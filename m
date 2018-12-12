Return-Path: <SRS0=ZQeV=OV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A35CC04EB8
	for <linux-pci@archiver.kernel.org>; Wed, 12 Dec 2018 13:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC9D220849
	for <linux-pci@archiver.kernel.org>; Wed, 12 Dec 2018 13:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Pqz76G3F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC9D220849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbeLLNjs (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 12 Dec 2018 08:39:48 -0500
Received: from smtprelay2.synopsys.com ([198.182.60.111]:40248 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbeLLNjs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Dec 2018 08:39:48 -0500
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id C007D10C1845;
        Wed, 12 Dec 2018 05:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1544621987; bh=116vZpCq8fFyRY5dxK2HkOBrZ0ERuxabGGu7xsvKkXY=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Pqz76G3Fmy99TgbjquaruqRTKUOl65AZQqf6Js9drfrJf3n7qaOC3eKcvCavU57F9
         UFhTyZtHsmlCnBK3dgRvDtCLVKuTA3QlfpIMk/I6wM5ZBF2bw/s0elYt8whGrPHhh2
         Uby4/tFTXboxY6zwTRi4zmMCqAv16MfQZfeUlF2dSa04RTZRCpO/I3daqOzajXCFTK
         rg2ANhiFrR0m2o20J67DRxEyvu6piod8EatPsfHk1gsykIT5XDj8KFHylQ5xyyniSh
         Wx4dnaY+MMPNdJVWX74A7FxS1WtkVK2m1JubOKklMpdcqzgqO2FfgWCpm9lrlBUMys
         unL+wCs4ZOjLw==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id 86461386A;
        Wed, 12 Dec 2018 05:39:47 -0800 (PST)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 12 Dec 2018 05:39:47 -0800
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCB.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Wed,
 12 Dec 2018 14:39:45 +0100
From:   Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
To:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>
CC:     "vkoul@kernel.org" <vkoul@kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        Joao Pinto <joao.pinto@synopsys.com>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>
Subject: Re: [RFC 2/6] dma: Add Synopsys eDMA IP version 0 support
Thread-Topic: [RFC 2/6] dma: Add Synopsys eDMA IP version 0 support
Thread-Index: AQHUkgvLbXgM69oMY0mwcujtMNdcAKV7C2uA
Date:   Wed, 12 Dec 2018 13:39:44 +0000
Message-ID: <1544621983.3270.26.camel@synopsys.com>
References: <cover.1544610287.git.gustavo.pimentel@synopsys.com>
         <bb2574d32c7aeb332c79436655f5ab1f9bac540e.1544610287.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <bb2574d32c7aeb332c79436655f5ab1f9bac540e.1544610287.git.gustavo.pimentel@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.121.3.66]
Content-Type: text/plain; charset="utf-8"
Content-ID: <7A443586DD964245BBCA7A02E86D9627@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgR3VzdGF2bywNCg0KT24gV2VkLCAyMDE4LTEyLTEyIGF0IDEyOjEzICswMTAwLCBHdXN0YXZv
IFBpbWVudGVsIHdyb3RlOg0KPiBBZGQgc3VwcG9ydCBmb3IgdGhlIGVETUEgSVAgdmVyc2lvbiAw
IGRyaXZlciBmb3IgYm90aCByZWdpc3RlciBtYXBzIChsZWdhY3kNCj4gYW5kIHVucm9sbCkuDQpb
c25pcF0NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZG1hL2R3LWVkbWEvZHctZWRtYS12MC1jb3Jl
LmMgYi9kcml2ZXJzL2RtYS9kdy1lZG1hL2R3LWVkbWEtdjAtY29yZS5jDQo+IG5ldyBmaWxlIG1v
ZGUgMTAwNjQ0DQo+IGluZGV4IDAwMDAwMDAuLmNjMzYyYjANCj4gLS0tIC9kZXYvbnVsbA0KPiAr
KysgYi9kcml2ZXJzL2RtYS9kdy1lZG1hL2R3LWVkbWEtdjAtY29yZS5jDQo+IEBAIC0wLDAgKzEs
MzQ2IEBADQo+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPiArLy8gQ29w
eXJpZ2h0IChjKSAyMDE4IFN5bm9wc3lzLCBJbmMuIGFuZC9vciBpdHMgYWZmaWxpYXRlcy4NCj4g
Ky8vIFN5bm9wc3lzIERlc2lnbldhcmUgZURNQSB2MCBjb3JlDQo+ICsNCj4gKyNpbmNsdWRlICJk
dy1lZG1hLWNvcmUuaCINCj4gKyNpbmNsdWRlICJkdy1lZG1hLXYwLWNvcmUuaCINCj4gKyNpbmNs
dWRlICJkdy1lZG1hLXYwLXJlZ3MuaCINCj4gKyNpbmNsdWRlICJkdy1lZG1hLXYwLWRlYnVnZnMu
aCINCj4gKw0KPiArI2RlZmluZSBRV09SRF9ISSh2YWx1ZSkJCSgodmFsdWUgJiAweEZGRkZGRkZG
MDAwMDAwMDBsbHUpID4+IDMyKQ0KVXNlIHVwcGVyXzMyX2JpdHMoKSBtYWNyb3MuDQoNCj4gKyNk
ZWZpbmUgUVdPUkRfTE8odmFsdWUpCQkodmFsdWUgJiAweDAwMDAwMDAwRkZGRkZGRkZsbHUpDQpV
c2UgbG93ZXJfMzJfYml0cygpIG1hY3Jvcy4NCg0KPiArZW51bSBkd19lZG1hX2NvbnRyb2wgew0K
PiArCURXX0VETUFfQ0IJCT0gQklUKDApLA0KPiArCURXX0VETUFfVENCCQk9IEJJVCgxKSwNCj4g
KwlEV19FRE1BX0xMUAkJPSBCSVQoMiksDQo+ICsJRFdfRURNQV9MSUUJCT0gQklUKDMpLA0KPiAr
CURXX0VETUFfUklFCQk9IEJJVCg0KSwNCg0KDQpbc25pcF0NCj4gKwkJdmlld3BvcnRfc2VsID0g
KGNoICYgMHgwMDAwMDAwN3VsKTsNCltzbmlwXQ0KPiArdm9pZCBkd19lZG1hX3YwX2NvcmVfb2Zm
KHN0cnVjdCBkd19lZG1hICpkdykNCj4gK3sNCj4gKwlTRVRfQk9USChkdywgaW50X21hc2ssIDB4
MDBGRjAwRkZ1bCk7DQo+ICsJU0VUX0JPVEgoZHcsIGludF9jbGVhciwgMHgwMEZGMDBGRnVsKTsN
Cj4gKwlTRVRfQk9USChkdywgZW5naW5lX2VuLCAweDAwMDAwMDAwdWwpOw0KPiArfQ0KW3NuaXBd
DQo+ICsJCW51bV9jaCAmPSAweDAwMDAwMDBGdWw7DQo+ICsJfSBlbHNlIHsNCj4gKwkJbnVtX2No
ICY9IDB4MDAwRjAwMDB1bDsNCg0KSSBndWVzcyBpdCdzIGJldHRlciB0byBuYW1lIHRoaXMgbWFn
aWMgbnVtYmVycyB2aWEgZGVmaW5lcy4NCg0KDQpbc25pcF0NCg0KPiArDQo+ICtib29sIGR3X2Vk
bWFfdjBfY29yZV9zdGF0dXNfZG9uZV9pbnQoc3RydWN0IGR3X2VkbWFfY2hhbiAqY2hhbikNCj4g
K3sNCj4gKwlzdHJ1Y3QgZHdfZWRtYSAqZHcgPSBjaGFuLT5jaGlwLT5kdzsNCj4gKwl1MzIgdG1w
Ow0KPiArDQo+ICsJdG1wID0gR0VUX1JXKGR3LCBjaGFuLT5kaXIsIGludF9zdGF0dXMpOw0KPiAr
CXRtcCAmPSBCSVQoY2hhbi0+aWQpOw0KPiArDQo+ICsJcmV0dXJuIHRtcCA/IHRydWUgOiBmYWxz
ZTsNCg0KcmV0dXJuICEhdG1wOw0KDQo+ICt9DQo+ICsNCj4gK2Jvb2wgZHdfZWRtYV92MF9jb3Jl
X3N0YXR1c19hYm9ydF9pbnQoc3RydWN0IGR3X2VkbWFfY2hhbiAqY2hhbikNCj4gK3sNCj4gKwlz
dHJ1Y3QgZHdfZWRtYSAqZHcgPSBjaGFuLT5jaGlwLT5kdzsNCj4gKwl1MzIgdG1wOw0KPiArDQo+
ICsJdG1wID0gR0VUX1JXKGR3LCBjaGFuLT5kaXIsIGludF9zdGF0dXMpOw0KPiArCXRtcCAmPSBC
SVQoY2hhbi0+aWQgKyAxNik7DQo+ICsNCj4gKwlyZXR1cm4gdG1wID8gdHJ1ZSA6IGZhbHNlOw0K
ZGl0dG8uDQoNCi0tIA0KIEV1Z2VuaXkgUGFsdHNldg==
