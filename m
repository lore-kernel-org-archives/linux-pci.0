Return-Path: <SRS0=vi1x=SO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1336C10F0E
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 09:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73A1920850
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 09:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CS3MBPRn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfDLJw2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Apr 2019 05:52:28 -0400
Received: from mail-eopbgr150054.outbound.protection.outlook.com ([40.107.15.54]:18336
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726694AbfDLJw2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Apr 2019 05:52:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0GKWIbQNgzrbef6D0cgGGBd+ZgcSZAPGQI6U5ys4m4Q=;
 b=CS3MBPRnmrIOuk+t7IWqFmsG4jMGHbXDO7YFznrWuZ6kq0WXqPeCNK0ZfA+kGxuSs6z1H0EFudVSu66gUf5UyF/L+lSFNtjzeAdoh7MtGWyLpvmgUrwL3NVuk/67WBUfZMStCINazE3pux1M5ZbSNaN0RWYZZAdeym19wmFDmkI=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB4232.eurprd04.prod.outlook.com (52.135.166.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.18; Fri, 12 Apr 2019 09:52:25 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::f9db:ed86:614e:460]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::f9db:ed86:614e:460%4]) with mapi id 15.20.1792.009; Fri, 12 Apr 2019
 09:52:25 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "l.subrahmanya@mobiveil.co.in" <l.subrahmanya@mobiveil.co.in>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>
CC:     Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>
Subject: [PATCHv5 0/6] PCI: refactor Mobiveil driver and add PCIe Gen4 driver
 for NXP Layerscape SoCs
Thread-Topic: [PATCHv5 0/6] PCI: refactor Mobiveil driver and add PCIe Gen4
 driver for NXP Layerscape SoCs
