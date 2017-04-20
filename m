Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-eopbgr670099.outbound.protection.outlook.com ([40.107.67.99]:61440
        "EHLO CAN01-TO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S947937AbdDTXHK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Apr 2017 19:07:10 -0400
From: "Stephen  Bates" <sbates@raithlin.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: Jerome Glisse <jglisse@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Christoph Hellwig" <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Steve Wise <swise@opengridcomputing.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Keith Busch <keith.busch@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@ml01.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 0/8] Copy Offload with Peer-to-Peer PCI Memory
Date: Thu, 20 Apr 2017 23:07:06 +0000
Message-ID: <D090F830-2753-4479-A291-CEE37DC0A853@raithlin.com>
References: <20170418164557.GA7181@obsidianresearch.com>
 <cce00131-1f28-27b3-40ab-04f8783f1e5a@deltatee.com>
 <20170418190138.GH7181@obsidianresearch.com>
 <df1351d8-b86c-2e21-1948-4688ece5dc2b@deltatee.com>
 <CAPcyv4gScx6A7vG9VEHpNF41GOy1Nxst7QQ3QC3uZ54bWoxbMg@mail.gmail.com>
 <20170418210339.GA24257@obsidianresearch.com>
 <1492564806.25766.124.camel@kernel.crashing.org>
 <20170419155557.GA8497@obsidianresearch.com>
 <4899b011-bdfb-18d8-ef00-33a1516216a6@deltatee.com>
 <CAPcyv4iJ9H8Ykwnjqa2R_D1qG6PsSQmi=QxYH-rKLF_ihrsWyw@mail.gmail.com>
 <20170419173225.GA11255@redhat.com>
 <CAPcyv4gxBgVsbSez7_dZYkZojUWU0X0txs7FxiJ+Z3xsMt6TqQ@mail.gmail.com>
 <D79A59A8-DC7E-413F-ABB8-05F373A9DFD4@raithlin.com>
 <CAPcyv4i+a_14E58SjFHncyq2O2-zf_PB=aT7k0a-Jc0XsfPapQ@mail.gmail.com>
In-Reply-To: <CAPcyv4i+a_14E58SjFHncyq2O2-zf_PB=aT7k0a-Jc0XsfPapQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Pj4gWWVzLCB0aGlzIG1ha2VzIHNlbnNlIEkgdGhpbmsgd2UgcmVhbGx5IGp1c3Qgd2FudCB0byBk
aXN0aW5ndWlzaCBob3N0DQo+PiBtZW1vcnkgb3Igbm90IGluIHRlcm1zIG9mIHRoZSBkZXZfcGFn
ZW1hcCB0eXBlLg0KPg0KPj4gSSB3b3VsZCBsaWtlIHRvIHNlZSBtdXR1YWxseSBleGNsdXNpdmUg
ZmxhZ3MgZm9yIGhvc3QgbWVtb3J5IChvciBub3QpIGFuZCBwZXJzaXN0ZW5jZSAob3Igbm90KS4N
Cj4+DQo+DQo+IFdoeSBwZXJzaXN0ZW5jZT8gSXQgaGFzIHplcm8gbWVhbmluZyB0byB0aGUgbW0u
DQoNCkkgbGlrZSB0aGUgaWRlYSBvZiBoYXZpbmcgcHJvcGVydGllcyBvZiB0aGUgbWVtb3J5IGlu
IG9uZSBwbGFjZS4gV2hpbGUgbW0gbWlnaHQgbm90IHVzZSBwZXJzaXN0ZW5jZSB0b2RheSBpdCBt
YXkgbWFrZSB1c2UgY2VydGFpbiB0aGluZ3MgdGhhdCBwZXJzaXN0ZW5jZSBpbXBsaWVzIChsaWtl
IGZpbml0ZSBlbmR1cmFuY2UgYW5kL29yIGhpZ2hlciB3cml0ZSBsYXRlbmN5KSBpbiB0aGUgZnV0
dXJlLiBBbHNvIHRoZSBwZXJzaXN0ZW5jZSBvZiB0aGUgbWVtb3J5IG11c3QgaGF2ZSBpc3N1ZXMg
Zm9yIG1tIHNlY3VyaXR5PyBBZ2FpbiBub3QgYWRkcmVzc2VkIHRvZGF5IGJ1dCB1c2VmdWwgaW4g
dGhlIGZ1dHVyZS4NCg0KSW4gYWRkaXRpb24gSSBhbSBub3Qgc3VyZSB3aGVyZSBlbHNlIHdvdWxk
IGJlIGFuIGFwcHJvcHJpYXRlIHBsYWNlIHRvIHB1dCBzb21ldGhpbmcgbGlrZSBhIHBlcnNpc3Rl
bmNlIHByb3BlcnR5IGZsYWcuIEkga25vdyB0aGUgTlZESU1NIHNlY3Rpb24gb2YgdGhlIGtlcm5l
bCB1c2VzIHRoaW5ncyBsaWtlIE5GSVQgdG8gZGVzY3JpYmUgcHJvcGVydGllcyBvZiB0aGUgbWVt
b3J5IGJ1dCB3ZSBkb27igJl0IHlldCAodG8gbXkga25vd2xlZGdlKSBoYXZlIHNvbWV0aGluZyBz
aW1pbGFyIGZvciBJTyBtZW1vcnkuDQoNClN0ZXBoZW4NCg0K
