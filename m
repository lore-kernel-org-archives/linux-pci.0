Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH v2 01/40] iommu: Introduce Shared Virtual Addressing API
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <20180511190641.23008-1-jean-philippe.brucker@arm.com>
 <20180511190641.23008-2-jean-philippe.brucker@arm.com>
 <bf42affd-e9d0-e4fc-6d28-f3c3f7795348@redhat.com>
 <03d31ba5-1eda-ea86-8c0c-91d14c86fe83@arm.com>
 <ed39159c-087e-7e56-7d29-d1de9fa1677f@amd.com>
 <f0b317d5-e2e9-5478-952c-05e8b97bd68b@arm.com>
 <2fd4a0a1-1a35-bf82-df84-b995cce011d9@amd.com>
 <65e7accd-4446-19f5-c667-c6407e89cfa6@arm.com>
 <5bbc0332-b94b-75cc-ca42-a9b196811daf@amd.com>
 <20180907142504.5034351e@jacob-builder>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <3e3a6797-a233-911b-3a7d-d9b549160960@amd.com>
Date: Sat, 8 Sep 2018 09:29:13 +0200
MIME-Version: 1.0
In-Reply-To: <20180907142504.5034351e@jacob-builder>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "xieyisheng1@huawei.com" <xieyisheng1@huawei.com>,
 "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "xuzaibo@huawei.com" <xuzaibo@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 Will Deacon <Will.Deacon@arm.com>, Michal Hocko <mhocko@kernel.org>,
 "okaya@codeaurora.org" <okaya@codeaurora.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "ashok.raj@intel.com" <ashok.raj@intel.com>,
 Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
 "tn@semihalf.com" <tn@semihalf.com>, "joro@8bytes.org" <joro@8bytes.org>,
 "robdclark@gmail.com" <robdclark@gmail.com>,
 "bharatku@xilinx.com" <bharatku@xilinx.com>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "liudongdong3@huawei.com" <liudongdong3@huawei.com>,
 "rfranz@cavium.com" <rfranz@cavium.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 Auger Eric <eric.auger@redhat.com>,
 "jcrouse@codeaurora.org" <jcrouse@codeaurora.org>,
 "rgummal@xilinx.com" <rgummal@xilinx.com>,
 "thunder.leizhen@huawei.com" <thunder.leizhen@huawei.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "shunyong.yang@hxt-semitech.com" <shunyong.yang@hxt-semitech.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "liubo95@huawei.com" <liubo95@huawei.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Robin Murphy <Robin.Murphy@arm.com>,
 "nwatters@codeaurora.org" <nwatters@codeaurora.org>,
 "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

