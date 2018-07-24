Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Message-ID: <1532451152.32306.8.camel@pengutronix.de>
Subject: Re: [PATCH v3 1/2] Revert "ARM: dts: imx7d: Invert legacy PCI irq
 mapping"
From: Lucas Stach <l.stach@pengutronix.de>
To: Leonard Crestez <leonard.crestez@nxp.com>, Andrey Smirnov
 <andrew.smirnov@gmail.com>, Richard Zhu <hongxing.zhu@nxp.com>, Shawn Guo
 <shawnguo@kernel.org>
Date: Tue, 24 Jul 2018 18:52:32 +0200
In-Reply-To: <ed0ceaa10da805bc79e85ec7d60fcce9d4327066.1532448745.git.leonard.crestez@nxp.com>
References: <cover.1532448745.git.leonard.crestez@nxp.com>
 <ed0ceaa10da805bc79e85ec7d60fcce9d4327066.1532448745.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Dong Aisheng <aisheng.dong@nxp.com>, Joao Pinto <Joao.Pinto@synopsys.com>,
 kernel@pengutronix.de, Anson Huang <Anson.Huang@nxp.com>,
 Jingoo Han <jingoohan1@gmail.com>, linux-kernel@vger.kernel.org,
 Fabio Estevam <fabio.estevam@nxp.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-imx@nxp.com,
 Philipp Zabel <p.zabel@pengutronix.de>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

QW0gRGllbnN0YWcsIGRlbiAyNC4wNy4yMDE4LCAxOToxNCArMDMwMCBzY2hyaWViIExlb25hcmQg
Q3Jlc3RlejoKPiBUaGlzIHJldmVydHMgY29tbWl0IDFjODZjOWRkODJmODU5YjQ3NDQ3NGE3ZmVl
MGQ1MTk1ZGEyYzljMWQuCj4gCj4gVGhhdCBjb21taXQgZm9sbG93ZWQgdGhlIHJlZmVyZW5jZSBt
YW51YWwgYnV0IHVuZm9ydHVuYXRlbHkgdGhlIGlteDdkCj4gbWFudWFsIGlzIGluY29ycmVjdC4K
PiAKPiBUZXN0ZWQgd2l0aCBhdGg5ayBwY2llIGNhcmQgYW5kIGNvbmZpcm1lZCBpbnRlcm5hbGx5
Lgo+IAo+IFNpZ25lZC1vZmYtYnk6IExlb25hcmQgQ3Jlc3RleiA8bGVvbmFyZC5jcmVzdGV6QG54
cC5jb20+CgpBY2tlZC1ieTogTHVjYXMgU3RhY2ggPGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU+Cgo+
IC0tLQo+IMKgYXJjaC9hcm0vYm9vdC9kdHMvaW14N2QuZHRzaSB8IDEyICsrKysrKysrLS0tLQo+
IMKgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKPiAKPiBk
aWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14N2QuZHRzaSBiL2FyY2gvYXJtL2Jvb3Qv
ZHRzL2lteDdkLmR0c2kKPiBpbmRleCA3Y2JjMmZmYTRiM2EuLjcyMzRlODMzMGE1NyAxMDA2NDQK
PiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9pbXg3ZC5kdHNpCj4gKysrIGIvYXJjaC9hcm0vYm9v
dC9kdHMvaW14N2QuZHRzaQo+IEBAIC0xMjQsMTQgKzEyNCwxOCBAQAo+ID4gwqAJCW51bS1sYW5l
cyA9IDwxPjsKPiA+IMKgCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMTIyIElSUV9UWVBFX0xFVkVM
X0hJR0g+Owo+ID4gwqAJCWludGVycnVwdC1uYW1lcyA9ICJtc2kiOwo+ID4gwqAJCSNpbnRlcnJ1
cHQtY2VsbHMgPSA8MT47Cj4gPiDCoAkJaW50ZXJydXB0LW1hcC1tYXNrID0gPDAgMCAwIDB4Nz47
Cj4gPiAtCQlpbnRlcnJ1cHQtbWFwID0gPDAgMCAwIDEgJmludGMgR0lDX1NQSSAxMjIgSVJRX1RZ
UEVfTEVWRUxfSElHSD4sCj4gPiAtCQkJCTwwIDAgMCAyICZpbnRjIEdJQ19TUEkgMTIzIElSUV9U
WVBFX0xFVkVMX0hJR0g+LAo+ID4gLQkJCQk8MCAwIDAgMyAmaW50YyBHSUNfU1BJIDEyNCBJUlFf
VFlQRV9MRVZFTF9ISUdIPiwKPiA+IC0JCQkJPDAgMCAwIDQgJmludGMgR0lDX1NQSSAxMjUgSVJR
X1RZUEVfTEVWRUxfSElHSD47Cj4gPiArCQkvKgo+ID4gKwkJwqAqIFJlZmVyZW5jZSBtYW51YWwg
bGlzdHMgcGNpIGlycXMgaW5jb3JyZWN0bHkKPiA+ICsJCcKgKiBSZWFsIGhhcmR3YXJlIG9yZGVy
aW5nIGlzIHNhbWUgYXMgaW14NjogRCtNU0ksIEMsIEIsIEEKPiA+ICsJCcKgKi8KPiA+ICsJCWlu
dGVycnVwdC1tYXAgPSA8MCAwIDAgMSAmaW50YyBHSUNfU1BJIDEyNSBJUlFfVFlQRV9MRVZFTF9I
SUdIPiwKPiA+ICsJCQkJPDAgMCAwIDIgJmludGMgR0lDX1NQSSAxMjQgSVJRX1RZUEVfTEVWRUxf
SElHSD4sCj4gPiArCQkJCTwwIDAgMCAzICZpbnRjIEdJQ19TUEkgMTIzIElSUV9UWVBFX0xFVkVM
X0hJR0g+LAo+ID4gKwkJCQk8MCAwIDAgNCAmaW50YyBHSUNfU1BJIDEyMiBJUlFfVFlQRV9MRVZF
TF9ISUdIPjsKPiA+IMKgCQljbG9ja3MgPSA8JmNsa3MgSU1YN0RfUENJRV9DVFJMX1JPT1RfQ0xL
PiwKPiA+IMKgCQkJwqA8JmNsa3MgSU1YN0RfUExMX0VORVRfTUFJTl8xMDBNX0NMSz4sCj4gPiDC
oAkJCcKgPCZjbGtzIElNWDdEX1BDSUVfUEhZX1JPT1RfQ0xLPjsKPiA+IMKgCQljbG9jay1uYW1l
cyA9ICJwY2llIiwgInBjaWVfYnVzIiwgInBjaWVfcGh5IjsKPiA+IMKgCQlhc3NpZ25lZC1jbG9j
a3MgPSA8JmNsa3MgSU1YN0RfUENJRV9DVFJMX1JPT1RfU1JDPiwKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBs
aXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5m
cmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
