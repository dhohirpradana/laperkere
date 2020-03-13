<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\User;
use Auth;

class ProfileController extends Controller
{
    public function show()
    {
        $id = Auth::user()->id;
        $user = User::where("id", $id)->get();

        return response()->json([
            // "data" => $user,
            "no_thl" => $user[0]['no_thl'],
            "name" => $user[0]['name'],
            "tmt_pengangkatan_pertama" => $user[0]['tmt_pengangkatan_pertama'],
            "tempat_lahir" => $user[0]['tempat_lahir'],
            "tanggal_lahir" => $user[0]['tanggal_lahir'],
            "tingkat_pendidikan_terakhir" => $user[0]['tingkat_pendidikan_terakhir'],
            "jurusan_pendidikan_terakhir" => $user[0]['jurusan_pendidikan_terakhir'],
            "jabatan" => $user[0]['jabatan'],
            "status_tenaga" => $user[0]['status_tenaga'],
            "unit_kerja" => $user[0]['unit_kerja'],
            "value" => 1,
        ]);
    }

}
