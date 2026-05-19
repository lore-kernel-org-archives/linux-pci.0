Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010065.outbound.protection.outlook.com [40.93.198.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A1030C16E;
	Tue, 19 May 2026 03:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779162000; cv=fail; b=HUX0359NDfe65AXWOuZRU7QTdtMLZUpe2yAWf+hDHKe4/rqQWUzRrAc+Q57jUBD3IUtl8rfQBs/mFFA++yhJa0xg8LlFKw7anjuzcPAhMKahRpbmnX3U1fbhJIzkmrK3qwUUjfyISpJOIsZPjYVK+dMKKUxHwvs2/MIkxSxjtZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779162000; c=relaxed/simple;
	bh=OFpmX4HMkS8BLIGt12PTgF8Li2gRtYpDLFhbbUT8c30=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f39HV2W8Gw0gwc0CoRl8lWvaYxJ5+MPmXY/t2ZGZf6gkmSkk850tXWUqo6PfTZpYZwqdIxH7nBFkiOcj1SsJZeuSMpfFfs0K4dk1qcnc3OBeJmCWi5pWWZ7byjU81Ea43VrPcvmSRdsfU/ucHIIO0QezdURB/S0P9ggHZzcyNzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Rv52zirV; arc=fail smtp.client-ip=40.93.198.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Rv52zirV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sFg85anVh3OM7ehpSPeS7HHxHhE3KHkuSsbxyjcBYKkfk3/XmsPdB5Dclm/h3qQflrIZA+HlpA05N+ObLoGFQIT9EwK2YjS//LLxh0H7fcKwZxCjI7OuwP0jsrIitxaJsX3S6mPcewfm1n7ii1T9dSj0/mZHKZety7FwC9z7SKf6799Vb3BOb1TgA+hPJsJMEHjCbMgb84vyza18Jn87zzvSRyp87/BcxeMxqV/6af5xO9GM5f8KGJZJ6ZafJghCxD4cFKPLu8E4obEVJVeEPbuv9eGI8NJw2tZbPLNWL9qBELEbPbgtPFXk6qzdrKg1uHfvyzPkXoFuw144uYFicQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=180oG6n4cU1ARET331oFg1dro5CJzInPpnmh4YERyPE=;
 b=NQBja8MCXUg47Eyu1/waJ4Llt61CEbl4b5WQrLvoLITB0vpqdivTP42q9FHzYfJ96EZEIY6ZMdTdNZDWyJPkSmLVHVxUjPoxCgJzt74bC4fSwkFRBf7Jp/O+XJyG4ex6pm2FfAYMFTjDPaq/94c98AhgLWZKTOOdbnMWb4R25WH62rkOL1KHvILooedUX7OBEPmDlgK6SbzrEv56H5nAAcc3iDfl3z2ptRY9LaO6QRTTHISGhe+0i8dDzVw4a9o7UwOmS95+iTf+4u03qwqS9UA28dIVjthE/c3GJktPIgh01h7No4CYtC44ryPrA93AS8PV1tpicppzU6YK84zmxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=180oG6n4cU1ARET331oFg1dro5CJzInPpnmh4YERyPE=;
 b=Rv52zirVY/YpAqO7ly/nrVxCq+tLzTJr0d1dH+G+uU36oaBfR7KgZDzzeCx6tryqPh4zCL7KOaClnJCCI9BV/VzAPtUI+j/atgdU7nvtjfEz0BPQt7DPsv9EgpccmQUcm/QfdZ7hDou0pIUjs98mMLw0iP0YJGFM0rGpnymcR10Ms1/AaZqdugwRW7ZT1zUx9VCFg+WLEssT0n1LsmdBegpfztqnMEcoM4pr50vMfQoaJnbHQEjCY+vgbwmpxzULSjE47mFQ6WoEIL4xolzHsu5TUYW/abiW0WBe8uF5lVxe/oQ57Pa+BqrBwuhdkXmmo/wdMvSv43R0+HAajH0nKw==
Received: from SJ0PR05CA0042.namprd05.prod.outlook.com (2603:10b6:a03:33f::17)
 by SAWPR12MB999164.namprd12.prod.outlook.com (2603:10b6:806:4e1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 19 May
 2026 03:39:48 +0000
Received: from SJ1PEPF0000231B.namprd03.prod.outlook.com
 (2603:10b6:a03:33f:cafe::a5) by SJ0PR05CA0042.outlook.office365.com
 (2603:10b6:a03:33f::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.12 via Frontend Transport; Tue, 19
 May 2026 03:39:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF0000231B.mail.protection.outlook.com (10.167.242.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 03:39:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 18 May
 2026 20:39:28 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 18 May
 2026 20:39:27 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 18 May 2026 20:39:26 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Joerg
 Roedel" <joro@8bytes.org>, Bjorn Helgaas <bhelgaas@google.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>
CC: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Pranjal Shrivastava <praan@google.com>, Mostafa Saleh <smostafa@google.com>,
	Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <vsethi@nvidia.com>, Shuai Xue
	<xueshuai@linux.alibaba.com>
Subject: [PATCH v4 05/24] iommu: Add reset_device_done callback for hardware fault recovery
Date: Mon, 18 May 2026 20:38:48 -0700
Message-ID: <4cfa6d35cad451f303c17a388ff6fc6fb8b6f68e.1779161849.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1779161849.git.nicolinc@nvidia.com>
References: <cover.1779161849.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231B:EE_|SAWPR12MB999164:EE_
X-MS-Office365-Filtering-Correlation-Id: c1e7a1b2-8d15-4849-215b-08deb558468d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700016|1800799024|11063799003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	zf7w0Bhz8XmBJdaJu3RbHjDWhOuJU2yrh+wC8DzndhdYwKhXcWJuKpIuguvxr/xMflK1a2ImQckbwp6YUvsjktvXbssd5nlobJfnyF164rlDgdCDVr3/Cyapk3/DXVuYRPi+yAqryZ1nTpYSh+571cS+4w8yDMHw8fx/uDcLjC5NJHpUvjhWwGcAl+zgecqNLUISTOq2tCXxUQnktIheDfFIv4AlyO3XqQ+4Kz6Ps43OpsjMdOBpE91Hyqc01YBueFF3rTeE7baayuaxw3I/OSL9HAFHUb8e+e86ZCsIy5XC/1gcyUIwWvmaT7qp8R4eH2sPbzB5mL2uR4zw1Tcokxd3XQ25kq3OAgpBjbl637X8b/WCsPntKdCgxzCTWomyLg4eU5TIAYtmfqgmqoN89BkDs94/388HJmQ4iSejfa8DclANCcTaQZfEWHZGfBKJ0uWuYGaDYirtagZacR/yU1RMIOrRk78UvEX2lfH2ydSiXcRNb7XbgM8i3SoZWhnHiBaOAoTXnZACx9eFGAGPHMx5aSQWXwdMrp92TjVqoJ+DYMBY0sSGBFqmodrjZm6OzDxAsSnwZ6udC2OJDAb6n5Qc5Cw82/UYZgsOu/f3I5GIKkgWD4PtTpocs6lSrBNIr4+XNzSQGlssJW+s0Y/Iynl5UsGY9dTiWI96pLbWRAd9wWBi7R+bRSMpJsPD+lpSFUiMYo9JsiuI5QhiX5C0K0986w68koZCnJaHQyXX8x8=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700016)(1800799024)(11063799003)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	iZbz41TZtm6EO8UsBP99aCvzubBC/bRGN0xVQ5oNIcIMDhvImc/rFwaNnY4wkZSREIaGROq6PSRnzu+fWaYDwzxZB/CPPwBvUDl5f7luzggzZ+06JZ2tUWUaLm2w1xKLzt636ZF1tU/FskFFyy/otXkiBqE2kwuwMmLkM7fo+ZY9y8iLv6nQ77Z4cRXHZ7XQ9RySz5urVd81dzmwRErEoWpbt0aCHWbGYodnzeqJaQkeSYbRgJbYbfJCd/mmgzx9gMU2Rtxo31ueYXG5ApvwughDxxGJYqtN3osqSen8NVcm5n8DEMMqcrnpJYgE0cxzJ1maUTJUAMYDabapuwAMizp1TZqkw+2X6oHZfMtpsmBw3JA3CSStbbXX74lBDdBNbVS/GQGr195DRaDsQB9O4GdlVPQ4Sck4emTf66IEDzG+Oxi1AZrygDGwhULA7cy0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 03:39:47.7236
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1e7a1b2-8d15-4849-215b-08deb558468d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999164

When an IOMMU hardware detects an error due to a faulty device (e.g. an ATS
invalidation timeout), IOMMU drivers may quarantine the device by disabling
specific hardware features or dropping translation capabilities.

To recover from these states, the IOMMU driver needs a reliable signal that
the underlying physical hardware has been cleanly reset (e.g., via PCIe AER
or a sysfs Function Level Reset) so as to lift the quarantine.

Introduce a reset_device_done callback in struct iommu_ops. Trigger it from
the existing pci_dev_reset_iommu_done() path to notify the underlying IOMMU
driver that the device's internal state has been sanitized, when the result
indicates a successful physical reset.

As the initial use case, this will be used by ATS-capable PCI devices.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommu.h |  4 ++++
 drivers/iommu/iommu.c | 12 ++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index e191d30d228ac..6c124e9e9af8b 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -629,6 +629,9 @@ __iommu_copy_struct_to_user(const struct iommu_user_data *dst_data,
  * @release_device: Remove device from iommu driver handling
  * @probe_finalize: Do final setup work after the device is added to an IOMMU
  *                  group and attached to the groups domain
+ * @reset_device_done: Notify the driver that a device has reset successfully.
+ *                     Note that the core invokes the callback function while
+ *                     holding the group->mutex
  * @device_group: find iommu group for a particular device
  * @get_resv_regions: Request list of reserved regions for a device
  * @of_xlate: add OF master IDs to iommu grouping
@@ -686,6 +689,7 @@ struct iommu_ops {
 	struct iommu_device *(*probe_device)(struct device *dev);
 	void (*release_device)(struct device *dev);
 	void (*probe_finalize)(struct device *dev);
+	void (*reset_device_done)(struct device *dev);
 	struct iommu_group *(*device_group)(struct device *dev);
 
 	/* Request/Free a list of reserved regions for a device */
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 6c92b7a2b14cc..e68c7b142ad5a 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -4182,12 +4182,14 @@ void pci_dev_reset_iommu_done(struct pci_dev *pdev, int reset_result)
 {
 	struct iommu_group *group = pdev->dev.iommu_group;
 	enum gdev_blocked old_gdev_blocked;
+	const struct iommu_ops *ops;
 	struct group_device *gdev;
 	unsigned long pasid;
 	void *entry;
 
 	if (!pci_ats_supported(pdev) || !dev_has_iommu(&pdev->dev))
 		return;
+	ops = dev_iommu_ops(&pdev->dev);
 
 	guard(mutex)(&group->mutex);
 
@@ -4249,6 +4251,16 @@ void pci_dev_reset_iommu_done(struct pci_dev *pdev, int reset_result)
 			 "DMA-aliased sibling may be prematurely unblocked\n");
 	}
 
+	/*
+	 * A PCI device might have been in an error state, so the IOMMU driver
+	 * had to quarantine the device by disabling specific hardware features
+	 * or dropping translation capability. Here notify the IOMMU driver as
+	 * a reliable signal that the faulty PCI device has been cleanly reset
+	 * so now it can lift its quarantine and restore full functionality.
+	 */
+	if (ops->reset_device_done)
+		ops->reset_device_done(&pdev->dev);
+
 	/*
 	 * Re-attach RID domain back to group->domain
 	 *
-- 
2.43.0

