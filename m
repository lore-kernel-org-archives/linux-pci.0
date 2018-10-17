Return-Path: <SRS0=Zwnb=M5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796FFECDE3B
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 18:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42F672145D
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 18:16:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42F672145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbeJRCN3 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 17 Oct 2018 22:13:29 -0400
Received: from mga14.intel.com ([192.55.52.115]:39628 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727672AbeJRCN3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Oct 2018 22:13:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Oct 2018 11:16:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,393,1534834800"; 
   d="scan'208";a="78796293"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by fmsmga007.fm.intel.com with ESMTP; 17 Oct 2018 11:16:35 -0700
Received: from orsmsx116.amr.corp.intel.com (10.22.240.14) by
 ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 17 Oct 2018 11:16:35 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.122]) by
 ORSMSX116.amr.corp.intel.com ([169.254.7.58]) with mapi id 14.03.0319.002;
 Wed, 17 Oct 2018 11:16:35 -0700
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Busch, Keith" <keith.busch@intel.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>
Subject: Re: [PATCH 2/2] PCI/VMD: Set up firmware-first if capable
Thread-Topic: [PATCH 2/2] PCI/VMD: Set up firmware-first if capable
Thread-Index: AQHUZOrxcME+hN7b2kyNMv55d5sgE6Uj8oUAgABECoA=
Date:   Wed, 17 Oct 2018 18:16:34 +0000
Message-ID: <1539800189.18190.10.camel@intel.com>
References: <1539650888-3792-1-git-send-email-jonathan.derrick@intel.com>
         <1539650888-3792-3-git-send-email-jonathan.derrick@intel.com>
         <20181017140733.GA6674@e107981-ln.cambridge.arm.com>
