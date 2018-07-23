Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Message-ID: <1532338865.3163.95.camel@pengutronix.de>
Subject: Re: [PATCH v2 2/3] reset: imx7: Fix always writing bits as 0
From: Lucas Stach <l.stach@pengutronix.de>
To: Leonard Crestez <leonard.crestez@nxp.com>, Richard Zhu
 <hongxing.zhu@nxp.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Philipp
 Zabel <p.zabel@pengutronix.de>
Date: Mon, 23 Jul 2018 11:41:05 +0200
In-Reply-To: <54f436a1d2a11a379af642a3327312367ef95343.1532090446.git.leonard.crestez@nxp.com>
References: <cover.1532090446.git.leonard.crestez@nxp.com>
 <54f436a1d2a11a379af642a3327312367ef95343.1532090446.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Dong Aisheng <aisheng.dong@nxp.com>, Joao Pinto <Joao.Pinto@synopsys.com>,
 linux-pm@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>,
 linux-kernel@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-imx@nxp.com,
 kernel@pengutronix.de, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Shawn Guo <shawnguo@kernel.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

QXMgdGhpcyBkb2Vzbid0IGRlcGVuZCBvbiBhbnkgb3RoZXIgcGF0Y2ggaW4gdGhpcyBzZXJpZXMs
IEkgdGhpbmsgaXQKd291bGQgYmUgZmluZSBpZiBQaGlsaXBwwqB0YWtlcyB0aGlzIHBhdGNoIHRo
cm91Z2ggdGhlIHJlc2V0IHRyZWUuCgpSZWdhcmRzLApMdWNhcwoKQW0gRnJlaXRhZywgZGVuIDIw
LjA3LjIwMTgsIDE1OjQ3ICswMzAwIHNjaHJpZWIgTGVvbmFyZCBDcmVzdGV6Ogo+IFJpZ2h0IG5v
dyB0aGUgb25seSB1c2VyIG9mIHJlc2V0LWlteDcgaXMgcGNpLWlteDYgYW5kIHRoZQo+IHJlc2V0
X2NvbnRyb2xfYXNzZXJ0IGFuZCBkZWFzc2VydCBjYWxscyBvbiBwY2llcGh5X3Jlc2V0IGRvbid0
IHRvZ2dsZQo+IHRoZSBQQ0lFUEhZX0JUTiBhbmQgUENJRVBIWV9HX1JTVCBiaXRzIGFzIGV4cGVj
dGVkLiBGaXggdGhpcyBieSB3cml0aW5nCj4gMSBvciAwIHJlc3BlY3RpdmVseS4KPiAKPiBUaGUg
cmVmZXJlbmNlIG1hbnVhbCBpcyBub3QgdmVyeSBjbGVhciByZWdhcmRpbmcgU1JDX1BDSUVQSFlf
UkNSIGJ1dCBmb3IKPiBvdGhlciByZWdpc3RlcnMgbGlrZSBNSVBJUEhZIGFuZCBIU0lDUEhZIHRo
ZSBiaXRzIGFyZSBleHBsaWNpdGx5Cj4gZG9jdW1lbnRlZCBhcyAiMSBtZWFucyBhc3NlcnQsIDAg
bWVhbnMgZGVhc3NlcnQiLgo+IAo+IFRoZSB2YWx1ZXMgYXJlIHN0aWxsIHJldmVyc2VkIGZvciBJ
TVg3X1JFU0VUX1BDSUVfQ1RSTF9BUFBTX0VOLgo+IAo+ID4gU2lnbmVkLW9mZi1ieTogTGVvbmFy
ZCBDcmVzdGV6IDxsZW9uYXJkLmNyZXN0ZXpAbnhwLmNvbT4KPiA+IFJldmlld2VkLWJ5OiBMdWNh
cyBTdGFjaCA8bC5zdGFjaEBwZW5ndXRyb25peC5kZT4KPiAtLS0KPiDCoGRyaXZlcnMvcmVzZXQv
cmVzZXQtaW14Ny5jIHwgMiArLQo+IMKgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAx
IGRlbGV0aW9uKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcmVzZXQvcmVzZXQtaW14Ny5j
IGIvZHJpdmVycy9yZXNldC9yZXNldC1pbXg3LmMKPiBpbmRleCA0ZGIxNzdiYzg5YmMuLmZkZWFj
MTk0NjQyOSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3Jlc2V0L3Jlc2V0LWlteDcuYwo+ICsrKyBi
L2RyaXZlcnMvcmVzZXQvcmVzZXQtaW14Ny5jCj4gQEAgLTc4LDExICs3OCwxMSBAQCBzdGF0aWMg
c3RydWN0IGlteDdfc3JjICp0b19pbXg3X3NyYyhzdHJ1Y3QgcmVzZXRfY29udHJvbGxlcl9kZXYg
KnJjZGV2KQo+IMKgc3RhdGljIGludCBpbXg3X3Jlc2V0X3NldChzdHJ1Y3QgcmVzZXRfY29udHJv
bGxlcl9kZXYgKnJjZGV2LAo+ID4gwqAJCQnCoMKgdW5zaWduZWQgbG9uZyBpZCwgYm9vbCBhc3Nl
cnQpCj4gwqB7Cj4gPiDCoAlzdHJ1Y3QgaW14N19zcmMgKmlteDdzcmMgPSB0b19pbXg3X3NyYyhy
Y2Rldik7Cj4gPiDCoAljb25zdCBzdHJ1Y3QgaW14N19zcmNfc2lnbmFsICpzaWduYWwgPSAmaW14
N19zcmNfc2lnbmFsc1tpZF07Cj4gPiAtCXVuc2lnbmVkIGludCB2YWx1ZSA9IDA7Cj4gPiArCXVu
c2lnbmVkIGludCB2YWx1ZSA9IGFzc2VydCA/IHNpZ25hbC0+Yml0IDogMDsKPiDCoAo+ID4gwqAJ
c3dpdGNoIChpZCkgewo+ID4gwqAJY2FzZSBJTVg3X1JFU0VUX1BDSUVQSFk6Cj4gPiDCoAkJLyoK
PiA+IMKgCQnCoCogd2FpdCBmb3IgbW9yZSB0aGFuIDEwdXMgdG8gcmVsZWFzZSBwaHkgZ19yc3Qg
YW5kCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51
eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1h
cm0ta2VybmVsCg==
