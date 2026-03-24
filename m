Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013036.outbound.protection.outlook.com [40.93.196.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188683B636A;
	Tue, 24 Mar 2026 19:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774379417; cv=fail; b=o7kWLfBvn9+3vehFTjNzA7X3dpzLxBuNykSftYPU+j1cRV6WDpyHad5cqO7ZHB/5sv0ZvpJizuZdopQa7OrP1VkTgQmHnPXRc4VsVkEf8yJ77PMSzanbFtSnsvcYvzo5lpcchRNQcUIi3IgWPjPkeHQKSxqUVPFt9lhcC0S1E1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774379417; c=relaxed/simple;
	bh=I2vUhqDdZvK5nyYFQjhDvSku9S4YD2sGWDD/vJqigJ4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fZfPY6lNSy3gmEz6793uE1/+t2bRLcojKQrAskyEuyTowzcYRJaNf2nTIB4aUr+3aiQ9LwIJZxW3RK3+llhlMbfqrKVjBDzGAkW2uhWuSoWaKiXbPGEYSpF1w2OhOg2PBXloo24c+cegckxdb51ngcNnIDGwQx1AbVDsRoXNYeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q2kRI4w0; arc=fail smtp.client-ip=40.93.196.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q2kRI4w0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eAQP5TzI2ovQ1fvaj+OOXzB7N67q4eU5AbYxo3UG00fEJ3VDSRDhGzxiDWWVwEXVVgjkdesbAj77QrkXzQ10Cbrmr8moqp47ILl47EaiQ9g6s5bOnVHCW+Mb0g2U5lytP9IUwBFQrZnfpmE2Q6aIdLA45J6iuaEBbxb/5dRkbW5rxuq5MUcqHt93SJJJNjHksIey24oyI6YQOnVeEJx5by8sSsSzoXzOwTydnud0mjcWdUL/9ab3bPFSYkovUiDoK1zZk0e16/SmVi7O7wnaPvg/tDgSw4P5L4PrdiqU6BkXb333R8rtywufdgQ+iF2LQFC3DGzq/X1r5mysmV8D5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LWpgD6zRcndYWAZ4vDu8kXsQmVvCyVX3E54LiV0SubA=;
 b=vFEHi/FJni2JvbugpSEDYzrpGp2yi5u7QwGHAot+t9CcSiz3Sd9oG4H+CtPhmg5gPX5jtZ2BwZfqmJDaFKgSqTSdh2qTMgVaD8dNdOtNJZT3koXFqTyDvG1BzP47RZYtbFGAlVdZqPOgEbXalZFSbYrHTOcdGerehWLmf0uoAPS1TvLdXsA9Q3w0y3/rGtt4Fakh1VyrBrzM8JwXAcJAgla4weZ37Ao7J7t3C0xYS8mVwIlbXubtxxHc+DX0Z1fY+z2Z8NTB8NVFbyKV14iE9bUknP5DwnZBYwalAC68OnMQNrcJZByEdHv6Rckd7FDywI1MFfnEytZv22+cWntcuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LWpgD6zRcndYWAZ4vDu8kXsQmVvCyVX3E54LiV0SubA=;
 b=q2kRI4w0LzCdt36GBcsxgAyJpbLc8/m+rgVHpQI9cGmUK9XytwiAM2CrKp4tMFksUdJCTddOQfmfseeBCAC1CLM4uoJO1eST5XWOFRizWsFyYjh+JkMHA++FP4rIvxlyHcmg6teJwBql+cXiiaKTn+o0eXqHlFyvLzwvmgmI75Gtz0efff7xnd9Ty+s61IM9+WjGjuMxGoG3drj+e6v1bLRP5jAEKu/rEgj/bsCos057mpB71PRVAhRO+t5tMiWj+9da4c0mgTrP3fq1ixOAEm3HA51GV+LMU0CTMwO/FYmnTNkTaiz9R1jEZIgnJbMyzmf26C9vm+XkDvsCGr4tdg==
Received: from BN9PR03CA0754.namprd03.prod.outlook.com (2603:10b6:408:13a::9)
 by BL1PR12MB5729.namprd12.prod.outlook.com (2603:10b6:208:384::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 19:10:01 +0000
Received: from BN2PEPF000044A8.namprd04.prod.outlook.com
 (2603:10b6:408:13a:cafe::d9) by BN9PR03CA0754.outlook.office365.com
 (2603:10b6:408:13a::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 19:09:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044A8.mail.protection.outlook.com (10.167.243.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 19:10:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 12:09:37 -0700
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 24 Mar 2026 12:09:31 -0700
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<kishon@kernel.org>, <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
	<Frank.Li@nxp.com>, <den@valinux.co.jp>, <hongxing.zhu@nxp.com>,
	<jingoohan1@gmail.com>, <vidyas@nvidia.com>, <cassel@kernel.org>,
	<18255117159@163.com>
CC: <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH v8 13/14] PCI: tegra194: Disable L1.2 capability of Tegra234 EP
Date: Wed, 25 Mar 2026 00:37:54 +0530
Message-ID: <20260324190755.1094879-14-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260324190755.1094879-1-mmaddireddy@nvidia.com>
References: <20260324190755.1094879-1-mmaddireddy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A8:EE_|BL1PR12MB5729:EE_
X-MS-Office365-Filtering-Correlation-Id: 1489991c-fea9-46da-0043-08de89d8f2d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|7416014|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	jNBeXu7Hh98GspUQsSF9+2VZdNfLbstxRasISn32dVgxFMsxc4LpsVKcSN1+vP96MPbkOXUI1ekO98Z5HsRKjQf1AcFSkADg4wgEIcYzE4VvykE6JGUnLuSUcu8A463HD6RzSxrzOr2cRMMzWra+Pn2qg/3FSkNUfisT3fIWMOynyQbFUlTA/+/qmSMHa7AQLm+O7UybkgrTsVYJkuNuSCKBKSimAnKN2g7NrCjf2gKQkHoZec2nAd87VjuNOvLskzPVsOR4BofFevQJPML9mFE1Xkq36nlH/Dj8VZS5jHVz6ux3Jbc2BpukT9qtc5jq2tqDvtdunEi0Rtg3Wg2T64F0Q70oC5H85GtiK7Xj8klrZxTNBXoDcjQ2bUt0drbyaDOH3/TgiRFR+Xow5m11531/ikSbCzzBazjABCK5KdN1kdvKXc+Ec4augk360q9/+hcy+dq55AmLklzE8xqHX3TuvtYjT+in+DGjD8P4hZlhxyB1rEXOO9PKnSkBL5ZxgRDUK2Tb807yeB88Gd5KAvNnXTY+C2ZnwQ0RTOCnjujkDBubBo8bD5PPB7SDiU0cNq0lUlysBo8fAR2mMYos8xe1HFiQLBv3E3v+5t+GPvDUDvT+97UXUUofIVvIf5swPSaNjKwmGC4JTapnXwrbfmR0zEAhxpaBxGTmlAde2vaVAjlMT3rKswVWtHQTAe72CU3gbPnNgDP7LJymMRU6twedD8FcMn41B7eizd9B7+5ZycrqoLBn7FrzQXjWTUeTHvYm0uu8tbA1YyskLvjCQ3mV+fpKcbGHCK5AzMNoN+OkpF2VvqWYfujxvWwLgyDE
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(7416014)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	znLZ8GeqJ0OEFLchi0+ljRN07WS3CtlCHq6pyhM5Zl7UHpBkDngFmp1CFACXwimEe5iTvbklTolec65iBGmL9aTY+w/Vo02bnCftnh2G5trCIM0MVXdhY9HMHtBkKRM/PBbxV77w3EkO91OIaIXlnI658dNXg2X7wsecK/aXXYPTDrX1/jvhIXvDHvor4rHXfyr/IaFDs171j0A2rrfLnB+ToSeY6chFRFKPCQNcjTk/bJClzBHb3nBYH9+TA7lB16B9vGJGsqOCGSvEJ/gPKyDcGkZY66VP8/Sgtrs0Cxi94gDVp/YEm10FNj+Z5sWYaWCLKrMcwL4/VsmsB65fofZ+XJblMfIuib5AC2EcKxHN1xb8FHFaOCofu0mifYBTuXbBhslYpdxnEN8DCmnfnPp6tGU8Zwhi3Bx7l9ZFco2+HKyGYDTpr4C6WYEn8t42
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 19:10:01.1049
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1489991c-fea9-46da-0043-08de89d8f2d8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5729

From: Vidya Sagar <vidyas@nvidia.com>

When Tegra234 is operating in the Endpoint mode with L1.2 enabled, PCIe
link goes down during L1.2 exit. This is because Tegra234 is powering up
UPHY PLL immediately without making sure that the REFCLK is stable.
This is causing UPHY PLL to not lock to the correct frequency and leading
to link going down. There is no hardware fix for this, hence do not
advertise the L1.2 capability in the Endpoint mode.

Fixes: a54e19073718 ("PCI: tegra194: Add Tegra234 PCIe support")
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
Changes V8: Add fixes tag and move to fixes series
Changes V1 -> V7: None

 drivers/pci/controller/dwc/pcie-tegra194.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 4cc0bdb0b9da..c7cae3a004ec 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -234,6 +234,7 @@ struct tegra_pcie_dw_of_data {
 	bool has_sbr_reset_fix;
 	bool has_l1ss_exit_fix;
 	bool has_ltr_req_fix;
+	bool disable_l1_2;
 	u32 cdm_chk_int_en_bit;
 	u32 gen4_preset_vec;
 	u8 n_fts[2];
@@ -679,6 +680,22 @@ static void init_host_aspm(struct tegra_pcie_dw *pcie)
 	if (pcie->supports_clkreq)
 		pci->l1ss_support = true;
 
+	/*
+	 * Disable L1.2 capability advertisement for Tegra234 Endpoint mode.
+	 * Tegra234 has a hardware bug where during L1.2 exit, the UPHY PLL is
+	 * powered up immediately without waiting for REFCLK to stabilize. This
+	 * causes the PLL to fail to lock to the correct frequency, resulting in
+	 * PCIe link loss. Since there is no hardware fix available, we prevent
+	 * the Endpoint from advertising L1.2 support by clearing the L1.2 bits
+	 * in the L1 PM Substates Capabilities register. This ensures the host
+	 * will not attempt to enter L1.2 state with this Endpoint.
+	 */
+	if (pcie->of_data->disable_l1_2 && pcie->of_data->mode == DW_PCIE_EP_TYPE) {
+		val = dw_pcie_readl_dbi(pci, l1ss + PCI_L1SS_CAP);
+		val &= ~(PCI_L1SS_CAP_PCIPM_L1_2 | PCI_L1SS_CAP_ASPM_L1_2);
+		dw_pcie_writel_dbi(pci, l1ss + PCI_L1SS_CAP, val);
+	}
+
 	/* Program L0s and L1 entrance latencies */
 	val = dw_pcie_readl_dbi(pci, PCIE_PORT_AFR);
 	val &= ~PORT_AFR_L0S_ENTRANCE_LAT_MASK;
@@ -2443,6 +2460,7 @@ static const struct tegra_pcie_dw_of_data tegra234_pcie_dw_ep_of_data = {
 	.mode = DW_PCIE_EP_TYPE,
 	.has_l1ss_exit_fix = true,
 	.has_ltr_req_fix = true,
+	.disable_l1_2 = true,
 	.cdm_chk_int_en_bit = BIT(18),
 	/* Gen4 - 6, 8 and 9 presets enabled */
 	.gen4_preset_vec = 0x340,
-- 
2.34.1

