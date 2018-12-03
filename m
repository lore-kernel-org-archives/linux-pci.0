Return-Path: <SRS0=SeHV=OM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED5DC04EBF
	for <linux-pci@archiver.kernel.org>; Mon,  3 Dec 2018 10:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DCD620850
	for <linux-pci@archiver.kernel.org>; Mon,  3 Dec 2018 10:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WxcCu096"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DCD620850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725983AbeLCKkK (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 3 Dec 2018 05:40:10 -0500
Received: from mail-eopbgr00077.outbound.protection.outlook.com ([40.107.0.77]:53049
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725888AbeLCKkJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 3 Dec 2018 05:40:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42WJ7RDVNfnSKBpBhn/673Q4snxwCLXR6iImXyhc7mk=;
 b=WxcCu096yph1HGNUKaz/IbXm89bL3YpS31O37z2+RXlNxazYb5Vt25gXwz2HAzsjN1XwjdKAwPOJmODPfO88xUiUQvbC7SqBM+NDWFAELewhimybKI1+8AEdCcS24bz+OZFlxYOlSDK5M7BCksIrNFw5QHg05iSA0afK3WS9eI0=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.2.80) by
 AM6PR04MB5574.eurprd04.prod.outlook.com (20.178.94.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.20; Mon, 3 Dec 2018 10:39:37 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::29b5:b3ed:3854:cf1c]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::29b5:b3ed:3854:cf1c%5]) with mapi id 15.20.1382.020; Mon, 3 Dec 2018
 10:39:37 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "l.subrahmanya@mobiveil.co.in" <l.subrahmanya@mobiveil.co.in>
CC:     Leo Li <leoyang.li@nxp.com>, "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>
Subject: [PATCHv2 1/2] PCI: mobiveil: ls_pcie_g4: add Workaround for A-011577
Thread-Topic: [PATCHv2 1/2] PCI: mobiveil: ls_pcie_g4: add Workaround for
 A-011577
Thread-Index: AQHUivR8ePRHkblC7EqMWnaWVzeadA==
Date:   Mon, 3 Dec 2018 10:39:37 +0000
Message-ID: <20181203104000.48626-2-Zhiqiang.Hou@nxp.com>
References: <20181203104000.48626-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20181203104000.48626-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR02CA0167.apcprd02.prod.outlook.com
 (2603:1096:201:1f::27) To AM6PR04MB5781.eurprd04.prod.outlook.com
 (2603:10a6:20b:aa::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB5574;6:hYvGPinRAPkly01HmMWGwMNhfdvXxX0CWStGFQJMlu+JHA85T4j1t6I7///qgfrtSlkC6YeTHrzKkC90WLKdPuqhLsvW65IvoWmVpvstOivEUF7mtZvEevo/OmWPizsKwVoDmj6OKWchV+OERUgv76C5H+2OG2vIh8gKPJUKOge8dygXpxX+gMCEadA+GCWiIhdymId7w1vNhxsDgd6yxm1ZpiHkblofxQb0EoQVK1Pldu+gMUlylR7QumyiawwtJv3DiDLiGVvWazuGerxWQpm+zLlKBlRcbo2ao99BRC3Y+evhYOTSXSmkHasoB/BX638H0IhuYZ/XYq+W+MEEMecY5WF0rVl9TtTK9t+XGHm2EKuw+GlU/ocn6s2IJXVIeDoI729uUDuloBipB1n6fuwemBc+aoexGzGoHIO9Lk2kTdBcQwTzr387Z/XmdIs3XcvcJvrvYvRGdzvHQq/ihw==;5:5M7n1NBojr/SH4SGBCiiZDhSif7xpVqwq23yVW0imeEK/ZYK7aDpAZQtEigekyW2TqEm0nNRLzCikSVCD+TQj/Qp2QQqBVD6mek+1ipPJ227bFGI4DRr4IMzerDCsWCds0nrd6i5Db8a3aXpY5pt1sKzyRknJ/3ZZHFgYEBUEIE=;7:AKreUY2/eLBgQ/jm9VbAUhy3vbKHeo9z0jTn2gkaN76Gr0o1uVnK5zS/spI3SJhJIW9674MvL3tkLJnkLMweRWKuXWZmfaQMBEk1urUnjIS3suZgs33g0aG+MKWmfAHl9sH3L+ewbd/nUx4DFgDfQA==
x-ms-office365-filtering-correlation-id: 5fd8fc76-027b-488e-ab2a-08d6590b9f27
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB5574;
x-ms-traffictypediagnostic: AM6PR04MB5574:
x-microsoft-antispam-prvs: <AM6PR04MB5574CEC61E5E10A71DB91E7E84AE0@AM6PR04MB5574.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231455)(999002)(944501493)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB5574;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB5574;
x-forefront-prvs: 08756AC3C8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(39860400002)(396003)(366004)(189003)(199004)(2501003)(97736004)(6512007)(105586002)(316002)(305945005)(478600001)(102836004)(476003)(76176011)(6436002)(14444005)(6116002)(256004)(99286004)(446003)(14454004)(36756003)(386003)(6506007)(5660300001)(6486002)(26005)(11346002)(3846002)(110136005)(54906003)(8936002)(25786009)(8676002)(86362001)(81166006)(186003)(4326008)(71190400001)(71200400001)(52116002)(68736007)(81156014)(66066001)(106356001)(1076002)(2201001)(7736002)(486006)(2616005)(2906002)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5574;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Yd2ryL0gW9b2WCQp6K2DAEwOws8k2aLEeBNz2xlRCqNs85yD6y8fJMmd+QxvyL7M6fScPxWvZtAk2YHzq06bPc2zjBKSorKfivJE4Fc9RCYgSjVQ6BixjCiHycpXcpLuG+PobwVEjYIUhDXrc68q1awEGi6wdF0gfP0zLwyl+IRnlJ32ulV0/1lnP0lT6iWMdLRClp1+/BkhAbCW5vYw1V/aRhCkXlLbM+xAhvSFaQJtjiqwmRfzZzoCZ2B3szcM9Gjya2xa2eQUlyOtQMlx5P95K6BTc1kpoqQrgso6f+/iHsmTPnLbpWEZonMTUni/OPZfs0gwO/uR8Hz3UxYN2Run4bDe6OSVJnt5dnc0tIk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fd8fc76-027b-488e-ab2a-08d6590b9f27
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2018 10:39:37.1895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5574
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
V2:
 - Only apply the workaround for Rev1.0.

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
index c85f00d3cfcf..70f64cdde37f 100644
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

