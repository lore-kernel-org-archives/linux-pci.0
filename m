Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021116.outbound.protection.outlook.com [40.107.74.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132A34F3928;
	Mon, 28 Sep 2026 16:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790614395; cv=fail; b=msmXVqc4IGv59+EnvLqtlBkIEm5zSSXpmYmaUzzAxOPJK2JuJvilRzPh6pHowsZJ2YQvEU5HlyPDVl+ZGcuW1Tb2TxrzoABvZ1ANbvCpNlwi2VAPzCLoc8sqQkpEp7C6DHXo5ywtcv3pSmuQN/T17+AXD1W6u6BStFZja8h1FYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790614395; c=relaxed/simple;
	bh=75iyDdLRGkL6N0XuXWXyr8EnW0LsInGwA+MzYqq//mA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BF3rtebpxhUaIswFAh7rYVPR75V/vaEU8SbJDMVkL9Zsd9QYIuTCbwNkUKq65bPT8NFT4sVzelireWJtFj2mN0mGOv7vN9ByCp1lkQKOxlLJwpVpeJQE9Cgt2wywGChOMC1jYBtrCMskXMCK1prJby7RZcL/LesYD5qAM+MZxEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=I/1JImjW; arc=fail smtp.client-ip=40.107.74.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="I/1JImjW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qSAyN1Gc5crZA3V/Jt4nfJiSNbxbu1zTG+8zE9EYx0BAUip9PFYH4RyDLljEyuR9p0jjJOv80o0f2kzLhwFahWY7LE+Dh8kjLSK9s2U8ZkpZPRilOemDctIOILQTPKortaXzPWE8LhYXEE86/1hU3BUh5Tx9mkgafiLtXMKe1Yd9vS5FbMvLz5B70gfGFZfP9IJbmfMK6VpO3TyAq4rhUGCQAYZpmZ0WXkjktNfjzAPDT3DDrBqgpuibUMwbby0wRXRf0/S+0h/2puUTyHBg3LSJs7hL9JZ5wK1I30D0SW8p6Rdmv8CefQ2c0NDeGIXf8AeLC0DxkbN8z/SwNj4dfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lRfletaBhEP8LU7p78JyBLqv86e7UN2gqk7NtheSBkk=;
 b=eVbj/46onL4ZHn+SfswsrIVlpBF0HYX7f51dnWOJhdfssZDn/CVvKgRfRSlvX9qvqK7ZO5Nfijsfpm9w6/4CCW5fafSWKwaa+l8Y2k6NGNrA8CE9j8qEf0F8Q6MEb5pLLA6nREePvW+Lyt0iHWpbNr+kgUR5l9QFbVqEERHXTTceOGbMAWBDN+p8q0w/6Z1Te7c7/HfXKN0cWFbHcn+z1y4KTycvmAGTwe8Wl2TJ7icelOHj9unsgVf1Iw3aCeNYP8sULp7djF4wc2ItPZ8yBNLJjLdmutEDgeaMJ7Ks2lOjNSZJfzN9IK1I43l6iU7gLNJZqFchSoC7b+yJaOL6kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lRfletaBhEP8LU7p78JyBLqv86e7UN2gqk7NtheSBkk=;
 b=I/1JImjWuvwgVVmJ0hYPWkfHxrwmFUZGhjK9iwyxgqdZsN6A4jJl7ZcrlK03a/cdFPMkqrpR4HuiUIFoE3+bHU3o1Xiz7H6IZGdhmPH/cnb9Pe8czcnWqGoMfWeCkc4+YxzBZhfFiWHe4hmGs0n3dwn6vgNycetj5B/ERZue0dU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYCP286MB3638.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3c0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 16:53:06 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 16:53:06 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Jingoo Han <jingoohan1@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
	Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/15] PCI: rcar-gen4: Separate hardware setup from resource acquisition
