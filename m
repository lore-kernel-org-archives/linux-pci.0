Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([45.249.212.187]:7269 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1946554AbdEZBlL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 May 2017 21:41:11 -0400
From: songxiaowei <songxiaowei@hisilicon.com>
To: Rob Herring <robh@kernel.org>
CC: "Wangzhou (B)" <wangzhou1@hisilicon.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "xuwei (O)" <xuwei5@hisilicon.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chenfeng (puck)" <puck.chen@hisilicon.com>,
        "guodong.xu@linaro.org" <guodong.xu@linaro.org>,
        Wangbinghui <wangbinghui@hisilicon.com>,
        Suzhuangluan <suzhuangluan@hisilicon.com>
Subject: =?utf-8?B?562U5aSNOiDnrZTlpI06IFtQYXRjaCB2MyAxLzNdIGFybTY0OiBkdHM6IGhp?=
 =?utf-8?Q?3660:_add_pcie_node?=
Date: Fri, 26 May 2017 01:40:45 +0000
Message-ID: <99B4C6BADD9E3241B25E52B02BA737C54116D871@DGGEMA505-MBX.china.huawei.com>
References: <20170518074946.21362-1-songxiaowei@hisilicon.com>
 <20170523141641.kbb4falhs574dfpu@rob-hp-laptop>
 <99B4C6BADD9E3241B25E52B02BA737C54116D35D@DGGEMA505-MBX.china.huawei.com>
 <CAL_JsqJV5TA2ADo35tqGXC61NWK9PDqw8Dq5m5fYHg59yaoEUA@mail.gmail.com>
In-Reply-To: <CAL_JsqJV5TA2ADo35tqGXC61NWK9PDqw8Dq5m5fYHg59yaoEUA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

DQoNCi0tLS0t6YKu5Lu25Y6f5Lu2LS0tLS0NCuWPkeS7tuS6ujogUm9iIEhlcnJpbmcgW21haWx0
bzpyb2JoQGtlcm5lbC5vcmddIA0K5Y+R6YCB5pe26Ze0OiAyMDE35bm0NeaciDI15pelIDIwOjM5
DQrmlLbku7bkuro6IHNvbmd4aWFvd2VpDQrmioTpgIE6IFdhbmd6aG91IChCKTsgR2FicmllbGUg
UGFvbG9uaTsgYmhlbGdhYXNAZ29vZ2xlLmNvbTsgbWFyay5ydXRsYW5kQGFybS5jb207IHh1d2Vp
IChPKTsgY2F0YWxpbi5tYXJpbmFzQGFybS5jb207IHdpbGwuZGVhY29uQGFybS5jb207IGxpbnV4
LXBjaUB2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnOyBDaGVuZmVuZyAocHVjayk7IGd1b2RvbmcueHVAbGluYXJv
Lm9yZzsgV2FuZ2JpbmdodWk7IFN1emh1YW5nbHVhbg0K5Li76aKYOiBSZTog562U5aSNOiBbUGF0
Y2ggdjMgMS8zXSBhcm02NDogZHRzOiBoaTM2NjA6IGFkZCBwY2llIG5vZGUNCg0KT24gVHVlLCBN
YXkgMjMsIDIwMTcgYXQgODozOSBQTSwgc29uZ3hpYW93ZWkgPHNvbmd4aWFvd2VpQGhpc2lsaWNv
bi5jb20+IHdyb3RlOg0KPiAtLS0tLemCruS7tuWOn+S7ti0tLS0tDQo+IOWPkeS7tuS6ujogUm9i
IEhlcnJpbmcgW21haWx0bzpyb2JoQGtlcm5lbC5vcmddDQo+IOWPkemAgeaXtumXtDogMjAxN+W5
tDXmnIgyM+aXpSAyMjoxNw0KPiDmlLbku7bkuro6IHNvbmd4aWFvd2VpDQo+IOaKhOmAgTogV2Fu
Z3pob3UgKEIpOyBHYWJyaWVsZSBQYW9sb25pOyBiaGVsZ2Fhc0Bnb29nbGUuY29tOyBtYXJrLnJ1
dGxhbmRAYXJtLmNvbTsgeHV3ZWkgKE8pOyBjYXRhbGluLm1hcmluYXNAYXJtLmNvbTsgd2lsbC5k
ZWFjb25AYXJtLmNvbTsgbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2Vy
Lmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IENoZW5mZW5nIChwdWNr
KTsgZ3VvZG9uZy54dUBsaW5hcm8ub3JnOyBXYW5nYmluZ2h1aTsgU3V6aHVhbmdsdWFuDQo+IOS4
u+mimDogUmU6IFtQYXRjaCB2MyAxLzNdIGFybTY0OiBkdHM6IGhpMzY2MDogYWRkIHBjaWUgbm9k
ZQ0KPg0KPiBPbiBUaHUsIE1heSAxOCwgMjAxNyBhdCAwMzo0OTo0NlBNICswODAwLCBTb25nIFhp
YW93ZWkgd3JvdGU6DQo+PiBBZGQgUENJZSBub2RlIGZvciBoaTM2NjAsIGFuZCBhZGQgYmluZGlu
ZyBkb2N1bWVudGF0aW9uLg0KPj4NCj4+IENjOiBHdW9kb25nIFh1IDxndW9kb25nLnh1QGxpbmFy
by5vcmc+DQo+PiBTaWduZWQtb2ZmLWJ5OiBTb25nIFhpYW93ZWkgPHNvbmd4aWFvd2VpQGhpc2ls
aWNvbi5jb20+DQo+PiAtLS0NCj4+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvaGlzaWxp
Y29uLXBjaWUudHh0ICAgICB8IDUyICsrKysrKysrKysrKysrKysrKysrKysNCj4+ICBhcmNoL2Fy
bTY0L2Jvb3QvZHRzL2hpc2lsaWNvbi9oaTM2NjAuZHRzaSAgICAgICAgICB8IDMxICsrKysrKysr
KysrKysNCg0KWy4uLl0NCg0KPj4gKyAgImNvbmZpZyI6IFBDSWUgY29uZmlndXJhdGlvbiBzcGFj
ZSByZWdpc3RlcnMuDQo+PiArLSByZXNldC1ncGlvOiBwZXJzdCBhc3NlcnQvZGVhc3NlcnQgZ3Bp
bw0KPg0KPiByZXNldC1ncGlvcw0KPiBbc29uZ3hpYW93ZWldIHJlc3QtZ3BpbyBpcyB1c2VkIHRv
IHNpZ25hbCAncGNpZSBwZXJzdCc6IGhpZ2ggbGV2ZWwgcmVmZXJzIHRvIGRlYXNzZXJ0DQo+ICAg
ICAgICAgICAgICBhbmQgbG93IGxldmVsIHJlZmVycyB0byBhc3NlcnQuIFNvLCBJIHRoaW5rICcg
cmVzZXQtZ3BpbzogY3JlYXRlcyBwZXJzdCBhc3NlcnQvZGVhc3NlcnQgc2lnbmFsICcNCj4gICAg
ICAgICAgICAgICAgICAgICAgICAgd291bGQgYmUgYSBiZXR0ZXIgY2hvaWNlLg0KDQpXaGF0IEkg
d2FzIHNheWluZyBpcyB0aGUgbmFtZSBzaG91bGQgYmUgcmVzZXQtZ3Bpb3MsIG5vdCByZXNldC1n
cGlvLg0KDQpbc29uZ3hpYW93ZWldIE9rLCBJJ2xsIGZpeCBpdC4gSW4gZmFjdCwgcGVyc3Qgc2ln
bmFsIG9ubHkgdXNlIG9uZSBsaW5lLCBzbyByZXNldC1ncGlvcyBjb250YWlucyBvbmx5IG9uZSBn
cGlvLg0KUm9iDQo=
