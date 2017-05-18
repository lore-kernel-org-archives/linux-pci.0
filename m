Return-Path: <linux-kernel-owner@vger.kernel.org>
From: songxiaowei <songxiaowei@hisilicon.com>
To: Arnd Bergmann <arnd@arndb.de>
CC: Bjorn Helgaas <bhelgaas@google.com>, Kishon <kishon@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Tomasz Nowicki <tn@semihalf.com>,
        Keith Busch <keith.busch@intel.com>,
        "niklas.cassel@axis.com" <niklas.cassel@axis.com>,
        Duc Dang <dhdang@apm.com>,
        "liudongdong (C)" <liudongdong3@huawei.com>,
        "Chenfeng (puck)" <puck.chen@hisilicon.com>,
        Guodong Xu <guodong.xu@linaro.org>,
        Wangbinghui <wangbinghui@hisilicon.com>,
        Suzhuangluan <suzhuangluan@hisilicon.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0ggMS8yXSBQQ0k6IGR3Yzoga2lyaW46IGFkZCBQQ0ll?=
 =?utf-8?Q?_Driver_for_HiSilicon_Kirin_SoC?=
Date: Thu, 18 May 2017 01:50:09 +0000
Message-ID: <99B4C6BADD9E3241B25E52B02BA737C541161E84@DGGEMA505-MBS.china.huawei.com>
References: <20170512015105.32653-1-songxiaowei@hisilicon.com>
 <CAK8P3a0MFBW9NGN6oanH+x0YzbXznjUfk0B-pd_Fh-+8+5W3iA@mail.gmail.com>
In-Reply-To: <CAK8P3a0MFBW9NGN6oanH+x0YzbXznjUfk0B-pd_Fh-+8+5W3iA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

SGkgQXJuZCwNCg0KDQpPbiBGcmksIE1heSAxMiwgMjAxNyBhdCAzOjUxIEFNLCBTb25nIFhpYW93
ZWkgPHNvbmd4aWFvd2VpQGhpc2lsaWNvbi5jb20+IHdyb3RlOg0KPiBGcm9tOiBzb25neGlhb3dl
aSA8c29uZ3hpYW93ZWlAaGlzaWxpY29uLmNvbT4NCg0KTG9va3MgZ29vZCBvdmVyYWxsLCBqdXN0
IGEgZmV3IGRldGFpbHM6DQoNClBsZWFzZSBmaXggeW91ciB+Ly5naXRjb25maWcgdG8gY29udGFp
biB0aGUgc2FtZSByZWFsIG5hbWUgKCJTb25nIFhpYW93ZWkiDQppbnN0ZWFkIG9mICJzb25neGlh
b3dlaSIpIHRoYXQgeW91IHVzZSBmb3Igc2VuZGluZyB0aGUgZW1haWxzLg0KDQpbWGlhb3dlaSBT
b25nXSAgSSdsbCBmaXggdGhpcyBpc3N1ZSBhbmQgdXBkYXRlIHRoZSBwYXRjaC4NCg0KPiArDQo+
ICtzdGF0aWMgaW50IGtpcmluX3BjaWVfcGh5X2luaXQoc3RydWN0IGtpcmluX3BjaWUgKmtpcmlu
X3BjaWUpIHsNCi4uLg0KPiArICAgICAgIHJlZ192YWwgPSBraXJpbl9hcGJfcGh5X3JlYWRsKGtp
cmluX3BjaWUsIDB4NDAwKTsNCj4gKyAgICAgICB3aGlsZSAocmVnX3ZhbCAmIHBpcGVfY2xrX3N0
YWJsZSkgew0KPiArICAgICAgICAgICAgICAgdWRlbGF5KDEwMCk7DQo+ICsgICAgICAgICAgICAg
ICBpZiAodGltZSA9PSAwKSB7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIGRldl9lcnIoa2ly
aW5fcGNpZS0+cGNpLT5kZXYsICJQSVBFIGNsayBpcyBub3Qgc3RhYmxlXG4iKTsNCj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ICsgICAgICAgICAgICAgICB9DQo+
ICsgICAgICAgICAgICAgICB0aW1lLS07DQo+ICsgICAgICAgICAgICAgICByZWdfdmFsID0ga2ly
aW5fYXBiX3BoeV9yZWFkbChraXJpbl9wY2llLCAweDQwMCk7DQo+ICsgICAgICAgfQ0KDQpJZiB0
aGlzIGlzIG5vdCBjYWxsZWQgd2l0aCBpbnRlcnJ1cHRzIGRpc2FibGVkLCBwbGVhc2UgdXNlIGEg
c2xlZXBpbmcgZnVuY3Rpb24gKGUuZy4gbXNsZWVwKDEpKSBhcyB0aGUgZGVsYXkgYW5kIGNvbXBh
cmUgYWdhaW5zdCBrdGltZV9iZWZvcmUoKSB0byBzZWUgaG93IG11Y2ggdG90YWwgdGltZSBoYXMg
ZXhwaXJlZCB3aGVuIHdhaXRpbmcgZm9yIGEgdGltZW91dCwgaW5zdGVhZCBvZiB1c2luZyBhIGNv
dW50ZXIuDQoNCltYaWFvd2VpIFNvbmddIFRoaXMgaXNzdWUgd2FzIGZpeGVkIGluIHRoZSBwYXRj
aCBzZW50IGF0IDIwMTctNS0xNSwgYW5kIEknbGwgc2VuZCBpdCBhZ2Fpbi4NCg0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9wY2kvZHdjL3BjaWUta2lyaW4uaCANCj4gYi9kcml2ZXJzL3BjaS9kd2Mv
cGNpZS1raXJpbi5oIG5ldyBmaWxlIG1vZGUgMTAwNjQ0IGluZGV4IA0KPiAwMDAwMDAwMDAwMDAu
LmFkOWEzYjQyNzI5OA0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBiL2RyaXZlcnMvcGNpL2R3Yy9w
Y2llLWtpcmluLmgNCj4gQEAgLTAsMCArMSw3OSBAQA0KPiArLyoNCj4gKyAqIFBDSWUgaG9zdCBj
b250cm9sbGVyIGRyaXZlciBmb3IgS2lyaW4gOTYwIFNvQ3MNCj4gKyAqDQo+ICsgKiBDb3B5cmln
aHQgKEMpIDIwMTUgSHVhd2VpIEVsZWN0cm9uaWNzIENvLiwgTHRkLg0KPiArICogICAgICAgICAg
ICAgaHR0cDovL3d3dy5odWF3ZWkuY29tDQo+ICsgKg0KPiArICogQXV0aG9yOiBYaWFvd2VpIFNv
bmcgPHNvbmd4aWFvd2VpQGh1YXdlaS5jb20+DQoNClRoZSBoZWFkZXIgaXMgb25seSB1c2VkIGlu
IG9uZSAuYyBmaWxlLCBzbyBqdXN0IHJlbW92ZSBpdCBhbmQgYWRkIHRoZSBjb250ZW50cyB0byB0
aGF0IGZpbGUuDQoNCltzb25neGlhb3dlaV0gSW4gbmV3IHBhdGNoIHRoZSBoZWFkZXIgZmlsZSB3
YXMgZGVsZXRlZCwNCg0KDQpUaGFua3MgYSBsb3QuDQoNCkJlc3QgcmVnYXJkLA0KWGlhb3dlaS4N
Cg==
