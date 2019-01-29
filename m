Return-Path: <SRS0=gAuQ=QF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E87C169C4
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 08:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3902B214DA
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 08:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hjSp+001"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbfA2ILI (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 29 Jan 2019 03:11:08 -0500
Received: from mail-eopbgr150087.outbound.protection.outlook.com ([40.107.15.87]:28160
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725468AbfA2ILI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Jan 2019 03:11:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Ijucq+in7jzAUvaRJqQehF8100FgZk16qweqH1kdag=;
 b=hjSp+00125C5F5R2fqNWVpANlBSNlXVd9yOjzw6+nFFYEMK/bPvQu5Ok26ZwJxhcNJq0zGtDs2kwKzyf123xi/DZx7+5dg4bBizMCQphYKq0gkPQxHMRs16/E+SfHCIAkrnTj5T0A8xw/hOx7mNiYn89I+YjId6xs+5ONu8jOAs=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB6117.eurprd04.prod.outlook.com (20.179.7.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Tue, 29 Jan 2019 08:11:01 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::9c0:e3aa:b41f:9504]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::9c0:e3aa:b41f:9504%3]) with mapi id 15.20.1558.023; Tue, 29 Jan 2019
 08:11:01 +0000
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
Subject: [PATCHv3 24/27] PCI: mobiveil: ls_pcie_g4: add Workaround for
 A-011577
Thread-Topic: [PATCHv3 24/27] PCI: mobiveil: ls_pcie_g4: add Workaround for
 A-011577
