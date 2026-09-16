Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011060.outbound.protection.outlook.com [52.101.52.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660204D7D45;
	Wed, 16 Sep 2026 18:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789583893; cv=fail; b=K87e1mVhx9DS3BpAdag/S2vZ6M8zupxa1h2k+lpcPP8QU1Qvpyh/NVlzxRj4mc+UssrwInUxbBrbG7C9cM3zGXqMC6VBNbaaZJgS9hMv+EeNEnPS6t4+pZNjWFB9DDYW69inLwC9SkV+G81NVEpmw8gd/kqgHmy6j5WETYgpYHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789583893; c=relaxed/simple;
	bh=5U6zR9eCkaJd6vvZGDSGE7n5UThuK3nFJEns7TqNRKs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A4NGnmrOky55elzEJ1SxV2xUT4bHr37zeo51gIpbcWqEpGXVWPTvXOezzj/UcIPGKlquCNQ5juJ4ii1EfFKBILXVMY3aiypRTtHQJ1Oz/UYyzTxR+Srfs0eAyfpyF5WUXI4bOuRs7w0n2HwQnF0MuEIRn/Xf01UaUifVAvNy4Ko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BGaqfKYH; arc=fail smtp.client-ip=52.101.52.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BGaqfKYH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WPEAkKzqklvfXiddcRXhIXoegVDDBIzgKskhcKchNB0QPU3kLQ7JE5UqV5G/Ct3Xsf8u8n/5aAjwkgbaccRQYU83+bYMce92fimFz7imEe/nHKrY1vqq1w+j46YI0weMMOG0GjK4sPNX8r1VaCHr7nvon80fQ4FQvH+sf4Qa/bUPVPmLjAu47dNhqR5rtemh/sXQ5KOlyRbV+StVOGU/vd7lPvbFxnAs+kiIzdpM9SlzgB4XyJWm/xIB2HRhN14bAl2unXOyEtsKNoT+Bsao7d209SLPFCZMhPX/oR8lNP3i7tb3sIWhhbnb0rd+1DM90sXzvKND0jbhhjlz1XtFzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5rl1QuaAVjixslIHCwPbWuqyHzLns70pRJjntQXp7Hc=;
 b=aNnFlAZu0xvSyLfoNnkfpJo8WUC6rJqs08iZLeUbi/u1jFfK2zopsB/BhexVrZg2SSSL4drxHFyV6rFYx73qHYD+6dCKcxAV8ldRSTbw8ofOm2k7f4nxPohLPy+RbtVrQCDVs/whA0JZjTz7oPuOC1DnL6tMK4u5RrkpPqLe8p/z4uIcRQVO/0G+XDzoaOubtX2uhV7e1noNIW6OxXC58MLlc3kS7pUGcW8bNu+sTw8CiIuDMxNbAxJRtE/oyR9KKStPdgGD/tIG884dO/Hr55L3RaHf81pIwGseWBZJiqoh5sYZ1xTmrt8/Or61TwkHa6+UlGR0xcKBpVOlFZHkXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5rl1QuaAVjixslIHCwPbWuqyHzLns70pRJjntQXp7Hc=;
 b=BGaqfKYHD0ysEXHJSt7QLLx4X4buDgnF7qHsmINGHFO3q06gqbRvZQs4QMZnIZ6gBqkuKAcmbxisQ9bWcWd2G8Qd/1OC6CtSMi7d4GuMjpJJH8ENBH02jjgz9vf90gNGeR310Quqpur+j0TVSaj7nD5F2GMdl5QZLIm7vVVNb3oGXvxwbS7RdPyV4MWE0OyOnOWKZxOCgHZBQgUQ3YCxF9u6lIHEWsuUelgCowBOuF3sfaYLjf2C45x+TOARzLYkpFysFgRfgQbr1NykM+TWIP6mrs/aanoqlIv6zxJN3c/sLEe79F5V89HIvVn+7XegAzhP5DjKS5soIlkIawz4hg==
Received: from BN0PR04CA0056.namprd04.prod.outlook.com (2603:10b6:408:e8::31)
 by DM4PR12MB6589.namprd12.prod.outlook.com (2603:10b6:8:b4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 18:37:25 +0000
Received: from BN6PEPF0000006F.namprd03.prod.outlook.com
 (2603:10b6:408:e8:cafe::f) by BN0PR04CA0056.outlook.office365.com
 (2603:10b6:408:e8::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 18:37:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN6PEPF0000006F.mail.protection.outlook.com (10.167.248.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 18:37:24 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 11:36:53 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail202.nvidia.com (10.129.68.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 11:36:44 -0700
From: <mhonap@nvidia.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>, <ankita@nvidia.com>,
	<jic23@kernel.org>, <dave.jiang@intel.com>, <alejandro.lucero-palau@amd.com>,
	<smadhavan@nvidia.com>, <corbet@lwn.net>, <skhan@linuxfoundation.org>,
	<dave@stgolabs.net>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <iweiny@kernel.org>, <ming.li@zohomail.com>,
	<yishaih@nvidia.com>, <skolothumtho@nvidia.com>, <kevin.tian@intel.com>,
	<bhelgaas@google.com>, <dmatlack@google.com>, <kees@kernel.org>,
	<gustavoars@kernel.org>
CC: <cjia@nvidia.com>, <kjaju@nvidia.com>, <vsethi@nvidia.com>,
	<zhiw@nvidia.com>, <mhonap@nvidia.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-hardening@vger.kernel.org>
Subject: [PATCH v5 05/27] vfio/pci: Add the CXL provider ops registration interface
Date: Thu, 17 Sep 2026 00:05:18 +0530
Message-ID: <20260916183540.3813685-6-mhonap@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260916183540.3813685-1-mhonap@nvidia.com>
References: <20260916183540.3813685-1-mhonap@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail202.nvidia.com (10.129.68.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PEPF0000006F:EE_|DM4PR12MB6589:EE_
X-MS-Office365-Filtering-Correlation-Id: 266f6e35-948b-4839-9178-08df14218d77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|1800799024|36860700016|7416014|376014|10067099003|18002099003|22082099003|56012099006|11063799006|921020;
X-Microsoft-Antispam-Message-Info:
	UuIcd8ywBN83/xf/FHwyxGstZuXyBzo6Ok6by2X/aeLvYZeaFnktHXIuH1vE/Gl6+tATCoHcPIyn2vnbuRsc1AtiiRHHxWa8WUX4vuklTxOJaLnM4+22Z3kTn0ewJoXl1Q3ToytDTJ/O+i0MVR/bd8gMKKAuPq+4uoCxcdO6WoWdokiPIaCKWi8QtYhx7fNTJykjAyOGbDv3ZHvWvYybmMOoVbe38ivyv1tSL/P6jGYDqhXYF0E2lIqGz9ktxzC+2ItpKK6/i+xjY3NIMuo8UemP47VT3wRv6ESye27cud39Bymdp2Bmc6NVBom4uESnp+Fe9OMJxwdcDT9DCIjUpy7rBLlRP4VykyXWKaOt8EdlpWD0NLjYEVSQP8Ow5ixNlz9fl7fMUOXmgJtPljFMwZWsMkyu7P95UXEZq6hHVz8eXIEQhkcv6SyFGKiuJNmFA+BcQXLMd0cGaUFV00pQO3PDTXXlm+gsRKjZXBGJVdpz5qusNR1DYgvYa4LPeua1lizUjdwPP4ATp4a9V50aX7G4Iek6Rqln+jqZgfZIfeG+5UNhNZSlnP7h9iAXMWcptfQA6xHaUX8pJnjGIzlklD3/yVXqc6+GMMSbpsHaglAQV9sqeIhwGG78stCktQKoqQF6e89IF/k4SqvY8Fc48HKOa7Lr39R+GlF2jnZwjBnbVMjRwUc06b1GQDiasZ7mME1BLLUGcMiaAajhsfPfSSS+vgk7R6VPSc/xK1BWX8xCxq2L8maBhRTqdjRzXe0b
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(1800799024)(36860700016)(7416014)(376014)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	x0ZiU1aPQUCNBsA0Vv4qeyOPEOulu35/RHBS9Hi8v4Wj+WOZQyra46MeGErMcVjxl7MTl4mb+zOWYy34CMsRND5p2I5NoZcVZo0o1R4/56RtdeGWAfK9WyIIMZciBg6tgT3CEQrXRI6ZVpFsP7zHRcVZx5Oj8dTE2pv5RpYiC0iT74F4lGSJFu16sOUrZ3T23pY56WmEThRNJOFIsZXVv/clo5u2faTq0v/LHbpkR1ct8jGosykrDKRRD2HoAxAQGPbAAmJ9YFLO3Z/SEywJRYPCN04BYwBl4W0GoFV+AuFRCmLaJuqF4PEoyEy0fdJj0s4OlK+HalL07YcAgY0HyMGIoT0RANUSa5CRWmjY74YHd3b+eunv9pMN0B6vE4od/P83va5B15xg+pNhCbfLaTIOtyG25BB4+JuwchHWRcZPYKtxJyK9wMbgpwakK28M
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 18:37:24.7914
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 266f6e35-948b-4839-9178-08df14218d77
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN6PEPF0000006F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6589

From: Manish Honap <mhonap@nvidia.com>

vfio-pci-core must stay free of any CXL header dependency, so CXL Type-2
handling lives in a separate vfio-cxl module that plugs in a set of
callbacks.

Add the registration interface:
- vfio-cxl registers a single struct vfio_cxl_ops at module_init
- vfio-pci-core stores it under an rwsem.

A second registration is refused with -EBUSY.

The owner field will be used to pin vfio-cxl for the lifetime of each
bound CXL device.

Assisted-by: LLM
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 24 ++++++++++++++++++++++++
 include/linux/vfio_pci_core.h    | 10 ++++++++++
 2 files changed, 34 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 6757054e9d87..2cc5dd20396c 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -2178,6 +2178,30 @@ static void vfio_pci_vga_uninit(struct vfio_pci_core_device *vdev)
 					      VGA_RSRC_LEGACY_MEM);
 }
 
+static const struct vfio_cxl_ops *vfio_pci_cxl_ops;
+static DECLARE_RWSEM(vfio_pci_cxl_ops_rwsem);
+
+int vfio_pci_core_register_cxl_ops(const struct vfio_cxl_ops *ops)
+{
+	guard(rwsem_write)(&vfio_pci_cxl_ops_rwsem);
+
+	if (vfio_pci_cxl_ops)
+		return -EBUSY;
+
+	vfio_pci_cxl_ops = ops;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(vfio_pci_core_register_cxl_ops);
+
+void vfio_pci_core_unregister_cxl_ops(const struct vfio_cxl_ops *ops)
+{
+	guard(rwsem_write)(&vfio_pci_cxl_ops_rwsem);
+
+	if (vfio_pci_cxl_ops == ops)
+		vfio_pci_cxl_ops = NULL;
+}
+EXPORT_SYMBOL_GPL(vfio_pci_core_unregister_cxl_ops);
+
 int vfio_pci_core_init_dev(struct vfio_device *core_vdev)
 {
 	struct vfio_pci_core_device *vdev =
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 9a1674c152aa..9fe0d1a3a370 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -66,6 +66,16 @@ struct vfio_pci_device_ops {
 			       size_t nr_ranges);
 };
 
+struct vfio_cxl_ops {
+	int	(*init)(struct vfio_pci_core_device *vdev);
+	void	(*release)(struct vfio_pci_core_device *vdev);
+	/* Pinned per bound CXL device so vfio-cxl cannot unload under usage */
+	struct module *owner;
+};
+
+int vfio_pci_core_register_cxl_ops(const struct vfio_cxl_ops *ops);
+void vfio_pci_core_unregister_cxl_ops(const struct vfio_cxl_ops *ops);
+
 #if IS_ENABLED(CONFIG_VFIO_PCI_DMABUF)
 int vfio_pci_core_fill_phys_vec(struct phys_vec *phys_vec,
 				struct vfio_region_dma_range *dma_ranges,
-- 
2.25.1

