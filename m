Return-Path: <SRS0=UcfF=MX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D25C677FF
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 16:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A34712085B
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 16:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="ZYYZma+4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A34712085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730301AbeJLA1c (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Oct 2018 20:27:32 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:54430 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730647AbeJLA1c (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Oct 2018 20:27:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1539277165; x=1570813165;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=9Qz5WBPBFO3ID78nYsK+R9cdRJITvopSX6RL+MSFtTI=;
  b=ZYYZma+4U5ZS0DBpGk2TqhNYrkQd/CZR1weH1d+zDPNQMzPwfJkflww5
   /W2xG+qMPjHyj084gugvoGTV1tEqUUPsuxrZf91FVtq2NHpOwRHhulrZ8
   zszO59hhi47iQWBEs69oPY7ZwIUWPPzTzpcL15AHvHrQYLv72dH9tGLFQ
   U=;
X-IronPort-AV: E=Sophos;i="5.54,369,1534809600"; 
   d="scan'208";a="362101978"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-474bcd9f.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 11 Oct 2018 16:59:24 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-474bcd9f.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id w9BGxMUJ074507
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 11 Oct 2018 16:59:23 GMT
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 11 Oct 2018 16:59:22 +0000
Received: from EX13D01EUB003.ant.amazon.com (10.43.166.248) by
 EX13D01EUB001.ant.amazon.com (10.43.166.194) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 11 Oct 2018 16:59:21 +0000
Received: from EX13D01EUB003.ant.amazon.com ([10.43.166.248]) by
 EX13D01EUB003.ant.amazon.com ([10.43.166.248]) with mapi id 15.00.1367.000;
 Thu, 11 Oct 2018 16:59:21 +0000
From:   "Raslan, KarimAllah" <karahmed@amazon.de>
To:     "helgaas@kernel.org" <helgaas@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: [PATCH v2] PCI/IOV: Use VF0 cached config space size for other
 VFs
Thread-Topic: [PATCH v2] PCI/IOV: Use VF0 cached config space size for other
 VFs
Thread-Index: AQHUYLJdK9eU3B2FIkSfhKUeSf57PKUaQ9+AgAACPQA=
Date:   Thu, 11 Oct 2018 16:59:20 +0000
Message-ID: <1539277160.13237.94.camel@amazon.de>
References: <1539187210-22515-1-git-send-email-karahmed@amazon.de>
         <20181011165119.GQ5906@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20181011165119.GQ5906@bhelgaas-glaptop.roam.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.165.114]
