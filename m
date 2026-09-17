Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013003.outbound.protection.outlook.com [40.107.162.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134C83AAF74;
	Thu, 17 Sep 2026 06:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789626569; cv=fail; b=b4VmVy24uDKWcrmDeFm4g8E6TmaTYJBNzt5JU/0O/4WGxGOlxxkl82qZy0QyGi+uJRP40zAoleJ3uc67V0ifhH5w/SEsCCm4FW3u+3zg5de08vZDDl6w5k/rttrJqxOk6PKzRlVi0l60w3OcgcjUOf7n3uaxNKE7Y+x81gC3R5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789626569; c=relaxed/simple;
	bh=S0CXWXlWnL4Ce/P4Y9nAvyNTVDHL5vK3AC83g1p8pr8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=pFYNTdD5yOSIHGPpHcRavDG6gk4H2eZbKkAASjHOXY6bCDBy5FOuAlcilwhBMaBA58uG5BsmQBXcVDfv6rNPX52efKqV25Cdr2zg7cJvA+oAePMFVP3d0qPRGhXSvX2wmdJ8CTd2o1PGHVjVAwp7oxpVKMnZh/PUhikTXwAnpLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Tce/A7E9; arc=fail smtp.client-ip=40.107.162.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Tce/A7E9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tiDXevjasUU8V/PsZOfbxqFqaVWUb6oNmbsmtiMP9kUT+ed0QKjrrBxw0jnUmsxOzr7XqE+zzNW5aZ5AxGGwVZSBvNLli6eLNeWXkFJZT7Dy12JkWRvbNK2eTr27oo4mVcdEcXq+Sm7dvl64JhRQxKi+4kOIOi/BVdo6f7fe9sIsf2Kc4tCCLdRZ0jYi6Czpyfzbe1FyKqxUalFGX1LI/Y8w8qJ1S/qmaAaEAbh/5Qkr0YF4Wit3exM603dkY+smrK5QtIfD0reDcniCrno37F8ny2FpayBiMh5jE3CCZNtcsvpfZkJtLtuu/r87Rh/5gtF1S2a+57Hhe/nVU3DNpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YinLryoCEwP8HDotVqp9b2x/vhszlWFQzj49y6MjEgo=;
 b=DAwrBnN9AVQM9vnfHLubCXvPaSf+SdhwG7U9L//kiU0qsxektZoLnJmA+oRgwEWA3SJoZ3g3YRLppvztmMS4kx2/oqIXOYzZXWPoY0mvJfnNH7MMoh2Bg6IADCo8QU9KSLNW4bSkqlo65Nc+BRyiXXrE5f9/2fvIHoMy+0SSAai2mDnAf3XkIETspo2qvAf6ZlbGtBCBDrW3Bow4KfnawlQcif0f4dHsuYfgZduW2Jz9hSV9b3P/ANUBLBSq8tHNjtS0NA8WRNGcLZUp8dAkzBPaihC0REEkq7zYrngPnWtn160S2vFa684l7OZF2mmBGcUueUaj01XInXww91o1aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YinLryoCEwP8HDotVqp9b2x/vhszlWFQzj49y6MjEgo=;
 b=Tce/A7E9zmEJB9tmKSRWLhWmf6wqlY8m2yEUqIvT30yhP3b5RutwHr1xKoRTXl8IiVOq/1tB+14pfk+fvkcAxCEDqANA+jZ2J9AN74HN1GpcPBeJgUGtnKIb88BUxsdmEZ37f0IMSvYAm6kxBIT24+rbIYZRts5LiM2EuGdkKjNJF2iKrPivGr99QYo4IF01e2dqOpaog9VMnScCo6RcxylCeGp38DzA9249KvFbKUggbmn++GLpNsiXXQBEgnM46uvVfCqFrjS7HATFoKdnWclK4wdNG7+7uvljsT50WCTnXpbbWVS1ZkfjS9BcysTZUwUKM9exOxuv1B+4Lny6Wg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8096.eurprd04.prod.outlook.com (2603:10a6:102:1c7::19)
 by AMBPR04MB12589.eurprd04.prod.outlook.com (2603:10a6:20b:77b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 06:29:24 +0000
Received: from PAXPR04MB8096.eurprd04.prod.outlook.com
 ([fe80::68be:f721:5000:3f2d]) by PAXPR04MB8096.eurprd04.prod.outlook.com
 ([fe80::68be:f721:5000:3f2d%5]) with mapi id 15.21.0428.011; Thu, 17 Sep 2026
 06:29:24 +0000
From: hongxing.zhu@oss.nxp.com
To: frank.li@oss.nxp.com,
	jingoohan1@gmail.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v3] PCI: dwc: Add suspend_poweroff flag for platforms with RC power loss
Date: Thu, 17 Sep 2026 14:33:22 +0800
Message-Id: <20260917063322.4102035-1-hongxing.zhu@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0132.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d2::15) To PAXPR04MB8096.eurprd04.prod.outlook.com
 (2603:10a6:102:1c7::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8096:EE_|AMBPR04MB12589:EE_
X-MS-Office365-Filtering-Correlation-Id: fe5d4d30-499b-4e81-c579-08df148503e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|7416014|1800799024|23010399003|56012099006|5023799004|11063799006|6133799003|10067099003|921020|18002099003;
X-Microsoft-Antispam-Message-Info:
	UpKHHmlhHVBrI8Egszmqto+zX2XixsQ4rX7ASgojN9ZHZkBExF7vafgCgobjakbHodiCxj3hgErnUaalyVwLfIOPNehj5q3dNb9pPmRdvNhpkdHGC/YmvtJ847AW67BIMNWcdJz+on9zpdB3Fdjv8gi92WCBuKv/Ygp/Sxki+YRomyhvOwyUsYV7DqC9MV9WR8Oym+O1N6aRC61YKgKY7WtxSFmJc3zDLy+UO+7yJot2g9ViS/b9Xj1RX0XwXBrPuejU7YPyJBovKSn9yzetYTejkubwYi0wmTBgmFJl1r2I1pvQoxi/KG00rBZUQeLO/egLob0sWV6KhLscF28x3hwQs7O7umKj373OlJUMsW7aHinIKFOs5ep1jMe2MR5u9swIjO7g7gO+9XkU2rZ6Pg4TGxWGaRLZ8hw/Xn5PSqiPw/WLORYx/Ufnogq7+nGq8PwhrsgNxb6hSSlLR7BIcyC0SOEhfOCh7Z1B48oqPG+dS9z9E7WK6po4iFJ/tTYARxbWQbQa+agNl9rHnAQUdfn09swlCHDBodueaEEu+mddMsL3mV4wVF9G+MTkPwWKqH7Iz3lm0MBKYoSc5OgAykriWwTUD7xZLPPSnJnV057NzFAegxM/Fm5jaI5lxmYACEaVPMIZB3rpiWCgZxgL6ND+SwUFcyhpAgv+S/VPSaWJuQSJBkOYZTK5RdrBGwYq31VxoIO222fTWmzGuI4fvQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8096.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(7416014)(1800799024)(23010399003)(56012099006)(5023799004)(11063799006)(6133799003)(10067099003)(921020)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UIl8tpy39D9xRMU/P0h7Y2im/i5NOuohqye3uZpuBjVCMSJvQtSCsoeZeaad?=
 =?us-ascii?Q?5l6mu2qwy1wdX/x6/hCOn4j5LQkuCMf84uX52CXUlrBQtZ7jg05CCX/JtNB7?=
 =?us-ascii?Q?06wB8/iVcM9P5F3fJ2RsVipU70S0GOsRJ5m2c1IYixeTjz3QvoRHR/TRf8uq?=
 =?us-ascii?Q?rz+wZ/7RAzecmurzt+ycgzHEKrhkXW5/iJxY/t8befiwcT/xkkkgJbL/WKhm?=
 =?us-ascii?Q?gvOx/SV+U6GzLg5Di+TFLj6AOgpxZCyc6ZNpzSSa3Jd338mVKeLouYbeFxp1?=
 =?us-ascii?Q?D9zm/W2R9c6JdJwzMKQgpi9CdGY5QROuoaqVcqEiuwmC7T0sOjIRtXMY6xbf?=
 =?us-ascii?Q?cIikX/XybBNimZ0/jlwJMFs4izYqC0+ODeTqwyWOXvW8gjiLexAZx/4R/rVP?=
 =?us-ascii?Q?V3wpA2B2MSMNa52Eq2rgQuSPQubpxqdm6uIMc4FCl/Taaa9voMqCTi80G+ps?=
 =?us-ascii?Q?mIPJQUa4EgSdSfk3Zacb9+jIkZdZD4Y5OS2idqVI1sbNYuWSEvO63txTLQkf?=
 =?us-ascii?Q?uKFnhNJVj8FX0oFPeBMwUpGEJbwAl6aTvmdHPVcfohnPZ+Jqqy9qQXxHWBkQ?=
 =?us-ascii?Q?Wx2ozaODX2TWV0rqicO7QOAHvmxL4nttIr3Dnn3AnnyrG0FJvR8qZL93orS9?=
 =?us-ascii?Q?f6YGyKwVSMGeKQNjiqZpY9TmPHWdAW829tDmctkVkswdSVhiKNk0wnDMZa+V?=
 =?us-ascii?Q?9kpVtIG81R7l1ghdFUuJtZxFThzrhOF0qVpHPLBP0OkbdzS5EDLrVyJPdxqT?=
 =?us-ascii?Q?NRcCrgtMNLGa5ujj2nNcaSHw8P49iinAJeYKcgUekfYHzzriAOnVoCK2vPKh?=
 =?us-ascii?Q?prvQQ2847TFaEOls3KPEdVVdNC7H/1fa0O34dX/MIygsfp2MhBEhHgtO0eqJ?=
 =?us-ascii?Q?7v4svKP8eAAAMSkAUTp1KY+Qkin5e3+lr0bhke33NhBZ1LDR5YdHFMFIXcgZ?=
 =?us-ascii?Q?dSNu3RE05Z58AnH2QWWE1TPKaJO8F3QVHz4nrSEjxF7Djs7h4xtF4Vd7VmXE?=
 =?us-ascii?Q?2lNkZt9+mJ/6IodtQMdNz9rA7MXxQOzh0M8FarZypqMiooNxguPJBoFHdSvn?=
 =?us-ascii?Q?mKsT3jzkKXp8KXmCiKL0qpCSpKK9kR9VJ7RC2prrQ1VEkaM4JkYe8irq7o5E?=
 =?us-ascii?Q?36wYQVLjrnw2eeoqV6BSKuUv1/g+4A2ixfnuo2jEUQfSzCrwbCF12olKwHOr?=
 =?us-ascii?Q?tOP9YFL8EEXS2CnwrU7j8ZA/9oVknvukbeg7yXFBNaLST1a7yJs/Kg6ou7MS?=
 =?us-ascii?Q?HwegYIEGRP+DSX4fo6RGzYu5rW1YMZDfvJ4K5xO8qS+1TQ69qcVADbf6+e3r?=
 =?us-ascii?Q?YOL+nzbPXKQM2jw2tymL/Vsr070y26FuDm7ymGegzUiFbudaiKodh7JSZKZf?=
 =?us-ascii?Q?dItjZ/zKIzmOmhesgtwPNeLLoKkKo3fzgT8TQn8KpvxhI1Tk7j9WK1+WP5Oe?=
 =?us-ascii?Q?qqac+ZIYJztpeIArOMejNUmiI2WLZgmXZSoDZfNqNgS/dtO8Zdhl2Pe4o5Bu?=
 =?us-ascii?Q?PgQtkLBF04PieKj2yTKl1uwGSfMzma71urQmDPN3nUcXQiww3u216f6gcmZ0?=
 =?us-ascii?Q?a8meh/9K5U2onXsTylbMhW7x5fsjs9mg6+OaembBCiIcrWOZwnTqBP60h8T2?=
 =?us-ascii?Q?7pCtStl+CamxphnSn9OdDyrTqJyTSKZO/elQglDERKDhmS3o4x1eONpLVHX+?=
 =?us-ascii?Q?2tl1J9Fk5rvN44mf36sYhZZoE4DIHhspLkH8TNrBn0+qBBB+N0rW9ltXiMP+?=
 =?us-ascii?Q?y4aBzfbSItZvmTrAFfNlAmANQhsDwhThpUuKaYFktZc6duVmBsFl?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe5d4d30-499b-4e81-c579-08df148503e8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8096.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 06:29:24.1653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uqoNfghES6i6YX9imkQCJwZsyA9MVWwFy+CM+FXQP+ux5EztkMLRHVgRL4ru8/s7ph4Djf5dQ0Q1MRaKd9kIhAH9jKRfZ5gNPR5d1N04WhF7BJzRWpqSMqJ5P+At3Gva
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB12589

From: Richard Zhu <hongxing.zhu@nxp.com>

Some platforms like i.MX power off their PCIe RC controllers during
system suspend, requiring full re-initialization on resume. These
platforms need to enter L2 state to properly notify endpoints before
power loss.

According to PCIe base spec r7.0, sec 5.2, the system software should
transition the device into D3Hot before broadcasting the PME_Turn_Off
message to initiate L2 entry. In practice, endpoint drivers properly
put their devices into D3hot during the suspend flow. However, some
wakeup-capable endpoint devices that don't support PME from D3cold
fail the D3cold capability check in pci_host_common_d3cold_possible(),
which currently prevents L2 entry even though the devices are already
in the required D3hot state.

For platforms where the RC loses power during suspend, L2 entry is
essential regardless of D3cold support, as the link will be lost anyway
when the RC powers off. Without L2 entry, endpoints are not properly
notified before power loss, which can cause issues during resume and
reinitialization.

Add a suspend_poweroff flag to allow L2 entry for devices that are in
D3hot but fail the D3cold capability check, and enable it for i.MX PCIe
controllers that lose power during suspend.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
Changes in v3:
- Refine commit message and comments to clarify that devices are in D3hot
  but fail D3cold capability check, blocking L2 entry
- Remove misleading spec violation statements

Changes in v2:
- Rename the new added flag.
- Update commit description and comments.
---
 drivers/pci/controller/dwc/pci-imx6.c             |  8 ++++++++
 drivers/pci/controller/dwc/pcie-designware-host.c | 10 ++++++++--
 drivers/pci/controller/dwc/pcie-designware.h      |  8 ++++++++
 3 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 3f55c91d0921a..c9e630b2c4fdd 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -2016,6 +2016,14 @@ static int imx_pcie_probe(struct platform_device *pdev)
 				goto err_pwrctrl_destroy;
 		}
 
