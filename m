Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Message-ID: <1532343774.3501.8.camel@pengutronix.de>
Subject: Re: [PATCH v2 2/3] reset: imx7: Fix always writing bits as 0
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Lucas Stach <l.stach@pengutronix.de>, Leonard Crestez
 <leonard.crestez@nxp.com>, Richard Zhu <hongxing.zhu@nxp.com>, Andrey
 Smirnov <andrew.smirnov@gmail.com>
Date: Mon, 23 Jul 2018 13:02:54 +0200
In-Reply-To: <1532338865.3163.95.camel@pengutronix.de>
References: <cover.1532090446.git.leonard.crestez@nxp.com>
 <54f436a1d2a11a379af642a3327312367ef95343.1532090446.git.leonard.crestez@nxp.com>
 <1532338865.3163.95.camel@pengutronix.de>
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

T24gTW9uLCAyMDE4LTA3LTIzIGF0IDExOjQxICswMjAwLCBMdWNhcyBTdGFjaCB3cm90ZToKPiBB
cyB0aGlzIGRvZXNuJ3QgZGVwZW5kIG9uIGFueSBvdGhlciBwYXRjaCBpbiB0aGlzIHNlcmllcywg
SSB0aGluayBpdAo+IHdvdWxkIGJlIGZpbmUgaWYgUGhpbGlwcMKgdGFrZXMgdGhpcyBwYXRjaCB0
aHJvdWdoIHRoZSByZXNldCB0cmVlLgo+IAo+IFJlZ2FyZHMsCj4gTHVjYXMKPiAKPiBBbSBGcmVp
dGFnLCBkZW4gMjAuMDcuMjAxOCwgMTU6NDcgKzAzMDAgc2NocmllYiBMZW9uYXJkIENyZXN0ZXo6
Cj4gPiBSaWdodCBub3cgdGhlIG9ubHkgdXNlciBvZiByZXNldC1pbXg3IGlzIHBjaS1pbXg2IGFu
ZCB0aGUKPiA+IHJlc2V0X2NvbnRyb2xfYXNzZXJ0IGFuZCBkZWFzc2VydCBjYWxscyBvbiBwY2ll
cGh5X3Jlc2V0IGRvbid0IHRvZ2dsZQo+ID4gdGhlIFBDSUVQSFlfQlROIGFuZCBQQ0lFUEhZX0df
UlNUIGJpdHMgYXMgZXhwZWN0ZWQuIEZpeCB0aGlzIGJ5IHdyaXRpbmcKPiA+IDEgb3IgMCByZXNw
ZWN0aXZlbHkuCj4gPiAKPiA+IFRoZSByZWZlcmVuY2UgbWFudWFsIGlzIG5vdCB2ZXJ5IGNsZWFy
IHJlZ2FyZGluZyBTUkNfUENJRVBIWV9SQ1IgYnV0IGZvcgo+ID4gb3RoZXIgcmVnaXN0ZXJzIGxp
a2UgTUlQSVBIWSBhbmQgSFNJQ1BIWSB0aGUgYml0cyBhcmUgZXhwbGljaXRseQo+ID4gZG9jdW1l
bnRlZCBhcyAiMSBtZWFucyBhc3NlcnQsIDAgbWVhbnMgZGVhc3NlcnQiLgo+ID4gCj4gPiBUaGUg
dmFsdWVzIGFyZSBzdGlsbCByZXZlcnNlZCBmb3IgSU1YN19SRVNFVF9QQ0lFX0NUUkxfQVBQU19F
Ti4KPiA+IAo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBMZW9uYXJkIENyZXN0ZXogPGxlb25hcmQuY3Jl
c3RlekBueHAuY29tPgo+ID4gPiBSZXZpZXdlZC1ieTogTHVjYXMgU3RhY2ggPGwuc3RhY2hAcGVu
Z3V0cm9uaXguZGU+CgpUaGFuayB5b3UsIGFwcGxpZWQgdG8gcmVzZXQvZml4ZXMuCgpyZWdhcmRz
ClBoaWxpcHAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xp
bnV4LWFybS1rZXJuZWwK
