Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from [216.32.181.185] ([216.32.181.185]:42232 "EHLO
	ch1outboundpool.messaging.microsoft.com" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1754430Ab3CTUiw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 20 Mar 2013 16:38:52 -0400
From: Matthew Garrett <matthew.garrett@nebula.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
CC: James Morris <jmorris@namei.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>,
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 01/12] Security: Add CAP_COMPROMISE_KERNEL
Date: Wed, 20 Mar 2013 20:37:36 +0000
Message-ID: <1363811856.2553.37.camel@x230.sbx07502.somerma.wayport.net>
References: <1363642353-30749-1-git-send-email-matthew.garrett@nebula.com>
	 <alpine.LRH.2.02.1303191542200.30973@tundra.namei.org>
	 <1363797717.2580.10.camel@falcor1.watson.ibm.com>
	 <1363798166.2553.29.camel@x230.sbx07502.somerma.wayport.net>
	 <1363802506.2580.55.camel@falcor1.watson.ibm.com>
	 <1363803158.2553.33.camel@x230.sbx07502.somerma.wayport.net>
	 <1363806968.2580.86.camel@falcor1.watson.ibm.com>
In-Reply-To: <1363806968.2580.86.camel@falcor1.watson.ibm.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

T24gV2VkLCAyMDEzLTAzLTIwIGF0IDE1OjE2IC0wNDAwLCBNaW1pIFpvaGFyIHdyb3RlOg0KPiBP
biBXZWQsIDIwMTMtMDMtMjAgYXQgMTg6MTIgKzAwMDAsIE1hdHRoZXcgR2FycmV0dCB3cm90ZToN
Cj4gPiBXZWxsLCBpbiB0aGUgYWJzZW5jZSBvZiBoYXJkY29kZWQgaW4ta2VybmVsIHBvbGljeSwg
dGhlcmUgbmVlZHMgdG8gYmUNCj4gPiBzb21lIG1lY2hhbmlzbSBmb3IgZW5zdXJpbmcgdGhlIGlu
dGVncml0eSBvZiBhIHBvbGljeS4gU2hpcHBpbmcgYSBzaWduZWQNCj4gPiBwb2xpY3kgaW5pdHJh
bWZzIGZyYWdtZW50IGFuZCBoYXZpbmcgYW55IFNlY3VyZSBCb290IGJvb3Rsb2FkZXJzIHBhc3Mg
YQ0KPiA+IGZsYWcgaW4gYm9vdHBhcmFtcyBpbmRpY2F0aW5nIHRoYXQgdGhlIGtlcm5lbCBzaG91
bGQgcGFuaWMgaWYgdGhhdA0KPiA+IGZyYWdtZW50IGlzbid0IHByZXNlbnQgd291bGQgc2VlbSB0
byBiZSB0aGUgZWFzaWVzdCB3YXkgb2YgZG9pbmcgdGhhdC4NCj4gPiBPciBoYXZlIEkgbWlzdW5k
ZXJzdG9vZCB0aGUgcXVlc3Rpb24/DQo+IA0KPiBPaywgSSB3YXMgY29uZnVzZWQgYnkgdGhlIHRl
cm0gImZyYWdtZW50ZWQiIGluaXRyYW1mcy4gIFNvIG9uY2UgeW91IGhhdmUNCj4gdmVyaWZpZWQg
dGhlICJlYXJseSIgZnJhZ21lbnRlZCBpbml0cmFtZnMgc2lnbmF0dXJlLCB0aGlzIGluaXRyYW1m
cyB3aWxsDQo+IGxvYWQgdGhlICJ0cnVzdGVkIiBwdWJsaWMga2V5cyBhbmQgY291bGQgYWxzbyBs
b2FkIHRoZSBNQUMgcG9saWN5LiAoSQ0KPiByZWFsaXplIHRoYXQgZHJhY3V0IGlzIGN1cnJlbnRs
eSBsb2FkaW5nIHRoZSBNQUMgcG9saWN5LCBub3QgdGhlDQo+IGluaXRyYW1mcy4pICBUaGUgTUFD
IHBvbGljeSB3b3VsZCB0aGVuIGJlIHRydXN0ZWQsIHJpZ2h0PyAgQ291bGQgd2UgdGhlbg0KPiB1
c2UgdGhlIExTTSBsYWJlbHMgZm9yIGRlZmluaW5nIGFuIGludGVncml0eSBwb2xpY3kgZm9yIGtl
eGVjPw0KDQpSaWdodCwgdGhhdCdkIGJlIHRoZSByb3VnaCBpZGVhLiBBbnkgZnVydGhlciBydW50
aW1lIHBvbGljeSB1cGRhdGVzDQp3b3VsZCBwcmVzdW1hYmx5IG5lZWQgdG8gYmUgc2lnbmVkIHdp
dGggYSB0cnVzdGVkIGtleS4NCg0KLS0gDQpNYXR0aGV3IEdhcnJldHQgfCBtamc1OUBzcmNmLnVj
YW0ub3JnDQo=

