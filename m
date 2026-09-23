Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013045.outbound.protection.outlook.com [40.93.196.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433E73FF8B6;
	Wed, 23 Sep 2026 07:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790147980; cv=fail; b=tuksPK0vltuQcrRO4Q/tChktaUDcLPQmgfA/wC/f6xq+x+hSGsslbI+qI/zI2ig5hcpFee25v/MpfkZEgY4SmwPcY/opzn/KncnimQj01TCcJlH06eNzyd4vtEhidBGdymOvwKwelin/HQo0PXtbidTaIROwfFcCjPhcl06rRAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790147980; c=relaxed/simple;
	bh=XJvYALSCFwnfFpnT4pW4dYCHzZs79j2rIUAA2rB4awQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IswKPS1qzknMp9mb7EU7tJJncO5YmE+ztSsC7r5HGb28oaGtO4jAa+s9HS+/Uwhg8A8Xfh+rpRYcyK3xtOZTqRa4oHkHbzyM9ALro2D27AW1zy4hRxf+58z884Dq03/Ftk9FYPyWf9CPQ5NG2LaWjUNWL3FqdnD2G8Hvnn8cnqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dE19ovXo; arc=fail smtp.client-ip=40.93.196.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dE19ovXo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ecJiqhl0r/u9N1cywT/QhR0zQrcdBTA9F1w6oyBWcxjmlr551pMHvHGmtkv/B0ttwSpPyZ1XWK/C+GxCSkefcMuegtI8HWnkQYP8lKSfjJp+uOgs6+SMRKD2CHSBmEpIHMEk1iyY5+/cxkMy+XYhdCp5k6Ak2LJr2PkRkem+OpzfHEeisnn3Dq+JtWLgoT+HifNyBXcM8igm/Y2hmRyG/0snmZkuZTOvQ8u+oC+RrMH0R55c2MrZ4PNXDPc9bMWQ7i0tJIF2A0Oz2CZXj87lWccvNSqwefc1AMqlZ+GhMn6yiwbD9uhBmgXZHggJxuj07KmjMX0KThQg+Fu5EPt71w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=woD4DPMPz4dp3Hc8+pWtnMQSZQjT332zivbqaNDh/f0=;
 b=NRnrMjKMHX0Fx4eN091KMp98G+UEmDSLoX9zzVeDdLBNaJPgdH4ZxobjbdlaWQ2vFf+jYT9hZpZNgqn4bGOlrgANaGVa1q3HWE0U86HxfgoUj+9z5Vdyp8uLbnz1viC5kX1BpRRmQi2GFShT9/el0MtNFZoprB2SLfvvPCHqzIUSn5jsPaCtUkZbCRBmjS1IedpMJNb/pH/xGTV1IesE4+ktJBfC7qGP0Ne+HjJbRhXYkxBCOIIrJIM2va55HuMXm1SZ5v0MoOFXO18RZTtQoPVOJoHXIGZpazZvbADPavCQTYrcVDcTh2wad4lCwN+HMk+6LS5nfYoV3hVDBs06+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=woD4DPMPz4dp3Hc8+pWtnMQSZQjT332zivbqaNDh/f0=;
 b=dE19ovXoA8CNYFVQiWnWwl/Ky4W0RidxZUaJPgIkq727AO/fA04aNSSClTcTnvnmZZgN6RCef2VpUpM+O1EzHOI4ysUOnnAfRiJNUMNDeV7yMRQCAkxArGjPcdDiTnKtgehS9nvNBS8Wr5FQYOoCPLhgBGpUCviGAVBa2nAyAMhXhsE0t3HiYV/WAvdNhCzl6itPqIDAhwd/cCLp56zDulGWNY44VKONZUkZDxA9TUQ6e6Ob5Byq60p8oagweAsFQF/wIzIfcjPdyOQGXsaiUaNFBDBsRafzoDtEvbumJFriq1WwmnB8LjgtQYEeAkSvIeCjAsH0o5Wg9Y/Cf5jFJg==
Received: from BY3PR05CA0025.namprd05.prod.outlook.com (2603:10b6:a03:254::30)
 by DM4PR12MB5747.namprd12.prod.outlook.com (2603:10b6:8:5e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.14; Wed, 23 Sep
 2026 07:19:26 +0000
Received: from SJ5PEPF000001F6.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::8c) by BY3PR05CA0025.outlook.office365.com
 (2603:10b6:a03:254::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.7 via Frontend Transport; Wed, 23
 Sep 2026 07:19:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001F6.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 07:19:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 00:19:07 -0700
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 23 Sep 2026 00:19:02 -0700
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam
	<mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, "Krzysztof
 Wilczynski" <kwilczynski@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>
CC: Rob Herring <robh@kernel.org>, Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>, Vidya Sagar <vidyas@nvidia.com>,
	Niklas Cassel <cassel@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH 2/5] PCI: tegra194: Use FIELD_*() for register fields
Date: Wed, 23 Sep 2026 12:47:03 +0530
Message-ID: <20260923071706.1134320-3-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260923071706.1134320-1-mmaddireddy@nvidia.com>
References: <20260923071706.1134320-1-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F6:EE_|DM4PR12MB5747:EE_
X-MS-Office365-Filtering-Correlation-Id: 56f23d3f-8d1f-4c94-919e-08df19430016
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700016|82310400026|23010399003|3023799007|6133799003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	s645X8EPdxGZl1mXcahHuXCKhNnmXgxs6sFezbSxKlJ53JZ1LrYN7gPl0fkbUaH5dbUnbRC3+fTWOPEKkf9lj/kjKz8v2icSuyifz4hjCKdMGXHdc4suesNNKL/gH1/23DL7OuZWXJ6ifEZdosO0xlS5vxuuEstC/6c4GWsGNp2RpXOJQaPIpc4auJowlqlQ7Yc57H0TaY7ZHkhA08CWTGaAc6mm8NhCu/gM50ThVxXnHmfcnVfYFToJ6AVbWeBHDWavYY4nxlQsqJuKFDhHRz85ltyXROtdikfOwVmaDcs1wDvNSo57TDN/EnhhVHmVqHFLJJ4KUmfq4p29IbxDidnhMIDbqw38n8vLfZfjh/pOhUZniaT1S/u2IFre0ji8QT5I4+EvXgrPqkduWZoANtggBFaxwx7HbLkx2XbvDuS+4Enw099GWfg5RQ82KxLvGpb0lDhpVbNtLIyRz88ZEYcjhdS4lQTcnJx5OnIRILA21yfdaxt5465hIjfpytz6J/nAs4FIOQFfEW+32Gwm85A9NddfofgLUdA578dMPGMGeZx5wSYYVIqUxhJs9uCRi95XyiXMmyYbWEM2TxS8E31AgBHDmD9TjXWtEtFTCz33+C0ME7G2Q9zKNrPgPpsfUb+GWJ52MLrNhscUVG+SE1wsyexpBLUFwb5TpiNbftUFGtz3w12bERQw89p+n7BjPlnEK9I24cnoNQbsooEeRQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700016)(82310400026)(23010399003)(3023799007)(6133799003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	l4TcEK6T0QS7yaQJSyPCHqbXRAVCLTF1RYLS1C5RH7RYZB+BO9YH7T0591GQs/j3zGKWp8WKqMJc3+bedBUc0tNuVHoVe+O0G4lKKBBEgwLUcmLYg4Qh4nkYaSUh1iMm1vWsiuYZuJN0PwAVyzGCfBjVKO0vEJG7tM4VwexIMEc0mNC70YLJpsSAxyDb91bPm7kBKVIpONWovVz3BcmQ74jpfw0hs8a0Ho1LADYWcHuIT08O6tr86Y/ZTwEBO0UacKxtln3odMDptjVSuIhtwzFCYcokRR4/to2GcWssDDSMQ18kLCL7+obSVceIknaEbAJctRGI6kWkt+XNlZ0WH3P8XTZlbbSyNAlthf2WKYVmcX1NHHkOS6CA3KYmX9w9aaDfBc98c858ZjkVYZ4OisPNdgSqD54cmNsP6wDNu6rizykhWkhLMnlZrIMqTzxf
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 07:19:26.3523
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56f23d3f-8d1f-4c94-919e-08df19430016
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5747

Several Tegra194 APPL and DesignWare register fields are programmed
with open-coded shifts, which makes the register programming more
verbose than necessary.

Use FIELD_PREP(), FIELD_MODIFY() and FIELD_GET() at the Tegra call
sites where values are shifted into fields. The LTSSM state constants
are converted from pre-shifted register values to unshifted field
values for FIELD_GET().

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/r/20260515070753.3852840-2-mmaddireddy@nvidia.com
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 145 ++++++++++-----------
 1 file changed, 71 insertions(+), 74 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 63a0f56cad8e..3cfb386dd433 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -50,8 +50,7 @@
 #define APPL_CTRL_SYS_PRE_DET_STATE		BIT(6)
 #define APPL_CTRL_LTSSM_EN			BIT(7)
 #define APPL_CTRL_HW_HOT_RST_EN			BIT(20)
-#define APPL_CTRL_HW_HOT_RST_MODE_MASK		GENMASK(1, 0)
-#define APPL_CTRL_HW_HOT_RST_MODE_SHIFT		22
+#define APPL_CTRL_HW_HOT_RST_MODE_MASK		GENMASK(23, 22)
 #define APPL_CTRL_HW_HOT_RST_MODE_IMDT_RST	0x1
 #define APPL_CTRL_HW_HOT_RST_MODE_IMDT_RST_LTSSM_EN	0x2
 
@@ -136,14 +135,13 @@
 
 #define APPL_DEBUG				0xD0
 #define APPL_DEBUG_PM_LINKST_IN_L2_LAT		BIT(21)
-#define APPL_DEBUG_PM_LINKST_IN_L0		0x11
 #define APPL_DEBUG_LTSSM_STATE_MASK		GENMASK(8, 3)
-#define APPL_DEBUG_LTSSM_STATE_SHIFT		3
-#define LTSSM_STATE_DETECT_QUIET		0x00
-#define LTSSM_STATE_DETECT_ACT			0x08
-#define LTSSM_STATE_PRE_DETECT_QUIET		0x28
-#define LTSSM_STATE_DETECT_WAIT			0x30
-#define LTSSM_STATE_L2_IDLE			0xa8
+#define LTSSM_STATE_DETECT_QUIET		0x0
+#define LTSSM_STATE_DETECT_ACT			0x1
+#define LTSSM_STATE_PRE_DETECT_QUIET		0x5
+#define LTSSM_STATE_DETECT_WAIT			0x6
+#define LTSSM_STATE_L0				0x11
+#define LTSSM_STATE_L2_IDLE			0x15
 
 #define APPL_RADM_STATUS			0xE4
 #define APPL_PM_XMT_TURNOFF_STATE		BIT(0)
@@ -162,7 +160,6 @@
 #define APPL_CFG_MISC				0x110
 #define APPL_CFG_MISC_SLV_EP_MODE		BIT(14)
 #define APPL_CFG_MISC_ARCACHE_MASK		GENMASK(13, 10)
-#define APPL_CFG_MISC_ARCACHE_SHIFT		10
 #define APPL_CFG_MISC_ARCACHE_VAL		3
 
 #define APPL_CFG_SLCG_OVERRIDE			0x114
@@ -178,14 +175,14 @@
 #define CFG_PREF_MEM_LIMIT_BASE_MEM_LIMIT_DECODE	BIT(16)
 
 #define CFG_TIMER_CTRL_MAX_FUNC_NUM_OFF	0x718
-#define CFG_TIMER_CTRL_ACK_NAK_SHIFT	(19)
+#define CFG_TIMER_CTRL_ACK_NAK_MASK		GENMASK(23, 19)
+#define CFG_TIMER_CTRL_ACK_NAK_VAL		1
 
 #define N_FTS_VAL					52
 #define FTS_VAL						52
 
 #define PORT_LOGIC_AMBA_ERROR_RESPONSE_DEFAULT	0x8D0
-#define AMBA_ERROR_RESPONSE_RRS_SHIFT		3
-#define AMBA_ERROR_RESPONSE_RRS_MASK		GENMASK(1, 0)
+#define AMBA_ERROR_RESPONSE_RRS_MASK		GENMASK(4, 3)
 #define AMBA_ERROR_RESPONSE_RRS_OKAY		0
 #define AMBA_ERROR_RESPONSE_RRS_OKAY_FFFFFFFF	1
 #define AMBA_ERROR_RESPONSE_RRS_OKAY_FFFF0001	2
@@ -202,7 +199,6 @@
 #define CAP_SPCIE_CAP_OFF			0x154
 #define CAP_SPCIE_CAP_OFF_DSP_TX_PRESET0_MASK	GENMASK(3, 0)
 #define CAP_SPCIE_CAP_OFF_USP_TX_PRESET0_MASK	GENMASK(11, 8)
-#define CAP_SPCIE_CAP_OFF_USP_TX_PRESET0_SHIFT	8
 
 #define LTSSM_DELAY_US		10000	/* 10 ms */
 #define LTSSM_TIMEOUT_US	120000	/* 120 ms */
@@ -348,8 +344,8 @@ static void apply_bad_link_workaround(struct dw_pcie_rp *pp)
 			dev_warn(pci->dev, "PCIe link is bad, width reduced\n");
 			val = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base +
 						PCI_EXP_LNKCTL2);
