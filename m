Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-eopbgr660134.outbound.protection.outlook.com ([40.107.66.134]:46877
        "EHLO CAN01-QB1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754749AbdDGLTd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Apr 2017 07:19:33 -0400
From: "Stephen  Bates" <sbates@raithlin.com>
To: Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
CC: Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Steve Wise <swise@opengridcomputing.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-nvdimm@ml01.01.org" <linux-nvdimm@ml01.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 6/8] nvmet: Be careful about using iomem accesses when
 dealing with p2pmem
Date: Fri, 7 Apr 2017 11:19:30 +0000
Message-ID: <3E85B4D4-9EBC-4299-8209-2D8740947764@raithlin.com>
References: <1490911959-5146-1-git-send-email-logang@deltatee.com>
 <1490911959-5146-7-git-send-email-logang@deltatee.com>
 <080b68b4-eba3-861c-4f29-5d829425b5e7@grimberg.me>
 <20170404154629.GA13552@obsidianresearch.com>
 <4df229d8-8124-664a-9bc4-6401bc034be1@grimberg.me>
In-Reply-To: <4df229d8-8124-664a-9bc4-6401bc034be1@grimberg.me>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

T24gMjAxNy0wNC0wNiwgNjozMyBBTSwgIlNhZ2kgR3JpbWJlcmciIDxzYWdpQGdyaW1iZXJnLm1l
PiB3cm90ZToNCg0KPiBTYXkgaXQncyBjb25uZWN0ZWQgdmlhIDIgbGVncywgdGhlIGJhciBpcyBh
Y2Nlc3NlZCBmcm9tIGxlZyBBIGFuZCB0aGUNCj4gZGF0YSBmcm9tIHRoZSBkaXNrIGNvbWVzIHZp
YSBsZWcgQi4gSW4gdGhpcyBjYXNlLCB0aGUgZGF0YSBpcyBoZWFkaW5nDQo+IHRvd2FyZHMgdGhl
IHAycCBkZXZpY2UgdmlhIGxlZyBCIChtaWdodCBiZSBjb25nZXN0ZWQpLCB0aGUgY29tcGxldGlv
bg0KPiBnb2VzIGRpcmVjdGx5IHRvIHRoZSBSQywgYW5kIHRoZW4gdGhlIGhvc3QgaXNzdWVzIGEg
cmVhZCBmcm9tIHRoZQ0KPiBiYXIgdmlhIGxlZyBBLiBJIGRvbid0IHVuZGVyc3RhbmQgd2hhdCBj
YW4gZ3VhcmFudGVlIG9yZGVyaW5nIGhlcmUuDQoNCj4gU3RlcGhlbiB0b2xkIG1lIHRoYXQgdGhp
cyBzdGlsbCBndWFyYW50ZWVzIG9yZGVyaW5nLCBidXQgSSBob25lc3RseQ0KPiBjYW4ndCB1bmRl
cnN0YW5kIGhvdywgcGVyaGFwcyBzb21lb25lIGNhbiBleHBsYWluIHRvIG1lIGluIGEgc2ltcGxl
DQo+IHdheSB0aGF0IEkgY2FuIHVuZGVyc3RhbmQuDQoNClNhZ2kNCg0KQXMgbG9uZyBhcyBsZWdB
LCBsZWdCIGFuZCB0aGUgUkMgYXJlIGFsbCBjb25uZWN0ZWQgdG8gdGhlIHNhbWUgc3dpdGNoIHRo
ZW4gb3JkZXJpbmcgd2lsbCBiZSBwcmVzZXJ2ZWQgKEkgdGhpbmsgbWFueSBvdGhlciB0b3BvbG9n
aWVzIGFsc28gd29yaykuIEhlcmUgaXMgaG93IGl0IHdvdWxkIHdvcmsgZm9yIHRoZSBwcm9ibGVt
IGNhc2UgeW91IGFyZSBjb25jZXJuZWQgYWJvdXQgKHdoaWNoIGlzIGEgcmVhZCBmcm9tIHRoZSBO
Vk1lIGRyaXZlKS4NCg0KMS4gRGlzayBkZXZpY2UgRE1BcyBvdXQgdGhlIGRhdGEgdG8gdGhlIHAy
cG1lbSBkZXZpY2UgdmlhIGEgc3RyaW5nIG9mIFBDSWUgTWVtV3IgVExQcy4NCjIuIERpc2sgZGV2
aWNlIHdyaXRlcyB0byB0aGUgY29tcGxldGlvbiBxdWV1ZSAoaW4gc3lzdGVtIG1lbW9yeSkgdmlh
IGEgTWVtV3IgVExQLg0KMy4gVGhlIGxhc3Qgb2YgdGhlIE1lbVdycyBmcm9tIHN0ZXAgMSBtaWdo
dCBoYXZlIGdvdCBzdGFsbGVkIGluIHRoZSBQQ0llIHN3aXRjaCBkdWUgdG8gY29uZ2VzdGlvbiBi
dXQgaWYgc28gdGhleSBhcmUgc3RhbGxlZCBpbiB0aGUgZWdyZXNzIHBhdGggb2YgdGhlIHN3aXRj
aCBmb3IgdGhlIHAycG1lbSBwb3J0Lg0KNC4gVGhlIFJDIGRldGVybWluZXMgdGhlIElPIGlzIGNv
bXBsZXRlIHdoZW4gdGhlIFRMUCBhc3NvY2lhdGVkIHdpdGggc3RlcCAyIHVwZGF0ZXMgdGhlIG1l
bW9yeSBhc3NvY2lhdGVkIHdpdGggdGhlIENRLiBJdCBpc3N1ZXMgc29tZSBvcGVyYXRpb24gdG8g
cmVhZCB0aGUgcDJwbWVtLg0KNS4gUmVnYXJkbGVzcyBvZiB3aGV0aGVyIHRoZSBNZW1SZCBUTFAg
Y29tZXMgZnJvbSB0aGUgUkMgb3IgYW5vdGhlciBkZXZpY2UgY29ubmVjdGVkIHRvIHRoZSBzd2l0
Y2ggaXQgaXMgcXVldWVkIGluIHRoZSBlZ3Jlc3MgcXVldWUgZm9yIHRoZSBwMnBtZW0gRklPIGJl
aGluZCB0aGUgbGFzdCBETUEgVExQIChmcm9tIHN0ZXAgMSkuIFBDSWUgb3JkZXJpbmcgZW5zdXJl
cyB0aGF0IHRoaXMgTWVtUmQgY2Fubm90IG92ZXJ0YWtlIHRoZSBNZW1XciAoUmVhZHMgY2FuIG5l
dmVyIHBhc3Mgd3JpdGVzKS4gVGhlcmVmb3JlIHRoZSBNZW1SZCBjYW4gbmV2ZXIgZ2V0IHRvIHRo
ZSBwMnBtZW0gZGV2aWNlIHVudGlsIGFmdGVyIHRoZSBsYXN0IERNQSBNZW1XciBoYXMuDQoNCkkg
aG9wZSB0aGlzIGhlbHBzIQ0KDQpTdGVwaGVuDQoNCg0K
