Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.34
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794493252;
	b=eX7RuWpV8I66CI8IXC9o9qRkcckVAM0xiCKnKZn1xUWNHbNr+1BY9oQ6//SRRkJobDzu
	 OqURVfzk0P918BO23MhgUuFiTtgCyG8H3i6t6gbTMaUr1sZRn9sTHDiVuuH3jLUT+KQOD
	 /nBSjQEhsic3PuP3vJgfrOhHqGErRWh8Ft46m6ATm86aYTX+wzBYhwgAKHef3NCWMR+qd
	 F4yAtGacxXtMkqjlRBUBdyptWkZUdLE/EbukOi4VqFgsTeKa6Vo+z37rjEzJqnJUtb4Ly
	 ExDfQrMx9LgFfvYqe+kYJdofKrhx9LPQv0oF2TU/XQNF0IDJiweTeEcJt3QHcu3Ki2g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493252;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
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
	bh=bcdwMjM/YWfwMXARh1y+slJkx1n1WaHUF2Q7b5RLCO0=;
	b=ICg/iAUqSElx96L96hd7OSwhJRJofSvJ9e77L8QIxlV/qbpkSUN73xywfNxS59fK/M2k
	 n9RgolEmIDpF8E8jJM5DcTTnzuUbmIfBbF4obVcvblnuL8ZB/+KFozrzSCFexgBMTuX4n
	 4BKW0v6zJ449evQ0AS/wjX3I2n+51mMni1Ro3nB1HKY4sBqcNnbmBDBo1l9XVqHuGh5h6
	 PiFZrlfced9ndFeF2zB7xMyRI1TAIUroaiO8rKYsPkvhY4hpYkAwlR2ErHbDV3YJX9qQx
	 Mik3N70L2STa6NG51Hqz4gDToxulqN1A2bbeRp+NKOlxDtTFgErpni59+eRCPMlFK6Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=UAvkEFto;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.34
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011034.outbound.protection.outlook.com [52.101.52.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBAB606A8BE;
	Thu, 12 Nov 2026 14:20:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FBAB606A8BE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=UAvkEFto
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j44Ep/JZbasqHIJ7q3i7psWXlN/3hmqAtutnYj/qbJS2ahtG8mye8AAWfALYd6FiGGMkL1L5gwQbqdoN/Csr5OxqY5WuIeKWj+qIz01z5+JhP8mR30kJlwmS637dpR0LsdpuxY8AN9tLaTchmWTNn90LHMEYmuWyoLo6kmTON9q6cw3n6E/4gJUx3+F36jjcBOO8G1o6kKzGv1D666Gi/UG7dwBmGD73xRBYcKaYex0OENa/L5B43qKwJUk603J0CmqZgUH4fA+fpIhdAV/lXjwgt6gFmv5vzHPfHXOMngqPjG74Z5B38YETQJeUd9omyLITcGZMYZbRX1V7z1tyuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bcdwMjM/YWfwMXARh1y+slJkx1n1WaHUF2Q7b5RLCO0=;
 b=QfKbPEsYhPsslDBaC5CkJWGYTJ0YbUkOZsJzySUQUcPazJykeY49pSnfBYErevEuW2Wl9d/C996KcRV3RoRBFRFlMf3GnyUQlrZE0W69dEStt6zNe0L/FR0vb5813tKGvT79Rm12q/tnR4ATXCWMeu4GeJ574UgN3LauR/nqVj/tiUenf6oRkFtLPgkobH+PsV3JUU2BVx461k0jbWlnhgAECf3uY4agdrgKfu0XHjT6W7v6dcmWCI0p5uGuKhodt100tQaDlF15wjGaMiiiHwUkla4GiZ4X0tHe6b4DuZIe4O0UwWXTiI5KffQmuWDABkDeMsf1/hcN52Z/V/drKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bcdwMjM/YWfwMXARh1y+slJkx1n1WaHUF2Q7b5RLCO0=;
 b=UAvkEFtoPLJOXlKMPS6c+aNAK0NAmuxnyhOrMkcFWnQRCeQVa6Tc8qSKYl0aqSnQLUFjjt/T7eg6wENzOgFyViONSG3o3hf/2gNwUcN4MalP4+Y2sQNtn2xaUFlhtmqR16HBP2ZXJVzIB7itPl7rCCtDCPYNeYD3VZRBAJGTfQvPJUw6Z971UZUvbumVISjVObVb+gzj6tiYqGpMM8jHm2f163EKoBAjEEbouJtbstyXtTlexLxAZ7ais8L73GZUMTanf4JFroVPfonaERDvYYtOjs6/53OKgoX2zJmaDpdDIup2SQSIO8IXNni90CGr7qHbmwK91qtHWwmVPbeD4Q==
Received: from SJ0PR03CA0220.namprd03.prod.outlook.com (2603:10b6:a03:39f::15)
 by CHBPR12MB869915.namprd12.prod.outlook.com (2603:10b6:610:406::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Thu, 12 Nov
 2026 14:18:47 +0000
Received: from BY1PEPF000264B3.namprd02.prod.outlook.com
 (2603:10b6:a03:39f:cafe::81) by SJ0PR03CA0220.outlook.office365.com
 (2603:10b6:a03:39f::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Thu, 12
 Nov 2026 14:18:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BY1PEPF000264B3.mail.protection.outlook.com (10.167.242.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 12 Nov 2026 14:18:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 12 Nov
 2026 06:18:24 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 12 Nov
 2026 06:18:21 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kbusch@meta.com>, <michal.winiarski@intel.com>,
	<satyanarayana.k.v.p@intel.com>, <sonangp@nvidia.com>, <ankita@nvidia.com>,
	<nathanc@nvidia.com>, <mochs@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [RFC PATCH v3 11/20] vfio/pci: Use access ops for hardware information queries
Date: Thu, 12 Nov 2026 14:16:23 +0000
Message-ID: <20261112141632.918954-12-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261112141632.918954-1-skolothumtho@nvidia.com>
References: <20261112141632.918954-1-skolothumtho@nvidia.com>
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
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B3:EE_|CHBPR12MB869915:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d425b0d-c557-4f8f-e9e4-08df40c7dde7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|23010399003|6133799003|22082099003|261009223027099003|18002099003|261022075727099003|261022105027099003|261021121427099003|261102123227099003|261028144727099003|261026140227099003|261021123027099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	8hBn9z0sgskW1gM4l7gcDrW95ijU/P7b3EwYzq/6Mm1yR0T9S+HX7sO7GntNQEybS4ZdgJI6pocwmKBpa8x60mbBGqErED52XSsbFhAHoKul1Bn6ITSZq3QsxL9+AC5OXltbDkZleUrBzQnd8wX6Ahz6yVdikrMHUTYKCvkcwhM++nhaplO75HRyZXVWAw9OTNBM9xJOAxHKo4uQz3euTz+dugXCMvbn2wr2MHjM5OB+ngt356EL3CUJ5WfLVbmYVgvjMH8YEV8E18jSCM2OwVx2uLTCw4sgG8FHk8o5pQYI0ut/z9viDMrwW/m+NFbFS2eTYqXMTvqiXkRH4wZvjGt29FTtH1YPgZ4WrCTZWZJpboYeCiXq/KS97Kpo+z9LZ1buGt03Ao19q7zILTcVEPc7D6TPCdkURwWBoIezYDkwIVEncUIlVyU5lqcBHzsGt11k5Ju5C2IAVcThBV5BmA9uclIHbUsytQpzrMeiq2akD4tCTmhehH8wvnORxp7Ku2HNYp9D+wvymkkATI3oMxU/Mh7y1dtwHjfr8IDZhwQdjuXaDBjhAMPalrZ5BQT16Ef2PEh86SgM4FFw0Qpf4T0CqbxAWz6xXOwEjfV0tPGo1hJ+MK3BWzx9HARk3qLMjiz82ni5KBx5fReCFPJuImj/yCU+1x8rdZFbcEW+PE1gH0v7sEkLEgm2d6QNBAN1hzXSeALQG/03Kv4DmPfJAg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(23010399003)(6133799003)(22082099003)(261009223027099003)(18002099003)(261022075727099003)(261022105027099003)(261021121427099003)(261102123227099003)(261028144727099003)(261026140227099003)(261021123027099003)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hYwYnJn5XlXmMPxsZCrcaK8ZZ88/XgtRlqRqUH5G3nEN7qQynYngaDCubuNEA+nn6pNKoW9kXCsxMxO/InRXmhEy8MZeyZIVggBI7iu6LFjXh6FkHtk1RbwzrzRjgnDRPQpI7rxzUZ5wMxB6lOt/oXkeaoN9K7yva8G1co7qVQqVQdC5q3b60fblorFk8klkoHNBf/cP6M4mLY3XGv+8zt/kvl8qLv8ggzC4JeXs3xdtumustGGzhJd3ilbQIqfw+1xyBHYh9gbDRzWuhkcwZEaN2wOeqKZHNa26nDOopqQwD8EpnDdGRsm/49e2OPZT+i2ZMuPyRqeCk6AzG1QVCBMm8Qs/1KIrNLhaVL4a+vKprMCAvhsdG6D1WBlMy6AzUuUMFeYjyFnz1VADyCS+poSRrho0Vcjrjw33S4CBpoGwzBJ/BJKF8pmfRQ3tMZFD
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 14:18:47.5236
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d425b0d-c557-4f8f-e9e4-08df40c7dde7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF000264B3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHBPR12MB869915

AtomicOps and ROM information queries access PCI configuration and ROM
contents. Run these accesses through access ops and keep userspace
copies outside SRCU. Free the capability buffer if the query fails.

A VF's AtomicOps query accesses its PF. If the PF is managed by VFIO and
supports recovery, check its access ops too. Hold the PF's access_lock
and reject queries when it is closed, since its SRCU instance exists
only while open. Other PF drivers retain their existing behavior.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 82 ++++++++++++++++++++++++--------
 1 file changed, 61 insertions(+), 21 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index fc6b2673be88..da7166669dc7 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1178,6 +1178,33 @@ static int vfio_pci_info_atomic_cap(struct vfio_pci_core_device *vdev,
 	return vfio_info_add_capability(caps, &cap.header, sizeof(cap));
 }
 
+static long vfio_pci_access_atomic_cap_target(struct vfio_pci_core_device *vdev,
+					      void *data)
+{
+	return vfio_pci_info_atomic_cap(vdev, data);
+}
+
+static long vfio_pci_access_atomic_cap(struct vfio_pci_core_device *vdev,
+				       void *data)
+{
+	struct vfio_pci_core_device *pf_vdev = vdev->sriov_pf_core_dev;
+
+	if (!pf_vdev || !pf_vdev->pci_recovery_supported)
+		return vfio_pci_info_atomic_cap(vdev, data);
+
+	/*
+	 * VF AtomicOps queries read the PF's configuration. The PF association
+	 * lasts until VF removal, but its SRCU instance exists only while
+	 * the PF is open.
+	 */
+	guard(mutex)(&pf_vdev->access_lock);
+	if (!pf_vdev->device_open)
+		return -EIO;
+
+	return vfio_pci_core_access(pf_vdev, vfio_pci_access_atomic_cap_target,
+				    data);
+}
+
 static int vfio_pci_ioctl_get_info(struct vfio_pci_core_device *vdev,
 				   struct vfio_device_info __user *arg)
 {
@@ -1209,10 +1236,12 @@ static int vfio_pci_ioctl_get_info(struct vfio_pci_core_device *vdev,
 		return ret;
 	}
 
-	ret = vfio_pci_info_atomic_cap(vdev, &caps);
+	ret = vfio_pci_core_access(vdev, vfio_pci_access_atomic_cap, &caps);
 	if (ret && ret != -ENODEV) {
-		pci_warn(vdev->pdev,
-			 "Failed to setup AtomicOps info capability\n");
+		if (ret != -EIO)
+			pci_warn(vdev->pdev,
+				 "Failed to setup AtomicOps info capability\n");
+		kfree(caps.buf);
 		return ret;
 	}
 
@@ -1235,6 +1264,31 @@ static int vfio_pci_ioctl_get_info(struct vfio_pci_core_device *vdev,
 	return copy_to_user(arg, &info, minsz) ? -EFAULT : 0;
 }
 
+static long vfio_pci_access_rom_info(struct vfio_pci_core_device *vdev,
+				     void *data)
+{
+	struct vfio_region_info *info = data;
+	struct pci_dev *pdev = vdev->pdev;
+	void __iomem *io;
+	size_t size;
+	u16 cmd;
+
+	/*
+	 * Check ROM content is valid. Need to enable memory
+	 * decode for ROM access in pci_map_rom().
+	 */
+	cmd = vfio_pci_memory_lock_and_enable(vdev);
+	io = pci_map_rom(pdev, &size);
+	if (io) {
+		info->flags = VFIO_REGION_INFO_FLAG_READ;
+		/* Report the BAR size, not the ROM size. */
+		info->size = pci_resource_len(pdev, PCI_ROM_RESOURCE);
+		pci_unmap_rom(pdev, io);
+	}
+	vfio_pci_memory_unlock_and_restore(vdev, cmd);
+	return 0;
+}
+
 int vfio_pci_ioctl_get_region_info(struct vfio_device *core_vdev,
 				   struct vfio_region_info *info,
 				   struct vfio_info_cap *caps)
@@ -1272,29 +1326,15 @@ int vfio_pci_ioctl_get_region_info(struct vfio_device *core_vdev,
 
 		break;
 	case VFIO_PCI_ROM_REGION_INDEX: {
-		void __iomem *io;
-		size_t size;
-		u16 cmd;
-
 		info->offset = VFIO_PCI_INDEX_TO_OFFSET(info->index);
 		info->flags = 0;
 		info->size = 0;
 
 		if (pci_resource_start(pdev, PCI_ROM_RESOURCE)) {
-			/*
-			 * Check ROM content is valid. Need to enable memory
-			 * decode for ROM access in pci_map_rom().
-			 */
-			cmd = vfio_pci_memory_lock_and_enable(vdev);
-			io = pci_map_rom(pdev, &size);
-			if (io) {
-				info->flags = VFIO_REGION_INFO_FLAG_READ;
-				/* Report the BAR size, not the ROM size. */
-				info->size = pci_resource_len(pdev,
-							      PCI_ROM_RESOURCE);
-				pci_unmap_rom(pdev, io);
-			}
-			vfio_pci_memory_unlock_and_restore(vdev, cmd);
+			ret = vfio_pci_core_access(vdev, vfio_pci_access_rom_info,
+						   info);
+			if (ret)
+				return ret;
 		} else if (pdev->rom && pdev->romlen) {
 			info->flags = VFIO_REGION_INFO_FLAG_READ;
 			/* Report BAR size as power of two. */
-- 
2.43.0

