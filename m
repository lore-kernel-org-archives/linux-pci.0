Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: "Jingoo Han" <jingoohan1@gmail.com>
To: "'Joao Pinto'" <Joao.Pinto@synopsys.com>,
 "'Bjorn Andersson'" <bjorn.andersson@linaro.org>
References: <20170716063947.3272-1-bjorn.andersson@linaro.org>
 <73b9c442-38f6-cc5b-c6e0-4ce7187dc0a8@synopsys.com>
In-Reply-To: <73b9c442-38f6-cc5b-c6e0-4ce7187dc0a8@synopsys.com>
Subject: Re: [PATCH 1/3] PCI: dwc: Handle host_init failures
Date: Mon, 17 Jul 2017 15:28:13 -0400
Message-ID: <000a01d2ff32$d5d59e00$8180da00$@gmail.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "'open list:PCI DRIVER FOR TI DRA7XX'" <linux-pci@vger.kernel.org>,
 'Binghui Wang' <wangbinghui@hisilicon.com>,
 "'open list:PCIE DRIVER FOR AXIS ARTPEC'" <linux-arm-kernel@axis.com>,
 'Jesper Nilsson' <jesper.nilsson@axis.com>,
 "'moderated list:PCI DRIVER FOR SAMSUNG EXYNOS'"
 <linux-samsung-soc@vger.kernel.org>,
 'Pratyush Anand' <pratyush.anand@gmail.com>,
 'Krzysztof Kozlowski' <krzk@kernel.org>,
 'Kishon Vijay Abraham I' <kishon@ti.com>, 'Kukjin Kim' <kgene@kernel.org>,
 'Xiaowei Song' <songxiaowei@hisilicon.com>,
 'Richard Zhu' <hongxing.zhu@nxp.com>,
 "'open list:PCIE DRIVER FOR QUALCOMM MSM'" <linux-arm-msm@vger.kernel.org>,
 'Niklas Cassel' <niklas.cassel@axis.com>,
 'Murali Karicheri' <m-karicheri2@ti.com>,
 'Bjorn Helgaas' <bhelgaas@google.com>, 'Mingkai Hu' <mingkai.hu@freescale.com>,
 "'open list:PCI DRIVER FOR TI DRA7XX'" <linux-omap@vger.kernel.org>,
 "'moderated list:PCI DRIVER FOR SAMSUNG EXYNOS'"
 <linux-arm-kernel@lists.infradead.org>,
 'Thomas Petazzoni' <thomas.petazzoni@free-electrons.com>,
 "'open list:PCI DRIVER FOR FREESCALE LAYERSCAPE'"
 <linuxppc-dev@lists.ozlabs.org>, 'open list' <linux-kernel@vger.kernel.org>,
 'Stanimir Varbanov' <svarbanov@mm-sol.com>,
 'Minghuan Lian' <minghuan.Lian@freescale.com>,
 'Roy Zang' <tie-fei.zang@freescale.com>,
 'Lucas Stach' <l.stach@pengutronix.de>
Content-Type: text/plain; charset="utf-8"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

