Return-Path: <linux-acpi-owner@vger.kernel.org>
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
Date: Fri, 14 Jun 2013 22:27:34 +0000
Message-ID: <1371248853.2490.5.camel@x230>
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
In-Reply-To: <CAE9FiQWxDhagFNAYc2eNDe_1jYtVTa5Azg0zifiprND5m3CmMw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

T24gRnJpLCAyMDEzLTA2LTE0IGF0IDE1OjE3IC0wNzAwLCBZaW5naGFpIEx1IHdyb3RlOg0KDQo+
IGFmdGVyIHRob3NlIHR3byBwYXRjaGVzLCBpdCBhc3BtX2Rpc2FibGVkIGlzIHNldCwgdmlhIF9v
c2MgZWFybHksDQo+IHByZS0xLjEgZGV2aWNlcyBhc3BtIHJlZ2lzdGVyIHdpbGwgYmUgdG91Y2hl
ZCBldmVuIGFzcG1fZm9yY2UgaXMgbm90IHNwZWNpZmllZC4NCg0KSSBkb24ndCBmb2xsb3cuIFdl
IHdlcmUgcHJldmlvdXNseSBhdXRvbWF0aWNhbGx5IGRpc2FibGluZyBBU1BNIG9uDQpwcmUtMS4x
IGRldmljZXMgZXZlbiBpZiBfT1NDIGRpZG4ndCBnaXZlIHVzIGNvbnRyb2wuIEkndmUgY29uZmly
bWVkIHRoYXQNCnRoaXMgd2FzIHRoZSB3cm9uZyB0aGluZyBmb3IgdXMgdG8gYmUgZG9pbmcsIGFu
ZCBteSBwYXRjaCBjaGFuZ2VkIHRoZQ0KYmVoYXZpb3VyIHN1Y2ggdGhhdCBpZiB0aGUgZmlybXdh
cmUgZW5hYmxlcyBBU1BNIG9uIGEgcHJlLTEuMSBkZXZpY2UgYW5kDQpyZWZ1c2VzIHRvIGdpdmUg
dXMgY29udHJvbCB2aWEgX09TQyB3ZSB3aWxsIGxlYXZlIEFTUE0gZW5hYmxlZC4NCg0KLS0gDQpN
YXR0aGV3IEdhcnJldHQgfCBtamc1OUBzcmNmLnVjYW0ub3JnDQo=
