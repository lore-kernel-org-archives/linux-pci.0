Return-Path: <linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH v5 13/13] nvmet: Optionally use PCI P2P memory
To: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-rdma@vger.kernel.org, linux-nvdimm@lists.01.org,
 linux-block@vger.kernel.org
References: <20180830185352.3369-1-logang@deltatee.com>
 <20180830185352.3369-14-logang@deltatee.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <ecbb669a-2e84-1333-7e0d-1560cf014750@grimberg.me>
Date: Thu, 30 Aug 2018 17:25:09 -0700
MIME-Version: 1.0
In-Reply-To: <20180830185352.3369-14-logang@deltatee.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Steve Wise <swise@opengridcomputing.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stephen Bates <sbates@raithlin.com>, Keith Busch <keith.busch@intel.com>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Max Gurtovoy <maxg@mellanox.com>, Dan Williams <dan.j.williams@intel.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Cj4gKy8qCj4gKyAqIElmIGFsbG93X3AycG1lbSBpcyBzZXQsIHdlIHdpbGwgdHJ5IHRvIHVzZSBQ
MlAgbWVtb3J5IGZvciB0aGUgU0dMIGxpc3RzIGZvcgo+ICsgKiDOmS9PIGNvbW1hbmRzLiBUaGlz
IHJlcXVpcmVzIHRoZSBQQ0kgcDJwIGRldmljZSB0byBiZSBjb21wYXRpYmxlIHdpdGggdGhlCj4g
KyAqIGJhY2tpbmcgZGV2aWNlIGZvciBldmVyeSBuYW1lc3BhY2Ugb24gdGhpcyBjb250cm9sbGVy
Lgo+ICsgKi8KPiArc3RhdGljIHZvaWQgbnZtZXRfc2V0dXBfcDJwbWVtKHN0cnVjdCBudm1ldF9j
dHJsICpjdHJsLCBzdHJ1Y3QgbnZtZXRfcmVxICpyZXEpCj4gK3sKPiArCXN0cnVjdCBudm1ldF9u
cyAqbnM7Cj4gKwlpbnQgcmV0Owo+ICsKPiArCWlmICghcmVxLT5wb3J0LT51c2VfcDJwbWVtIHx8
ICFyZXEtPnAycF9jbGllbnQpCj4gKwkJcmV0dXJuOwo+ICsKPiArCW11dGV4X2xvY2soJmN0cmwt
PnN1YnN5cy0+bG9jayk7Cj4gKwo+ICsJcmV0ID0gcGNpX3AycGRtYV9hZGRfY2xpZW50KCZjdHJs
LT5wMnBfY2xpZW50cywgcmVxLT5wMnBfY2xpZW50KTsKPiArCWlmIChyZXQpIHsKPiArCQlwcl9l
cnIoImZhaWxlZCBhZGRpbmcgcGVlci10by1wZWVyIERNQSBjbGllbnQgJXM6ICVkXG4iLAo+ICsJ
CSAgICAgICBkZXZfbmFtZShyZXEtPnAycF9jbGllbnQpLCByZXQpOwo+ICsJCWdvdG8gZnJlZV9k
ZXZpY2VzOwo+ICsJfQo+ICsKPiArCWxpc3RfZm9yX2VhY2hfZW50cnlfcmN1KG5zLCAmY3RybC0+
c3Vic3lzLT5uYW1lc3BhY2VzLCBkZXZfbGluaykgewo+ICsJCXJldCA9IG52bWV0X3AycGRtYV9h
ZGRfY2xpZW50KGN0cmwsIG5zKTsKPiArCQlpZiAocmV0KQo+ICsJCQlnb3RvIGZyZWVfZGV2aWNl
czsKPiArCX0KPiArCj4gKwlpZiAocmVxLT5wb3J0LT5wMnBfZGV2KSB7Cj4gKwkJaWYgKCFwY2lf
cDJwZG1hX2Fzc2lnbl9wcm92aWRlcihyZXEtPnBvcnQtPnAycF9kZXYsCj4gKwkJCQkJCSZjdHJs
LT5wMnBfY2xpZW50cykpIHsKPiArCQkJcHJfaW5mbygicGVlci10by1wZWVyIG1lbW9yeSBvbiAl
cyBpcyBub3Qgc3VwcG9ydGVkXG4iLAo+ICsJCQkJcGNpX25hbWUocmVxLT5wb3J0LT5wMnBfZGV2
KSk7Cj4gKwkJCWdvdG8gZnJlZV9kZXZpY2VzOwo+ICsJCX0KPiArCQljdHJsLT5wMnBfZGV2ID0g
cGNpX2Rldl9nZXQocmVxLT5wb3J0LT5wMnBfZGV2KTsKPiArCX0gZWxzZSB7CgpXaGVuIGlzIHBv
cnQtPnAycF9kZXYgPT0gTlVMTD8gYSBsaXR0bGUgbW9yZSBkb2N1bWVudGF0aW9uIHdvdWxkIGhl
bHAgCmhlcmUuLi4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9y
ZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