+		/*
+		 * i.MX RC is powered off during suspend, requiring L2 entry
+		 * to notify endpoints before power loss. Some endpoints fail
+		 * the D3cold capability check, which would normally prevent
+		 * L2 entry. Force L2 entry anyway since the link will be lost
+		 * when RC powers off.
+		 */
+		pci->pp.suspend_poweroff = true;
 		if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_SKIP_L23_READY))
 			pci->pp.skip_l23_ready = true;
 		if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_KEEP_MSI_CAP))
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index f5a38e6fd8d79..133050c12628a 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -1224,14 +1224,20 @@ static int dw_pcie_pme_turn_off(struct dw_pcie *pci)
 
 int dw_pcie_suspend_noirq(struct dw_pcie *pci)
 {
-	bool pme_capable = false;
+	bool d3cold, pme_capable = false;
 	int ret = 0;
 	u32 val;
 
 	if (!dw_pcie_link_up(pci))
 		goto stop_link;
 
-	if (!pci_host_common_d3cold_possible(pci->pp.bridge, &pme_capable))
+	d3cold = pci_host_common_d3cold_possible(pci->pp.bridge, &pme_capable);
+	/*
+	 * Enter L2 if D3cold is possible, or if the platform loses RC power
+	 * during suspend (in which case L2 entry is required to notify
+	 * endpoints before power loss, regardless of D3cold support).
+	 */
+	if (!d3cold && !pci->pp.suspend_poweroff)
 		return 0;
 
 	if (pci->pp.ops->pme_turn_off) {
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 0735ae9409240..e66b3f259fc82 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -471,6 +471,14 @@ struct dw_pcie_rp {
 	bool			native_ecam;
 	bool                    skip_l23_ready;
 	bool			skip_pwrctrl_off;
+	/*
+	 * suspend_poweroff: Allow L2 entry during suspend even when D3cold
+	 * capability check fails. Used on platforms where RC loses power
+	 * during suspend. Some wakeup-capable endpoints in D3hot fail the
+	 * D3cold capability check, but L2 entry is still required to
+	 * properly notify endpoints before RC power loss.
+	 */
+	bool                    suspend_poweroff;
 };
 
 struct dw_pcie_ep_ops {

base-commit: 1fefdcbe1697cf25a7f7b307078742d9757fff46
-- 
2.34.1

