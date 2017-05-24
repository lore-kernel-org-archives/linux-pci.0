Return-Path: <SRS0=Kgy0=46=hisilicon.com=songxiaowei@kernel.org>
Return-Path: <SRS0=Kgy0=46=hisilicon.com=songxiaowei@kernel.org>
From: songxiaowei <songxiaowei@hisilicon.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>,
        "kishon@ti.com"
	<kishon@ti.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "tn@semihalf.com" <tn@semihalf.com>,
        "keith.busch@intel.com" <keith.busch@intel.com>,
        "niklas.cassel@axis.com"
	<niklas.cassel@axis.com>,
        "dhdang@apm.com" <dhdang@apm.com>,
        "liudongdong
 (C)" <liudongdong3@huawei.com>,
        "Chenfeng (puck)" <puck.chen@hisilicon.com>,
        "guodong.xu@linaro.org" <guodong.xu@linaro.org>,
        Wangbinghui
	<wangbinghui@hisilicon.com>,
        Suzhuangluan <suzhuangluan@hisilicon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "chenyao (F)"
	<chenyao11@huawei.com>
Subject: =?gb2312?B?tPC4tDogW1BBVENIIHY0IDIvM10gUENJOiBkd2M6IGtpcmluOiBhZGQgUENJ?=
 =?gb2312?Q?e_Driver_for_HiSilicon_Kirin_SoC?=
Date: Wed, 24 May 2017 01:43:37 +0000
Message-ID: <99B4C6BADD9E3241B25E52B02BA737C54116D374@DGGEMA505-MBX.china.huawei.com>
References: <20170518091640.36704-1-songxiaowei@hisilicon.com>
 <20170523213032.GD15055@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20170523213032.GD15055@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="gb2312"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

DQoNCi0tLS0t08q8/tStvP4tLS0tLQ0Kt6K8/sjLOiBCam9ybiBIZWxnYWFzIFttYWlsdG86aGVs
Z2Fhc0BrZXJuZWwub3JnXSANCreiy83KsbzkOiAyMDE3xOo11MIyNMjVIDU6MzENCsrVvP7Iyzog
c29uZ3hpYW93ZWkNCrOty806IGJoZWxnYWFzQGdvb2dsZS5jb207IGtpc2hvbkB0aS5jb207IGpp
bmdvb2hhbjFAZ21haWwuY29tOyBhcm5kQGFybmRiLmRlOyB0bkBzZW1paGFsZi5jb207IGtlaXRo
LmJ1c2NoQGludGVsLmNvbTsgbmlrbGFzLmNhc3NlbEBheGlzLmNvbTsgZGhkYW5nQGFwbS5jb207
IGxpdWRvbmdkb25nIChDKTsgQ2hlbmZlbmcgKHB1Y2spOyBndW9kb25nLnh1QGxpbmFyby5vcmc7
IFdhbmdiaW5naHVpOyBTdXpodWFuZ2x1YW47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7IGNoZW55YW8gKEYpDQrW98ziOiBSZTogW1BBVENI
IHY0IDIvM10gUENJOiBkd2M6IGtpcmluOiBhZGQgUENJZSBEcml2ZXIgZm9yIEhpU2lsaWNvbiBL
aXJpbiBTb0MNCg0KSGksDQoNCldoZW4geW91IHJlcG9zdCB0aGlzLCB3b3VsZCB5b3UgbWluZCBw
b3N0aW5nIHRoZSB2NCBhcyBhIGNvbXBsZXRlIHNlcGFyYXRlIHRocmVhZCB3aXRoIGEgY292ZXIg
bGV0dGVyLCBpLmUuLA0KDQogIFt2NCAwLzNdIGNvdmVyDQogICAgW3Y0IDEvM10gYXJtNjQ6IGR0
czogaGkzNjYwOiBhZGQgcGNpZSBub2RlDQogICAgW3Y0IDIvM10gUENJOiBkd2M6IGtpcmluOiBh
ZGQgUENJZSBEcml2ZXIgZm9yIEhpU2lsaWNvbiBLaXJpbiBTb0MNCiAgICBbdjQgMy8zXSBkZWZj
b25maWc6IFBDSTogRW5hYmxlIEtpcmluIFBDSWUgZGVmY29uZmlnDQoNClRoYXQgbWFrZXMgaXQg
bXVjaCBlYXNpZXIgdG8gcHVsbCB0aGUgcGF0Y2hlcyBvdXQgb2YgZW1haWwuDQpbc29uZ3hpYW93
ZWldIE9rLCB0aGlzIGlzc3VlIHdpbGwgYmUgZml4ZWQuDQoNCk9uIFRodSwgTWF5IDE4LCAyMDE3
IGF0IDA1OjE2OjQwUE0gKzA4MDAsIFNvbmcgWGlhb3dlaSB3cm90ZToNCj4gKy8qIGluZm8gbGFj
YXRlZCBpbiBzeXNjdHJsICovDQoNCnMvbGFjYXRlZC9sb2NhdGVkLw0KDQo+ICsvKnBlcmlfY3Jn
IGN0cmwqLw0KDQpBZGQgc3BhY2VzIGFmdGVyICIvKiIgYW5kIGJlZm9yZSAiKi8iIChhbHNvIGZp
eCBvdGhlciBvY2N1cnJlbmNlcyBiZWxvdykuDQoNCltzb25neGlhb3dlaV0gb2suDQoNCj4gK3N0
YXRpYyBpbnQgX19pbml0IGtpcmluX2FkZF9wY2llX3BvcnQoc3RydWN0IGR3X3BjaWUgKnBjaSwN
Cj4gKwkJCXN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICt7DQo+ICsJaW50IHJldDsN
Cj4gKw0KPiArCXBjaS0+cHAub3BzID0gJmtpcmluX3BjaWVfaG9zdF9vcHM7DQo+ICsNCj4gKwly
ZXQgPSBkd19wY2llX2hvc3RfaW5pdCgmcGNpLT5wcCk7DQo+ICsNCj4gKwlyZXR1cm4gcmV0Ow0K
DQogIHJldHVybiBkd19wY2llX2hvc3RfaW5pdCgmcGNpLT5wcCk7DQoNCmFuZCBnZXQgcmlkIG9m
ICJyZXQiIGFsdG9nZXRoZXIuDQpbc29uZ3hpYW93ZWldIE9rLCBJIHdpbGwgZml4IGl0Lg0KDQo+
ICt9DQoNCj4gKwlyZXQgPSBraXJpbl9hZGRfcGNpZV9wb3J0KHBjaSwgcGRldik7DQo+ICsJaWYg
KHJldCkNCj4gKwkJcmV0dXJuIHJldDsNCj4gKw0KPiArCXJldHVybiAwOw0KDQoNCiAgcmV0dXJu
IGtpcmluX2FkZF9wY2llX3BvcnQocGNpLCBwZGV2KTsNCltzb25neGlhb3dlaV0gT2ssIEkgd2ls
bCBmaXggaXQuDQoNCj4gK30NCg0KVGhhbmtzIGZvciB5b3VyIHRpbWUuDQoNCkJlc3Qgd2lzaGVz
LA0KWGlhby13ZWkuDQoNCg==
