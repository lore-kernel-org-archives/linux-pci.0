Return-Path: <SRS0=4GJS=N7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F2CC43610
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 09:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 823202075B
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 09:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ExBx9BV1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 823202075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727974AbeKTTzD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Nov 2018 14:55:03 -0500
Received: from mail-eopbgr80073.outbound.protection.outlook.com ([40.107.8.73]:11604
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727477AbeKTTzC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Nov 2018 14:55:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IjcSXw7tHNyA93XfqGn65Uz6dkglRFYQIp/PtgEylDk=;
 b=ExBx9BV1Bkf8QGnMxXpaEkmrEejZdb6h0LSI6gdJDP53aL+22L6BexzY+rkCwi2Tzt8GIiP7s7Bc+6yvwcTn2JlqJjrkkitM3SxVBibUZp4p8RksuIOab89BwHJOiPHT1cJpElmRsw0eZs+G/5IsOLLKLUW6Z5xLN1qZDoKzVXE=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.2.80) by
 AM6PR04MB5269.eurprd04.prod.outlook.com (20.177.35.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.21; Tue, 20 Nov 2018 09:26:50 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::29b5:b3ed:3854:cf1c]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::29b5:b3ed:3854:cf1c%4]) with mapi id 15.20.1339.026; Tue, 20 Nov 2018
 09:26:50 +0000
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
Subject: [PATCHv2 12/25] PCI: mobiveil: move out the link up waiting from
 mobiveil_host_init
Thread-Topic: [PATCHv2 12/25] PCI: mobiveil: move out the link up waiting from
 mobiveil_host_init