Date: Tue, 29 Sep 2026 01:52:22 +0900
Message-ID: <20260928165230.3397664-8-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260928165230.3397664-1-den@valinux.co.jp>
References: <20260928165230.3397664-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0041.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::7) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYCP286MB3638:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bd6905f-25f8-481f-6fef-08df1d80f7bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|10070799003|56012099006|6133799003|10067099003|921020|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	3imp3eUt0Zo7ufI698KD9+jOUCnkl77qjMiKdiTilfupK9EFiLPc+LM9is6H6N6bEVPRsc0eJIrbZ3u8E4a0e//yK6feIPYYUw0ypxvp5eks2tP1n351OMakaaCwAcO8W2yW8dSqq6kKrS0+ivRvRBVdbN/6UopBjtfr4Aq4DoPynAqpeIOtlhY5mJsObbFH6DwiNVDy+/HiZzeML+aHDvOfEr+CJsr+bB7GAjD8tLrLbmBJMlxE199M2BjZb79Hhp6ocABewJNOhPFQXLzi6K6WGWCq3zbcVKSq6IG1vtkplA/uC2AklDe8jWDOYlHSnLuw9xHXH4zovw9V/VH1jamchm4B0PCI45BjprWWaLlkXDyosoP/jdJw52TCHPhQrof1D1XkCf7Xde/cpQbpPqyjMLoF135v76lsWEDVCHIeJWfpBVZoi2Vb016cfkL3wFtu9croBr07tzpXCYur1c+C0qgcGQTYEttC+TQVr7h+pJvlZtLfp6vgYhUBfMV7X624DfmUytGM4ySgdAZEpkk0iYoUY8vr+ehjtGMKkPQcKmLj9tstgM1ZCpJzE71wMYSS/Fwl47abiGgYPu6c5rqrhcqKGiWvopIaNQR/6AoqnrVDKLXvjU56bQob5SvLY4fPaTQiAVJKcYF3w2dYvwiek0CO3nqnIibIVFMgaU7F6uaEoQF+4Tcc9qo9WmmOz4996+bZ0Shprx9CgArPsA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(10070799003)(56012099006)(6133799003)(10067099003)(921020)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LBh2VgSUKdMwvqIzKdGDTVw7iiGVn2VQz5246NxD0qoh1wRvizUCa/kxRcVI?=
 =?us-ascii?Q?oVR/wV/bfA7wVjikX14vECkSwkqHMN6NW6bBC5unyrVLpwM34oW0Ulz4Gneq?=
 =?us-ascii?Q?ZqxlWWswSDjy/wPz8J4ixBwj/DcbHN9TM7LX7+ynWXjX3v3YFnDlmurGR6j/?=
 =?us-ascii?Q?vBp9HGQ6VDuQC4+95JZCm5QGABZ/h/+PtOaolOY7SPgvp5U1I1juCh8wVRx2?=
 =?us-ascii?Q?yERPhM5X5P+uxGxsaiXegaBQHSzmtU9IHfGTvYYdkAkQAMu/bcAaWygPGJcV?=
 =?us-ascii?Q?UMK+cabexJ+TglnIbCkClTp1zEC4qotszL2bR+YOxHPKltDXXXi7M0O50kMg?=
 =?us-ascii?Q?gX5rhMFqSD4boPdJFncgBk8rf6XmewdyPfFrnIfHMOCM1A4MCwjcNk9k96rj?=
 =?us-ascii?Q?N6jnbg3l/lMf7odsjj0t5RINVG5S8kMudXzUpMoHEUlePdyC7/yeZ3dMsHGV?=
 =?us-ascii?Q?rV7J9NqL+1ao/G7Bsx/RZ4QZgYF8UdmTAOgkwQztw9oKQT2zIr5O6NmjpwpF?=
 =?us-ascii?Q?0j1rbJ2fZorMk0qHGf/dSNfYe9JAqw8fO5Yj9npi54+ZEoLvreUJE883iuvC?=
 =?us-ascii?Q?5VKBIu1YNNrN7wkOS9rw4K5u+KmQB8LzboMcTSzZaVw4G1b1W/x2dYNfP5zL?=
 =?us-ascii?Q?kl4tjZ4MFVcl2TQOSCWHzplShAgzNHav5X8tRSfMIJX1dZt/nrR/RxlolAfZ?=
 =?us-ascii?Q?9JQpgt7c8/yIOdf0sTPmZcIxG4QLvu7ro5tje/JN7+5683PlpiDDLBLRn2ae?=
 =?us-ascii?Q?P6/CxybNprcX7MCgSaG2aOwt7PrJ1dK3HNC6C+XMbURul0P2U+o2YZy7KJYP?=
 =?us-ascii?Q?fOIY6KpaOenXRVq9w0eAOh2+dcg58Q1/c+a8vpfL7/giSuQXLe8IgeZvq3qM?=
 =?us-ascii?Q?BHOQceVPsrruV8AKgk9IaIQ0L/Ab2OLSa0GyuUP4lB229ajmqGJi6bhVtrx7?=
 =?us-ascii?Q?L3z6z3rDyyKW3CWSAC99+3umyP3mPj2gK7L31DYDogY7etzKIhUMXNAFMi1t?=
 =?us-ascii?Q?NflHsZxQOxheMUUQdCEEB234DCxC9CyjYdyw9EP/nK5g42zu4Dz0d29dVJKO?=
 =?us-ascii?Q?duakJ+RZattdn4vHmP7xG9pfpTiyrlwhI0pTI0wdHo/rbbkuFXZg6l468rB7?=
 =?us-ascii?Q?8RrO8b1/Gm3Tq+kwCNyjBjKUZPlj8W38x8apUFTm7+1QWIuwnjrSVLknX7Cj?=
 =?us-ascii?Q?Vlsnq/ihK1KKce7KKtHyab8i47lUPrZDTeXT8CMrGBXC1oK7XzD7lZEXEn5u?=
 =?us-ascii?Q?LbuTDKsxrkdp9PtaeKqjdTAGweLGN+DlF7yWJro3DWZSjwJijhtcRQK07dWs?=
 =?us-ascii?Q?zLF6Chj5GeWO51vahyOiGAHZAdMzWI2JUIT2yf1yVkejFeD1WHC1FpAt506s?=
 =?us-ascii?Q?ZrT783FWvUjza95PApe/tYE5yTw83tI9caEiIvZ5Y9qljIkF8yGFHBHU4dah?=
 =?us-ascii?Q?qs5FIMhO/lcfkHCHLnobUbxrZoRonJYnJZt+yqVor71w7t8B0UtfvzWywUsJ?=
 =?us-ascii?Q?raFv1PhONINl+y0+hfvkUtnIsnhl/eRS2YDyrotnrp+Q9+23B8TSCCXd9xPr?=
 =?us-ascii?Q?d8wZdu1j10CmfSbEQ3n/eaAVNjJBo7VkhHdlX3AVTnPCJWXH4wAWxewKpp5a?=
 =?us-ascii?Q?Mq7W7btoi7XcdEihxhd3K0EIr9IIGd/Eg0bqsGStg1QAGsYXy2w5udITyQ8L?=
 =?us-ascii?Q?v34wUKSpUMbEGFoF8O09jw0ywQUyQ+Rj7ayTk2mQ+GUKNMEgU1GbMBhtZmOh?=
 =?us-ascii?Q?nMGBfiLgbrBU32pSp2MW+d3kJOoRgEXm9GPVTNvsGQQVH/ushuFY?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bd6905f-25f8-481f-6fef-08df1d80f7bb
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 16:53:06.0040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PzIZybGj8XBny5Ef+DUdaXUkKAEzQyfIglzirAkWZDIe2UBso/DKyzdictFcrUYkNGs3OxWIbxPCnrt6nlRT7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB3638