-			val &= ~PCI_EXP_LNKCTL2_TLS;
-			val |= PCI_EXP_LNKCTL2_TLS_2_5GT;
+			FIELD_MODIFY(PCI_EXP_LNKCTL2_TLS, &val,
+				     PCI_EXP_LNKCTL2_TLS_2_5GT);
 			dw_pcie_writew_dbi(pci, pcie->pcie_cap_base +
 					   PCI_EXP_LNKCTL2, val);
 
@@ -622,10 +618,9 @@ static inline u32 event_counter_prog(struct tegra_pcie_dw *pcie, u32 event)
 
 	val = dw_pcie_readl_dbi(&pcie->pci, pcie->ras_des_cap +
 				PCIE_RAS_DES_EVENT_COUNTER_CONTROL);
-	val &= ~(EVENT_COUNTER_EVENT_SEL_MASK << EVENT_COUNTER_EVENT_SEL_SHIFT);
-	val |= EVENT_COUNTER_GROUP_5 << EVENT_COUNTER_GROUP_SEL_SHIFT;
-	val |= event << EVENT_COUNTER_EVENT_SEL_SHIFT;
-	val |= EVENT_COUNTER_ENABLE_ALL << EVENT_COUNTER_ENABLE_SHIFT;
+	FIELD_MODIFY(EVENT_COUNTER_EVENT_SEL_FIELD_MASK, &val, event);
+	FIELD_MODIFY(EVENT_COUNTER_GROUP_SEL_MASK, &val, EVENT_COUNTER_GROUP_5);
+	FIELD_MODIFY(EVENT_COUNTER_ENABLE_MASK, &val, EVENT_COUNTER_ENABLE_ALL);
 	dw_pcie_writel_dbi(&pcie->pci, pcie->ras_des_cap +
 			   PCIE_RAS_DES_EVENT_COUNTER_CONTROL, val);
 	val = dw_pcie_readl_dbi(&pcie->pci, pcie->ras_des_cap +
@@ -661,8 +656,8 @@ static int aspm_state_cnt(struct seq_file *s, void *data)
 			   EVENT_COUNTER_ALL_CLEAR);
 
 	/* Re-enable counting */
