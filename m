Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:54365 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751956Ab2JaRCA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 31 Oct 2012 13:02:00 -0400
From: "Rose, Gregory V" <gregory.v.rose@intel.com>
To: Don Dutile <ddutile@redhat.com>,
	Ben Hutchings <bhutchings@solarflare.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"yuvalmin@broadcom.com" <yuvalmin@broadcom.com>,
	"yinghai@kernel.org" <yinghai@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>
Subject: RE: [PATCH 3/8] PCI: sysfs per device SRIOV control and status
Date: Wed, 31 Oct 2012 17:01:07 +0000
Message-ID: <C5551D9AAB213A418B7FD5E4A6F30A072D54CD4F@ORSMSX106.amr.corp.intel.com>
References: <1351190310-5043-1-git-send-email-ddutile@redhat.com>
  <1351190310-5043-4-git-send-email-ddutile@redhat.com>
 <1351196234.2662.37.camel@bwh-desktop.uk.solarflarecom.com>
 <508AA719.2060705@redhat.com>
In-Reply-To: <508AA719.2060705@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEb24gRHV0aWxlIFttYWlsdG86
ZGR1dGlsZUByZWRoYXQuY29tXQ0KPiBTZW50OiBGcmlkYXksIE9jdG9iZXIgMjYsIDIwMTIgODow
NyBBTQ0KPiBUbzogQmVuIEh1dGNoaW5ncw0KPiBDYzogbGludXgtcGNpQHZnZXIua2VybmVsLm9y
ZzsgYmhlbGdhYXNAZ29vZ2xlLmNvbTsgeXV2YWxtaW5AYnJvYWRjb20uY29tOw0KPiBSb3NlLCBH
cmVnb3J5IFY7IHlpbmdoYWlAa2VybmVsLm9yZzsgZGF2ZW1AZGF2ZW1sb2Z0Lm5ldA0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIDMvOF0gUENJOiBzeXNmcyBwZXIgZGV2aWNlIFNSSU9WIGNvbnRyb2wg
YW5kIHN0YXR1cw0KPiANCiANCj4gDQo+IE9rLCBteSB0dXJuOg0KPiBBbnkgZmVlZGJhY2sgb24g
aGF2aW5nIHRoZSBzeXNmcyBjb25maWd1cmUgY2FsbA0KPiBwY2lfc3Jpb3ZfW2VuYWJsZS9kaXNh
YmxlXSgpLCBhcyB3ZWxsIGFzIGRvIHRoZSBkb24ndC1kaXNhYmxlIGlmIFZGcyBhcmUNCj4gYXNz
aWduZWQgdG8gZ3Vlc3RzPw0KPiANCg0KRG9uLA0KDQpBcyBJJ3ZlIG1lbnRpb25lZCBiZWZvcmUg
SSBzdGlsbCBwcmVmZXIgdG8gaGF2ZSB0aGUgc3lzZnMgaW50ZXJmYWNlIHlvdSd2ZSB3cml0dGVu
IHVwIG1ha2UgdGhlIGNhbGxzIHRvIHBjaV9zcmlvdl9lbmFibGUvZGlzYWJsZSgpIGFuZCBoYXZl
IHRoZSBjaGVja2luZyBmb3Igd2hldGhlciB0aGUgVkZzIGFyZSBhc3NpZ25lZCB0byBndWVzdHMg
ZG9uZSB0aGVyZSBhbHNvLCBidXQgcmVhbGx5IGl0IGlzbid0IGFueXRoaW5nIHdvcnRoIGdvaW5n
IHRvIHRoZSBtYXRzIGFib3V0LiAgQXMgaXQgc3RhbmRzIEkgdGhpbmsgaWYgeW91IGFkZHJlc3Mg
dGhlIGlzc3VlcyBicm91Z2h0IHVwIGJ5IEJlbiB0aGVuIEknbSBmaW5lIHdpdGggd2hhdCB5b3Un
dmUgd29ya2VkIHVwIHNvIGZhci4gIFNpbmNlIG5vIG9uZSBlbHNlIHNlZW1zIHRvIGhhdmUgYW4g
b3BpbmlvbiBhYm91dCBpdCAoYXMgZGVtb25zdHJhdGVkIGJ5IGEgbGFjayBvZiByZXNwb25zZSBv
dmVyIHRoZSBsYXN0IDUgZGF5cykgdGhlbiBJJ2Qgc3VnZ2VzdCB3ZSBnbyBmb3J3YXJkIHdpdGgg
dGhlIGN1cnJlbnQgaW1wbGVtZW50YXRpb24uICBJJ2QgcmVhbGx5IGxpa2UgdG8gc2VlIHRoaXMg
aW4gMy44IGlmIHBvc3NpYmxlLg0KDQpUaGFua3MgZm9yIGFsbCB5b3VyIHdvcmsuDQoNCi0gR3Jl
Zw0K