T24gTW9uZGF5LCBKdWx5IDE3LCAyMDE3IDc6MTggQU0sIEpvYW8gUGludG8gd3JvdGU6Cj4gCj4g
SGkgQmpvcm4gQW5kZXJzc29uLAo+IAo+IMOAcyA3OjM5IEFNIGRlIDcvMTYvMjAxNywgQmpvcm4g
QW5kZXJzc29uIGVzY3JldmV1Ogo+ID4gSW4gc2V2ZXJhbCBkd2MgYmFzZWQgZHJpdmVycyBob3N0
X2luaXQgY2FuIGZhaWwsIHNvIG1ha2Ugc3VyZSB0bwo+ID4gcHJvcGFnYXRlIGFuZCBoYW5kbGUg
dGhpcyB0byBhdm9pZCBjb250aW51aW5nIG9wZXJhdGlvbiBvZiBhIGRyaXZlciBvcgo+ID4gaGFy
ZHdhcmUgaW4gYW4gaW52YWxpZCBzdGF0ZS4KPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBCam9ybiBB
bmRlcnNzb24gPGJqb3JuLmFuZGVyc3NvbkBsaW5hcm8ub3JnPgo+ID4gLS0tCj4gPiAgZHJpdmVy
cy9wY2kvZHdjL3BjaS1kcmE3eHguYyAgICAgICAgICAgfCAgNCArKystCj4gPiAgZHJpdmVycy9w
Y2kvZHdjL3BjaS1leHlub3MuYyAgICAgICAgICAgfCAgNCArKystCj4gPiAgZHJpdmVycy9wY2kv
ZHdjL3BjaS1pbXg2LmMgICAgICAgICAgICAgfCAgNCArKystCj4gPiAgZHJpdmVycy9wY2kvZHdj
L3BjaS1rZXlzdG9uZS5jICAgICAgICAgfCAgNCArKystCj4gPiAgZHJpdmVycy9wY2kvZHdjL3Bj
aS1sYXllcnNjYXBlLmMgICAgICAgfCAxNCArKysrKysrKysrLS0tLQo+ID4gIGRyaXZlcnMvcGNp
L2R3Yy9wY2llLWFybWFkYThrLmMgICAgICAgIHwgIDQgKysrLQo+ID4gIGRyaXZlcnMvcGNpL2R3
Yy9wY2llLWFydHBlYzYuYyAgICAgICAgIHwgIDQgKysrLQo+ID4gIGRyaXZlcnMvcGNpL2R3Yy9w
Y2llLWRlc2lnbndhcmUtaG9zdC5jIHwgIDcgKysrKystLQo+ID4gIGRyaXZlcnMvcGNpL2R3Yy9w
Y2llLWRlc2lnbndhcmUtcGxhdC5jIHwgIDQgKysrLQo+ID4gIGRyaXZlcnMvcGNpL2R3Yy9wY2ll
LWRlc2lnbndhcmUuaCAgICAgIHwgIDIgKy0KPiA+ICBkcml2ZXJzL3BjaS9kd2MvcGNpZS1raXJp
bi5jICAgICAgICAgICB8ICA0ICsrKy0KPiA+ICBkcml2ZXJzL3BjaS9kd2MvcGNpZS1xY29tLmMg
ICAgICAgICAgICB8ICA2ICsrKystLQo+ID4gIGRyaXZlcnMvcGNpL2R3Yy9wY2llLXNwZWFyMTN4
eC5jICAgICAgIHwgIDQgKysrLQo+ID4gIDEzIGZpbGVzIGNoYW5nZWQsIDQ3IGluc2VydGlvbnMo
KyksIDE4IGRlbGV0aW9ucygtKQo+ID4KClsuLi4uLl0KCj4gCj4gQSBzdGVwIGluIHRoZSByaWdo
dCBkaXJlY3Rpb24gOikuIEluIHRoZSBmdXR1cmUgd2Ugc2hvdWxkIGFkZCBob3N0IGluaXQKPiB2
YWxpZGF0aW9uIGluIHRoZSBzcGVjaWZpYyBTb0MgZHJpdmVycywgbGlrZSBMYXllcnNjYXBlIGFu
ZCBRY29tIGhhdmUsIHRvCj4gYXNzdXJlCj4gdGhhdCBhbnkgcHJvYmxlbSBpcyB0cmVhdGVkIHBy
b3Blcmx5IGluIHRoZSBjb3JlIGRyaXZlci4KCkkgYWdyZWUgd2l0aCB5b3VyIG9waW5pb24uCgo+
IAo+IEFja2VkLWJ5OiBKb2FvIFBpbnRvIDxqcGludG9Ac3lub3BzeXMuY29tPgoKQWNrZWQtYnk6
IEppbmdvbyBIYW4gPGppbmdvb2hhbjFAZ21haWwuY29tPgoKQmVzdCByZWdhcmRzLApKaW5nb28g
SGFuCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGlu
dXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRl
YWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgt
YXJtLWtlcm5lbAo=
