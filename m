Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH 02/37] iommu/sva: Bind process address spaces to devices
To: "joro@8bytes.org" <joro@8bytes.org>,
 Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
 <20180212183352.22730-3-jean-philippe.brucker@arm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D191002897@SHSMSX101.ccr.corp.intel.com>
 <b9eacb30-817f-9027-bc0a-1f01cf9f13f9@arm.com>
 <20180215102113.c7t7rrnyzgazmdli@8bytes.org>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <88f5a22a-6db9-f34b-916b-83cd6e683ceb@amd.com>
Date: Thu, 15 Feb 2018 13:29:34 +0100
MIME-Version: 1.0
In-Reply-To: <20180215102113.c7t7rrnyzgazmdli@8bytes.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <Mark.Rutland@arm.com>,
 "xieyisheng1@huawei.com" <xieyisheng1@huawei.com>,
 "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
 mykyta.iziumtsev@linaro.org, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "xuzaibo@huawei.com" <xuzaibo@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 Will Deacon <Will.Deacon@arm.com>,
 "okaya@codeaurora.org" <okaya@codeaurora.org>, "Liu,
 Yi L" <yi.l.liu@intel.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 "Raj, Ashok" <ashok.raj@intel.com>, "tn@semihalf.com" <tn@semihalf.com>,
 "robdclark@gmail.com" <robdclark@gmail.com>,
 "bharatku@xilinx.com" <bharatku@xilinx.com>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 Catalin Marinas <Catalin.Marinas@arm.com>,
 "rfranz@cavium.com" <rfranz@cavium.com>, "lenb@kernel.org" <lenb@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "Tian,
 Kevin" <kevin.tian@intel.com>,
 "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "thunder.leizhen@huawei.com" <thunder.leizhen@huawei.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "shunyong.yang@hxt-semitech.com" <shunyong.yang@hxt-semitech.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "liubo95@huawei.com" <liubo95@huawei.com>,
 "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
 "jcrouse@codeaurora.org" <jcrouse@codeaurora.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>,
 Sudeep Holla <Sudeep.Holla@arm.com>, Robin Murphy <Robin.Murphy@arm.com>,
 "nwatters@codeaurora.org" <nwatters@codeaurora.org>
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

