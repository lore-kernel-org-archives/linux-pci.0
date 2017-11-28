Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [Intel-gfx] [PATCH V3 09/29] drm/i915: deprecate
 pci_get_bus_and_slot()
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
References: <1511801886-6753-1-git-send-email-okaya@codeaurora.org>
 <1511801886-6753-10-git-send-email-okaya@codeaurora.org>
 <20171128153051.GU10981@intel.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <9046d23e-412d-9d9f-147f-a3bc6eea34fc@codeaurora.org>
Date: Tue, 28 Nov 2017 11:29:44 -0500
MIME-Version: 1.0
In-Reply-To: <20171128153051.GU10981@intel.com>
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

T24gMTEvMjgvMjAxNyAxMDozMCBBTSwgVmlsbGUgU3lyasOkbMOkIHdyb3RlOgo+PiArCWRldl9w
cml2LT5icmlkZ2VfZGV2ID0KPj4gKwkJcGNpX2dldF9kb21haW5fYnVzX2FuZF9zbG90KGRvbWFp
biwgMCwgUENJX0RFVkZOKDAsIDApKTsKPiBNYXliZSBqdXN0IHBjaV9nZXRfc2xvdChwZGV2LT5i
dXMsIFBDSV9ERVZGTigwLCAwKSkgPwo+IAo+IEkgZ3Vlc3MgaWYgd2Ugd2FudCB0byBiZSBwZWRh
bnRpYyB3ZSBjb3VsZCBnbyBmb3I6Cj4gCj4gYnVzID0gcGNpX2ZpbmRfaG9zdF9icmlkZ2UocGRl
di0+YnVzKS0+YnVzOwo+IHBjaV9nZXRfc2xvdChidXMsIFBDSV9ERVZGTigwLCAwKSkKPiAKPiBi
dXQgSSB0aGluayB0aGUgR1BVIHNob3VsZCBhbHdheXMgYmUgb24gdGhlIHJvb3QgYnVzLCBzbyB0
aGUgc2ltcGxlcgo+IGZvcm0gc2hvdWxkIGJlIGZpbmUuCj4gCgpBbGwgdGhyZWUgb2YgdGhlc2Ug
c2hvdWxkIGJlIGNvcnJlY3QuIAoKSSdsbCB1c2UgcGNpX2dldF9zbG90KHBkZXYtPmJ1cywgUENJ
X0RFVkZOKDAsIDApKSBhcyB5b3Ugc3VnZ2VzdGVkLgoKLS0gClNpbmFuIEtheWEKUXVhbGNvbW0g
RGF0YWNlbnRlciBUZWNobm9sb2dpZXMsIEluYy4gYXMgYW4gYWZmaWxpYXRlIG9mIFF1YWxjb21t
IFRlY2hub2xvZ2llcywgSW5jLgpRdWFsY29tbSBUZWNobm9sb2dpZXMsIEluYy4gaXMgYSBtZW1i
ZXIgb2YgdGhlIENvZGUgQXVyb3JhIEZvcnVtLCBhIExpbnV4IEZvdW5kYXRpb24gQ29sbGFib3Jh
dGl2ZSBQcm9qZWN0LgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8vbGludXgtYXJtLWtlcm5lbAo=
