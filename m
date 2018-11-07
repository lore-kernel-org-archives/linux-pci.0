Return-Path: <SRS0=4zPb=NS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C33C0044C
	for <linux-pci@archiver.kernel.org>; Wed,  7 Nov 2018 04:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1E4E20827
	for <linux-pci@archiver.kernel.org>; Wed,  7 Nov 2018 04:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EdKGgPm9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1E4E20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbeKGOKe (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 7 Nov 2018 09:10:34 -0500
Received: from mail-ve1eur01on0062.outbound.protection.outlook.com ([104.47.1.62]:26976
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726558AbeKGOKe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Nov 2018 09:10:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SB85xXmFlRXf3+Ab0wFBT0KYmpDmGoGHV7zVuyRgDD8=;
 b=EdKGgPm95BYKqc3UtfJFBbAGcH4k3xfM0LkUUl1C5tPeFIj0E1/0lTaetNTTNoiNXtJf7inHTvGA+IFfLK0rxu/U49aj+aggiCBmHkWibQutDuiSEV0hrDHgTEioxGz2nBOzwdc0Y9tln2G9roV4f7RIocLkI20ff7k6L4rJa9M=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.2.80) by
 AM6PR04MB4056.eurprd04.prod.outlook.com (52.135.167.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.25; Wed, 7 Nov 2018 04:41:49 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::7d93:8053:57fd:1a00]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::7d93:8053:57fd:1a00%3]) with mapi id 15.20.1273.035; Wed, 7 Nov 2018
 04:41:49 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        Roy Zang <roy.zang@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>
Subject: RE: [PATCH] PCI/Layerscape: fix wrongly invoking of outbound window
 disable accessor
Thread-Topic: [PATCH] PCI/Layerscape: fix wrongly invoking of outbound window
 disable accessor
