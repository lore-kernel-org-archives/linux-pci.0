Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-eopbgr660108.outbound.protection.outlook.com ([40.107.66.108]:47760
        "EHLO CAN01-QB1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S945338AbdDTUnu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Apr 2017 16:43:50 -0400
From: "Stephen  Bates" <sbates@raithlin.com>
To: Dan Williams <dan.j.williams@intel.com>,
        Jerome Glisse <jglisse@redhat.com>
CC: Logan Gunthorpe <logang@deltatee.com>,
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
Date: Thu, 20 Apr 2017 20:43:47 +0000
Message-ID: <D79A59A8-DC7E-413F-ABB8-05F373A9DFD4@raithlin.com>
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
In-Reply-To: <CAPcyv4gxBgVsbSez7_dZYkZojUWU0X0txs7FxiJ+Z3xsMt6TqQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

DQo+IFllcywgdGhpcyBtYWtlcyBzZW5zZSBJIHRoaW5rIHdlIHJlYWxseSBqdXN0IHdhbnQgdG8g
ZGlzdGluZ3Vpc2ggaG9zdA0KPiBtZW1vcnkgb3Igbm90IGluIHRlcm1zIG9mIHRoZSBkZXZfcGFn
ZW1hcCB0eXBlLg0KDQpJIHdvdWxkIGxpa2UgdG8gc2VlIG11dHVhbGx5IGV4Y2x1c2l2ZSBmbGFn
cyBmb3IgaG9zdCBtZW1vcnkgKG9yIG5vdCkgYW5kIHBlcnNpc3RlbmNlIChvciBub3QpLg0KDQpT
dGVwaGVuDQoNCg==
