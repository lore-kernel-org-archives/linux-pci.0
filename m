Return-Path: <linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org>
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
 linux-nvdimm@lists.01.org, linux-block@vger.kernel.org
References: <20180830185352.3369-1-logang@deltatee.com>
 <20180830185352.3369-2-logang@deltatee.com>
 <2711b3a7-f582-0dda-8ac2-530be7bda1bb@amd.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <439181bb-6cd6-0ab2-bca6-fc820845166e@deltatee.com>
Date: Fri, 31 Aug 2018 09:48:40 -0600
MIME-Version: 1.0
In-Reply-To: <2711b3a7-f582-0dda-8ac2-530be7bda1bb@amd.com>
Subject: Re: [PATCH v5 01/13] PCI/P2PDMA: Support peer-to-peer memory
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Sagi Grimberg <sagi@grimberg.me>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stephen Bates <sbates@raithlin.com>, Keith Busch <keith.busch@intel.com>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Max Gurtovoy <maxg@mellanox.com>, Dan Williams <dan.j.williams@intel.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="utf-8"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

CgpPbiAzMS8wOC8xOCAwMjowNCBBTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBBbSAzMC4w
OC4yMDE4IHVtIDIwOjUzIHNjaHJpZWIgTG9nYW4gR3VudGhvcnBlOgo+PiBTb21lIFBDSSBkZXZp
Y2VzIG1heSBoYXZlIG1lbW9yeSBtYXBwZWQgaW4gYSBCQVIgc3BhY2UgdGhhdCdzCj4+IGludGVu
ZGVkIGZvciB1c2UgaW4gcGVlci10by1wZWVyIHRyYW5zYWN0aW9ucy4gSW4gb3JkZXIgdG8gZW5h
YmxlCj4+IHN1Y2ggdHJhbnNhY3Rpb25zIHRoZSBtZW1vcnkgbXVzdCBiZSByZWdpc3RlcmVkIHdp
dGggWk9ORV9ERVZJQ0UgcGFnZXMKPj4gc28gaXQgY2FuIGJlIHVzZWQgYnkgRE1BIGludGVyZmFj
ZXMgaW4gZXhpc3RpbmcgZHJpdmVycy4KPiAKPiBXZSB3YW50IHRvIHVzZSB0aGF0IGZlYXR1cmUg
d2l0aG91dCBaT05FX0RFVklDRSBwYWdlcyBmb3IgRE1BLWJ1ZiBhcyB3ZWxsLgo+IAo+IEhvdyBo
YXJkIHdvdWxkIGl0IGJlIHRvIHNlcGFyYXRlIGVuYWJsaW5nIFAyUCBkZXRlY3Rpb24gKGUuZy4g
ZGlzdGFuY2UgCj4gYmV0d2VlbiB0d28gZGV2aWNlcykgZnJvbSB0aGlzPwoKUHJldHR5IGVhc3ku
IFAyUCBkZXRlY3Rpb24gaXMgcHJldHR5IG11Y2gganVzdCBwY2lfcDJwZG1hX2Rpc3RhbmNlKCkg
LAp3aGljaCBoYXMgbm90aGluZyB0byBkbyB3aXRoIHRoZSBaT05FX0RFVklDRSBzdXBwb3J0LgoK
KEFuZCB0aGUgZGlzdGFuY2UgZnVuY3Rpb24gbWFrZXMgdXNlIG9mIGEgbnVtYmVyIG9mIHN0YXRp
YyBmdW5jdGlvbnMKd2hpY2ggY291bGQgYmUgY29tYmluZWQgaW50byBhIHNpbXBsZXIgaW50ZXJm
YWNlLCBzaG91bGQgd2UgbmVlZCBpdC4pCgpMb2dhbgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZt
ZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8vbGludXgtbnZtZQo=
