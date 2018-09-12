Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 12 Sep 2018 20:50:52 +0200
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: Baruch Siach <baruch@tkos.co.il>
Subject: Re: [BISECTED] Regression: Solidrun Clearfog Base won't boot since
 "PCI: mvebu: Only remap I/O space if configured"
Message-ID: <20180912205052.19de01a0@windsurf>
In-Reply-To: <87zhwm4kl6.fsf@tkos.co.il>
References: <61fdfd69-2bb6-478c-b0d5-69d8744adae3@cesnet.cz>
 <87zhwm4kl6.fsf@tkos.co.il>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Jason Cooper <jason@lakedaemon.net>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Jan =?UTF-8?B?S3VuZHLDoXQ=?= <jan.kundrat@cesnet.cz>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

SmFuLCBCYXJ1Y2gsCgpPbiBXZWQsIDEyIFNlcCAyMDE4IDIxOjQ5OjQxICswMzAwLCBCYXJ1Y2gg
U2lhY2ggd3JvdGU6Cgo+IEphbiBLdW5kcsOhdCB3cml0ZXM6Cj4gPiBzaW5jZSBjb21taXQgZWUx
NjA0MzgxYTM3MWIzZWE2YWVjN2Q1ZTQzYjZlM2Y1ZTE1Mzg1NCAoIlBDSTogbXZlYnU6IE9ubHkK
PiA+IHJlbWFwIEkvTyBzcGFjZSBpZiBjb25maWd1cmVkIiksIG15IGJvYXJkIChTb2xpZHJ1biBD
bGVhcmZvZyBCYXNlKSB3b24ndAo+ID4gZmluaXNoIGJvb3Rpbmcgd2l0aCA0LjE4LXJjMyB3b24n
dCBib290OiAgCj4gCj4gWW91IG1lYW4gJzQuMTktcmMzJywgcmlnaHQ/Cj4gCj4gPj4gWyAgICAx
Ljc0MTQ1OF0gSW50ZXJuYWwgZXJyb3I6IE9vcHMgLSB1bmRlZmluZWQgaW5zdHJ1Y3Rpb246IDAg
WyMxXSBTTVAgQVJNCj4gPj4gWyAgICAxLjc0ODE4Ml0gQ1BVOiAxIFBJRDogNzIgQ29tbToga3dv
cmtlci8xOjIgVGFpbnRlZDogRyAgICAgICAgVyAgICAgICAgIDQuMTkuMC1yYzMgIzEgIAo+IAo+
IFRoZSAnVycgdGFpbnQgbWVhbnMgdGhhdCB0aGVyZSB3YXMgYSBrZXJuZWwgd2FybmluZyBiZWZv
cmUuIFdoaWNoCj4gd2FybmluZyB3YXMgdGhhdD8KPiAKPiBJIHJlcHJvZHVjZWQgdGhlIHNhbWUg
T29wcyBvbiBDbGVhcmZvZyBCYXNlIHdpdGhvdXQgYW55IHRhaW50OgoKVGhhbmtzIGZvciB0aGUg
cmVwb3J0LCBJJ2xsIGhhdmUgYSBsb29rIHRvbW9ycm93IHdoZW4gSSBoYXZlIHRvCkNsZWFyRm9n
IGhhcmR3YXJlLgoKVGhhbmtzLAoKVGhvbWFzCi0tIApUaG9tYXMgUGV0YXp6b25pLCBDVE8sIEJv
b3RsaW4KRW1iZWRkZWQgTGludXggYW5kIEtlcm5lbCBlbmdpbmVlcmluZwpodHRwczovL2Jvb3Rs
aW4uY29tCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwps
aW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJh
ZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51
eC1hcm0ta2VybmVsCg==