In-Reply-To: <20181017140733.GA6674@e107981-ln.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.232.112.33]
Content-Type: text/plain; charset="utf-8"
Content-ID: <EFC35BB12159FD49A35F3FC7A67124D9@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgTG9yZW56bywNCg0KT24gV2VkLCAyMDE4LTEwLTE3IGF0IDE1OjEyICswMTAwLCBMb3Jlbnpv
IFBpZXJhbGlzaSB3cm90ZToNCj4gT24gTW9uLCBPY3QgMTUsIDIwMTggYXQgMDY6NDg6MDhQTSAt
MDYwMCwgSm9uIERlcnJpY2sgd3JvdGU6DQo+ID4gVGhlIFZNRCBlbmRwb2ludCBkZXZpY2UgZXhw
b3NlcyBhIGRvbWFpbiBvZiByb290IHBvcnRzIGFuZCBhbnkNCj4gPiBkb3duc3RyZWFtIGRldmlj
ZXMgYXR0YWNoZWQgdG8gdGhhdCBoaWVyYXJjaHkuIFZNRCBkb21haW5zDQo+ID4gY29uc2lzdGlu
ZyBvZg0KPiA+IHRoZSByb290IHBvcnRzIGFuZCBkb3duc3RyZWFtIGRldmljZXMgYXJlIG5vdCBy
ZXByZXNlbnRlZCBpbiB0aGUNCj4gPiBBQ1BJDQo+ID4gdGFibGVzIGFuZCBfT1NDIGlzIHVuc3Vw
cG9ydGVkLiBCZWNhdXNlIG9mIHRoaXMgbm9uLXN0YW5kYXJkIHdheSBvZg0KPiA+IHNpZ25hbGlu
ZyBmaXJtd2FyZS1maXJzdCBlbmFibGluZyBvbiB0aGUgcm9vdCBwb3J0cywgdGhlIFZNRCBkZXZp
Y2UNCj4gPiBpbnN0ZWFkIGFkdmVydGlzZXMgc3VwcG9ydCBmb3IgZmlybXdhcmUtZmlyc3Qgb24g
dGhlIHJvb3QgcG9ydHMgYnkNCj4gPiBzZXR0aW5nIGl0cyBpbnRlcmZhY2UgYml0IHRvIDB4MS4N
Cj4gPiANCj4gPiBXaGVuIGZpcm13YXJlLWZpcnN0IGlzIGVuYWJsZWQgb24gYSBWTUQgZG9tYWlu
LCB0aGUgZHJpdmVyIHNldHMgdXANCj4gPiB0aGUNCj4gPiByb290IHBvcnQgY29udHJvbCByZWdp
c3RlcnMgdG8gZ2VuZXJhdGUgU01JIHN5c3RlbSBpbnRlcnJ1cHRzIHRvDQo+ID4gZmlybXdhcmUg
b24gZXJyb3JzLiBTeXN0ZW0gZmlybXdhcmUgd2lsbCBoYW5kbGUgdGhlIGVycm9yIGFzIGl0DQo+
ID4gc2Vlcw0KPiA+IGZpdCwgdGhlbiBwYXNzZXMgYmFjayBjb250cm9sIHRvIFZNRCB3aXRoIGEg
c3ludGhlc2l6ZWQgTVNJDQo+ID4gbWVzc2FnZS4NCj4gPiANCj4gPiBCZWNhdXNlIG9mIHRoaXMg
a2VybmVsIHBhc3MtYmFjaywgdGhlIGRyaXZlciBkb2VzIG5vdCBkaXNhYmxlIHRoZQ0KPiA+IG5h
dGl2ZQ0KPiA+IEFFUiBwb3J0IHNlcnZpY2UgZHJpdmVyIGF0dGFjaGVkIHRvIHRoZSBWTUQgcm9v
dCBwb3J0cywgYWxsb3dpbmcNCj4gPiBmb3INCj4gPiBmdXJ0aGVyIGtlcm5lbCBlcnJvciBoYW5k
bGluZyBpZiBkZXNpcmVkLg0KPiANCj4gVGhpcyBwYXRjaCBsb29rcyBtb3JlIGxpa2UgYSBwb2xp
Y3kgdG8gZGV0ZWN0IHdoZXRoZXIgdGhlIGdlbmVyaWMNCj4gUm9vdCBQb3J0IHN5c3RlbSBlcnJv
ciByZXBvcnRpbmcgc2hvdWxkIGJlIGVuYWJsZWQgb3Igbm90LCBvciBhdA0KPiBsZWFzdCBtYXkg
YmUgZ2VuZXJhbGl6ZWQgYXMgc3VjaC4NCj4gSXQgaXMgY29udGFpbmVkIGluIHRoZSBWTUQgZHJp
dmVyIC0gSSB3b3VsZCBsaWtlIHRvIGhhdmUgS2VpdGggYW5kDQo+IEJqb3JuDQo+IG9waW5pb25z
IGJlZm9yZSBtZXJnaW5nIGl0LCBzZWUgYmVsb3cuDQpJdCBpcyBpbmhlcmVudGx5IGEgcG9saWN5
IGRlY2lzaW9uIGJ5IHRoZSBCSU9TLg0KDQo+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEpvbiBEZXJy
aWNrIDxqb25hdGhhbi5kZXJyaWNrQGludGVsLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9w
Y2kvY29udHJvbGxlci92bWQuYyB8IDMwICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0K
PiA+ICAxIGZpbGUgY2hhbmdlZCwgMzAgaW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3ZtZC5jDQo+ID4gYi9kcml2ZXJzL3BjaS9jb250
cm9sbGVyL3ZtZC5jDQo+ID4gaW5kZXggNDZlZDgwZi4uOTYyNWRjYSAxMDA2NDQNCj4gPiAtLS0g
YS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3ZtZC5jDQo+ID4gKysrIGIvZHJpdmVycy9wY2kvY29u
dHJvbGxlci92bWQuYw0KPiA+IEBAIC01ODksNiArNTg5LDcgQEAgc3RhdGljIGludCB2bWRfZW5h
YmxlX2RvbWFpbihzdHJ1Y3Qgdm1kX2Rldg0KPiA+ICp2bWQsIHVuc2lnbmVkIGxvbmcgZmVhdHVy
ZXMpDQo+ID4gIAlMSVNUX0hFQUQocmVzb3VyY2VzKTsNCj4gPiAgCXJlc291cmNlX3NpemVfdCBv
ZmZzZXRbMl0gPSB7MH07DQo+ID4gIAlyZXNvdXJjZV9zaXplX3QgbWVtYmFyMl9vZmZzZXQgPSAw
eDIwMDAsIGJ1c25fc3RhcnQgPSAwOw0KPiA+ICsJdTggaW50ZXJmYWNlOw0KPiA+ICANCj4gPiAg
CS8qDQo+ID4gIAkgKiBTaGFkb3cgcmVnaXN0ZXJzIG1heSBleGlzdCBpbiBjZXJ0YWluIFZNRCBk
ZXZpY2UgaWRzDQo+ID4gd2hpY2ggYWxsb3cNCj4gPiBAQCAtNzE4LDYgKzcxOSwzNSBAQCBzdGF0
aWMgaW50IHZtZF9lbmFibGVfZG9tYWluKHN0cnVjdCB2bWRfZGV2DQo+ID4gKnZtZCwgdW5zaWdu
ZWQgbG9uZyBmZWF0dXJlcykNCj4gPiAgCWRldl9zZXRfbXNpX2RvbWFpbigmdm1kLT5idXMtPmRl
diwgdm1kLT5pcnFfZG9tYWluKTsNCj4gPiAgCXBjaV9yZXNjYW5fYnVzKHZtZC0+YnVzKTsNCj4g
PiAgDQo+ID4gKwkvKg0KPiA+ICsJICogQ2VydGFpbiBWTUQgZGV2aWNlcyBtYXkgcmVxdWVzdCBm
aXJtd2FyZS1maXJzdCBlcnJvcg0KPiA+IGhhbmRsaW5nDQo+ID4gKwkgKiBzdXBwb3J0IG9uIHRo
ZSBkb21haW4uIFRoZXNlIGRvbWFpbnMgYXJlIHZpcnR1YWwgYW5kDQo+ID4gbm90IGRlc2NyaWJl
ZA0KPiA+ICsJICogYnkgQUNQSSBhbmQgbXVzdCBiZSBjb25maWd1cmVkIG1hbnVhbGx5LiBWTUQg
ZG9tYWlucw0KPiA+IHdoaWNoIHV0aWxpemUNCj4gPiArCSAqIGZpcm13YXJlLWZpcnN0IG1heSBz
dGlsbCByZXF1aXJlIGZ1cnRoZXIga2VybmVsIGVycm9yDQo+ID4gaGFuZGxpbmcsIGJ1dA0KPiA+
ICsJICogdGhlIGRvbWFpbiBpcyBpbnRlbmRlZCB0byBmaXJzdCBpbnRlcnJ1cHQgdXBvbiBlcnJv
ciB0bw0KPiA+IHN5c3RlbQ0KPiA+ICsJICogZmlybXdhcmUgYmVmb3JlIGJlaW5nIHBhc3NlZCBi
YWNrIHRvIHRoZSBrZXJuZWwuIFRoZQ0KPiA+IHN5c3RlbSBlcnJvcg0KPiA+ICsJICogaGFuZGxp
bmcgYml0cyBpbiB0aGUgcm9vdCBwb3J0IGNvbnRyb2wgcmVnaXN0ZXIgbXVzdCBiZQ0KPiA+IGVu
YWJsZWQNCj4gPiArCSAqIGZvbGxvd2luZyB0aGUgQUVSIHNlcnZpY2UgZHJpdmVyIGNvbmZpZ3Vy
YXRpb24gaW4gb3JkZXINCj4gPiB0byBnZW5lcmF0ZQ0KPiA+ICsJICogdGhlc2Ugc3lzdGVtIGlu
dGVycnVwdHMuDQo+ID4gKwkgKg0KPiA+ICsJICogQmVjYXVzZSB0aGUgcm9vdCBwb3J0cyBhcmUg
bm90IGRlc2NyaWJlZCBieSBBQ1BJIGFuZA0KPiA+IF9PU0MgaXMNCj4gPiArCSAqIHVuc3VwcG9y
dGVkIGluIFZNRCBkb21haW5zLCB0aGUgaW50ZW50IHRvIHVzZSBmaXJtd2FyZS0NCj4gPiBmaXJz
dCBlcnJvcg0KPiA+ICsJICogaGFuZGxpbmcgaW4gdGhlIHJvb3QgcG9ydHMgaXMgaW5zdGVhZCBk
ZXNjcmliZWQgYnkgdGhlDQo+ID4gVk1EIGRldmljZSdzDQo+ID4gKwkgKiBpbnRlcmZhY2UgYml0
Lg0KPiA+ICsJICovDQo+ID4gKwlwY2lfcmVhZF9jb25maWdfYnl0ZSh2bWQtPmRldiwgUENJX0NM
QVNTX1BST0csDQo+ID4gJmludGVyZmFjZSk7DQo+ID4gKwlpZiAoaW50ZXJmYWNlID09IDB4MSkg
ew0KPiA+ICsJCXN0cnVjdCBwY2lfZGV2ICpycGRldjsNCj4gPiArDQo+ID4gKwkJbGlzdF9mb3Jf
ZWFjaF9lbnRyeShycGRldiwgJnZtZC0+YnVzLT5kZXZpY2VzLA0KPiA+IGJ1c19saXN0KSB7DQo+
ID4gKwkJCWlmIChycGRldi0+YWVyX2NhcCkNCj4gDQo+IFRoaXMgc2hvdWxkIGJlIENPTkZJR19Q
Q0lFQUVSIGd1YXJkZWQgYnV0IEkgd291bGQgbGlrZSB0byB1bmRlcnN0YW5kDQo+IGl0cw0KPiBs
b2dpYy4NCkkgdGhpbmsgd2Ugc2hvdWxkIGNvbnNpZGVyIGFsbG93aW5nIGl0IGZvciBDT05GSUdf
UENJRUFFUj1uLiBUaGUNCmZpcm13YXJlIHNob3VsZCBiZSBhYmxlIHRvIHRyeSBhbmQgbWFuYWdl
IHRoZSBlcnJvciBldmVuIGlmIGl0IG9jY3Vycw0Kd2hlbiBuYXRpdmUgYWVyIGlzbid0IGJ1aWx0
LWluLiBJdCB3b3VsZCBiZSB3b3JzZSBpbiB0aGF0IHJlc3BlY3QgaWYNCnRoZSBlcnJvciB3ZW50
IGxlZnQgdW5jaGVja2VkLg0KDQoNCj4gSUlVQyB0aGlzIGFzc3VtZXMgYWxsIGRldmljZXMgaW4g
dGhlIHJvb3QgYnVzIGFyZSByb290IHBvcnRzLCB3aGljaA0KPiBpcw0KPiBhbiBWTUQgYXNzdW1w
dGlvbiBJIHJlY2tvbi4NClRoYXQncyB0cnVlIGZvciB0aGUgVk1EIGhhcmR3YXJlIHNvIGZhci4g
V2UgZG9uJ3QgZXhwZWN0IGFueSBkZXZpY2VzDQpiZXNpZGVzIHJvb3QgcG9ydHMgb24gdGhlIHJv
b3QgYnVzLg0KDQpJIHdvdWxkIHJhdGhlciBkcm9wIHRoZSBkZXYtPmFlcl9jYXAgY2hlY2ssIGJ1
dCBJIGNhbiBhZGQgYQ0KcGNpX3BjaWVfdHlwZShkZXYpID09IFBDSV9FWFBfVFlQRV9ST09UX1BP
UlQgY2hlY2sNCg0KPiANCj4gDQo+ID4gKwkJCQlwY2llX2NhcGFiaWxpdHlfc2V0X3dvcmQocnBk
ZXYsDQo+ID4gUENJX0VYUF9SVENUTCwNCj4gPiArCQkJCQkJCSBQQ0lfRVhQX1INCj4gPiBUQ1RM
X1NFQ0VFICB8DQo+ID4gKwkJCQkJCQkgUENJX0VYUF9SDQo+ID4gVENUTF9TRU5GRUUgfA0KPiA+
ICsJCQkJCQkJIFBDSV9FWFBfUg0KPiA+IFRDVExfU0VGRUUpOw0KPiANCj4gSSB3b25kZXIgd2hl
dGhlciB0aGlzIGNvZGUgc2hvdWxkIGJlIHBhcnQgb2YgdGhlIGdlbmVyaWMgQUVSIGxheWVyDQo+
IChpZQ0KPiB0aGUgUENJRSBwb3J0IGRyaXZlcikgcmF0aGVyIHRoYW4gVk1EIHNwZWNpZmljLCBh
ZnRlciBhbGwgdGhhdCdzIHBhcnQNCj4gb2YNCj4gdGhlIGdlbmVyaWMgc3BlY2lmaWNhdGlvbnMs
IEkgZG8gbm90IGtub3cgaWYgd2UgY2FuIGVudmlzYWdlIGFuIEFQSQ0KPiB0aGF0DQo+IGFsbG93
IFBDSSBjb250cm9sbGVyIGRyaXZlcnMgdG8gZW5hYmxlL2Rpc2FibGUgc3lzdGVtIGVycm9ycy4N
Cj4gDQo+IFRob3VnaHRzID8NCj4gDQo+IExvcmVuem8NCkkgZGlkIGNvbnNpZGVyIHRoaXMgb3B0
aW9uIGZpcnN0Lg0KVGhlcmUncyBhIGNhbGwgaW4gYWVyLmMgdG8gZGlzYWJsZSB0aGVzZSBiaXRz
LCBzbyB0aGUgQVBJIG5lZWQgaGFzDQpwcmVjZW5kZW5jZS4NCg0KV2Ugd291bGQgbmVlZCB0aGlz
IEFQSSByZWFjaGFibGUgYnkgdm1kLmMuIEl0IHNlZW1zIGVhc2llc3QgdG8gaW5saW5lDQppbiBw
Y2kuaC4NCg0KPiANCj4gPiArCQl9DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICAJV0FSTihzeXNmc19j
cmVhdGVfbGluaygmdm1kLT5kZXYtPmRldi5rb2JqLCAmdm1kLT5idXMtDQo+ID4gPmRldi5rb2Jq
LA0KPiA+ICAJCQkgICAgICAgImRvbWFpbiIpLCAiQ2FuJ3QgY3JlYXRlIHN5bWxpbmsgdG8NCj4g
PiBkb21haW5cbiIpOw0KPiA+ICAJcmV0dXJuIDA7DQo+ID4gLS0gDQo+ID4gMS44LjMuMQ0KPiA+
IA==
