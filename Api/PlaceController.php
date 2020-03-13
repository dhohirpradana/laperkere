<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Place;
use Auth;

class PlaceController extends Controller
{
    public function show()
    {
        $places = Place::where("user_id", Auth::user()->id)->get();

        return response()->json([
            "value" => 1,
            "data" => $places,
            "message" => "data presensi berhasil",
        ]);
    }

    public function show_image($id)
    {
        $image = Place::where("id", $id)->first();
        if (empty($image)) {
            abort(404);
        }

        return response()->json([
            "value" => 1,
            "data" => $image,
            "message" => "data gambar berhasil",
        ]);
    }
}
