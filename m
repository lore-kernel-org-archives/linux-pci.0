Return-Path: <SRS0=gAuQ=QF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E7AC282C7
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 08:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 356A8214DA
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 08:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rWkFI8r4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfA2IKD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 29 Jan 2019 03:10:03 -0500
Received: from mail-eopbgr70058.outbound.protection.outlook.com ([40.107.7.58]:22016
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727166AbfA2IKC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Jan 2019 03:10:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PlBOMd+seufsghBS3KS0MJplk2qmVcJh6mJIbRqnBDE=;
 b=rWkFI8r4Ydi6JOAcDc3/sW5ZIil/rbIzXRSnSso6OMf9efdvcxwh3tKD2IQCvBReL0ZaHy3LqRdui/1lWM2uMvQ8DFJEaTxIJSYMN16HOsynymsX6pdn12LLxRb6i4qLA/GduPcWdWg94cROLZkzj7jd51hXkxiP40EcNabKavw=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB4728.eurprd04.prod.outlook.com (20.177.32.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Tue, 29 Jan 2019 08:09:58 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::9c0:e3aa:b41f:9504]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::9c0:e3aa:b41f:9504%3]) with mapi id 15.20.1558.023; Tue, 29 Jan 2019
 08:09:58 +0000
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
Subject: [PATCHv3 14/27] PCI: mobiveil: initialize
 Primary/Secondary/Subordinate bus number
Thread-Topic: [PATCHv3 14/27] PCI: mobiveil: initialize
 Primary/Secondary/Subordinate bus number
Thread-Index: AQHUt6oGvsMP74HT8k+h+5NNlChWGA==
Date:   Tue, 29 Jan 2019 08:09:58 +0000
Message-ID: <20190129080926.36773-15-Zhiqiang.Hou@nxp.com>
References: <20190129080926.36773-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20190129080926.36773-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:203:36::20) To AM6PR04MB5781.eurprd04.prod.outlook.com
 (2603:10a6:20b:ad::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB4728;6:0Mlm//6gxhwBYTI7Ff8Ucg0KwJeKG6bmb006SXOr0ZLGn6HNboL/p0rFP+TDHYKSy8UaJABc7fyMyfNh9ldpq1ZG524pgw/mkqJ0rUbBZClDVqKU3YB5iRQM93UREhOOZhlrsNJJItBKWLJzP9g8/gVkDYi2866R0jENQyofOd02XQPBccBw+lpyUi0+neC+WGCPaOQt97yK8c/pgSLP3fPRcWYaNjgbF0xQhETik0ouR94I2F+sy+79YfsUfAelw9u2pJjFSq9E/Fgg74KHlhzfkoSeGzpHIVtgtfVayqYPG2GgKDJXsF0L8jOjUBHIGyxjx6Dx1pHYbxGStf9bxmpw3EEXRhcUEIN4bbpLb2wte2UiHBmHp+cIdBwB84GQLRMnnprHb2JpzUHkw/6v8DS4zpkBjSWejbGf8JuN/KxgVIH08n0yTXEuNSbuBPW3KrF3LkctdeleKoC//VkpQw==;5:9m1UAaqvFA/jCMf6+g9/yF1+5WLMPTI7xP1a3Efj3disGRnDqEKBvTa8RfQ4UEmwUG+Fn8gHvoVKbI4QpbUALMh1DOphDndQkVntWStAa1H1C3Etulz7d5ZArHb+13u/3Udz61FqSjylyC01kYZAH7FfkMKk1Ke0lPZaI6OYbNqOzXRY/ad3biWHSukZId4Xba4fc20aKxqXAD9dox0OlA==;7:imCZJhu3MpuIhNnF3Kt8HPTA3X7dmkyJ4XuXn09/tAuk8icmxJM08LGWrxW1+ly2S5Gwu28Yd7bTn2BImUYgip86z+8z9hlX8KKCyEQZS9I0HYw0frU+TScwTdw29SAsS2CgYIzgql3A77KnCcH2Zw==
x-ms-office365-filtering-correlation-id: 80e748db-24de-4fed-4224-08d685c128c2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4728;
x-ms-traffictypediagnostic: AM6PR04MB4728:
x-microsoft-antispam-prvs: <AM6PR04MB47281E9836C72A4BEAD37CE084970@AM6PR04MB4728.eurprd04.prod.outlook.com>
x-forefront-prvs: 093290AD39
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(396003)(39860400002)(346002)(376002)(189003)(199004)(3846002)(7416002)(4744005)(71190400001)(71200400001)(2201001)(36756003)(4326008)(316002)(6512007)(105586002)(53936002)(6116002)(6436002)(106356001)(6486002)(86362001)(1076003)(97736004)(81166006)(81156014)(476003)(2616005)(486006)(256004)(52116002)(446003)(68736007)(50226002)(478600001)(2501003)(8936002)(8676002)(66066001)(6506007)(386003)(2906002)(11346002)(102836004)(110136005)(26005)(54906003)(76176011)(305945005)(186003)(7736002)(99286004)(25786009)(14454004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4728;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: H3FIxN/t9Jcuu0yh3kR0PbymPpfa0YTP7OlKWo67Pyyfxl7mBV/FjiA/u9xKC81t3053B59kI2TFD6O9Xq/IzesPxVmrrYsWFE3kBSYYCagwNTtE0fJNwxGUc2CLhy4o/YfwfmhZmKaMPGbY5qXSUhDF8UqWEkcenqfEZhpMsPHJ1R6F4vYXQ8d39RHF3bop8czNgujMusyDSgZ5wgz/9JvluKMWkRjB3C0TIp7OIj78uYncWBQPYOn8pAJE/ICkj4/tH6jtOIjj7ejuS9DQVbMssGU0d7zbuvLQ3CmuXAUpmF3cKy7yfUS9rUrzQ/PvB4yOgnOFPZFhNAqEtwv+7TKIbAsRexMI0VyAP5sCKtvLSvLAE41tEJYEy6mMTUO3YIuvE2oJkcWMVa8vxhw6P56iBV2EaGoX8n+SDTLhCS8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80e748db-24de-4fed-4224-08d685c128c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2019 08:09:51.7254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4728
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

The reset value is all zero, so set a workable value for Primary,
Secondary and Subordinate bus numbers.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
---
V3:
 - No change

 drivers/pci/controller/pcie-mobiveil.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controlle=
r/pcie-mobiveil.c
index db7ecb021c63..9210165fe8c0 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -582,6 +582,12 @@ static int mobiveil_host_init(struct mobiveil_pcie *pc=
ie)
 	u32 value, pab_ctrl, type;
 	struct resource_entry *win;
=20
+	/* setup bus numbers */
+	value =3D csr_readl(pcie, PCI_PRIMARY_BUS);
+	value &=3D 0xff000000;
+	value |=3D 0x00ff0100;
+	csr_writel(pcie, value, PCI_PRIMARY_BUS);
+
 	/*
 	 * program Bus Master Enable Bit in Command Register in PAB Config
 	 * Space
--=20
2.17.1

