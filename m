Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [RESEND PATCH v3 4/7] PCI: dwc: all: Modify dbi accessors to take
 dbi_base as argument
To: Kishon Vijay Abraham I <kishon@ti.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Joao Pinto <Joao.Pinto@synopsys.com>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <1489041545-15730-1-git-send-email-kishon@ti.com>
 <1489041545-15730-5-git-send-email-kishon@ti.com>
 <4e13580d-2625-5eed-bcbc-2ffd7493b073@axis.com>
 <595fab62-fb7a-888a-f898-7b59030585f1@axis.com> <58C28FCC.4070100@ti.com>
From: Niklas Cassel <niklas.cassel@axis.com>
Message-ID: <789eb88c-982e-9581-49a6-a337251bf781@axis.com>
Date: Fri, 10 Mar 2017 13:23:23 +0100
MIME-Version: 1.0
In-Reply-To: <58C28FCC.4070100@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Richard Zhu <hongxing.zhu@nxp.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 Jingoo Han <jingoohan1@gmail.com>, nsekhar@ti.com,
 Jesper Nilsson <jespern@axis.com>, Zhou Wang <wangzhou1@hisilicon.com>,
 Murali Karicheri <m-karicheri2@ti.com>, Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="utf-8"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

T24gMDMvMTAvMjAxNyAxMjozNiBQTSwgS2lzaG9uIFZpamF5IEFicmFoYW0gSSB3cm90ZToKPiBI
aSwKPgo+IE9uIFRodXJzZGF5IDA5IE1hcmNoIDIwMTcgMDg6MzUgUE0sIE5pa2xhcyBDYXNzZWwg
d3JvdGU6Cj4+Cj4+IE9uIDAzLzA5LzIwMTcgMDM6NDggUE0sIE5pa2xhcyBDYXNzZWwgd3JvdGU6
Cj4+PiBPbiAwMy8wOS8yMDE3IDA3OjM5IEFNLCBLaXNob24gVmlqYXkgQWJyYWhhbSBJIHdyb3Rl
Ogo+Pj4+IGR3YyBoYXMgMiBkYmkgYWRkcmVzcyBzcGFjZSBsYWJlbGVkIGRiaWNzIGFuZCBkYmlj
czIuIFRoZSBleGlzdGluZwo+Pj4+IGhlbHBlciB0byBhY2Nlc3MgZGJpIGFkZHJlc3Mgc3BhY2Ug
Y2FuIGFjY2VzcyBvbmx5IGRiaWNzLiBIb3dldmVyCj4+Pj4gZGJpY3MyIGhhcyB0byBiZSBhY2Nl
c3NlZCBmb3IgcHJvZ3JhbW1pbmcgdGhlIEJBUiByZWdpc3RlcnMgaW4gdGhlCj4+Pj4gY2FzZSBv
ZiBFUCBtb2RlLiBUaGlzIGlzIGluIHByZXBhcmF0aW9uIGZvciBhZGRpbmcgRVAgbW9kZSBzdXBw
b3J0Cj4+Pj4gdG8gZHdjIGRyaXZlci4KPj4+IEhlbGxvIEtpc2hvbgo+Pj4KPj4+IEkgZG9uJ3Qg
cmVhbGx5IGxpa2UgdGhlIGlkZWEgb2YgYWRkaW5nIGFuIGV4dHJhIGFyZ3VtZW50IHRvIGV2ZXJ5
IGV4aXN0aW5nIHJlYWQvd3JpdGUuCj4+PiBXaWxsIG5vdCBhIHJlYWQvd3JpdGUgdXNpbmcgZGJp
MiBiZSBxdWl0ZSB1bmNvbW1vbiBjb21wYXJlZCB0byBhIHJlYWQvd3JpdGUKPj4+IHVzaW5nIGRi
aT8KPj4+Cj4+PiBIb3cgYWJvdXQgc29tZXRoaW5nIGxpa2UgdGhpczoKPj4+Cj4+PiB2b2lkIF9f
ZHdfcGNpZV93cml0ZWwoc3RydWN0IGR3X3BjaWUgKnBjaSwgdm9pZCBfX2lvbWVtICpiYXNlLCB1
MzIgcmVnLCB1MzIgdmFsKQo+Pj4gewo+Pj4gICAgIGlmIChwY2ktPm9wcy0+d3JpdGVsX2RiaSkK
Pj4+ICAgICAgICAgcGNpLT5vcHMtPndyaXRlbF9kYmkocGNpLCBiYXNlLCByZWcsIHZhbCk7eMKR
V8KhUn8KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxp
bnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4
LWFybS1rZXJuZWwK
