Return-Path: <SRS0=gAuQ=QF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A456C282C7
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 08:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19EE2214DA
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 08:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Y1gsAqUa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbfA2IJm (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 29 Jan 2019 03:09:42 -0500
Received: from mail-eopbgr00042.outbound.protection.outlook.com ([40.107.0.42]:30688
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727781AbfA2IJl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Jan 2019 03:09:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4pRlTG/hTHjG7NncY//Wh/e8nBhMaDygHgI02F1ibrU=;
 b=Y1gsAqUarnDRTmQo7B8qZtmKhdhrLvntXA55Ipf7hv7IvQX52vxShOqmN0Z6QgYMFnhHnM3wkBe5mixqjsaLeXl6bndKBTwUAtzVewed/r0dqZ6Q1AJckIo7Qkqf+cCTxFNY4Yh31GqoxSMoBCLmhw6rHGuz5L+cTp0yU7m9q2Y=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB4774.eurprd04.prod.outlook.com (20.177.32.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Tue, 29 Jan 2019 08:09:38 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::9c0:e3aa:b41f:9504]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::9c0:e3aa:b41f:9504%3]) with mapi id 15.20.1558.023; Tue, 29 Jan 2019
 08:09:38 +0000
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
Subject: [PATCHv3 11/27] PCI: mobiveil: only fix up the Class Code field
Thread-Topic: [PATCHv3 11/27] PCI: mobiveil: only fix up the Class Code field
Thread-Index: AQHUt6n6FgLtfR2uu0ORRlaW6wBtmg==
Date:   Tue, 29 Jan 2019 08:09:38 +0000
Message-ID: <20190129080926.36773-12-Zhiqiang.Hou@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;AM6PR04MB4774;6:DHU1rjS6gYNBFBWt15b/8YfN9sBi1F1OEQf+o5lYjl7GP6y8PMlHlt8Duc/EXPtdvbQF+EPVhzyQhnRJ6FpsQarhmDeyoOSR+RYUxqLoNSV0gyNwj2AAzX4D3hkSbb36WY91PgM8dZuatC+qkw+E47MPX3v4qmQ0uHrvkKnzLUocnNNrKPsUvAvZ5E3gF467P2kX7UIMOO721lpBRb8uKonD7K7LuNK7MVrg8zOT17MUxqvJiIKjMZVgVjFQNZdA6mjnQHwuCAwEAb8GpQixj0I2kzkgoqMSiqKvLw5rGZgWanHclGTmuclr4oPulBrz7pqputUSjqdCGssL0AZ/P4AznIgrkROON+xp2z81bLmIlFVoSp2jo1wowO9GBU2UTbniFbcqAp0clVK8paWWlgazfxCmffldDqzxN4ioo25UA9AND2w5JbGO9eCpngt3Mi0BUbgM4tNdU5izvgWa1Q==;5:eefonoV71O84mDtcctMkBqpwvi5v+wNIw3KerrV4eFK0a9zUqlqv92JZ/DtxnBhDOaFXB+1ABnt07ii5Y1AJoVIJFp0gKs2OBIsqZW0BLT8dj1Y8YzaJOpv5EGm0QlWt0uEHpJ89Z4ivq5IcxULuJi2BcMlHc3E6DE5/QKYMgAYJ55+PhxhcVD7S7jKWdV1Hvnq1YeJMH3VUiuxg69wS2g==;7:jUo4huw0vBA2SzecXe26yC8l/Fwqd6DGyPyvcezVlefMLA2dJ1hFhSs0LaTqUtZX2ovJq2ewoA326B0xRnykLwWOyXZnnfhAgsicaVAQ4L6KxSO5FdLwwEQz/VxQ0fE/Zum+QPy1ntgpIfUwZSltUA==
x-ms-office365-filtering-correlation-id: 0d0da117-2c69-485d-7276-08d685c11d14
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4774;
x-ms-traffictypediagnostic: AM6PR04MB4774:
x-microsoft-antispam-prvs: <AM6PR04MB477467A82AA6C090EAA7B6B584970@AM6PR04MB4774.eurprd04.prod.outlook.com>
x-forefront-prvs: 093290AD39
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(376002)(396003)(136003)(39860400002)(189003)(199004)(86362001)(2201001)(102836004)(4326008)(305945005)(186003)(478600001)(26005)(7736002)(386003)(76176011)(71200400001)(14454004)(25786009)(6506007)(446003)(53936002)(71190400001)(52116002)(1076003)(256004)(11346002)(7416002)(68736007)(81166006)(81156014)(8936002)(316002)(486006)(6436002)(2616005)(8676002)(110136005)(54906003)(3846002)(2501003)(6116002)(99286004)(2906002)(476003)(105586002)(97736004)(36756003)(50226002)(66066001)(6512007)(106356001)(6486002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4774;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LBUrZa7HQYjB69a6T0ib8WGaJPOZwgOKo2eWe7ZDPI22FuiuSLq0glkEveQRIUaLzObu9Rv2Ed4dwcFTXnVOqnsTjgv0ylg1OmyspU0Y/qag2g9U+ZWQvyHTGIgAMT1NGkv8DpTXvBmoI8jIO87WafxiBDHXJK+0Ej4GOXZxc8hCNEflkygIStensSvChdk9IB9GOWfEKIDA5CUmM1DVwPcfCX60se+dXTx3BGfjZ3NqcJX1aZi6QGc8tPsSddL530sHgzWZFx+wPvEQTV4HiaLuy4XG/8giWjTlYzliT2oqUWcp5MdwTomfLl7ioubWifcEzJPjaOlUTGz3qw7vbFLAFtgN2gBO86WDqgAokWFPfRCUmyxlWCgJlJa8ReBy8CcI1QlFsiL25gP4JuuuWQllfOfNTp9rx4YM0gUEPyA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d0da117-2c69-485d-7276-08d685c11d14
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2019 08:09:32.6470
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4774
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Fix up the Class Code to PCI bridge, do not change the Revision ID.
And move the fixup to mobiveil_host_init function.

Fixes: 9af6bcb11e12 ("PCI: mobiveil: Add Mobiveil PCIe Host Bridge
IP driver")
Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
---
V3:
 - No change

 drivers/pci/controller/pcie-mobiveil.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controlle=
r/pcie-mobiveil.c
index 78e575e71f4d..8eee1ab7ee24 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -653,6 +653,12 @@ static int mobiveil_host_init(struct mobiveil_pcie *pc=
ie)
 				   type, resource_size(win->res));
 	}
=20
+	/* fixup for PCIe class register */
+	value =3D csr_readl(pcie, PAB_INTP_AXI_PIO_CLASS);
+	value &=3D 0xff;
+	value |=3D (PCI_CLASS_BRIDGE_PCI << 16);
+	csr_writel(pcie, value, PAB_INTP_AXI_PIO_CLASS);
+
 	/* setup MSI hardware registers */
 	mobiveil_pcie_enable_msi(pcie);
=20
@@ -896,9 +902,6 @@ static int mobiveil_pcie_probe(struct platform_device *=
pdev)
 		goto error;
 	}
=20
-	/* fixup for PCIe class register */
-	csr_writel(pcie, 0x060402ab, PAB_INTP_AXI_PIO_CLASS);
-
 	/* initialize the IRQ domains */
 	ret =3D mobiveil_pcie_init_irq_domain(pcie);
 	if (ret) {
--=20
2.17.1

