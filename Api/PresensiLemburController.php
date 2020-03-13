<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Jadwal;
use App\Place;
use Auth;
use DateTime;
use Illuminate\Http\Request;
use Illuminate\Support\Str;

class PresensiLemburController extends Controller
{
    public function store(Request $request)
    {
        /**
         * masih bug di hari libur
         */
        $lembur_mulai = Jadwal::where("nama_lain", date("l"))->pluck("lembur_mulai")->first();
        $lembur_selesai = Jadwal::where("nama_lain", date("l"))->pluck("lembur_selesai")->first();

        $current_time = date("H:i:s");
        $sunrise = $lembur_mulai;
        $sunset = $lembur_selesai;
        $date1 = DateTime::createFromFormat('H:i:s', $current_time);
        $date2 = DateTime::createFromFormat('H:i:s', $sunrise);
        $date3 = DateTime::createFromFormat('H:i:s', $sunset);

        if ($date1 > $date2 && $date1 < $date3) {
            /**
             * kode 0 untuk jam kerja asli
             * kode 1 untuk jam kerja lembur
             */
            $place = Place::where("user_id", Auth::user()->id)
                ->whereDay("time", date("d"))
                ->where("status", "=", 1)
                ->first();

            if (!empty($place)) {
                return response()->json([
                    "value" => 2,
                    "message" => "Presensi Sudah di masukkan",
                ]);
            } else {

                $this->validate($request, [
                    "image" => "required",
                    "latitude" => "required",
                    "longtitude" => "required",
                    "lokasi" => "required",
                ]);

                $file = $request->file("image");

                $ext = $file->getClientOriginalExtension();
                $name = Str::random(20) . time();

                $file->storeAs(
                    "public/presensi", $name . ".jpg"
                );

                $data = Place::create([
                    "image" => $name,
                    "latitude" => $request->latitude,
                    "longtitude" => $request->longtitude,
                    "time" => date("Y-m-d H:i:s"),
                    "lokasi" => $request->lokasi,
                    "status" => 1,
                    "user_id" => Auth::user()->id,
                ]);

                return response()->json([
                    "value" => 1,
                    "message" => "Berhasil mengisi Presensi hari ini",
                    "data" => $data,
                ]);
            }

        } else {
            return response()->json([
                "value" => 0,
                "message" => "jam kerja sudah selesai, jam kerja antara $sunrise sampai $sunset ",
            ]);
        }

    }
}
