Return-Path: <SRS0=6VBI=NY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 048C9C43441
	for <linux-pci@archiver.kernel.org>; Tue, 13 Nov 2018 06:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC32C21780
	for <linux-pci@archiver.kernel.org>; Tue, 13 Nov 2018 06:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="omTkLTW9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC32C21780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbeKMQFV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 13 Nov 2018 11:05:21 -0500
Received: from mail-eopbgr70073.outbound.protection.outlook.com ([40.107.7.73]:20400
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726535AbeKMQFV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Nov 2018 11:05:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GaIzCc7xdfG3GIfszpsVzS6/VHmKgsGTEhA4cGMhTXI=;
 b=omTkLTW9XGorB1tMbLffg/0eeFNO9giAIOlAMpt2sUeaD9KvxGNk/QRR7FOrAKaL94EDl3aPtU3DRPrGSpFIW54EtiBz0ORMcMgHJ1NwDZZOlafLz792f45Dt2P/y2MKpjzD020h/1NdHB+ysxgI5ERoRqnoz2wHV7SpWfNRKks=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.2.80) by
 AM6PR04MB5127.eurprd04.prod.outlook.com (20.177.34.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.32; Tue, 13 Nov 2018 06:08:44 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::7d93:8053:57fd:1a00]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::7d93:8053:57fd:1a00%3]) with mapi id 15.20.1294.045; Tue, 13 Nov 2018
 06:08:44 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "l.subrahmanya@mobiveil.co.in" <l.subrahmanya@mobiveil.co.in>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: RE: [PATCH 15/23] dt-bindings: pci: mobiveil: change gpio_slave and
 apb_csr to optional
Thread-Topic: [PATCH 15/23] dt-bindings: pci: mobiveil: change gpio_slave and
 apb_csr to optional
Thread-Index: AQHUddOEP/V1AsPVHEO11IQdjk5tbKVMevqAgAB7/PA=
Date:   Tue, 13 Nov 2018 06:08:44 +0000
Message-ID: <AM6PR04MB57810984D8C842A2134A836184C20@AM6PR04MB5781.eurprd04.prod.outlook.com>
References: <20181106131807.29951-1-Zhiqiang.Hou@nxp.com>
 <20181106131807.29951-16-Zhiqiang.Hou@nxp.com>
 <5bea0eb7.1c69fb81.dd309.4a26@mx.google.com>
