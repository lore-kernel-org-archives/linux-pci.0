Return-Path: <SRS0=/WWX=OG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B30C43441
	for <linux-pci@archiver.kernel.org>; Tue, 27 Nov 2018 17:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4539020659
	for <linux-pci@archiver.kernel.org>; Tue, 27 Nov 2018 17:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="MTNVvztA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4539020659
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=impinj.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731229AbeK1EWQ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 27 Nov 2018 23:22:16 -0500
Received: from mail-eopbgr770119.outbound.protection.outlook.com ([40.107.77.119]:44890
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731032AbeK1EWQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Nov 2018 23:22:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uA4USytzxzdkF7fu+nEZqtQ8r5p17kThdLugKaDVx3g=;
 b=MTNVvztAVLgZ+a6auyQ7948GhhWvnRTKmicRudw6czA/2MqoZG/nbM39gvQEAQTkxjaDft3vGvFflTc7dVN8kMmu6EAnS6J19ec79hFMIP0vSzYODXbJ8eQaCzg36eC9ED57h4qugTk88cFl1SSdQSeOr/BK42v0eaSriqn7IkI=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3771.namprd06.prod.outlook.com (10.167.236.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Tue, 27 Nov 2018 17:23:38 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::c0f3:ea8f:48ba:a5d7]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::c0f3:ea8f:48ba:a5d7%4]) with mapi id 15.20.1361.019; Tue, 27 Nov 2018
 17:23:38 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "marc.zyngier@arm.com" <marc.zyngier@arm.com>
CC:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "faiz_abbas@ti.com" <faiz_abbas@ti.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "helgaas@google.com" <helgaas@google.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>
Subject: Re: [PATCH 0/3] PCI: designware: Fixing MSI handling flow
Thread-Topic: [PATCH 0/3] PCI: designware: Fixing MSI handling flow
Thread-Index: AQHUe6RNjvB+uYCyEUiVT8YH/lgHCqVOVoyAgACySICADLahgIAASXEAgAADZ4CABkBzgIABCB2AgACft4A=
Date:   Tue, 27 Nov 2018 17:23:38 +0000
Message-ID: <1543339417.18519.53.camel@impinj.com>
References: <20181113225734.8026-1-marc.zyngier@arm.com>
         <e73891a5-d798-ee9c-607c-9648d07f6505@synopsys.com>
         <86a7mcdlwg.wl-marc.zyngier@arm.com>
         <9b63c20b-f928-7c40-2734-00ed783625f5@synopsys.com>
         <20181122162616.GA17826@e107981-ln.cambridge.arm.com>
         <1d83d4e5-3cfc-3fc4-f875-c25b5ae3284f@arm.com>
         <1543248401.18519.24.camel@impinj.com> <86bm6brm8w.wl-marc.zyngier@arm.com>
