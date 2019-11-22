Return-Path: <SRS0=vAAV=ZO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7FDC432C0
	for <linux-pci@archiver.kernel.org>; Fri, 22 Nov 2019 16:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DF482071C
	for <linux-pci@archiver.kernel.org>; Fri, 22 Nov 2019 16:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbfKVQ1p (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 22 Nov 2019 11:27:45 -0500
Received: from mga05.intel.com ([192.55.52.43]:25109 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727336AbfKVQ1p (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 Nov 2019 11:27:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Nov 2019 08:27:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,230,1571727600"; 
   d="scan'208";a="238658667"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by fmsmga002.fm.intel.com with ESMTP; 22 Nov 2019 08:27:43 -0800
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.229]) by
 ORSMSX108.amr.corp.intel.com ([169.254.2.82]) with mapi id 14.03.0439.000;
 Fri, 22 Nov 2019 08:27:43 -0800
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "kbusch@kernel.org" <kbusch@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Remove Keith from VMD maintainer
Thread-Topic: [PATCH] MAINTAINERS: Remove Keith from VMD maintainer
Thread-Index: AQHVoVF0of06QKsFF0m1wqGz9CTGmqeX5wAA
Date:   Fri, 22 Nov 2019 16:27:43 +0000
Message-ID: <5364bafc4b61e66ff7734ab805abd14d5fa2a5c9.camel@intel.com>
References: <20191122162501.27018-1-kbusch@kernel.org>
In-Reply-To: <20191122162501.27018-1-kbusch@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.232.115.147]
Content-Type: text/plain; charset="utf-8"
Content-ID: <012A9E1E17502F418C95583D3506EDF0@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

TkFLISBKdXN0IGtpZGRpbmcuLg0KDQpBY2tlZC1ieTogSm9uIERlcnJpY2sgPGpvbmF0aGFuLmRl
cnJpY2tAaW50ZWwuY29tPg0KDQpPbiBTYXQsIDIwMTktMTEtMjMgYXQgMDE6MjUgKzA5MDAsIEtl
aXRoIEJ1c2NoIHdyb3RlOg0KPiBJIG5vIGxvbmdlciB3b3JrIGluIHRoaXMgY2FwYWNpdHkgb24g
dGhlIFZNRCBkcml2ZXIuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBLZWl0aCBCdXNjaCA8a2J1c2No
QGtlcm5lbC5vcmc+DQo+IC0tLQ0KPiAgTUFJTlRBSU5FUlMgfCAxIC0NCj4gIDEgZmlsZSBjaGFu
Z2VkLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvTUFJTlRBSU5FUlMgYi9NQUlO
VEFJTkVSUw0KPiBpbmRleCBlNGYxNzBkOGJjMjkuLjA2NDMzMzYwN2ZlYiAxMDA2NDQNCj4gLS0t
IGEvTUFJTlRBSU5FUlMNCj4gKysrIGIvTUFJTlRBSU5FUlMNCj4gQEAgLTEyNDUzLDcgKzEyNDUz
LDYgQEAgRjoJRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9mc2wsaW14NnEt
cGNpZS50eHQNCj4gIEY6CWRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjLyppbXg2Kg0KPiAgDQo+
ICBQQ0kgRFJJVkVSIEZPUiBJTlRFTCBWT0xVTUUgTUFOQUdFTUVOVCBERVZJQ0UgKFZNRCkNCj4g
LU06CUtlaXRoIEJ1c2NoIDxrZWl0aC5idXNjaEBpbnRlbC5jb20+DQo+ICBNOglKb25hdGhhbiBE
ZXJyaWNrIDxqb25hdGhhbi5kZXJyaWNrQGludGVsLmNvbT4NCj4gIEw6CWxpbnV4LXBjaUB2Z2Vy
Lmtlcm5lbC5vcmcNCj4gIFM6CVN1cHBvcnRlZA0K