QW0gMDcuMDkuMjAxOCB1bSAyMzoyNSBzY2hyaWViIEphY29iIFBhbjoKPiBPbiBGcmksIDcgU2Vw
IDIwMTggMjA6MDI6NTQgKzAyMDAKPiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmln
QGFtZC5jb20+IHdyb3RlOgo+PiBbU05JUF0KPj4+IGlvbW11LXN2YSBleHBlY3RzIGV2ZXJ5d2hl
cmUgdGhhdCB0aGUgZGV2aWNlIGhhcyBhbiBpb21tdV9kb21haW4sCj4+PiBpdCdzIHRoZSBmaXJz
dCB0aGluZyB3ZSBjaGVjayBvbiBlbnRyeS4gQnlwYXNzaW5nIGFsbCBvZiB0aGlzIHdvdWxkCj4+
PiBjYWxsIGlkcl9hbGxvYygpIGRpcmVjdGx5LCBhbmQgd291bGRuJ3QgaGF2ZSBhbnkgY29kZSBp
biBjb21tb24KPj4+IHdpdGggdGhlIGN1cnJlbnQgaW9tbXUtc3ZhLiBTbyBpdCBzZWVtcyBsaWtl
IHlvdSBuZWVkIGEgbGF5ZXIgb24KPj4+IHRvcCBvZiBpb21tdS1zdmEgY2FsbGluZyBpZHJfYWxs
b2MoKSB3aGVuIGFuIElPTU1VIGlzbid0IHByZXNlbnQsCj4+PiBidXQgSSBkb24ndCB0aGluayBp
dCBzaG91bGQgYmUgaW4gZHJpdmVycy9pb21tdS8KPj4gSW4gdGhpcyBjYXNlIEkgcXVlc3Rpb24g
aWYgdGhlIFBBU0lEIGhhbmRsaW5nIHNob3VsZCBiZSB1bmRlcgo+PiBkcml2ZXJzL2lvbW11IGF0
IGFsbC4KPj4KPj4gU2VlIEkgY2FuIGhhdmUgYSBtaXggb2YgVk0gY29udGV4dCB3aGljaCBhcmUg
Ym91bmQgdG8gcHJvY2Vzc2VzIChzb21lCj4+IGZldykgYW5kIFZNIGNvbnRleHRzIHdoaWNoIGFy
ZSBzdGFuZGFsb25lIGFuZCBkb2Vzbid0IGNhcmUgZm9yIGEKPj4gcHJvY2VzcyBhZGRyZXNzIHNw
YWNlLiBCdXQgZm9yIGVhY2ggVk0gY29udGV4dCBJIG5lZWQgYSBkaXN0aW5jdAo+PiBQQVNJRCBm
b3IgdGhlIGhhcmR3YXJlIHRvIHdvcmsuCj4+Cj4+IEkgY2FuIGxpdmUgaWYgd2Ugc2F5IGlmIElP
TU1VIGlzIGNvbXBsZXRlbHkgZGlzYWJsZWQgd2UgdXNlIGEgc2ltcGxlCj4+IGlkYSB0byBhbGxv
Y2F0ZSB0aGVtLCBidXQgd2hlbiBJT01NVSBpcyBlbmFibGVkIEkgY2VydGFpbmx5IG5lZWQgYQo+
PiB3YXkgdG8gcmVzZXJ2ZSBhIFBBU0lEIHdpdGhvdXQgYW4gYXNzb2NpYXRlZCBwcm9jZXNzLgo+
Pgo+IFZULWQgd291bGQgYWxzbyBoYXZlIHN1Y2ggcmVxdWlyZW1lbnQuIFRoZXJlIGlzIGEgdmly
dHVhbCBjb21tYW5kCj4gcmVnaXN0ZXIgZm9yIGFsbG9jYXRlIGFuZCBmcmVlIFBBU0lEIGZvciBW
TSB1c2UuIFdoZW4gdGhhdCBQQVNJRAo+IGFsbG9jYXRpb24gcmVxdWVzdCBnZXRzIHByb3BhZ2F0
ZWQgdG8gdGhlIGhvc3QgSU9NTVUgZHJpdmVyLCB3ZSBuZWVkIHRvCj4gYWxsb2NhdGUgUEFTSUQg
dy9vIG1tLgo+Cj4gSWYgdGhlIFBBU0lEIGFsbG9jYXRpb24gaXMgZG9uZSB2aWEgVkZJTywgY2Fu
IHdlIGhhdmUgRkQgdG8gdHJhY2sgUEFTSUQKPiBsaWZlIGN5Y2xlIGluc3RlYWQgb2YgbW1fZXhp
dCgpPyBpLmUuIGFsbCBGRHMgZ2V0IGNsb3NlZCBiZWZvcmUKPiBtbV9leGl0LCBJIGFzc3VtZT8K
ClllcywgZXhhY3RseS4gSSBqdXN0IG5lZWQgYSBQQVNJRCB3aGljaCBpcyBuZXZlciB1c2VkIGJ5
IHRoZSBPUyBmb3IgYSAKcHJvY2VzcyBhbmQgd2UgY2FuIGVhc2lseSBnaXZlIHRoYXQgYmFjayB3
aGVuIHRoZSBsYXN0IEZEIHJlZmVyZW5jZSBpcyAKY2xvc2VkLgoKPj4+PiAzLiBFdmVuIGFmdGVy
IGRlc3RydWN0aW9uIG9mIGEgcHJvY2VzcyBhZGRyZXNzIHNwYWNlIHdlIG5lZWQgc29tZQo+Pj4+
IGdyYWNlIHBlcmlvZCBiZWZvcmUgYSBQQVNJRCBpcyByZXVzZWQgYmVjYXVzZSBpdCBjYW4gYmUg
dGhhdCB0aGUKPj4+PiBzcGVjaWZpYyBQQVNJRCBpcyBzdGlsbCBpbiBzb21lIGhhcmR3YXJlIHF1
ZXVlcyBldGMuLi4KPj4+PiAgICDCoMKgwqAgwqDCoMKgIEF0IGJhcmUgbWluaW11bSBhbGwgZGV2
aWNlIGRyaXZlcnMgdXNpbmcgcHJvY2VzcyBiaW5kaW5nCj4+Pj4gbmVlZCB0byBleHBsaWNpdGx5
IG5vdGUgdG8gdGhlIGNvcmUgd2hlbiB0aGV5IGFyZSBkb25lIHdpdGggYQo+Pj4+IFBBU0lELgo+
Pj4gUmlnaHQsIG11Y2ggb2YgdGhlIGhvcnJpYmxlbmVzcyBpbiBpb21tdS1zdmEgZGVhbHMgd2l0
aCB0aGlzOgo+Pj4KPj4+IFRoZSBwcm9jZXNzIGRpZXMsIGlvbW11LXN2YSBpcyBub3RpZmllZCBh
bmQgY2FsbHMgdGhlIG1tX2V4aXQoKQo+Pj4gZnVuY3Rpb24gcGFzc2VkIGJ5IHRoZSBkZXZpY2Ug
ZHJpdmVyIHRvIGlvbW11X3N2YV9kZXZpY2VfaW5pdCgpLiBJbgo+Pj4gbW1fZXhpdCgpIHRoZSBk
ZXZpY2UgZHJpdmVyIG5lZWRzIHRvIGNsZWFyIGFueSByZWZlcmVuY2UgdG8gdGhlCj4+PiBQQVNJ
RCBpbiBoYXJkd2FyZSBhbmQgaW4gaXRzIG93biBzdHJ1Y3R1cmVzLiBXaGVuIHRoZSBkZXZpY2Ug
ZHJpdmVyCj4+PiByZXR1cm5zIGZyb20gbW1fZXhpdCgpLCBpdCBlZmZlY3RpdmVseSB0ZWxscyB0
aGUgY29yZSB0aGF0IGl0IGhhcwo+Pj4gZmluaXNoZWQgdXNpbmcgdGhlIFBBU0lELCBhbmQgaW9t
bXUtc3ZhIGNhbiByZXVzZSB0aGUgUEFTSUQgZm9yCj4+PiBhbm90aGVyIHByb2Nlc3MuIG1tX2V4
aXQoKSBpcyBhbGxvd2VkIHRvIGJsb2NrLCBzbyB0aGUgZGV2aWNlCj4+PiBkcml2ZXIgaGFzIHRp
bWUgdG8gY2xlYW4gdXAgYW5kIGZsdXNoIHRoZSBxdWV1ZXMuCj4+Pgo+Pj4gSWYgdGhlIGRldmlj
ZSBkcml2ZXIgZmluaXNoZXMgdXNpbmcgdGhlIFBBU0lEIGJlZm9yZSB0aGUgcHJvY2Vzcwo+Pj4g
ZXhpdHMsIGl0IGp1c3QgY2FsbHMgdW5iaW5kKCkuCj4+IEV4YWN0bHkgdGhhdCdzIHdoYXQgTWlj
aGFsIEhvY2tvIGlzIHByb2JhYmx5IGdvaW5nIHRvIG5vdCBsaWtlIGF0IGFsbC4KPj4KPj4gQ2Fu
IHdlIGhhdmUgYSBkaWZmZXJlbnQgYXBwcm9hY2ggd2hlcmUgZWFjaCBkcml2ZXIgaXMgaW5mb3Jt
ZWQgYnkgdGhlCj4+IG1tX2V4aXQoKSwgYnV0IG5lZWRzIHRvIGV4cGxpY2l0bHkgY2FsbCB1bmJp
bmQoKSBiZWZvcmUgYSBQQVNJRCBpcwo+PiByZXVzZWQ/Cj4+Cj4+IER1cmluZyB0aGF0IHRlYXJk
b3duIHRyYW5zaXRpb24gaXQgd291bGQgYmUgaWRlYWwgaWYgdGhhdCBQQVNJRCBvbmx5Cj4+IHBv
aW50cyB0byBhIGR1bW15IHJvb3QgcGFnZSBkaXJlY3Rvcnkgd2l0aCBvbmx5IGludmFsaWQgZW50
cmllcy4KPj4KPiBJIGd1ZXNzIHRoaXMgY2FuIGJlIHZlbmRvciBzcGVjaWZpYywgSW4gVlQtZCBJ
IHBsYW4gdG8gbWFyayBQQVNJRAo+IGVudHJ5IG5vdCBwcmVzZW50IGFuZCBkaXNhYmxlIGZhdWx0
IHJlcG9ydGluZyB3aGlsZSBkcmFpbmluZyByZW1haW5pbmcKPiBhY3Rpdml0aWVzLgoKU291bmRz
IGdvb2QgdG8gbWUuCgpQb2ludCBpcyBhdCBsZWFzdCBpbiB0aGUgY2FzZSB3aGVyZSB0aGUgcHJv
Y2VzcyB3YXMga2lsbGVkIGJ5IHRoZSBPT00gCmtpbGxlciB3ZSBzaG91bGQgbm90IGJsb2NrIGlu
IG1tX2V4aXQoKS4KCkluc3RlYWQgb3BlcmF0aW9ucyBpc3N1ZWQgYnkgdGhlIHByb2Nlc3MgdG8g
YSBkZXZpY2UgZHJpdmVyIHdoaWNoIHVzZXMgClNWQSBuZWVkcyB0byBiZSB0ZXJtaW5hdGVkIGFz
IHNvb24gYXMgcG9zc2libGUgdG8gbWFrZSBzdXJlIHRoYXQgdGhlIE9PTSAKa2lsbGVyIGNhbiBh
ZHZhbmNlLgoKVGhhbmtzLApDaHJpc3RpYW4uCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1h
cm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
