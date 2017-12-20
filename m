Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH 1/4] pci: dwc: pci-dra7xx: Enable errata i870 for both EP
 and RC mode
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, KISHON VIJAY ABRAHAM
 <kishon@ti.com>
References: <20171201061311.16691-1-vigneshr@ti.com>
 <20171201061311.16691-2-vigneshr@ti.com> <20171219162421.GD21501@red-moon>
From: Vignesh R <vigneshr@ti.com>
Message-ID: <fa536894-fac6-feea-e973-268ff5a6389d@ti.com>
Date: Wed, 20 Dec 2017 09:45:45 +0530
MIME-Version: 1.0
In-Reply-To: <20171219162421.GD21501@red-moon>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Tony Lindgren <tony@atomide.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Chris Welch <Chris.Welch@viavisolutions.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

CgpPbiBUdWVzZGF5IDE5IERlY2VtYmVyIDIwMTcgMDk6NTQgUE0sIExvcmVuem8gUGllcmFsaXNp
IHdyb3RlOgo+IE9uIEZyaSwgRGVjIDAxLCAyMDE3IGF0IDExOjQzOjA4QU0gKzA1MzAsIFZpZ25l
c2ggUiB3cm90ZToKPj4gRXJyYXRhIGk4NzAgaXMgYXBwbGljYWJsZSBpbiBib3RoIEVQIGFuZCBS
QyBtb2RlLiBUaGVyZWZvcmUgcmVuYW1lCj4+IGZ1bmN0aW9uIGRyYTd4eF9wY2llX2VwX3VuYWxp
Z25lZF9tZW1hY2Nlc3MoKSwgdGhhdCBpbXBsZW1lbnRzIGVycmF0YQo+PiB3b3JrYXJvdW5kLCB0
byBkcmE3eHhfcGNpZV91bmFsaWduZWRfbWVtYWNjZXNzKCkgYW5kIGNhbGwgaXQgZnJvbSBhCj4+
IGNvbW1vbiBwbGFjZS4gU28sIHRoYXQgZXJyYXRhIHdvcmthcm91bmQgaXMgYXBwbGllZCBmb3Ig
Ym90aCBtb2RlcyBvZgo+PiBvcGVyYXRpb24uCj4+IAo+PiBSZXBvcnRlZC1ieTogQ2hyaXMgV2Vs
Y2ggPENocmlzLldlbGNoQHZpYXZpc29sdXRpb25zLmNvbT4KPj4gU2lnbmVkLW9mZi1ieTogVmln
bmVzaCBSIDx2aWduZXNockB0aS5jb20+Cj4+IC0tLQo+PsKgIGRyaXZlcnMvcGNpL2R3Yy9wY2kt
ZHJhN3h4LmMgfCAxMiArKysrKystLS0tLS0KPj7CoCAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRp
b25zKCspLCA2IGRlbGV0aW9ucygtKQo+IAo+IEkgbmVlZCBLaXNob24ncyBBQ0sgdG8gYXBwbHkg
aXQsIHRoYW5rcy4KClRoZXJlIGFyZSBzb21lIGVuaGFuY2VtZW50cyB0byB0aGlzIHBhdGNoLiBX
aWxsIHN1Ym1pdCBhIHYyIHNob3J0bHkuClBsZWFzZSBpZ25vcmUgdGhpcyB2ZXJzaW9uIGZvciBu
b3cuIFRoYW5rcyEKCgotLSAKUmVnYXJkcwpWaWduZXNoCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdAps
aW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVh
ZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
