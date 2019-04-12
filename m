Return-Path: <SRS0=vi1x=SO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC90C10F0E
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 08:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9178921872
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 08:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="p0PJsoWC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfDLIfQ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Apr 2019 04:35:16 -0400
Received: from mail-eopbgr00046.outbound.protection.outlook.com ([40.107.0.46]:50737
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725973AbfDLIfQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Apr 2019 04:35:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dtU0Ao/R3IT59N4ZD+ZkO4wI3y9Rn5Vxznvh8GVIbnk=;
 b=p0PJsoWCYXtF6j0SngAUiROSsHqNXg7JunDlkDAv0y+aJjOf2HkkR8HUHp1Pt+j9LB44oVjLIYIJU2/qDyzyGc1/6mV0V54GMQV6NQbT0Wy9xlp9RCLsyqwa0YaybBfOrlY/pdQU5s21MeGKC3wywvPK1BEHsyyIbqWaatMXuGM=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB5926.eurprd04.prod.outlook.com (20.179.3.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.14; Fri, 12 Apr 2019 08:35:11 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::f9db:ed86:614e:460]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::f9db:ed86:614e:460%4]) with mapi id 15.20.1792.009; Fri, 12 Apr 2019
 08:35:11 +0000
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
Subject: [PATCHv5 00/20] PCI: mobiveil: fixes for Mobiveil PCIe Host Bridge IP
 driver
Thread-Topic: [PATCHv5 00/20] PCI: mobiveil: fixes for Mobiveil PCIe Host
 Bridge IP driver
