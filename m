Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH 2/2] PCI: armada8k: Fix clock resource by adding a
 register clock
References: <20180228144704.12947-1-gregory.clement@bootlin.com>
 <20180228144704.12947-3-gregory.clement@bootlin.com>
 <20180228152756.GV9418@n2100.armlinux.org.uk>
Date: Wed, 28 Feb 2018 16:31:16 +0100
In-Reply-To: <20180228152756.GV9418@n2100.armlinux.org.uk> (Russell King's
 message of "Wed, 28 Feb 2018 15:27:57 +0000")
Message-ID: <878tbdf7wb.fsf@bootlin.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Andrew Lunn <andrew@lunn.ch>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Jason Cooper <jason@lakedaemon.net>,
 Antoine Tenart <antoine.tenart@bootlin.com>, linux-pci@vger.kernel.org,
 Hanna Hawa <hannah@marvell.com>, Omri Itach <omrii@marvell.com>,
 Nadav Haklai <nadavh@marvell.com>, Shadi Ammouri <shadi@marvell.com>,
 linux-arm-kernel@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 =?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@bootlin.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Marcin Wojtas <mw@semihalf.com>,
 Igal Liberman <igall@marvell.com>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="utf-8"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

SGkgUnVzc2VsbCBLaW5nLAogCiBPbiBtZXIuLCBmw6l2ci4gMjggMjAxOCwgUnVzc2VsbCBLaW5n
IC0gQVJNIExpbnV4IDxsaW51eEBhcm1saW51eC5vcmcudWs+IHdyb3RlOgoKPiBPbiBXZWQsIEZl
YiAyOCwgMjAxOCBhdCAwMzo0NzowNFBNICswMTAwLCBHcmVnb3J5IENMRU1FTlQgd3JvdGU6Cj4+
IEBAIC0yMjksNiArMjMwLDE1IEBAIHN0YXRpYyBpbnQgYXJtYWRhOGtfcGNpZV9wcm9iZShzdHJ1
Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQo+PiAgCWlmIChyZXQpCj4+ICAJCXJldHVybiByZXQ7
Cj4+ICAKPj4gKwlpZiAoSVNfRVJSKHBjaWUtPmNsa19yZWcpICYmIFBUUl9FUlIocGNpZS0+Y2xr
X3JlZykgPT0gLUVQUk9CRV9ERUZFUikgewo+Cj4gWW91IGRvIHJlYWxpc2UgdGhpcyBpcyBuZWVk
bGVzc2x5IGNvbXBsZXguCj4KPiBQb2ludGVyIGVycm9ycyBhcmUgdW5pcXVlLCBzbzoKPgo+IAlp
ZiAocGNpZS0+Y2xrX3JlZyA9PSBFUlJfUFRSKC1FUFJPQkVfREVGRVIpKSB7Cj4KPiB3aWxsIGRv
IHRoZSBzYW1lIHRoaW5nIGJ1dCB3aXRob3V0IHRoZSBjb21wbGV4aXR5LiAgVHJhbnNmb3JtaW5n
IHRoZQo+IGNvbnN0YW50IHJhdGhlciB0aGFuIHRoZSB2YXJpYWJsZSBpcyBhbHNvIGEgZ29vZCBo
YWJiaXQgdG8gZ2V0IGludG8gLQo+IHRoZSBjb21waWxlciBjYW4gb3B0aW1pc2UgdHJhbnNmb3Jt
cyB0byBjb25zdGFudHMsIGJ1dCBjYW4ndCB3aXRoCj4gdmFyaWFibGVzLCBzbyBjb21wYXJpc29u
cyBpbnZvbHZpbmcgdGhpbmdzIGxpa2UgZW5kaWFuIGNvbnZlcnNpb24KPiBzaG91bGQgYWx3YXlz
IGJlIGRvbmUgYnkgdHJhbnNmb3JtaW5nIHRoZSBjb25zdGFudCBub3QgdGhlIHZhcmlhYmxlLgoK
VGhhbmtzIGZvciB0aGUgdGlwLCBJIHdpbGwgdXNlIGl0IGluIHRoZSBuZXh0IHZlcnNpb24uCgpH
cmVnb3J5Cgo+Cj4gLS0gCj4gUk1LJ3MgUGF0Y2ggc3lzdGVtOiBodHRwOi8vd3d3LmFybWxpbnV4
Lm9yZy51ay9kZXZlbG9wZXIvcGF0Y2hlcy8KPiBGVFRDIGJyb2FkYmFuZCBmb3IgMC44bWlsZSBs
aW5lIGluIHN1YnVyYmlhOiBzeW5jIGF0IDguOE1icHMgZG93biA2MzBrYnBzIHVwCj4gQWNjb3Jk
aW5nIHRvIHNwZWVkdGVzdC5uZXQ6IDguMjFNYnBzIGRvd24gNTEwa2JwcyB1cAoKLS0gCkdyZWdv
cnkgQ2xlbWVudCwgQm9vdGxpbiAoZm9ybWVybHkgRnJlZSBFbGVjdHJvbnMpCkVtYmVkZGVkIExp
bnV4IGFuZCBLZXJuZWwgZW5naW5lZXJpbmcKaHR0cDovL2Jvb3RsaW4uY29tCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1h
aWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
