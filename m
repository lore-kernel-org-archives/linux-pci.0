Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011008.outbound.protection.outlook.com [52.101.65.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E27E314A9E;
	Fri, 24 Apr 2026 02:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776999402; cv=fail; b=CV8mU6zrfFCs9LY3mc5w366l/w52iNeSn3GUUQNFr4YozsLRq6bFalw4FZZl6+FhhlLGCjyJWTHvuCdVS6GGDEMF6xtKwA01f8eJHu7AP0dwBYw2JttPYuBSXvUJ7RaxbGOgzKw1lE/mzzTslQaPR7cCiztuJrD4/nlBiQ2908Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776999402; c=relaxed/simple;
	bh=JVHPirqXnJC5ou+4V6ORigalClXOVM6nlgY7keRhTCA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HQ4wkA8R0PW2hbh47NO8MUAaSUv4iXDaM0e75DYYmfcLdymNMhRjCisUxYZSnGJvZkvi7B0WOFfRchvK2qxO6lcDGZNvXZZtoHYWqw24LVbT/ihPP3+0PEbIhjQmIwcydGmb939N/USLfMDJsKaCPtIAs6ppjnmwxCoPFkGyp80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nMMOsGG6; arc=fail smtp.client-ip=52.101.65.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nMMOsGG6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SO/yY9dGOOeDWNp6M0w3JBAynELib/OYoh42J4DGN/gzhArcr32nxWdQaj7Hh3fhiwgpNDKFC3m7EQ3A785PJO+YgsSsLySSgkXSt7T2YwZzzR/x07Bu3t5nVBX4Sr4IWQcNICJmsKt17pqu1cTBbhC2Ae9/OW66+emalEeYH1K/2C4c7eT9VZUIEToD0MW6k9a4EYbdi2m9lGMB0Pau6HWcCkruBBycBWt/haAVH3+knXM/TzaQZXq1oMvD3629VIM/yBn6S271j2+NEFnUglmaGuiayRdkxAHKxvKiUmqf1sCRnMJ70gxnI4WApSRqqBUJj3m9A+NJc4zXnDX4Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SU3Dkdp9jiHl5QYOnxTqHHDmI8qJMUyeIFokLxHv6Qk=;
 b=aMjqZ+zEUIfsTkoyl8uZ05DjoNAwk08zlHbuxjAAlBNgbcPbU27v0DGb6ysUxYHmdb34MLaSxB2/iaiISMsuWxoDHLS3Vo5CqLrS7klN1YhJv6ID8gxWHdkawqofdyTERdyRoO+n2HQuOHFstPDkuya2gJyGzgWZfYUtHitOxV+TnNV0JO+puN+PmiRvjZpEOLz00gQ5kAE1kv6GYJND4gu2xU+VpnI+AfoHRH6UTEDqUCwbhQpzhbj4v1T1hvmNHrogIExyRsvxA3hUqTacYaW1g5N24oN+sAtRf4IK5h6Z44ZZS9qC7gZJcSg+KRcwukqCojBZjmyhU1PEvd7Ttg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SU3Dkdp9jiHl5QYOnxTqHHDmI8qJMUyeIFokLxHv6Qk=;
 b=nMMOsGG6qIIjyIaVbtwvqCteTf19YN8dafHzSc05yapb+a7a5HSTqwBwcCGJFU6ygXh982Lh/iWgkCgn/xx/sd5umjanOOLXOM8U1eYHia0uPSURyCYgVgfoqT67Hor+o2vqH5pQy5T39am5knG8ZDx2D0VZU0a9kCCCdZjq0g0YJpR7OhUDsiz3NHSd13FMxNTDhTMBdXprYCBZ1hyOCAm366Rr2mTDFZ3Nu7L9vwL9D03FHcpuVPMFSpYWK4IoKJ5UuLCQDflZRdjkeKAozW1ZhJ6xS0qAsKu0OEKLrOD5QOGygeMaT7T/d7Zu/zz9NUazGzOW4UgpCfZSX/1XIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5222.eurprd04.prod.outlook.com (2603:10a6:20b:11::12)
 by DU2PR04MB8791.eurprd04.prod.outlook.com (2603:10a6:10:2e2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 02:56:23 +0000
Received: from AM6PR04MB5222.eurprd04.prod.outlook.com
 ([fe80::374c:87:282a:63a3]) by AM6PR04MB5222.eurprd04.prod.outlook.com
 ([fe80::374c:87:282a:63a3%4]) with mapi id 15.20.9846.016; Fri, 24 Apr 2026
 02:56:23 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	bhelgaas@google.com,
	frank.li@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v1 3/3] PCI: imx6: Add root port reset to support link recovery
Date: Fri, 24 Apr 2026 10:57:35 +0800
Message-Id: <20260424025735.1490772-4-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260424025735.1490772-1-hongxing.zhu@nxp.com>
References: <20260424025735.1490772-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0223.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f3::9) To AM6PR04MB5222.eurprd04.prod.outlook.com
 (2603:10a6:20b:11::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5222:EE_|DU2PR04MB8791:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c751684-cb7f-42d1-fcd6-08dea1ad119d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|19092799006|1800799024|56012099003|22082099003|18002099003|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	kYaiHQABDQl4C+Ba2UuqzTNAd1f2nbN7Be/Wp8+NhikbT9EfoEZfMHrp8y26f8KmbxU7pvulxMf330kknlwZoRyDWe4hwXS38G6V+1bZQkv7ePZrcXtgj41osL1Gf7bX3j+P9c8LTbA5hD9HXjKXpWCVWxZpsBM4/iyV6KNl6JxzCKfRvGqd9H15TrK/jK5izJPGqUMih4cuwHjKTZvAAJ5vtIJy9B6XsAfUo0UZVRpvVzXdIAQ4ysfJjQCgvf4lIHNCtldgQ/Qd5Qfs76p8PQzWrhSL9mhL3i/XTeks0RHt6dQyncj5G9nQVTcNGGhqB4xnwQuK61MFr+e+YXHJ1YA+RXOtQLkZxaj0Fa05jYm96nF3AoKiR9RIpuPrjlX7URZHsHXga1ifk1LwFlVwnbhxKeA+H2f9sna/zGW/9jColjznEHFHfspZycJjYZ4/aSZrX7tyEvX3KLz179KOKvhChzOod2MPOG0+Q6XAH1/b/pBRcBK4c1Xh6DrTLApDS1k0ts204nRb+yB5Fmn10GpDC/Sj6vWjXoWvg0IJ/E0lRPKOVrN0XJ8iFPlGqveqMTYOSG2ltOClp2FdyEF8AWVKt8f473m7vyUapRTf4Yo5HVgLQKyXtAHPrrIlTcwk6HouIq73HrfRRFCN5rNpeUSkqk762rGOctp145QpYFKQK3DjDBA83FvzUSxyIAR+88ejYSL8w2y/jpux9erw2MxPHz33ASrc1GvjrlyTxZm3DF5FolO4ZXI1hKFBnYWWllLI7owUTRuUnSL2rMdWedNg1nGOX4uP9/11x8E+GjyVJ+HIQdAoiEHvRs2FrW/2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5222.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(19092799006)(1800799024)(56012099003)(22082099003)(18002099003)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S0p5g5DnVX7dQuIYSylmyiNbnVXucsraNLAa9G8jTtGt8WEpYxP49zN0n8Y9?=
 =?us-ascii?Q?NUuUMaZ6jGtA30v3Pewh7ShmqHrrSQqyO8hylAFJgP5D3Sanpt9cdv+uljc1?=
 =?us-ascii?Q?Cy4ISJAdqQok+WcFbrg2fvug+Zg2EV6wmQJbVQ9oatoPs2+TVPo/FLlZlGRe?=
 =?us-ascii?Q?V69pR1kdrzUNTyaB6NlZNOBWfO36T4cRuwpEi+F7JNFOv0+RavC8dNyXseQ/?=
 =?us-ascii?Q?LdTTOYgwCw0fTAcn1a94g9uPO1pbTLULE/5lcMHShUuAs3UNs4b0g+Og2mG7?=
 =?us-ascii?Q?Mk+FtgJRS0Fr0KnnKQZMiv2ItdigMLCyqY6O8VYMZxqALb1GM8ndouv/mxE2?=
 =?us-ascii?Q?fP3udO/YFiYaHzmH7ISXVBBV04oaxeUyosU7GD2BgBl7blIi2iS1Trx9s84i?=
 =?us-ascii?Q?Wjwokhle9hLNGdyrZKEq9Rr9cvwMJlGRIaAiQGQ2yNBZ/Eorpa96JcLrr/WR?=
 =?us-ascii?Q?3K3s55PC+t4TEaYTtBMpH8JVmgG7thS2+WmT6L6eXCl3B/4bqb6zzEvAuqOQ?=
 =?us-ascii?Q?wKl+GSuh3g2kpp3UpwaBpVWH6vej2prb12FOpUjg79/9oPcLzbqe9zHjD/Xw?=
 =?us-ascii?Q?6gqRo8quujW0R838dBewyRjBrSjtwGtkq9Ox+71aOss9hyiBMTzZhBcxhbU8?=
 =?us-ascii?Q?FyRgyHh+kvi0nmIT3oUOwc50/vZ6E3RbZ7r2mDO86uxfVr41omMc7MWUgkDr?=
 =?us-ascii?Q?KgrM7MEppVgnKwQBqJt12hrTKsrK4A8lM9dQsgEPxPmpT09psfP5twCSHgiq?=
 =?us-ascii?Q?fV3OZSAW/VjzSCDH1vU7EP+rdxez/JNF4Fhl5J/IMVLrROx0Rnh0puywSJKs?=
 =?us-ascii?Q?qfIbsWRmCv0oI/JxbgU9Wanh59xyf7AUYyG32dJFvICfnlM4r6JVmOH2R1kd?=
 =?us-ascii?Q?alKaVvj9luy1vDdpIFH92EAXh7hdO1JYLYETTi35YIIwL+FNhV+z7UOeGYH4?=
 =?us-ascii?Q?70KCXzfiRotMwwkQJglHQAeWmk2ruex+6Esh0M8gfD8HtylY+2ONnjSAFlJT?=
 =?us-ascii?Q?q5fP92EMARiYGagY7hSeEbbv+YAuToSVjpY250vXrH/wgUHI4uMs/OZ/Bin2?=
 =?us-ascii?Q?ZrTvZB1YggYeQ00yYcH2uFTRvPvbxr9Nq88XTwZmTWTbMph1EHduBhYyhs70?=
 =?us-ascii?Q?//Mfn9OxTohs1GDLoeKR4RSTKR2ZV5dPbCLlbuJn68mC306Gp1kTWqKRXSXr?=
 =?us-ascii?Q?LftD4u2LtTmsHK/Jm1POF88rj2Lz3Sh+jQlRxbSb8Agypuxv6uL2Sd6Ij6v/?=
 =?us-ascii?Q?5JZAkLMZK+mqyvU5P5j+LKXuJ6P4+E6TpTEZyK58fG78bcvQAhL4JbgLeLsO?=
 =?us-ascii?Q?XIfBgC2TVYXIfEujBOg6iQPKvtlwRB1NV7O3FzAAnqsxtM4dd+BH3QUON3Wq?=
 =?us-ascii?Q?e0RynBNNC6WgaDGrPWPw1JZmd+eaUcnBG072oEgqX+btDbNZhANmm5K5AL9C?=
 =?us-ascii?Q?HsdV6dUXrcGlmtWAb/dR/G0i45dlNALyxbzn5M7mKBjdU3NccduD27+BJ14v?=
 =?us-ascii?Q?8dUdMxbKLUz9tqkzRhBA0TYc+FidSgqdW/PLxH0T+UPqJiKKzNjKtcnNiC3q?=
 =?us-ascii?Q?4pYfucsBio1j1tJIphLAlAB+pn9FDs8UuaCbsoo6deQC73Y1ooNQ9tnPpf3t?=
 =?us-ascii?Q?DCvK1XJlKyiMYsJtuctjPgHHyGzpsbQEGCWMhdOKoTMt5dzIRrkMk9tbID3D?=
 =?us-ascii?Q?NoAeoULk2UuyzNW/yIYdmXF/PxJEZjIqCLjQ3bjIIafESwtORjo+qN81zJz8?=
 =?us-ascii?Q?B8NjkVfmCg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c751684-cb7f-42d1-fcd6-08dea1ad119d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5222.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 02:56:23.3745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MmqtWHQ1olQuO614V/lKIau2KTdW119he7WZxRyEARielQOh8e5bNoaMMGVTZaeKvWhFZiCQw8MzsBumzB+3sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8791

The PCIe link can go down due to various unexpected circumstances. Add
root port reset support to enable link recovery for the i.MX PCIe
controller when the optional "intr" interrupt is present.

Reset root port to uninitialize, initialize the PCIe controller, and
restart the PCIe link at end when a link down event happens.

On i.MX95 platforms, link events and PME share the same interrupt line.
The link event interrupt cannot use a threaded-only IRQ handler because
the PME driver uses request_irq() with only the IRQF_SHARED flag set,
which requires a primary handler.

To handle this shared interrupt scenario, register a primary interrupt
handler with IRQF_SHARED for link events and manipulate the link event
enable bits to ensure the shared interrupt source triggers only one
handler at a time.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 122 ++++++++++++++++++++++++++
 1 file changed, 122 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index e35044cc52185..0fb75d4b4e636 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -34,6 +34,7 @@
 #include <linux/pm_runtime.h>
 
 #include "../../pci.h"
+#include "../pci-host-common.h"
 #include "pcie-designware.h"
 
 #define IMX8MQ_GPR_PCIE_REF_USE_PAD		BIT(9)
@@ -78,6 +79,10 @@
 #define IMX95_SID_MASK				GENMASK(5, 0)
 #define IMX95_MAX_LUT				32
 
+#define IMX95_LINK_INT_CTRL_STS			0x1040
+#define IMX95_LINK_DOWN_INT_STS			BIT(11)
+#define IMX95_LINK_DOWN_INT_EN			BIT(10)
+
 #define IMX95_PCIE_RST_CTRL			0x3010
 #define IMX95_PCIE_COLD_RST			BIT(0)
 
@@ -125,6 +130,8 @@ enum imx_pcie_variants {
 #define IMX_PCIE_MAX_INSTANCES	2
 
 struct imx_pcie;
+static int imx_pcie_reset_root_port(struct pci_host_bridge *bridge,
+				    struct pci_dev *pdev);
 
 struct imx_pcie_drvdata {
 	enum imx_pcie_variants variant;
@@ -158,6 +165,7 @@ struct imx_pcie {
 	bool			supports_clkreq;
 	bool			enable_ext_refclk;
 	struct regmap		*iomuxc_gpr;
+	u32			lnk_intr;
 	u16			msi_ctrl;
 	u32			controller_id;
 	struct reset_control	*pciephy_reset;
@@ -1306,6 +1314,13 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 
 	imx_setup_phy_mpll(imx_pcie);
 
+	/*
+	 * Callback invoked by PCI core when link down is detected and
+	 * recovery is needed.
+	 */
+	if (pp->bridge)
+		pp->bridge->reset_root_port = imx_pcie_reset_root_port;
+
 	return 0;
 
 err_phy_off:
@@ -1573,6 +1588,9 @@ static int imx_pcie_suspend_noirq(struct device *dev)
 	if (!(imx_pcie->drvdata->flags & IMX_PCIE_FLAG_SUPPORTS_SUSPEND))
 		return 0;
 
+	if (imx_pcie->lnk_intr)
+		regmap_clear_bits(imx_pcie->iomuxc_gpr, IMX95_LINK_INT_CTRL_STS,
+				  IMX95_LINK_DOWN_INT_EN);
 	imx_pcie_msi_save_restore(imx_pcie, true);
 	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_LUT))
 		imx_pcie_lut_save(imx_pcie);
@@ -1623,6 +1641,9 @@ static int imx_pcie_resume_noirq(struct device *dev)
 	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_LUT))
 		imx_pcie_lut_restore(imx_pcie);
 	imx_pcie_msi_save_restore(imx_pcie, false);