-	val = EVENT_COUNTER_ENABLE_ALL << EVENT_COUNTER_ENABLE_SHIFT;
-	val |= EVENT_COUNTER_GROUP_5 << EVENT_COUNTER_GROUP_SEL_SHIFT;
+	val = FIELD_PREP(EVENT_COUNTER_ENABLE_MASK, EVENT_COUNTER_ENABLE_ALL);
+	val |= FIELD_PREP(EVENT_COUNTER_GROUP_SEL_MASK, EVENT_COUNTER_GROUP_5);
 	dw_pcie_writel_dbi(&pcie->pci, pcie->ras_des_cap +
 			   PCIE_RAS_DES_EVENT_COUNTER_CONTROL, val);
 
@@ -680,16 +675,15 @@ static void init_host_aspm(struct tegra_pcie_dw *pcie)
 							PCI_EXT_CAP_ID_VNDR);
 
 	/* Enable ASPM counters */
-	val = EVENT_COUNTER_ENABLE_ALL << EVENT_COUNTER_ENABLE_SHIFT;
-	val |= EVENT_COUNTER_GROUP_5 << EVENT_COUNTER_GROUP_SEL_SHIFT;
+	val = FIELD_PREP(EVENT_COUNTER_ENABLE_MASK, EVENT_COUNTER_ENABLE_ALL);
+	val |= FIELD_PREP(EVENT_COUNTER_GROUP_SEL_MASK, EVENT_COUNTER_GROUP_5);
 	dw_pcie_writel_dbi(pci, pcie->ras_des_cap +
 			   PCIE_RAS_DES_EVENT_COUNTER_CONTROL, val);
 
 	/* Program T_cmrt and T_pwr_on values */
 	val = dw_pcie_readl_dbi(pci, l1ss + PCI_L1SS_CAP);
