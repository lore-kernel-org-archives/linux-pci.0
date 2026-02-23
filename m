Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010005.outbound.protection.outlook.com [52.101.85.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FFB36922F;
	Mon, 23 Feb 2026 18:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771872435; cv=fail; b=FtTqatkeZ8dABSAC97MvwSe9eJ/0L+U3Pc+tvf9VLJ70P11hqPA/9x9sIcwIxpMT1FE9ihIWoUC+yA2pEvd8tPItDHUIn1TcxHfr9auHlTCaC9gvXnU07qsF1Lk3VOx4d1bCnvQQ8RJ1VVxP3IqJvuiyCj73rMz2yCpMLMmdQHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771872435; c=relaxed/simple;
	bh=m6iF+ETpqt/n4KTMPWVF4Ckc1Mnm090dajDbJjLyeeI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wk+WbmfGOk1ncV//Xe8pZ91sRnLlTQQQEtRMSxQ7MGLukEuAx9a9pnMTDAMorndqiefOVR/SWKQdy5mECiMfXlaaufx51KoKxA+bV6b2+1brY153tVKG9ggAfzQ0vqBcO235BHTRnxdVg6quKXpFy+889WuBnCBM/s3f7zJ7Kkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ajP60A1y; arc=fail smtp.client-ip=52.101.85.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ajP60A1y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H+ztFaYO7E60NbR6xqolzJSksUdu+rjJTZnELYJvAKh3fDA4Seoi1QEMhHVMqkmerDEY1O+0GfZovOUGPFDbO//3M/osfOeLcFPRfbQRoytmGUELgt+v5HVNICkbpTygzgUqM+k802az1DO/xjx+2uiw1Hp8VYT7ekmAcgSinPCluv/BuZxY1FJNMrYnMpxc5CSf6IGgmySEP7KsiHKi832JvAgBfXJ5QpkGI36hEQc9dYfVCNm3RXFE+LicjLh7z4ZZKKQsZkqu32junoxMBFymc42IMqMn+OLv4+okty5us0nvxpVBU9444hZgAbbShAdE99AEFhZN45CaIuQMRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iW7tNQ01DYYS7+wSYp0Ei+5ldmIb0z4ozn7/FYhbH7U=;
 b=B9uFud8hkouUQH5DGzEPpx6g7un09U981X/+483DPWwUrzhmshO7lm/gSST2xwn4tj3K35kPTufoLcSpT5a2+EVG+u08sf32u/I+C52zmirkg+wNderfOSWFkYQY877793AOaKmHoocdxTu3LvOns2/V2cbwU8jyofFH4ksUTiSrtZ8UhCvUa9sgwtcPUqvXY05oH8fj9/cRdNSPF8xqcoC+lhIe82atRgIX6hk7zMQr7O1TIn+2CHHCGPlILyq5sFG5OcWBr2jEO5mETUZ4QppEIamPqkyFuSymZwBna9LFcIcefhPOp+8N1XDJJe9e7b3wd7r7J456LY50D5XFDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iW7tNQ01DYYS7+wSYp0Ei+5ldmIb0z4ozn7/FYhbH7U=;
 b=ajP60A1y7DMrTWVbn9erCu9SNpxOO8Ub3ZawlRVaUe2WTaJHzj0Nc0MkuUNYPjZXdUHO/233mpNVWSNdZoFk4GCCv2AUMUngm3XasWk1cXaR+VRN0R4xedz2P9ZiKrKleIBEw74lI54ZKjiEXR4kkEhttpmy85mUhJCsmbRibl/U22fFU46D6h0l6VhQWSJpfVcnENyCCWf63Kdq5mrnQDeQa2n/fHw8E3Yzsu1O0aUZE7Cg6tLTI+8pi0sV5n7KyN11NuHszyZseAuAmAgpvHYc9EjJ+ljjVjnOh4YTdMm+0HGowI+y01TkV9ykAoT/p0X+NvDfFw6XL0LBwHM4NA==
Received: from SJ0PR05CA0154.namprd05.prod.outlook.com (2603:10b6:a03:339::9)
 by DS7PR12MB5766.namprd12.prod.outlook.com (2603:10b6:8:75::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.19; Mon, 23 Feb
 2026 18:47:05 +0000
Received: from SJ1PEPF000023D5.namprd21.prod.outlook.com
 (2603:10b6:a03:339:cafe::4e) by SJ0PR05CA0154.outlook.office365.com
 (2603:10b6:a03:339::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Mon,
 23 Feb 2026 18:46:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023D5.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.0 via Frontend Transport; Mon, 23 Feb 2026 18:47:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 10:46:40 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 23 Feb 2026 10:46:34 -0800
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
Subject: [PATCH v6 6/9] PCI: tegra194: Disable L1.2 capability of Tegra234 EP
Date: Tue, 24 Feb 2026 00:15:35 +0530
Message-ID: <20260223184538.3084753-7-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260223184538.3084753-1-mmaddireddy@nvidia.com>
References: <20260223184538.3084753-1-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D5:EE_|DS7PR12MB5766:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d9a307a-0da5-4b4e-8824-08de730befb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VtIj0Ah/Owi+KyIgYZMQInLo68enHeZhmXcHwBuriCDhtGTDz7CDCBxO5Npa?=
 =?us-ascii?Q?ut+A3WDuHb/D3adp35HgHQ9qfFfQsAyRTR+je+NHo3UlwEWrMF96Sv+j+AUD?=
 =?us-ascii?Q?6vUucHz8+5Gb8y7H9c1PwR5eOuOdJaQLWy8Dj+rPjK70mZkKLLEbGS/mxdJ5?=
 =?us-ascii?Q?qZXAWgzEorePrDOGj+jrfEKpqel8TNhGZmMA79Wuul4oAaQRsskhEFgeZS+e?=
 =?us-ascii?Q?O/bIDxPRI129gQG87o9/j3s2abDs30IS4ilDZ/cwbnDtC8D21vpIK0oQ4mD5?=
 =?us-ascii?Q?OF4vdDtNtd1fEkLzXNbWOX3ZyGoXoo6mjlU/iJHzUoBrw2BGjZ7QPJt0qOTz?=
 =?us-ascii?Q?KXag+bOBHCDTuFF1PWGdbInh/k6HvOZYeG9oql6EO6XD5DdVT4BAZN/Wc8gb?=
 =?us-ascii?Q?rLE8gpnlZb6Jd9SPwznKrLFlZbT1myc9rhEhlA4Q4yu67Q+8Ju5EiOt0DLih?=
 =?us-ascii?Q?tpByCDwtK+oJ7cVZ1djKcgCFz8NyeQdhmOoxtJ9f+/xtT9Mth6fO5jl7lEe5?=
 =?us-ascii?Q?D+O/8QTJGMaNuW9ms2kHNRNRO2qPvb7JqnkdhCrnCMHFy3smnDQvHMj7Js1t?=
 =?us-ascii?Q?OXUE0ElRxXoqk3m4D5tqZsziQm5dXR75YBF838FwxoP+AWsOktG6YZo5KZXc?=
 =?us-ascii?Q?p5ik3IPkaA+dv8rgt1ELEvoI7MwzdG/60M0X9Zuy22M+ppMSinrpqXq9M4so?=
 =?us-ascii?Q?XFEqQjh+RkLYixmrIAUlyRFOf3jTzPbQpFOHQYSM6NPnliY7U7VFzb2aQrpA?=
 =?us-ascii?Q?8yXf7vCG0U488n7XEAzbqTtiNmHVilx9PFxhQ9cbEipvJvAmxaD7XawhzgFW?=
 =?us-ascii?Q?GEdFWn4NtHyeJAlM7PnWimYuEynhz26D7UC3gPlJSIaNgd9d4++hjPdUTmZK?=
 =?us-ascii?Q?ompoZTc2ZlxzPTEOO5WiKOHVNTwNok8NgO6dD9bQ1I/emjEmsf+VInHnYH+f?=
 =?us-ascii?Q?wpO/q8ZVOFZqyY9S2j0pEue7svGFQRs8XNQ7HAOXkuFgy8RZzSSNyUROgXld?=
 =?us-ascii?Q?+lOF5YXLsAyksyaMrXdjYZqvbV1cMWRtyik86Eu+UWzQfXPX0nRM7pXsbBfW?=
 =?us-ascii?Q?Hh7M97cqdR/rIW2/oUbkBfo3VklmfR0srELHvkT4TsHf7/1kGNqNc3ja8Zoo?=
 =?us-ascii?Q?DKuJK3jZo3Vr3jpzdq+o5TXGZOXYcJs2UubkmQo6tHxQLo9/NlkOKrB7wEsi?=
 =?us-ascii?Q?63CB5uC4fa7tNKVds3uMCtlE6iskNPJNyONqZIXlapRgjikmeeEuN46JPCqP?=
 =?us-ascii?Q?k4BeXoQQyxilYstsqqXHsEWvSoaPXv4uyrA8g7523ZpntUZwbhBCJbTO12hV?=
 =?us-ascii?Q?H7NxoYiM+2tG0FVWqF1kV6LqnHve24itAjJIwSiepba6fWJewlpGzL/wnXOz?=
 =?us-ascii?Q?nSH58pIdInh2AWichIIiWiOAu1H+SEQigi0Q3i+DqXtpsCqu5+mL4fTLkcXt?=
 =?us-ascii?Q?AVHtPHuwUddryNKuMSB3XLStQ71bqRQIkaT7YSdCc03VQDI2JZlVIm9NAU0F?=
 =?us-ascii?Q?PuvLEgT2pKsUjBR9D4t8W5fSZ+GzTuIcn2wr0tkElD7cWTlXnnh41BTEOev/?=
 =?us-ascii?Q?KYOmwOtPGnsJzXtrMVKXdIucnr7aprjLgePkgGru8mmGczePaIbS0OTl/MZd?=
 =?us-ascii?Q?himd7dX66nUKOxHpMIkjyO1Gx9U8RzhJwVSyqhi02AyUufAy6e68plNdAhNW?=
 =?us-ascii?Q?KZLqae0u7grOUoGMwyDm9b4pk0o=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4gMLpec4q8WqDoTqTjSM3GchVsa5Zp/9zGq+cBHDp8LY7VLxd5K8bwSgRhsw5Cd3ACTzuCA0ivhC+vbt5lIPeU1i6nftRs+MrxR4ND9XQjXpRORXzYfkrhdvpePzSnjumL4uF+/ZUEa2IiDMfjgcK0stxO4wux2aSmBTLoA6D16mGnz2xolX+sUrjMLHjrZTin2jADEvpET6d1HO9qvTEJEuz8Wdh1x2xn+04G+r+UFeSpxOWLEn44TBUvF2c8qzT9v1hLbJlXy6RGj2Glu7GJ4eBtd1LAv6+l8wcwR3pwzTRYfvfb85wvN5hUY0fFsNHdhYvz0ON7C2sFhCfNXna6JJsOPs+fBz04mFHr14J9X4ufM/8shsM/64VNc+gfVdUzAt0qzDEHT8Ti2m5vxhH3KuyaDJDtcqBh+E+NAY2gU8uoF40BQ4zrqa0FgapmV0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 18:47:03.5503
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d9a307a-0da5-4b4e-8824-08de730befb7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D5.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5766

From: Vidya Sagar <vidyas@nvidia.com>

When Tegra234 is operating in the endpoint mode with L1.2 enabled, PCIe
link goes down during L1.2 exit. This is because Tegra234 is powering up
UPHY PLL immediately without making sure that the REFCLK is stable.
This is causing UPHY PLL to not lock to the correct frequency and leading
to link going down. There is no hardware fix for this, hence do not
advertise the L1.2 capability in the endpoint mode.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
Changes V1 -> V6: None

 drivers/pci/controller/dwc/pcie-tegra194.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index f6305a880cad..96581fcd8693 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -240,6 +240,7 @@ struct tegra_pcie_dw_of_data {
 	bool has_sbr_reset_fix;
 	bool has_l1ss_exit_fix;
 	bool has_ltr_req_fix;
+	bool disable_l1_2;
 	u32 cdm_chk_int_en_bit;
 	u32 gen4_preset_vec;
 	u8 n_fts[2];
@@ -692,6 +693,22 @@ static void init_host_aspm(struct tegra_pcie_dw *pcie)
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
@@ -2464,6 +2481,7 @@ static const struct tegra_pcie_dw_of_data tegra234_pcie_dw_ep_of_data = {
 	.mode = DW_PCIE_EP_TYPE,
 	.has_l1ss_exit_fix = true,
 	.has_ltr_req_fix = true,
+	.disable_l1_2 = true,
 	.cdm_chk_int_en_bit = BIT(18),
 	/* Gen4 - 6, 8 and 9 presets enabled */
 	.gen4_preset_vec = 0x340,
-- 
2.34.1