+	if (imx_pcie->lnk_intr)
+		regmap_set_bits(imx_pcie->iomuxc_gpr, IMX95_LINK_INT_CTRL_STS,
+				IMX95_LINK_DOWN_INT_EN);
 
 	return 0;
 }
@@ -1632,6 +1653,84 @@ static const struct dev_pm_ops imx_pcie_pm_ops = {
 				  imx_pcie_resume_noirq)
 };
 
+static irqreturn_t imx_pcie_link_irq_handler(int irq, void *priv)
+{
+	struct imx_pcie *imx_pcie = priv;
+	struct dw_pcie *pci = imx_pcie->pci;
+	struct device *dev = pci->dev;
+	u32 val;
+
+	regmap_read(imx_pcie->iomuxc_gpr, IMX95_LINK_INT_CTRL_STS, &val);
+	if (val & IMX95_LINK_DOWN_INT_STS) {
+		dev_dbg(dev, "PCIe link down detected, initiating recovery\n");
+		regmap_clear_bits(imx_pcie->iomuxc_gpr, IMX95_LINK_INT_CTRL_STS,
+				  IMX95_LINK_DOWN_INT_EN);
+		regmap_set_bits(imx_pcie->iomuxc_gpr, IMX95_LINK_INT_CTRL_STS,
+				IMX95_LINK_DOWN_INT_STS);
+
+		return IRQ_WAKE_THREAD;
+	} else {
+		return IRQ_NONE;
+	}
+}
+
+static irqreturn_t imx_pcie_link_irq_thread(int irq, void *priv)
+{
+	struct imx_pcie *imx_pcie = priv;
+	struct dw_pcie *pci = imx_pcie->pci;
+	struct dw_pcie_rp *pp = &pci->pp;
+	struct pci_dev *port;
+
+	for_each_pci_bridge(port, pp->bridge->bus)
+		if (pci_pcie_type(port) == PCI_EXP_TYPE_ROOT_PORT)
+			pci_host_handle_link_down(port);
+
+	regmap_set_bits(imx_pcie->iomuxc_gpr, IMX95_LINK_INT_CTRL_STS,
+			IMX95_LINK_DOWN_INT_EN);
+
+	return IRQ_HANDLED;
+}
+
+static int imx_pcie_reset_root_port(struct pci_host_bridge *bridge,
+				    struct pci_dev *pdev)
+{
+	struct pci_bus *bus = bridge->bus;
+	struct dw_pcie_rp *pp = bus->sysdata;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct imx_pcie *imx_pcie = to_imx_pcie(pci);
+	int ret;
+
+	imx_pcie_msi_save_restore(imx_pcie, true);
+	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_LUT))
+		imx_pcie_lut_save(imx_pcie);
+	imx_pcie_stop_link(pci);
+	imx_pcie_host_exit(pp);
+
+	ret = imx_pcie_host_init(pp);
+	if (ret) {
+		dev_err(pci->dev, "Failed to re-init PCIe\n");
+		return ret;
+	}
+	ret = dw_pcie_setup_rc(pp);
+	if (ret)
+		goto err_host_deinit;
+
+	imx_pcie_start_link(pci);
+	dw_pcie_wait_for_link(pci);
+
+	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_LUT))
+		imx_pcie_lut_restore(imx_pcie);
+	imx_pcie_msi_save_restore(imx_pcie, false);
+
+	dev_dbg(pci->dev, "Root port reset completed\n");
+	return 0;
+
+err_host_deinit:
+	imx_pcie_host_exit(pp);
+
+	return ret;
+}
+
 static int imx_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1834,9 +1933,32 @@ static int imx_pcie_probe(struct platform_device *pdev)
 			val |= PCI_MSI_FLAGS_ENABLE;
 			dw_pcie_writew_dbi(pci, offset + PCI_MSI_FLAGS, val);
 		}
+
+		/* Get link event irq if it is present */
+		imx_pcie->lnk_intr = platform_get_irq_byname(pdev, "intr");
+		if (imx_pcie->lnk_intr < 0)
+			return 0;
+
+		ret = devm_request_threaded_irq(dev, imx_pcie->lnk_intr,
+						imx_pcie_link_irq_handler,
+						imx_pcie_link_irq_thread,
+						IRQF_SHARED,
+						"lnk", imx_pcie);
+		if (ret) {
+			dev_err_probe(dev, ret, "Unable to request LNK IRQ\n");
+			goto err_host_deinit;
+		}
+
+		regmap_set_bits(imx_pcie->iomuxc_gpr, IMX95_LINK_INT_CTRL_STS,
+				IMX95_LINK_DOWN_INT_EN);
 	}
 
 	return 0;
+
+err_host_deinit:
+	dw_pcie_host_deinit(&pci->pp);
+
+	return ret;
 }
 
 static void imx_pcie_shutdown(struct platform_device *pdev)
-- 
2.37.1

