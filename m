Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Message-ID: <1508229310.2146.2.camel@pengutronix.de>
Subject: Re: [PATCH 1/2] PCI: dwc: Adjust Kconfig to allow IMX6 PCIe host on
 IMX7
From: Lucas Stach <l.stach@pengutronix.de>
To: Trent Piepho <tpiepho@impinj.com>, linux-arm-kernel
 <linux-arm-kernel@lists.infradead.org>, linux-pci@vger.kernel.org
Date: Tue, 17 Oct 2017 10:35:10 +0200
In-Reply-To: <20171017001159.109152-1-tpiepho@impinj.com>
References: <20171017001159.109152-1-tpiepho@impinj.com>
Mime-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
 Richard Zhu <hongxing.zhu@nxp.com>
Content-Type: text/plain; charset="utf-8"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

QW0gTW9udGFnLCBkZW4gMTYuMTAuMjAxNywgMTc6MTEgLTA3MDAgc2NocmllYiBUcmVudCBQaWVw
aG86Cj4gVGhlIElNWDYgUENJLWUgaG9zdCBkcml2ZXIgYWxzbyBzdXBwb3J0cyB0aGUgSU1YN2Qu
wqDCoEhvd2V2ZXIsIHRoZQo+IEtjb25maWcgZGVwZW5kZW5jaWVzIG9mIHRoZSBkcml2ZXIgcHJl
dmVudGVkIGl0IGZyb20gYmVpbmcgZW5hYmxlZAo+IHVubGVzcyB0aGUga2VybmVsIHdhcyBidWls
dCB3aXRoIGJvdGggSU1YNiBhbmQgSU1YNyBzdXBwb3J0LsKgwqBJdAo+IHdvcmtzCj4gZmluZSB0
byBidWlsZCB3aXRoIG9ubHkgSU1YNyBzdXBwb3J0IGVuYWJsZWQuCj4gCj4gQ2M6IEFuZHJleSBT
bWlybm92IDxhbmRyZXcuc21pcm5vdkBnbWFpbC5jb20+Cj4gQ2M6IFJpY2hhcmQgWmh1IDxob25n
eGluZy56aHVAbnhwLmNvbT4KPiBDQzogTHVjYXMgU3RhY2ggPGwuc3RhY2hAcGVuZ3V0cm9uaXgu
ZGU+Cj4gU2lnbmVkLW9mZi1ieTogVHJlbnQgUGllcGhvIDx0cGllcGhvQGltcGluai5jb20+CgpS
ZXZpZXdlZC1ieTogTHVjYXMgU3RhY2ggPGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU+Cgo+IC0tLQo+
IMKgZHJpdmVycy9wY2kvZHdjL0tjb25maWcgfCA0ICsrLS0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAy
IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
cGNpL2R3Yy9LY29uZmlnIGIvZHJpdmVycy9wY2kvZHdjL0tjb25maWcKPiBpbmRleCAyMmVjODJm
Y2RlYTIuLjg1Y2YzOTI5MjFhOSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3BjaS9kd2MvS2NvbmZp
Zwo+ICsrKyBiL2RyaXZlcnMvcGNpL2R3Yy9LY29uZmlnCj4gQEAgLTcxLDkgKzcxLDkgQEAgY29u
ZmlnIFBDSV9FWFlOT1MKPiDCoAlzZWxlY3QgUENJRV9EV19IT1NUCj4gwqAKPiDCoGNvbmZpZyBQ
Q0lfSU1YNgo+IC0JYm9vbCAiRnJlZXNjYWxlIGkuTVg2IFBDSWUgY29udHJvbGxlciIKPiArCWJv
b2wgIkZyZWVzY2FsZSBpLk1YNi83IFBDSWUgY29udHJvbGxlciIKPiDCoAlkZXBlbmRzIG9uIFBD
SQo+IC0JZGVwZW5kcyBvbiBTT0NfSU1YNlEKPiArCWRlcGVuZHMgb24gU09DX0lNWDZRIHx8IFNP
Q19JTVg3RAo+IMKgCWRlcGVuZHMgb24gUENJX01TSV9JUlFfRE9NQUlOCj4gwqAJc2VsZWN0IFBD
SUVQT1JUQlVTCj4gwqAJc2VsZWN0IFBDSUVfRFdfSE9TVAoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QK
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRl
YWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
