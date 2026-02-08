Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012053.outbound.protection.outlook.com [52.101.48.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33F82F3C37;
	Sun,  8 Feb 2026 18:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770574248; cv=fail; b=gpMtjk2uFNuP/bVgxC9+BGO1p7dnOj9K2vGGUNRgoAkMxSkeVkG9wyXzHPDQuPK7vmJqn0cA2wXFyIWdzgwYl08tPA9bgMxDZakBaaK3r3+/x+oCZWyY0nRe8VSB5vQSxPN0VJqpsZvd3HG/TsA6VmtFtWi7RaMqBkiDBmUW/80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770574248; c=relaxed/simple;
	bh=zXqNiOpVYKE39ciZ7BfIzRecY/8nt04s8TFjGVdwZfI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZOt7IUEVy8M0kSsJK9A1K8gakBXzGZSCzOhkmWsFH00L3fzUs4wiXbQErS2eEf3kSwRMoWoKHEp8F6KWpoEqRm0xUqyAAMPav0S5vmxFbDJBQI6xPMs7qNKl9Ff/OlF1T+A67aIU57wZGRiPoNxS8gTRTmtlTvZMpCsmMw5XHxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HoVm8SUj; arc=fail smtp.client-ip=52.101.48.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HoVm8SUj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ogOlVMAXtfAOfSR7s6arkvrk1SZhE2mEzArSIF10bEjrHiv9chfLK0ky+3ZwW43xZ3J7/BsA6w6DgK24eb77/KgyXuIffaV5VqBNy7zsi6+UMJlqUP3v6iiDbeCBlXWdx78gcTgVRvViF8JepCffIjXtmyDiiB1ZzY+39ntMzI9JDPiHiqayhZ5+cK/CND/8AJf8DUDyyrj8FL+FM4U5vPNx9OLVrixREvbMs7rAHEFo0OiwMp6S0T8pUuxBd2mW+Ly8ORWAXlKOh+/WHyrmvEPv9epUHXB3KAOFbn3oTYuV8fcs8H8UKbLS1OoOTgCtrAcAZRmHsUNsFg1qG4QSoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9HmfDtFc13xJXqO41s6mxYYaR7iVAnqYNJqnpyuRDg=;
 b=eK4GjiPDj/WXbbju9o9Xo0baKdeROhyk6S/eQYHc6lp6q96XAziTxYWL769CdBzTS1QmkKtDYw6ML9bn7pGolJ2lR48FzaITVdy6ruslYbV6njtfL178E5TQl5A0xUEoFrO0WAMQfnE2sBRrDz5Tx1+btJMjbYw0Peew6y5bmWSJx5lp/N5Bua7guIS3JD7R01Bt2UT8V9ZvGlZQYJkXq/F04flISBzvqHAkztqORuInla6jsrZbZDB+BCeQ+nfPWeERhLAqqJD07pVsxGEEWgtEhPde1wyTMT1rQ1imo1bWPn3nGIiDn/bVuwRdYCvzINdbfR1e6Y+UI6CO/ICvbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9HmfDtFc13xJXqO41s6mxYYaR7iVAnqYNJqnpyuRDg=;
 b=HoVm8SUjRE2Ua1x5Ef1EOI/2gjHg9pJ1+5Thvk+clHUHhukQNMOMBC+zJFYDa2zLjKxr8V7xsiCi3HnFwDKOYFKD+kPbZVbxacV3r41sVuPdK3jtfckTnpOwQom1PqPM0oN+99iTOFD5MeWefea8CHVuqh+aOJ5Vyyqz2aEASoMynJqZTPWQ8xcd+d75P1Rps7e+IRItOAamBSwo/JedKsZXsENJVuoloYtgIIBykC4oc6+2e6NaFsQbCXwED8i3ZVbfNweo2WEWtUJSAQnzBeBMKH93oIrkJW53ii3uRlgANRXvfIlstT/mbB6DIymGrFfqbmeMnOHy9c9p/KrMuw==
Received: from PH7P221CA0080.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::34)
 by SJ1PR12MB6315.namprd12.prod.outlook.com (2603:10b6:a03:456::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Sun, 8 Feb
 2026 18:10:44 +0000
Received: from SJ1PEPF000023D9.namprd21.prod.outlook.com
 (2603:10b6:510:328:cafe::ea) by PH7P221CA0080.outlook.office365.com
 (2603:10b6:510:328::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.18 via Frontend Transport; Sun,
 8 Feb 2026 18:10:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023D9.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.0 via Frontend Transport; Sun, 8 Feb 2026 18:10:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 8 Feb
 2026 10:10:30 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 8 Feb 2026 10:10:25 -0800
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<jingoohan1@gmail.com>, <vidyas@nvidia.com>, <cassel@kernel.org>,
	<18255117159@163.com>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Manikanta
 Maddireddy" <mmaddireddy@nvidia.com>
Subject: [V5,6/9] PCI: tegra194: Disable L1.2 capability of Tegra234 EP
Date: Sun, 8 Feb 2026 23:39:33 +0530
Message-ID: <20260208180936.2026329-7-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260208180936.2026329-1-mmaddireddy@nvidia.com>
References: <20260208180936.2026329-1-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D9:EE_|SJ1PR12MB6315:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fbd0683-c0ba-4f9a-0bb4-08de673d60a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TaR0X+9c4SfeYgrpp89FiyOr9Y2yD8/WF1sWeKOJV/cjuZ4wBAROLEKSMgKZ?=
 =?us-ascii?Q?10a5xD1EzZ+Cqo6/ES4CKIohketqwoAKTrs+Cx0ZrEmMGwmxZ/KH72kXiP23?=
 =?us-ascii?Q?KCSyCowi66Nf4GZgK/gjQ2gcKXwyrgUX6q35Z9NQbWCQo9tp2oIayyBjVcoW?=
 =?us-ascii?Q?/ExKugErEktBirTzLIBdCEMbsDOaQ9nA5wsN/2R2IUqTL7TkJ/80BLdILuct?=
 =?us-ascii?Q?6CsS9SL2bVqG+6RPFvWFDOweh+UyG4DnJ+mMA8OAZk9tmbkxfrQ2P/n446KL?=
 =?us-ascii?Q?QMsfBuF+LrFz9P7roujtRydVU/arM39MStahWzbnCmi2CrfPiCvoUmB+YU8u?=
 =?us-ascii?Q?Lv0JA4eRaMBSF/MCUpMwbY/Yyi5lXfzoES1dfGqe24s/GntGmDDEugxhS+1p?=
 =?us-ascii?Q?6wA85T/2dkMb9tRtOsjJBzo/XjmmA+vaC3PbJSbE5TXaVFAlIrZD1ekP22h1?=
 =?us-ascii?Q?KVHRi5kIt1l+NAmw5HFPew/siSceQ+H0GDSx/NqPIobzl9fRJN5P9y4OPn4P?=
 =?us-ascii?Q?m4kur16Kvk4erCgmgKciP5AfgwZ3FDEQQMVBjYPEpD0/TKdx/q7VbO1CtPts?=
 =?us-ascii?Q?Pb6+whB0X52yDt7vL5agpogcLiPYUkOAb/PeKWwo9OXtJf12nApcPEIs8wBd?=
 =?us-ascii?Q?8H2Tn5V5+4mQicLdBBbG/rjSIYY15luolnbLaQGpZs+9irDnkIS5rZaR+p18?=
 =?us-ascii?Q?dXHqewvWDx7mARGUzmFPwkqCCbYK5OhYsGtquljHAW2Oma48AGuXHFC8/Ne/?=
 =?us-ascii?Q?FAw6YG+8ciuYSn960dpXWS8jNTCh66/S6nDOcwFBIoj97u5PuTbP+mWDGkWS?=
 =?us-ascii?Q?3t6lKUt60TH9qb1kvQqdTfun1023G6bk5akGXl6596V0p0cVE4ftzBuCyypF?=
 =?us-ascii?Q?/tqXtyku/T324ufRnCmRNpFOclD45ZzWfdXGI9VeCF/l4iruUGBQevCbuhDI?=
 =?us-ascii?Q?iXspKvVejlK/yTnPwbIzDAnmMJ+/YoXEYlVQ+/qIICZEbLCDRZHFGgnzLh28?=
 =?us-ascii?Q?Y3TX4hmzm3HOOpgTajW6Mx73AdnnbdZR6Ii2CougG+PEY97OfhsTp3503sqF?=
 =?us-ascii?Q?SjVU2I52yqw1B9AzbqDrPOt1nYoE2G4zml5DKOADrzNZx4G9iLoFS7ed+X1u?=
 =?us-ascii?Q?zJIruWGtBMdvZ0JsooLs2+oI0XuWIB8u9rqfNuy6016wYgj0pDHg4l0nePzO?=
 =?us-ascii?Q?jmJ2pUxQNvHpxVNX9tbsW31/KREAGG+pz8nzJtKgZktqjuLR3i6CqOM/MYwi?=
 =?us-ascii?Q?sCSvn/sXrddH4xaWvB6ac0AsiEcalOa8UxcShaBrbQFGMU+jRDgKKS0PRjUe?=
 =?us-ascii?Q?YcECTShqkgNYe1fhVDJrKMiZhXcNWXqh5M9MOkOU3fHF4n0PrwZWB9vcVp8i?=
 =?us-ascii?Q?IiQ91MxseedmD2Kbl3ffeOXKwxvqPTf4TjBktnT5mUn86/6I04rTfVRUxvRo?=
 =?us-ascii?Q?SdsDtzX5Rp8wiB3auWHb2lzGv2MbUvTaSYDy7pdiTHuNCIwS4/nhhT6VyW92?=
 =?us-ascii?Q?4hsxNw/+frkXkn4djfzVZe2biXKMIdqevwo61EZfVsudSHU8csD0+K3ZJRpP?=
 =?us-ascii?Q?z4M/SLecdEv4ZzD2udShR6zBkNl5MrdkwNUrxiRbVe6rQ7DGVIqBljCMDif1?=
 =?us-ascii?Q?q8rT1mb8Lqd85ZytvmHHLgWTptfd+tjqUyC/eSDJa7E6dXKM2KA9lAFyaZfj?=
 =?us-ascii?Q?r4LVv9eZ5iBjUGT7grQnXmPpuo4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zfP9V/mM55qwXxm3qKR6APQkB1rNaX4PEnSdwuGwnls1Q+apvrDd5K/qYUPAyOSm7RgZu3+w/JtREG4XYPpKqu9XYb3drpxxOEIi1gQ5XjFtMpBcP0WuklnMxocue6moNw51mBCfcUx+barKMCQnYLcqu1FGScbWpO4fxwNTYAR+I9uSTq5v9ViuJl/ly0Xwy7bupsK1eo5P+3My0fm2dZe68BpFeVNFA/PiiLCzPD+vYsNDWKMe7vCBaWkBhnJsABixkpmqHHNQek5EV1o7nzmwUKzT+LGjtDrwhJhTB4gCSVbdJVv4fJ78oArrYXlcobuMMJ3DipUkHgWZnFwwY6ZHnQ7Bymx2AK62eQVmMOQbGEKEpX+yEWLWLsBD09TiXKyA8yD8x/yiq+/fRSvRSjdjXUBsnKEii/Q73U3Xds69gASUKzGSSDA1N4kwOvIR
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 18:10:44.4780
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fbd0683-c0ba-4f9a-0bb4-08de673d60a4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6315

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
V5:
* None

V4:
* None

V3:
* None

V2:
* None

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

