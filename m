Return-Path: <SRS0=vi1x=SO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD56C10F14
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 09:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8242120850
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 09:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JWXsxheb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfDLJxL (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Apr 2019 05:53:11 -0400
Received: from mail-eopbgr130072.outbound.protection.outlook.com ([40.107.13.72]:18851
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726742AbfDLJxJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Apr 2019 05:53:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pm+mmoNlW9IPyWZXz8QSQkMmKjUEOEHoxUv1GnVQ9LM=;
 b=JWXsxhebg3uoKQrzU0rZPCwW29tidi5NFqzZKg6k0IAf7IhHxBuj0XaAn+3lDFl2iELR6grmBmlV2rWcjkP5CYEF3D25XY9ILrwuMu5XdyFiiXXx7FfxqeK0CltNtvspkyr7uNJrVrL34FafheAoT1/AioZ61i2Bz0NHCiqZuv8=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB6040.eurprd04.prod.outlook.com (20.179.6.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.14; Fri, 12 Apr 2019 09:53:05 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::f9db:ed86:614e:460]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::f9db:ed86:614e:460%4]) with mapi id 15.20.1792.009; Fri, 12 Apr 2019
 09:53:05 +0000
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
Subject: [PATCHv5 6/6] arm64: defconfig: Enable CONFIG_PCI_LAYERSCAPE_GEN4
Thread-Topic: [PATCHv5 6/6] arm64: defconfig: Enable
 CONFIG_PCI_LAYERSCAPE_GEN4
Thread-Index: AQHU8RWGcK7G0bp520GfZt7Hb5oJLw==
Date:   Fri, 12 Apr 2019 09:53:05 +0000
Message-ID: <20190412095332.41370-7-Zhiqiang.Hou@nxp.com>
References: <20190412095332.41370-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20190412095332.41370-1-Zhiqiang.Hou@nxp.com>
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
x-ms-office365-filtering-correlation-id: 5df55a3f-eb32-455b-02c2-08d6bf2ca879
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM6PR04MB6040;
x-ms-traffictypediagnostic: AM6PR04MB6040:
x-microsoft-antispam-prvs: <AM6PR04MB60404513A0DC7859F2410AAC84280@AM6PR04MB6040.eurprd04.prod.outlook.com>
x-forefront-prvs: 0005B05917
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(366004)(376002)(39860400002)(396003)(199004)(189003)(2201001)(26005)(11346002)(53936002)(316002)(2501003)(81156014)(4744005)(81166006)(71200400001)(1076003)(36756003)(97736004)(6436002)(105586002)(71190400001)(50226002)(25786009)(478600001)(110136005)(54906003)(14454004)(6486002)(8936002)(186003)(7416002)(256004)(76176011)(106356001)(2906002)(7736002)(8676002)(4326008)(6506007)(102836004)(476003)(486006)(305945005)(386003)(99286004)(5660300002)(2616005)(66066001)(3846002)(68736007)(86362001)(52116002)(6116002)(446003)(6512007)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB6040;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 86wKiD3Qw209HbvkleTvS+yE2GTj9vWsCqk4FBTN4/cCsAuotHW4bJEpvRMYipfZsI1bFmppU9e/fDtRyNxh7f55fgEia9Yk/FdEw/hxFMW84oGDw2j1G24+b3j6QDntQV81vxvXwviS2BWVRGFEgl8hXquy8aF6YJaFt7QGEzCn2zksA+FLOzO3sVwUNXuI8LkLxGNSmmSjC7Y3ZK3wYNS7JMMzaNieav/lg3pENUoNunPG9ZjIFwMiyS33I6XeL5VxJnv0stzhzFX5t4jP/SGi+mm6vvwK/5TiHWQzbG0NTaqyMZ7XRxmXI7s7D0kwITJGuljeiBGotzFhZOC5qhPEeynZkyrMrIw3I4iKrIy+DvlGu/bGH+vQqTGIZ+wuNq6pjDtbDHm795EX68IOnGrR+tFhDySCCHR+OvhUwvU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5df55a3f-eb32-455b-02c2-08d6bf2ca879
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2019 09:53:05.0256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6040
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

RnJvbTogSG91IFpoaXFpYW5nIDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4NCg0KRW5hYmxlIHRoZSBQ
Q0llIEdlbjQgY29udHJvbGxlciBkcml2ZXIgZm9yIExheWVyc2NhcGUgU29Dcy4NCg0KU2lnbmVk
LW9mZi1ieTogSG91IFpoaXFpYW5nIDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4NClJldmlld2VkLWJ5
OiBNaW5naHVhbiBMaWFuIDxNaW5naHVhbi5MaWFuQG54cC5jb20+DQotLS0NClY1Og0KIC0gTm8g
Y2hhbmdlLg0KDQogYXJjaC9hcm02NC9jb25maWdzL2RlZmNvbmZpZyB8IDEgKw0KIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KDQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9jb25maWdz
L2RlZmNvbmZpZyBiL2FyY2gvYXJtNjQvY29uZmlncy9kZWZjb25maWcNCmluZGV4IDJkOWMzOTAz
M2MxYS4uZTI5NDk3OGFhZDVkIDEwMDY0NA0KLS0tIGEvYXJjaC9hcm02NC9jb25maWdzL2RlZmNv
bmZpZw0KKysrIGIvYXJjaC9hcm02NC9jb25maWdzL2RlZmNvbmZpZw0KQEAgLTgyLDYgKzgyLDcg
QEAgQ09ORklHX1BDSV9IT1NUX1RIVU5ERVJfUEVNPXkNCiBDT05GSUdfUENJX0hPU1RfVEhVTkRF
Ul9FQ0FNPXkNCiBDT05GSUdfUENJRV9ST0NLQ0hJUF9IT1NUPW0NCiBDT05GSUdfUENJX0xBWUVS
U0NBUEU9eQ0KK0NPTkZJR19QQ0lfTEFZRVJTQ0FQRV9HRU40PXkNCiBDT05GSUdfUENJX0hJU0k9
eQ0KIENPTkZJR19QQ0lFX1FDT009eQ0KIENPTkZJR19QQ0lFX0FSTUFEQV84Sz15DQotLSANCjIu
MTcuMQ0KDQo=
