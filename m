Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Message-ID: <1528467832.26356.18.camel@pengutronix.de>
Subject: Re: [PATCH 1/2] reset: imx7: Fix always writing bits as 0
From: Lucas Stach <l.stach@pengutronix.de>
To: Leonard Crestez <leonard.crestez@nxp.com>, Andrey Smirnov
 <andrew.smirnov@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, Richard
 Zhu <hongxing.zhu@nxp.com>, linux-pci@vger.kernel.org,
 linux-pm@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Date: Fri, 08 Jun 2018 16:23:52 +0200
In-Reply-To: <c441872d7dd355ae09e945447441389e93e3b888.1527621510.git.leonard.crestez@nxp.com>
References: <cover.1527621510.git.leonard.crestez@nxp.com>
 <c441872d7dd355ae09e945447441389e93e3b888.1527621510.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Abel Vesa <abel.vesa@nxp.com>, Anson Huang <Anson.Huang@nxp.com>,
 Jingoo Han <jingoohan1@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Joao Pinto <Joao.Pinto@synopsys.com>, Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="utf-8"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

QW0gRGllbnN0YWcsIGRlbiAyOS4wNS4yMDE4LCAyMjozOSArMDMwMCBzY2hyaWViIExlb25hcmQg
Q3Jlc3RlejoKPiBSaWdodCBub3cgdGhlIG9ubHkgdXNlciBvZiByZXNldC1pbXg3IGlzIHBjaS1p
bXg2IGFuZCB0aGUKPiByZXNldF9jb250cm9sX2Fzc2VydCBhbmQgZGVhc3NlcnQgY2FsbHMgb24g
cGNpZXBoeV9yZXNldCBkb24ndCB0b2dnbGUKPiB0aGUgUENJRVBIWV9CVE4gYW5kIFBDSUVQSFlf
R19SU1QgYml0cyBhcyBleHBlY3RlZC4gRml4IHRoaXMgYnkgd3JpdGluZwo+IDEgb3IgMCByZXNw
ZWN0aXZlbHkuCj4gCj4gVGhlIHJlZmVyZW5jZSBtYW51YWwgaXMgbm90IHZlcnkgY2xlYXIgcmVn
YXJkaW5nIFNSQ19QQ0lFUEhZX1JDUiBidXQgZm9yCj4gb3RoZXIgcmVnaXN0ZXJzIGxpa2UgTUlQ
SVBIWSBhbmQgSFNJQ1BIWSB0aGUgYml0cyBhcmUgZXhwbGljaXRseQo+IGRvY3VtZW50ZWQgYXMg
IjEgbWVhbnMgYXNzZXJ0LCAwIG1lYW5zIGRlYXNzZXJ0Ii4KPiAKPiBUaGUgdmFsdWVzIGFyZSBz
dGlsbCByZXZlcnNlZCBmb3IgSU1YN19SRVNFVF9QQ0lFX0NUUkxfQVBQU19FTi4KPiAKPiBTaWdu
ZWQtb2ZmLWJ5OiBMZW9uYXJkIENyZXN0ZXogPGxlb25hcmQuY3Jlc3RlekBueHAuY29tPgoKUmV2
aWV3ZWQtYnk6IEx1Y2FzIFN0YWNoIDxsLnN0YWNoQHBlbmd1dHJvbml4LmRlPgoKPiAtLS0KPiDC
oGRyaXZlcnMvcmVzZXQvcmVzZXQtaW14Ny5jIHwgMiArLQo+IMKgMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcmVz
ZXQvcmVzZXQtaW14Ny5jIGIvZHJpdmVycy9yZXNldC9yZXNldC1pbXg3LmMKPiBpbmRleCA0ZGIx
NzdiYzg5YmMuLmZkZWFjMTk0NjQyOSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3Jlc2V0L3Jlc2V0
LWlteDcuYwo+ICsrKyBiL2RyaXZlcnMvcmVzZXQvcmVzZXQtaW14Ny5jCj4gQEAgLTc4LDExICs3
OCwxMSBAQCBzdGF0aWMgc3RydWN0IGlteDdfc3JjICp0b19pbXg3X3NyYyhzdHJ1Y3QgcmVzZXRf
Y29udHJvbGxlcl9kZXYgKnJjZGV2KQo+IMKgc3RhdGljIGludCBpbXg3X3Jlc2V0X3NldChzdHJ1
Y3QgcmVzZXRfY29udHJvbGxlcl9kZXYgKnJjZGV2LAo+ID4gwqAJCQnCoMKgdW5zaWduZWQgbG9u
ZyBpZCwgYm9vbCBhc3NlcnQpCj4gwqB7Cj4gPiDCoAlzdHJ1Y3QgaW14N19zcmMgKmlteDdzcmMg
PSB0b19pbXg3X3NyYyhyY2Rldik7Cj4gPiDCoAljb25zdCBzdHJ1Y3QgaW14N19zcmNfc2lnbmFs
ICpzaWduYWwgPSAmaW14N19zcmNfc2lnbmFsc1tpZF07Cj4gPiAtCXVuc2lnbmVkIGludCB2YWx1
ZSA9IDA7Cj4gPiArCXVuc2lnbmVkIGludCB2YWx1ZSA9IGFzc2VydCA/IHNpZ25hbC0+Yml0IDog
MDsKPiDCoAo+ID4gwqAJc3dpdGNoIChpZCkgewo+ID4gwqAJY2FzZSBJTVg3X1JFU0VUX1BDSUVQ
SFk6Cj4gPiDCoAkJLyoKPiA+IMKgCQnCoCogd2FpdCBmb3IgbW9yZSB0aGFuIDEwdXMgdG8gcmVs
ZWFzZSBwaHkgZ19yc3QgYW5kCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVs
QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
