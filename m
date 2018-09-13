Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: =?iso-8859-1?Q?Jan_Kundr=E1t?= <jan.kundrat@cesnet.cz>
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [BISECTED] Regression: Solidrun Clearfog Base won't boot since
 =?iso-8859-1?Q?"PCI:_mvebu:_Only_remap_I/O_space_if_configured"?=
Date: Thu, 13 Sep 2018 10:20:45 +0200
MIME-Version: 1.0
Message-ID: <5ad46fec-a71a-477a-b23f-d20aacfb481d@cesnet.cz>
In-Reply-To: <20180913094515.351967bb@windsurf>
References: <61fdfd69-2bb6-478c-b0d5-69d8744adae3@cesnet.cz>
 <87zhwm4kl6.fsf@tkos.co.il> <20180912231050.GX30658@n2100.armlinux.org.uk>
 <20180913094515.351967bb@windsurf>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Baruch Siach <baruch@tkos.co.il>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Jason Cooper <jason@lakedaemon.net>, linux-pci@vger.kernel.org,
 Russell King - ARM Linux <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

T24gxI10dnJ0ZWsgMTMuIHrDocWZw60gMjAxOCA5OjQ1OjE1IENFU1QsIFRob21hcyBQZXRhenpv
bmkgd3JvdGU6Cj4gV2hhdCBhYm91dCBzb21ldGhpbmcgbGlrZSB0aGUgYmVsb3cuIEkgdGVzdGVk
IGl0LCBpbmNsdWRpbmcgdGhlIGVycm9yCj4gY2FzZSBieSBmb3JjaW5nIGFuIC1FUFJPQkVfREVG
RVIuIFRoZSBuZXcgcGNpX3VubWFwX2lvKCkgaXMgbW9kZWxlZAo+IGFmdGVyIHBjaV91bm1hcF9p
b3NwYWNlKCkuIEFjdHVhbGx5LCBJIHdvdWxkIHByZWZlciB0byB1c2UKPiBwY2lfcmVtYXBfaW9z
cGFjZSgpIGFuZCBwY2lfdW5tYXBfaW9zcGFjZSgpIGJ1dCBmb3Igbm93IHRoaXMgQVBJCj4gZG9l
c24ndCBhbGxvdyBvdmVybG9hZGluZyB0aGUgbWVtb3J5IHR5cGUgdXNlZCBmb3IgdGhlIG1hcHBp
bmcuCgpUaGFua3MgZm9yIHByb3ZpZGluZyB0aGlzIGZpeCBzbyBxdWlja2x5LCBUaG9tYXMuIEkg
Y2FuIGNvbmZpcm0gdGhhdCB0aGlzIApwYXRjaCAtLSB0ZXN0ZWQgb24gdG9wIG9mIDU0ZWRhOWRm
MTdmMzIxNWI5ZWQxNjYyOWVlNzFlYTA3NDEzZWZkYWYgKCJNZXJnZSAKdGFnICdwY2ktdjQuMTkt
Zml4ZXMtMScgb2YgCmdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dp
dC9oZWxnYWFzL3BjaSIpLiBEaXNjbGFpbWVyOiBJIApoYXZlIHplcm8gZmFtaWxpYXJpdHkgd2l0
aCBMaW51eCcgUENJIGNvZGUuCgpUZXN0ZWQtYnk6IEphbiBLdW5kcsOhdCA8amFuLmt1bmRyYXRA
Y2VzbmV0LmN6PgoKV2l0aCBraW5kIHJlZ2FyZHMsCkphbgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QK
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRl
YWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