In-Reply-To: <5bea0eb7.1c69fb81.dd309.4a26@mx.google.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB5127;6:AWIPAACCGGfNGlbbKXsHW/FY27mNhbjZ/xCf9AkSUzCifN11mtXEIhJ8zSuJtBv1IKbmyNepjQ2M1XLRTzFZQHnYlxgO/Xkxm1kK0UuEUCs0AD4vBFYldG4qB6DGJi0Ora+sTq8rdbXlZm8fKPWiWiSAWrnM9GiZXcEXHx77c/oa7EJhwKDwlR7o1XzHsqBLURQ0SjPp3dBdzmEa22ujd9yqqnJ/qKYIcM1GODPP5uH9OQzlYecGPHHOWowT+DjWG6L9Z/YnitPKKYEUcrHdhEEMhqWwZGJVZ7UBqHyjZ8kuJQKtDnJzCx+vq7pZhXYxe4kO2yIE/TUkSTp+8tkCmOaVSB26MS4SqUV5ykESmqlONZswiL9V2S6ruYWJsxNWVuUXbrAVz51pG/DPIo8Xozv11GQguWQgAqdBscy9D/Shfea6AcqAIQ+EdhqTTS7RnNgzlS2DFMDZAuKtQTUVPQ==;5:7xeJ3MzGLo03OKHbMEkCZcmIzkUdg9KgbNUxxpk1auHp8vpm3FudI78Pv7ZoQ2IdiNW0YPGafOGVUJVg502DLfB0R3hHboSSOAXwvBvDcR1q4TmN4fj+hoIaAFQz3jaKytHSQRvfxgStI1QV8BbXkeAOhT87bbez+nKoP4qWQUw=;7:YpXqMhT70khAYm8gvw6NKT1GGXDbA9eJSsnsDrkHyRdKDMQbZrMUWPbEUl1hPhG3IgReWx2gQk/AerQY4GqqnxrOMnay9AAoSlM5wznyv0qdx1CS4KwgF9VhTYdesdo49KgXeMKCDInkAP9Ni4CatQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 54c39016-4a2c-41d0-c502-08d6492e77d0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390060)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB5127;
x-ms-traffictypediagnostic: AM6PR04MB5127:
x-microsoft-antispam-prvs: <AM6PR04MB5127B8ACDC11C26819D1F6F184C20@AM6PR04MB5127.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(258649278758335)(211936372134217)(180628864354917)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231406)(944501410)(52105112)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB5127;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB5127;
x-forefront-prvs: 085551F5A8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(136003)(366004)(396003)(346002)(199004)(13464003)(189003)(305945005)(2900100001)(26005)(53936002)(102836004)(25786009)(6246003)(106356001)(7416002)(74316002)(33656002)(14454004)(4326008)(316002)(229853002)(54906003)(99286004)(7736002)(186003)(105586002)(68736007)(97736004)(6116002)(3846002)(6916009)(6436002)(2906002)(71190400001)(446003)(71200400001)(11346002)(53546011)(478600001)(81166006)(486006)(86362001)(6506007)(76176011)(8676002)(81156014)(256004)(66066001)(55016002)(7696005)(476003)(5660300001)(8936002)(9686003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5127;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: xrjgJh9LGgAadmLZFpdIqY+ZXQZyc5GBzV2SWBOaPJ7zUUybwMBTUuz/rQB4DYtk8GMcQnfUwpIiD9CFMMGze2X7ZueBVC0o7qLE8wXV3hTHjNLbpGsl7WrhAKf+PSqo1KN9Y/KHu6hoPSoHeVECX1gBY0oOy1v0a3NPg4ZJ1ZmKciBN436BZaQ9DB4CwMGuM4Jzze4Ujs1V5pfdOcz1HxQ9OG8RHTU4d/xtTsz5X1VC18p3BknM5XyOVXaLD0/IUhQViVsqo/SiVjJ1/2s8BxKiQHNCyFiQ3IDRMXdGqdMfnA1nDN1GMwVfWMhGp4GW1iHgoMp0P1iIk8rF8alIrYtTDlfmOnnWNjrRTtQ2MeI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54c39016-4a2c-41d0-c502-08d6492e77d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2018 06:08:44.6227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5127
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgUm9iLA0KDQpUaGFua3MgYSBsb3QgZm9yIHlvdXIgQUNLIQ0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+DQo+IFNl
bnQ6IDIwMTjE6jEx1MIxM8jVIDI6MTMNCj4gVG86IFoucS4gSG91IDx6aGlxaWFuZy5ob3VAbnhw
LmNvbT4NCj4gQ2M6IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxA
bGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGJoZWxnYWFzQGdvb2dsZS5jb207IG1hcmsucnV0
bGFuZEBhcm0uY29tOw0KPiBsLnN1YnJhaG1hbnlhQG1vYml2ZWlsLmNvLmluOyBzaGF3bmd1b0Br
ZXJuZWwub3JnOyBMZW8gTGkNCj4gPGxlb3lhbmcubGlAbnhwLmNvbT47IGxvcmVuem8ucGllcmFs
aXNpQGFybS5jb207IE1pbmdrYWkgSHUNCj4gPG1pbmdrYWkuaHVAbnhwLmNvbT47IE0uaC4gTGlh
biA8bWluZ2h1YW4ubGlhbkBueHAuY29tPjsgWGlhb3dlaSBCYW8NCj4gPHhpYW93ZWkuYmFvQG54
cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMTUvMjNdIGR0LWJpbmRpbmdzOiBwY2k6IG1v
Yml2ZWlsOiBjaGFuZ2UgZ3Bpb19zbGF2ZSBhbmQNCj4gYXBiX2NzciB0byBvcHRpb25hbA0KPiAN
Cj4gT24gVHVlLCBOb3YgMDYsIDIwMTggYXQgMDE6MjA6NDFQTSArMDAwMCwgWi5xLiBIb3Ugd3Jv
dGU6DQo+ID4gRnJvbTogSG91IFpoaXFpYW5nIDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4NCj4gPg0K
PiA+IENoYW5nZSB0aGUgImdwaW9fc2xhdmUiIGFuZCAiYXBiX2NzciIgdG8gb3B0aW9uYWwsIHRo
ZSAiZ3Bpb19zbGF2ZSINCj4gPiBpcyBub3QgdXNlZCBpbiBjdXJyZW50IGNvZGUsIGFuZCAiYXBi
X2NzciIgaXMgbm90IHVzZWQgYnkgc29tZQ0KPiA+IHBsYXRvcm1zLg0KPiA+DQo+ID4gU2lnbmVk
LW9mZi1ieTogSG91IFpoaXFpYW5nIDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4NCj4gPiAtLS0NCj4g
PiAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9tb2JpdmVpbC1wY2llLnR4
dCB8IDIgKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPiANCj4gQWNr
ZWQtYnk6IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+DQoNClJlZ2FyZHMsDQpaaGlxaWFu
Zw0K
