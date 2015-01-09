Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cmexedge2.emulex.com ([138.239.224.100]:6851 "EHLO
	CMEXEDGE2.ext.emulex.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752365AbbAIHkg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 9 Jan 2015 02:40:36 -0500
From: Venkat Duvvuru <VenkatKumar.Duvvuru@Emulex.Com>
To: Alex Williamson <alex.williamson@redhat.com>,
	Gavin Shan <gwshan@linux.vnet.ibm.com>
CC: Ajit Kumar Khaparde <Ajit.Khaparde@Emulex.Com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH] PCI: Mark broken INTx masking for BENET devices
Date: Fri, 9 Jan 2015 07:40:08 +0000
Message-ID: <f588414b-dba0-4d83-942b-0e5841f1e89c@CMEXHTCAS1.ad.emulex.com>
References: <1420424274-3194-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <a227414f-6f4b-4656-b65b-ef8d6e68f135@CMEXHTCAS1.ad.emulex.com>
 <20150109003320.GA24054@shangw>
 <1257448143.6977594.1420766719306.JavaMail.zimbra@redhat.com>
In-Reply-To: <1257448143.6977594.1420766719306.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PiA+DQo+ID4gVmVua2F0LCBPbiBJQk0ncyBQb3dlcjcgYm94LCBJIHBhc3NlZCB0aHJvdWdoIGZv
bGxvd2luZyBhZHBhdGVyIHRvIGd1ZXN0DQo+IHdpdGgNCj4gPiBmb2xsb3dpbmcNCj4gLi4uDQo+
ID4NCj4gPiBTdGVwcyB0byByZWNyZWF0ZSB0aGUgaXNzdWUNCj4gPiA9PT09PT09PT09PT09PT09
PT09PT09PT09PT0NCj4gPg0KPiA+IDEuIENvbmZpZ3VyZSB0aGUgTklDIGFuZCBwaW5nIGl0IGZy
b20gZXh0ZXJuYWwuDQo+ID4gMi4gSW5qZWN0IEVFSCBlcnJvciBieSBydW5uaW5nIGZvbGxvd2lu
ZyBjb21tYW5kIGluIGhvc3Qgc2lkZS4gQWZ0ZXIgYWJvdXQNCj4gPiAgICAyMCBzZWNvbmRzLCBJ
IGdvdCBmb2xsb3dpbmcgbWVzc2FnZSBmcm9tIGhvc3Qgc2lkZS4gV2l0aCB0aGUgcGF0Y2gNCj4g
YXBwbGllZA0KPiA+ICAgIHRvIGhvc3Qga2VybmVsLCBJIGRpZG4ndCBzZWUgdGhlIHdhcm5pbmcg
bWVzc2FnZXM6DQo+IA0KPiBUaGlzIHNlZW1zIHJlYWxseSBkdWJpb3VzIGFuZCBJIGRvbid0IHNl
ZSBhbnkganVzdGlmaWNhdGlvbiBhdCBhbGwgZm9yIGRlY2xhcmluZw0KPiBEaXNJTlR4IGJyb2tl
biBmb3IgYWxsIGRldmljZXMgZm9yIHRoZSB2ZW5kb3IuICBUeXBpY2FsbHkgdG8gY2FsbCBEaXNJ
TlR4IGJyb2tlbg0KPiBmb3IgYSBnaXZlbiBkZXZpY2UsIHlvdSBjYW4ganVzdCBib290IHRoZSBn
dWVzdCB3aXRoIHBjaT1ub21zaSB0byBmb3JjZSBJTlR4DQo+IHRvIGJlIHVzZWQuICBJZiB0aGF0
IHdvcmtzLCB0aGVuIERpc0lOVHggbWFza2luZyB3b3Jrcy4gIElmIHlvdSByZXF1aXJlIEVFSA0K
PiBpbmplY3Rpb24gdG8gdG8gdHJpZ2dlciB0aGlzLCB0aGVuIHRoZSBwcm9ibGVtIGlzIG1vcmUg
bGlrZWx5IHNvbWUgY29udGFpbm1lbnQNCj4gaXNzdWUgZHVyaW5nIEVFSCByZWNvdmVyeS4gIFRo
YW5rcywNCj4gDQo+IEFsZXgNClllcyBJIGFncmVlIHdpdGggQWxleC4gDQpwY2k9bm9tc2kgaXMg
d2hhdCBleGFjdGx5IHdlIGRpZCB0byBzZWUgaWYgRGlzSU5UeCBpcyBicm9rZW4gb3Igbm90IGFu
ZCBEaXNJTlR4IHdvcmtzIGZpbmUgaW4gb3VyIHNldHVwLg0KSSB0aGluaywgd2UgbmVlZCB0byBh
bmFseXplIHRoaXMgRUVIIGluamVjdGlvbiBzY2VuYXJpbyBmdXJ0aGVyLCB0byByb290IGNhdXNl
IHRoZSBwcm9ibGVtLg0KV2Ugd2lsbCBwb3N0IHlvdSB1cGRhdGVzIG9uIG91ciBmaW5kaW5ncyBh
ZnRlciB0aGUgYW5hbHlzaXMuDQo=