In-Reply-To: <86bm6brm8w.wl-marc.zyngier@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3771;6:dxXCp8dP4Ws5bjmEHTqbId9h+EOoedqtdcBFfIEW5Y+ich/zReOASLs+YQx4AYZdE3SyKLLMQBARABWTBE+sXi/m4uRxRnF1OBhVj3sy0dHTx+nAR+Upai8XBG5t7MB6QiGnPI7UbyERlr2Ee/lC7B8X2DL8GFkPusirf3OAfuwruqhs0aWy+q9lIEFcLQwoYTpVe0ogs3pwU3jdzifdCw8hpy/6Y8B8naUtK0uNm1wR8KKF8KsOZuYiI60hXA6QcWIr0fWcbx8E2nGc5ZutA3VEaWalRboltA4mjGPn1u4DNxuvE1ulYjHkM4LKSsAsQTG1YRKEpMa9dQIIe2ppjnzH9zcaGm5cbTg+tBTYQybMwxD0B0WXT3vYJESppv2fh2LFwxEiwWSqFnLt3Skb1WxwUrPU6AHvt0w5fUx39ps/RFboDimk8ouJqa7zJoKJ0tjzOE+3uuiwY9aJlYrgBA==;5:qLiCpW/YEmIYOYSwLYvL57aq3Eonw/0xnz0+j9iXTRTXG5l/GeiFSB61/fip+jkjjR5CIf2DFX8IyI2iDKIyNdLrq+giBuOZohTZOv3NKJvFo6iNstHOhogEPiMAK5yNemTVGPGZjgmuXsraUFDBQqnEW4YWdLjSHijEtNEA2LY=;7:DDRewJCEVws/X7Y1Zu0MvfDhugbWrLCjqnVNzevVBAWzbOtEen4uw43JiEjn65TWME0shydW6yAR88FYyVMlfLGukI2O0NYG6umwlNDMwXJP9K4ca/xzW+CdVoySN0YRG4aDGSXtO4ik6W90Z3yK7Q==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 88126084-008a-45cc-f0c3-08d6548d11a3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3771;
x-ms-traffictypediagnostic: MWHPR0601MB3771:
x-microsoft-antispam-prvs: <MWHPR0601MB377111F12CE27CC9106E4F16D3D00@MWHPR0601MB3771.namprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231443)(944501410)(52105112)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:MWHPR0601MB3771;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0601MB3771;
x-forefront-prvs: 086943A159
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(346002)(366004)(39850400004)(136003)(199004)(189003)(2906002)(8936002)(25786009)(103116003)(305945005)(8676002)(4326008)(7736002)(53936002)(6916009)(5660300001)(68736007)(5640700003)(39060400002)(229853002)(6116002)(256004)(81156014)(6246003)(6512007)(81166006)(478600001)(3846002)(76176011)(4001150100001)(486006)(99286004)(54906003)(66066001)(71190400001)(71200400001)(93886005)(86362001)(2351001)(2501003)(105586002)(316002)(102836004)(26005)(14454004)(186003)(106356001)(476003)(97736004)(2616005)(11346002)(446003)(6486002)(6436002)(36756003)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3771;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: hpMGmCi7q/bH+psRIO3VulaRrUF/T50ctC91MzidU1DnSyq+hPXbeHNCwnIr5GRuUBE1muMtRXTooQWK7WugmA/4WP9vgHmu4gJO9OvD+Aa5M38zAXT/+yHzyQvuQYexGBN61xFdln6t3z36uG253fn5jeK8ThTCjCrcldhi+mH6Jk5feuz2ObPVxMktY+Zl32CXhAWXSTdIW2doTbJz5vnqsRyklewJ9ECNyOA4b4M6qzjfRwWKWCvirChKKLY7lC06CxZicuT43I5MoP+9QO4S2zyT8U+rJSwgYqps6tOhzC6/ck97Oe3FGm48F9BhdQrE+3tEARVOSi/e+nMX9LGDRM5yvGN59Bo4v0UIrmk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <6F0810AF194D0B4F814537D3914E3DD1@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88126084-008a-45cc-f0c3-08d6548d11a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2018 17:23:38.0551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3771
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVHVlLCAyMDE4LTExLTI3IGF0IDA3OjUxICswMDAwLCBNYXJjIFp5bmdpZXIgd3JvdGU6DQo+
IE9uIE1vbiwgMjYgTm92IDIwMTggMTY6MDY6NTQgKzAwMDAsDQo+IFRyZW50IFBpZXBobyA8dHBp
ZXBob0BpbXBpbmouY29tPiB3cm90ZToNCj4gPiANCj4gPiBPbiBUaHUsIDIwMTgtMTEtMjIgYXQg
MTY6MzggKzAwMDAsIE1hcmMgWnluZ2llciB3cm90ZToNCj4gPiA+IA0KPiA+ID4gVG8gYWRkIHRv
IExvcmVuem8ncyBjb21tZW50LCB3ZSdyZSB0cnlpbmcgaGFyZCB0byBoYXZlIGENCj4gPiA+ICpt
aW5pbWFsKiBmaXgNCj4gPiA+IHRoYXQgY2FuIGJlIGVhc2lseSBiYWNrcG9ydGVkLiBDaGFuZ2lu
ZyB2YXJpYWJsZSBhbmQgZmllbGQgbmFtZXMNCj4gPiA+IGFzIHdlbGwNCj4gPiA+IGFzIGZsaXBw
aW5nIHRoZSBzZW1hbnRpYyBvZiBvdGhlciBiaXRzIG9mIHRoZSBkcml2ZXIgbWFrZXMgaXQNCj4g
PiA+IGhhcmRlciB0bw0KPiA+ID4gcmV2aWV3LCBhbmQgY2VydGFpbmx5IGRvZXNuJ3QgaGVscCBn
ZXR0aW5nIHRoaW5ncyBiYWNrcG9ydGVkIHRvDQo+ID4gPiBzdGFibGUNCj4gPiA+IChzZWUgdGhl
IHN0YWJsZSBrZXJuZWwgcnVsZXMpLg0KPiA+ID4gDQo+ID4gPiBJJ2Qgc3VnZ2VzdCB0aGlzIGtp
bmQgb2YgcmVwYWludGluZyBpcyBiZXR0ZXIga2VwdCBhcyBhIHNlcGFyYXRlDQo+ID4gPiBwYXRj
aA0KPiA+ID4gYW5kIG1lcmdlZCBzZXBhcmF0ZWx5Lg0KPiA+IA0KPiA+IElmIHlvdSB3YW50IGEg
bWluaW1hbCBmaXggdG8gYmFja3BvcnQsIHlvdSBzaG91bGQganVzdCB1c2UgbXkgb3JpZ2luYWwN
Cj4gPiBwYXRjaCBmb3IgNC4xNS00LjE5IHN0YWJsZSBzZXJpZXMuICBJdCdzIGEgb25lIGxpbmUg
Y2hhbmdlIHRvIGZpeCB0aGUNCj4gPiByZWFsIGJ1Zy4NCj4gPiANCj4gPiBJdCdsbCBiZSBmYXIg
ZWFzaWVyIHRvIGJhY2twb3J0IHRvIDwgNC4xNywgIHdoZXJlIHRoZSBoaWVyYXJjaGljYWwgaXJx
DQo+ID4gZG9tYWluIHN0dWZmIHdhc24ndCB1c2VkIGluIHRoaXMgcGFydCBvZiB0aGUgZHJpdmVy
Lg0KPiANCj4gVGhlIHJpZ2h0IGZpeCBpcyB0byBjcmVhdGUgYW4gaXJxX2FjayBtZXRob2QgYW5k
IHB1dCB0aGUgcmVsZXZhbnQgY29kZQ0KPiB0aGVyZS4NCg0KRmluZS4NCg0KQnV0IHRoZSBpcnEg
ZG9tYWluIHN0dWZmIHNob3VsZCBnbyBpbnRvIHRoZSBzdGFibGUgNC4xNSBhbmQgNC4xNg0Ka2Vy
bmVscy4gIEl0J3Mgbm90IGEgZml4IGFuZCBpdCBjaGFuZ2VzIGJlaGF2aW9yIGluIGhvdyB0aGUg
aW50ZXJydXB0cw0KbG9vayBpbiAvcHJvYyBzaWduaWZpY2FudGx5Lg0K