-	val &= ~(PCI_L1SS_CAP_CM_RESTORE_TIME | PCI_L1SS_CAP_P_PWR_ON_VALUE);
-	val |= (pcie->aspm_cmrt << 8);
-	val |= (pcie->aspm_pwr_on_t << 19);
+	FIELD_MODIFY(PCI_L1SS_CAP_CM_RESTORE_TIME, &val, pcie->aspm_cmrt);
+	FIELD_MODIFY(PCI_L1SS_CAP_P_PWR_ON_VALUE, &val, pcie->aspm_pwr_on_t);
 	dw_pcie_writel_dbi(pci, l1ss + PCI_L1SS_CAP, val);
 
 	if (pcie->supports_clkreq)
@@ -714,10 +708,10 @@ static void init_host_aspm(struct tegra_pcie_dw *pcie)
 
 	/* Program L0s and L1 entrance latencies */
 	val = dw_pcie_readl_dbi(pci, PCIE_PORT_AFR);
-	val &= ~PORT_AFR_L0S_ENTRANCE_LAT_MASK;
-	val |= (pcie->aspm_l0s_enter_lat << PORT_AFR_L0S_ENTRANCE_LAT_SHIFT);
-	val &= ~PORT_AFR_L1_ENTRANCE_LAT_MASK;
-	val |= (pcie->aspm_l1_enter_lat << PORT_AFR_L1_ENTRANCE_LAT_SHIFT);
+	FIELD_MODIFY(PORT_AFR_L0S_ENTRANCE_LAT_MASK, &val,
+		     pcie->aspm_l0s_enter_lat);
+	FIELD_MODIFY(PORT_AFR_L1_ENTRANCE_LAT_MASK, &val,
+		     pcie->aspm_l1_enter_lat);
 	val |= PORT_AFR_ENTER_ASPM;
 	dw_pcie_writel_dbi(pci, PCIE_PORT_AFR, val);
 }
