Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 13 Sep 2018 10:42:41 +0200
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: Jan =?UTF-8?B?S3VuZHLDoXQ=?= <jan.kundrat@cesnet.cz>
Subject: Re: [BISECTED] Regression: Solidrun Clearfog Base won't boot since
 "PCI: mvebu: Only remap I/O space if configured"
Message-ID: <20180913104241.65db8243@windsurf>
In-Reply-To: <5ad46fec-a71a-477a-b23f-d20aacfb481d@cesnet.cz>
References: <61fdfd69-2bb6-478c-b0d5-69d8744adae3@cesnet.cz>
 <87zhwm4kl6.fsf@tkos.co.il>
 <20180912231050.GX30658@n2100.armlinux.org.uk>
 <20180913094515.351967bb@windsurf>
 <5ad46fec-a71a-477a-b23f-d20aacfb481d@cesnet.cz>
MIME-Version: 1.0
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
Content-Type: text/plain; charset="utf-8"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

SGVsbG8sCgpPbiBUaHUsIDEzIFNlcCAyMDE4IDEwOjIwOjQ1ICswMjAwLCBKYW4gS3VuZHLDoXQg
d3JvdGU6Cj4gT24gxI10dnJ0ZWsgMTMuIHrDocWZw60gMjAxOCA5OjQ1OjE1IENFU1QsIFRob21h
cyBQZXRhenpvbmkgd3JvdGU6Cj4gPiBXaGF0IGFib3V0IHNvbWV0aGluZyBsaWtlIHRoZSBiZWxv
dy4gSSB0ZXN0ZWQgaXQsIGluY2x1ZGluZyB0aGUgZXJyb3IKPiA+IGNhc2UgYnkgZm9yY2luZyBh
biAtRVBST0JFX0RFRkVSLiBUaGUgbmV3IHBjaV91bm1hcF9pbygpIGlzIG1vZGVsZWQKPiA+IGFm
dGVyIHBjaV91bm1hcF9pb3NwYWNlKCkuIEFjdHVhbGx5LCBJIHdvdWxkIHByZWZlciB0byB1c2UK
PiA+IHBjaV9yZW1hcF9pb3NwYWNlKCkgYW5kIHBjaV91bm1hcF9pb3NwYWNlKCkgYnV0IGZvciBu
b3cgdGhpcyBBUEkKPiA+IGRvZXNuJ3QgYWxsb3cgb3ZlcmxvYWRpbmcgdGhlIG1lbW9yeSB0eXBl
IHVzZWQgZm9yIHRoZSBtYXBwaW5nLiAgCj4gCj4gVGhhbmtzIGZvciBwcm92aWRpbmcgdGhpcyBm
aXggc28gcXVpY2tseSwgVGhvbWFzLiBJIGNhbiBjb25maXJtIHRoYXQgdGhpcyAKPiBwYXRjaCAt
LSB0ZXN0ZWQgb24gdG9wIG9mIDU0ZWRhOWRmMTdmMzIxNWI5ZWQxNjYyOWVlNzFlYTA3NDEzZWZk
YWYgKCJNZXJnZSAKPiB0YWcgJ3BjaS12NC4xOS1maXhlcy0xJyBvZiAKPiBnaXQ6Ly9naXQua2Vy
bmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvaGVsZ2Fhcy9wY2kiKS4gRGlzY2xhaW1l
cjogSSAKPiBoYXZlIHplcm8gZmFtaWxpYXJpdHkgd2l0aCBMaW51eCcgUENJIGNvZGUuCj4gCj4g
VGVzdGVkLWJ5OiBKYW4gS3VuZHLDoXQgPGphbi5rdW5kcmF0QGNlc25ldC5jej4KClRoYW5rcyBm
b3IgdGhlIHRlc3RpbmcuIEknbGwgd2FpdCBmb3IgUnVzc2VsbCB0byBzYXkgaWYgaGUgaXMgaGFw
cHkKKG9yIG5vdCkgd2l0aCB0aGUgYWRkaXRpb24gb2YgcGNpX3VubWFwX2lvKCkgaW4gdGhlIEFS
TSBjb2RlLCBpZiB0aGF0J3MKdGhlIGNhc2UsIEknbGwgc2VuZCBhIHByb3BlciBwYXRjaCB0byBm
aXggdGhlIGlzc3VlLgoKQmVzdCByZWdhcmRzLAoKVGhvbWFzCi0tIApUaG9tYXMgUGV0YXp6b25p
LCBDVE8sIEJvb3RsaW4KRW1iZWRkZWQgTGludXggYW5kIEtlcm5lbCBlbmdpbmVlcmluZwpodHRw
czovL2Jvb3RsaW4uY29tCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9saW51eC1hcm0ta2VybmVsCg==
