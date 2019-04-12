Return-Path: <SRS0=vi1x=SO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6021C10F0E
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 08:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA20C2186A
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 08:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cJvX0r1A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbfDLIfu (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Apr 2019 04:35:50 -0400
Received: from mail-eopbgr30068.outbound.protection.outlook.com ([40.107.3.68]:59521
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725973AbfDLIfr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Apr 2019 04:35:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=py0Yq4aUtdyPnkhtrHLieXbbkcXqC+7yM4Tfvc4t7+U=;
 b=cJvX0r1ARrNJD+XD+ufAPB8TgYior/pBnfWBjN3Jh0dEf5Itmzx7eFyhdITNS+KJCyNESp0iD5HOGW7HdKK61qiAXjwtpV57lMonYG8J0IM7OdakJJiJOPesSzW+zdw43Fvku7dNVxLvBXr8QZkXqfFDgCkg/zalrNxR+K00RJ8=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB5926.eurprd04.prod.outlook.com (20.179.3.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.14; Fri, 12 Apr 2019 08:35:30 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::f9db:ed86:614e:460]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::f9db:ed86:614e:460%4]) with mapi id 15.20.1792.009; Fri, 12 Apr 2019
 08:35:30 +0000
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
Subject: [PATCHv5 03/20] PCI: mobiveil: Correct the returned error number
Thread-Topic: [PATCHv5 03/20] PCI: mobiveil: Correct the returned error number
Thread-Index: AQHU8QqwGTpkCK3rR0itFH1s1bUioQ==
Date:   Fri, 12 Apr 2019 08:35:30 +0000
Message-ID: <20190412083635.33626-4-Zhiqiang.Hou@nxp.com>
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
x-ms-office365-filtering-correlation-id: fb70a42b-b776-4a13-fc5b-08d6bf21d24e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM6PR04MB5926;
x-ms-traffictypediagnostic: AM6PR04MB5926:
x-microsoft-antispam-prvs: <AM6PR04MB59265AD9107945BB429CF68084280@AM6PR04MB5926.eurprd04.prod.outlook.com>
x-forefront-prvs: 0005B05917
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(366004)(396003)(39860400002)(189003)(199004)(54534003)(478600001)(36756003)(305945005)(52116002)(6486002)(110136005)(186003)(7416002)(3846002)(7736002)(6436002)(50226002)(54906003)(316002)(6512007)(6116002)(25786009)(1076003)(26005)(86362001)(105586002)(8676002)(81166006)(386003)(106356001)(14454004)(2501003)(6506007)(81156014)(76176011)(5660300002)(102836004)(256004)(53936002)(71200400001)(71190400001)(2906002)(68736007)(476003)(66066001)(99286004)(2616005)(97736004)(4326008)(486006)(446003)(11346002)(8936002)(2201001)(14444005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5926;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qb7LpZ/Kx1LSZL5A/Yvr5KN2dBycit9wwwUosMbZpiDoyjfMkl29NCtETW1/n0zr3bDOU0jcc1Pr0vo+CnHIOfXMp/pKpR9fg4hVXxrmZU7UjhEG15EVscv+2JZCaNYBs+JAIKzP0PDuoT9pk1vfUXGLC5ojUDBuiXlpGEMjAJ4ycHUYRKbaWtzpD36Cx2x5vDf3ua4Cisr5NUMk69Ae2fFjKMuI+EO4F62r4wp+zXNaEhXUHt/qIp8AbR35xjDKp3j+KW3VDNyoKP3lwYUDFppaItdJX5h+E7Og57xNzo/vfH+qFoAFIVMnCbynI5d5K0o4ILhrm9uJlGmMve5GIMRNBSD3nCtOHeHKtFJYcAiCTFbkExrXcyMFA3h+nJhsDJGdIMuYGRh2YVGr+hPXRQMhvJbPtkuH0mXI6HNGg8I=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb70a42b-b776-4a13-fc5b-08d6bf21d24e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2019 08:35:30.7575
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5926
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

RnJvbTogSG91IFpoaXFpYW5nIDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4NCg0KVGhpcyBwYXRjaCBj
b3JyZWN0cyB0aGUgcmV0dXJuZWQgZXJyb3IgbnVtYmVyIGJ5IGNvbnZlbnRpb24sDQphbmQgcmVt
b3ZlcyBhbiB1bm5lY2Vzc2FyeSBlcnJvciBjaGVjay4NCg0KU2lnbmVkLW9mZi1ieTogSG91IFpo
aXFpYW5nIDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4NClJldmlld2VkLWJ5OiBNaW5naHVhbiBMaWFu
IDxNaW5naHVhbi5MaWFuQG54cC5jb20+DQpSZXZpZXdlZC1ieTogU3VicmFobWFueWEgTGluZ2Fw
cGEgPGwuc3VicmFobWFueWFAbW9iaXZlaWwuY28uaW4+DQotLS0NClY1Og0KIC0gQ29ycmVjdGVk
IGFuZCByZXRvdWNoZWQgdGhlIHN1YmplY3QgYW5kIGNoYW5nZWxvZy4NCg0KIGRyaXZlcnMvcGNp
L2NvbnRyb2xsZXIvcGNpZS1tb2JpdmVpbC5jIHwgOCArKystLS0tLQ0KIDEgZmlsZSBjaGFuZ2Vk
LCAzIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJz
L3BjaS9jb250cm9sbGVyL3BjaWUtbW9iaXZlaWwuYyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIv
cGNpZS1tb2JpdmVpbC5jDQppbmRleCBiODc0NzFmMDhhNDAuLjU2MzIxMGU3MzFkMyAxMDA2NDQN
Ci0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tb2JpdmVpbC5jDQorKysgYi9kcml2
ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtbW9iaXZlaWwuYw0KQEAgLTgxOSw3ICs4MTksNyBAQCBz
dGF0aWMgaW50IG1vYml2ZWlsX3BjaWVfaW5pdF9pcnFfZG9tYWluKHN0cnVjdCBtb2JpdmVpbF9w
Y2llICpwY2llKQ0KIA0KIAlpZiAoIXBjaWUtPmludHhfZG9tYWluKSB7DQogCQlkZXZfZXJyKGRl
diwgIkZhaWxlZCB0byBnZXQgYSBJTlR4IElSUSBkb21haW5cbiIpOw0KLQkJcmV0dXJuIC1FTk9E
RVY7DQorCQlyZXR1cm4gLUVOT01FTTsNCiAJfQ0KIA0KIAlyYXdfc3Bpbl9sb2NrX2luaXQoJnBj
aWUtPmludHhfbWFza19sb2NrKTsNCkBAIC04NDUsMTEgKzg0NSw5IEBAIHN0YXRpYyBpbnQgbW9i
aXZlaWxfcGNpZV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KIAkvKiBhbGxv
Y2F0ZSB0aGUgUENJZSBwb3J0ICovDQogCWJyaWRnZSA9IGRldm1fcGNpX2FsbG9jX2hvc3RfYnJp
ZGdlKGRldiwgc2l6ZW9mKCpwY2llKSk7DQogCWlmICghYnJpZGdlKQ0KLQkJcmV0dXJuIC1FTk9E
RVY7DQorCQlyZXR1cm4gLUVOT01FTTsNCiANCiAJcGNpZSA9IHBjaV9ob3N0X2JyaWRnZV9wcml2
KGJyaWRnZSk7DQotCWlmICghcGNpZSkNCi0JCXJldHVybiAtRU5PTUVNOw0KIA0KIAlwY2llLT5w
ZGV2ID0gcGRldjsNCiANCkBAIC04NjYsNyArODY0LDcgQEAgc3RhdGljIGludCBtb2JpdmVpbF9w
Y2llX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQogCQkJCQkJICAgICZwY2ll
LT5yZXNvdXJjZXMsICZpb2Jhc2UpOw0KIAlpZiAocmV0KSB7DQogCQlkZXZfZXJyKGRldiwgIkdl
dHRpbmcgYnJpZGdlIHJlc291cmNlcyBmYWlsZWRcbiIpOw0KLQkJcmV0dXJuIC1FTk9NRU07DQor
CQlyZXR1cm4gcmV0Ow0KIAl9DQogDQogCS8qDQotLSANCjIuMTcuMQ0KDQo=