@@ -851,22 +845,20 @@ static void config_gen3_gen4_eq_presets(struct tegra_pcie_dw *pcie)
 	/* Program init preset */
 	for (i = 0; i < pcie->num_lanes; i++) {
 		val = dw_pcie_readw_dbi(pci, CAP_SPCIE_CAP_OFF + (i * 2));
-		val &= ~CAP_SPCIE_CAP_OFF_DSP_TX_PRESET0_MASK;
-		val |= GEN3_GEN4_EQ_PRESET_INIT;
-		val &= ~CAP_SPCIE_CAP_OFF_USP_TX_PRESET0_MASK;
-		val |= (GEN3_GEN4_EQ_PRESET_INIT <<
-			   CAP_SPCIE_CAP_OFF_USP_TX_PRESET0_SHIFT);
+		FIELD_MODIFY(CAP_SPCIE_CAP_OFF_DSP_TX_PRESET0_MASK, &val,
+			     GEN3_GEN4_EQ_PRESET_INIT);
+		FIELD_MODIFY(CAP_SPCIE_CAP_OFF_USP_TX_PRESET0_MASK, &val,
+			     GEN3_GEN4_EQ_PRESET_INIT);
 		dw_pcie_writew_dbi(pci, CAP_SPCIE_CAP_OFF + (i * 2), val);
 
 		offset = dw_pcie_find_ext_capability(pci,
 						     PCI_EXT_CAP_ID_PL_16GT) +
 				PCI_PL_16GT_LE_CTRL;
 		val = dw_pcie_readb_dbi(pci, offset + i);
-		val &= ~PCI_PL_16GT_LE_CTRL_DSP_TX_PRESET_MASK;
-		val |= GEN3_GEN4_EQ_PRESET_INIT;
-		val &= ~PCI_PL_16GT_LE_CTRL_USP_TX_PRESET_MASK;
-		val |= (GEN3_GEN4_EQ_PRESET_INIT <<
-			PCI_PL_16GT_LE_CTRL_USP_TX_PRESET_SHIFT);
+		FIELD_MODIFY(PCI_PL_16GT_LE_CTRL_DSP_TX_PRESET_MASK, &val,
+			     GEN3_GEN4_EQ_PRESET_INIT);
+		FIELD_MODIFY(PCI_PL_16GT_LE_CTRL_USP_TX_PRESET_MASK, &val,
+			     GEN3_GEN4_EQ_PRESET_INIT);
 		dw_pcie_writeb_dbi(pci, offset + i, val);
 	}
 
