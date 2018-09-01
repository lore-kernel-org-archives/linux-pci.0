Return-Path: <linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Sat, 1 Sep 2018 10:27:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v5 01/13] PCI/P2PDMA: Support peer-to-peer memory
Message-ID: <20180901082703.GA670@lst.de>
References: <20180830185352.3369-1-logang@deltatee.com>
 <20180830185352.3369-2-logang@deltatee.com>
 <2711b3a7-f582-0dda-8ac2-530be7bda1bb@amd.com>
 <439181bb-6cd6-0ab2-bca6-fc820845166e@deltatee.com>
MIME-Version: 1.0
In-Reply-To: <439181bb-6cd6-0ab2-bca6-fc820845166e@deltatee.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <keith.busch@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvdimm@lists.01.org, linux-rdma@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 linux-block@vger.kernel.org,
 =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
 Jason Gunthorpe <jgg@mellanox.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Max Gurtovoy <maxg@mellanox.com>,
 Dan Williams <dan.j.williams@intel.com>, Christoph Hellwig <hch@lst.de>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

T24gRnJpLCBBdWcgMzEsIDIwMTggYXQgMDk6NDg6NDBBTSAtMDYwMCwgTG9nYW4gR3VudGhvcnBl
IHdyb3RlOgo+IFByZXR0eSBlYXN5LiBQMlAgZGV0ZWN0aW9uIGlzIHByZXR0eSBtdWNoIGp1c3Qg
cGNpX3AycGRtYV9kaXN0YW5jZSgpICwKPiB3aGljaCBoYXMgbm90aGluZyB0byBkbyB3aXRoIHRo
ZSBaT05FX0RFVklDRSBzdXBwb3J0Lgo+IAo+IChBbmQgdGhlIGRpc3RhbmNlIGZ1bmN0aW9uIG1h
a2VzIHVzZSBvZiBhIG51bWJlciBvZiBzdGF0aWMgZnVuY3Rpb25zCj4gd2hpY2ggY291bGQgYmUg
Y29tYmluZWQgaW50byBhIHNpbXBsZXIgaW50ZXJmYWNlLCBzaG91bGQgd2UgbmVlZCBpdC4pCgpJ
J2Qg0ZVheSBsZXRzIGdldCB0aGluZ3MgbWVyZ2VkIGFzLWlzLCBzbyB0aGF0IHdlIGNhbiByZXZp
ZXcgdGhlCm5vbi1aT05FX0RFVklDRSB1c2Vycy4gIEknbSBhIGxpdHRsZSBjdXJpb3VzIGhvdyB0
aGF0IGlzIGdvaW5nIHRvIHdvcmssCnNvIGhhdmluZyBpdCBhcyBhIGZ1bGwgc2VyaWVzIHdvdWxk
IGJlIHVzZWZ1bC4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9y
ZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
