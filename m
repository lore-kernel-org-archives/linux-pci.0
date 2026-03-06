Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010013.outbound.protection.outlook.com [52.101.56.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EDE375AAD;
	Fri,  6 Mar 2026 08:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772784060; cv=fail; b=MVj2x8IGoyiacp8izox3M8efGnJe58tKjW5dCIN64yd7b7QFvTrx1rvuCFSWI9pSNuk4QACMRrvosufLF12kEvD91cV15CDinjUkhzrtFIJHwujyfjkJg0YqnBTWR7RYcaNbckVqRZ8N9KfA6vbpYm9/HuP5npFT2XzLO6E8mXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772784060; c=relaxed/simple;
	bh=lBkKjFn4GiGLK66/JrQdEmulYZHAZ4GQZp/oOKkKucA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d4TIr0jLYcyEWag882BtcRhQcwO0clfOZNXsgOYCtgcEVm7uoKAk7j0/0nkOslpMOpIQaaEQTobxJqc//heli7J+vRz4c78BRmt32tpWg1ujodNDycpz8h+4GHqqmzIXu99Tna7neYNXQt0hydwwTmyDcAd/O3SnOembE/dB18k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LYu5JOpN; arc=fail smtp.client-ip=52.101.56.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LYu5JOpN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k4gI+v5ie6SsB3Va7dv05uDfEpNjQtsxhMDLJfCKZ3aSdF20NSywdg7r7gyT1hJHSg3z0nzZp75up/i1oT9FDv+lmMs7tDmViiV8cN5JnwleYKnpdZAhtRGwyvlGhpNYXEybDlg6yHP8/3p9kHVGSkkWX2S9MVwagvoKZiWWEfN3I8RTVKpzqp31+4pwoxLb5sEcszncMVo1OzA+yGd3sT8tbxmrNnidKDWuxSdro04RWpUJ2HxUe/VTmXmFQklyZv/Rqsn1U0y0ZHeUsxjeE5O2Dnv3xmBGTC3CQTFyN9NGHaJiQj+LuLFraD8YIWQrRsQz7ouyKgfOzyi6C4xnbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w+x3K/PfF3v5/csgy1f5eh5Ia4jOjyjmYQOrtggsno8=;
 b=ESA22btfIYKsbSuxKD6tazZ4ci+0PkELkWsd3DQjD3g/ZpSrpRepXa8SeDxQQGWhhO63KWdpX8eGuvZrW5Ya6ekSowiNqtI7qYdIXt0KE3XxtTi6Kkhny4slcSTODi/1dIyXg8nJ8FHlXHUaFnRQizk1NVqX/EPqoKiNNMo/OaHbvfizlJ4w+qCiwOalq8GfI89tMqOVeilO++5TanZErowjoR34iNuAKgAkV6N+Ln/g7libOhBQVH1HWkkDME4a2PAk7QJTcD2NTYGYt22ORrhXyW4DFyXRwPxZJMAcuQWQIDUfnKiVw0QK8a0DPnDlYTGQfglfGncR4HPIWW2IWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+x3K/PfF3v5/csgy1f5eh5Ia4jOjyjmYQOrtggsno8=;
 b=LYu5JOpNak3y2sAl+GfA8Sr106cy/hiMxYLAtvh+Wde8xQzUPPpj6hHZyj7ly1+zg2nJT9IaEvZAEwzKMNpl2AQN6mhZSrqaKvOGpvLW1WAue/rHwyVQ+k9y32BH8wfa2b9FXfFswhM/r6aN7Rbqub7KAdj66EixbYPzsUGM5u6kNlLARlJgtOF26npVMUSq6Iq3te+TRgVVoVLEoiNz11GtvVBP8giipExWA/wETCEwCZo/Wd5CAyXnegB4pN8YStctJrWxhZsk5e8iKCFehieWKcxNvB41V5Oa3uDhlm8353Zbfj9CsaHXbCqq7Xdhjbu19FqR2wFvWvw6Pu6E1Q==
Received: from SJ0PR05CA0204.namprd05.prod.outlook.com (2603:10b6:a03:330::29)
 by DS0PR12MB9399.namprd12.prod.outlook.com (2603:10b6:8:1b8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Fri, 6 Mar
 2026 08:00:52 +0000
Received: from SJ1PEPF00002311.namprd03.prod.outlook.com
 (2603:10b6:a03:330:cafe::5f) by SJ0PR05CA0204.outlook.office365.com
 (2603:10b6:a03:330::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.13 via Frontend Transport; Fri,
 6 Mar 2026 08:00:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00002311.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 08:00:52 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Mar
 2026 00:00:39 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 6 Mar 2026 00:00:38 -0800
Received: from build-smadhavan-noble-20260205.internal (10.127.8.10) by
 mail.nvidia.com (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Fri, 6 Mar 2026 00:00:38 -0800
From: <smadhavan@nvidia.com>
To: <bhelgaas@google.com>, <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
	<jonathan.cameron@huawei.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>, <dave@stgolabs.net>
CC: <alwilliamson@nvidia.com>, <jeshuas@nvidia.com>, <vsethi@nvidia.com>,
	<skancherla@nvidia.com>, <vaslot@nvidia.com>, <sdonthineni@nvidia.com>,
	<mhonap@nvidia.com>, <vidyas@nvidia.com>, <jan@nvidia.com>,
	<mochs@nvidia.com>, <dschumacher@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Srirangan
 Madhavan" <smadhavan@nvidia.com>
Subject: [PATCH 1/5] PCI: Add CXL DVSEC control, lock, and range register definitions
Date: Fri, 6 Mar 2026 08:00:15 +0000
Message-ID: <20260306080026.116789-2-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306080026.116789-1-smadhavan@nvidia.com>
References: <20260306080026.116789-1-smadhavan@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002311:EE_|DS0PR12MB9399:EE_
X-MS-Office365-Filtering-Correlation-Id: d771d6f6-7d70-4262-fd4c-08de7b567cab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700016|1800799024;
X-Microsoft-Antispam-Message-Info:
	956YPpcgfNi/ZY6IMMBjX57RQGoKgyQVpyYEGI2V3VAojDxQZvTYnca+C/dEif8nRHUAWsia4IvsYv0teaBdXTWDFXx7AX8alEicvZxbz2FQvoZwyOoydwnz+8jiltGGIfGztwnuhm3hjALwkjUUUOQOswJJouJpUwCWRzGAsj9XV2AqNMFGpRc7D+RZq2GgFW1zzAjPAPKYuH8g8Zx3vNjtHPUxclW/hw+BL1tb0NY5ItZlaWrQnI7bt1v7NbCPcLREVMLisj1OpGZbRsN94V4rSugytMQAAHEZIpPKXJ+0IuWGOnkzNDxtnpKo7yEAzWIxHi4cPYPmpePqLY7qnNChccQY0vE3xc2T1R5h6EivSE80iUAQqZj+Ab5MHbhCZF66hCJfbzTV6RoJay//IOOGiyyarh0+FFU21CDIoFM5W+Y47ODkhZfFL7YfdrgGF+VXeoMQvI2V2iIbi9vj+/btF44lykEVvrj5RhtDVgn1IqxNPauHi+piJtC6xgiIxbXsoXMB4ZQYf4m/5/DpAL5wXuXp2bOKKTvqvoVyMs6qciMEuRbKVINTrB1tsE/FakX+Uc8HbW//VpRS7yKhnQxvh7ildbU7zcLETH0KmO/k9+8+iFskLAnv8+BxkXeOEL84mHujTyVkKeb5IGT2KvVzJyq4tMRFpyVD9uvG6InubKGMphHFbXnW3fiibZH94CCnGMYx9hn0+Xav6y8XKQeRdANvebOVqwQkVBQB31/zZj11thR6pwC8rjUFv7snxQJMCZMqq7RTiEwwaI9xig==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	cSb/oU658OVaNWIVv+wW57QLk8UmJ3CrHE0iuwyn8jiCz7R94X8j+hVxiFsi9SqgONWwu2+aagqWU+9tukVdL8OI+1IQ2Ddnf/ua3JEI8gSOvvzxqUZGJzZNAvgdEGwdaRRNGVuxo9SthmalT8y1BdbhN9E5cb4NCIDByBq+m4SThoodGbVxvPtRngCfngOIdCaPMUUrvQ2pYSnXSpulTI+v5phudLYACFqrTruMHFa2exm8prc27dNKFckNLrlwBtSJgCrxGTPNOts8FAu5ynlMw1A1i1rT6RKouJprXAzN52018E/7YQWzxVXBhdbj4+gcO1byXlpKoFvqFOn8UD2Qt9ffTupAC6ANpRCpAzX5HV2AGobdU541kqfq04d6LBCyh9ZFQKUUv9fPtc0vELxUQaZM7IfAPtRAEaYtyFlywNNcGxUV4sOCo7WvrVw0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 08:00:52.1972
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d771d6f6-7d70-4262-fd4c-08de7b567cab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002311.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9399

From: Srirangan Madhavan <smadhavan@nvidia.com>

PCI: Add CXL DVSEC control, lock, and range register definitions

Add register offset and field definitions for CXL DVSEC registers needed
by CXL state save/restore across resets:

  - CTRL2 (offset 0x10) and LOCK (offset 0x14) registers
  - CONFIG_LOCK bit in the LOCK register
  - RWL (read-write-when-locked) field masks for CTRL and range base
    registers.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 include/uapi/linux/pci_regs.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index ec1c54b5a310..6fdc20d7f5e6 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1353,14 +1353,20 @@
 #define   PCI_DVSEC_CXL_HDM_COUNT			__GENMASK(5, 4)
 #define  PCI_DVSEC_CXL_CTRL				0xC
 #define   PCI_DVSEC_CXL_MEM_ENABLE			_BITUL(2)
+#define   PCI_DVSEC_CXL_CTRL_RWL			0x5FED
+#define  PCI_DVSEC_CXL_CTRL2				0x10
+#define  PCI_DVSEC_CXL_LOCK				0x14
+#define   PCI_DVSEC_CXL_LOCK_CONFIG			_BITUL(0)
 #define  PCI_DVSEC_CXL_RANGE_SIZE_HIGH(i)		(0x18 + (i * 0x10))
 #define  PCI_DVSEC_CXL_RANGE_SIZE_LOW(i)		(0x1C + (i * 0x10))
 #define   PCI_DVSEC_CXL_MEM_INFO_VALID			_BITUL(0)
 #define   PCI_DVSEC_CXL_MEM_ACTIVE			_BITUL(1)
 #define   PCI_DVSEC_CXL_MEM_SIZE_LOW			__GENMASK(31, 28)
 #define  PCI_DVSEC_CXL_RANGE_BASE_HIGH(i)		(0x20 + (i * 0x10))
+#define   PCI_DVSEC_CXL_RANGE_BASE_HI_RWL		0xFFFFFFFF
 #define  PCI_DVSEC_CXL_RANGE_BASE_LOW(i)		(0x24 + (i * 0x10))
 #define   PCI_DVSEC_CXL_MEM_BASE_LOW			__GENMASK(31, 28)
+#define   PCI_DVSEC_CXL_RANGE_BASE_LO_RWL		0xF0000000
 
 #define CXL_DVSEC_RANGE_MAX				2
 
-- 
2.43.0