@@ -880,8 +872,7 @@ static void config_gen3_gen4_eq_presets(struct tegra_pcie_dw *pcie)
 	dw_pcie_writel_dbi(pci, GEN3_EQ_CONTROL_OFF, val);
 
 	val = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
-	val &= ~GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK;
-	val |= (0x1 << GEN3_RELATED_OFF_RATE_SHADOW_SEL_SHIFT);
+	FIELD_MODIFY(GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK, &val, 0x1);
 	dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
 
 	val = dw_pcie_readl_dbi(pci, GEN3_EQ_CONTROL_OFF);
@@ -921,9 +912,8 @@ static int tegra_pcie_dw_host_init(struct dw_pcie_rp *pp)
 
 	/* Enable as 0xFFFF0001 response for RRS */
 	val = dw_pcie_readl_dbi(pci, PORT_LOGIC_AMBA_ERROR_RESPONSE_DEFAULT);
-	val &= ~(AMBA_ERROR_RESPONSE_RRS_MASK << AMBA_ERROR_RESPONSE_RRS_SHIFT);
-	val |= (AMBA_ERROR_RESPONSE_RRS_OKAY_FFFF0001 <<
-		AMBA_ERROR_RESPONSE_RRS_SHIFT);
+	FIELD_MODIFY(AMBA_ERROR_RESPONSE_RRS_MASK, &val,
+		     AMBA_ERROR_RESPONSE_RRS_OKAY_FFFF0001);
 	dw_pcie_writel_dbi(pci, PORT_LOGIC_AMBA_ERROR_RESPONSE_DEFAULT, val);
 
 	/* Clear Slot Clock Configuration bit if SRNS configuration */
@@ -947,7 +937,8 @@ static int tegra_pcie_dw_host_init(struct dw_pcie_rp *pp)
 
 	if (pcie->update_fc_fixup) {
 		val = dw_pcie_readl_dbi(pci, CFG_TIMER_CTRL_MAX_FUNC_NUM_OFF);
-		val |= 0x1 << CFG_TIMER_CTRL_ACK_NAK_SHIFT;
+		FIELD_MODIFY(CFG_TIMER_CTRL_ACK_NAK_MASK, &val,
+			     CFG_TIMER_CTRL_ACK_NAK_VAL);
 		dw_pcie_writel_dbi(pci, CFG_TIMER_CTRL_MAX_FUNC_NUM_OFF, val);
 	}
 
@@ -1002,11 +993,10 @@ static int tegra_pcie_dw_start_link(struct dw_pcie *pci)
 		 * link up once again with DLF disabled.
 		 */
 		val = appl_readl(pcie, APPL_DEBUG);
-		val &= APPL_DEBUG_LTSSM_STATE_MASK;
-		val >>= APPL_DEBUG_LTSSM_STATE_SHIFT;
+		val = FIELD_GET(APPL_DEBUG_LTSSM_STATE_MASK, val);
 		tmp = appl_readl(pcie, APPL_LINK_STATUS);
 		tmp &= APPL_LINK_STATUS_RDLH_LINK_UP;
