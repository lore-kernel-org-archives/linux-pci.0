Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Fri, 2 Mar 2018 16:42:25 +0000
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Lu Baolu <baolu.lu@linux.intel.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH 03/37] iommu/sva: Manage process address spaces
Message-ID: <ebd22a3b-8507-8fd1-3efb-357931613c47@arm.com>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
 <20180212183352.22730-4-jean-philippe.brucker@arm.com>
 <5A97A324.9050605@linux.intel.com>
 <cd4d7a98-e45e-7066-345f-52d8eef926a2@amd.com>
MIME-Version: 1.0
In-Reply-To: <cd4d7a98-e45e-7066-345f-52d8eef926a2@amd.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <Mark.Rutland@arm.com>,
 "bharatku@xilinx.com" <bharatku@xilinx.com>,
 "ashok.raj@intel.com" <ashok.raj@intel.com>,
 "shunyong.yang@hxt-semitech.com" <shunyong.yang@hxt-semitech.com>,
 "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
 Catalin Marinas <Catalin.Marinas@arm.com>,
 "xuzaibo@huawei.com" <xuzaibo@huawei.com>,
 "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
 Will Deacon <Will.Deacon@arm.com>,
 "okaya@codeaurora.org" <okaya@codeaurora.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, Sudeep Holla <Sudeep.Holla@arm.com>,
 "rfranz@cavium.com" <rfranz@cavium.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "lenb@kernel.org" <lenb@kernel.org>
Content-Type: text/plain; charset="utf-8"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

T24gMDEvMDMvMTggMDg6MDQsIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gQW0gMDEuMDMuMjAx
OCB1bSAwNzo1MiBzY2hyaWViIEx1IEJhb2x1Ogo+PiBIaSBKZWFuLAo+Pgo+PiBPbiAwMi8xMy8y
MDE4IDAyOjMzIEFNLCBKZWFuLVBoaWxpcHBlIEJydWNrZXIgd3JvdGU6Cj4+PiBbU05JUF0KPj4+
ICsJcGFzaWQgPSBpZHJfYWxsb2NfY3ljbGljKCZpb21tdV9wYXNpZF9pZHIsIGlvX21tLCBkZXZf
cGFyYW0tPm1pbl9wYXNpZCwKPj4+ICsJCQkJIGRldl9wYXJhbS0+bWF4X3Bhc2lkICsgMSwgR0ZQ
X0FUT01JQyk7Cj4+IENhbiB0aGUgcGFzaWQgbWFuYWdlbWVudCBjb2RlIGJlIG1vdmVkIGludG8g
YSBjb21tb24gbGlicmFyeT8KPj4gUEFTSUQgaXMgbm90IHN0aWNrIHRvIFNWQS4gQW4gSU9NTVUg
bW9kZWwgZGV2aWNlIGNvdWxkIGJlIGRlc2lnbmVkCj4+IHRvIHVzZSBQQVNJRCBmb3Igc2Vjb25k
IGxldmVsIHRyYW5zbGF0aW9uIChjbGFzc2ljYWwgRE1BIHRyYW5zbGF0aW9uKQo+PiBhcyB3ZWxs
Lgo+IAo+IFllYWgsIHdlIGhhdmUgdGhlIHNhbWUgcHJvYmxlbSBvbiBhbWRncHUuCj4gCj4gV2Ug
YXNzaWduIFBBU0lEcyB0byBjbGllbnRzIGV2ZW4gd2hlbiBJT01NVSBpc24ndCBwcmVzZW50IGlu
IHRoZSBzeXN0ZW0gCj4ganVzdCBiZWNhdXNlIHdlIG5lZWQgaXQgZm9yIGRlYnVnZ2luZy4KPiAK
PiBFLmcuIHdoZW4gdGhlIGhhcmR3YXJlIGRldGVjdHMgdGhhdCBzb21lIHNoYWRlciBwcm9ncmFt
IGlzIGRvaW5nIAo+IHNvbWV0aGluZyBuYXN0eSB3ZSBnZXQgdGhlIFBBU0lEIGluIHRoZSBpbnRl
cnJ1cHQgYW5kIGNvdWxkIGZvciBleGFtcGxlIAo+IHVzZSBpdCB0byBpbmZvcm0gdGhlIGNsaWVu
dCBhYm91dCB0aGUgZmF1bHQuCgpUaGlzIHNlZW1zIGxpa2UgYSBuZXcgcmVxdWlyZW1lbnQgYWx0
b2dldGhlciwgYW5kIGEgYml0IG91dHNpZGUgdGhlCnNjb3BlIG9mIHRoaXMgc2VyaWVzIHRvIGJl
IGhvbmVzdC4gSXMgdGhlIGNsaWVudCB1c2Vyc3BhY2UgaW4gdGhpcwpjb250ZXh0PyBJIGd1ZXNz
IGl0IHdvdWxkIGJlIG1vc3RseSBmb3IgcHJvdG90eXBpbmcgdGhlbj8gT3RoZXJ3aXNlIHlvdQpw
cm9iYWJseSBkb24ndCB3YW50IHRvIGhhbmQgR1BVIGNvbnRleHRzIHRvIHVzZXJzcGFjZSB3aXRo
b3V0IGFuIElPTU1VCmlzb2xhdGluZyB0aGVtPwoKSWYgeW91IGRvbid0IG5lZWQgbW0gdHJhY2tp
bmcvc2hhcmluZyBvciBpb21tdV9tYXAvdW5tYXAsIHRoZW4gbWF5YmUgYW4KSURSIHByaXZhdGUg
dG8gdGhlIEdQVSBkcml2ZXIgd291bGQgYmUgZW5vdWdoPyBJZiB5b3UgZG8gbmVlZCBtbQp0cmFj
a2luZywgSSBzdXBwb3NlIHdlIGNvdWxkIG1vZGlmeSBpb21tdV9zdmFfYmluZCgpIHRvIGFsbG9j
YXRlIGFuZAp0cmFjayBpb19tbSBldmVuIGlmIHRoZSBnaXZlbiBkZXZpY2UgZG9lc24ndCBoYXZl
IGFuIElPTU1VLCBidXQgaXQgc2VlbXMKYSBiaXQgYmFja3dhcmQuCgpUaGFua3MsCkplYW4KCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1r
ZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJu
ZWwK
