Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010053.outbound.protection.outlook.com [40.93.198.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DBE4570EE;
	Mon,  7 Sep 2026 10:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788778509; cv=fail; b=WBKbSFddY3Y5d4t6I7anciw+nmhU6den5WpEfnJDxJS+cJiyCC2iHogf+FRfmEisJyIyhevGsaKhDkunQefpqTMMWN+eTloLda9yvEBDX+ppcQVDpHACt0nz+f/n03hHz0BG1bF6Mjr6v7Zsczo1M7XYNDQGJyuziBPuIAppb84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788778509; c=relaxed/simple;
	bh=d178z8AtaizPmK5XNv0mOwUnvkOckWpgjbXRcyV5/XY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=udRyyp01DJbdg9AwasqTG8ZJY8PjkH+PDt5ZIayTO9dK445LdlzdCMOAQDKPGRFSdeokFBp1R6gErkdF4XDZvcCgo2Xh/X5xZAgCzmUdobhUP+GN6rETW//Z34rq0U0Jab4qTpMZVW3r5992vT4LMj+0O8a8uZuaoQGkDnjnQE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Bhg2iBLk; arc=fail smtp.client-ip=40.93.198.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Bhg2iBLk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZaX/e4arTPUbBT03vPo11ln5820qWdi21EO/snDNuLke3SS0gmHQo4xqg8co1h5UbsHQ9Ot1KgEAJUWejVYPxdbPGnISdRjnx/pfoP82jGn8tlELYxYxDrb+Mcjsd9PirNBnr6U9tCl5nYOrQ0vaWEtv9wW30oKbcqxCJ3PIwpc3BSkjUNoOnMuNwqwIAQaxHab/v9TvYZchGu5QpRr1NYou2Kt8Uei47w2m4CmivRnlklgsE8or8lIBW56sSuvy1r1dIJIT0LDsSOALUyri2Y6NAGQnJRjg53txmYo+Z0lZDHjSeZvAk8oUgjeP0uB5ASUSa9cJlJCXpuZ8ohgxYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v99L5KKVzAnLh2HQQH3P3sCZ0FsRdzwZfuPujsE+j9M=;
 b=G6E0+ot6LwTd0KQsatAJ/knx8B6WZaNMVJCDZR5oZUWG/v/eFBOKN2g3BG4YJznF/UJGbhgC9APnYaBmQ2niLxLojSik+7ooEtATQavx9sijKdGDo94NXM+w3YaxvHESXG0q5tKvyYwulazO3cccWgqfGuuvyknMj+nwCBBFxcLvt3rR6iXn36McqBMWdXQEon4KgyXQF6vMrMb7mInd93fucnUFhcI8ry387Qsb+Pxh5GUCGwqGfeHxBxORhBHI+o0T2Db93sFOjKwmUOEOnKgGcN0/e+WoRthoHgRAIqU/VdViM4sAu7RVk4yvVw7V8Ykg+r7/jhZSPtKamrZljg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v99L5KKVzAnLh2HQQH3P3sCZ0FsRdzwZfuPujsE+j9M=;
 b=Bhg2iBLkYHBDjZYtggERdc3ZlN4q6dwy4NrkOUAdFBLtQFKDoSQUBmY3+b2Br4dJ27VsQ23PktoQmvn7iEP9e6s1dpmshQM0jsHoA0UplNv0Fmf5FqoKM+xUmE4gmfTfzUB6UqJA2u3PC/V9AnRtzTqGYlrLFXGaOmuxgjcx+yE=
Received: from MW4PR03CA0024.namprd03.prod.outlook.com (2603:10b6:303:8f::29)
 by SA1PR12MB6702.namprd12.prod.outlook.com (2603:10b6:806:252::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 10:55:00 +0000
Received: from MW1PEPF0001615B.namprd21.prod.outlook.com
 (2603:10b6:303:8f:cafe::98) by MW4PR03CA0024.outlook.office365.com
 (2603:10b6:303:8f::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.13 via Frontend Transport; Mon, 7
 Sep 2026 10:55:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MW1PEPF0001615B.mail.protection.outlook.com (10.167.249.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.1 via Frontend Transport; Mon, 7 Sep 2026 10:55:00 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 7 Sep
 2026 05:54:59 -0500
Received: from xhddevverma40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46
 via Frontend Transport; Mon, 7 Sep 2026 05:54:57 -0500
From: Devendra K Verma <devverma@amd.com>
To: <mani@kernel.org>, <vkoul@kernel.org>, <frank.li@kernel.org>,
	<den@valinux.co.jp>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>, <devverma@amd.com>
Subject: [PATCH v1 1/2] dmaengine: dw-edma: Macro order as per reg bit position
Date: Mon, 7 Sep 2026 16:24:52 +0530
Message-ID: <20260907105453.1940646-2-devverma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907105453.1940646-1-devverma@amd.com>
References: <20260907105453.1940646-1-devverma@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615B:EE_|SA1PR12MB6702:EE_
X-MS-Office365-Filtering-Correlation-Id: e19df8a6-301b-4777-fa16-08df0cce76c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700016|82310400026|23010399003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	tpJJixY57KGpdKok517hABrSAd11+yC9j93shVjPHnInGmzc5EC3JN4Flr/UUzyn7Gdjpo+cVx9Vvt2o65IFBy3fp0J6sbl9CQXlnEIR7jE9fHN8cZ6FIezS2Hbc9KPRG6rzgbvHa0+/91VE/77LVnJvKWnH0oEBDwXtfQTf6Zj4MMJnMd6SskY0oksj0qLf11IW357R+g+wjwnULT91RPGvkqfAsh+6FudMMdJoZ9vkexqUzDtEiarjkCXD9Y3uqCxmRYBSuBWKZ2HOMkOLtIQ5eqVLTkP2YA2yUQHKBceeUBp913VzFWE+T+lPK8v80E20zDw/fYwmwBqhsSPNZ/N7eT5KCs3BnAuGUnN7dBg1kQsy5sDlqsQjcwJYGFwa+qtkZVsFZHZJ0g4VjgMgInclTm4gMtPRCFT2PVg0Sp0UR/uTB2BYOw4a5XdnCTPXJUDKf49re4SzGufPSkHmzvy8U6vPjGUL+WQ01QOEhy1TiMP/H0TqP9+LoCd6TG5KX2T/Krwnsicp2h7LtM1jl8s+uXVJAEM/uFPFky1ZDVa4sauzOncWaUoOo5VkbfEhQdKY1ZOfrVZNf7tMbKqMS+azcxC9AGNyqgZEPnhwdXDVC/LoJnxspGsRXYYKo8bqiEmYlTUQYFA3CeJ7J/kcjiS+e5a4G9JxIGImd+nUlmY3x1c0u1cMwILiCJAhE52nGHPHa2ZfA1q79BuEh5/5DQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(23010399003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+9oglyyKz2zmbVc4dLBQ+o4DEUJL62KcqE/Jj6RkdFqGEEFaFGnvwLCPL/iWiQwnR4FEBJ0Fisn5n0j2OhZLamwyt6IoBDAd7vbUbnqnjydEtLziMJBjkmCw8tideYjxTffqQwyvqmDaexJdfg/W39Ihp7W8FyXJOHuydCPSLkla974N/u+biyqSb6lR9mUyolxUKotv5Ju/rkM9ySfjvO3HgxhNX/yWue17Oe5j0qZWJ0K4UWlBfM9IVlyEcwn5LFiEbCjJcEm8sjSdkqe6YkvoLTHyve3LGwwKznPGkPmvpZNOs23JpAhPVp5cGmxmteJzNOYjoyRRU4zLXWCJZfBweKEgbfSwLAmnzz43lHsQ3nIKq0pd8w6Qv5hTFSRapzvDDBhAK7gloCduz9Mk3uK5PTIoJ6f1ne3/SrurcdUMNjmn3Z15GQuRb+9BMa6h
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 10:55:00.4536
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e19df8a6-301b-4777-fa16-08df0cce76c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF0001615B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6702

For a register the macros providing masks for bit ranges.
These macros if placed in order provide good view of the bits.
Placed macros in ascending order.

Signed-off-by: Devendra K Verma <devverma@amd.com>
---
 drivers/dma/dw-edma/dw-edma-pcie.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 9f237ba916de..006dea7d6322 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -31,8 +31,8 @@
 
 #define DW_PCIE_XILINX_MDB_VSEC_DMA_ID		0x6
 #define DW_PCIE_XILINX_MDB_VSEC_ID		0x20
-#define DW_PCIE_XILINX_MDB_VSEC_DMA_BAR		GENMASK(10, 8)
 #define DW_PCIE_XILINX_MDB_VSEC_DMA_MAP		GENMASK(2, 0)
+#define DW_PCIE_XILINX_MDB_VSEC_DMA_BAR		GENMASK(10, 8)
 #define DW_PCIE_XILINX_MDB_VSEC_DMA_WR_CH	GENMASK(9, 0)
 #define DW_PCIE_XILINX_MDB_VSEC_DMA_RD_CH	GENMASK(25, 16)
 
-- 
2.43.0

