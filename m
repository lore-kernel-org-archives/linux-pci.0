Return-Path: <SRS0=vi1x=SO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A181C10F0E
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 08:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E8552171F
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 08:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="m4c00jI8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbfDLIf7 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Apr 2019 04:35:59 -0400
Received: from mail-eopbgr80079.outbound.protection.outlook.com ([40.107.8.79]:47685
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726875AbfDLIf6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Apr 2019 04:35:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZHVeZ64iR0qsT2PR1O85oCQ0cXlom1mGtJhGq/Wzqk=;
 b=m4c00jI8pcz9xNNqfgN+CB6D2RufBf/8YzOIxXjtWx5KexipPOaZ1G6AEUDiNsYMb5rQtvLvJVxMlXlt2DbcJtBFBGX40BZZcKon1K3aItvuqAccwXCfogcPNEhbAYEp98KinRFItl3GN9mnAMySBEXgUAD/xeSjtJXq48NJncY=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB5846.eurprd04.prod.outlook.com (20.179.3.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.18; Fri, 12 Apr 2019 08:35:54 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::f9db:ed86:614e:460]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::f9db:ed86:614e:460%4]) with mapi id 15.20.1792.009; Fri, 12 Apr 2019
 08:35:54 +0000
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
Subject: [PATCHv5 07/20] PCI: mobiveil: Use WIN_NUM_0 explicitly for CFG
 outbound window
Thread-Topic: [PATCHv5 07/20] PCI: mobiveil: Use WIN_NUM_0 explicitly for CFG
 outbound window