Factor out the hardware setup needed by Root Port recovery into helpers.
Recovery needs to reset and restore the controller while keeping its
clocks enabled and the Gen5 PHY initialized.

- From rcar_gen4_pcie_common_init(), extract the power reset and mode
  setup. Leave clock enabling and Application/Local reset control in
  common_init(), so recovery can keep the APP registers accessible.

- From the V4H/V4M and Gen5 .init() callbacks, extract the SoC-specific
  register setup. This allows recovery to restore those settings without
  taking another clock or PHY initialization reference.

- From rcar_gen4_pcie_host_init(), extract the Root Port register setup
  and PERST# release. Both paths need this host-specific sequence after
  the per-SoC initialization or reset.

No functional changes.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v2:
  - Separate hardware setup extraction from the .reinit() addition.
  - Keep the reset_control_status() check, so the power reset assertion
    and the 1 ms wait after it remain conditional. (Marek)

 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 125 ++++++++++++--------
 1 file changed, 77 insertions(+), 48 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index 75e74fe3889d..e73ef6ccb145 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -236,20 +236,13 @@ static void rcar_gen4_pcie_stop_link(struct dw_pcie *dw)
 		rcar->drvdata->ltssm_control(rcar, false);
 }
 
-static int rcar_gen4_pcie_common_init(struct rcar_gen4_pcie *rcar)
+/* Clocks must be enabled and the Application/Local reset deasserted. */
+static int rcar_gen4_pcie_reset(struct rcar_gen4_pcie *rcar)
 {
 	struct dw_pcie *dw = &rcar->dw;
 	u32 val;
 	int ret;
 
-	ret = clk_bulk_prepare_enable(DW_PCIE_NUM_CORE_CLKS, dw->core_clks);
-	if (ret) {
-		dev_err(dw->dev, "Enabling core clocks failed\n");
-		return ret;
-	}
-
-	reset_control_deassert(dw->core_rsts[DW_PCIE_CORE_RST].rstc);
-
 	if (!reset_control_status(dw->core_rsts[DW_PCIE_PWR_RST].rstc)) {
 		reset_control_assert(dw->core_rsts[DW_PCIE_PWR_RST].rstc);
 		/*
@@ -268,8 +261,7 @@ static int rcar_gen4_pcie_common_init(struct rcar_gen4_pcie *rcar)
 	} else if (rcar->drvdata->mode == DW_PCIE_EP_TYPE) {
 		val |= DEVICE_TYPE_EP;
 	} else {
-		ret = -EINVAL;
-		goto err_unprepare;
+		return -EINVAL;
 	}
 
 	if (dw->num_lanes < 4)
@@ -279,7 +271,7 @@ static int rcar_gen4_pcie_common_init(struct rcar_gen4_pcie *rcar)
 
 	ret = reset_control_deassert(dw->core_rsts[DW_PCIE_PWR_RST].rstc);
 	if (ret)
-		goto err_unprepare;
+		return ret;
 
 	/*
 	 * Assure the reset is latched and the core is ready for DBI access.
@@ -295,6 +287,26 @@ static int rcar_gen4_pcie_common_init(struct rcar_gen4_pcie *rcar)
 	fsleep(1000);
 
 	return 0;
+}
+
+static int rcar_gen4_pcie_common_init(struct rcar_gen4_pcie *rcar)
+{
+	struct dw_pcie *dw = &rcar->dw;
+	int ret;
+
+	ret = clk_bulk_prepare_enable(DW_PCIE_NUM_CORE_CLKS, dw->core_clks);
+	if (ret) {
+		dev_err(dw->dev, "Enabling core clocks failed\n");
+		return ret;
+	}
+
+	reset_control_deassert(dw->core_rsts[DW_PCIE_CORE_RST].rstc);
+
+	ret = rcar_gen4_pcie_reset(rcar);
+	if (ret)
+		goto err_unprepare;
+
+	return 0;
 
 err_unprepare:
 	reset_control_assert(dw->core_rsts[DW_PCIE_CORE_RST].rstc);
@@ -312,16 +324,10 @@ static void rcar_gen4_pcie_common_deinit(struct rcar_gen4_pcie *rcar)
 	clk_bulk_disable_unprepare(DW_PCIE_NUM_CORE_CLKS, dw->core_clks);
 }
 
-static int rcar_gen4_v4h_v4m_pcie_init(struct rcar_gen4_pcie *rcar)
+static void rcar_gen4_v4h_v4m_pcie_configure(struct rcar_gen4_pcie *rcar)
 {
 	struct dw_pcie *dw = &rcar->dw;
 	u32 val;
-	int ret;
-
-	/* R-Car Gen4 common initialization. */
-	ret = rcar_gen4_pcie_common_init(rcar);
-	if (ret)
-		return ret;
 
 	/* R-Car V4H and V4M specific additional initialization. */
 	val = dw_pcie_readl_dbi(dw, PCIE_PORT_LANE_SKEW);
@@ -333,6 +339,17 @@ static int rcar_gen4_v4h_v4m_pcie_init(struct rcar_gen4_pcie *rcar)
 	val = readl(rcar->base + PCIEPWRMNGCTRL);
 	val |= APP_CLK_REQ_N | APP_CLK_PM_EN;
 	writel(val, rcar->base + PCIEPWRMNGCTRL);
+}
+
+static int rcar_gen4_v4h_v4m_pcie_init(struct rcar_gen4_pcie *rcar)
+{
+	int ret;
+
+	ret = rcar_gen4_pcie_common_init(rcar);
+	if (ret)
+		return ret;
+
+	rcar_gen4_v4h_v4m_pcie_configure(rcar);
 
 	return 0;
 }
@@ -343,22 +360,11 @@ static void rcar_gen5_pcie_deinit(struct rcar_gen4_pcie *rcar)
 	rcar_gen4_pcie_common_deinit(rcar);
 }
 
