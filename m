Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011064.outbound.protection.outlook.com [52.101.65.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F30213D886;
	Wed,  3 Jun 2026 06:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780467761; cv=fail; b=Up+uy0oVKZuPYM1q0f/gJx7Y5fQt8vQQxpHC770/m5todTslozGbrD+2whE4WcLY7VJW/mox/W7T1vL0mKcAsofqQlsWDgL1ItY5nQ6wb9BF0012akhaGIIQWdBXhZVT0hvRvKPIb3j7wOfwStelmD73cz1R8Fmm7nvwNp+7jcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780467761; c=relaxed/simple;
	bh=DBZQjmQzmRaLg6Sj4uIw/0J8u3ACD8CkGJa5nYbR0aU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jv26ByPz9goKkXzAAEkZ6On9B/QWFnB5QN2lQAO8zFBjgZvnUYjyFC0aruQi152AJYVFDGNwIaNeDKGDim8R/nggoHsT1qWaUfV5I1+OPC8VsMGKnqiNHnxq+tE8WNfvkVxEUZBOxuUJG6TSb7dKhyMGQparVHeimj6AiyLo+bE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=tz34NyY2; arc=fail smtp.client-ip=52.101.65.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="tz34NyY2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OzsQU7/d4/ADQDqcyqFdVoF35YhxOzbA9Zz6GBoS66Bdu4g+VSxdBGm4ffYIxJ9wStFm6X0nSsTm4vV3O9CodW5cNna0qi8MqQu6wMdq/IH2F3WJPL2V+ZItpXo1iXWmH0853peUxIp/18Fgh34FEjy5TXz0wFjPowfQkkxWwiwpZeq2BIXCwa14KI8dpsanwAr89jEF7783iJdLvcJNZsr+D0cJAvODe3MPffayObEP10Z8F3da1bt/dbnX49NUbA48/h/pCO2ut1REtxvVkS9H5m8A+nOLBpxkTOT1hxfRvDGHCb3cd1BmEIvSqnX3GlkdokFo5gEjxrlzGzA2GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aeWx2GQHEEjZjG62/nVWrfQaLBt35VLMEvP0EQbvSJE=;
 b=okxwvbotwgC+BaXRKEJhUaTOrpfEtXtUrrnjJaSTT8i+n9preoJDKYgpYDG2dBndmtg9IFjmJnd3BJT7ubP0nwZ44vlEtAjlJaKOo/me2pRzbSdDXdGTB5tss8c+c84lTNI/K5CP4vJ4bgolcupx21mLgQb0klvpgr/ZSymlKaVxLI0qZAypCU894OyqxKep9UfBdHFyK719aIQH5YinPiPlaQKwB3ZVyE/5AZ5Ed7fwBWJGpFT7mI1UnUyuMqFJ7hgDpIMMw9H3eZlPjEE2BKrEFcgDsDzyAcWfeM05hqYRknYzjCRYB3XuUwUuOmu83h27gEdGm+PusoBqB3dGXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aeWx2GQHEEjZjG62/nVWrfQaLBt35VLMEvP0EQbvSJE=;
 b=tz34NyY2gWyVaufHHRFiIlm/yUmGjXSyPpuSm3fedDYOy2HYlqv6Xz7nzSH8DxhnFL8Uj9pdt9sVo0SoYwXulZRWi1GKygEeWqOXxZAYzzRFRcEQINLdsw82vBbmd6/7Kh0sIu8ioj/9a6BU19vnFgwJJBYie0dcJwioyTdEfnfvfVLyKqU2XToFvAxRxK/9ZAFUKURzGHNxZbXdCQFFfumMPRROLAo3989nglQB7YEvwyxdCu4X0ibGY3fhDrYMvcpX5+OJ1Vg69fAz2xVOHP7fyUrK+P/QkRpazyK2O7uHZLBdTmoCcHRinQgh9qEpy2p6Cizfmdd2eH2g1yhvZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8096.eurprd04.prod.outlook.com (2603:10a6:102:1c7::19)
 by PA1PR04MB11334.eurprd04.prod.outlook.com (2603:10a6:102:4f2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 06:22:36 +0000
Received: from PAXPR04MB8096.eurprd04.prod.outlook.com
 ([fe80::68be:f721:5000:3f2d]) by PAXPR04MB8096.eurprd04.prod.outlook.com
 ([fe80::68be:f721:5000:3f2d%6]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 06:22:36 +0000
From: hongxing.zhu@oss.nxp.com
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
Subject: [PATCH v6 3/3] PCI: imx6: Add root port reset to support link recovery
Date: Wed,  3 Jun 2026 14:25:10 +0800
Message-Id: <20260603062510.3767610-4-hongxing.zhu@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260603062510.3767610-1-hongxing.zhu@oss.nxp.com>
References: <20260603062510.3767610-1-hongxing.zhu@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0044.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::17) To PAXPR04MB8096.eurprd04.prod.outlook.com
 (2603:10a6:102:1c7::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8096:EE_|PA1PR04MB11334:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b1a2c1f-9164-48c6-9375-08dec1388132
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|921020|6133799003|5023799004|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	maFRnaFmDqRqyldGYxEpq04u8qo0DjBCql/XG3kEGgWe9WTb/eLXf+WFuELYYdrwLxiXVH7IjxeeAVDq2dafK/6KoXo806IqeCgCF2HuiLyXBOVlEIsUKCr6whcfjpTJefeKX/wpevMVRWY4eEIdyHh8YHc4ehQAfms09HZEz9875ffiqnP1NbkvI1+/RO5JcRjp9cGPPRBUd5u7iLLXd3VkPvbkvORBfcanBNV3OSrpV4cjsjpMpz84DfeYJPBJWQFhLw9zsMmnmCkOLQyJKKGTQzekEVn+4ln8cNBuIZ2CHuOou98tw/CutTFVzcB4jHlYs7L8Q5vvGMVCvDdDK6CluaVYW9FNNfeI93UiYMGTSJoZztbljiNxdgVUTrmiEJtyLFKFDw6m3/fobjSsUDNdKhHrp1hZqOcP+7xQ9amxn1xd7Fw4hEes/Uk8/uC6Kz8JUEm6jEB5ra5rLIdOgEUA4jErHO/uTBu9+u2fpvES7CROlQ6HQB4PV47pikBHWBPXIAgn1f7+zW49sy1oDzVvMW1Q6PIO5uew2zujhj+/LhC6AqjyrJHMR3L1DTCeJ7ii1c58I73hFJMjE/dyOnO+YPNdqCyBNtLvXI33FcHUzgmmQaNAROhUeLTM7ivQ3y0QI1gUVUSXvKbUCDPZBauXzZCOZY3BNrquf0AZwHU2TAlsjUzV8DE27gWW7O1mRNV+9Bckl86KuFgVFuF7J8d5z0jjRGm0i77IePg5r7A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8096.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(921020)(6133799003)(5023799004)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dgeVUDbyGs1s2qJi5zm/ikt6V3UhDd3+AmLt8AS0nhyQ3gelzml6LoOg+Yt/?=
 =?us-ascii?Q?us6L909AIt60/KQwZtpjXznvoQUxHcYT010BtfNT5V2JVoQrTGOGuWqnloEV?=
 =?us-ascii?Q?I24ya8yM1LcJt2bIK9KPLqCfm8vcocECEaOVKlYiqc41DB/qF9yCJdyY1mA/?=
 =?us-ascii?Q?GTUHnTTdhVMekRO9dpuqTGFYMd/Xuki2eJEOqgjeE/hW1pmFzxIVcY4U7Ngd?=
 =?us-ascii?Q?FSNCavxfygCPIqZyFvUUPT6KHkc17NXP9iKQK60NBurLa9KEKDZi+YxdkB28?=
 =?us-ascii?Q?YyGs8Ittp/CIRwjajjFY7uMJxJyt9wJLVhcQgaogjRNqqKaSgUK8Nq4S5T1a?=
 =?us-ascii?Q?/LEHd2DYoiXwav8WTKJaKArV07+wjGX6m/vfd8hO18tLyMgTisQcBPXiaUl9?=
 =?us-ascii?Q?XAWU14tYGb2RvumkS2zw1uFYeCDIz1rT/ZVWa5TXHx37dD6A7w9GLPbWroAw?=
 =?us-ascii?Q?4Bf05aY0T0Lz8e6qNYJpz+r8F1AFxS7sHDW/c/zjEFirng3ItcAHYkWwYMwk?=
 =?us-ascii?Q?saN3Whyr9T5L+mvGexHLZLCUSr+yB9xhiFeYcBALU4DpC5hTw5OIQY1zJCOm?=
 =?us-ascii?Q?g+DSzPm2EIUHp2Gyetwes/e5liSkBS1lE4GrvcjIlRBuDsTrU89vZXIZOjrT?=
 =?us-ascii?Q?pFYEIjspZ/6H8iRF4KYLQsFg75aky8H8mbcrtbxzzgqz1fkxHF7r7cGYDfTe?=
 =?us-ascii?Q?dLLM1bLuO1+B/e9Ys73xIFtwY340ZIGk3qvHO0m4V5fWV12iFW5m0EIVsCb0?=
 =?us-ascii?Q?Y9Oa86EH9ApULI/mB4HXliTOvn+Nzv7TP80U92JR3QLjUKOI3+zYa0WLz/VL?=
 =?us-ascii?Q?2+ozx9Pk70oiVvTledzXPvaTfIXrtqTZZkj+HiXc8ePimNuHJgTdA42g8Sg+?=
 =?us-ascii?Q?nomf7V6HeA9F7+rnZkcObRSb+U3Nm++WciMGsWGtabuwfrAdLDgzIbWxWoKr?=
 =?us-ascii?Q?ByjBuUe2xFD/fdW31yBqLzc9g+Bay2EObtvqo3ifI84840ubrxzFY6yKsG9u?=
 =?us-ascii?Q?vVnPjgxCw8jCsQfevDeqO5v3PvXEhgdp2EjNQ2QtRzeFtnUIuXsefNml5vCV?=
 =?us-ascii?Q?+EysCUe4TiYfsbCLS9r+/v3kmX2o1BOdgmSDrRoqteD6IAsTKAeHpMw+rq9h?=
 =?us-ascii?Q?I+IbTl9g3JQdhQ/ggj28QpJH6U01HthgK2mEAlwEUSPgXxcruxWSaq+kt9mj?=
 =?us-ascii?Q?2XF1c9a/PqB7WBp0uuO4eUQlhxn+QVUNOxOmvHiapVdry74k/DyYiH4JHSao?=
 =?us-ascii?Q?xbl/s2PA4KiesRnuXYzM3/mp7JloV1XgqlMzRcma5lxfABKbIZFIj16Hifhv?=
 =?us-ascii?Q?DWSB80AUhww3aEaBOAhRbUeKyUOiwlmkdz/mNh9IQC8b8Wgw8EBxo93CZosq?=
 =?us-ascii?Q?V56untu8/+1sJcB3Pz+ZsQzQV9YWfmcoX8qfrNrkU80xJ1m045H3MEQOl/R+?=
 =?us-ascii?Q?YMTa3Eoi3/ZpjabUcRonFxzdgtBbKDOwlq39m5lHHgMmzJ9ozc8BKeOsoLyb?=
 =?us-ascii?Q?BCn3WBTtuqCcaas72k9UjMhaKEZ5LpyrLbkGkFVbKN+pGQpDBf3Yod4K2Uac?=
 =?us-ascii?Q?QpKya/seZMRIplNjBE38wMRzaE2lS7y4GnZHMoufzfZqCV12cSbalZvc83FD?=
 =?us-ascii?Q?GVAB+f+8uW/G7pD+oq7oL6IjKq5v0n3oieRSlHLzxU+Ji/X9l2+ySzhJFBNP?=
 =?us-ascii?Q?4XECOgHphUl1Jh5gMzP1r17LPOEY5jpVjwdHlBVcltB3EdG0x1cbWeLXFLAD?=
 =?us-ascii?Q?jacpnHBSHTtLz3eL5ZXZ2oqFCsN+Ku2YCO5uIg1ev8istHvuBgQh?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b1a2c1f-9164-48c6-9375-08dec1388132
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8096.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 06:22:36.5558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z88Cvaf1Sucmg2CQiaw6qXVf1YTk9cjJ3gySVSg3RWQLURNXb7gKcNsYtFA+DT6Uxu9jTcJNvPFw5VkD54J8hzT2S/ybEIKciBaan5w33pMajd0kOwNO7JrKRBwpR64+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11334

From: Richard Zhu <hongxing.zhu@nxp.com>

The PCIe link can go down due to various unexpected circumstances. Add
root port reset support to enable link recovery for the i.MX PCIe
controller when the optional "intr" interrupt is present.

When a link down event occurs, reset the root port by: uninitializing the
PCIe controller, re-initializing it, and restarting the link.

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
 drivers/pci/controller/dwc/pci-imx6.c | 123 ++++++++++++++++++++++++++
 1 file changed, 123 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 773ab65b2afa..aa5c90be23df 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -79,6 +79,10 @@
 #define IMX95_SID_MASK				GENMASK(5, 0)
 #define IMX95_MAX_LUT				32
 
+#define IMX95_LINK_INT_CTRL_STS			0x1040
+#define IMX95_LINK_DOWN_INT_STS			BIT(11)
+#define IMX95_LINK_DOWN_INT_EN			BIT(10)
+
 #define IMX95_PCIE_RST_CTRL			0x3010
 #define IMX95_PCIE_COLD_RST			BIT(0)
 
@@ -126,6 +130,8 @@ enum imx_pcie_variants {
 #define IMX_PCIE_MAX_INSTANCES	2
 
 struct imx_pcie;
+static int imx_pcie_reset_root_port(struct pci_host_bridge *bridge,
+				    struct pci_dev *pdev);
 
 struct imx_pcie_drvdata {
 	enum imx_pcie_variants variant;
@@ -158,6 +164,7 @@ struct imx_pcie {
 	bool			supports_clkreq;
 	bool			enable_ext_refclk;
 	struct regmap		*iomuxc_gpr;
+	int			lnk_intr;
 	u16			msi_ctrl;
 	u32			controller_id;
 	struct reset_control	*pciephy_reset;
@@ -1394,6 +1401,13 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 
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
@@ -1661,6 +1675,9 @@ static int imx_pcie_suspend_noirq(struct device *dev)
 	if (!(imx_pcie->drvdata->flags & IMX_PCIE_FLAG_SUPPORTS_SUSPEND))
 		return 0;
 
+	if (imx_pcie->lnk_intr > 0)
+		regmap_clear_bits(imx_pcie->iomuxc_gpr, IMX95_LINK_INT_CTRL_STS,
+				  IMX95_LINK_DOWN_INT_EN);
 	imx_pcie_msi_save_restore(imx_pcie, true);
 	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_LUT))
 		imx_pcie_lut_save(imx_pcie);
@@ -1711,6 +1728,9 @@ static int imx_pcie_resume_noirq(struct device *dev)
 	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_LUT))
 		imx_pcie_lut_restore(imx_pcie);
 	imx_pcie_msi_save_restore(imx_pcie, false);
+	if (imx_pcie->lnk_intr > 0)
+		regmap_set_bits(imx_pcie->iomuxc_gpr, IMX95_LINK_INT_CTRL_STS,
+				IMX95_LINK_DOWN_INT_EN);
 
 	return 0;
 }
@@ -1720,6 +1740,85 @@ static const struct dev_pm_ops imx_pcie_pm_ops = {
 				  imx_pcie_resume_noirq)
 };
 