Thread-Index: AQHUbEA3bQ9DeLR/KUmsy7zvrJJQ86Uv+XIAgADQnOCABacBAIANXmFg
Date:   Wed, 7 Nov 2018 04:41:49 +0000
Message-ID: <AM6PR04MB5781A39406AC16F7CE5D727D84C40@AM6PR04MB5781.eurprd04.prod.outlook.com>
References: <20181025085323.8819-1-Zhiqiang.Hou@nxp.com>
 <20181025134522.GE214775@bhelgaas-glaptop.roam.corp.google.com>
 <AM3PR04MB121709BD837D4E5EA3E28B1A84F00@AM3PR04MB1217.eurprd04.prod.outlook.com>
 <20181029163102.GA13681@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20181029163102.GA13681@bhelgaas-glaptop.roam.corp.google.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB4056;6:aZ81gGqpNx7vQ+4KUwe7ojOgTu5JlZdGTkuMJux+jR1DICINdz5p7YKTXwhDqeXLYNbg+q4vKzkggWaHpRfGer7p40FmStnRsCvZV5vGHT90oTQtKBzAyj5XOHw9o4ADxFqz32ogzyBOiPNvzjek2LBcnJvKVJtON54XovB5bF08/jydgVsSbWlsu7DrvLZ/5Z4EGveY8iJy3HfiKRPrXyHsK5cUF8B/RcnGeFCVDgkrKReTacUR19198aNPmM+FVlUn866QW8VVAknxqaMxJvEiaKHenjgxz9tpHsI9rA6QQZVH4ie2dI2zS5A8uOXr1rfGxvrG0cTl83Dvs5ZrrDojF8Vb6YUsUai0FDqBf1xcxtcdc1D+/znLcMoou2jTbnTe+srMqbNRgnH6FJB6BjAsqw+EOd2RmYPi909aLM92VVlZgbBrnvCQZFKR4pbKyme1ZonAOrM2I5wolhHTYg==;5:w2eM99iM/qwDbgAhRCMvVcE74kKweMGydLW/33hB/7JmptmSkzm4kHPPjmJE0XRPCHDyRY5VywKN2ALXcQfE2EIK8EXVDqm8FrBtTAGV8UXap7tUh1DhdEFMspngBDMAcp9ht/Cpx2YB8IdXOHT1/etz2hzeu0EkcL3R0KT3KnA=;7:Ps8qxtHHVMdtnM8T5bgY7cAlkfecYBk8xQQq8NH+H2fHC3RLMd8eIow7SqdqTQAGMZhic8iMHxkVaYB/Pr04oxW1J2Wec7rO0CXGKQoKZMFjKz9t+fS6ulp0RLJ4nlEN4nvMFdfXv6WlNaAAB56x0Q==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 415bd389-96f9-40f8-ea48-08d6446b54ee
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4056;
x-ms-traffictypediagnostic: AM6PR04MB4056:
x-microsoft-antispam-prvs: <AM6PR04MB40561E94AD3D99ACD3DC3F2A84C40@AM6PR04MB4056.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(211936372134217)(180628864354917)(45079756050767)(189930954265078)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB4056;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4056;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39860400002)(136003)(376002)(346002)(199004)(13464003)(189003)(5660300001)(26005)(54906003)(99286004)(256004)(476003)(316002)(55016002)(486006)(186003)(4326008)(6306002)(9686003)(105586002)(6916009)(6436002)(106356001)(71190400001)(71200400001)(93886005)(97736004)(2900100001)(446003)(11346002)(86362001)(6506007)(53546011)(76176011)(7696005)(102836004)(45080400002)(81166006)(2906002)(81156014)(478600001)(66066001)(33656002)(966005)(229853002)(68736007)(8676002)(3846002)(6116002)(7736002)(8936002)(14454004)(6246003)(25786009)(53936002)(74316002)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4056;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: pmMUBdreihrPLtzEYLr/DuRuo9f3wqFxjYXcHFhMKxg53d3Oh0TFmzXpNDg4nwXEQSubuHZlppKMLpb4NYBU6dzYZArE2rqp7N9fDeBUpstuijp+6MHfBJnRDDYel5KW9FbU3RdzlClSx/Thwb6kJIXPKFE6eIZ1flg44WKFBBXfdipr7mm42Issxtedr1O3v6xmSB3Fg54Z7wUO7Yhwoiy2fQ9HCsIZSexc/8VitqWald8Znn7rsvbrTSFjZO2+XUut00jMz9UQ8ul8vMCfgHBQiE+nst/Bfg81QpWwacD45Ley6eu9covAAg8AlcPYcolpJghmSKuj6kADQMK7188o2H/NNSL0aazCejsUdjA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 415bd389-96f9-40f8-ea48-08d6446b54ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 04:41:49.5996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4056
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgQmpvcm4sDQoNClRoYW5rcyBhIGxvdCBmb3IgeW91ciBndWlkZSENCkknbGwgdGFnIGl0IGZv
ciBzdGFibGUgaW4gdjIuDQoNClRoYW5rcywNClpoaXFpYW5nDQoNCj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gRnJvbTogQmpvcm4gSGVsZ2FhcyA8aGVsZ2Fhc0BrZXJuZWwub3JnPg0K
PiBTZW50OiAyMDE4xOoxMNTCMzDI1SAwOjMxDQo+IFRvOiBaLnEuIEhvdSA8emhpcWlhbmcuaG91
QG54cC5jb20+DQo+IENjOiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnOw0KPiBiaGVsZ2Fhc0Bnb29nbGUuY29tOyBsb3JlbnpvLnBpZXJhbGlz
aUBhcm0uY29tOyBSb3kgWmFuZw0KPiA8cm95LnphbmdAbnhwLmNvbT47IE0uaC4gTGlhbiA8bWlu
Z2h1YW4ubGlhbkBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBQQ0kvTGF5ZXJzY2Fw
ZTogZml4IHdyb25nbHkgaW52b2tpbmcgb2Ygb3V0Ym91bmQNCj4gd2luZG93IGRpc2FibGUgYWNj
ZXNzb3INCj4gDQo+IE9uIEZyaSwgT2N0IDI2LCAyMDE4IGF0IDAyOjIwOjIxQU0gKzAwMDAsIFou
cS4gSG91IHdyb3RlOg0KPiA+ID4gRnJvbTogQmpvcm4gSGVsZ2FhcyA8aGVsZ2Fhc0BrZXJuZWwu
b3JnPg0KPiANCj4gPiA+IEhvbHkgY293LCB0aGlzIGhhcyBiZWVuIGJyb2tlbiBzaW5jZSB2NC4x
NC4gIElmIGZpeGluZyB0aGlzIG1ha2VzIGENCj4gPiA+IGRpZmZlcmVuY2UsIHlvdSBtaWdodCB3
YW50IHRvIHRhZyBpdCBmb3Igc3RhYmxlLg0KPiA+DQo+ID4gSG93IGNhbiBJIHRhZyBpdCBmb3Ig
c3RhYmxlPw0KPiANCj4gaHR0cHM6Ly9lbWVhMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9v
ay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmdpdC5rDQo+IGVybmVsLm9yZyUyRmNnaXQlMkZsaW51
eCUyRmtlcm5lbCUyRmdpdCUyRnRvcnZhbGRzJTJGbGludXguZ2l0JTJGdHJlZSUNCj4gMkZEb2N1
bWVudGF0aW9uJTJGcHJvY2VzcyUyRnN0YWJsZS1rZXJuZWwtcnVsZXMucnN0JmFtcDtkYXRhPTAy
JTdDMDENCj4gJTdDemhpcWlhbmcuaG91JTQwbnhwLmNvbSU3Q2QzYmI2ZTI2ZTJiZDRkYzA2YzY4
MDhkNjNkYmJlZTA2JTcNCj4gQzY4NmVhMWQzYmMyYjRjNmZhOTJjZDk5YzVjMzAxNjM1JTdDMCU3
QzAlN0M2MzY3NjQyNzQ2OTczMjE4Mw0KPiAwJmFtcDtzZGF0YT1rNkRGMlUyUCUyRng1aWF5bDI5
cWhDM2xscUlFbyUyQm5PcTFkTmRoUmdGbEFzZyUzRCYNCj4gYW1wO3Jlc2VydmVkPTANCg==
