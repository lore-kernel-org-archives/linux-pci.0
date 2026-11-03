Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.70
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793730863;
	b=YFJX4E6W3CJu8QPH1ZfKRtxnMvP7jnLnuhvU+oJXX7uCpfReZLJoGITE0SUyspuETmH4
	 Ncmip8HOz3pmpaIEjmntEp3eBRRGUyWlk8azsxz3CU4WcRwbfjCQ+88+CYNOg8vd1/xiS
	 0bf7PJTMQCZLAaoqP2Z1muuwBAzKNwwPaoe2jveoRa9F73zWCSNAwFl+KAK/wv7Kg7nJm
	 olKF6WCY2NvQCA4gqVsoNrd65Kdei1vjA/J1nP4+8qv8C+2wmVYMUK0kZFNG0ItUBhxgF
	 WXcxTuZ0NNnjJj7XnOcdTzl23T3D0Y9KPagWkHuIuXXGyqVdyquehtyqWCngpIAnscw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793730863;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-NV-OnPremToCloud:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=nLVk5x4GhjiNv/8jIYdZ3iWZJVV7J/YxeHfQkRxAcKg=;
	b=3v3UKVRkUZzreyMg9w4r6H1/lMOje//sVZmrVwyHsQ14WnIQHI7ZGJBs0hyrOPqhVBbC
	 t5XvyMqYE4BuBaTy1RymOiLT6rse5JY8TBva/ZVSlqJaWZHSspbrkczglwmqnYVmUATnj
	 JSBusgS8xeEWvd48h/Jn427t4m8G/fnq6hLkLUA81jAWdyOKxFzcT401yj/MSFKEaW6pW
	 NNarLRc2ro4f8u5FC8ACYMyeLhvYuTe/ouv9VOfYxEXxNE5n0Eqkcfdv3EQWVgzdy6jzP
	 oClDHP0imx1Yuf9g15doRcsFY4IXv+5wVDMnaDrQ8aNsksRfS6MjiL4RJVgRTwOL87A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="ak1Kh/KY";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.70
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011070.outbound.protection.outlook.com [52.101.57.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E59C606A32C;
	Tue,  3 Nov 2026 18:34:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E59C606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ak1Kh/KY
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JdhzuSRVHnFxzIDzNuZwrUmmup5ohkKw5imJSyatTtdf5hp9JCmJfI/GidFL6MRrzBUDNCqKHCcMSo1wcITDC4RXFP9JSyePMs09yNMqMRqLi3Z0zw+sgh9pFzb0VakniZrDUFWu3aegNj89YitKYX5ufESL7CybnFqvYV4mzan2JYKF1OfnjzxNvIsPImpiZ3UyTAHTmAtxR1YolwRSdyh6h0oaEZnWdaMMS0WrYKNB2EVIsmEr+xbbh/Z3nXXRJWyQk7i8n8orRE9lqh+NJdiIQIMpByiVQBUGZh7wAcW+nG05pedn8pzeETo1TJfO4Hr9bDZvVhHVALXYi8a/UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nLVk5x4GhjiNv/8jIYdZ3iWZJVV7J/YxeHfQkRxAcKg=;
 b=j3AxKj1c/oYqKlTBP41a5+/v1AI05Iaf7MdiLivIUAbCUAZ2Z6MdFn+hsbGvMx1jWXXO0izmsJUa26ZFhMnnvLOVgw3SrtrHAwdx8aweDi9V8NewTSjRRf4jxoddLK/jUHJ473724USnvarB1Vhg0BfBVCJzP8nE+79+DbTk8xQ6Gm523rN/xpUqVZQS2MDt/tFpOazw7DS16eEe7nxaPwC/1656yjP5DKfXIVf6LazxM5HSDAcOpxjhiprFSJAq2x3Axclfqj+/nmSEIZ7oDLqBvO0DC6w/64gNM+wWEfOjLft70omSuTosLyul1Bn85zK+Glk/EMuYa4cYsYXoNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nLVk5x4GhjiNv/8jIYdZ3iWZJVV7J/YxeHfQkRxAcKg=;
 b=ak1Kh/KY88JY6MwrqImVryijUjqL0lYdY8VKssyekhqBaj6jQ7UAdPjgCoOBwnGHRaRHxvOt6pgRX7i+k/x6JzamdndylabzfksiaXYijC8qETBiJFOt0RLmoIuD89k6z8Hp1P1+7wMWdnJsTfUz4Al8SbQg/4hS6uZwZqXSraroE1I2W/s5XEc6u1rpzVAB/EP+RLOLIjNhe9HJiV6Ra1JOaIib1yDDH9e17gsIui2zPaQtd4k6r1B8WIXpwn/h2rIhwHDDC9/3HB6+xWJX6ucwgOuuKVUf1cihpGIs4SdkhmzpV0FxinjHRmD4e8EfWwhvjDjTeVZB48jx/P2RLA==
Received: from CY8PR02CA0008.namprd02.prod.outlook.com (2603:10b6:930:4d::14)
 by CHAPR12MB999249.namprd12.prod.outlook.com (2603:10b6:610:300::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 18:34:17 +0000
Received: from CY8PEPF00000051.namprd05.prod.outlook.com
 (2603:10b6:930:4d:cafe::73) by CY8PR02CA0008.outlook.office365.com
 (2603:10b6:930:4d::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Tue, 3
 Nov 2026 18:34:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY8PEPF00000051.mail.protection.outlook.com (10.167.247.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 18:34:16 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 3 Nov
 2026 10:33:54 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 3 Nov
 2026 10:33:54 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Tue, 3 Nov 2026 10:33:53 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>, <joro@8bytes.org>, Bjorn Helgaas
	<bhelgaas@google.com>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	<rafael@kernel.org>, Len Brown <lenb@kernel.org>, Joerg Roedel
	<joerg.roedel@amd.com>, Kevin Tian <kevin.tian@intel.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Dan
 Williams" <djbw@kernel.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH v1 3/5] iommu: Convert gdev->blocked from bool to enum blocked_reason
Date: Tue, 3 Nov 2026 10:33:44 -0800
Message-ID: <f60d229c210e30a814528bc402b211d32c8a68f2.1793729707.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793729707.git.nicolinc@nvidia.com>
References: <cover.1793729707.git.nicolinc@nvidia.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PEPF00000051:EE_|CHAPR12MB999249:EE_
X-MS-Office365-Filtering-Correlation-Id: 854d2d0f-1320-4c39-9841-08df39d91138
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014|23010399003|7416014|18002099003|10067099003|261102123227099003|22082099003|261022105027099003|56012099006|261021121427099003|261026121527099003|261021135927099003|261026140227099003|261022075727099003|11063799006|261028144727099003|261009223027099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	pNhYnizEMdc1cHxDeUF+AP+aQ0bgphi9ikTDeHJJ2II37CuVO/eTxt8DFunFko1EOQCOhxK+TvVD/u+omQ+esGLUmivyxKyBI8CAIq/fMx54NJGRY1AwUvgnarBKuHD7NDCGlHFo15GfjF8EgZ4oBv+uI2apDMsBALl4GdOK5OgIDzQnh7BestOqSmRdd3Rnqz6tRBUOFY/RyiP61CVMkq4okeyMQONAPl90GdCxBsSh4hS9i9AG0V8xf/zOCbJs4lrMgI8mymuzWJ6zW/HrOOm+ikRfhW6KtKv9ai+7xo6Zn9tToHH9g9jmliL8fbNNwc7orm94aknHuaOC7DHHOuMPGHGeB4VAKK6/mKg+7eXR0Z+1T9XiJyoUjW0KRLRz91WR5AEUqFs4QMMeiJgP31MgJWfFbORZEfNnF5BDgT8+SEt4b1d2u+v42PC2QU9qgtbp+wIlQVS+unLuyFZuF3/zcaoCSEQ5gPL3Mrt23fYrYm+onQ11RZpY2Ax5EhlrOk6sxJSZ/918BScAorhOp9KVSNXKNeRdUjZWg7xnjZKLPWoVPLBuziFMZhEU4FknCg99nfNNprc8XyMgP7zyMuFDp5XoSNGbpLFwrdeioRh44oQ4siUFhEAxsjXxSlWJDZjfiU6i1PtWLSsAyLzfDTVC4oaGZ5a0d2k5CdMjwlyoPrnyFBqf3m03PLJExb2631T3aNj+scjCJwtYhGEKKA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(23010399003)(7416014)(18002099003)(10067099003)(261102123227099003)(22082099003)(261022105027099003)(56012099006)(261021121427099003)(261026121527099003)(261021135927099003)(261026140227099003)(261022075727099003)(11063799006)(261028144727099003)(261009223027099003)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Im22yX8NhgprNKugghBWmZHmzTyglWowef8EmoEFn6XuSInt9rsnyuC0q3hY9ZJ1U2/CWaSRIpXrJYc79W3oCFoS5ZK0RjYZOxxeI0EOlUFcSfs4wwWIZL2pfG+qxCSEVxPlRVv1iivOB74AGKmjY/mYoRSccZAPzDHdHnKFyRWquHBXRajQU0/4mmHkgXKFsFlom5ZvUXZozzdC4zVb4d+Br4xBaYGBlHm/Pf36QFGvYmXCzxiKCpgbl1JdgGj4z2kuJLZjXFUDAlFYq776FnWIc+E27rjt7k3dtHorXN7VIL4DFgL92sen4RVlNXJ193H35nE51Ho7WTnnl+KRtISasTt+I5cljQnrMYFZ/IZvjXHdLN58MgXmFlHQNthSIqnhBtNUfiQoMhwnjLnaAwRMR1Ssb0AK9IxcNxYUryF6aJ3luixK53xJSo9Ayb+K
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 18:34:16.8448
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 854d2d0f-1320-4c39-9841-08df39d91138
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY8PEPF00000051.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR12MB999249

The gdev->blocked flag tracks whether a device is individually being held
in the group->blocking_domain while group->domain is retained. Up to now,
a PCI reset in flight is the only producer, so a bool suffices.

Subsequent changes will add more reasons to keep a device blocked, e.g. a
failed-reset case that must not auto-unblock, or a driver-side quarantine
for a hardware fault. These reasons are cleared by different events, which
a single bool cannot encode.

Convert the "bool blocked" into "enum blocked_reason blocked", provisioned
with two initial values: BLOCKED_NONE and BLOCKED_RESETTING, covering the
existing use cases. All readers keep the "if (gdev->blocked)" form, since
BLOCKED_NONE == 0.

This is a pure type change with no behavior change. Follow-on changes will
add new enum values along with their producers.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommu.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index b486b8bbd1fcd..ee026f5f14349 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -73,16 +73,20 @@ struct iommu_group {
 	void *owner;
 };
 
+enum blocked_reason {
+	BLOCKED_NONE = 0, /* Not blocked */
+	BLOCKED_RESETTING, /* PCI reset in flight */
+};
+
 struct group_device {
 	struct list_head list;
 	struct device *dev;
 	char *name;
 	/*
 	 * Device is blocked for a pending recovery while its group->domain is
-	 * retained. This can happen when:
-	 *  - Device is undergoing a reset
+	 * retained.
 	 */
-	bool blocked;
+	enum blocked_reason blocked;
 	unsigned int reset_depth;
 };
 
@@ -4072,7 +4076,7 @@ int pci_dev_reset_iommu_prepare(struct pci_dev *pdev)
 	 * the correct domain in iommu_driver_get_domain_for_dev() that might be
 	 * called in a set_dev_pasid callback function.
 	 */
-	gdev->blocked = true;
+	gdev->blocked = BLOCKED_RESETTING;
 
 	/*
 	 * Stage PASID domains at blocking_domain while retaining pasid_array.
@@ -4198,7 +4202,7 @@ void pci_dev_reset_iommu_done(struct pci_dev *pdev)
 	 * the correct domain in iommu_driver_get_domain_for_dev() that might be
 	 * called in a set_dev_pasid callback function.
 	 */
-	gdev->blocked = false;
+	gdev->blocked = BLOCKED_NONE;
 
 	/*
 	 * Re-attach PASID domains back to the domains retained in pasid_array.
-- 
2.43.0

