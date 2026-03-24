Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010061.outbound.protection.outlook.com [52.101.46.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FFE392822;
	Tue, 24 Mar 2026 19:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774379344; cv=fail; b=noes+doY6WpQWSsblbsvaMoc2swi2lUbViwl4i2vpoWJKMp7c0lL14D0KArLsXrvqyRK/SnBjs4inMj6mC5D0xkqXwowF8XpedI+CS6Jl3qgoYDos+PyLD0AgLjvQJ3t7By94gXOdBtXzgHVCQf4IsXHUZrAXog3WcW4gthnNbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774379344; c=relaxed/simple;
	bh=mqW9p4zntFjERsT1o3WiN6i1waivgdaOxfa8NEtwUs0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IWMn++H9nH2pY5iuSFXfV9loVThy7pQ2To02icJk+AxYVoxKp4OnzXzsG8yAkBIWplrBDxn1y9XOlbvGoMvgHSAsRWWzb4KtUVLJRIXvvtwcYodSMFRF6GpZGv84OwS1HSOe2RHaBcF9D8r1u9khKnCv31h+7d+G0zn1tJSDp5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fNyBwN9y; arc=fail smtp.client-ip=52.101.46.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fNyBwN9y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wP5w14Bbovhz4v56rPhSF+v1CmafMhrXU5DGXat6S0dEWbl22VcRUN30NhXlk+7tS7U5tdG/MHfT/Pa8N0M5isHYf9D/EFxCjuOFikDDdGZB5/tSpGRK47/KHIUrLvsFek/kIDRAyW7F+R+9d6US1Jd/iOm4B80A6b+UtiOIqwAMCZ1YpyOY3aVBzw7IO3yvh3LBws7kHJWDUGr5DF9mzjbKj62vduwn8feoXLyQ84iLIANwlN1eYVfXHDeszwo0cL6kLdKZerkueOXptDp51K79cHHCC7B/9Z1SLVmHmdG6x0detCP8PbsKgAIqIr40c5uKZC08QtmLcVWiX+hZRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n7fuvcWsqIB5s+WQwbx+qUvXE0+TwQieMkVCFXZomkw=;
 b=H/T71NZrCbQ1GMGnCQuSBYHBz9gsMQNPjKp7btMXRR7yB0yjSZBQ32zaylJx9ZHR76Jrv9lUM/0EIiI9xyqw7G+XGHMChIO8YI+CQfc2/qZGSyT4dCVszN6RP7QTqGdGetEa1Ay/haBS3kEM3f79OYssuN2IIL2yvvY0LVXn7oJtd6BLK7TzO7gO56pO4DqlpmUvubKClIOB/mWOA9Ojh848TuDMj4wUROD/X1sYLQXVjWo7Rg3LiospaKUz/WVfbLZqGS11mE8kf95IUfDJsOYRW8cbhXzj0hiNR5iaN+EHuYmWlnDCSK3DxN4fTqOzZQ4rR4l+HgjnmvhvwB3nFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7fuvcWsqIB5s+WQwbx+qUvXE0+TwQieMkVCFXZomkw=;
 b=fNyBwN9yrE3oEYpU5EJqrswJ5RUfg2XsAOiYtpWTAZySKpR34iInqu07pw4MN/r9x1ZxuWeZ69PNgLe5ftdr2/CICh1KOOvBZUx2QwN4Sj3wXnyPjxV9dAgU7pILblUicP1xh/bi36wdHNKd+QrziYgCy52szSAjWYh9kTTa6WFPQw/sAMk+KvJz+G1Pp5NvovbqnL0Lwbl/Simzz/r+uhX+ENJUViFYgB6RKWbLsPgNQuc3uJBKUq9hMPF/HVb+uj69Nq8rojXX3Y87COY77N0CZpHI33szmlyUiuDweDv1c4HGTP0wzLDQw9wWXsAEE74bScnx+f+BD9aCoOXxqA==
Received: from BN0PR02CA0038.namprd02.prod.outlook.com (2603:10b6:408:e5::13)
 by DS0PR12MB7970.namprd12.prod.outlook.com (2603:10b6:8:149::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 19:08:55 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:408:e5:cafe::ab) by BN0PR02CA0038.outlook.office365.com
 (2603:10b6:408:e5::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 19:08:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 19:08:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 12:08:34 -0700
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 24 Mar 2026 12:08:27 -0700
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
Subject: [PATCH v8 03/14] PCI: tegra194: Disable LTSSM after transition to detect on surprise down
Date: Wed, 25 Mar 2026 00:37:44 +0530
Message-ID: <20260324190755.1094879-4-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|DS0PR12MB7970:EE_
X-MS-Office365-Filtering-Correlation-Id: 40f384e8-7d99-4f4b-eb90-08de89d8cb81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700016|82310400026|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	NDIIzynz88ZM9R6BrXQgxwOcl67PIkBnfG/SdgYx7Tsk9n9d3S4krrl0fem7n+uV8wAeWme+2Nv4Lb+5SRJG0D0mET1YKSK3gVCqItuwl13A7qCkBBvUjxWfPjJ4ommGnFiQkgmiV0nzf1wwenMqqOLfQkS33I9nQdvTy7jyJmEIRgWgZM5fXE6fpGlmgbjGHd5QVReFFGFWBEhopx+YQOwkTapkALO3lvEHpOenbsmfanX89Mx9lm75NDZqHXf7m+dRO8jBb9wO90d3BQl22vUfbnl2cldUquQD6czSZcJOPrmHONsqhc4vh8bAB4oFB5ww6TF1S7J1yjrS78GjUvl8JyxFR2jWx12sLjNGaeNXtZuT0dRhc/mmgx/D4jz232oGzyAVgvMd00BAwt/yDP9WBwjgqD+c9uYfhgcUAWoZXAo7rlAZLkyBqMKcvi8owGuDwslILlo8QvxO8dZVC71gD9RTxe/qP8HtY52TSYtkEfSMfxQBuagoG2m9ZjakUxjPDGBQ6ykbXat/PlovVOCCDR+xJZGP+XRv9Eh+wQGp0Dsss008iIwOoqIoFlKer6oNKvNUo8NHuzLWbDAlW43OQqvkxakjxrzYzYJKiN5Kr33z12f0lj0HdwIuzl93iT/YK8DgdkJ59HVZOBZ5dZpxVJLZUMo0HPrdXEBcU/nTHBLTTlExFCuU+YBl4RtrdtLlYcDLoec4LfCoVz40AMcKFs8/se+hEKcs/3Za6SMKeaIx24Yz/dQ+eESl5dW7KOLYFxgzL3dvk8Uru3h8siV6Pti9qB1VwWOOPBIpmbB0wKl7GAzUnDNWvKgVWoSh
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700016)(82310400026)(921020)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wwFpWaXiMtCLflWT0xxV2vaAY+nsNJDGrAF7YYhY71lp89zjhDKmJHASkte59DsgmDO8MDYkBatM0t+IMTzaqjDZJt5DPg7XYFKBNq2xYG/tQNvaSH0cBbLTyX8p9MiOpdhuFH9CRgSXB3hsbG1Ffe5dUQ916XzCW4wGqaD65RqkIXc2VGRt/RxcVTgr+VT0Yq3rQJ6fhdO7EzqX/XDxjzbo8BCJbqX2cfhzhvQOAZVKKZf43TeDVguN+DjsSjmtP+xQ6tL+lkjtG+EjHK76lExpbX3dcdi+fbwNiwWXNnH6mCpPQQelipP+KpwXD5JMgMIOc3m8sgg/OfeN93h3gBH4UPBqAehvulaF0Kpx0p2OfpP4sIuKbnTFKLqldqGtxmcK4qO64XtYSlEwm8EU1x9DBKkXEVlvzd8zpQ1tMFHqDB3tFp4TEM54RVYEWf+q
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 19:08:55.1519
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40f384e8-7d99-4f4b-eb90-08de89d8cb81
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7970

After the link reaches a detect-related LTSSM state, disable LTSSM so it does
not keep toggling between polling and detect. Do this by polling for the
detect state first, then clearing APPL_CTRL_LTSSM_EN in both
tegra_pcie_dw_pme_turnoff() and pex_ep_event_pex_rst_assert().

Fixes: 56e15a238d92 ("PCI: tegra: Add Tegra194 PCIe support")
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
Changes V8: Split into two patches

 drivers/pci/controller/dwc/pcie-tegra194.c | 29 ++++++++++++----------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 5b243c006562..baee73438638 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1594,14 +1594,6 @@ static void tegra_pcie_dw_pme_turnoff(struct tegra_pcie_dw *pcie)
 		data &= ~APPL_PINMUX_PEX_RST;
 		appl_writel(pcie, data, APPL_PINMUX);
 
-		/*
-		 * Some cards do not go to detect state even after de-asserting
-		 * PERST#. So, de-assert LTSSM to bring link to detect state.
-		 */
-		data = readl(pcie->appl_base + APPL_CTRL);
-		data &= ~APPL_CTRL_LTSSM_EN;
-		writel(data, pcie->appl_base + APPL_CTRL);
-
 		err = readl_poll_timeout(pcie->appl_base + APPL_DEBUG, data,
 			((data & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_DETECT_QUIET) ||
 			((data & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_DETECT_ACT) ||
@@ -1610,6 +1602,14 @@ static void tegra_pcie_dw_pme_turnoff(struct tegra_pcie_dw *pcie)
 			LTSSM_DELAY_US, LTSSM_TIMEOUT_US);
 		if (err)
 			dev_info(pcie->dev, "LTSSM state: 0x%x detect timeout: %d\n", data, err);
+
+		/*
+		 * Deassert LTSSM state to stop the state toggling between
+		 * polling and detect.
+		 */
+		data = readl(pcie->appl_base + APPL_CTRL);
+		data &= ~APPL_CTRL_LTSSM_EN;
+		writel(data, pcie->appl_base + APPL_CTRL);
 	}
 	/*
 	 * DBI registers may not be accessible after this as PLL-E would be
@@ -1683,11 +1683,6 @@ static void pex_ep_event_pex_rst_assert(struct tegra_pcie_dw *pcie)
 	if (pcie->ep_state == EP_STATE_DISABLED)
 		return;
 
-	/* Disable LTSSM */
-	val = appl_readl(pcie, APPL_CTRL);
-	val &= ~APPL_CTRL_LTSSM_EN;
-	appl_writel(pcie, val, APPL_CTRL);
-
 	ret = readl_poll_timeout(pcie->appl_base + APPL_DEBUG, val,
 		((val & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_DETECT_QUIET) ||
 		((val & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_DETECT_ACT) ||
@@ -1698,6 +1693,14 @@ static void pex_ep_event_pex_rst_assert(struct tegra_pcie_dw *pcie)
 	if (ret)
 		dev_info(pcie->dev, "LTSSM state: 0x%x detect timeout: %d\n", val, ret);
 
+	/*
+	 * Deassert LTSSM state to stop the state toggling between
+	 * polling and detect.
+	 */
+	val = appl_readl(pcie, APPL_CTRL);
+	val &= ~APPL_CTRL_LTSSM_EN;
+	appl_writel(pcie, val, APPL_CTRL);
+
 	reset_control_assert(pcie->core_rst);
 
 	tegra_pcie_disable_phy(pcie);
-- 
2.34.1

