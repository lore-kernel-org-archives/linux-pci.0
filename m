Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [Intel-gfx] [PATCH V3 09/29] drm/i915: deprecate
 pci_get_bus_and_slot()
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
References: <1511801886-6753-1-git-send-email-okaya@codeaurora.org>
 <1511801886-6753-10-git-send-email-okaya@codeaurora.org>
 <20171128153051.GU10981@intel.com>
 <9046d23e-412d-9d9f-147f-a3bc6eea34fc@codeaurora.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <ad60832e-a0bd-007f-293f-dc5ad3e629d5@codeaurora.org>
Date: Sun, 3 Dec 2017 14:29:03 -0500
MIME-Version: 1.0
In-Reply-To: <9046d23e-412d-9d9f-147f-a3bc6eea34fc@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
 timur@codeaurora.org, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

T24gMTEvMjgvMjAxNyAxMToyOSBBTSwgU2luYW4gS2F5YSB3cm90ZToKPiBPbiAxMS8yOC8yMDE3
IDEwOjMwIEFNLCBWaWxsZSBTeXJqw6Rsw6Qgd3JvdGU6Cj4+PiArCWRldl9wcml2LT5icmlkZ2Vf
ZGV2ID0KPj4+ICsJCXBjaV9nZXRfZG9tYWluX2J1c19hbmRfc2xvdChkb21haW4sIDAsIFBDSV9E
RVZGTigwLCAwKSk7Cj4+IE1heWJlIGp1c3QgcGNpX2dldF9zbG90KHBkZXYtPmJ1cywgUENJX0RF
VkZOKDAsIDApKSA/Cj4+Cj4+IEkgZ3Vlc3MgaWYgd2Ugd2FudCB0byBiZSBwZWRhbnRpYyB3ZSBj
b3VsZCBnbyBmb3I6Cj4+Cj4+IGJ1cyA9IHBjaV9maW5kX2hvc3RfYnJpZGdlKHBkZXYtPmJ1cykt
PmJ1czsKPj4gcGNpX2dldF9zbG90KGJ1cywgUENJX0RFVkZOKDAsIDApKQo+Pgo+PiBidXQgSSB0
aGluayB0aGUgR1BVIHNob3VsZCBhbHdheXMgYmUgb24gdGhlIHJvb3QgYnVzLCBzbyB0aGUgc2lt
cGxlcgo+PiBmb3JtIHNob3VsZCBiZSBmaW5lLgo+Pgo+IAo+IEFsbCB0aHJlZSBvZiB0aGVzZSBz
aG91bGQgYmUgY29ycmVjdC4gCj4gCj4gSSdsbCB1c2UgcGNpX2dldF9zbG90KHBkZXYtPmJ1cywg
UENJX0RFVkZOKDAsIDApKSBhcyB5b3Ugc3VnZ2VzdGVkLgo+IAoKTm93IHRoYXQgSSB0aGluayBh
Ym91dCB0aGlzIG1vcmUsIEkgdGhpbmsgbXkgdmVyc2lvbiBpcyBhIHNpbXBsZXIgY2hhbmdlCmFu
ZCBkb2VzIG5vdCBpbnRyb2R1Y2UgIm5ldyBmZWF0dXJlcyIgYnkgYXNzdW1pbmcgR1BVIGFuZCBo
b3N0IHRvIGJlCm9uIHRoZSBzYW1lIGJ1cyBzaW1pbGFyIHRvIHRoZSBvcmlnaW5hbCBjb2RlLiAK
Ck9yaWdpbmFsIGNvZGUgY291bGQgaGF2ZSB1c2VkIHBjaV9nZXRfc2xvdCgpIHRvby4gU2luY2Ug
YWxsIG9mIHRoZW0gYXJlCmNvcnJlY3QsIG1pbmUgaXMgc2xpZ2h0bHkgbW9yZSBjb3JyZWN0OyBJ
J2QgbGlrZSB0byBrZWVwIG1pbmUuCgotLSAKU2luYW4gS2F5YQpRdWFsY29tbSBEYXRhY2VudGVy
IFRlY2hub2xvZ2llcywgSW5jLiBhcyBhbiBhZmZpbGlhdGUgb2YgUXVhbGNvbW0gVGVjaG5vbG9n
aWVzLCBJbmMuClF1YWxjb21tIFRlY2hub2xvZ2llcywgSW5jLiBpcyBhIG1lbWJlciBvZiB0aGUg
Q29kZSBBdXJvcmEgRm9ydW0sIGEgTGludXggRm91bmRhdGlvbiBDb2xsYWJvcmF0aXZlIFByb2pl
Y3QuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51
eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1h
cm0ta2VybmVsCg==