-static int rcar_gen5_pcie_init(struct rcar_gen4_pcie *rcar)
+static void rcar_gen5_pcie_configure(struct rcar_gen4_pcie *rcar)
 {
 	struct dw_pcie *dw = &rcar->dw;
-	int ret;
 	u32 val;
 
-	/* R-Car Gen4 and Gen5 common initialization. */
-	ret = rcar_gen4_pcie_common_init(rcar);
-	if (ret)
-		return ret;
-
-	/* R-Car Gen5 specific additional initialization. */
-	ret = phy_init(rcar->phy);
-	if (ret)
-		goto err_unprepare;
-
 	dw_pcie_dbi_ro_wr_en(dw);
 
 	val = dw_pcie_readl_dbi(dw, PCIE_PORT_LANE_SKEW);
@@ -377,13 +383,25 @@ static int rcar_gen5_pcie_init(struct rcar_gen4_pcie *rcar)
 	val |= APP_CLK_REQ_N | APP_CLK_PM_EN |
 	       APP_READY_ENTR_L23 | APP_REQ_ENTR_L1;
 	writel(val, rcar->base + PCIEPWRMNGCTRL);
+}
 
-	return 0;
+static int rcar_gen5_pcie_init(struct rcar_gen4_pcie *rcar)
+{
+	int ret;
 
-err_unprepare:
-	rcar_gen4_pcie_common_deinit(rcar);
+	ret = rcar_gen4_pcie_common_init(rcar);
+	if (ret)
+		return ret;
 
-	return ret;
+	ret = phy_init(rcar->phy);
+	if (ret) {
+		rcar_gen4_pcie_common_deinit(rcar);
+		return ret;
+	}
+
+	rcar_gen5_pcie_configure(rcar);
+
+	return 0;
 }
 
 static int rcar_gen4_pcie_prepare(struct rcar_gen4_pcie *rcar)