Thread-Index: AQHU8RVu1ySiX/BKZ0CeljNlXu/I9w==
Date:   Fri, 12 Apr 2019 09:52:24 +0000
Message-ID: <20190412095332.41370-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR02CA0210.apcprd02.prod.outlook.com
 (2603:1096:201:20::22) To AM6PR04MB5781.eurprd04.prod.outlook.com
 (2603:10a6:20b:ad::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5d30e08a-4e7f-436f-c818-08d6bf2c90b1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM6PR04MB4232;
x-ms-traffictypediagnostic: AM6PR04MB4232:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM6PR04MB4232F7895051C6B2BBF5443B84280@AM6PR04MB4232.eurprd04.prod.outlook.com>
x-forefront-prvs: 0005B05917
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(6029001)(136003)(376002)(346002)(39860400002)(396003)(366004)(189003)(199004)(106356001)(14454004)(2201001)(105586002)(6512007)(99286004)(54906003)(71190400001)(71200400001)(6116002)(3846002)(5660300002)(7416002)(305945005)(6306002)(25786009)(966005)(86362001)(2906002)(256004)(53936002)(478600001)(81156014)(8936002)(50226002)(102836004)(81166006)(66066001)(68736007)(6436002)(2501003)(8676002)(7736002)(4326008)(6486002)(316002)(97736004)(26005)(186003)(486006)(476003)(110136005)(2616005)(36756003)(386003)(6506007)(1076003)(52116002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4232;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OB+ilfIg1Hxg7wDZFY08M5QMAMdr0p9W8M1dgefZR5rd8ukS7FOwZAiuWEJRoLR6QvvhxqE9ddsFxk6RjEfnbpTYRbkSFxgibEHcvlzKJxKp2AQN18AFsG676tfEyJWpzeH2VZzFdc4jn3DZJvU/pTneh/WmVdPZXp3F1MN6T7Vsi2srNJ4Z51ioJVKk8s7EqgUCxkzyOVt4Cjej3QPB/OTF421hwsvT7kZnmVpRLk84wMowqqDu00AudZY2stJa9t9TWb9kIL8XFos7DLpONWEBjHtoY1N3hksLZNqkwR4s0BvaOmjM+ONL2AG6PQ6fyn3appQBUcq2JzwEf0NkdSQCC2q8JjCTm+vMyMSTUNgldoVdvFX/q3dIWQ65/YZdIZDeyIl7XYN1ypfqDMNKFU0i/L+Ifn4HofWbXc4lHjM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <446A5414BC800E438AB8550604D4749C@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d30e08a-4e7f-436f-c818-08d6bf2c90b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2019 09:52:24.9282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4232
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

RnJvbTogSG91IFpoaXFpYW5nIDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4NCg0KVGhpcyBwYXRjaCBz
ZXQgaXMgYWltIHRvIHJlZmFjdG9yIHRoZSBNb2JpdmVpbCBkcml2ZXIgYW5kIGFkZA0KUENJZSBz
dXBwb3J0IGZvciBOWFAgTGF5ZXJzY2FwZSBzZXJpZXMgU29DcyBpbnRlZ3JhdGVkIE1vYml2ZWls
J3MNClBDSWUgR2VuNCBjb250cm9sbGVyLg0KDQpUaGlzIHBhdGNoIHNldCBkZXBlbmRzIG9uOg0K
aHR0cDovL3BhdGNod29yay5vemxhYnMub3JnL3Byb2plY3QvbGludXgtcGNpL2xpc3QvP3Nlcmll
cz0xMDIzNzgNCg0KSG91IFpoaXFpYW5nICg2KToNCiAgUENJOiBtb2JpdmVpbDogUmVmYWN0b3Ig
TW9iaXZlaWwgUENJZSBIb3N0IEJyaWRnZSBJUCBkcml2ZXINCiAgUENJOiBtb2JpdmVpbDogTWFr
ZSBtb2JpdmVpbF9ob3N0X2luaXQoKSBjYW4gYmUgdXNlZCB0byByZS1pbml0IGhvc3QNCiAgZHQt
YmluZGluZ3M6IFBDSTogQWRkIE5YUCBMYXllcnNjYXBlIFNvQ3MgUENJZSBHZW40IGNvbnRyb2xs
ZXINCiAgUENJOiBtb2JpdmVpbDogQWRkIFBDSWUgR2VuNCBSQyBkcml2ZXIgZm9yIE5YUCBMYXll
cnNjYXBlIFNvQ3MNCiAgYXJtNjQ6IGR0czogbHgyMTYwYTogQWRkIFBDSWUgY29udHJvbGxlciBE
VCBub2Rlcw0KICBhcm02NDogZGVmY29uZmlnOiBFbmFibGUgQ09ORklHX1BDSV9MQVlFUlNDQVBF
X0dFTjQNCg0KIC4uLi9iaW5kaW5ncy9wY2kvbGF5ZXJzY2FwZS1wY2ktZ2VuNC50eHQgICAgICB8
ICA1MiArKw0KIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8
ICAxMCArLQ0KIC4uLi9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWx4MjE2MGEuZHRzaSB8
IDE2MyArKysrKw0KIGFyY2gvYXJtNjQvY29uZmlncy9kZWZjb25maWcgICAgICAgICAgICAgICAg
ICB8ICAgMSArDQogZHJpdmVycy9wY2kvY29udHJvbGxlci9LY29uZmlnICAgICAgICAgICAgICAg
IHwgIDExICstDQogZHJpdmVycy9wY2kvY29udHJvbGxlci9NYWtlZmlsZSAgICAgICAgICAgICAg
IHwgICAyICstDQogZHJpdmVycy9wY2kvY29udHJvbGxlci9tb2JpdmVpbC9LY29uZmlnICAgICAg
IHwgIDM0ICsNCiBkcml2ZXJzL3BjaS9jb250cm9sbGVyL21vYml2ZWlsL01ha2VmaWxlICAgICAg
fCAgIDUgKw0KIC4uLi9jb250cm9sbGVyL21vYml2ZWlsL3BjaS1sYXllcnNjYXBlLWdlbjQuYyB8
IDI1NiArKysrKysrKw0KIC4uLi9wY2llLW1vYml2ZWlsLWhvc3QuY30gICAgICAgICAgICAgICAg
ICAgICB8IDYwOSArKysrLS0tLS0tLS0tLS0tLS0NCiAuLi4vY29udHJvbGxlci9tb2JpdmVpbC9w
Y2llLW1vYml2ZWlsLXBsYXQuYyAgfCAgNTYgKysNCiAuLi4vcGNpL2NvbnRyb2xsZXIvbW9iaXZl
aWwvcGNpZS1tb2JpdmVpbC5jICAgfCAyNDggKysrKysrKw0KIC4uLi9wY2kvY29udHJvbGxlci9t
b2JpdmVpbC9wY2llLW1vYml2ZWlsLmggICB8IDIyNCArKysrKysrDQogMTMgZmlsZXMgY2hhbmdl
ZCwgMTE2MCBpbnNlcnRpb25zKCspLCA1MTEgZGVsZXRpb25zKC0pDQogY3JlYXRlIG1vZGUgMTAw
NjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvbGF5ZXJzY2FwZS1wY2kt
Z2VuNC50eHQNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9wY2kvY29udHJvbGxlci9tb2Jp
dmVpbC9LY29uZmlnDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIv
bW9iaXZlaWwvTWFrZWZpbGUNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9wY2kvY29udHJv
bGxlci9tb2JpdmVpbC9wY2ktbGF5ZXJzY2FwZS1nZW40LmMNCiByZW5hbWUgZHJpdmVycy9wY2kv
Y29udHJvbGxlci97cGNpZS1tb2JpdmVpbC5jID0+IG1vYml2ZWlsL3BjaWUtbW9iaXZlaWwtaG9z
dC5jfSAoNTElKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3BjaS9jb250cm9sbGVyL21v
Yml2ZWlsL3BjaWUtbW9iaXZlaWwtcGxhdC5jDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMv
cGNpL2NvbnRyb2xsZXIvbW9iaXZlaWwvcGNpZS1tb2JpdmVpbC5jDQogY3JlYXRlIG1vZGUgMTAw
NjQ0IGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvbW9iaXZlaWwvcGNpZS1tb2JpdmVpbC5oDQoNCi0t
IA0KMi4xNy4xDQoNCg==
