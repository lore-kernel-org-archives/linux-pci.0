Return-Path: <SRS0=ulVR=N2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A88C43441
	for <linux-pci@archiver.kernel.org>; Thu, 15 Nov 2018 02:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32A9B22360
	for <linux-pci@archiver.kernel.org>; Thu, 15 Nov 2018 02:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ssERimCB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32A9B22360
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbeKOMdp (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 15 Nov 2018 07:33:45 -0500
Received: from mail-eopbgr140042.outbound.protection.outlook.com ([40.107.14.42]:53910
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725895AbeKOMdp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Nov 2018 07:33:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vhqp+bC6Ks0JB6uxB92Yc7DtTm369aZvkIXqUrS2sI8=;
 b=ssERimCBB4NGVEu4tcqAms0r6TOB5mr/4DK5V3PR18gLggXeRpvqYEnwKzOQ4UrctamprDFmNTQEMycuJGhOiBfuko5RtaGtMF+r9zAlrmH04QslTpE1B1dy5CeHJNsVn8yu6hCqUahskcsrkblOv8Cmn/X4Ac9O1SJh+VYUELA=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.2.80) by
 AM6PR04MB4054.eurprd04.prod.outlook.com (52.135.167.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.21; Thu, 15 Nov 2018 02:27:48 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::7d93:8053:57fd:1a00]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::7d93:8053:57fd:1a00%3]) with mapi id 15.20.1294.045; Thu, 15 Nov 2018
 02:27:48 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: RE: [PATCH 15/23] dt-bindings: pci: mobiveil: change gpio_slave and
 apb_csr to optional
Thread-Topic: [PATCH 15/23] dt-bindings: pci: mobiveil: change gpio_slave and
 apb_csr to optional
Thread-Index: AQHUddOEP/V1AsPVHEO11IQdjk5tbKVPDogAgAEbJ2A=
Date:   Thu, 15 Nov 2018 02:27:48 +0000
Message-ID: <AM6PR04MB57819B50E52512EF10B26CC984DC0@AM6PR04MB5781.eurprd04.prod.outlook.com>
References: <20181106131807.29951-1-Zhiqiang.Hou@nxp.com>
 <20181106131807.29951-16-Zhiqiang.Hou@nxp.com>
 <CAFZiPx270bWemYRekvk1BZ23RW3ecK+znEc6C1Dix_U-2y+cnA@mail.gmail.com>
