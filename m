Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp-out6.electric.net ([192.162.217.194]:62315 "EHLO
        smtp-out6.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756301AbcK3SPL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Nov 2016 13:15:11 -0500
From: David Laight <David.Laight@ACULAB.COM>
To: 'Bjorn Helgaas' <bhelgaas@google.com>,
        Gavin Shan <gwshan@linux.vnet.ibm.com>
CC: "clsoto@us.ibm.com" <clsoto@us.ibm.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH v4 4/7] PCI: Don't update VF BARs while VF memory space
 is enabled
Date: Wed, 30 Nov 2016 17:56:05 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DB02307B5@AcuExch.aculab.com>
References: <20161129035218.21453.93986.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20161129041521.21453.33146.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20161129041521.21453.33146.stgit@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

RnJvbTogQmpvcm4gSGVsZ2Fhcw0KPiBTZW50OiAyOSBOb3ZlbWJlciAyMDE2IDA0OjE1DQo+IElm
IHdlIHVwZGF0ZSBhIFZGIEJBUiB3aGlsZSBpdCdzIGVuYWJsZWQsIHRoZXJlIGFyZSB0d28gcG90
ZW50aWFsIHByb2JsZW1zOg0KPiANCj4gICAxKSBBbnkgZHJpdmVyIHRoYXQncyB1c2luZyB0aGUg
VkYgaGFzIGEgY2FjaGVkIEJBUiB2YWx1ZSB0aGF0IGlzIHN0YWxlDQo+ICAgICAgYWZ0ZXIgdGhl
IHVwZGF0ZSwgYW5kDQo+IA0KPiAgIDIpIFdlIGNhbid0IHVwZGF0ZSA2NC1iaXQgQkFScyBhdG9t
aWNhbGx5LCBzbyB0aGUgaW50ZXJtZWRpYXRlIHN0YXRlDQo+ICAgICAgKG5ldyBsb3dlciBkd29y
ZCB3aXRoIG9sZCB1cHBlciBkd29yZCkgbWF5IGNvbmZsaWN0IHdpdGggYW5vdGhlcg0KPiAgICAg
IGRldmljZSwgYW5kIGFuIGFjY2VzcyBieSBhIGRyaXZlciB1bnJlbGF0ZWQgdG8gdGhlIFZGIG1h
eSBjYXVzZSBhIGJ1cw0KPiAgICAgIGVycm9yLg0KDQpDYW4gdGhlIGhpZ2ggd29yZCBiZSBmaXJz
dCBzZXQgdG8gYSB2YWx1ZSB0aGF0IGlzIGludmFsaWQgKGllIGEgNEcgYmxvY2sNCnRoYXQgaGFz
IG5vIHZhbGlkIFBDSWUgc2xhdmVzKSBiZWZvcmUgdXBkYXRpbmcgdGhlIGxvdyB3b3JkIGFuZCBm
aW5hbGx5DQp0aGUgY29ycmVjdCBoaWdoIHdvcmQuDQoNCk5vdGUgdGhhdCB0aGUgYWRkcmVzcyBv
bmx5IGhhcyB0byBiZSBvdXRzaWRlIHRoZSByYW5nZSB0aGF0IHRoZSBicmlkZ2UNCmZvcndhcmRz
IG9udG8gdGhhdCBzcGVjaWZpYyBidXMuDQoNCglEYXZpZA0KDQo=
