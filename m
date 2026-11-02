Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793611405;
	b=3RwlQL7opZpxsFRorTXZHFay5DUaiLgAk/WNEbMuEXiPqAcfQSIBdiZT1zVbIaRBFNyf
	 ZTGQ7RO5p2bN+3XUwYiqFLHmfEwcd8gJiOrHg/c4nqkWZfF6YGDMpVV4iVRK0MZgSBH8/
	 9UkX3FQQ5uXcUtW9A0Mfs3sSlTIlx4tGn6Rc6kwLLtb0cNFfLRFSixH1tVQvxOeAzpBtq
	 FuiUV141ya/sjtfetzvvAbY0G/OxINHrhV9v4Qp8b59iW/kxw4VUkB/1xvwYDX34r3yWO
	 A0B1D5uzGCEiQgxNXQcI0Z99xRkyBePKeaEJ75zQ0UTD/ReFvTutRUH4WKiWWEeaxsg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793611405;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=skQyDu+sU0ii7k3Tb3V/8tNtoytzs413vfB/+iFfi6c=;
	b=TjfStfv1J4VP2nfLsdgfMBCx0Ds8j/zCdC1hrG10m7mBZJXyPxjKzH8Nzq6WRf+/qMgo
	 NU4aFt3E33LXsiS3h/qy3HFDshdn1aUMmeraHGzglD15fVKF/z0nWer4c2WScNPZ7x/zZ
	 NGkZ5XokgNuETadvDLycS4g5qW4OZBJEOZwE/8N+99dblawCkZdQR7rsBpKqQWUo4kBBl
	 I2ellGOF3kargE1ZGrDw5LQYxB50cq9hquwuqOdQZPACMdqLiVX/ZVJj4Z5edj56AQFkG
	 /rWZvIDxZicX2Aov3bvZy8dcUaUeUzTVdcntHIwC8f5M9mHzUXd7qfZPYd8T5P7IckQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=lT3dWqUs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.54
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010054.outbound.protection.outlook.com [52.101.201.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E280606A331;
	Mon,  2 Nov 2026 09:23:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E280606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=lT3dWqUs
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hyRVWWbKK8FZhSRBeIwoy6lbc7zdK9zTfODywPg0yI6AYEbnzjJOvjBNZqzYp39XzG9DLdkmi8cqrCyc5U6rYuykwEn9Mzt15KUC4ZNRQ89IwZmSWk5tTZVyIAW0t/Np0+Yg0QSSvwHWi3EEmFVoxp8qaNpzZapxU93XOB78KyIX+6lN/5sXm0uzkPl+h3eRKMCN81MGZqV7zMmrDpme7YKR0x268ro+xekV0YYD7gQXyAA5ieiv4li9lEobgFS4X33/q5e6k8E3EOO+78CLdpvQyg/SVfED3hTiJwpuxwoDmi2H3AsEQQ50FIo/K/LVfV6I4okH+npYI6aRoSN7RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=skQyDu+sU0ii7k3Tb3V/8tNtoytzs413vfB/+iFfi6c=;
 b=Aq0c6mkzTNf9l1GjZURkWGtYPJ2Qrd8Vey57ZavIw5D7LBobYqRX3jusFITQHlCRM2FDlexTS82N82cRvckiT+HmUHkMCkbDBaNWz1Wf0FvwFwXizWOse0RsUKPVrFIGLKwZbaeob+VoTl6TvDitqO6FxLv8ksiDSSUjL7LhHbNOnaW+lUN+4mMc4W+pbPghueNKklbAHfAFoAUXottPYPHxBkX7seRHJozOH17aYM/xP84477baQyW1v5ywF6C5V2VVB1KBT/M5wROPwe24aHFiozwcKj+2w2zyutYLmx9XU+Hi2mgx+Cvs4XKh49L6u+bxKXijM+eF0+sbxyDsuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=skQyDu+sU0ii7k3Tb3V/8tNtoytzs413vfB/+iFfi6c=;
 b=lT3dWqUsg48BOPXIoLaMR1QR88WDvq4eK0NPqH1YnyL7bhIfE/xWxeuPeSUyER3R53aWIwec5UysvlL1zXuG0EIs1nK49AiBL3QdjR/UU3btODgSdTdVc23x7JqR0uHt4EJ3Z1ZYxlKjCZFA28s8p0lI+8/QJOYITI0E1nvIySGtGarRlK23rj1PHTn+x6caFK4CtaZYwW6a4IprafnIlYjweqF/8VwLZRcpIjQSjsx5Xj8//TyOWV291c2YfIoGzLYgnPbnnebOEGW7n367zTb0ak2YIAWidhDIeMQoENPSdthtFQj0iPmidz2CGl9FybjKS3V6Exw4seek9xiR+Q==
Received: from SJ0PR13CA0112.namprd13.prod.outlook.com (2603:10b6:a03:2c5::27)
 by IA1PR12MB7591.namprd12.prod.outlook.com (2603:10b6:208:429::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 09:23:19 +0000
Received: from SJ1PEPF000037A1.namprd04.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::af) by SJ0PR13CA0112.outlook.office365.com
 (2603:10b6:a03:2c5::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Mon, 2
 Nov 2026 09:23:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000037A1.mail.protection.outlook.com (10.167.244.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Mon, 2 Nov 2026 09:23:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 2 Nov
 2026 01:23:02 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 01:22:58 -0800
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <jingoohan1@gmail.com>, <mani@kernel.org>, <lpieralisi@kernel.org>,
	<kwilczynski@kernel.org>, <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: <robh@kernel.org>, <thierry.reding@kernel.org>, <jonathanh@nvidia.com>,
	<vidyas@nvidia.com>, <cassel@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <mmaddireddy@nvidia.com>
Subject: [PATCH v3 1/2] PCI: tegra194: Use FIELD_*() for register fields
Date: Mon, 2 Nov 2026 14:52:37 +0530
Message-ID: <20261102092238.3917883-2-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261102092238.3917883-1-mmaddireddy@nvidia.com>
References: <20261102092238.3917883-1-mmaddireddy@nvidia.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A1:EE_|IA1PR12MB7591:EE_
X-MS-Office365-Filtering-Correlation-Id: 32fa8101-2ffc-4fc8-6a35-08df38c2eeb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|82310400026|1800799024|23010399003|3023799007|6133799003|10067099003|18002099003|22082099003|56012099006|11063799006|261021123027099003|261021121427099003|261026121527099003|261022105027099003|261026140227099003|261022075727099003|261009223027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info:
	xiZaoj2GZwEFk0BdH4pgrfMA4zoVDJWuPM74gexVPaC4Wh2mveHkJpneOPotaPycS9HgZr54jPxBz9HJVFzfl+mVYG459g4EG31p1//3Ekqx5HvroCSfbxKFHzU+RSUR2ORzAypvpjjwe3R40+65ESwTrFrbAuZo30r2aS5PmHppfxB5fb99QkjD1Mvwasl+t1pri6OVgklK/aug/C0UHsit6/TjkxWWK1V7pw512z/BPNqd4Kt6rb/wj3Z0WhfyV1bv0oQW6LaRHrZHy+Yk7qk/cG9QnTpI6StbGM930AVmpHGmkm/Ls1mXemvZw6kQ0WjxHsN80VZz+kZdCxllsqKPtHMrHGhXPJtzzVAMCFV5b4sTIbHvZ7GotDLGKxcxk2s/X7Dd5uRUR0e3cai5AFJwMKWFkla0B1qWUK2Xw1HEKkfMZrLZHq5C93poNyTZWeWNsWyxEtTVdIj7wAaQFR5p5VdfeqtTIxkibhc6uSoj08/x1oL7FdoADV1PC0XalHIL0ACAmmWFQ94k/6BblKb4mPrYxgfnbG+o+eajqs4T8r9KTO/3U2Eg5ZIoFAOX6/TRgIccsUa85gQv3O52aSHLFNUjs4IPdzuDo2qzu0a00x+vDrkLQn3PTBpsKwksxTaSpb9WqehfNfwftPM+mCGx5BpFuOHyiJz3qPjplaJ8MSBIE8zK1cQIUadkACOiDmKZ/7bEasQoAZJ0Y+5bDQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(82310400026)(1800799024)(23010399003)(3023799007)(6133799003)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006)(261021123027099003)(261021121427099003)(261026121527099003)(261022105027099003)(261026140227099003)(261022075727099003)(261009223027099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tobFf4Iio4D8yxGS/YJTo4bPORwsOoHYaAv8gavKE65J3BiQvZy4GbkOwv8fB3xU0yHV+dL+gPfFB69EXq8M93UeaKYpBW931dT21XMQu3NUenKi8p/UDxKtNBWBhHee5Dqoscj2s0nbyTT2uxnJm0sCpTfWfRvT+G4KlWL8C39FBFWgroyLq2s2MWUh20tDuEdVaL9YLRsBL/7U96C4sRFjvRbbNskrjil47kStHZo1FQOeyQ4hwGc5/WWZ/7Y5yrGo/tQa/Sp1lnLVMMUxi39taPyZO6qhhpQt/abhRflFCKa992WvhbUkP8oGSbSPDwtf9t8OO0SBoKarBXVVueQJb7NRMiQ1CzRo36EB9YsZp9iV8Wh1WKDHPe0LsAHTVD/Y0ACv0tO5Xpk/2XVk8YNpwQywV4Z0gNC5VdvSFIQWyv3sMfAiMELW83GAau2g
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 09:23:18.9308
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32fa8101-2ffc-4fc8-6a35-08df38c2eeb7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037A1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7591

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
 drivers/pci/controller/dwc/pcie-tegra194.c | 137 ++++++++++-----------
 1 file changed, 67 insertions(+), 70 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 26e2ac5c5869..62bbfcefe6fe 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -51,8 +51,7 @@
 #define APPL_CTRL_SYS_PRE_DET_STATE		BIT(6)
 #define APPL_CTRL_LTSSM_EN			BIT(7)
 #define APPL_CTRL_HW_HOT_RST_EN			BIT(20)
-#define APPL_CTRL_HW_HOT_RST_MODE_MASK		GENMASK(1, 0)
-#define APPL_CTRL_HW_HOT_RST_MODE_SHIFT		22
+#define APPL_CTRL_HW_HOT_RST_MODE_MASK		GENMASK(23, 22)
 #define APPL_CTRL_HW_HOT_RST_MODE_IMDT_RST	0x1
 #define APPL_CTRL_HW_HOT_RST_MODE_IMDT_RST_LTSSM_EN	0x2
 
@@ -137,14 +136,13 @@
 
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
@@ -163,7 +161,6 @@
 #define APPL_CFG_MISC				0x110
 #define APPL_CFG_MISC_SLV_EP_MODE		BIT(14)
 #define APPL_CFG_MISC_ARCACHE_MASK		GENMASK(13, 10)
-#define APPL_CFG_MISC_ARCACHE_SHIFT		10
 #define APPL_CFG_MISC_ARCACHE_VAL		3
 
 #define APPL_CFG_SLCG_OVERRIDE			0x114
@@ -179,14 +176,14 @@
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
@@ -203,7 +200,6 @@
 #define CAP_SPCIE_CAP_OFF			0x154
 #define CAP_SPCIE_CAP_OFF_DSP_TX_PRESET0_MASK	GENMASK(3, 0)
 #define CAP_SPCIE_CAP_OFF_USP_TX_PRESET0_MASK	GENMASK(11, 8)
-#define CAP_SPCIE_CAP_OFF_USP_TX_PRESET0_SHIFT	8
 
 #define LTSSM_DELAY_US		10000	/* 10 ms */
 #define LTSSM_TIMEOUT_US	120000	/* 120 ms */
@@ -349,8 +345,8 @@ static void apply_bad_link_workaround(struct dw_pcie_rp *pp)
 			dev_warn(pci->dev, "PCIe link is bad, width reduced\n");
 			val = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base +
 						PCI_EXP_LNKCTL2);
-			val &= ~PCI_EXP_LNKCTL2_TLS;
-			val |= PCI_EXP_LNKCTL2_TLS_2_5GT;
+			FIELD_MODIFY(PCI_EXP_LNKCTL2_TLS, &val,
+				     PCI_EXP_LNKCTL2_TLS_2_5GT);
 			dw_pcie_writew_dbi(pci, pcie->pcie_cap_base +
 					   PCI_EXP_LNKCTL2, val);
 
@@ -623,10 +619,9 @@ static inline u32 event_counter_prog(struct tegra_pcie_dw *pcie, u32 event)
 
 	val = dw_pcie_readl_dbi(&pcie->pci, pcie->ras_des_cap +
 				RAS_DES_EVENT_COUNTER_CONTROL);
-	val &= ~EVENT_COUNTER_EVENT_SEL_MASK;
-	val |= FIELD_PREP(EVENT_COUNTER_GROUP_SEL_MASK, EVENT_COUNTER_GROUP_5);
-	val |= FIELD_PREP(EVENT_COUNTER_EVENT_SEL_MASK, event);
-	val |= FIELD_PREP(EVENT_COUNTER_ENABLE_MASK, EVENT_COUNTER_ENABLE_ALL);
+	FIELD_MODIFY(EVENT_COUNTER_EVENT_SEL_MASK, &val, event);
+	FIELD_MODIFY(EVENT_COUNTER_GROUP_SEL_MASK, &val, EVENT_COUNTER_GROUP_5);
+	FIELD_MODIFY(EVENT_COUNTER_ENABLE_MASK, &val, EVENT_COUNTER_ENABLE_ALL);
 	dw_pcie_writel_dbi(&pcie->pci, pcie->ras_des_cap +
 			   RAS_DES_EVENT_COUNTER_CONTROL, val);
 	val = dw_pcie_readl_dbi(&pcie->pci, pcie->ras_des_cap +
@@ -688,9 +683,8 @@ static void init_host_aspm(struct tegra_pcie_dw *pcie)
 
 	/* Program T_cmrt and T_pwr_on values */
 	val = dw_pcie_readl_dbi(pci, l1ss + PCI_L1SS_CAP);
-	val &= ~(PCI_L1SS_CAP_CM_RESTORE_TIME | PCI_L1SS_CAP_P_PWR_ON_VALUE);
-	val |= (pcie->aspm_cmrt << 8);
-	val |= (pcie->aspm_pwr_on_t << 19);
+	FIELD_MODIFY(PCI_L1SS_CAP_CM_RESTORE_TIME, &val, pcie->aspm_cmrt);
+	FIELD_MODIFY(PCI_L1SS_CAP_P_PWR_ON_VALUE, &val, pcie->aspm_pwr_on_t);
 	dw_pcie_writel_dbi(pci, l1ss + PCI_L1SS_CAP, val);
 
 	if (pcie->supports_clkreq)
@@ -715,10 +709,10 @@ static void init_host_aspm(struct tegra_pcie_dw *pcie)
 
 	/* Program L0s and L1 entrance latencies */
 	val = dw_pcie_readl_dbi(pci, PORT_AFAC);
-	val &= ~PORT_AFAC_L0S_ELM;
-	val |= FIELD_PREP(PORT_AFAC_L0S_ELM, pcie->aspm_l0s_enter_lat);
-	val &= ~PORT_AFAC_L1_ELM;
-	val |= FIELD_PREP(PORT_AFAC_L1_ELM, pcie->aspm_l1_enter_lat);
+	FIELD_MODIFY(PORT_AFAC_L0S_ELM, &val,
+		     pcie->aspm_l0s_enter_lat);
+	FIELD_MODIFY(PORT_AFAC_L1_ELM, &val,
+		     pcie->aspm_l1_enter_lat);
 	val |= PORT_AFAC_ENTER_ASPM;
 	dw_pcie_writel_dbi(pci, PORT_AFAC, val);
 }
@@ -852,22 +846,20 @@ static void config_gen3_gen4_eq_presets(struct tegra_pcie_dw *pcie)
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
 
@@ -881,8 +873,7 @@ static void config_gen3_gen4_eq_presets(struct tegra_pcie_dw *pcie)
 	dw_pcie_writel_dbi(pci, GEN3_EQ_CTRL, val);
 
 	val = dw_pcie_readl_dbi(pci, GEN3_CTRL);
-	val &= ~GEN3_CTRL_RATE_SHADOW_SEL_MASK;
-	val |= FIELD_PREP(GEN3_CTRL_RATE_SHADOW_SEL_MASK, 0x1);
+	FIELD_MODIFY(GEN3_CTRL_RATE_SHADOW_SEL_MASK, &val, 0x1);
 	dw_pcie_writel_dbi(pci, GEN3_CTRL, val);
 
 	val = dw_pcie_readl_dbi(pci, GEN3_EQ_CTRL);
@@ -922,9 +913,8 @@ static int tegra_pcie_dw_host_init(struct dw_pcie_rp *pp)
 
 	/* Enable as 0xFFFF0001 response for RRS */
 	val = dw_pcie_readl_dbi(pci, PORT_LOGIC_AMBA_ERROR_RESPONSE_DEFAULT);
-	val &= ~(AMBA_ERROR_RESPONSE_RRS_MASK << AMBA_ERROR_RESPONSE_RRS_SHIFT);
-	val |= (AMBA_ERROR_RESPONSE_RRS_OKAY_FFFF0001 <<
-		AMBA_ERROR_RESPONSE_RRS_SHIFT);
+	FIELD_MODIFY(AMBA_ERROR_RESPONSE_RRS_MASK, &val,
+		     AMBA_ERROR_RESPONSE_RRS_OKAY_FFFF0001);
 	dw_pcie_writel_dbi(pci, PORT_LOGIC_AMBA_ERROR_RESPONSE_DEFAULT, val);
 
 	/* Clear Slot Clock Configuration bit if SRNS configuration */
@@ -948,7 +938,8 @@ static int tegra_pcie_dw_host_init(struct dw_pcie_rp *pp)
 
 	if (pcie->update_fc_fixup) {
 		val = dw_pcie_readl_dbi(pci, CFG_TIMER_CTRL_MAX_FUNC_NUM_OFF);
-		val |= 0x1 << CFG_TIMER_CTRL_ACK_NAK_SHIFT;
+		FIELD_MODIFY(CFG_TIMER_CTRL_ACK_NAK_MASK, &val,
+			     CFG_TIMER_CTRL_ACK_NAK_VAL);
 		dw_pcie_writel_dbi(pci, CFG_TIMER_CTRL_MAX_FUNC_NUM_OFF, val);
 	}
 
@@ -1003,11 +994,10 @@ static int tegra_pcie_dw_start_link(struct dw_pcie *pci)
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
@@ -1420,10 +1410,8 @@ static int tegra_pcie_config_controller(struct tegra_pcie_dw *pcie,
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
@@ -1447,7 +1435,8 @@ static int tegra_pcie_config_controller(struct tegra_pcie_dw *pcie,
 	appl_writel(pcie, val | APPL_CTRL_SYS_PRE_DET_STATE, APPL_CTRL);
 
 	val = appl_readl(pcie, APPL_CFG_MISC);
-	val |= (APPL_CFG_MISC_ARCACHE_VAL << APPL_CFG_MISC_ARCACHE_SHIFT);
+	FIELD_MODIFY(APPL_CFG_MISC_ARCACHE_MASK, &val,
+		     APPL_CFG_MISC_ARCACHE_VAL);
 	appl_writel(pcie, val, APPL_CFG_MISC);
 
 	if (pcie->enable_srns || pcie->enable_ext_refclk) {
@@ -1606,10 +1595,14 @@ static void tegra_pcie_dw_pme_turnoff(struct tegra_pcie_dw *pcie)
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
@@ -1695,11 +1688,16 @@ static void pex_ep_event_pex_rst_assert(struct tegra_pcie_dw *pcie)
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
@@ -1818,13 +1816,14 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
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
@@ -1876,7 +1875,8 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 
 	if (pcie->update_fc_fixup) {
 		val = dw_pcie_readl_dbi(pci, CFG_TIMER_CTRL_MAX_FUNC_NUM_OFF);
-		val |= 0x1 << CFG_TIMER_CTRL_ACK_NAK_SHIFT;
+		FIELD_MODIFY(CFG_TIMER_CTRL_ACK_NAK_MASK, &val,
+			     CFG_TIMER_CTRL_ACK_NAK_VAL);
 		dw_pcie_writel_dbi(pci, CFG_TIMER_CTRL_MAX_FUNC_NUM_OFF, val);
 	}
 
@@ -2391,8 +2391,7 @@ static int tegra_pcie_dw_suspend_late(struct device *dev)
 	/* Enable HW_HOT_RST mode */
 	if (!pcie->of_data->has_sbr_reset_fix) {
 		val = appl_readl(pcie, APPL_CTRL);
-		val &= ~(APPL_CTRL_HW_HOT_RST_MODE_MASK <<
-			 APPL_CTRL_HW_HOT_RST_MODE_SHIFT);
+		FIELD_MODIFY(APPL_CTRL_HW_HOT_RST_MODE_MASK, &val, 0);
 		val |= APPL_CTRL_HW_HOT_RST_EN;
 		appl_writel(pcie, val, APPL_CTRL);
 	}
@@ -2467,10 +2466,8 @@ static int tegra_pcie_dw_resume_early(struct device *dev)
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

