Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1on0116.outbound.protection.outlook.com ([157.56.110.116]:62528
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754935AbbFLPLQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 12 Jun 2015 11:11:16 -0400
From: Jake Oshins <jakeo@microsoft.com>
To: Paul Bolle <pebolle@tiscali.nl>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	KY Srinivasan <kys@microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
	"olaf@aepfle.de" <olaf@aepfle.de>,
	"apw@canonical.com" <apw@canonical.com>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	Mike Ebersol <Michael.Ebersol@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>
Subject: RE: [PATCH 6/6] drivers:pci:hv: New paravirtual PCI front-end for
 Hyper-V VMs
Date: Fri, 12 Jun 2015 15:11:14 +0000
Message-ID: <DM2PR0301MB12323CC0C1132A7F71C79DD3ABBB0@DM2PR0301MB1232.namprd03.prod.outlook.com>
References: <1434039747-44535-1-git-send-email-jakeo@microsoft.com>
	 <1434039747-44535-7-git-send-email-jakeo@microsoft.com>
 <1434098643.2271.141.camel@x220>
In-Reply-To: <1434098643.2271.141.camel@x220>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQYXVsIEJvbGxlIFttYWlsdG86
cGVib2xsZUB0aXNjYWxpLm5sXQ0KPiBTZW50OiBGcmlkYXksIEp1bmUgMTIsIDIwMTUgMTo0NCBB
TQ0KPiBUbzogSmFrZSBPc2hpbnMNCj4gQ2M6IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnOyBL
WSBTcmluaXZhc2FuOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgZGV2ZWxAbGlu
dXhkcml2ZXJwcm9qZWN0Lm9yZzsgb2xhZkBhZXBmbGUuZGU7DQo+IGFwd0BjYW5vbmljYWwuY29t
OyB2a3V6bmV0c0ByZWRoYXQuY29tOyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOw0KPiBiaGVs
Z2Fhc0Bnb29nbGUuY29tOyBNaWtlIEViZXJzb2w7IEhhaXlhbmcgWmhhbmcNCj4gU3ViamVjdDog
UmU6IFtQQVRDSCA2LzZdIGRyaXZlcnM6cGNpOmh2OiBOZXcgcGFyYXZpcnR1YWwgUENJIGZyb250
LWVuZCBmb3INCj4gSHlwZXItViBWTXMNCj4gDQo+IEdyZWcgaGFzIGFscmVhZHkgYXNrZWQgeW91
IHRvIHJlc2VuZC4gU28gaGVyZSBmb2xsb3cgYSBmZXcgcmVtYXJrcyB0bw0KPiB0YWtlIGludG8g
YWNjb3VudCBmb3IgdGhhdCByZXNlbmQuDQo+IA0KDQpUaGFuayB5b3UuICBJJ2xsIGZpeCBldmVy
eXRoaW5nIHlvdSd2ZSBtZW50aW9uZWQgYmVmb3JlIHJlc2VuZGluZy4gIEkgZG8gaGF2ZSBvbmUg
bW9yZSBxdWVzdGlvbiwgYmVsb3cuDQoNCj4gDQo+ID4gK0VYUE9SVF9TWU1CT0woaHZfcmVhZF9j
b25maWdfYmxvY2spOw0KPiANCj4gPiArRVhQT1JUX1NZTUJPTChodl93cml0ZV9jb25maWdfYmxv
Y2spOw0KPiANCj4gPiArRVhQT1JUX1NZTUJPTChodl9yZWdpc3Rlcl9ibG9ja19pbnZhbGlkYXRl
KTsNCj4gDQo+IEkgY291bGRuJ3Qgc3BvdCBhbnkgdXNlcnMgb2YgdGhlc2UgZXhwb3J0cy4gQWN0
dWFsbHksIEkgY291bGRuJ3QgZXZlbg0KPiBzcG90IGFueSB1c2VycyBvZiB0aGVzZSB0aHJlZSBm
dW5jdGlvbnMuIFdoeSB3ZXJlIHRoZXkgYWRkZWQ/DQo+IA0KDQpUaGlzIGRyaXZlciBpcyBpbnRl
bmRlZCB0byBzdXBwb3J0IGJvdGggZnVsbCBQQ0kgRXhwcmVzcyBkZXZpY2UgcGFzcyB0aHJvdWdo
IGFuZCBhbHNvIGJlIHRoZSBiYXNpcyBmb3IgU1ItSU9WIG5ldHdvcmtpbmcgb24gdG9wIG9mIEh5
cGVyLVYuICBUaGVzZSBmdW5jdGlvbnMgd291bGQgYWxsb3cgc29tZWJvZHkgdHJ5aW5nIHRvIG1h
a2UgdGhlaXIgTklDIGRyaXZlciB3b3JrIG9uIHRvcCBvZiBIeXBlci1WIHRvIGV4Y2hhbmdlIG1l
c3NhZ2VzIHdpdGggdGhlaXIgYmFjay1lbmQgV2luZG93cyBkcml2ZXIuDQoNCk15IHF1ZXN0aW9u
IGlzIHRoaXMuICBIb3cgZG9lcyBzb21lYm9keSBkZWxpdmVyaW5nIGEgcGxhdGZvcm0gdXN1YWxs
eSB3b3JrIHdpdGggdGhlIExpbnV4IGNvbW11bml0eSB0byBkZWxpdmVyIGVuYWJsZW1lbnQgY29k
ZSBsaWtlIHRoaXM/ICBJJ20gdHJ5aW5nIHRvIHdvcmsgaW4gdGhlIG9wZW4sIGFuZCBnbyB1cHN0
cmVhbSBlYXJseSAob3IgYXQgbGVhc3QgSSB0aGluayB0aGF0IHVuZGVyc3RhbmQgd2hhdCB0aGVz
ZSB0aGluZ3MgbWVhbi4pICBJZiB0aGUgY29tbXVuaXR5IGRvZXNuJ3Qgd2FudCBmdW5jdGlvbnMg
dGhhdCBoYXZlIG5vIGNhbGxlcnMgKGFuZCBJIHVuZGVyc3RhbmQgdGhhdCwgdG9vKSB0aGVuIGhv
dyBzaG91bGQgSSBwcm92aWRlIHRoZW0gdG8gdGhlIE5JQyB2ZW5kb3JzPw0KDQpUaGFua3MsDQpK
YWtlIE9zaGlucw0KDQo=
