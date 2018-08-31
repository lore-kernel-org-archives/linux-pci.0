Return-Path: <linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org>
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
 linux-nvdimm@lists.01.org, linux-block@vger.kernel.org
References: <20180830185352.3369-1-logang@deltatee.com>
 <20180830185352.3369-7-logang@deltatee.com>
 <98bff500-4e4c-3a34-6762-16ef4b076d90@amd.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <6820d451-9591-1979-00bf-60c65fc4f136@deltatee.com>
Date: Fri, 31 Aug 2018 09:51:06 -0600
MIME-Version: 1.0
In-Reply-To: <98bff500-4e4c-3a34-6762-16ef4b076d90@amd.com>
Subject: Re: [PATCH v5 06/13] PCI/P2PDMA: Add P2P DMA driver writer's
 documentation
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Sagi Grimberg <sagi@grimberg.me>, Jonathan Corbet <corbet@lwn.net>,
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

CgpPbiAzMS8wOC8xOCAwMjowOCBBTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4gK09uZSBv
ZiB0aGUgYmlnZ2VzdCBpc3N1ZXMgaXMgdGhhdCBQQ0kgZG9lc24ndCByZXF1aXJlIGZvcndhcmRp
bmcKPj4gK3RyYW5zYWN0aW9ucyBiZXR3ZWVuIGhpZXJhcmNoeSBkb21haW5zLCBhbmQgaW4gUENJ
ZSwgZWFjaCBSb290IFBvcnQKPj4gK2RlZmluZXMgYSBzZXBhcmF0ZSBoaWVyYXJjaHkgZG9tYWlu
LiBUbyBtYWtlIHRoaW5ncyB3b3JzZSwgdGhlcmUgaXMgbm8KPj4gK3NpbXBsZSB3YXkgdG8gZGV0
ZXJtaW5lIGlmIGEgZ2l2ZW4gUm9vdCBDb21wbGV4IHN1cHBvcnRzIHRoaXMgb3Igbm90Lgo+PiAr
KFNlZSBQQ0llIHI0LjAsIHNlYyAxLjMuMSkuIFRoZXJlZm9yZSwgYXMgb2YgdGhpcyB3cml0aW5n
LCB0aGUga2VybmVsCj4+ICtvbmx5IHN1cHBvcnRzIGRvaW5nIFAyUCB3aGVuIHRoZSBlbmRwb2lu
dHMgaW52b2x2ZWQgYXJlIGFsbCBiZWhpbmQgdGhlCj4+ICtzYW1lIFBDSSBicmlkZ2UsIGFzIHN1
Y2ggZGV2aWNlcyBhcmUgYWxsIGluIHRoZSBzYW1lIFBDSSBoaWVyYXJjaHkKPj4gK2RvbWFpbiwg
YW5kIHRoZSBzcGVjIGd1YXJhbnRlZXMgdGhhdCBhbGwgdHJhbnNhY2F0aW9ucyB3aXRoaW4gdGhl
Cj4+ICtoaWVyYXJjaHkgd2lsbCBiZSByb3V0YWJsZSwgYnV0IGl0IGRvZXMgbm90IHJlcXVpcmUg
cm91dGluZwo+PiArYmV0d2VlbiBoaWVyYXJjaGllcy4KPiAKPiBDYW4gd2UgYWRkIGEga2VybmVs
IGNvbW1hbmQgbGluZSBzd2l0Y2ggYW5kIGEgd2hpdGVsaXN0IHRvIGVuYWJsZSBQMlAgCj4gYmV0
d2VlbiBzZXBhcmF0ZSBoaWVyYXJjaGllcz8KCkluIGZ1dHVyZSB3b3JrLCB5ZXMuIEJ1dCBub3Qg
Zm9yIHRoaXMgcGF0Y2hzZXQuIFRoaXMgaXMgZGVmaW5pdGVseSB0aGUKd2F5IEkgc2VlIHRoaW5n
cyBnb2luZywgYnV0IHdlJ3ZlIGNob3NlbiB0byBzdGFydCB3aXRoIHdoYXQgd2UndmUgcHJlc2Vu
dGVkLgoKTG9nYW4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9y
ZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