Content-Type: text/plain; charset="utf-8"
Content-ID: <8A9A41CB3374FB4BB817B0AE82554E77@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVGh1LCAyMDE4LTEwLTExIGF0IDExOjUxIC0wNTAwLCBCam9ybiBIZWxnYWFzIHdyb3RlOg0K
PiBPbiBXZWQsIE9jdCAxMCwgMjAxOCBhdCAwNjowMDoxMFBNICswMjAwLCBLYXJpbUFsbGFoIEFo
bWVkIHdyb3RlOg0KPiA+IA0KPiA+IENhY2hlIHRoZSBjb25maWcgc3BhY2Ugc2l6ZSBmcm9tIFZG
MCBhbmQgdXNlIGl0IGZvciBhbGwgb3RoZXIgVkZzIGluc3RlYWQNCj4gPiBvZiByZWFkaW5nIGl0
IGZyb20gdGhlIGNvbmZpZyBzcGFjZSBvZiBlYWNoIFZGLiBXZSBhc3N1bWUgdGhhdCBpdCB3aWxs
IGJlDQo+ID4gdGhlIHNhbWUgYWNyb3NzIGFsbCBhc3NvY2lhdGVkIFZGcy4NCj4gPiANCj4gPiBU
aGlzIGlzIGFuIG9wdGltaXphdGlvbiB3aGVuIGVuYWJsaW5nIFNSLUlPViBvbiBhIGRldmljZSB3
aXRoIG1hbnkgVkZzLg0KPiA+IA0KPiA+IENjOiBCam9ybiBIZWxnYWFzIDxiaGVsZ2Fhc0Bnb29n
bGUuY29tPg0KPiA+IENjOiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnDQo+ID4gQ2M6IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gPiBTaWduZWQtb2ZmLWJ5OiBLYXJpbUFsbGFoIEFo
bWVkIDxrYXJhaG1lZEBhbWF6b24uZGU+DQo+IA0KPiBBcHBsaWVkIHRvIHBjaS92aXJ0dWFsaXph
dGlvbiBmb3IgdjQuMjAsIHRoYW5rcyENCj4gDQo+IEFzIEkgbWVudGlvbmVkIGxhc3QgdGltZSwg
SSB0aGluayBDT05GSUdfUENJX0FUUyBpcyB0aGUgd3Jvbmcgc3ltYm9sIHRvDQo+IHRlc3QgaGVy
ZSwgc28gSSBjaGFuZ2VkIHRoYXQgdG8gQ09ORklHX1BDSV9JT1YuDQoNCk9vb3BzISBTb3JyeSwg
aXQgaGFzIGJlZW4gYSBsb25nIHRpbWUgYW5kIEkgZm9nb3QgOkQNCg0KPiBJIGFsc28gbW92ZWQg
dGhlICNpZmRlZiB3cmFwcGVyIHNvIHRoZSBjYWxsZXIgZG9lc24ndCBuZWVkIGFuIGlmZGVmLg0K
PiBQbGVhc2UgbGV0IG1lIGtub3cgaWYgdGhlc2UgYnJlYWsgYW55dGhpbmcuICBUaGUgcGF0Y2gg
SSBhcHBsaWVkIGlzIGFwcGVuZGVkLg0KDQpMb29rcyBnb29kIHRvIG1lLiBUaGFua3MhDQoNCj4g
PiANCj4gPiAtLS0NCj4gPiB2MSAtPiB2MjoNCj4gPiAtIERyb3AgdGhlIF9fcGNpX2NmZ19zcGFj
ZV9zaXplIChiaGVsZ2Fhc0ApDQo+ID4gLSBFeHRlbmQgcGNpX2NmZ19zcGFjZV9zaXplIHRvIHJl
dHVybiB0aGUgY2FjaGVkIHZhbHVlIGZvciBhbGwgVkZzIGV4Y2VwdA0KPiA+ICAgVkYwIChiaGVs
Z2Fhc0ApDQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvcGNpL2lvdi5jICAgfCAgMiArKw0KPiA+ICBk
cml2ZXJzL3BjaS9wY2kuaCAgIHwgIDEgKw0KPiA+ICBkcml2ZXJzL3BjaS9wcm9iZS5jIHwgMTcg
KysrKysrKysrKysrKysrKysNCj4gPiAgMyBmaWxlcyBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCsp
DQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2lvdi5jIGIvZHJpdmVycy9wY2kv
aW92LmMNCj4gPiBpbmRleCBjNWYzY2Q0ZS4uNDIzOGI1MyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2
ZXJzL3BjaS9pb3YuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2lvdi5jDQo+ID4gQEAgLTEzMyw2
ICsxMzMsOCBAQCBzdGF0aWMgdm9pZCBwY2lfcmVhZF92Zl9jb25maWdfY29tbW9uKHN0cnVjdCBw
Y2lfZGV2ICp2aXJ0Zm4pDQo+ID4gIAkJCSAgICAgJnBoeXNmbi0+c3Jpb3YtPnN1YnN5c3RlbV92
ZW5kb3IpOw0KPiA+ICAJcGNpX3JlYWRfY29uZmlnX3dvcmQodmlydGZuLCBQQ0lfU1VCU1lTVEVN
X0lELA0KPiA+ICAJCQkgICAgICZwaHlzZm4tPnNyaW92LT5zdWJzeXN0ZW1fZGV2aWNlKTsNCj4g
PiArDQo+ID4gKwlwaHlzZm4tPnNyaW92LT5jZmdfc2l6ZSA9IHBjaV9jZmdfc3BhY2Vfc2l6ZSh2
aXJ0Zm4pOw0KPiA+ICB9DQo+ID4gIA0KPiA+ICBpbnQgcGNpX2lvdl9hZGRfdmlydGZuKHN0cnVj
dCBwY2lfZGV2ICpkZXYsIGludCBpZCkNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvcGNp
LmggYi9kcml2ZXJzL3BjaS9wY2kuaA0KPiA+IGluZGV4IDZlMGQxNTIuLjJmMTQ1NDIgMTAwNjQ0
DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kvcGNpLmgNCj4gPiArKysgYi9kcml2ZXJzL3BjaS9wY2ku
aA0KPiA+IEBAIC0yODUsNiArMjg1LDcgQEAgc3RydWN0IHBjaV9zcmlvdiB7DQo+ID4gIAl1MTYJ
CWRyaXZlcl9tYXhfVkZzOwkvKiBNYXggbnVtIFZGcyBkcml2ZXIgc3VwcG9ydHMgKi8NCj4gPiAg
CXN0cnVjdCBwY2lfZGV2CSpkZXY7CQkvKiBMb3dlc3QgbnVtYmVyZWQgUEYgKi8NCj4gPiAgCXN0
cnVjdCBwY2lfZGV2CSpzZWxmOwkJLyogVGhpcyBQRiAqLw0KPiA+ICsJdTMyCQljZmdfc2l6ZTsJ
LyogVkYgY29uZmlnIHNwYWNlIHNpemUgKi8NCj4gPiAgCXUzMgkJY2xhc3M7CQkvKiBWRiBkZXZp
Y2UgKi8NCj4gPiAgCXU4CQloZHJfdHlwZTsJLyogVkYgaGVhZGVyIHR5cGUgKi8NCj4gPiAgCXUx
NgkJc3Vic3lzdGVtX3ZlbmRvcjsgLyogVkYgc3Vic3lzdGVtIHZlbmRvciAqLw0KPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3BjaS9wcm9iZS5jIGIvZHJpdmVycy9wY2kvcHJvYmUuYw0KPiA+IGlu
ZGV4IDIwMWY5ZTUuLjhjMGY0MjggMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kvcHJvYmUu
Yw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL3Byb2JlLmMNCj4gPiBAQCAtMTQzOCwxMiArMTQzOCwy
OSBAQCBzdGF0aWMgaW50IHBjaV9jZmdfc3BhY2Vfc2l6ZV9leHQoc3RydWN0IHBjaV9kZXYgKmRl
dikNCj4gPiAgCXJldHVybiBQQ0lfQ0ZHX1NQQUNFX0VYUF9TSVpFOw0KPiA+ICB9DQo+ID4gIA0K
PiA+ICsjaWZkZWYgQ09ORklHX1BDSV9BVFMNCj4gPiArc3RhdGljIGJvb2wgaXNfdmYwKHN0cnVj
dCBwY2lfZGV2ICpkZXYpDQo+ID4gK3sNCj4gPiArCWlmIChwY2lfaW92X3ZpcnRmbl9kZXZmbihk
ZXYtPnBoeXNmbiwgMCkgPT0gZGV2LT5kZXZmbiAmJg0KPiA+ICsJICAgIHBjaV9pb3ZfdmlydGZu
X2J1cyhkZXYtPnBoeXNmbiwgMCkgPT0gZGV2LT5idXMtPm51bWJlcikNCj4gPiArCQlyZXR1cm4g
dHJ1ZTsNCj4gPiArDQo+ID4gKwlyZXR1cm4gZmFsc2U7DQo+ID4gK30NCj4gPiArI2VuZGlmDQo+
ID4gKw0KPiA+ICBpbnQgcGNpX2NmZ19zcGFjZV9zaXplKHN0cnVjdCBwY2lfZGV2ICpkZXYpDQo+
ID4gIHsNCj4gPiAgCWludCBwb3M7DQo+ID4gIAl1MzIgc3RhdHVzOw0KPiA+ICAJdTE2IGNsYXNz
Ow0KPiA+ICANCj4gPiArI2lmZGVmIENPTkZJR19QQ0lfQVRTDQo+ID4gKwkvKiBSZWFkIGNhY2hl
ZCB2YWx1ZSBmb3IgYWxsIFZGcyBleGNlcHQgZm9yIFZGMCAqLw0KPiA+ICsJaWYgKGRldi0+aXNf
dmlydGZuICYmICFpc192ZjAoZGV2KSkNCj4gPiArCQlyZXR1cm4gZGV2LT5waHlzZm4tPnNyaW92
LT5jZmdfc2l6ZTsNCj4gPiArI2VuZGlmDQo+ID4gKw0KPiA+ICAJaWYgKGRldi0+YnVzLT5idXNf
ZmxhZ3MgJiBQQ0lfQlVTX0ZMQUdTX05PX0VYVENGRykNCj4gPiAgCQlyZXR1cm4gUENJX0NGR19T
UEFDRV9TSVpFOw0KPiA+ICANCj4gPiAtLSANCj4gPiAyLjcuNA0KPiA+IA0KPiANCj4gY29tbWl0
IDYwMWY5ZjY2NzkxNTdiNzBhN2E0ZTc1MmJhYTU5MGJkMmFmNjlmZmINCj4gQXV0aG9yOiBLYXJp
bUFsbGFoIEFobWVkIDxrYXJhaG1lZEBhbWF6b24uZGU+DQo+IERhdGU6ICAgVGh1IE9jdCAxMSAx
MTo0OTo1OCAyMDE4IC0wNTAwDQo+IA0KPiAgICAgUENJL0lPVjogVXNlIFZGMCBjYWNoZWQgY29u
ZmlnIHNwYWNlIHNpemUgZm9yIG90aGVyIFZGcw0KPiAgICAgDQo+ICAgICBDYWNoZSB0aGUgY29u
ZmlnIHNwYWNlIHNpemUgZnJvbSBWRjAgYW5kIHVzZSBpdCBmb3IgYWxsIG90aGVyIFZGcyBpbnN0
ZWFkDQo+ICAgICBvZiByZWFkaW5nIGl0IGZyb20gdGhlIGNvbmZpZyBzcGFjZSBvZiBlYWNoIFZG
LiAgV2UgYXNzdW1lIHRoYXQgaXQgd2lsbCBiZQ0KPiAgICAgdGhlIHNhbWUgYWNyb3NzIGFsbCBh
c3NvY2lhdGVkIFZGcy4NCj4gICAgIA0KPiAgICAgVGhpcyBpcyBhbiBvcHRpbWl6YXRpb24gd2hl
biBlbmFibGluZyBTUi1JT1Ygb24gYSBkZXZpY2Ugd2l0aCBtYW55IFZGcy4NCj4gICAgIA0KPiAg
ICAgU2lnbmVkLW9mZi1ieTogS2FyaW1BbGxhaCBBaG1lZCA8a2FyYWhtZWRAYW1hem9uLmRlPg0K
PiAgICAgW2JoZWxnYWFzOiB1c2UgQ09ORklHX1BDSV9JT1YgKG5vdCBDT05GSUdfUENJX0FUUyks
IGFkanVzdCBpc192ZjAoKSB3cmFwcGVyDQo+ICAgICBzbyBjYWxsZXIgZG9lc24ndCBuZWVkIGlm
ZGVmXQ0KPiAgICAgU2lnbmVkLW9mZi1ieTogQmpvcm4gSGVsZ2FhcyA8YmhlbGdhYXNAZ29vZ2xl
LmNvbT4NCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9pb3YuYyBiL2RyaXZlcnMvcGNp
L2lvdi5jDQo+IGluZGV4IGM1ZjNjZDRlZDc2Ni4uNDIzOGI1MzlmOWQ4IDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL3BjaS9pb3YuYw0KPiArKysgYi9kcml2ZXJzL3BjaS9pb3YuYw0KPiBAQCAtMTMz
LDYgKzEzMyw4IEBAIHN0YXRpYyB2b2lkIHBjaV9yZWFkX3ZmX2NvbmZpZ19jb21tb24oc3RydWN0
IHBjaV9kZXYgKnZpcnRmbikNCj4gIAkJCSAgICAgJnBoeXNmbi0+c3Jpb3YtPnN1YnN5c3RlbV92
ZW5kb3IpOw0KPiAgCXBjaV9yZWFkX2NvbmZpZ193b3JkKHZpcnRmbiwgUENJX1NVQlNZU1RFTV9J
RCwNCj4gIAkJCSAgICAgJnBoeXNmbi0+c3Jpb3YtPnN1YnN5c3RlbV9kZXZpY2UpOw0KPiArDQo+
ICsJcGh5c2ZuLT5zcmlvdi0+Y2ZnX3NpemUgPSBwY2lfY2ZnX3NwYWNlX3NpemUodmlydGZuKTsN
Cj4gIH0NCj4gIA0KPiAgaW50IHBjaV9pb3ZfYWRkX3ZpcnRmbihzdHJ1Y3QgcGNpX2RldiAqZGV2
LCBpbnQgaWQpDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9wY2kuaCBiL2RyaXZlcnMvcGNp
L3BjaS5oDQo+IGluZGV4IDZlMGQxNTI4ZDQ3MS4uMmYxNDU0MjA5MjU3IDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL3BjaS9wY2kuaA0KPiArKysgYi9kcml2ZXJzL3BjaS9wY2kuaA0KPiBAQCAtMjg1
LDYgKzI4NSw3IEBAIHN0cnVjdCBwY2lfc3Jpb3Ygew0KPiAgCXUxNgkJZHJpdmVyX21heF9WRnM7
CS8qIE1heCBudW0gVkZzIGRyaXZlciBzdXBwb3J0cyAqLw0KPiAgCXN0cnVjdCBwY2lfZGV2CSpk
ZXY7CQkvKiBMb3dlc3QgbnVtYmVyZWQgUEYgKi8NCj4gIAlzdHJ1Y3QgcGNpX2Rldgkqc2VsZjsJ
CS8qIFRoaXMgUEYgKi8NCj4gKwl1MzIJCWNmZ19zaXplOwkvKiBWRiBjb25maWcgc3BhY2Ugc2l6
ZSAqLw0KPiAgCXUzMgkJY2xhc3M7CQkvKiBWRiBkZXZpY2UgKi8NCj4gIAl1OAkJaGRyX3R5cGU7
CS8qIFZGIGhlYWRlciB0eXBlICovDQo+ICAJdTE2CQlzdWJzeXN0ZW1fdmVuZG9yOyAvKiBWRiBz
dWJzeXN0ZW0gdmVuZG9yICovDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9wcm9iZS5jIGIv
ZHJpdmVycy9wY2kvcHJvYmUuYw0KPiBpbmRleCAyMDFmOWU1ZmY1NWMuLjljMjBkOTY2N2U2MSAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9wY2kvcHJvYmUuYw0KPiArKysgYi9kcml2ZXJzL3BjaS9w
cm9iZS5jDQo+IEBAIC0xNDM4LDEyICsxNDM4LDI3IEBAIHN0YXRpYyBpbnQgcGNpX2NmZ19zcGFj
ZV9zaXplX2V4dChzdHJ1Y3QgcGNpX2RldiAqZGV2KQ0KPiAgCXJldHVybiBQQ0lfQ0ZHX1NQQUNF
X0VYUF9TSVpFOw0KPiAgfQ0KPiAgDQo+ICtzdGF0aWMgYm9vbCBpc192ZjAoc3RydWN0IHBjaV9k
ZXYgKmRldikNCj4gK3sNCj4gKyNpZmRlZiBDT05GSUdfUENJX0lPVg0KPiArCWlmIChwY2lfaW92
X3ZpcnRmbl9kZXZmbihkZXYtPnBoeXNmbiwgMCkgPT0gZGV2LT5kZXZmbiAmJg0KPiArCSAgICBw
Y2lfaW92X3ZpcnRmbl9idXMoZGV2LT5waHlzZm4sIDApID09IGRldi0+YnVzLT5udW1iZXIpDQo+
ICsJCXJldHVybiB0cnVlOw0KPiArI2VuZGlmDQo+ICsNCj4gKwlyZXR1cm4gZmFsc2U7DQo+ICt9
DQo+ICsNCj4gIGludCBwY2lfY2ZnX3NwYWNlX3NpemUoc3RydWN0IHBjaV9kZXYgKmRldikNCj4g
IHsNCj4gIAlpbnQgcG9zOw0KPiAgCXUzMiBzdGF0dXM7DQo+ICAJdTE2IGNsYXNzOw0KPiAgDQo+
ICsJLyogUmVhZCBjYWNoZWQgdmFsdWUgZm9yIGFsbCBWRnMgZXhjZXB0IGZvciBWRjAgKi8NCj4g
KwlpZiAoZGV2LT5pc192aXJ0Zm4gJiYgIWlzX3ZmMChkZXYpKQ0KPiArCQlyZXR1cm4gZGV2LT5w
aHlzZm4tPnNyaW92LT5jZmdfc2l6ZTsNCj4gKw0KPiAgCWlmIChkZXYtPmJ1cy0+YnVzX2ZsYWdz
ICYgUENJX0JVU19GTEFHU19OT19FWFRDRkcpDQo+ICAJCXJldHVybiBQQ0lfQ0ZHX1NQQUNFX1NJ
WkU7DQo+ICANCj4gDQpBbWF6b24gRGV2ZWxvcG1lbnQgQ2VudGVyIEdlcm1hbnkgR21iSApCZXJs
aW4gLSBEcmVzZGVuIC0gQWFjaGVuCm1haW4gb2ZmaWNlOiBLcmF1c2Vuc3RyLiAzOCwgMTAxMTcg
QmVybGluCkdlc2NoYWVmdHNmdWVocmVyOiBEci4gUmFsZiBIZXJicmljaCwgQ2hyaXN0aWFuIFNj
aGxhZWdlcgpVc3QtSUQ6IERFMjg5MjM3ODc5CkVpbmdldHJhZ2VuIGFtIEFtdHNnZXJpY2h0IENo
YXJsb3R0ZW5idXJnIEhSQiAxNDkxNzMgQgo=

