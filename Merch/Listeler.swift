//
//  Listeler.swift
//  Merch
//
//  Created by Burak Erdem on 2.10.2017.
//  Copyright © 2017 Burak Erdem. All rights reserved.
//
let sampleStoreData:[[String: String]] = [["storeName": "5M Umraniye Meydan AVM", "staringTime":"09:00","endingTime":"12:00"],
                                          ["storeName": "Çekmeköy Eltes MMM Migros", "staringTime":"13:00","endingTime":"14:30"],
                                          ["storeName": "Paradise Migros", "staringTime":"15:00","endingTime":"17:00"]]

let activeDsaData: [[String:String]] = [["urunAdi": "Ülker Petibör 1000 GR",    "type":"Sepet",             "anlasma": "Anlaşması Yok"],
                                        ["urunAdi": "Ülker Metro",              "type":"Asalak",            "anlasma": "Anlaşması Var"],
                                        ["urunAdi": "Ülker Çikolatalı Gofret",  "type":"Kasa Önü",          "anlasma": "Anlaşması Yok"]]

let deactiveDsaData: [[String:String]] = [["urunAdi": "Ülker Herobaby Bisküvi 400 GR",    "type":"Sepet",             "anlasmaTarih": "21.09.2017-04.10.2017"],
                                          ["urunAdi": "Ülker Çokonat 5'li",              "type":"Asalak",            "anlasmaTarih": "01.10.2017-18.10.2017"],
                                          ["urunAdi": "Ülker Biskrem",  "type":"Kasa Önü",          "anlasmaTarih": "04.10.2017-31.10.2017"]]


let urunler: [[String:String]] = [["urunAdi": "Ülker Petibör 1000 GR",              "barcode":"1234567890123"],
                                  ["urunAdi": "Ülker Metro",                        "barcode":"1234567890123"],
                                  ["urunAdi": "Ülker Çikolatalı Gofret",            "barcode":"1234567890123"],
                                  ["urunAdi": "Ülker Herobaby Bisküvi 400 GR",      "barcode":"1234567890123"],
                                  ["urunAdi": "Ülker Çokonat 5'li",                 "barcode":"1234567890123"],
                                  ["urunAdi": "Ülker Biskrem",                      "barcode":"1234567890123"]]

let tehsirTipleri: [[String:String]] = [["type":"Alle Centrale"],
                                       ["type":"Palet"],
                                       ["type":"Podyum"],
                                       ["type":"Gondol Başı"],
                                       ["type":"Atlas Sepet"],
                                       ["type":"Sepet"],
                                       ["type":"Yanak"],
                                       ["type":"Asalak"]]
