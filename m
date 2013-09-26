Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from va3ehsobe001.messaging.microsoft.com ([216.32.180.11]:14908
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751477Ab3IZDxX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 25 Sep 2013 23:53:23 -0400
From: Bhushan Bharat-R65777 <R65777@freescale.com>
To: Alex Williamson <alex.williamson@redhat.com>
CC: "joro@8bytes.org" <joro@8bytes.org>,
	"benh@kernel.crashing.org" <benh@kernel.crashing.org>,
	"galak@kernel.crashing.org" <galak@kernel.crashing.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"agraf@suse.de" <agraf@suse.de>,
	Wood Scott-B07421 <B07421@freescale.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: RE: [PATCH 5/7] iommu: supress loff_t compilation error on powerpc
Date: Thu, 26 Sep 2013 03:53:12 +0000
Message-ID: <6A3DF150A5B70D4F9B66A25E3F7C888D07183CA4@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1379575763-2091-1-git-send-email-Bharat.Bhushan@freescale.com>
	 <1379575763-2091-6-git-send-email-Bharat.Bhushan@freescale.com>
 <1380127227.3030.316.camel@ul30vt.home>
In-Reply-To: <1380127227.3030.316.camel@ul30vt.home>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxleCBXaWxsaWFtc29u
IFttYWlsdG86YWxleC53aWxsaWFtc29uQHJlZGhhdC5jb21dDQo+IFNlbnQ6IFdlZG5lc2RheSwg
U2VwdGVtYmVyIDI1LCAyMDEzIDEwOjEwIFBNDQo+IFRvOiBCaHVzaGFuIEJoYXJhdC1SNjU3NzcN
Cj4gQ2M6IGpvcm9AOGJ5dGVzLm9yZzsgYmVuaEBrZXJuZWwuY3Jhc2hpbmcub3JnOyBnYWxha0Br
ZXJuZWwuY3Jhc2hpbmcub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGlu
dXhwcGMtZGV2QGxpc3RzLm96bGFicy5vcmc7IGxpbnV4LQ0KPiBwY2lAdmdlci5rZXJuZWwub3Jn
OyBhZ3JhZkBzdXNlLmRlOyBXb29kIFNjb3R0LUIwNzQyMTsgaW9tbXVAbGlzdHMubGludXgtDQo+
IGZvdW5kYXRpb24ub3JnOyBCaHVzaGFuIEJoYXJhdC1SNjU3NzcNCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCA1LzddIGlvbW11OiBzdXByZXNzIGxvZmZfdCBjb21waWxhdGlvbiBlcnJvciBvbiBwb3dl
cnBjDQo+IA0KPiBPbiBUaHUsIDIwMTMtMDktMTkgYXQgMTI6NTkgKzA1MzAsIEJoYXJhdCBCaHVz
aGFuIHdyb3RlOg0KPiA+IFNpZ25lZC1vZmYtYnk6IEJoYXJhdCBCaHVzaGFuIDxiaGFyYXQuYmh1
c2hhbkBmcmVlc2NhbGUuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3ZmaW8vcGNpL3ZmaW9f
cGNpX3Jkd3IuYyB8ICAgIDMgKystDQo+ID4gIDEgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmZpby9w
Y2kvdmZpb19wY2lfcmR3ci5jDQo+ID4gYi9kcml2ZXJzL3ZmaW8vcGNpL3ZmaW9fcGNpX3Jkd3Iu
Yw0KPiA+IGluZGV4IDIxMGRiMjQuLjhhODE1NmEgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy92
ZmlvL3BjaS92ZmlvX3BjaV9yZHdyLmMNCj4gPiArKysgYi9kcml2ZXJzL3ZmaW8vcGNpL3ZmaW9f
cGNpX3Jkd3IuYw0KPiA+IEBAIC0xODEsNyArMTgxLDggQEAgc3NpemVfdCB2ZmlvX3BjaV92Z2Ff
cncoc3RydWN0IHZmaW9fcGNpX2RldmljZSAqdmRldiwgY2hhcg0KPiBfX3VzZXIgKmJ1ZiwNCj4g
PiAgCQkJICAgICAgIHNpemVfdCBjb3VudCwgbG9mZl90ICpwcG9zLCBib29sIGlzd3JpdGUpICB7
DQo+ID4gIAlpbnQgcmV0Ow0KPiA+IC0JbG9mZl90IG9mZiwgcG9zID0gKnBwb3MgJiBWRklPX1BD
SV9PRkZTRVRfTUFTSzsNCj4gPiArCWxvZmZfdCBvZmY7DQo+ID4gKwl1NjQgcG9zID0gKHU2NCAp
KCpwcG9zICYgVkZJT19QQ0lfT0ZGU0VUX01BU0spOw0KPiA+ICAJdm9pZCBfX2lvbWVtICppb21l
bSA9IE5VTEw7DQo+ID4gIAl1bnNpZ25lZCBpbnQgcnNyYzsNCj4gPiAgCWJvb2wgaXNfaW9wb3J0
Ow0KPiANCj4gV2hhdCdzIHRoZSBjb21waWxlIGVycm9yIHRoYXQgdGhpcyBmaXhlcz8NCg0KSSB3
YXMgZ2V0dGluZyBiZWxvdyBlcnJvcjsgYW5kIGFmdGVyIHNvbWUgZ29vZ2xpbmcgSSBjYW1lIHRv
IGtub3cgdGhhdCB0aGlzIGlzIGhvdyBpdCBpcyBmaXhlZCBieSBvdGhlciBndXlzLg0KDQovaG9t
ZS9yNjU3NzcvbGludXgtdmZpby9kcml2ZXJzL3ZmaW8vcGNpL3ZmaW9fcGNpX3Jkd3IuYzoxOTM6
IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYF9fY21wZGkyJw0KL2hvbWUvcjY1Nzc3L2xpbnV4LXZm
aW8vZHJpdmVycy92ZmlvL3BjaS92ZmlvX3BjaV9yZHdyLmM6MTkzOiB1bmRlZmluZWQgcmVmZXJl
bmNlIHRvIGBfX2NtcGRpMicNCg0KVGhhbmtzDQotQmhhcmF0DQo+IA0KDQo=

