Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:36388 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752343AbdDJM2y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Apr 2017 08:28:54 -0400
From: "Raslan, KarimAllah" <karahmed@amazon.de>
To: David Vrabel <david.vrabel@citrix.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
CC: Juergen Gross <jgross@suse.com>,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Paul Gortmaker" <paul.gortmaker@windriver.com>,
        Julien Grall <julien.grall@citrix.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Ingo Molnar" <mingo@redhat.com>,
        "Liguori, Anthony" <aliguori@amazon.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Subject: Re: [Xen-devel] [PATCH] xen: Remove event channel notification
 through Xen PCI platform device
Date: Mon, 10 Apr 2017 12:28:38 +0000
Message-ID: <5E59C7DE-9640-4D97-A633-BFFDC4BF1352@amazon.de>
References: <1472248536-2063-1-git-send-email-karahmed@amazon.de>
 <57EE7AB7.4020405@citrix.com>
In-Reply-To: <57EE7AB7.4020405@citrix.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

VW5mb3J0dW5hdGVseSwgdGhpcyBjb21taXQgaXMgcG90ZW50aWFsbHkgYSBjYW5kaWRhdGUgZm9y
IHJldmVydGluZy4gQWZ0ZXIgYQ0KbGVuZ3RoeSBxdWFsaWZpY2F0aW9uIEkgcmVhbGl6ZWQgdGhh
dCB0aGVyZSBpcyBhIGZ1bmN0aW9uIGNhbGxlZDoNCiJ4ZW5fc3RyaWN0X3hlbmJ1c19xdWlyaygp
IiB0aGF0IGlzIGJlaW5nIGNhbGxlZCBpbiB0aGUgb2ZmZW5kaW5nIHBhdGggdGhhdA0Kc2hvcnQt
Y2lyY3VpdHMgdGhlIG9mZmVuZGluZyBjb2RlIQ0KDQpTbyBhdCB0aGUgbW9tZW50IGFueSBkb21V
IGtlcm5lbCB3aXRoIHRoaXMgY29tbWl0IHdpbGwgbm90IGJvb3Qgb24gYW55IFhlbg0KdmVyc2lv
biA8IDQuMCEgIFNvIG5vYm9keSB3aXRoIFhlbiA8IDQuMCB3YXMgY29tcGxhaW5pbmcgbm90IGJl
Y2F1c2Ugbm9ib2R5IGlzDQp1c2luZyBpdCBidXQgcmF0aGVyIGJlY2F1c2UgdGhlcmUgaXMgYSBz
aG9ydC1jaXJjdWl0IGluIHRoZSBjb2RlIHRoYXQgYXZvaWRzDQpoaXR0aW5nIHRoZSBvZmZlbmRp
bmcgY29kZSBpbiB0aGUgZmlyc3QgcGxhY2UhIFNvIHRoZSBvcmlnaW5hbCBhc3N1bXB0aW9uIHRo
YXQNCnRoZSBjb2RlIGlzIGRlYWQgbWlnaHQgbm8gYmUgMTAwJSBjb3JyZWN0IQ0KDQpTbyBldmVu
IHRob3VnaCB0aGUgY29kZSBmb3IgSU5UeCBpcyBicm9rZW4gZm9yIGFueSBYZW4gPiA0LjAsIHRo
ZSByaWdodCB0aGluZw0KdG8gZG8gbm93IGlzIHRvIGFjdHVhbGx5IGZpeCB0aGUgSU5UeCBwcm9w
ZXJseSBhbmQgY29tcGxldGVseSByZXZlcnQgdGhpcw0KY29tbWl0IChhY3R1YWxseSBub3cgYWxz
byBjb21taXQgZGE3MmZmNWJmY2IwIG5lZWRzIHRvIGJlIHJldmVydGVkIHRvIGNsZWFubHkNCnJl
dmVydCB0aGlzIGNvbW1pdCkgdG8gYXZvaWQgYW55IHBvdGVudGlhbCByZWdyZXNzaW9uLg0KDQpE
YXZpZCwNCkRvZXMgdGhpcyBtYWtlIHNlbnNlIHRvIHlvdT8NCg0KSSB3aWxsIHNlbmQgYSBwYXRj
aCB0byBmaXggSU5UeCBzaG9ydGx5IGFzIHdlbGwuDQoNCk9uIDkvMzAvMTYsIDQ6NDYgUE0sICJE
YXZpZCBWcmFiZWwiIDxkYXZpZC52cmFiZWxAY2l0cml4LmNvbT4gd3JvdGU6DQoNCiAgICBPbiAy
Ni8wOC8xNiAyMjo1NSwgS2FyaW1BbGxhaCBBaG1lZCB3cm90ZToNCiAgICA+IEV2ZXIgc2luY2Ug
Y29tbWl0IDI1NGQxYTNmMDJlYiAoInhlbi9wdi1vbi1odm0ga2V4ZWM6IHNodXRkb3duIHdhdGNo
ZXMNCiAgICA+IGZyb20gb2xkIGtlcm5lbCIpIHVzaW5nIHRoZSBJTlR4IGludGVycnVwdCBmcm9t
IFhlbiBQQ0kgcGxhdGZvcm0gZGV2aWNlIGZvcg0KICAgID4gZXZlbnQgY2hhbm5lbCBub3RpZmlj
YXRpb24gd291bGQganVzdCBsb2NrdXAgdGhlIGd1ZXN0IGR1cmluZyBib290dXAuDQogICAgPiBw
b3N0Y29yZV9pbml0Y2FsbCBub3cgY2FsbHMgeHNfcmVzZXRfd2F0Y2hlcyB3aGljaCB3aWxsIGV2
ZW50dWFsbHkgdHJ5IHRvIHJlYWQNCiAgICA+IGEgdmFsdWUgZnJvbSBYZW5TdG9yZSBhbmQgd2ls
bCBnZXQgc3R1Y2sgb24gcmVhZF9yZXBseSBhdCBYZW5CdXMgZm9yZXZlciBzaW5jZQ0KICAgID4g
dGhlIHBsYXRmb3JtIGRyaXZlciBpcyBub3QgcHJvYmVkIHlldCBhbmQgaXRzIElOVHggaW50ZXJy
dXB0IGhhbmRsZXIgaXMgbm90DQogICAgPiByZWdpc3RlcmVkIHlldC4gVGhhdCBtZWFucyB0aGF0
IHRoZSBndWVzdCBjYW4gbm90IGJlIG5vdGlmaWVkIGF0IHRoaXMgbW9tZW50IG9mDQogICAgPiBh
bnkgcGVuZGluZyBldmVudCBjaGFubmVscyBhbmQgbm9uZSBvZiB0aGUgcGVyLWV2ZW50IGhhbmRs
ZXJzIHdpbGwgZXZlciBiZQ0KICAgID4gaW52b2tlZCAoaW5jbHVkaW5nIHRoZSBYZW5TdG9yZSBv
bmUpIGFuZCB0aGUgcmVwbHkgd2lsbCBuZXZlciBiZSBwaWNrZWQgdXAgYnkNCiAgICA+IHRoZSBr
ZXJuZWwuDQogICAgDQogICAgQXBwbGllZCB0byBmb3ItbGludXMtNC45LCB0aGFua3MuDQogICAg
DQogICAgRGF2aWQNCiAgICANCiAgICANCiAgICANCg0KQW1hem9uIERldmVsb3BtZW50IENlbnRl
ciBHZXJtYW55IEdtYkgKQmVybGluIC0gRHJlc2RlbiAtIEFhY2hlbgptYWluIG9mZmljZTogS3Jh
dXNlbnN0ci4gMzgsIDEwMTE3IEJlcmxpbgpHZXNjaGFlZnRzZnVlaHJlcjogRHIuIFJhbGYgSGVy
YnJpY2gsIENocmlzdGlhbiBTY2hsYWVnZXIKVXN0LUlEOiBERTI4OTIzNzg3OQpFaW5nZXRyYWdl
biBhbSBBbXRzZ2VyaWNodCBDaGFybG90dGVuYnVyZyBIUkIgMTQ5MTczIEIK