-		if (!(val == 0x11 && !tmp)) {
+		if (!(val == LTSSM_STATE_L0 && !tmp)) {
 			/* Link is down for all good reasons */
 			return 0;
 		}
@@ -1419,10 +1409,8 @@ static int tegra_pcie_config_controller(struct tegra_pcie_dw *pcie,
 	if (en_hw_hot_rst || pcie->of_data->has_sbr_reset_fix) {
 		/* Enable HW_HOT_RST mode */
 		val = appl_readl(pcie, APPL_CTRL);
-		val &= ~(APPL_CTRL_HW_HOT_RST_MODE_MASK <<
-			 APPL_CTRL_HW_HOT_RST_MODE_SHIFT);
-		val |= (APPL_CTRL_HW_HOT_RST_MODE_IMDT_RST_LTSSM_EN <<
-			APPL_CTRL_HW_HOT_RST_MODE_SHIFT);
+		FIELD_MODIFY(APPL_CTRL_HW_HOT_RST_MODE_MASK, &val,
+			     APPL_CTRL_HW_HOT_RST_MODE_IMDT_RST_LTSSM_EN);
 		val |= APPL_CTRL_HW_HOT_RST_EN;
 		appl_writel(pcie, val, APPL_CTRL);
 	}
@@ -1446,7 +1434,8 @@ static int tegra_pcie_config_controller(struct tegra_pcie_dw *pcie,
 	appl_writel(pcie, val | APPL_CTRL_SYS_PRE_DET_STATE, APPL_CTRL);
 
 	val = appl_readl(pcie, APPL_CFG_MISC);
-	val |= (APPL_CFG_MISC_ARCACHE_VAL << APPL_CFG_MISC_ARCACHE_SHIFT);
+	FIELD_MODIFY(APPL_CFG_MISC_ARCACHE_MASK, &val,
+		     APPL_CFG_MISC_ARCACHE_VAL);
 	appl_writel(pcie, val, APPL_CFG_MISC);
 
 	if (pcie->enable_srns || pcie->enable_ext_refclk) {
@@ -1605,10 +1594,14 @@ static void tegra_pcie_dw_pme_turnoff(struct tegra_pcie_dw *pcie)
 		appl_writel(pcie, data, APPL_PINMUX);
 
 		err = readl_poll_timeout(pcie->appl_base + APPL_DEBUG, data,
-			((data & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_DETECT_QUIET) ||
-			((data & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_DETECT_ACT) ||
-			((data & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_PRE_DETECT_QUIET) ||
-			((data & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_DETECT_WAIT),
+			(FIELD_GET(APPL_DEBUG_LTSSM_STATE_MASK, data) ==
+			 LTSSM_STATE_DETECT_QUIET) ||
+			(FIELD_GET(APPL_DEBUG_LTSSM_STATE_MASK, data) ==
+			 LTSSM_STATE_DETECT_ACT) ||
+			(FIELD_GET(APPL_DEBUG_LTSSM_STATE_MASK, data) ==
+			 LTSSM_STATE_PRE_DETECT_QUIET) ||
+			(FIELD_GET(APPL_DEBUG_LTSSM_STATE_MASK, data) ==
+			 LTSSM_STATE_DETECT_WAIT),
 			LTSSM_DELAY_US, LTSSM_TIMEOUT_US);
 		if (err)
 			dev_info(pcie->dev, "LTSSM state: 0x%x detect timeout: %d\n", data, err);
@@ -1694,11 +1687,16 @@ static void pex_ep_event_pex_rst_assert(struct tegra_pcie_dw *pcie)
 		return;
 
 	ret = readl_poll_timeout(pcie->appl_base + APPL_DEBUG, val,
-		((val & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_DETECT_QUIET) ||
-		((val & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_DETECT_ACT) ||
-		((val & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_PRE_DETECT_QUIET) ||
-		((val & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_DETECT_WAIT) ||
-		((val & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_L2_IDLE),
+		(FIELD_GET(APPL_DEBUG_LTSSM_STATE_MASK, val) ==
+		 LTSSM_STATE_DETECT_QUIET) ||
+		(FIELD_GET(APPL_DEBUG_LTSSM_STATE_MASK, val) ==
+		 LTSSM_STATE_DETECT_ACT) ||
+		(FIELD_GET(APPL_DEBUG_LTSSM_STATE_MASK, val) ==
+		 LTSSM_STATE_PRE_DETECT_QUIET) ||
+		(FIELD_GET(APPL_DEBUG_LTSSM_STATE_MASK, val) ==
+		 LTSSM_STATE_DETECT_WAIT) ||
+		(FIELD_GET(APPL_DEBUG_LTSSM_STATE_MASK, val) ==
+		 LTSSM_STATE_L2_IDLE),
 		LTSSM_DELAY_US, LTSSM_TIMEOUT_US);
 	if (ret)
 		dev_info(pcie->dev, "LTSSM state: 0x%x detect timeout: %d\n", val, ret);
@@ -1817,13 +1815,14 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 	val = appl_readl(pcie, APPL_CTRL);
 	val |= APPL_CTRL_SYS_PRE_DET_STATE;
 	val |= APPL_CTRL_HW_HOT_RST_EN;
-	val &= ~(APPL_CTRL_HW_HOT_RST_MODE_MASK << APPL_CTRL_HW_HOT_RST_MODE_SHIFT);
-	val |= (APPL_CTRL_HW_HOT_RST_MODE_IMDT_RST_LTSSM_EN << APPL_CTRL_HW_HOT_RST_MODE_SHIFT);
+	FIELD_MODIFY(APPL_CTRL_HW_HOT_RST_MODE_MASK, &val,
+		     APPL_CTRL_HW_HOT_RST_MODE_IMDT_RST_LTSSM_EN);
 	appl_writel(pcie, val, APPL_CTRL);
 
 	val = appl_readl(pcie, APPL_CFG_MISC);
 	val |= APPL_CFG_MISC_SLV_EP_MODE;
-	val |= (APPL_CFG_MISC_ARCACHE_VAL << APPL_CFG_MISC_ARCACHE_SHIFT);
+	FIELD_MODIFY(APPL_CFG_MISC_ARCACHE_MASK, &val,
+		     APPL_CFG_MISC_ARCACHE_VAL);
 	appl_writel(pcie, val, APPL_CFG_MISC);
 
 	val = appl_readl(pcie, APPL_PINMUX);
@@ -1875,7 +1874,8 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 
 	if (pcie->update_fc_fixup) {
 		val = dw_pcie_readl_dbi(pci, CFG_TIMER_CTRL_MAX_FUNC_NUM_OFF);
-		val |= 0x1 << CFG_TIMER_CTRL_ACK_NAK_SHIFT;
+		FIELD_MODIFY(CFG_TIMER_CTRL_ACK_NAK_MASK, &val,
+			     CFG_TIMER_CTRL_ACK_NAK_VAL);
 		dw_pcie_writel_dbi(pci, CFG_TIMER_CTRL_MAX_FUNC_NUM_OFF, val);
 	}
 
@@ -2390,8 +2390,7 @@ static int tegra_pcie_dw_suspend_late(struct device *dev)
 	/* Enable HW_HOT_RST mode */
 	if (!pcie->of_data->has_sbr_reset_fix) {
 		val = appl_readl(pcie, APPL_CTRL);
-		val &= ~(APPL_CTRL_HW_HOT_RST_MODE_MASK <<
-			 APPL_CTRL_HW_HOT_RST_MODE_SHIFT);
+		FIELD_MODIFY(APPL_CTRL_HW_HOT_RST_MODE_MASK, &val, 0);
 		val |= APPL_CTRL_HW_HOT_RST_EN;
 		appl_writel(pcie, val, APPL_CTRL);
 	}
@@ -2466,10 +2465,8 @@ static int tegra_pcie_dw_resume_early(struct device *dev)
 	/* Disable HW_HOT_RST mode */
 	if (!pcie->of_data->has_sbr_reset_fix) {
 		val = appl_readl(pcie, APPL_CTRL);
-		val &= ~(APPL_CTRL_HW_HOT_RST_MODE_MASK <<
-			 APPL_CTRL_HW_HOT_RST_MODE_SHIFT);
-		val |= APPL_CTRL_HW_HOT_RST_MODE_IMDT_RST <<
-		       APPL_CTRL_HW_HOT_RST_MODE_SHIFT;
+		FIELD_MODIFY(APPL_CTRL_HW_HOT_RST_MODE_MASK, &val,
+			     APPL_CTRL_HW_HOT_RST_MODE_IMDT_RST);
 		val &= ~APPL_CTRL_HW_HOT_RST_EN;
 		appl_writel(pcie, val, APPL_CTRL);
 	}
-- 
2.34.1

