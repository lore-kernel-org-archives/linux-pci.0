Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Luck, Tony" <tony.luck@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Alex Williamson <alex.williamson@redhat.com>,
	Jiang Liu <jiang.liu@linux.intel.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"bp@alien8.de" <bp@alien8.de>, "Zheng, Lv" <lv.zheng@intel.com>,
	"hpa@zytor.com" <hpa@zytor.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"yinghai@kernel.org" <yinghai@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] x86/PCI: Fully disable devices before releasing IRQ
 resource
Date: Wed, 11 Mar 2015 22:04:42 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F32A0E2E2@ORSMSX113.amr.corp.intel.com>
References: <20150305210529.6393.29546.stgit@gimli.home>
 <1425613912.5200.344.camel@redhat.com> <1426092450.3643.7.camel@redhat.com>
 <2139068.CEUJTvBkYG@vostro.rjw.lan>
In-Reply-To: <2139068.CEUJTvBkYG@vostro.rjw.lan>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Pj4gVW5mb3J0dW5hdGVseSB0aGVyZSdzIGEgbG9uZyBzdGFuZGluZyBjb21tZW50IGluIHBjaV9k
ZXZpY2VfcmVtb3ZlKCk6DQo+PiANCj4+ICAgICAgICAgLyoNCj4+ICAgICAgICAgICogV2Ugd291
bGQgbG92ZSB0byBjb21wbGFpbiBoZXJlIGlmIHBjaV9kZXYtPmlzX2VuYWJsZWQgaXMgc2V0LCB0
aGF0DQo+PiAgICAgICAgICAqIHRoZSBkcml2ZXIgc2hvdWxkIGhhdmUgY2FsbGVkIHBjaV9kaXNh
YmxlX2RldmljZSgpLCBidXQgdGhlDQo+PiAgICAgICAgICAqIHVuZm9ydHVuYXRlIGZhY3QgaXMg
dGhlcmUgYXJlIHRvbyBtYW55IG9kZCBCSU9TIGFuZCBicmlkZ2Ugc2V0dXBzDQo+PiAgICAgICAg
ICAqIHRoYXQgZG9uJ3QgbGlrZSBkcml2ZXJzIGRvaW5nIHRoYXQgYWxsIG9mIHRoZSB0aW1lLg0K
Pj4gICAgICAgICAgKiBPaCB3ZWxsLCB3ZSBjYW4gZHJlYW0gb2Ygc2FuZSBoYXJkd2FyZSB3aGVu
IHdlIHNsZWVwLCBubyBtYXR0ZXIgaG93DQo+PiAgICAgICAgICAqIGhvcnJpYmxlIHRoZSBjcmFw
IHdlIGhhdmUgdG8gZGVhbCB3aXRoIGlzIHdoZW4gd2UgYXJlIGF3YWtlLi4uDQo+PiAgICAgICAg
ICAqLw0KPj4gDQo+PiBTbywgdW5sZXNzIHdlIGNhbiBzb21laG93IGlnbm9yZSB0aGF0IGNvbW1l
bnQsIEkgc3VzcGVjdCBmb3JjaW5nIHRoZQ0KPj4gZGV2aWNlIHRvIGJlIGRpc2FibGVkIG9uIGRy
aXZlciByZW1vdmUsIHdoZXRoZXIgZG9uZSBmcm9tIHBjaS1jb3JlIG9yDQo+PiBmcm9tIHg4Ni9w
Y2ksIGlzIGdvaW5nIHRvIGNhdXNlIGFsbCBzb3J0cyBvZiBicmVha2FnZS4gIEFyZSB0aGUNCj4+
IGV4cGVjdGF0aW9ucyBzZXQgYnkgYjRiNTVjZGE1ODc0IHJlYWxseSB2YWxpZD8gIEl0IHNlZW1z
IGxpa2Ugc29tZXRoaW5nDQo+PiBuZWVkcyB0byBiZSBkb25lIHRvIGFsbG93IHRoZSBJUlEgdG8g
YmUgYXV0b21hdGljYWxseSByZS1lc3RhYmxpc2hlZCBvbg0KPj4geDg2IHJlZ2FyZGxlc3Mgb2Yg
dGhlIGRyaXZlciBkb2luZyB0aGUgcmlnaHQgdGhpbmcgd2hlbiByZWxlYXNpbmcgdGhlDQo+PiBk
ZXZpY2UuICBXZSdyZSBzdGlsbCBsb29raW5nIGF0IGEgcmVncmVzc2lvbiBmb3IgdjQuMCBhcyBh
IHJlc3VsdCBvZg0KPj4gYjRiNTVjZGE1ODc0Lg0KPg0KPiBJbiB3aGljaCBjYXNlIHdlIHByb2Jh
Ymx5IHNob3VsZCByZXZlcnQgY29tbWl0IGI0YjU1Y2RhNTg3NCBmb3IgdGhlIHRpbWUgYmVpbmcu
DQo+DQo+IEF0IGxlYXN0IEknZCBiZSB2ZXJ5IG5lcnZvdXMgYWJvdXQgYW55IGFkLWhvYyBmaXhl
cyBhdCB0aGlzIHN0YWdlIG9mIHRoZSBjeWNsZS4NCg0KVGhlIGNvbW1lbnQgZ29lcyBiYWNrIHRv
IHRoZSBkYXduIG9mICJnaXQiIHRpbWUgLi4uIG5vdCBzdXJlIGhvdyBtdWNoIGZ1cnRoZXINCmJh
Y2suDQoNCklzIHRoaXMgYWN0dWFsbHkgc3RpbGwgYW4gaXNzdWUgb24gbW9kZXJuIHN5c3RlbXM/
ICBNYXliZSB3ZSBuZWVkIGEgYmxhY2sgbGlzdA0Kb3Igd2hpdGUgbGlzdCB0byBzZXBhcmF0ZSB0
aGUgZ29vZCBmcm9tIGJhZCBzeXN0ZW1zPw0KDQotVG9ueQ0K