+static irqreturn_t imx_pcie_lnk_irq_isr(int irq, void *priv)
+{
+	struct imx_pcie *imx_pcie = priv;
+	struct dw_pcie *pci = imx_pcie->pci;
+	struct device *dev = pci->dev;
+	u32 val;
+
+	regmap_read(imx_pcie->iomuxc_gpr, IMX95_LINK_INT_CTRL_STS, &val);
+	if (val & IMX95_LINK_DOWN_INT_STS) {
+		dev_dbg(dev, "PCIe link down detected, initiating recovery\n");
+		/* Clear link down interrupt status by writing 1b'1 to it */
+		regmap_set_bits(imx_pcie->iomuxc_gpr, IMX95_LINK_INT_CTRL_STS,
+				IMX95_LINK_DOWN_INT_STS);
+		regmap_clear_bits(imx_pcie->iomuxc_gpr, IMX95_LINK_INT_CTRL_STS,
+				  IMX95_LINK_DOWN_INT_EN);
+
+		return IRQ_WAKE_THREAD;
+	}
+
+	return IRQ_NONE;
+}
+
+static irqreturn_t imx_pcie_lnk_irq_thread(int irq, void *priv)
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
@@ -1919,9 +2018,33 @@ static int imx_pcie_probe(struct platform_device *pdev)
 			val |= PCI_MSI_FLAGS_ENABLE;
 			dw_pcie_writew_dbi(pci, offset + PCI_MSI_FLAGS, val);
 		}
+
+		/* Get link event irq if it is present */
+		imx_pcie->lnk_intr = platform_get_irq_byname_optional(pdev, "intr");
+		if (imx_pcie->lnk_intr > 0) {
+			ret = devm_request_threaded_irq(dev, imx_pcie->lnk_intr,
+							imx_pcie_lnk_irq_isr,
+							imx_pcie_lnk_irq_thread,
+							IRQF_SHARED,
+							"lnk", imx_pcie);
+			if (ret) {
+				dev_err_probe(dev, ret,
+					      "unable to request LNK IRQ\n");
+				goto err_host_deinit;
+			}
+
+			regmap_set_bits(imx_pcie->iomuxc_gpr,
+					IMX95_LINK_INT_CTRL_STS,
+					IMX95_LINK_DOWN_INT_EN);
+		}
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
2.34.1

