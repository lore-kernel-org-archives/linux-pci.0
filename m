Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:34370 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754053AbdEJQfQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 May 2017 12:35:16 -0400
From: Wei Zhang <wzhang@fb.com>
To: Keith Busch <keith.busch@intel.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Wesley Yung <wesley.yung@microsemi.com>,
        "Sammy Hui" <sammy.hui@intel.com>,
        Joseph Gruher <joseph.r.gruher@intel.com>,
        Krishna Dhulipala <krishnad@fb.com>
Subject: Re: [PATCH 1/2] pcie/dpc: Skip DPC event if device is not present
Date: Wed, 10 May 2017 16:35:06 +0000
Message-ID: <9D9314D9-2EA5-45C1-AC60-54F7658FD4BC@fb.com>
References: <1493395369-20225-1-git-send-email-keith.busch@intel.com>
 <1493395369-20225-2-git-send-email-keith.busch@intel.com>
 <862590BB-8E84-4F2D-B5F9-A665000AA9CB@fb.com>
 <20170510131729.GD2572@localhost.localdomain>
In-Reply-To: <20170510131729.GD2572@localhost.localdomain>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

SGkgS2VpdGgsDQoNCkkgc2VlLiAgSSB0aG91Z2h0IHRoZSBjdXJyZW50IENQVSByb290IGNvbXBs
ZXggZG9lcyBub3Qgc3VwcG9ydCBzdWNoIGEgdXNlIGNhc2UsIGllIHJlbW92aW5nIHRoZSBEUEMg
c3dpdGNoIGRldmljZSBpdHNlbGYgYW5kIG1pZ2h0IHJlc3VsdCBpbiBrZXJuZWwgcGFuaWMuICBC
dXQgSSBhZ3JlZSB0aGlzIHdpbGwgbWFrZSB0aGUgY29kZSBmdXR1cmUtcHJvb2Ygd2hlbiBDUFUg
ZG9lcyBzdXBwb3J0IHN1Y2ggYSBjYXNlIGluIHRoZSBmdXR1cmUuDQoNClRoYW5rcyBmb3IgdGhl
IGNsYXJpZmljYXRpb24hDQotV2VpDQoNCi0tDQp3ZWkgemhhbmcgfCBzb2Z0d2FyZSBlbmdpbmVl
ciB8IGZhY2Vib29rDQp3emhhbmdAZmIuY29tIHwgKDQwOCkgNDYwLTQ4MDMNCg0KT24gNS8xMC8x
NywgOToxNyBQTSwgIktlaXRoIEJ1c2NoIiA8a2VpdGguYnVzY2hAaW50ZWwuY29tPiB3cm90ZToN
Cg0KICAgIE9uIFdlZCwgTWF5IDEwLCAyMDE3IGF0IDAzOjM5OjI3QU0gKzAwMDAsIFdlaSBaaGFu
ZyB3cm90ZToNCiAgICA+ICBIaSBLZWl0aCBhbmQgV2VzLA0KICAgID4gDQogICAgPiBJIHdvbmRl
ciBpZiBnZXR0aW5nIGFuIEFsbCAx4oCZcyByZWFkIG9uIHRoZSBEUEMgc3RhdHVzIHJlZ2lzdGVy
IGlzIGENCiAgICA+IHZhbGlkIHNjZW5hcmlvLiAgIFRoZSBEUEMgcmVnaXN0ZXIgaXMgb24gdGhl
IHN3aXRjaCwgd2h5IHdvdWxkIHRoZQ0KICAgID4gc3RhdHVzIHJlZ2lzdGVyIHJldHVybnMgQWxs
IDHigJlzIGV2ZW4gaWYgdGhlIGRldmljZSBpcyByZW1vdmVkPw0KICAgIA0KICAgIEFoLCB0aGlz
IGlzbid0IGFib3V0IHRoZSBkb3duc3RyZWFtIGRldmljZSBwcmVjZW5zZS4gVGhpcyBpcyBhYm91
dA0KICAgIHRoZSBEUEMgc3dpdGNoIGRldmljZSBpdHNlbGYsIGxpa2UgaWYgeW91IHB1bGwgdGhl
IGNhYmxlIG91dCBvZiB0aGUNCiAgICBlbmNsb3N1cmUuIFJlYWRpbmcgYW55dGhpbmcgb2ZmIHRo
ZSBEU1BzIGluIGl0IHdpbGwgc2VlIGFsbCAxJ3MuDQogICAgDQoNCg==
