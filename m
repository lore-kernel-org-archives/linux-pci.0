Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011017.outbound.protection.outlook.com [52.101.52.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91A4311958;
	Mon, 26 Jan 2026 07:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769413598; cv=fail; b=lCx91FfCbWinGXBJolZkGt8QoinEkb4rO5+7GoabveDhiKT7zpyCNocwe4P3fG7V+xGcLJTXIlqKimebjgtVPYgYTZ51yP3yDN+vRI6ruliC8f0D4R7mgsZZREOvEXzk4M6Wu5vYN+Shw1dJ/nY4T928V8D68v00TGy2g0nhEnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769413598; c=relaxed/simple;
	bh=T+hG8IVAbA/UETGctS3fcxwXo/jnxntYqe9A3MB4iP4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kaw8pn/YWvpx8r3EW/I0qnTD0Sm4wzCqLanh0lg4B2RNEYqtnL1V9VfKbuHvKWXc7cyIHa1+gxoZ1Dso0UD2EjUbG6n6+KUvCwCOOunas4uNjK7dpDLnu75IwNW3GrQIxlRwgOy2WkplPm9XAGT4VSRDXqOkRjN2bga+692kFhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dHTQOnhe; arc=fail smtp.client-ip=52.101.52.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dHTQOnhe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JglP4dO5bUQ/Y/g6racGrS24puQuITN0diUmguy0C/gN+GlPQW8BpZjhVMFwxeQOG/J+u4yOG0Bf0xSBGi3NEsHSmdMF3qLBjtkdba1B7wi7Y8rfOB/cgtT9TlyAnRD+Cjkqwv4ZvrAPETSSUkMfQojFh9+IjN8nTHAF8r+jYKltBpF/aFfEVirr/ZjSFcd0L1AL9EhnLcZ6A5cDtOjRDvtjygQvK8qfY1ZXIPdK38f5zOjKB/hpmrlWIWGjKGyQXNkeNY/Sdl1vh1A4GxFzwdbkfc/Z+daUSEEBojz80NRIRlZ26Ctbw+Pc6myn4WWw0jIotJKee7KxkXSBGHVfmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2mutTCuQDn6V2zysc9nfWwG0ysZSyvCnyDQ3Nn9kkQw=;
 b=PC/Be6G4cDDno7Jj7+qllrQtsYCqxKuS0eIwHxsNUFWKqFB+cNmeZvA/J99p6zQgWxfD/ktAYBOxOwaFEDy079wvo5rkmaiBjjrY/AmgTYFfDG+ltTI7XAbHC9cUe2HJs0WHLDkKG6xe+u5hLEl7rYUWrS25dw4SFAFUiQb+tMfg7Rd9hICzIdYQfCZwPV6qZ4VXLC8A5FfmtJ78f9e0ZsdPjINn1hU4epSEsX5nmjIGdr6BgkhnmToj7j+DhOSzShDZ8V8yJlEbb51WYYK23kTEIy8JWHqTdEITq+YACjNZsVF2E5qJPzWTxKZA5OtnbYgH3EOvms9mPhlIH/axHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2mutTCuQDn6V2zysc9nfWwG0ysZSyvCnyDQ3Nn9kkQw=;
 b=dHTQOnheAA70VFwOOWaGtX0c6X5AqandFDAyirZiKL7S+NOS1zCY2XyHfGDAAuus6xQyajWZSw0qMU96M9kgOyFocnQd7nBlFq5kB9YCxc9Crza/nrWW9zLOd0rmO09tx11nkZvq+oeEOBUVaQ+yYJrqyaqQu29QZiPBTmgEs+GSDtfUojpowi06CtgIc7gqyjdGctU4Vr1phWB01mkoekZkWZeD+adILozqYCpASpgi9wwyFoXNQ6Ekmd6iTQ5pxAxQZTZA0CZRQqLI19dVLP/Xzfvh6N56jU7zM3l25Bjv0vvnMq7K/PL2dx8mQRR9yMPxrDLIWuSRlISriWNBBQ==
Received: from BYAPR04CA0023.namprd04.prod.outlook.com (2603:10b6:a03:40::36)
 by MW4PR12MB7214.namprd12.prod.outlook.com (2603:10b6:303:229::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 07:46:32 +0000
Received: from SJ1PEPF000023D2.namprd02.prod.outlook.com
 (2603:10b6:a03:40:cafe::50) by BYAPR04CA0023.outlook.office365.com
 (2603:10b6:a03:40::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.15 via Frontend Transport; Mon,
 26 Jan 2026 07:46:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023D2.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 07:46:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 25 Jan
 2026 23:46:19 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 25 Jan 2026 23:46:14 -0800
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<jingoohan1@gmail.com>, <vidyas@nvidia.com>, <cassel@kernel.org>,
	<18255117159@163.com>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Manikanta
 Maddireddy" <mmaddireddy@nvidia.com>
Subject: [PATCH V4 05/22] PCI: tegra194: Refactor LTSSM state polling on surprise down
Date: Mon, 26 Jan 2026 13:15:02 +0530
Message-ID: <20260126074519.3426742-6-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260126074519.3426742-1-mmaddireddy@nvidia.com>
References: <20260126074519.3426742-1-mmaddireddy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D2:EE_|MW4PR12MB7214:EE_
X-MS-Office365-Filtering-Correlation-Id: 93965e54-fb7d-4113-9808-08de5caf05e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Kl2+ThZBSOrrJsbrT6mtlNHpPlF0XXBcwSqtqKtg5HUVZPiQ/Gl0oCbK3t9a?=
 =?us-ascii?Q?fkC6TTafUXCOS++lziFTCC7/VbSG8AlY8R51Hvfrcgd3mzT41Y1bs3e112UH?=
 =?us-ascii?Q?8NsNnSyZ2+MqhQUBc6KRWCZz+n+6/FH6p4SoEoCT7XTcWjdGDfDAIJNnx7ma?=
 =?us-ascii?Q?QwliU6sf3OwKWDFAepSIf3+FPjN8Z+Nhhzwi6OAQNLulJroh2D+NZmI7SZwR?=
 =?us-ascii?Q?WbGDvi+Er5GeN0FvRjHlGMoo+p67kuSIfG8Zh0SeG58o60z1gBD/abO5poNz?=
 =?us-ascii?Q?1yggCPPs7AkVuRks0V1cAr7uQFmRkK7c2r9wH3m0afsqVEPY+1bYxrgIEQVX?=
 =?us-ascii?Q?ii2XwLagiaodlDKmwgZoGnruCriMJkUhU4kx4TC7dKWPDaZWK5oKb5KS5Sq1?=
 =?us-ascii?Q?tg3dfjO71GP/Lp9S0jnX1CqBAklFcKYQ9pkHhz01T3Bfq1PH2aaE+wD8Bn/E?=
 =?us-ascii?Q?dZhov3ftj3luHbZ5NAmgkrR7tro8BKCS0yipMsTrhi0UE5uznb6ERIApcq4Q?=
 =?us-ascii?Q?KCJNvQFO0i1+2Xq95u/ZQSz7JFv7qxT0Kt26CF53AFehPTRwqvXMGNae82OH?=
 =?us-ascii?Q?d1GIrqYl67xn41Egxf7sZYnNJcu383D/y5mKOSRbLl59PmvdHgL6XNhzvlN4?=
 =?us-ascii?Q?RxXVn2gC9QKhHhbl11y7DN9ZWM4Pu2srAdDYc1XlnFy+aK87LmwcrgQqaLqk?=
 =?us-ascii?Q?IFlgM+a7+d4tlQhflRiSxF9dT7E89G14cmAqVbMoJ/NXEmgZV8k3vkmNV5g0?=
 =?us-ascii?Q?0jhUX3CYF0cV1FbUgYOCg5efCPo3GwIfPx2zt+LOMfrBRGCcJ+xlr6x+MPtj?=
 =?us-ascii?Q?KJMPsbxBP1AEsgoqjBNVap9pGdmVhwfdRBnR1kzGqaQwUiEpWMHTHCPMVEbT?=
 =?us-ascii?Q?zU7MNp2uQ9TzW0PKcn9a/UF/jzsPb7d+6whrFzlIspkGBM5I9/jb9dbqUFp9?=
 =?us-ascii?Q?V6Wg7YYtK2Lr98GrLSdil9290tZfNBJPPhaAhiclLyRkzF0BzShE33U8P2aB?=
 =?us-ascii?Q?xwZYNEnZj9mFiPhiClZe3vMvZMwTI8JDk1Nvf/kTU9DuVCK/k1Fgk4WkU4Sl?=
 =?us-ascii?Q?fgNJXTXU/67cnCzckNiHxCLeX0BkXs4ncBJutxIYy0VkRTE6+Rc7zNElH+mY?=
 =?us-ascii?Q?cTPiDpyLFlfXNxLI0f7DOTXXMoGuP4S2+zf0yySiMq+B3h/FaYipnq3xv6Tx?=
 =?us-ascii?Q?hHzcHkT8N0r/X6MuinPS1luvTuaEW5wziObEaKr3tCcv0Xb9p1qT2U6KBI/f?=
 =?us-ascii?Q?7lbGKmYMdCfcNn6jRvpUgWrD8rbrASJ6sg694vlPvn8PHntRwbxLfaEoy8dM?=
 =?us-ascii?Q?KrDCvXK2uRSwvUhwHo+0c78EzGNlR5jGmI2ixyHjqNqW0ED7OpR3/NkirFBs?=
 =?us-ascii?Q?xF+XJBEWSXUpUVP4WbNJrY1dSCYopFEreoX+wST2eG0CEk6x39Tx/IbOUbBt?=
 =?us-ascii?Q?taOtqiGDCBjI46MmbCMe6UvyB8B692j+mz6LslMKBJmu2N7ZBqqRjVmeWrok?=
 =?us-ascii?Q?ztojfLfRpziQ5ow67hQ79cY0+BJqacx4wswr5kH0QQE2Hxp2Ia+9N6hgy5xF?=
 =?us-ascii?Q?BwJ0en9fC5QgGtp34H2RJWnlvkM/B/hiuubxW8IJ+xKgK5UEBpsOTjwKNhPq?=
 =?us-ascii?Q?4lnqnSFokrXthjLZOv2i4E7Ejq6Z+fA+S7a2LLf9vpRISLKJPZCvTUPfLE3S?=
 =?us-ascii?Q?xshKSJUcG9TzdRr61C6xYmEQ0c0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 07:46:32.0486
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93965e54-fb7d-4113-9808-08de5caf05e0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7214

From: Vidya Sagar <vidyas@nvidia.com>

On surprise down, LTSSM state transits from L0 -> Recovery.RcvrLock ->
Recovery.RcvrSpeed -> Gen1 Recovery.RcvrLock -> Detect. Recovery.RcvrLock
and Recovery.RcvrSpeed transit times are 24 msec and 48 msec respectively.
So, the total time taken to transit from L0 to detect state is ~96 msec.
Hence, increase the poll time to 120 msec.

Disable the LTSSM state after it transits to detect to avoid LTSSM
toggling between polling and detect states.

tegra_pcie_dw_pme_turnoff() function is called in non-atomic context
only, so use the non-atomic poll function.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
V4:
* None

V3:
* Addressed review comments from Bjorn
* Reworded the commit message

V2:
* None

 drivers/pci/controller/dwc/pcie-tegra194.c | 55 +++++++++++++---------
 1 file changed, 32 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 04ff211deaea..d3d577d5f67b 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -138,7 +138,11 @@
 #define APPL_DEBUG_PM_LINKST_IN_L0		0x11
 #define APPL_DEBUG_LTSSM_STATE_MASK		GENMASK(8, 3)
 #define APPL_DEBUG_LTSSM_STATE_SHIFT		3
-#define LTSSM_STATE_PRE_DETECT			5
+#define LTSSM_STATE_DETECT_QUIET		0x00
+#define LTSSM_STATE_DETECT_ACT			0x08
+#define LTSSM_STATE_PRE_DETECT_QUIET		0x28
+#define LTSSM_STATE_DETECT_WAIT			0x30
+#define LTSSM_STATE_L2_IDLE			0xa8
 
 #define APPL_RADM_STATUS			0xE4
 #define APPL_PM_XMT_TURNOFF_STATE		BIT(0)
@@ -202,7 +206,8 @@
 #define PME_ACK_DELAY		100   /* 100 us */
 #define PME_ACK_TIMEOUT		10000 /* 10 ms */
 
-#define LTSSM_TIMEOUT 50000	/* 50ms */
+#define LTSSM_DELAY		10000	/* 10 ms */
+#define LTSSM_TIMEOUT		120000	/* 120 ms */
 
 #define GEN3_GEN4_EQ_PRESET_INIT	5
 
@@ -1593,23 +1598,22 @@ static void tegra_pcie_dw_pme_turnoff(struct tegra_pcie_dw *pcie)
 		data &= ~APPL_PINMUX_PEX_RST;
 		appl_writel(pcie, data, APPL_PINMUX);
 
+		err = readl_poll_timeout(pcie->appl_base + APPL_DEBUG, data,
+			((data & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_DETECT_QUIET) ||
+			((data & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_DETECT_ACT) ||
+			((data & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_PRE_DETECT_QUIET) ||
+			((data & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_DETECT_WAIT),
+			LTSSM_DELAY, LTSSM_TIMEOUT);
+		if (err)
+			dev_info(pcie->dev, "Link didn't go to detect state\n");
+
 		/*
-		 * Some cards do not go to detect state even after de-asserting
-		 * PERST#. So, de-assert LTSSM to bring link to detect state.
+		 * Deassert LTSSM state to stop the state toggling between
+		 * polling and detect.
 		 */
 		data = readl(pcie->appl_base + APPL_CTRL);
 		data &= ~APPL_CTRL_LTSSM_EN;
 		writel(data, pcie->appl_base + APPL_CTRL);
-
-		err = readl_poll_timeout_atomic(pcie->appl_base + APPL_DEBUG,
-						data,
-						((data &
-						APPL_DEBUG_LTSSM_STATE_MASK) >>
-						APPL_DEBUG_LTSSM_STATE_SHIFT) ==
-						LTSSM_STATE_PRE_DETECT,
-						1, LTSSM_TIMEOUT);
-		if (err)
-			dev_info(pcie->dev, "Link didn't go to detect state\n");
 	}
 	/*
 	 * DBI registers may not be accessible after this as PLL-E would be
@@ -1677,19 +1681,24 @@ static void pex_ep_event_pex_rst_assert(struct tegra_pcie_dw *pcie)
 	if (pcie->ep_state == EP_STATE_DISABLED)
 		return;
 
-	/* Disable LTSSM */
+	ret = readl_poll_timeout(pcie->appl_base + APPL_DEBUG, val,
+		((val & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_DETECT_QUIET) ||
+		((val & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_DETECT_ACT) ||
+		((val & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_PRE_DETECT_QUIET) ||
+		((val & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_DETECT_WAIT) ||
+		((val & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_L2_IDLE),
+		LTSSM_DELAY, LTSSM_TIMEOUT);
+	if (ret)
+		dev_err(pcie->dev, "LTSSM state: 0x%x timeout: %d\n", val, ret);
+
+	/*
+	 * Deassert LTSSM state to stop the state toggling between
+	 * polling and detect.
+	 */
 	val = appl_readl(pcie, APPL_CTRL);
 	val &= ~APPL_CTRL_LTSSM_EN;
 	appl_writel(pcie, val, APPL_CTRL);
 
-	ret = readl_poll_timeout(pcie->appl_base + APPL_DEBUG, val,
-				 ((val & APPL_DEBUG_LTSSM_STATE_MASK) >>
-				 APPL_DEBUG_LTSSM_STATE_SHIFT) ==
-				 LTSSM_STATE_PRE_DETECT,
-				 1, LTSSM_TIMEOUT);
-	if (ret)
-		dev_err(pcie->dev, "Failed to go Detect state: %d\n", ret);
-
 	reset_control_assert(pcie->core_rst);
 
 	tegra_pcie_disable_phy(pcie);
-- 
2.34.1

