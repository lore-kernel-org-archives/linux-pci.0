Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Stephen  Bates" <sbates@raithlin.com>
To: Knut Omang <knut.omang@oracle.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        "Dan Williams" <dan.j.williams@intel.com>
CC: Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Steve Wise <swise@opengridcomputing.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        Jerome Glisse <jglisse@redhat.com>,
        "Bjorn Helgaas" <helgaas@kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@ml01.01.org>,
        Max Gurtovoy <maxg@mellanox.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC 0/8] Copy Offload with Peer-to-Peer PCI Memory
Date: Tue, 25 Apr 2017 21:23:31 +0000
Message-ID: <705B114E-A084-4C0C-84BD-47E752FEE198@raithlin.com>
References: <1490911959-5146-1-git-send-email-logang@deltatee.com>
 <1491974532.7236.43.camel@kernel.crashing.org>
 <5ac22496-56ec-025d-f153-140001d2a7f9@deltatee.com>
 <1492034124.7236.77.camel@kernel.crashing.org>
 <81888a1e-eb0d-cbbc-dc66-0a09c32e4ea2@deltatee.com>
 <20170413232631.GB24910@bhelgaas-glaptop.roam.corp.google.com>
 <20170414041656.GA30694@obsidianresearch.com>
 <1492169849.25766.3.camel@kernel.crashing.org>
 <630c1c63-ff17-1116-e069-2b8f93e50fa2@deltatee.com>
 <20170414190452.GA15679@bhelgaas-glaptop.roam.corp.google.com>
 <1492207643.25766.18.camel@kernel.crashing.org>
 <bff1e503-95a9-e19f-bfd9-0ff962c63a81@deltatee.com>
 <CAPcyv4jUeKzKDARp6Z35kdPLKnP-M6aF8X5KpOx55CLyjnj4dA@mail.gmail.com>
 <1492311719.25766.37.camel@kernel.crashing.org>
 <CAPcyv4iqnz1B00Q3xG-nGrLXdOyB7ditxmwZyotksLFgUqr+jA@mail.gmail.com>
 <5e43818e-8c6b-8be8-23ff-b798633d2a73@deltatee.com>
 <1492381907.25766.49.camel@kernel.crashing.org>
 <1493019397.3171.118.camel@oracle.com>
In-Reply-To: <1493019397.3171.118.camel@oracle.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

DQo+IE15IGZpcnN0IHJlZmxleCB3aGVuIHJlYWRpbmcgdGhpcyB0aHJlYWQgd2FzIHRvIHRoaW5r
IHRoYXQgdGhpcyB3aG9sZSBkb21haW4NCj4gbGVuZHMgaXQgc2VsZiBleGNlbGxlbnRseSB0byB0
ZXN0aW5nIHZpYSBRZW11LiBDb3VsZCBpdCBiZSB0aGF0IGRvaW5nIHRoaXMgaW4gDQo+IHRoZSBv
cHBvc2l0ZSBkaXJlY3Rpb24gbWlnaHQgYmUgYSBzYWZlciBhcHByb2FjaCBpbiB0aGUgbG9uZyBy
dW4gZXZlbiB0aG91Z2ggDQo+IChzaWduaWZpY2FudCkgbW9yZSB3b3JrIHVwLWZyb250Pw0KDQpX
aGlsZSB0aGUgaWRlYSBvZiBRRU1VIGZvciB0aGlzIHdvcmsgaXMgYXR0cmFjdGl2ZSBpdCB3aWxs
IGJlIGEgbG9uZyB0aW1lIGJlZm9yZSBRRU1VIGlzIGluIGEgcG9zaXRpb24gdG8gc3VwcG9ydCB0
aGlzIGRldmVsb3BtZW50LiANCg0KQW5vdGhlciBhcHByb2FjaCBpcyB0byBwcm9wb3NlIGEgY29t
bW9uIGRldmVsb3BtZW50IHBsYXRmb3JtIGZvciBwMnBtZW0gd29yayB1c2luZyBhIHBsYXRmb3Jt
IHdlIGtub3cgaXMgZ29pbmcgdG8gd29yay4gVGhpcyBhbiBleHRyZW1lIHZlcnNpb24gb2YgdGhl
IHdoaXRlbGlzdGluZyBhcHByb2FjaCB0aGF0IHdhcyBkaXNjdXNzZWQgb24gdGhpcyB0aHJlYWQu
IFdlIGNhbiBsaXN0IGEgdmVyeSBzcGVjaWZpYyBzZXQgb2YgaGFyZHdhcmUgKG1vdGhlcmJvYXJk
LCBQQ0llIGVuZC1wb2ludHMgYW5kIChwb3NzaWJseSkgUENJZSBzd2l0Y2ggZW5jbG9zdXJlKSB0
aGF0IGhhcyBiZWVuIHNob3duIHRvIHdvcmsgdGhhdCBvdGhlcnMgY2FuIGNvcHkgZm9yIHRoZWly
IGRldmVsb3BtZW50IHB1cnBvc2VzLg0KDQpwMnBtZW0uaW8gcGVyaGFwcyA7LSk/DQoNClN0ZXBo
ZW4NCg0KDQo=
