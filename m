Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013041.outbound.protection.outlook.com [40.93.196.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9429438642B;
	Tue,  3 Mar 2026 06:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772520991; cv=fail; b=m8MM2JfZxoZP2+ggvRlUQYtLCwJt7w6hMB1TaRTqhqDGy1YuBpuHA56y78k0dGKrnHX2C60in4++c4jG+tYnHbI1c055oUGRBWWZFXO5S0V+cNI6480+o+KCd7toQ1g820VxFmR1eq27wiAuvhoGUEdHE991Y1/nrvDZmnxh7j4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772520991; c=relaxed/simple;
	bh=yozb2VvKWVSFwL8BHHbSLLJgSn572iR0w+YFowhtlFU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RNbOXMZ5BCQ22IK5lWKjUvXcBF4E8oIi1Y9RnFluMvVDWpd26F1up4xVStsQn+FPMmq2VEfOPG+byA4II+IR2arQlfoUtMPtDzQcEed/Uxu4A4IuM9TL3YfMrZ64a6ZNO+DNG/lJ3K/11336MPdsuGmMoOlkTyTjfRqaI8fMceQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B5GrGtFy; arc=fail smtp.client-ip=40.93.196.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B5GrGtFy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZThN34GREUk4Lp3MLzed0i+jGWwMu+ZN4r5+JWNaM3AtHoqymk+lNM6xaKLT3CXKDgOqxgAROi6vuI+VwvGMiQmiiV6U5+c/24oZ1wAqXaBhXtuztndJRqJ7soePSNBM7QZNsmRbEwUYDjvHyPDfPIJfvydLev9q7KxchXGnLmdOO6U8ylZ8YCuYHs7gI16yI2Q0/VXCL5Rs9HInqnWkbmO3bHqOz9Wn18G5WQ6fJ4pwPMNgAKZs7eRnqOiMjPWR2WDmxYLJnBLVYRlk7dnYVAOvDjWkHYHULIBcKdwl+HJ+LFEmLh8lqd2HyImmS3diJUo8niy6GFdmOeyCREWVTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gUMPI6r70u93WUs5yKA/4uyPZ6A8GJ8521cCxlJTn/s=;
 b=aVtLkqzSGnM/NELmaY4LNEx3J1sn99QdHyWlWhA6XTYGT4bg2rGtcVF/Pt/cP9daeWiKC2/TLAr4GVN805wfpLCcvDS82RkhXw5e5cNfXlUyxuYoj6u3JvEYl/2KAl0wlB3Czy8huAh0tJ9dzSR74hb+Lv2dKNjHmJm/6wLQxB+ioXAZv9x8HdMkZqi8c/nz0VJH9vjBije6wqiHdk6eOZasYXxCbr2Y/PpHofyo0HFCT435QCFY5+imeOfDJrHV8GM1LBDEqLP5ioOWHCogpfZiqjv/K5G+2qRsiyoRWitFn3RdGa8ZEkshSxIRH/blHjuKhEd09cXQZnGLy5BRYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gUMPI6r70u93WUs5yKA/4uyPZ6A8GJ8521cCxlJTn/s=;
 b=B5GrGtFyAMfA1s9zB8Au7WikhsbWppyVACadDExlHWjA6FHWOYPes2fdD5ri3XjT0Fb3u8kl6Ah1kODpQlUrsUe6dQjIuPlfKUtWf//V1NxxSQ2PO64MMzKvhaDVunK4QZMC2/FyhCDO2NfoUSqQEkxk64rFpCW8RuTYY2nOkS1JVnvh5iZT7AMTxN78uyk85MzORWNV/yhhjvKRciGRgAuZjCz231fpJ2TLhaFpmWEz67PaPZ9UHLl2Q5CyYYjungKLC30B8MtJyzyzRFKPFYMYreG++6HtIej77+8Eegv+fOqbs4ejK2pKVx1eYzcgXnfkuQlAL5St6g4ZgWjR3g==
Received: from MN2PR22CA0023.namprd22.prod.outlook.com (2603:10b6:208:238::28)
 by SA0PR12MB4384.namprd12.prod.outlook.com (2603:10b6:806:9f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 06:56:26 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:208:238::4) by MN2PR22CA0023.outlook.office365.com
 (2603:10b6:208:238::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.21 via Frontend Transport; Tue,
 3 Mar 2026 06:56:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Tue, 3 Mar 2026 06:56:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 22:56:11 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 2 Mar 2026 22:56:04 -0800
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
Subject: [PATCH v7 08/13] PCI: tegra194: Apply pinctrl settings for both PCIe RP and EP
Date: Tue, 3 Mar 2026 12:24:43 +0530
Message-ID: <20260303065448.2361488-9-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260303065448.2361488-1-mmaddireddy@nvidia.com>
References: <20260303065448.2361488-1-mmaddireddy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|SA0PR12MB4384:EE_
X-MS-Office365-Filtering-Correlation-Id: fc3784eb-031a-4f9f-e625-08de78f1fcdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	/T8MVIX1m1j6DuynPRCOcVvAmD+vBGc39jmnpBJerIEsa2YmrJxiaEmTrWGwq2I8/E/8eJXEhlsbvXXll9d/3A1HPddEBOue/MmeKnPnpRSnm4boLyZJZx5RZmcWDRHf269YBGOZ1pYxyyDGl465AzjXsebVKd2ZDg18IWnnmahKmjGqJMKFBlAJP/SHZYlcXSFJZhUvnygYkFdiRoA3RqKCLT+3JMViPYcJ+ypFhy5fBbTbl5qJOKyqU/kbdnnyxNAOkXydEZwbvv+FQH6MMeqAbs5E5xAiKz+9V0b9C4JZczNQbevE46l5LmciAdGIBS/BIw0Rg6D9nRFv0DiczLKnbE0BcI8pQagq1qJQUptXGl3fn+5WuU0rkzI2sUr3gWRM7untD6KwyA4sVaxfVcE/8ZxRI5kc1W9fX7zJ1gHBMdjH2/ptfK+c2EuxWL4uN432blEJKC7JRF1gnWj71LZu4F86MyqmFVwWpipMT6oevK+TpdIJbJQPEGnLJGoibzchUP2e8ZjwCsNuTGCNWtLrz0Cc0CTprwOeOL91Go8RP3uATLt0a7Ylg/uW8bW1TxvgE7RHpV1KqcrM52XauNPtdJFIE+Z4mROTSlr5o6KQimWxHGbhH6M7mf7+zgl7VO383Lwh1LWJKpD984ppQuDgs/7CZkR2QgGlqYaPfcZrc9WB8xKO8x/U43e5brl9YmlnsZiuSmEeJqYrNquk3IHJWzWvwbTm9vKB7p+5yZDVkTJvvdZaOjEI8agOYH0UElHPajY37Z2cIrgbBp7TwVjbBIkN6CoGv63xf0t3J67ik9NtVRZ7mrqqEOXRh4gwXC4IJPE7+5szWzNMxcD3DZdqGiqFTWv8gDppIDERn5w=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	b8RIpPM8tZ0fP7ZUdG557l68jMn+FwiuUbQne0fHeGfR13mooy1UCS5vfejt+nv9zChSiptcvoo/c8sPmH5dzXGNJN/ZaExa2qFEColSHco+Tzym9EcnDNHWzr4uw3rC+uRDZ0+2D9WNIDMP5X1ZATnII10J+OOJrIQskPm/eA+8ldk18+wgmhEz8b7NTODQ5dRiy9v60uVFz4LnjKVhgTZjyXqmahiylnOoC9Il5qYZEAUi3gLMn+8fNL9VhDt70ayG42BY3zIJly7lj80B4ll5vFZC+0nQ2NNkS7UK7bj18/3oY1USBWO7LPLF/dBHRPLXZbdcnkf4WKaZt4MBUndWB4fSl311v2wmalXruqIuoBQOwlLUaiJ/LbhgdO9GbpLE9kbfMdhme4BCFoOXjv5HV+VazOJB6j5MACcSOm9SzALpCrFa8TxwmUMXSKUf
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 06:56:25.6161
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc3784eb-031a-4f9f-e625-08de78f1fcdb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4384

From: Vidya Sagar <vidyas@nvidia.com>

PERST# and CLKREQ# pinctrl settings should be applied for both Root Port
and Endpoint mode. Move pinctrl_pm_select_default_state() function call
from Root Port specific configuration function to probe().

Fixes: c57247f940e8 ("PCI: tegra: Add support for PCIe endpoint mode in Tegra194")
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
Changes V5 -> V7: None
Changes V4 -> V5: Use dev_err_probe() function
Changes V1 -> V4: None

 drivers/pci/controller/dwc/pcie-tegra194.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index b50229df890e..5b79d3c28ba6 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1598,12 +1598,6 @@ static int tegra_pcie_config_rp(struct tegra_pcie_dw *pcie)
 		goto fail_pm_get_sync;
 	}
 
-	ret = pinctrl_pm_select_default_state(dev);
-	if (ret < 0) {
-		dev_err(dev, "Failed to configure sideband pins: %d\n", ret);
-		goto fail_pm_get_sync;
-	}
-
 	ret = tegra_pcie_init_controller(pcie);
 	if (ret < 0) {
 		dev_err(dev, "Failed to initialize controller: %d\n", ret);
@@ -2077,6 +2071,10 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
 	pp = &pci->pp;
 	pp->num_vectors = MAX_MSI_IRQS;
 
+	ret = pinctrl_pm_select_default_state(dev);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to configure sideband pins: %d\n", ret);
+
 	ret = tegra_pcie_dw_parse_dt(pcie);
 	if (ret < 0) {
 		const char *level = KERN_ERR;
-- 
2.34.1