Thread-Index: AQHU8Qq+T1qpZKLBb0ucpltc5qpQ8A==
Date:   Fri, 12 Apr 2019 08:35:54 +0000
Message-ID: <20190412083635.33626-8-Zhiqiang.Hou@nxp.com>
References: <20190412083635.33626-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20190412083635.33626-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR06CA0011.apcprd06.prod.outlook.com
 (2603:1096:202:2e::23) To AM6PR04MB5781.eurprd04.prod.outlook.com
 (2603:10a6:20b:ad::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d6008770-2043-4604-01e9-08d6bf21e08d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM6PR04MB5846;
x-ms-traffictypediagnostic: AM6PR04MB5846:
x-microsoft-antispam-prvs: <AM6PR04MB58463DB1A2C4A91D819E73DF84280@AM6PR04MB5846.eurprd04.prod.outlook.com>
x-forefront-prvs: 0005B05917
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(376002)(396003)(346002)(136003)(189003)(199004)(486006)(478600001)(2616005)(476003)(316002)(446003)(11346002)(305945005)(7736002)(81166006)(25786009)(81156014)(256004)(14454004)(8676002)(7416002)(4326008)(186003)(50226002)(26005)(8936002)(68736007)(2906002)(53936002)(102836004)(6512007)(66066001)(86362001)(99286004)(106356001)(6116002)(3846002)(6436002)(97736004)(1076003)(6506007)(386003)(52116002)(2201001)(105586002)(6486002)(36756003)(71200400001)(110136005)(54906003)(5660300002)(2501003)(71190400001)(76176011)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5846;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3yONLA+h15fpQYgfqpAGbTDVg2eeD+8VlbbV1kiY4q5jasoJmGrINfjiyfbXmYrnNjAjuNb3Mcd9qZ9MPIarOOwVsJ99xW6upucy2/1ywvr607x07wQUypgHQr/t/GJVu2ReRMVzT966X1VMiZtmSwmRmBjKbo6a4DOI1LSF0JW0XvXOU0YfP9USd7DzYAkMk2pxxKaLfZ+JV8bzCBuJATR2dISMspCn0/9C1LZNwekIscEapuqq/GQmzsGqCntfbrU3wU5gNX7eMjcaGDDFAPSW3fbmaCeLJdl+5dHPsUxLkUpBRs9mNx5d2aHEUrdJhjAGaxsL0LxZzynSh19mQmmTydG/EynFpg3AAC1tGcUvtoUBAizsRdoew8OuFQGbVSHRKzr3KNHKECW1DAe8BAexNHJhWRPqncwtbeaO+08=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6008770-2043-4604-01e9-08d6bf21e08d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2019 08:35:54.7471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5846
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

RnJvbTogSG91IFpoaXFpYW5nIDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4NCg0KQXMgdGhlIC5tYXBf
YnVzKCkgdXNlIHRoZSBXSU5fTlVNXzAgZm9yIENGRyB0cmFuc2FjdGlvbnMsDQppdCdzIGJldHRl
ciBwYXNzaW5nIFdJTl9OVU1fMCBleHBsaWNpdGx5IHdoZW4gaW5pdGlhbGl6ZQ0KdGhlIENGRyBv
dXRib3VuZCB3aW5kb3cuDQoNClNpZ25lZC1vZmYtYnk6IEhvdSBaaGlxaWFuZyA8WmhpcWlhbmcu
SG91QG54cC5jb20+DQpSZXZpZXdlZC1ieTogTWluZ2h1YW4gTGlhbiA8TWluZ2h1YW4uTGlhbkBu
eHAuY29tPg0KUmV2aWV3ZWQtYnk6IFN1YnJhaG1hbnlhIExpbmdhcHBhIDxsLnN1YnJhaG1hbnlh
QG1vYml2ZWlsLmNvLmluPg0KLS0tDQpWNToNCiAtIENvcnJlY3RlZCB0aGUgc3ViamVjdC4NCg0K
IGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tb2JpdmVpbC5jIHwgNSArKy0tLQ0KIDEgZmls
ZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQg
YS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtbW9iaXZlaWwuYyBiL2RyaXZlcnMvcGNpL2Nv
bnRyb2xsZXIvcGNpZS1tb2JpdmVpbC5jDQppbmRleCBiMmNjOWMwOTdmYzkuLmRmNzFjMTFiNDgx
MCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tb2JpdmVpbC5jDQor
KysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtbW9iaXZlaWwuYw0KQEAgLTYxMiw5ICs2
MTIsOCBAQCBzdGF0aWMgaW50IG1vYml2ZWlsX2hvc3RfaW5pdChzdHJ1Y3QgbW9iaXZlaWxfcGNp
ZSAqcGNpZSkNCiAJICovDQogDQogCS8qIGNvbmZpZyBvdXRib3VuZCB0cmFuc2xhdGlvbiB3aW5k
b3cgKi8NCi0JcHJvZ3JhbV9vYl93aW5kb3dzKHBjaWUsIHBjaWUtPm9iX3dpbnNfY29uZmlndXJl
ZCwNCi0JCQkgICBwY2llLT5vYl9pb19yZXMtPnN0YXJ0LCAwLCBDRkdfV0lORE9XX1RZUEUsDQot
CQkJICAgcmVzb3VyY2Vfc2l6ZShwY2llLT5vYl9pb19yZXMpKTsNCisJcHJvZ3JhbV9vYl93aW5k
b3dzKHBjaWUsIFdJTl9OVU1fMCwgcGNpZS0+b2JfaW9fcmVzLT5zdGFydCwgMCwNCisJCQkgICBD
RkdfV0lORE9XX1RZUEUsIHJlc291cmNlX3NpemUocGNpZS0+b2JfaW9fcmVzKSk7DQogDQogCS8q
IG1lbW9yeSBpbmJvdW5kIHRyYW5zbGF0aW9uIHdpbmRvdyAqLw0KIAlwcm9ncmFtX2liX3dpbmRv
d3MocGNpZSwgV0lOX05VTV8xLCAwLCBNRU1fV0lORE9XX1RZUEUsIElCX1dJTl9TSVpFKTsNCi0t
IA0KMi4xNy4xDQoNCg==
