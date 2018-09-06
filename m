Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH v2 01/40] iommu: Introduce Shared Virtual Addressing API
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Auger Eric <eric.auger@redhat.com>, linux-arm-kernel@lists.infradead.org,
 linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
 devicetree@vger.kernel.org, iommu@lists.linux-foundation.org,
 kvm@vger.kernel.org, linux-mm@kvack.org
References: <20180511190641.23008-1-jean-philippe.brucker@arm.com>
 <20180511190641.23008-2-jean-philippe.brucker@arm.com>
 <bf42affd-e9d0-e4fc-6d28-f3c3f7795348@redhat.com>
 <03d31ba5-1eda-ea86-8c0c-91d14c86fe83@arm.com>
 <ed39159c-087e-7e56-7d29-d1de9fa1677f@amd.com>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <f0b317d5-e2e9-5478-952c-05e8b97bd68b@arm.com>
Date: Thu, 6 Sep 2018 13:45:36 +0100
MIME-Version: 1.0
In-Reply-To: <ed39159c-087e-7e56-7d29-d1de9fa1677f@amd.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: xieyisheng1@huawei.com, ilias.apalodimas@linaro.org, xuzaibo@huawei.com,
 thunder.leizhen@huawei.com, will.deacon@arm.com, okaya@codeaurora.org,
 yi.l.liu@intel.com, ashok.raj@intel.com, tn@semihalf.com, joro@8bytes.org,
 bharatku@xilinx.com, liudongdong3@huawei.com, rfranz@cavium.com,
 kevin.tian@intel.com, jacob.jun.pan@linux.intel.com,
 alex.williamson@redhat.com, rgummal@xilinx.com, jonathan.cameron@huawei.com,
 shunyong.yang@hxt-semitech.com, dwmw2@infradead.org, liubo95@huawei.com,
 jcrouse@codeaurora.org, robdclark@gmail.com, robin.murphy@arm.com,
 nwatters@codeaurora.org, baolu.lu@linux.intel.com
Content-Type: text/plain; charset="utf-8"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

T24gMDYvMDkvMjAxOCAxMjoxMiwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBBbSAwNi4wOS4y
MDE4IHVtIDEzOjA5IHNjaHJpZWIgSmVhbi1QaGlsaXBwZSBCcnVja2VyOgo+PiBIaSBFcmljLAo+
Pgo+PiBUaGFua3MgZm9yIHJldmlld2luZwo+Pgo+PiBPbiAwNS8wOS8yMDE4IDEyOjI5LCBBdWdl
ciBFcmljIHdyb3RlOgo+Pj4+ICtpbnQgaW9tbXVfc3ZhX2RldmljZV9pbml0KHN0cnVjdCBkZXZp
Y2UgKmRldiwgdW5zaWduZWQgbG9uZyBmZWF0dXJlcywKPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgdW5zaWduZWQgaW50IG1heF9wYXNpZCkKPj4+IHdoYXQgYWJvdXQgbWluX3Bhc2lk
Pwo+PiBObyBvbmUgYXNrZWQgZm9yIGl0Li4uIFRoZSBtYXhfcGFzaWQgcGFyYW1ldGVyIGlzIGhl
cmUgZm9yIGRyaXZlcnMgdGhhdAo+PiBoYXZlIHZlbmRvci1zcGVjaWZpYyBQQVNJRCBzaXplIGxp
bWl0cywgc3VjaCBhcyBBTUQgS0ZEIChzZWUKPj4ga2ZkX2lvbW11X2RldmljZV9pbml0IGFuZAo+
PiBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNoLzk5ODkzMDcvIzIxMzg5NTcxKS4g
QnV0IGluIG1vc3QgY2FzZXMKPj4gdGhlIFBBU0lEIHNpemUgd2lsbCBvbmx5IGRlcGVuZCBvbiB0
aGUgUENJIFBBU0lEIGNhcGFiaWxpdHkgYW5kIHRoZQo+PiBJT01NVSBsaW1pdHMsIGJvdGgga25v
d24gYnkgdGhlIElPTU1VIGRyaXZlciwgc28gZGV2aWNlIGRyaXZlcnMgd29uJ3QKPj4gaGF2ZSB0
byBzZXQgbWF4X3Bhc2lkLgo+Pgo+PiBJT01NVSBkcml2ZXJzIG5lZWQgdG8gc2V0IG1pbl9wYXNp
ZCBpbiB0aGUgc3ZhX2RldmljZV9pbml0IGNhbGxiYWNrCj4+IGJlY2F1c2UgaXQgbWF5IGJlIGVp
dGhlciAxIChlLmcuIEFybSB3aGVyZSBQQVNJRCAjMCBpcyByZXNlcnZlZCkgb3IgMAo+PiAoSW50
ZWwgVnQtZCByZXYyKSwgYnV0IGF0IHRoZSBtb21lbnQgSSBjYW4ndCBzZWUgYSByZWFzb24gZm9y
IGRldmljZQo+PiBkcml2ZXJzIHRvIG92ZXJyaWRlIG1pbl9wYXNpZAo+IAo+IFNvcnJ5IHRvIHJ1
aW4geW91ciBkYXksIGJ1dCBpZiBJJ20gbm90IGNvbXBsZXRlbHkgbWlzdGFrZW4gUEFTSUQgemVy
byBpcwo+IHJlc2VydmVkIGluIHRoZSBBTUQgS0ZEIGFzIHdlbGwuCgpIZWgsIGZhaXIgZW5vdWdo
LiBJJ2xsIGFkZCB0aGUgbWluX3Bhc2lkIHBhcmFtZXRlcgoKVGhhbmtzLApKZWFuCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVs
IG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
