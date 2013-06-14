Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1lp0155.outbound.protection.outlook.com ([207.46.163.155]:30864
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753689Ab3FNWsS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 14 Jun 2013 18:48:18 -0400
From: Matthew Garrett <matthew.garrett@nebula.com>
To: Yinghai Lu <yinghai@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Roman Yepishev <roman.yepishev@gmail.com>,
	Jiang Liu <jiang.liu@huawei.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Maxim Levitsky <maximlevitsky@gmail.com>,
	Jussi Kivilinna <jussi.kivilinna@iki.fi>
Subject: Re: [PATCH] PCI: Remove not needed check in disable aspm link
Date: Fri, 14 Jun 2013 22:48:13 +0000
Message-ID: <1371250092.2490.7.camel@x230>
References: <CAE9FiQVu5QyxaKsYzzQoroQD=TvsziHzDOtoeg=FvhZ8HyN5yw@mail.gmail.com>
	 <CAErSpo7ChfRiEn0eR1rf-mVheUS9Yf8f+j4n78PJcGYh+yMVgA@mail.gmail.com>
	 <CAE9FiQXkDg7Y336S=DXoms44=5HLaiUx=sWviupz1fJmaDUEzQ@mail.gmail.com>
	 <CAE9FiQU5c=ztzbskNnYFFKF9V5zO+jnRcMBCivLxA1F3fSfX5w@mail.gmail.com>
	 <20130401235256.GA31966@google.com>
	 <CAE9FiQV8cPh-s6=EQu_cZTtn86+NwZE5KuGMhf43aOhzkL=hwA@mail.gmail.com>
	 <CAErSpo7Jni1ZSf_W=vB3kqsucPpoepa2Q5g=77a6D3FaPwe9LA@mail.gmail.com>
	 <CAE9FiQWjQXwiTWju6cBc_o25jy_wmZ1u+Pifh1wdnxtV=i5ENw@mail.gmail.com>
	 <CAErSpo7=a-wX6BLbm_O1nUMMrQHOgtSm3xZHKuRqaz8rnKSbRA@mail.gmail.com>
	 <CAE9FiQUbw7OUhRB+gKMxkuE9+nm9097+mwZ2z4adO8Hv_NjF1Q@mail.gmail.com>
	 <20130614141101.GA29452@google.com>
	 <CAE9FiQVr-OWeqEHFXn0MjNiSD0WM=FNO_DFo6m9UbbG60uonpw@mail.gmail.com>
	 <CAErSpo7grN-93zZfBJOHZH-pR1wDYrojTwt=B=++QqA0rPb3Rg@mail.gmail.com>
	 <CAE9FiQUO350kqrXB5=yQ-OxOeSJj4+P6WPg4gGgXxFEvfoLyng@mail.gmail.com>
	 <CAErSpo6vEOw10YV=Sou6wjjSc2GWr-oX=Dvbt7Xt=RJKi4RELw@mail.gmail.com>
	 <CAE9FiQWevd6ZNDdqGkqbLrGujKYuTiwibPAT+30VPpC_H-rLJA@mail.gmail.com>
	 <CAErSpo66qtgg8=BqX+4sm4h1vXD5gR6aiH7hHK7gvz1x3rEQZA@mail.gmail.com>
	 <CAE9FiQWxDhagFNAYc2eNDe_1jYtVTa5Azg0zifiprND5m3CmMw@mail.gmail.com>
	 <1371248853.2490.5.camel@x230>
	 <CAE9FiQWPvOYK2W0VSRuMyfj9Edbw1BSp-W91HjPyszPK0ZBcjg@mail.gmail.com>
In-Reply-To: <CAE9FiQWPvOYK2W0VSRuMyfj9Edbw1BSp-W91HjPyszPK0ZBcjg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

T24gRnJpLCAyMDEzLTA2LTE0IGF0IDE1OjQwIC0wNzAwLCBZaW5naGFpIEx1IHdyb3RlOg0KPiBP
biBGcmksIEp1biAxNCwgMjAxMyBhdCAzOjI3IFBNLCBNYXR0aGV3IEdhcnJldHQNCj4gPG1hdHRo
ZXcuZ2FycmV0dEBuZWJ1bGEuY29tPiB3cm90ZToNCj4gPiBPbiBGcmksIDIwMTMtMDYtMTQgYXQg
MTU6MTcgLTA3MDAsIFlpbmdoYWkgTHUgd3JvdGU6DQo+ID4NCj4gPj4gYWZ0ZXIgdGhvc2UgdHdv
IHBhdGNoZXMsIGl0IGFzcG1fZGlzYWJsZWQgaXMgc2V0LCB2aWEgX29zYyBlYXJseSwNCj4gPj4g
cHJlLTEuMSBkZXZpY2VzIGFzcG0gcmVnaXN0ZXIgd2lsbCBiZSB0b3VjaGVkIGV2ZW4gYXNwbV9m
b3JjZSBpcyBub3Qgc3BlY2lmaWVkLg0KPiA+DQo+ID4gSSBkb24ndCBmb2xsb3cuIFdlIHdlcmUg
cHJldmlvdXNseSBhdXRvbWF0aWNhbGx5IGRpc2FibGluZyBBU1BNIG9uDQo+ID4gcHJlLTEuMSBk
ZXZpY2VzIGV2ZW4gaWYgX09TQyBkaWRuJ3QgZ2l2ZSB1cyBjb250cm9sLg0KPiANCj4gSSBkb24n
dCB0aGluayBzbywgd2UganVzdCBtb3ZlZCBfT1NDIHN1cHBvcnQvY29udHJvbCBzZXR0aW5nIGJl
Zm9yZSBwY2kgc2Nhbg0KPiBpbiAzLjggYW5kIHJldmVydCB0aGF0IGluIHYzLjkuDQoNClJpZ2h0
LCBzb3JyeSwgSSBkb24ndCBtZWFuIF9PU0MsIEkgbWVhbiB0aGUgRkFEVCBmbGFnLiBXZSB3ZXJl
DQpwcmV2aW91c2x5IGF1dG9tYXRpY2FsbHkgZGlzYWJsaW5nIEFTUE0gb24gcHJlLTEuMSBkZXZp
Y2VzIGV2ZW4gaWYgdGhlDQpGQURUIGZsYWcgd2FzIHNldC4NCg0KLS0gDQpNYXR0aGV3IEdhcnJl
dHQgfCBtamc1OUBzcmNmLnVjYW0ub3JnDQo=
