Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011042.outbound.protection.outlook.com [40.93.194.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB792F5472;
	Sun,  8 Feb 2026 18:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770574176; cv=fail; b=NRcXsaslkX8GZBKQq81jtTdUSBf159Su2o0l1jWexkFmwx96QU1fW4OW/i0tuzS+T4kGXIa3am7SINfUNhtsXJ7849QOQbsFyjAhS0Hv5Vvw7xIytB490vyQRWf/+4BYgtSuLjdmLMNUc25RYLWcm4tf8aV/K9i4Izev6dJyDiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770574176; c=relaxed/simple;
	bh=sfJPrJRnrmZ6YEhJeXv0gmGV9PhV6JPBFeKPI/b5oRc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HA3XNA/afJgkzWdpBhoex1VRU5Jjh2hNvV6fwciFCjrbyYHemxTySfo+KJg5YtkXkCfjtBG2n3mmmE+UUd5fNOllk/irBoKcLNH279cP5EnKD1vYHgzAgiJgHov2t8k5hZpEOnnc07uD+17y7VErxhDQIlx2a3u/bhGT4wktVQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Bd1cTHoN; arc=fail smtp.client-ip=40.93.194.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Bd1cTHoN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ajxQyarGe+n5pIW3OFoIzsZihU3VDYEOb9iKPiga7X8zryDOAHAkQboN14gwKbUr6Ir6+X5cUbSvKGive38JW4yIiQP4WW9RK35vJ6H36peE7FeKYUcmW90i9YsYK72ksONHoei9ljybOK+0hU7yns0WoAwdc9+c9xAtE2RHr081PWGc8NNbuwdJn51RUO8omw7v79MarX13wRd796JvdhkfQiJJZfNL7OEF5iIZ8MKBAsuaB9uK0P1iLOmA3SvjWZAVV+tTQtPWosmkreebfKQMNR9IfGBQUw78RtjGVfGLyhS9gSlQRCM5JISokbE9mjVsqMBNz5YCVugDYTe02g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HgdNrq5cyv3T2PAv6/RXFsbLPe7o9wqs1w2B2N5rsMg=;
 b=xIOdOM/oISt8mOI4mPh9Idqud4oeCrbHz49gtgF0QUwTHNhllvQowlsgItk7qEpt7HBwK8h/BWJ9iH/Q+79bUCi1cEr5CWjn13kAIi6liMsNNhTz9+KYw2RTbVf+bNV4lZYAbbVFzPaeLWiukVQcYzWCVNFNccSCa63QE+/uLbR8dKEij0/51qfJ5Esj45KySUoVHXv1hsIwlA6Udt/6Cc1m1cuystxiRZwIxrUO+GF9ElcJsDn50lKC76eFuWMT0J1WDQhAL1hJlpkDi37Ii5lB7AwUv5bGPyB5N6YKYPP1chAwWUaAoe6kwb6Nu+i0cH2sEdszdTZx9of82chJKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HgdNrq5cyv3T2PAv6/RXFsbLPe7o9wqs1w2B2N5rsMg=;
 b=Bd1cTHoNA/7Jca6en9OShJgOqmA9H2IxO4fAtxc0gmaORX4xSpqcLYyI2tpn0OJodZODckQ/rZyIao1nQKDkt3hFfZsDVoKEljXQFrWjG5+23WH2897oYD/MmSgmVWJ28fQepDTnKS0uN4KLbiIqGrtUeVYfyvZ/OftnCNZyStqq/KMUub5SQb0YG/M1wj6rYmdXBi6qUmobOmzLUgOm4olSkjCZ7a9RhJg0tY4rLOl6EGLU1u7DYpm5WALHm+hqKFqxgnY4IhrrrbYmidqX+ho3IPpwM3mojHgnv6r72hFNNkrYQYAOvIDpL1S+1Tqu9hqDkdF05OU8PRIHj9/fGQ==
Received: from BYAPR02CA0070.namprd02.prod.outlook.com (2603:10b6:a03:54::47)
 by MW4PR12MB6875.namprd12.prod.outlook.com (2603:10b6:303:209::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Sun, 8 Feb
 2026 18:09:31 +0000
Received: from SJ1PEPF000023D8.namprd21.prod.outlook.com
 (2603:10b6:a03:54:cafe::77) by BYAPR02CA0070.outlook.office365.com
 (2603:10b6:a03:54::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.18 via Frontend Transport; Sun,
 8 Feb 2026 18:09:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023D8.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.0 via Frontend Transport; Sun, 8 Feb 2026 18:09:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 8 Feb
 2026 10:09:24 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 8 Feb 2026 10:09:19 -0800
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<jingoohan1@gmail.com>, <vidyas@nvidia.com>, <cassel@kernel.org>,
	<18255117159@163.com>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Manikanta
 Maddireddy" <mmaddireddy@nvidia.com>
Subject: [V5,13/13] PCI: tegra194: Set LTR message request before PCIe link up
Date: Sun, 8 Feb 2026 23:37:46 +0530
Message-ID: <20260208180746.2024338-14-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260208180746.2024338-1-mmaddireddy@nvidia.com>
References: <20260208180746.2024338-1-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D8:EE_|MW4PR12MB6875:EE_
X-MS-Office365-Filtering-Correlation-Id: a07f364b-217e-4c34-18d6-08de673d34cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GLULTHoN2iH/Ju5bj3RkbluZnpb2i8Jy9p+yJooiEvlqeEdBl8xONbYWgdhK?=
 =?us-ascii?Q?itRap+9/UYu29CFuj8XLYID0c/U2BWlO1/y2a0OJlKYFkA+Wz6BAhthUwEp6?=
 =?us-ascii?Q?wl2sGEagFsJidscFySJg4WBVPlXg2Tj06THs0z1Hmi44a2F21I3jMs3VAZJ9?=
 =?us-ascii?Q?qlGodRpKEc/rbPZoYCXk1WZJjBU48bpez8GFUf3BvlxK1Ia8NhP+iKeE+Daa?=
 =?us-ascii?Q?M4P1omDQ9MP3TPSOWRlqzrzoiwEkBbsCR5Y/LsSPFKCOMUcSnVE3GpZGEwPV?=
 =?us-ascii?Q?X2pCWbnIYFlW8y2T2OfX90jPTzUgK66R3KaKYX9zY0x3ONSKN/2WRFhralFu?=
 =?us-ascii?Q?bcayUMnrDEoARUpVIp/bQ+0hshws3GVNafvzlUEGEHxOA+p+v3aCPGOCPvQN?=
 =?us-ascii?Q?9kTwBBGqIiADN/koWslUvCVkQ83eIkLEgerP4LUmstJo4LQ4TuYChi9cGXA1?=
 =?us-ascii?Q?UCvguzMgOuDUXlDDj0YX1G99dYDn6YUQpsA5qX5i9iv6pwEFfcuJSnGs0T6S?=
 =?us-ascii?Q?xTTBhoFAYeIVXnTTgOxkdY+ZiV70Kxuue5L8DxDsuEpPrc78luIdKki9HaYA?=
 =?us-ascii?Q?aJQy2ol0dTXxDeAjr7c8cw7h40fOItWKwzxhWOfE7iaWg7HD0FN3hXnH1gg+?=
 =?us-ascii?Q?jqC4TBXziKaZqBzaKO59saOmsnkoMFEAd5otjgJejPCDnSDA4tA6OQRZY9QV?=
 =?us-ascii?Q?VTgcAzx7rR5GWKLkSOSn4+KcdRNsC7nOq7hhcmC9R/VqFCFmIjtbIbUoAhu6?=
 =?us-ascii?Q?b8vvmMdsJ2a+juEhHwTqnbuyjB2WA985gNt6mMFpQSnX5nBUJqhKL8NR6i08?=
 =?us-ascii?Q?6VySe25s9Z5b1mW3PTgGmjaNDE9qVcEck5OrbZOk0ZPanie/BxzIwjJDZWDp?=
 =?us-ascii?Q?ZEF18mDMeKWxNX0ZWT6s1WwPKyRx/KVJ1ttrzH0JPWJ4HoUnIyPLlsUjSJDN?=
 =?us-ascii?Q?rnwI61IzU1MnA7r9n3q5XT1/1ZuY5V0XGyaSVXZpUfaaDG3hC7xRweId7cLC?=
 =?us-ascii?Q?bvRK8Y5g0WZ5ReC2QNPl+o3zEFX58P3eJDXDrCcvlTzfocnIeDFB28GA0kNG?=
 =?us-ascii?Q?sjWJTU3m8XXAqrqYH2e6pdtpVbHwXz3TyDQRGnnHxat6mlBu1oxiJJBpvEH4?=
 =?us-ascii?Q?CDFUrmsOhvhSu35bek7JOdJnon4XVGo2xQ5y45GNWs3BuXXYMyWF/7m83VuL?=
 =?us-ascii?Q?bt1aPtGRewG688ZdNfL9dui7decQ1R08kB4XvKneQYxmwb/k+buwEwjoM2AL?=
 =?us-ascii?Q?6F6cdEIHCjbHCIyOuIUzi+Kj6N3T9KR1ZxtSq+aU7zijRlnLQXQ1CCds5kug?=
 =?us-ascii?Q?gxLmlYwcfJMvZ4feTiTrIXakOZrHNvc6ryPdAU1N7TGTBoNWT1AS+cewDltN?=
 =?us-ascii?Q?waCqomeG9KErdaOcYGvTygDsew1VSKH3KxtT3qEpTCSaSAxdIoWHyKcAOAvv?=
 =?us-ascii?Q?WvW+XCQ89KCgV7u+V1tfrZ5KL3hSEctQTSBxSibB/70EjQ/voQGJSvRdItjh?=
 =?us-ascii?Q?h4Srm8YksMv0har6bkg8zC/rkOItb3zCacB/ZAcyL010beyu3ShOHTM1nLtl?=
 =?us-ascii?Q?nCLkPqiTRfokL8LyGkTnpdmFab5k2spqp1zvp2mV2eTv59oLIJZMDLtdjOXB?=
 =?us-ascii?Q?r5ifudLLRn4uYYvKO+1US5Oc1hcMQO3C/g1R6s2hMl90mji3noHfilf7Pava?=
 =?us-ascii?Q?dExapCwVxLbNoGkZlYJypBLyVPQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CbnrQ9f/kpx2PUZ8oCxjv7bCak/1Yq6uu8pv2lsJC+ktaM0gABieVAWPpuumsehB5SSIn40dOTogKw5EDVT4gqJRC5+zKF3GPKHCl2f17vJqSO1EBZhimPbAbqhKpeEoDhA4J0mMDXCJWcyKhGsmtEmo6FSu7uOJB/0b733Ox9qb39wS39NJrTyy6q5BxQfrMOD1EoM4gMqsA5LietQIyzTDgVVnUlvd9y1XK5z23n9DQfJZy68HciSwCwmpLFovyrTPWgKsG9dgT235a92tsB+tAi5o488Ynocl6fJMY2MaqZqPR3/yWv2FguVTtvg2hfbnFIP9gS9oGchSB92SkEOwnH13K7mf+AzRaGRZZB7cyKh7pCc9RzPtVk4iNgNz+O7AsTXpcR/zWpgODz11MSBZK1JCUNbIP7SwOzVdYUQwpC7pCPjo0LwNqM4oZZoj
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 18:09:30.9272
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a07f364b-217e-4c34-18d6-08de673d34cf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6875

From: Vidya Sagar <vidyas@nvidia.com>

LTR message should be sent as soon as the root port enables LTR in the
endpoint. Set snoop & no snoop LTR timing and LTR message request before
PCIe links up. This ensures that LTR message is sent upstream as soon as
LTR is enabled.

Fixes: c57247f940e8 ("PCI: tegra: Add support for PCIe endpoint mode in Tegra194")
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

 drivers/pci/controller/dwc/pcie-tegra194.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 0f669933b108..9883d14f7f97 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -124,6 +124,7 @@
 
 #define APPL_LTR_MSG_1				0xC4
 #define LTR_MSG_REQ				BIT(15)
+#define LTR_MST_NO_SNOOP_SHIFT			16
 #define LTR_NOSNOOP_MSG_REQ			BIT(31)
 
 #define APPL_LTR_MSG_2				0xC8
@@ -488,15 +489,6 @@ static irqreturn_t tegra_pcie_ep_irq_thread(int irq, void *arg)
 	if (val & PCI_COMMAND_MASTER) {
 		ktime_t timeout;
 
-		/* 110us for both snoop and no-snoop */
-		val = FIELD_PREP(PCI_LTR_VALUE_MASK, 110) |
-		      FIELD_PREP(PCI_LTR_SCALE_MASK, 2) |
-		      LTR_MSG_REQ |
-		      FIELD_PREP(PCI_LTR_NOSNOOP_VALUE, 110) |
-		      FIELD_PREP(PCI_LTR_NOSNOOP_SCALE, 2) |
-		      LTR_NOSNOOP_MSG_REQ;
-		appl_writel(pcie, val, APPL_LTR_MSG_1);
-
 		/* Send LTR upstream */
 		val = appl_readl(pcie, APPL_LTR_MSG_2);
 		val |= APPL_LTR_MSG_2_LTR_MSG_REQ_STATE;
@@ -1799,6 +1791,11 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 	val |= APPL_INTR_EN_L1_0_0_RDLH_LINK_UP_INT_EN;
 	appl_writel(pcie, val, APPL_INTR_EN_L1_0_0);
 
+	/* 110us for both snoop and no-snoop */
+	val = 110 | (2 << PCI_LTR_SCALE_SHIFT) | LTR_MSG_REQ;
+	val |= (val << LTR_MST_NO_SNOOP_SHIFT);
+	appl_writel(pcie, val, APPL_LTR_MSG_1);
+
 	reset_control_deassert(pcie->core_rst);
 
 	/* Perform cleanup that requires refclk and core reset deasserted */
-- 
2.34.1