Thread-Index: AQHU8Qqk94Z0xb1jhECZwFnfMTeEPA==
Date:   Fri, 12 Apr 2019 08:35:11 +0000
Message-ID: <20190412083635.33626-1-Zhiqiang.Hou@nxp.com>
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
x-ms-office365-filtering-correlation-id: 50bb1804-5f17-441f-d028-08d6bf21c66b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM6PR04MB5926;
x-ms-traffictypediagnostic: AM6PR04MB5926:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM6PR04MB59267A138A31DEEA36DBAF2084280@AM6PR04MB5926.eurprd04.prod.outlook.com>
x-forefront-prvs: 0005B05917
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(366004)(396003)(39860400002)(189003)(199004)(478600001)(36756003)(305945005)(52116002)(6486002)(966005)(110136005)(186003)(7416002)(3846002)(7736002)(6436002)(50226002)(54906003)(316002)(6512007)(6116002)(25786009)(1076003)(26005)(86362001)(105586002)(8676002)(81166006)(386003)(106356001)(14454004)(2501003)(6306002)(6506007)(81156014)(5660300002)(102836004)(256004)(53936002)(71200400001)(71190400001)(2906002)(68736007)(476003)(66066001)(99286004)(2616005)(97736004)(4326008)(486006)(8936002)(2201001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5926;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yktwvJcevo36nE4rpbJVf0EX2+luD4H1x7/Po/CZXTwaXIF2gnYoYfN4+ybKx8fdi2QbM+fhp3XApEpiz3zxIsqzCJeB+KFXeul4qj7MeOcd48EX8sKRjP+h6WhLxC/NtDuaFtndCelOnLaaGHYu5t/SrUeFJ6O11d1EIroO2KcNstS36Z5AoX5s9JmrK5Hl9tNRC+a955voLqxOGZo+PyjnLbrmH6LSuZ5rN/2icMKSJ+rsbL3+OIVI16QvjQg8Q2dxwrZY4F+cvihHR92BVb7+qsCmTxnh/9WUB8Gg0VPkdylq7MPX72U60YKc7lQmoYfbb9QbzgB6BYRsCr2ipNNbc3yhVUN5u5H/Ymhm/s7p/Bi05M69JVYK/b04+uwsioWYovi7Y4X9hHkliMgRSw51zM4N0Qac3blbWGgksS4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50bb1804-5f17-441f-d028-08d6bf21c66b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2019 08:35:11.1160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5926
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

RnJvbTogSG91IFpoaXFpYW5nIDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4NCg0KVGhpcyBwYXRjaCBz
ZXQgaXMgdG8gYWRkIGZpeGVzIGZvciBNb2JpdmVpbCBQQ0llIEhvc3QgZHJpdmVyLg0KQW5kIHRo
ZXNlIHBhdGNoZXMgYXJlIHNwbGl0ZWQgZnJvbSB0aGUgdGhyZWFkIGJlbG93Og0KaHR0cDovL3Bh
dGNod29yay5vemxhYnMub3JnL3Byb2plY3QvbGludXgtcGNpL2xpc3QvP3Nlcmllcz05NjQxNw0K
DQpIb3UgWmhpcWlhbmcgKDIwKToNCiAgUENJOiBtb2JpdmVpbDogVW5pZnkgcmVnaXN0ZXIgYWNj
ZXNzb3JzDQogIFBDSTogbW9iaXZlaWw6IEZvcm1hdCB0aGUgY29kZSB3aXRob3V0IGZ1bmN0aW9u
YWxpdHkgY2hhbmdlDQogIFBDSTogbW9iaXZlaWw6IENvcnJlY3QgdGhlIHJldHVybmVkIGVycm9y
IG51bWJlcg0KICBQQ0k6IG1vYml2ZWlsOiBSZW1vdmUgdGhlIGZsYWcgTVNJX0ZMQUdfTVVMVElf
UENJX01TSQ0KICBQQ0k6IG1vYml2ZWlsOiBDb3JyZWN0IFBDSSBiYXNlIGFkZHJlc3MgaW4gTUVN
L0lPIG91dGJvdW5kIHdpbmRvd3MNCiAgUENJOiBtb2JpdmVpbDogUmVwbGFjZSB0aGUgcmVzb3Vy
Y2UgbGlzdCBpdGVyYXRpb24gZnVuY3Rpb24NCiAgUENJOiBtb2JpdmVpbDogVXNlIFdJTl9OVU1f
MCBleHBsaWNpdGx5IGZvciBDRkcgb3V0Ym91bmQgd2luZG93DQogIFBDSTogbW9iaXZlaWw6IFVz
ZSB0aGUgMXN0IGluYm91bmQgd2luZG93IGZvciBNRU0gaW5ib3VuZCB0cmFuc2FjdGlvbnMNCiAg
UENJOiBtb2JpdmVpbDogQ29ycmVjdCBpbmJvdW5kL291dGJvdW5kIHdpbmRvdyBzZXR1cCByb3V0
aW5lcw0KICBQQ0k6IG1vYml2ZWlsOiBGaXggdGhlIElOVHggcHJvY2VzcyBlcnJvcnMNCiAgUENJ
OiBtb2JpdmVpbDogQ29ycmVjdCB0aGUgZml4dXAgb2YgQ2xhc3MgQ29kZSBmaWVsZA0KICBQQ0k6
IG1vYml2ZWlsOiBNb3ZlIHRoZSBsaW5rIHVwIHdhaXRpbmcgb3V0IG9mIG1vYml2ZWlsX2hvc3Rf
aW5pdCgpDQogIFBDSTogbW9iaXZlaWw6IE1vdmUgSVJRIGNoYWluZWQgaGFuZGxlciBzZXR1cCBv
dXQgb2YgRFQgcGFyc2UNCiAgUENJOiBtb2JpdmVpbDogSW5pdGlhbGl6ZSBQcmltYXJ5L1NlY29u
ZGFyeS9TdWJvcmRpbmF0ZSBidXMgbnVtYmVycw0KICBQQ0k6IG1vYml2ZWlsOiBGaXggdGhlIGNo
ZWNraW5nIG9mIHZhbGlkIGRldmljZQ0KICBQQ0k6IG1vYml2ZWlsOiBBZGQgbGluayB1cCBjb25k
aXRpb24gY2hlY2sNCiAgUENJOiBtb2JpdmVpbDogQ29tcGxldGUgaW5pdGlhbGl6YXRpb24gb2Yg
aG9zdCBldmVuIGlmIG5vIFBDSWUgbGluaw0KICBQQ0k6IG1vYml2ZWlsOiBEaXNhYmxlIElCIGFu
ZCBPQiB3aW5kb3dzIHNldCBieSBib290bG9hZGVyDQogIFBDSTogbW9iaXZlaWw6IEFkZCA4LWJp
dCBhbmQgMTYtYml0IHJlZ2lzdGVyIGFjY2Vzc29ycw0KICBkdC1iaW5kaW5nczogUENJOiBtb2Jp
dmVpbDogQ2hhbmdlIGdwaW9fc2xhdmUgYW5kIGFwYl9jc3IgdG8gb3B0aW9uYWwNCg0KIC4uLi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9tb2JpdmVpbC1wY2llLnR4dCB8ICAgMiArDQogZHJpdmVy
cy9wY2kvY29udHJvbGxlci9wY2llLW1vYml2ZWlsLmMgICAgICAgIHwgNTc4ICsrKysrKysrKysr
LS0tLS0tLQ0KIDIgZmlsZXMgY2hhbmdlZCwgMzY4IGluc2VydGlvbnMoKyksIDIxMiBkZWxldGlv
bnMoLSkNCg0KLS0gDQoyLjE3LjENCg0K