Thread-Index: AQHUt6osDgubRWC4UkS7LbPeiPAwNQ==
Date:   Tue, 29 Jan 2019 08:11:01 +0000
Message-ID: <20190129080926.36773-25-Zhiqiang.Hou@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;AM6PR04MB6117;6:6xhF086TG1/Sz/6gvPQUxzTR0Bef+51Kp7bB1p/yiqCvUym2AeqCBy8cSsks+5EDx0yzDs7odJD1P6suZZT7o9tKQ9clkZ9mr2Opfu+9Lm0UO0FxtuE+qL6O9m8/OrgO3EPyIS8t3lW3In9u8WDod9DqjQ2zIitjM1B6qfnqub1EW/rIB7FAYNA2Q3bZoogXyhJwUTLbLZtlrE/hTlYWd8Q5Hmbymh66rudvyTfM37RXdMFWe90umGBWm5O/0TuT/svt2ASOsVWIIHz45bsUUKq8IfjoXWDyr/lA5EjxRdZiNJ77J6JUJL3RJ+t+hu1N2ffK8fCXzTRhbRGeumkLisNYtrPdOGZyoB4MygaXKorNGe7SB2bBmWUdLdMGnppObPKOdkk4GaI6zettUS6D1q33RnEpywS5jOF6MHFwP+EBQkYL5ZtKtz37VgDKsJBwXO546aDkqoK03eFvO5r+Zg==;5:uoHJxYCfJYdKQxJuiNmkvJwr5QDDDfFDjq04Q+kWbUat0QXR1VtUi62JrKD6S9iOehPu8i6u/HIGCYkHxqzDO6z7k9SefJbs5p7QJw7PIvcwgZcAEgMDbVgK87VCY/rA2sB5Ktih3Y3u80y2YzbiQqZh9NTDRk/GUdzQXUMl0jkL2KXDLUg4Gdh8DqgIwJ/8LbCMYhwKVjxPoid65IFyiA==;7:xXGIVD5wrVZ/M2I5U3v6LQQ9DoQU4DQzbHsuClWxylPYUxOd2fvF0FyPrxrD951hal6VyeRN4yQS46aeFySjB4dTCF9W3yqX6dFGPjX1j/9I2xB2jP+y7mC7H1B20e/fJxzwJLFXrIBUOng/ob4i7g==
x-ms-office365-filtering-correlation-id: 7f7a747b-acc0-4971-92a9-08d685c14e94
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB6117;
x-ms-traffictypediagnostic: AM6PR04MB6117:
x-microsoft-antispam-prvs: <AM6PR04MB61171A9B249308BCF2412CD184970@AM6PR04MB6117.eurprd04.prod.outlook.com>
x-forefront-prvs: 093290AD39
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(396003)(366004)(346002)(376002)(39860400002)(136003)(199004)(189003)(3846002)(966005)(6116002)(486006)(81166006)(81156014)(8676002)(7416002)(106356001)(14454004)(478600001)(386003)(446003)(11346002)(186003)(102836004)(476003)(6506007)(8936002)(50226002)(105586002)(68736007)(71190400001)(2906002)(2616005)(71200400001)(36756003)(2501003)(66066001)(97736004)(26005)(4326008)(25786009)(6436002)(6486002)(53936002)(6512007)(256004)(54906003)(7736002)(14444005)(99286004)(305945005)(76176011)(2201001)(110136005)(1076003)(316002)(86362001)(52116002)(6306002)(921003)(1121003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB6117;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iMX0ZUBrDgA/W05MrvVfZ7bt8S5G2y3rwB+rW7Lz+fgW2/ntlm8MWGLZwvBEbqbW5dRy8MpQHmJ7uqhZm1rw/V8Tie/aLq+Zg1Rj/ZM65gkuy1wRLvDd0zi/gLBkzeWgeUbHX7VDO/MRAZwX5PggHc01s7LiXQsVQsbvjsC2ZM6i3UirII1/Z33SCll2osurX8HeoyClw31ItlbU1q2vcqy3TdOg9vx2CalEZxtu8wXncrN4Mq6qfY5C3STXCgzVwFTwk1SSe/gF1mAupcuCrCxSve+Y4gQthiBKTZyxPDCivAJkVA9ShznVl1iqlcgL+thi9D75a2pw2FhtgN2eT/nKs/8W5pGPDkl+yNCg4x37P1qJuAhU4sV10dgJiqSYk4srmPdNrpQFF0MOBrEPaNRZIKfbfNr2zWIj8c0uLqc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f7a747b-acc0-4971-92a9-08d685c14e94
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2019 08:10:55.7107
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6117
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

PCIe configuration access to non-existent function triggered
SERROR interrupt exception.

Workaround:
Disable error reporting on AXI bus during the Vendor ID read
transactions in enumeration.

This ERRATA is only for LX2160A Rev1.0, and it will be fixed
in Rev2.0.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V3:
 - Integrated without change from http://patchwork.ozlabs.org/patch/1006790=
/

 .../controller/mobiveil/pci-layerscape-gen4.c | 37 +++++++++++++++++++
 .../controller/mobiveil/pcie-mobiveil-host.c  | 17 ++++++++-
 .../pci/controller/mobiveil/pcie-mobiveil.h   |  3 ++
 3 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/mobiveil/pci-layerscape-gen4.c b/driver=
s/pci/controller/mobiveil/pci-layerscape-gen4.c
index 174cbcac4059..d2c5dbbd5e3c 100644
--- a/drivers/pci/controller/mobiveil/pci-layerscape-gen4.c
+++ b/drivers/pci/controller/mobiveil/pci-layerscape-gen4.c
@@ -22,8 +22,13 @@
=20
 #include "pcie-mobiveil.h"
=20
+#define REV_1_0				(0x10)
+
 /* LUT and PF control registers */
 #define PCIE_LUT_OFF			(0x80000)
+#define PCIE_LUT_GCR			(0x28)
+#define PCIE_LUT_GCR_RRE		(0)
+
 #define PCIE_PF_OFF			(0xc0000)
 #define PCIE_PF_INT_STAT		(0x18)
 #define PF_INT_STAT_PABRST		(31)
@@ -41,6 +46,7 @@ struct ls_pcie_g4 {
 	struct mobiveil_pcie *pci;
 	struct delayed_work dwork;
 	int irq;
+	u8 rev;
 };
=20
 static inline u32 ls_pcie_g4_lut_readl(struct ls_pcie_g4 *pcie, u32 off)
@@ -76,6 +82,15 @@ static bool ls_pcie_g4_is_bridge(struct ls_pcie_g4 *pcie=
)
 	return header_type =3D=3D PCI_HEADER_TYPE_BRIDGE;
 }
=20
+static int ls_pcie_g4_host_init(struct mobiveil_pcie *pci)
+{
+	struct ls_pcie_g4 *pcie =3D to_ls_pcie_g4(pci);
+
+	pcie->rev =3D csr_readb(pci, PCI_REVISION_ID);
+
+	return 0;
+}
+
 static int ls_pcie_g4_link_up(struct mobiveil_pcie *pci)
 {
 	struct ls_pcie_g4 *pcie =3D to_ls_pcie_g4(pci);
@@ -188,12 +203,34 @@ static void ls_pcie_g4_reset(struct work_struct *work=
)
 	ls_pcie_g4_reinit_hw(pcie);
 }
