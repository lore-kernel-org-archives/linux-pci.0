Return-Path: <SRS0=wh2u=NR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE00CC32789
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 19:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 425DC20862
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 19:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="fNZvqeoe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 425DC20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=impinj.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbeKGFHK (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 7 Nov 2018 00:07:10 -0500
Received: from mail-eopbgr700133.outbound.protection.outlook.com ([40.107.70.133]:6071
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725776AbeKGFHK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Nov 2018 00:07:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EBhjo1mqsV/BOl8OPLY+Co+yHIIRCx/FBJ1/JxT9sfM=;
 b=fNZvqeoeeiKs5xyMu8sTohWgPn0TBlpBhilRxrmv7VL4eP3DYEnBOYqlZ2T91fBnHVeJ/71YyCwBP2C0IR7k00hh/cPjnVC8GlqAQX6BcFUA3FkXEZONK41yujcEuQj3hi2deL2dJrrQS0BZsIIYMGH20kWoGm2UW2R7oqgcysg=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3676.namprd06.prod.outlook.com (10.167.236.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.28; Tue, 6 Nov 2018 19:40:18 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::f51a:d8dd:1aad:3bf9]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::f51a:d8dd:1aad:3bf9%3]) with mapi id 15.20.1294.034; Tue, 6 Nov 2018
 19:40:18 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     "jpinto@synopsys.com" <jpinto@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "faiz_abbas@ti.com" <faiz_abbas@ti.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>
Subject: Re: [PATCH] PCI: dwc: Fix interrupt race in when handling MSI
Thread-Topic: [PATCH] PCI: dwc: Fix interrupt race in when handling MSI
Thread-Index: AQHUbYgjUY6vVpEq1Ees3VO0f7sjeaVC5fqAgAASigCAAD2CgA==
Date:   Tue, 6 Nov 2018 19:40:18 +0000
Message-ID: <1541533217.30311.263.camel@impinj.com>
References: <20181027000028.21343-1-tpiepho@impinj.com>
         <20181106145347.GB19060@e107981-ln.cambridge.arm.com>
         <db3462e2-422c-161a-1f58-135bc4eab7eb@arm.com>