QW0gMTUuMDIuMjAxOCB1bSAxMToyMSBzY2hyaWViIGpvcm9AOGJ5dGVzLm9yZzoKPiBPbiBUdWUs
IEZlYiAxMywgMjAxOCBhdCAxMjo1NzoyM1BNICswMDAwLCBKZWFuLVBoaWxpcHBlIEJydWNrZXIg
d3JvdGU6Cj4+ICogYmluZF9kZXZpY2UoKSBmYWlscyBpZiB0aGUgZGV2aWNlJ3MgZ3JvdXAgaGFz
IG1vcmUgdGhhbiBvbmUgZGV2aWNlLAo+PiBvdGhlcndpc2UgY2FsbHMgX19iaW5kX2RldmljZSgp
LiBUaGlzIHByZXZlbnRzIGRldmljZSBkcml2ZXJzIHRoYXQgYXJlCj4+IG9ibGl2aW91cyB0byBJ
T01NVSBncm91cHMgZnJvbSBvcGVuaW5nIGEgYmFja2Rvb3IuCj4+Cj4+ICogYmluZF9ncm91cCgp
IGNhbGxzIF9fYmluZF9kZXZpY2UoKSBmb3IgYWxsIGRldmljZXMgaW4gZ3JvdXAuIFRoaXMgd2F5
Cj4+IHVzZXJzIHRoYXQgYXJlIGF3YXJlIG9mIElPTU1VIGdyb3VwcyBjYW4gc3RpbGwgdXNlIHRo
ZW0gc2FmZWx5LiBOb3RlIHRoYXQKPj4gYXQgdGhlIG1vbWVudCBiaW5kX2dyb3VwKCkgZmFpbHMg
YXMgc29vbiBhcyBpdCBmaW5kcyBhIGRldmljZSB0aGF0IGRvZXNuJ3QKPj4gc3VwcG9ydCBTVkEu
IEhhdmluZyBhbGwgZGV2aWNlcyBzdXBwb3J0IFNWQSBpbiBhIGdpdmVuIGdyb3VwIGlzCj4+IHVu
cmVhbGlzdGljIGFuZCB0aGlzIGJlaGF2aW9yIG91Z2h0IHRvIGJlIGltcHJvdmVkLgo+IFllYWgs
IHNvIHRoZSBwcm9ibGVtIG9uIFBDSSBpcyB0aGF0IGFsbCBmdW5jdGlvbnMgb2YgYSBtdWx0aS1m
dW5jdGlvbgo+IGRldmljZSBhcmUgcHV0IGludG8gb25lIGdyb3VwLiBGb3IgQU1ELUdQVXMgdGhp
cyBtZWFucyB0aGF0IHRoZSBHUFUKPiAoU1ZBLWNhcGFibGUpIHdpbGwgZW5kIHVwIGluIHRoZSBz
YW1lIGdyb3VwIGFzIHRoZSBvbi1HUFUgc291bmQKPiBkZXZpY2UgKG5vdCBTVkEtY2FwYWJsZSku
CgpZZWFoLCBidXQgU1ZBIG9ubHkgYXBwbGllcyB0byByYXRoZXIgbmV3IEFNRC1HUFVzLCB3aGlj
aCBpbiB0dXJuIGNhbiAKb25seSBkbyBQQ0llIGFuZCB0aGVyZSB0aGUgcHJvYmxlbSBkb2Vzbid0
IHNlZW1zIHRvIGV4aXN0IGFueSBtb3JlLgoKRS5nLiB0aGUgYXVkaW8gZGV2aWNlIG9uIG15IFZl
Z2ExMCBnZXRzIGEgc2VwYXJhdGUgZ3JvdXAgZGVzcGl0ZSBiZWluZyAKYmVoaW5kIHNldmVyYWwg
YnJpZGdlczoKPiAwYjowMC4wIFZHQSBjb21wYXRpYmxlIGNvbnRyb2xsZXI6IEFkdmFuY2VkIE1p
Y3JvIERldmljZXMsIEluYy4gCj4gW0FNRC9BVEldIFZlZ2EgMTAgW1JhZGVvbiBWZWdhIEZyb250
aWVyIEVkaXRpb25dCj4gMGI6MDAuMSBBdWRpbyBkZXZpY2U6IEFkdmFuY2VkIE1pY3JvIERldmlj
ZXMsIEluYy4gW0FNRC9BVEldIERldmljZSBhYWY4Ci4uLgo+IFvCoMKgwqAgNi4zNjI2NjVdIGlv
bW11OiBBZGRpbmcgZGV2aWNlIDAwMDA6MGI6MDAuMCB0byBncm91cCAxNAo+IFvCoMKgwqAgNi4z
Njg0NjhdIGlvbW11OiBVc2luZyBkaXJlY3QgbWFwcGluZyBmb3IgZGV2aWNlIDAwMDA6MGI6MDAu
MAo+IFvCoMKgwqAgNi4zODAwNDBdIGlvbW11OiBBZGRpbmcgZGV2aWNlIDAwMDA6MGI6MDAuMSB0
byBncm91cCAxNQoKUmVnYXJkcywKQ2hyaXN0aWFuLgoKPgo+IEJlZm9yZSB0aGlzIGNhdXNlcyB1
cyBiaWcgaGVhZGFjaGVzIEkgc3VnZ2VzdCB0byBvbmx5IHByb3ZpZGUgdGhlCj4gYmluZF9kZXZp
Y2UoKSBmdW5jdGlvbi4gVGhpcyBzaG91bGQgYmUgZmluZSBiZWNhdXNlIGZvciBTVkEgd2UgZG9u
J3QKPiBuZWVkIGFsbCB0eXBlcyBvZiBpc29sYXRpb24gdGhhdCBpb21tdV9ncm91cHMgcHJvdmlk
ZS4KPgo+IElPTU1VLWdyb3VwcyBwcm92aWRlIHR3byB0eXBlcyBvZiBpc29sYXRpb246Cj4KPiAJ
MSkgVGhleSBncm91cCBkZXZpY2VzIHRvZ2V0aGVyIHdoaWNoIHRoZSBJT01NVSBjYW4ndCBkaXN0
aW5ndWlzaAo+IAkgICBmcm9tIGVhY2ggb3RoZXIsIGxpa2UgUENJIGRldmljZXMgYmVoaW5kIGEg
UENJZSBicmlkZ2UuCj4KPiAJMikgRGV2aWNlcyB0aGF0IGNhbid0IGJlIGlzb2xhdGVkIGZyb20g
ZWFjaCBvdGhlciBhcmUgYWxzbyBwdXQKPiAJICAgaW50byB0aGUgc2FtZSBncm91cC4gVGhpcyBp
cyB0aGUgY2FzZSBmb3IgbXVsdGktZnVuY3Rpb24gUENJZQo+IAkgICBkZXZpY2VzIGFzIHdlbGwg
YXMgYWxsIFBDSWUgZGV2aWNlcyBiZWhpbmQgYSBub24tQUNTIGJyaWRnZS4KPiAJICAgQnV0IGFs
bCB0aGVzZSBkZXZpY2VzIGNhbm4gc3RpbGwgYmUgZGlzdGluZ3Vpc2hlZCBieSB0aGUKPiAJICAg
SU9NTVUuCj4KPiBUaGVzZSB0d28gdHlwZXMgb2YgcHJvdGVjdGlvbiBhcmUgbmVlZGVkIHRvIHNh
ZmVseSBhc3NpZ24gZGV2aWNlcyB0bwo+IGd1ZXN0cywgYnV0IGZvciBiYXJlLW1ldGFsIFNWQSBh
bGwgd2UgbmVlZCBpcyB0eXBlIDEpIGlzb2xhdGlvbiwgYW5kCj4gbm90IGV2ZW4gdGhhdCBpZiB3
ZSBjYW4gYXNzdW1lIHRoYXQgYWxsIFNWQS1jYXBhYmxlIGRldmljZXMgaGF2ZSBhbgo+IGV4Y2x1
c2l2ZSBkZXZpY2UtaWQgKG9yIHN0cmVhbS1pZCkuCj4KPgo+Cj4gCUpvZXJnCj4KCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVs
IG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