=20
+static int ls_pcie_g4_read_other_conf(struct pci_bus *bus, unsigned int de=
vfn,
+				   int where, int size, u32 *val)
+{
+	struct mobiveil_pcie *pci =3D bus->sysdata;
+	struct ls_pcie_g4 *pcie =3D to_ls_pcie_g4(pci);
+	int ret;
+
+	if (pcie->rev =3D=3D REV_1_0 && where =3D=3D PCI_VENDOR_ID)
+		ls_pcie_g4_lut_writel(pcie, PCIE_LUT_GCR,
+				      0 << PCIE_LUT_GCR_RRE);
+
+	ret =3D pci_generic_config_read(bus, devfn, where, size, val);
+
+	if (pcie->rev =3D=3D REV_1_0 && where =3D=3D PCI_VENDOR_ID)
+		ls_pcie_g4_lut_writel(pcie, PCIE_LUT_GCR,
+				      1 << PCIE_LUT_GCR_RRE);
+
+	return ret;
+}
+
 static struct mobiveil_rp_ops ls_pcie_g4_rp_ops =3D {
 	.interrupt_init =3D ls_pcie_g4_interrupt_init,
+	.read_other_conf =3D ls_pcie_g4_read_other_conf,
 };
=20
 static const struct mobiveil_pab_ops ls_pcie_g4_pab_ops =3D {
 	.link_up =3D ls_pcie_g4_link_up,
+	.host_init =3D ls_pcie_g4_host_init,
 };
=20
 static int __init ls_pcie_g4_probe(struct platform_device *pdev)
diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c b/drivers=
/pci/controller/mobiveil/pcie-mobiveil-host.c
index e8d0c4989013..5f51bc2dd6d7 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
@@ -79,9 +79,20 @@ static void __iomem *mobiveil_pcie_map_bus(struct pci_bu=
s *bus,
 	return pcie->rp.config_axi_slave_base + where;
 }
=20
+static int mobiveil_pcie_config_read(struct pci_bus *bus, unsigned int dev=
fn,
+				     int where, int size, u32 *val)
+{
+	struct mobiveil_pcie *pcie =3D bus->sysdata;
+	struct root_port *rp =3D &pcie->rp;
+
+	if (bus->number > rp->root_bus_nr && rp->ops->read_other_conf)
+		return rp->ops->read_other_conf(bus, devfn, where, size, val);
+
+	return pci_generic_config_read(bus, devfn, where, size, val);
+}
 static struct pci_ops mobiveil_pcie_ops =3D {
 	.map_bus =3D mobiveil_pcie_map_bus,
-	.read =3D pci_generic_config_read,
+	.read =3D mobiveil_pcie_config_read,
 	.write =3D pci_generic_config_write,
 };
=20
@@ -309,6 +320,10 @@ int mobiveil_host_init(struct mobiveil_pcie *pcie, boo=
l reinit)
 	value |=3D (PCI_CLASS_BRIDGE_PCI << 16);
 	csr_writel(pcie, value, PAB_INTP_AXI_PIO_CLASS);
=20
+	/* Platform specific host init */
+	if (pcie->ops->host_init)
+		return pcie->ops->host_init(pcie);
+
 	return 0;
 }
=20
diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.h b/drivers/pci/=
controller/mobiveil/pcie-mobiveil.h
index 0ccd6cee5f8f..ab43de5e4b2b 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil.h
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
@@ -145,6 +145,8 @@ struct mobiveil_msi {			/* MSI information */
=20
 struct mobiveil_rp_ops {
 	int (*interrupt_init)(struct mobiveil_pcie *pcie);
+	int (*read_other_conf)(struct pci_bus *bus, unsigned int devfn,
+			       int where, int size, u32 *val);
 };
=20
 struct root_port {
@@ -160,6 +162,7 @@ struct root_port {
=20
 struct mobiveil_pab_ops {
 	int (*link_up)(struct mobiveil_pcie *pcie);
+	int (*host_init)(struct mobiveil_pcie *pcie);
 };
=20
 struct mobiveil_pcie {
--=20
2.17.1

