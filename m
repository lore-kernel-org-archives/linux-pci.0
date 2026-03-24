Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011062.outbound.protection.outlook.com [52.101.57.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3C13A3805;
	Tue, 24 Mar 2026 19:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774379329; cv=fail; b=BPoJM2dpn+I0fN8N0BxVf1f8beedGvQtbaqFwHgk3RTKSBXHsKmc9FDMUS2SI2L53Ve9zPQc0RwLJK+hunE/FC++/tS1iTGC7yAnZRyYb3ECPXOc0/oYCatTzGnf9LOGamswMIr10/7JznlioPh38Oqlwv4K37gOeZ+AMtpqJag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774379329; c=relaxed/simple;
	bh=0IvHflus+xzZVRUfw54gGL+ekSB1aS2ytOK/ihW7tLo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ipddmBrt+Qd2Wd6g42+C2UjjWsKSPRVfibp/71fy9gKWV7b7cGANrKT9SbfHGhUVsy743vpX2NB8o5JhQ6vUIHGhQc1oEMbgu89k4xjKnooedNxD/4Whg46hqLQMNKQAiVJvGwogXRduqMROfGr68sLL87wik/HIiyFHAxYHeTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DeW+VwBg; arc=fail smtp.client-ip=52.101.57.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DeW+VwBg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C23VZFZRfVx9Mpp/UcL+52iyWTH+v1H/Bv9qdbsc6DeDjsamEkXYG0GjzSXMwYakDvXw/nLmqodDV+ytT1fLHVZukIqjXYWi1f7ieize64KN2qaU6f1fM+9+Ap6WD+1x3Vmc5J1z2jTsNqV8CAdQ5ucDXPDc1zDaO2KjFBYKhPPMKFRv6u+kuI3BSbewhzh5XrzW+w6tVWu8fJ5UHOd1bAb1iJLihsG15NLKKJbe4byp57aSOyCYr9x5OusxGMyOotMZv/+Vh2WRR5ePTjJlXprhzBs2DHNisnm0WKkNzmTqpREm5RmuScAlbGxvDVvZhnFUmZrjRK69Qhz4PbGAFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NEX7P8bMTwQP3Opv/2iGc/ZjaWOFhF69nPKaNfpD9ic=;
 b=B7SpOeKoaWK3MLr2tXEBQN5KIe9AKn3mfHfgjlPpJNI9vvNOqFFgglr02shy6PMLV/Yacze+A9E7tyeBnkSFjYDaKRsEp7tXsEKKzBzZKWHepQdNdPC3w/I4Gqrh6J4nBwEsdbsFaKAh58mume3b/cWMs6NgXcIB7Jqku7kXASjVBmrSKYuBITDpEUyxwlvbKcCgedW6tt+GJPiGHLgl/a93R7Bs31/D6DGZCzcXEvCAwlYEFuXbIUX12pf4Ocr0EeX2aFBIUW6B+JCCBUYuoEzfWmPoFJpUIsH2qzeGx3PCTl1oTdI1ghb8sTp5ieTyO3bKhyK4Au6bptM4v29pCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NEX7P8bMTwQP3Opv/2iGc/ZjaWOFhF69nPKaNfpD9ic=;
 b=DeW+VwBgNO42tjqcWo1BjSZfmTLTdGg5H/FGtZgg9oeERAnFxEz7nOTZf8/nY21PW2If3UkW8Kl8e23vc3IuAOpHUWBsGNG6wmZd96JVe1Z3a/rC1PVomWmzIjjEPd/ce09EMG+pYfep4Zvw2bgquUKgMADV6DvX2p6qiuBuZTCAmiXSRUT5/D6v67IzFSwKcC/owssmzuz4PVIw8FrM7AooRl5942JMBvqP+ixU0y9FnIDdZWikh4eJqk/JGj094Qio3UAADJTnaWi6skzr6LWQu30lZI93tRl167f+WpTVv1E0zCNJT227yiVqX3DsVDdbOTkybi8rE1gpoCT7cw==
Received: from BY3PR05CA0049.namprd05.prod.outlook.com (2603:10b6:a03:39b::24)
 by SA1PR12MB5616.namprd12.prod.outlook.com (2603:10b6:806:22a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 19:08:41 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:a03:39b:cafe::d0) by BY3PR05CA0049.outlook.office365.com
 (2603:10b6:a03:39b::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 19:08:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 19:08:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 12:08:21 -0700
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 24 Mar 2026 12:08:15 -0700
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
Subject: [PATCH v8 01/14] PCI: tegra194: Fix polling delay for L2 state
Date: Wed, 25 Mar 2026 00:37:42 +0530
Message-ID: <20260324190755.1094879-2-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|SA1PR12MB5616:EE_
X-MS-Office365-Filtering-Correlation-Id: 4282516a-f3c9-4513-83ac-08de89d8c331
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|82310400026|376014|36860700016|921020|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	4otOCOQiUaAc/kuVjbEhjjfwXGAztJadXURNadSsJhix6+4lTUTWSl38oqlEAzdTv0zTubb/aHcJWmjXm262RqZh+IoTkL60rjD5mIzi3+Eh45PBEv9PdzAoIlIQ1OSx2dmzM3a0tB7RsYdU+tQJX8O/295PGzImNGDpAtLEMdl/Sc7HB1AofJTw0AHuijBYQGXbk8PaONudH4G2CxmDKXkv584PKNGgfu782SXi+mdjXpSF7T1J5jhDlaWVZfJkJc3UW1ca56i11Knm5U34k4ZEtGrJnG1ZspLf3iUfTO4i5UYBehC626wUn/V5AapbgC+103dtATKj3pKfRVtckOE9U2EFHd4/7PnzAtG0nhvY1QI8NPc4SxJQ/EjH3QiUyTBp/MQQrlMRMMz4JF5RSFof9TY8Yhd4mEH1BhIeiAsqsmxkoO9gA9S7m/KoHdP7M/qWMpLerSzVqXm2dBp1T2CzjsSuba3CYjDHRc4IfH6sNVx1z0RgwSHlhoe+87nv2li6XsLGH1evTgJ1BCgMS7d+OkLlOS/oFLMT+OJsJDmRIGpulbCu3ZRNh4N8e5705xxk9X0o24J3y2RdKToOOu+N9v1QG8AOP97XAhXi3aKcyB8FK85bOb6zfkUr8vIaiigeR2hHp3mKxDhS5P/TB9X2YKm4ftRb6ocAKS4IdGgabq4eqGpAhgBo4qWnYLQ/1Yu7BOuCNhOufIIKzE3lNKrpFGxs/ZgFFs2nGTTAmVT9LAC2MMMT4vaZG05SrXQ2JbFNFmOakF0MiJ/TWON0WNd+eWwSIESj8IIk0JvQbcy5usgDHb/1GKB52y4r6guc
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(82310400026)(376014)(36860700016)(921020)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/Apvqvv6aU5cNi13V5Qyu4n3w70oatXylXK2foZzXpb/plpY815SGwtN24I3fpvjmsrZeWmJj7ll52usdqkHENkW01qBVW2NZBIXQVMJya/d8xq2wisYrXFnC5QSs85fisplQw1KR6QRuBGqgMUDWDjsTszwKZELwu5ddEKu7ROlh/AsBBhwI8VU0nPPMpZDOUS/N7f+GdmfkNm7IKS8EsGD2ywi2aCXPN/Ck1fT7T2ZxckX8pApgj+vhsx8RHdHt2f97keDDi7MLxeMyxq6nDGYRVzI7ZfmnE+MVcWxPUaiWUfdd3c0DcI49heags27fM6LyWi8Cdn2J0AxK/DfkYzKhHQsgo5eTO/qgzghvi8dN3eANAJ8KyUJOUWkG4pvaHssUo2II9nkHSROYmGQ2CWFhwhCO522u4pgmhQFjyhNXCPBL4ViYi5q4qrY5TQN
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 19:08:41.3585
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4282516a-f3c9-4513-83ac-08de89d8c331
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5616

From: Vidya Sagar <vidyas@nvidia.com>

As per PCIe spec r7.0, sec 5.3.3.2.1, after sending PME_Turn_Off message,
Root Port should wait for 1~10 msec for PME_TO_Ack message. Currently,
driver is polling for 10 msec with 1 usec delay which is aggressive.
Use existing macro PCIE_PME_TO_L2_TIMEOUT_US to poll for 10 msec with
1 msec delay. Since this function is used in non-atomic context only,
use non-atomic poll function.

Fixes: 56e15a238d92 ("PCI: tegra: Add Tegra194 PCIe support")
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
Changes V8: None
Changes V6 -> V7: Use PCIE_PME_TO_L2_TIMEOUT_US instead PME_ACK_TIMEOUT
Changes V1 -> V6: None

 drivers/pci/controller/dwc/pcie-tegra194.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 0ddeef70726d..d6c6bd512b51 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -198,8 +198,6 @@
 #define CAP_SPCIE_CAP_OFF_USP_TX_PRESET0_MASK	GENMASK(11, 8)
 #define CAP_SPCIE_CAP_OFF_USP_TX_PRESET0_SHIFT	8
 
-#define PME_ACK_TIMEOUT 10000
-
 #define LTSSM_TIMEOUT 50000	/* 50ms */
 
 #define GEN3_GEN4_EQ_PRESET_INIT	5
@@ -1553,9 +1551,10 @@ static int tegra_pcie_try_link_l2(struct tegra_pcie_dw *pcie)
 	val |= APPL_PM_XMT_TURNOFF_STATE;
 	appl_writel(pcie, val, APPL_RADM_STATUS);
 
-	return readl_poll_timeout_atomic(pcie->appl_base + APPL_DEBUG, val,
-				 val & APPL_DEBUG_PM_LINKST_IN_L2_LAT,
-				 1, PME_ACK_TIMEOUT);
+	return readl_poll_timeout(pcie->appl_base + APPL_DEBUG, val,
+				  val & APPL_DEBUG_PM_LINKST_IN_L2_LAT,
+				  PCIE_PME_TO_L2_TIMEOUT_US/10,
+				  PCIE_PME_TO_L2_TIMEOUT_US);
 }
 
 static void tegra_pcie_dw_pme_turnoff(struct tegra_pcie_dw *pcie)
-- 
2.34.1