In-Reply-To: <CAFZiPx270bWemYRekvk1BZ23RW3ecK+znEc6C1Dix_U-2y+cnA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB4054;6:wr/UTlcE0Gk6zoK1m4DBciG6IOEG6Hf5EW9cuzBSSiOsPcpsq8IBKTvnIS910PnIEdLN6Ybp5ZvTHDToUeQlxuBzjPCXXsu1V/eAT8lNJkI4qD0WTjjNYjA1O2xaP6icXZA9jhTVCGc1dZt42uJ60JFiwD073uOLZMuYcW3qNpoeAcV9lupm/mr1/HHArvP1qMe6ycV7GHvVgHV5hZLgO4GcGmGHH7cv7VXIvdcjyLLkH0ermsUKqcMZaYvcFzHCGrbBzqauVMyn9jrH9eap/2kt/qnjlWHHM4YerqDNu3fDQKK2NGoPBmU60Fjbecc+UlyhJcNmnI0LrM0A64xMNU4iUQjC3PQ6G1WluggoZ8S1lmI+cEBZmLlNwMN+V2zybqHo8DbsSvxzy+UOIIWvN13J7IEacrtiNFzA9oCkZRAH5Z+aOGefYw9LlKkB7B/bq6Ss3I0UwHqdHLwFsCzPhA==;5:iopP9YIt0qI7CslAxPhSFqwxCtZsG/BhKKSze5xQEMb/xzDvwQvweOwzgPTYVX94NQb/H+snrPRSEI25JTGBIfk+RV/A5FzMMjYrhJoJzjq4neT9B5IorSi2myxnq++5x9aeJ/yU3bPOoZEFVUuF0u/GNhDotWSiNhJ+N2NnCOg=;7:0/wiPhNRshHmekiP/3B3H9CUsQc6uyJJnQttXqfieN1KdxSKEplJ/M3uRnDj/GDTxJnG/4uCmw3SBahaEyOEaIG9adWeUEMAoMLDBopB8vYEf0NpXKTHuQc6xQX/mWFGAiaqPKt3VM9H0rjOxRRYOQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 1a0f576b-6667-4056-2d64-08d64aa1ef50
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4054;
x-ms-traffictypediagnostic: AM6PR04MB4054:
x-microsoft-antispam-prvs: <AM6PR04MB4054E701EB37B21BD1C10A5984DC0@AM6PR04MB4054.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231415)(944501410)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB4054;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4054;
x-forefront-prvs: 08572BD77F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(39860400002)(396003)(136003)(13464003)(189003)(199004)(25786009)(478600001)(106356001)(99286004)(6916009)(7696005)(68736007)(5660300001)(316002)(76176011)(256004)(105586002)(14454004)(53546011)(6506007)(102836004)(2906002)(97736004)(71200400001)(71190400001)(86362001)(33656002)(26005)(486006)(11346002)(186003)(3846002)(6116002)(476003)(81166006)(81156014)(74316002)(2900100001)(6436002)(305945005)(8676002)(229853002)(53936002)(6246003)(66066001)(7736002)(54906003)(446003)(8936002)(9686003)(55016002)(7416002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4054;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: LVmxyfJAQHTtOxwbq01wPHrhpgq5SDusXUXYIOJqwA4VJdtmG3qDaqNbhYlLSsh+4lNH5CnLDkJEAF8PDDBCAaK7BDdlHiQZBmAaQkChQQ04EIh6NI26Ns6cOLOLspPF160jjhFTqQ5m4aPGL09YFEe3jAIt9abAN6ORGJMNxOFRMQAt1ydGNN8gWagZ/r3AYUPCl06FWUZ1Z24fG+oYO5l0eXvh2POTYkuPnfehvu/2qga0TImOwab9rFgOfYESLbKqM5kbV31lt74WiMVEpWWYvCzegsvvp0LGa9UxgRCKyxjheEEtZaPTbWCt8L8LXSRAUUGEgJCtTQp6c25OKwBUbSFKvrvFBuJofQa5B9A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a0f576b-6667-4056-2d64-08d64aa1ef50
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2018 02:27:48.3962
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4054
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgU3VicmFobWFueWEsDQoNClRoYW5rcyBhIGxvdCBmb3IgeW91ciBBQ0shDQoNClJlZ2FyZHMs
DQpaaGlxaWFuZw0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFN1YnJh
aG1hbnlhIExpbmdhcHBhIDxsLnN1YnJhaG1hbnlhQG1vYml2ZWlsLmNvLmluPg0KPiBTZW50OiAy
MDE45bm0MTHmnIgxNOaXpSAxNzozMw0KPiBUbzogWi5xLiBIb3UgPHpoaXFpYW5nLmhvdUBueHAu
Y29tPg0KPiBDYzogbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBs
aXN0cy5pbmZyYWRlYWQub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZzsgQmpvcm4gSGVsZ2Fhcw0KPiA8YmhlbGdhYXNAZ29vZ2xl
LmNvbT47IHJvYmgrZHRAa2VybmVsLm9yZzsgbWFyay5ydXRsYW5kQGFybS5jb207DQo+IHNoYXdu
Z3VvQGtlcm5lbC5vcmc7IExlbyBMaSA8bGVveWFuZy5saUBueHAuY29tPjsgTG9yZW56byBQaWVy
YWxpc2kNCj4gPGxvcmVuem8ucGllcmFsaXNpQGFybS5jb20+OyBNaW5na2FpIEh1IDxtaW5na2Fp
Lmh1QG54cC5jb20+OyBNLmguIExpYW4NCj4gPG1pbmdodWFuLmxpYW5AbnhwLmNvbT47IFhpYW93
ZWkgQmFvIDx4aWFvd2VpLmJhb0BueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDE1LzIz
XSBkdC1iaW5kaW5nczogcGNpOiBtb2JpdmVpbDogY2hhbmdlIGdwaW9fc2xhdmUgYW5kDQo+IGFw
Yl9jc3IgdG8gb3B0aW9uYWwNCj4gDQo+IEFja2VkLWJ5OiBTdWJyYWhtYW55YSBMaW5nYXBwYSA8
bC5zdWJyYWhtYW55YUBtb2JpdmVpbC5jby5pbj4NCj4gDQo+IE9uIFR1ZSwgTm92IDYsIDIwMTgg
YXQgNjo1MCBQTSBaLnEuIEhvdSA8emhpcWlhbmcuaG91QG54cC5jb20+IHdyb3RlOg0KPiA+DQo+
ID4gRnJvbTogSG91IFpoaXFpYW5nIDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4NCj4gPg0KPiA+IENo
YW5nZSB0aGUgImdwaW9fc2xhdmUiIGFuZCAiYXBiX2NzciIgdG8gb3B0aW9uYWwsIHRoZSAiZ3Bp
b19zbGF2ZSINCj4gPiBpcyBub3QgdXNlZCBpbiBjdXJyZW50IGNvZGUsIGFuZCAiYXBiX2NzciIg
aXMgbm90IHVzZWQgYnkgc29tZQ0KPiA+IHBsYXRvcm1zLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1i
eTogSG91IFpoaXFpYW5nIDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9tb2JpdmVpbC1wY2llLnR4dCB8IDIg
KysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAt
LWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvbW9iaXZlaWwtcGNp
ZS50eHQNCj4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvbW9iaXZl
aWwtcGNpZS50eHQNCj4gPiBpbmRleCBhNjE4ZDQ3ODdkZDcuLjY0MTU2OTkzZTA1MiAxMDA2NDQN
Cj4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL21vYml2ZWls
LXBjaWUudHh0DQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Bj
aS9tb2JpdmVpbC1wY2llLnR4dA0KPiA+IEBAIC0xMCw4ICsxMCwxMCBAQCBSZXF1aXJlZCBwcm9w
ZXJ0aWVzOg0KPiA+ICAgICAgICAgaW50ZXJydXB0IHNvdXJjZS4gVGhlIHZhbHVlIG11c3QgYmUg
MS4NCj4gPiAgLSBjb21wYXRpYmxlOiBTaG91bGQgY29udGFpbiAibWJ2bCxncGV4NDAtcGNpZSIN
Cj4gPiAgLSByZWc6IFNob3VsZCBjb250YWluIFBDSWUgcmVnaXN0ZXJzIGxvY2F0aW9uIGFuZCBs
ZW5ndGgNCj4gPiArICAgICAgIE1hbmRhdG9yeToNCj4gPiAgICAgICAgICJjb25maWdfYXhpX3Ns
YXZlIjogUENJZSBjb250cm9sbGVyIHJlZ2lzdGVycw0KPiA+ICAgICAgICAgImNzcl9heGlfc2xh
dmUiICAgOiBCcmlkZ2UgY29uZmlnIHJlZ2lzdGVycw0KPiA+ICsgICAgICAgT3B0aW9uYWw6DQo+
ID4gICAgICAgICAiZ3Bpb19zbGF2ZSIgICAgICA6IEdQSU8gcmVnaXN0ZXJzIHRvIGNvbnRyb2wg
c2xvdCBwb3dlcg0KPiA+ICAgICAgICAgImFwYl9jc3IiICAgICAgICAgOiBNU0kgcmVnaXN0ZXJz
DQo+ID4NCj4gPiAtLQ0KPiA+IDIuMTcuMQ0KPiA+DQo=