In-Reply-To: <db3462e2-422c-161a-1f58-135bc4eab7eb@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3676;6:Xg6afFpVGPHDn/r+DY/5HmiSF4zrC6EFA1yVyu8fzMstXo0iXdsqoNtirm1+WVgAdU2s4h/Zot5EOJd1tmB1c5Fvi+hhuqCT4dISfJnYjeVjQWUZ6TLv2mCRWbkufcQDVFuiW1XPSdrMoESYu2ULij+T2eF02lYRwoT+pCyI+JvcnaVcg5JOdKhKaY+IbADsEcTT5L+Wj28tybIQowMr72Zs0Fr1UOSXSASfjFbXQ6Vuigm0djgLeoko2pUqUGAdlzk9ZwpBNPx42rhKBOmga9hu8Vm9c/Y5KYTDruShklZt9QdIdjWBJNMMnECy/8kVLazj2tSUR88nnqZYFoQX0xd6kZyusKOnjXhFVzMgSUECPoe4Tqsuit7BgIfuHrEFJ1lXIBTi9MmuQnFrYGHQ3VrI+LJeKlcA7yO8cI5Pt3LZN1gyuFlO6dzJAgwxySMnDkewzkuZko3jYNyGwaCJ4w==;5:eI3Ln1+ZyZbRu/7qD1GJ131uuw9KbMEEZ1DBrmTQSmzrwz+cDh11CNy7H1QVCB08cFjzGl3NO9hPH+LzLSO9hb2ZmKxDJsyKaQAc1dB9uXrA5RN+tnIu9EpfEeqD83ZQ5XcJgUQx4G5CzNjNHsMikHRCs9y8giChnYkhircvi8A=;7:NZU6s113D4rTWFjsNTx44FKZjc97T0AVZmv+Tgu9+9RwbH47cAYIrKOUB7pDfGS6yOZwkhEr74hfMTdUO+le1CZKjZYws0VGm4X+XoysUR+HQVStzhDLbgbcX+CraOiGx0nDHlcjUvboF7zII82qMA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: e5e619cd-05d8-4c0d-a985-08d6441faea7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3676;
x-ms-traffictypediagnostic: MWHPR0601MB3676:
x-microsoft-antispam-prvs: <MWHPR0601MB3676E4A21C35579733A9BE79D3CB0@MWHPR0601MB3676.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:MWHPR0601MB3676;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0601MB3676;
x-forefront-prvs: 0848C1A6AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(346002)(39840400004)(376002)(199004)(189003)(4326008)(6116002)(66066001)(3846002)(486006)(6436002)(6512007)(2616005)(36756003)(26005)(476003)(99286004)(2501003)(14454004)(305945005)(105586002)(5660300001)(106356001)(68736007)(71200400001)(71190400001)(229853002)(81156014)(446003)(8676002)(81166006)(54906003)(7736002)(186003)(11346002)(53936002)(76176011)(2906002)(8936002)(103116003)(39060400002)(25786009)(6246003)(2900100001)(86362001)(6486002)(256004)(478600001)(110136005)(102836004)(97736004)(316002)(6506007)(7416002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3676;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: T0DduQAa8LHMHMVjhL3/JQRgzcRqGd0K4LZHcd8yyhXq4rD70hQio8U4JSN6mrE4YhpnNHrIpIauytitpI2hDpmTswSvPzMGheun+2eXoqBM6MwqqPq+IEoIEGzQXv1ukE0AbIVu2N9GO3lOIEqy86KyT6IQJAdQ9X2obUZp2hLVycv2jcqedwCG5FMv4a2iALh9GisWusAGlNHUkj9F+21/+/cUNcaJE9hKEPpR5Hv14nN1W3pqTarUnPNCDCulllb0/DToJmzm0zkzyATvF1E+P5GqslBM4tV4f5h3vbbP91jVXykIXEZ1TfW/j1b+ScGeMYd4fyeq+tbTUtl0bcaZ3nQlN4iXH/AIoLjtD3U=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <8FEEE2EF7D12D7469FD4578E1702BF2B@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5e619cd-05d8-4c0d-a985-08d6441faea7
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2018 19:40:18.2971
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3676
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVHVlLCAyMDE4LTExLTA2IGF0IDE2OjAwICswMDAwLCBNYXJjIFp5bmdpZXIgd3JvdGU6DQo+
IA0KPiBJdCBpcyBoYXJkIHRvIGRlY2lkZSB3aGF0IHRoZSByaWdodCBzb2x1dGlvbiBpcyB3aXRo
b3V0IHVuZGVyc3RhbmRpbmcNCj4gZXhhY3RseSB3aGF0IHRoaXMgcGFydGljdWxhciB3cml0ZSBh
Y3R1YWxseSBkb2VzLiBJdCBzZWVtcyB0byBiZSBzb21lDQo+IGZvcm0gb2YgYWNrbm93bGVkZ2Vt
ZW50LCBidXQgSSdtIG9ubHkgbWFraW5nIGFuIGVkdWNhdGVkIGd1ZXNzLCBhbmQgc29tZQ0KPiBv
ZiB0aGUgZGVmaW5lcyBzdWdnZXN0IHRoYXQgdGhlcmUgbWlnaHQgYmUgYW5vdGhlciByZWdpc3Rl
ciBmb3IgdGhhdC4NCg0KVW5mb3J0dW5hdGVseSwgdGhlcmUgYXJlIG5vIGRvY3MgZm9yIHRoaXMg
Y29udHJvbGxlci4gIEkndmUgZGV0ZXJtaW5lZA0KdGhhdCBpdCBzZXRzIGEgYml0IGluIHRoaXMg
cmVnaXN0ZXIgd2hlbiBhbiBNU0kgaXMgcmVjZWl2ZWQuICBPbmNlIHNldCwNCml0IGFjdHMgYXMg
YSBtYXNrIGFuZCB0aGUgY29udHJvbGxlciB3aWxsIGdlbmVyYXRlIG5vIGludGVycnVwdHMgd2hl
bg0KdGhlIHNhbWUgTVNJIGlzIHN1YnNlcXVlbnRseSByZWNlaXZlZC4gIFdyaXRpbmcgYSAxIHRv
IGEgYml0IGNsZWFycw0KdGhhdCBtYXNrIGJpdCwgb2J2aW91c2x5IHNvIHRoYXQgZWFjaCBiaXQg
Y2FuIGJlIGNsZWFyZWQgYXRvbWljYWxseSB2cw0KYSBub24tYXRvbWljIFJNVy4gIFRoZSBjb250
cm9sbGVyIGRvZXMgbm90IHF1ZXVlIGFueSBNU0lzIHJlY2VpdmVkDQp3aGlsZSB0aGUgaW50ZXJy
dXB0IHdhcyBtYXNrZWQuDQoNCj4gDQo+IFdoYXQgSSdtIGludGVyZXN0ZWQgaW4gaXMgdGhlIHJl
bGF0aW9uc2hpcCB0aGlzIGhhcyB3aXRoIHRoZSBtYXNrL3VubWFzaw0KPiBjYWxsYmFja3MsIGFu
ZCB3aGV0aGVyIG1hc2tpbmcgdGhlIGludGVycnVwdCBiZWZvcmUgYWNraW5nIGl0IHdvdWxkIGhl
bHAuDQoNCg0KPiANCj4gR3VzdGF2bywgY2FuIHlvdSBoZWxwIGhlcmU/DQo+IA0KPiBJbiBhbnkg
d2F5LCBtb3ZpbmcgdGhlIGFjdGlvbiBvZiBhY2tub3dsZWRnaW5nIHRoZSBpbnRlcnJ1cHQgdG8g
aXRzDQo+IHJpZ2h0IHNwb3QgaW4gdGhlIGtlcm5lbCAoZHdfcGNpX2JvdHRvbV9hY2spIHdvdWxk
IGJlIGEgZ29vZCBzdGFydC4NCg0KV2hhdCBhYm91dCBzdGFibGUga2VybmVscyB0aGF0IGRvbid0
IGhhdmUgdGhlIGhpZXJhcmNoaWNhbCBBUEk/