@@ -621,21 +639,11 @@ static void rcar_gen4_pcie_host_perst_assert(struct dw_pcie_rp *pp, bool assert)
 }
 
 /* Host mode */
-static int rcar_gen4_pcie_host_init(struct dw_pcie_rp *pp)
+static int rcar_gen4_pcie_host_setup(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *dw = to_dw_pcie_from_pp(pp);
-	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
 	int ret;
 
-	if (pp->bridge)
-		pp->bridge->enable_device = rcar_gen4_pcie_enable_device;
-
-	rcar_gen4_pcie_host_perst_assert(pp, true);
-
-	ret = rcar->drvdata->init(rcar);
-	if (ret)
-		return ret;
-
 	/*
 	 * According to the section 3.5.7.2 "RC Mode" in DWC PCIe Dual Mode
 	 * Rev.5.20a and 3.5.6.1 "RC mode" in DWC PCIe RC databook v5.20a, we
@@ -647,13 +655,34 @@ static int rcar_gen4_pcie_host_init(struct dw_pcie_rp *pp)
 
 	ret = rcar_gen4_pcie_host_msi_init(pp);
 	if (ret)
-		goto err;
+		return ret;
 
 	msleep(PCIE_T_PVPERL_MS);	/* pe_rst requires 100msec delay */
-
 	rcar_gen4_pcie_host_perst_assert(pp, false);
 
 	return 0;
+}
+
+static int rcar_gen4_pcie_host_init(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *dw = to_dw_pcie_from_pp(pp);
+	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
+	int ret;
+
+	if (pp->bridge)
+		pp->bridge->enable_device = rcar_gen4_pcie_enable_device;
+
+	rcar_gen4_pcie_host_perst_assert(pp, true);
+
+	ret = rcar->drvdata->init(rcar);
+	if (ret)
+		return ret;
+
+	ret = rcar_gen4_pcie_host_setup(pp);
+	if (ret)
+		goto err;
+
+	return 0;
 
 err:
 	rcar->drvdata->deinit(rcar);
-- 
2.51.0