Thread-Index: AQHUgLMquEOAt+rjOkCT2d13q//Fpw==
Date:   Tue, 20 Nov 2018 09:26:50 +0000
Message-ID: <20181120092615.11680-13-Zhiqiang.Hou@nxp.com>
References: <20181120092615.11680-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20181120092615.11680-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR03CA0050.apcprd03.prod.outlook.com
 (2603:1096:202:17::20) To AM6PR04MB5781.eurprd04.prod.outlook.com
 (2603:10a6:20b:aa::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB5269;6:AWQ1sYEk2nm5xqfqW30Ocpj2Fbkl4++aKn1ilMFY44NCdj5BUYCe+a8eAD8e6HmqPLB3OWG5R66/e4NngdOrisLt+uIzVyFwg94XVH9i9AzE8VCb2ndFQBsD9QL6h0GvzuZJqDPDNyJAI1PCzWlmQ+toFKDMZUABDKFxnTqALrNTxk7OWgOL8todNxow4ZT9iCr3zFCHMcAxe0aT0+37hZtxOje1HVPjrfKXblocA95SgyazkmZrZyyYi+dp+xD1Nbw4S2lHRfXYytbW9Za4eE0U/0twyygSgyL7ZUUYMxoJR1ma4GzMnK64fCE2f1o4X+yVL691JahddKCr6KrCILwkT0InnJT39817Fu4OHFMVDOCAmz5gC5yCQUsTVXWfNDHyoSynnlZ8QQmOXkpnB1EF0NNgpmcCmGTNTmdy83JxMnm+6vyv4T+VtEfcGllRZKXVphI4VZyQ/H0u8FtuCw==;5:0zYA2CLN12GAnIWzPzs2Imo6umMMsYt9wuknQCMJtdc6PxJ16q5yQ8ru7tAA/Y+YiWf7zIzNCtaPDOugGhJd6NXA5GRlDm+4qSZ3ogGXV59lvCqpjMc8TcrWqnuEl+uKhwOMlcniYN1NQyxcUMAlR0fpySz4EaHps3eT87AmKog=;7:GGDFdKhoVqw1r5mwx1d35Keo0qeeYWMw1zwiwgTsP2JNYdbmlZWipFycRX/kZWF3V3446+HHYOFga6F1Wog3VYsJIRz5v7CKGt+9EKPkNeUn1Fe0zkGG+C/J1rlq/lu/wQHNTYD3fJOfd791e4pBOQ==
x-ms-office365-filtering-correlation-id: 9ddd7237-d838-483c-13fe-08d64eca4ce4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB5269;
x-ms-traffictypediagnostic: AM6PR04MB5269:
x-microsoft-antispam-prvs: <AM6PR04MB52695BF0436486013DB3C96E84D90@AM6PR04MB5269.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231442)(944501410)(52105112)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB5269;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB5269;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(396003)(366004)(39860400002)(189003)(199004)(305945005)(7736002)(36756003)(5660300001)(7416002)(68736007)(2906002)(4326008)(8936002)(14454004)(256004)(54906003)(53936002)(6436002)(71200400001)(110136005)(71190400001)(6512007)(316002)(2616005)(476003)(446003)(11346002)(486006)(25786009)(2501003)(2201001)(86362001)(52116002)(76176011)(6506007)(102836004)(386003)(186003)(106356001)(26005)(2900100001)(81156014)(81166006)(105586002)(6486002)(8676002)(99286004)(66066001)(6116002)(3846002)(1076002)(478600001)(97736004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5269;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 5Sg+Aqf1ka9dH012De7b6HhvhDgBxwHr5Yun5/6RW6zftUjFYOQbODpPKmt+cLdwOqsF5DWXa2XzdWyuYf9nTe+ZquTVgPIcaB9HxHIpS90mq55Zc5zfOduFF8B5tjwciJvpJOj3PGSYIZNqILamkLU7w+c44K+Q3nqBYoBA2S0uy98wb62hFSnCRb8jCXAWlGL3h7JK3ghfYWf6sBKQJ2lR/DryFjMTgNQDIG07PWtFZjo0kEO01512SsomLalsgcL6QE2MLXtGMC/rZzsUP69oUXnXie66DNaUgSyK4nDPbaNsc53RO1XBZktz+no940LZPXeI+krApvJShCt6iDRT4b7Dtu/Pcysd/ein5gQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ddd7237-d838-483c-13fe-08d64eca4ce4
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 09:26:50.2379
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5269
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Host initial sequence does not depend on PCIe link up, so move it
to the place just before the enumeration.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V2:
 - no change

 drivers/pci/controller/pcie-mobiveil.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controlle=
r/pcie-mobiveil.c
index 8eee1ab7ee24..c2848c22b466 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -582,15 +582,8 @@ static void mobiveil_pcie_enable_msi(struct mobiveil_p=
cie *pcie)
 static int mobiveil_host_init(struct mobiveil_pcie *pcie)
 {
 	u32 value, pab_ctrl, type;
-	int err;
 	struct resource_entry *win;
=20
-	err =3D mobiveil_bringup_link(pcie);
-	if (err) {
-		dev_info(&pcie->pdev->dev, "link bring-up failed\n");
-		return err;
-	}
-
 	/*
 	 * program Bus Master Enable Bit in Command Register in PAB Config
 	 * Space
@@ -662,7 +655,7 @@ static int mobiveil_host_init(struct mobiveil_pcie *pci=
e)
 	/* setup MSI hardware registers */
 	mobiveil_pcie_enable_msi(pcie);
=20
-	return err;
+	return 0;
 }
=20
 static void mobiveil_mask_intx_irq(struct irq_data *data)
@@ -922,6 +915,12 @@ static int mobiveil_pcie_probe(struct platform_device =
*pdev)
 	bridge->map_irq =3D of_irq_parse_and_map_pci;
 	bridge->swizzle_irq =3D pci_common_swizzle;
=20
+	ret =3D mobiveil_bringup_link(pcie);
+	if (ret) {
+		dev_info(dev, "link bring-up failed\n");
+		goto error;
+	}
+
 	/* setup the kernel resources for the newly added PCIe root bus */
 	ret =3D pci_scan_root_bus_bridge(bridge);
 	if (ret)
--=20
2.17.1

