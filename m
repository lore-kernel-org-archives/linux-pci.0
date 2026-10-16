Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010069.outbound.protection.outlook.com [52.101.61.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D4A541462;
	Fri, 16 Oct 2026 16:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792167789; cv=fail; b=GIElqAjH21eJPaFjp6pYQj/JfdpTt5ZiD5LpwX5lwutfQEvl0Gjf8C+zFuupxdYAeStAfw8Lhedfa1XPRKy7345pQgSu/FOI/V0e8csarTy2GQSmqBvIuio+Jg1HkwZD1TXfZnNguIdrMlQKYNUdU2+fR56lRSUoM4zbaHrZf0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792167789; c=relaxed/simple;
	bh=jj/beiD/SI2gUZBx0dfSVjMA/IwAMxdtYI/zme1Wm+k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BNGq/h0P5a7BJ5epkP2ZZ1Aj1iA7jGnjeoA+3k9UpLkA5vZqs2LuCaeekjuf17TQMnFlssGiTwVK2I38G2tb6Vvxk2kRQb7ftVJ8qCbWsFZ6dAabjmcTcwx5p5YnHitYtRmLQ+QliDZ5GjcP05XPsIb2A8dYdccyQ4QEOROTCJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uuIs3yHY; arc=fail smtp.client-ip=52.101.61.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uuIs3yHY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yU8Qf4DYrgv9arcCDhEpIh52aQL/IOZRuWXlsZmm137nRO+22rdWo0dnf6wvxNuz62eFTjuV+K2OY8+xcJg58ZU1FqSKiHdg/HU/qOGtGPExms1rlD7gTeExFhK0oJKGXs/Kpn40z/JB7bTex3g3/UMxtgGurPSv7oHRATrHp0K39Uyoe4JTBnHaCv/6F98h7iTqtZL7nS5nyqK19vHYktPn8+c8EoMGDF2ZS91XDI44fXpYAzpjw65A0s6rQ3hIQ4TFvFKFAcxCwDWxldTT4TFAKgMXLFuT+Cm3e1ySdPLJyWy0ohzx0o7lTaFd/GcBmUbLOVcT4zeEKyEO5WMyFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZCUKwXpgL0iZNNrDBWRI0ozDZF/6YZHzKXEro+iGkg=;
 b=Mm4TSAS3k+Le+202Ph6ChYcuFGq9J2Zjs/4ISY4tvGTEir+Fbx6DzUHMuWg/O66iUZH0UCVgVjcEmBzXUFz2GAagAu+o8Ol3q9K0BSre35V+DpoON/AFMV2EsY+gL8Yhu7KflWIQcyfsOQHVtVPgTvyKJt2fvXv1HQUUxY3LMRdvH55TtCBFXy3pP7MAThUnhpu5W+l83wbg4TezAwMGnYnqbxo31kM/gIQYqI43nnK3ezOUiaz/qxnQS4WzqvcU+DXoIin4XfbvFbNERoJb/cQG7juBvwvvFbOXnaruBi5RffkUP3KyqnctvCu2bJmnCCdBS2g0kIeHUDsyZQKazA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZCUKwXpgL0iZNNrDBWRI0ozDZF/6YZHzKXEro+iGkg=;
 b=uuIs3yHYCeJ+7RwSXmA1xm4Sh4teZBahT5WCSQSg3YIeQFHdDcp2RzF1SNNAnUu050cQ++fmH7uosMT61PQ9seY6QHfDp2aCFiIF4qiuyl+znG60ShAAIPcxlzyyrPgVYPYxPYjrVwc5CGgvo7jjtjt69d3NnxwUB3UB2E474WhJV7Td/T1f4dHAGjYrofeRcbS+TxLOhTUWP38F8Vwdy5qiCYJmtNSqTM0hdf/w7B8MjKGgn81ekrfCoGbuD8TtmXHG0BPnMPVTZwWSWM+wD7iU4r+GAMcffndky/K+HDCVwIUOa19SBPYAdhl34jkIOZNCJL/WVR5sQ49P0UdDaQ==
Received: from SN7PR04CA0153.namprd04.prod.outlook.com (2603:10b6:806:125::8)
 by DM4PR12MB6640.namprd12.prod.outlook.com (2603:10b6:8:8f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Fri, 16 Oct
 2026 16:21:58 +0000
Received: from BN7PEPF000000A7.namprd05.prod.outlook.com
 (2603:10b6:806:125:cafe::2d) by SN7PR04CA0153.outlook.office365.com
 (2603:10b6:806:125::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Fri, 16
 Oct 2026 16:21:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN7PEPF000000A7.mail.protection.outlook.com (10.167.245.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 16:21:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 16 Oct
 2026 09:21:26 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 09:21:17 -0700
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
Subject: [PATCH v6 16/31] vfio/pci: Revoke and re-arm one device-specific region
Date: Fri, 16 Oct 2026 21:48:23 +0530
Message-ID: <20261016161839.2765592-17-mhonap@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016161839.2765592-1-mhonap@nvidia.com>
References: <20261016161839.2765592-1-mhonap@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF000000A7:EE_|DM4PR12MB6640:EE_
X-MS-Office365-Filtering-Correlation-Id: 6302b381-c124-47fc-7e38-08df2ba1983e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|7416014|82310400026|1800799024|921020|10067099003|11063799006|56012099006|22082099003|18002099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	9B7iqqQZFz67fN0RTzocr2LuNS4OnRIKFSKfZoTJfBSDHREc6qAW9TJh2o5/daHDqwWCsdKp+jaasq3gDRaSqEuZFTG1Jbigwe2mGzYTXJfbutcdngeKoXcqZ+gjHzyWJk3hyzl9Jnocacz+aoI/tGqjctHHqdu7ryf/C4dyMnoSo+63WmR2UoiGTGGb1Uj4z2HmF1gAUDuV/zMmcLoy0uewypVLFHmaympagI0F3Y1o+/782krVQWFeX06tImuaiiL8Lpul+hByjMz/+JSnvcD0brT4WfAPO2sftWzcppvxjlU9VW3G1e+2+xbUmSBDOHXrSljoQ39gC/mgXywaWkY/jKLbvRp0RpdVA8wa3RpxZ5VD5dt4Xzktb2QN9fQenHtMmAT5aUPursqrLtPdOSzOM4PaZ6OfBQ1FPrIlguR/U/5J4KygZUoukZB1FITRtyIk8fUZzHeykSdjcCedAvGLy+bV+7l6IqQSC2bIf2XsJxH/ylRl4VEqYz6cDKl34gva/YUPR59I+4gpsKhgWLjOXXTsS162VTpJiWbzvvQt36y9oqhZeTh5O2hwiXe8vpHClo6+H2X0FYSttzy90+8/pnPLx6/IDM6epBr+zabZ4va8fGjYrWqczG89Id4fRX7Y2RABNv78ef1rZYnC+30e9qy3I54gUwOsDWaufDipte55BiBuBRqGQLe97eRuKjxAVmh59t/XhYVeTQpiZzFkNBrq434WWrgzDNmXwBd+VyBBFuIixeMYbNkizDu0
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(7416014)(82310400026)(1800799024)(921020)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	EzHLOm3iVAzXef1v/Di2I0k9iU2AFcwLOZRYCxwRKEwbDqlbjst33PLJ/12U2WEPXwntXtu5uzPBjbs6gdqtrR3LraDylup/0dpyP02FRQ8nzStRff5lH473FYDuGCz6AbH30l01rfpYeWCT/2SCUq55+2n10IIokPW/5E7jghM0ZUfzCAaF52CC9cVWpVnMHLxyA3xMVSZqg7iSsGKF6sHQNSlh4OvRdz286QfUw3ZgUyVxUb0icULlD4C/5PDTPrioNnmCUdF5cq9JRIrnn4AcVQQDHVMLyJhDtmKXhsegzuSaaYVE5X4fVo6QkV2GBXK2DGFk127c8mUX1Y3n1HR81IUAmAtAHioLToThbhePPyLuYIY8BRjgx71A6MF8Ow18BLNlI1v+OsqrSwf9xkIkxzuceklRpQXtHC7VL6wtNER5Jq+HpcwvV5q86lm2
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 16:21:55.2065
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6302b381-c124-47fc-7e38-08df2ba1983e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF000000A7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6640

From: Manish Honap <mhonap@nvidia.com>

The BARs of a vfio PCI device follow the memory enable bit: clearing it
zaps their mmaps and revokes their dma-bufs, and setting it re-arms the
dma-bufs. A device-specific region does not have to follow that bit. The
HDM memory region of a CXL Type-2 device follows the committed HDM
decoder, which changes across reset, bus reset and low power, not with
Memory Space Enable. Other device-specific regions, such as nvgrace
coherent memory or the IGD OpRegion, do not depend on it either.

Record the region index of each dma-buf at export. vfio_pci_dma_buf_move()
now moves only the BAR dma-bufs, and vfio_pci_dma_buf_cleanup() still
drains every dma-buf of the device.

Export vfio_pci_core_revoke_region(), which zaps the user mmaps of one
device-specific region and revokes its dma-bufs, and
vfio_pci_core_rearm_region(), which re-arms them. A provider calls them
under memory_lock when the state its region depends on changes. Also
export __vfio_pci_vmf_insert_pfn(), the pfn insert of
vfio_pci_vmf_insert_pfn() without its memory enable and runtime PM
checks, for the fault handler of such a region. Export
vfio_pci_core_clear_memory_enable() for a provider whose failed
operation left Memory Space off in the device: it zaps the BAR mmaps,
revokes the BAR dma-bufs and clears vfio's record of the bit.

Suggested-by: Alex Williamson <alex@shazbot.org>
Assisted-by: LLM
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/vfio/pci/vfio_pci_core.c   | 109 +++++++++++++++++++++++++++--
 drivers/vfio/pci/vfio_pci_dmabuf.c |  98 +++++++++++++++++---------
 drivers/vfio/pci/vfio_pci_priv.h   |   7 ++
 include/linux/vfio_pci_core.h      |   8 +++
 4 files changed, 180 insertions(+), 42 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 6676c561465b..9d0c22a4f3c6 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1982,6 +1982,77 @@ static void vfio_pci_zap_bars(struct vfio_pci_core_device *vdev)
 	unmap_mapping_range(core_vdev->inode->i_mapping, start, len, true);
 }
 
+/**
+ * vfio_pci_core_revoke_region() - take a device-specific region out of use
+ * @vdev: vfio PCI device, with memory_lock held for write
+ * @index: vfio region index of a device-specific region
+ *
+ * Zap the user mmaps of the region and revoke its dma-bufs, for a provider
+ * whose region depends on device state that is about to change. The BARs
+ * follow the memory enable bit instead; a device-specific region may not.
+ * A later fault on the region goes back to the region's own fault handler.
+ */
+void vfio_pci_core_revoke_region(struct vfio_pci_core_device *vdev,
+				 unsigned int index)
+{
+	struct vfio_pci_region *region;
+
+	lockdep_assert_held_write(&vdev->memory_lock);
+
+	if (WARN_ON(index < VFIO_PCI_NUM_REGIONS ||
+		    index - VFIO_PCI_NUM_REGIONS >= vdev->num_regions))
+		return;
+
+	region = &vdev->region[index - VFIO_PCI_NUM_REGIONS];
+	unmap_mapping_range(vdev->vdev.inode->i_mapping,
+			    VFIO_PCI_INDEX_TO_OFFSET(index), region->size, true);
+	vfio_pci_dma_buf_move_region(vdev, index, true);
+}
+EXPORT_SYMBOL_GPL(vfio_pci_core_revoke_region);
+
+/**
+ * vfio_pci_core_rearm_region() - put a revoked device-specific region back
+ * @vdev: vfio PCI device, with memory_lock held for write
+ * @index: vfio region index passed to vfio_pci_core_revoke_region()
+ */
+void vfio_pci_core_rearm_region(struct vfio_pci_core_device *vdev,
+				unsigned int index)
+{
+	lockdep_assert_held_write(&vdev->memory_lock);
+
+	vfio_pci_dma_buf_move_region(vdev, index, false);
+}
+EXPORT_SYMBOL_GPL(vfio_pci_core_rearm_region);
+
+/**
+ * vfio_pci_core_clear_memory_enable() - follow a device that lost Memory Space
+ * @vdev: vfio PCI device, with memory_lock held for write
+ *
+ * For a provider whose failed operation left Memory Space disabled in the
+ * device. Zap the BAR mmaps, revoke the BAR dma-bufs and clear vfio's record
+ * of the Memory Space bit, as a user write that clears the bit would. The
+ * user's next Memory Space write enables it again.
+ */
+void vfio_pci_core_clear_memory_enable(struct vfio_pci_core_device *vdev)
+{
+	__le16 *virt_cmd;
+
+	lockdep_assert_held_write(&vdev->memory_lock);
+
+	/* Closed, or not open yet: vfio_config_init() reads the device. */
+	if (!vdev->vconfig)
+		return;
+
+	virt_cmd = (__le16 *)&vdev->vconfig[PCI_COMMAND];
+	if (!(*virt_cmd & cpu_to_le16(PCI_COMMAND_MEMORY)))
+		return;
+
+	vfio_pci_zap_bars(vdev);
+	vfio_pci_dma_buf_move(vdev, true);
+	*virt_cmd &= cpu_to_le16(~PCI_COMMAND_MEMORY);
+}
+EXPORT_SYMBOL_GPL(vfio_pci_core_clear_memory_enable);
+
 void vfio_pci_zap_and_down_write_memory_lock(struct vfio_pci_core_device *vdev)
 {
 	down_write(&vdev->memory_lock);
@@ -2019,16 +2090,26 @@ static unsigned long vma_to_pfn(struct vm_area_struct *vma)
 	return (pci_resource_start(vdev->pdev, index) >> PAGE_SHIFT) + pgoff;
 }
 
-vm_fault_t vfio_pci_vmf_insert_pfn(struct vfio_pci_core_device *vdev,
-				   struct vm_fault *vmf,
-				   unsigned long pfn,
-				   unsigned int order)
+/**
+ * __vfio_pci_vmf_insert_pfn() - insert a pfn without the memory enable and
+ *	runtime PM checks
+ * @vdev: vfio PCI device, with memory_lock held for read
+ * @vmf: the fault being served
+ * @pfn: first pfn to insert
+ * @order: page order of the mapping
+ *
+ * For a device-specific region that does not follow the memory enable bit.
+ * The caller checks the state its region depends on under memory_lock, and
+ * revokes the region with vfio_pci_core_revoke_region() when it changes or
+ * before the device leaves D0.
+ */
+vm_fault_t __vfio_pci_vmf_insert_pfn(struct vfio_pci_core_device *vdev,
+				     struct vm_fault *vmf,
+				     unsigned long pfn,
+				     unsigned int order)
 {
 	lockdep_assert_held_read(&vdev->memory_lock);
 
-	if (vdev->pm_runtime_engaged || !__vfio_pci_memory_enabled(vdev))
-		return VM_FAULT_SIGBUS;
-
 	if (!order)
 		return vmf_insert_pfn(vmf->vma, vmf->address, pfn);
 
@@ -2040,6 +2121,20 @@ vm_fault_t vfio_pci_vmf_insert_pfn(struct vfio_pci_core_device *vdev,
 
 	return VM_FAULT_FALLBACK;
 }
+EXPORT_SYMBOL_GPL(__vfio_pci_vmf_insert_pfn);
+
+vm_fault_t vfio_pci_vmf_insert_pfn(struct vfio_pci_core_device *vdev,
+				   struct vm_fault *vmf,
+				   unsigned long pfn,
+				   unsigned int order)
+{
+	lockdep_assert_held_read(&vdev->memory_lock);
+
+	if (vdev->pm_runtime_engaged || !__vfio_pci_memory_enabled(vdev))
+		return VM_FAULT_SIGBUS;
+
+	return __vfio_pci_vmf_insert_pfn(vdev, vmf, pfn, order);
+}
 EXPORT_SYMBOL_GPL(vfio_pci_vmf_insert_pfn);
 
 static vm_fault_t vfio_pci_mmap_huge_fault(struct vm_fault *vmf,
diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
index 8606c15ab2fe..d0f7ec5487de 100644
--- a/drivers/vfio/pci/vfio_pci_dmabuf.c
+++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
@@ -19,6 +19,7 @@ struct vfio_pci_dma_buf {
 	u32 nr_ranges;
 	struct kref kref;
 	struct completion comp;
+	u32 region_index;
 	u8 revoked : 1;
 };
 
@@ -288,6 +289,7 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
 	priv->vdev = vdev;
 	priv->nr_ranges = get_dma_buf.nr_ranges;
 	priv->size = length;
+	priv->region_index = get_dma_buf.region_index;
 	ret = vdev->pci_ops->get_dmabuf_phys(vdev, &priv->provider,
 					     get_dma_buf.region_index,
 					     priv->phys_vec, dma_ranges,
@@ -347,6 +349,49 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
 	return ret;
 }
 
+static void vfio_pci_dma_buf_move_one(struct vfio_pci_dma_buf *priv,
+				      bool revoked)
+{
+	if (!get_file_active(&priv->dmabuf->file))
+		return;
+
+	if (priv->revoked != revoked) {
+		dma_resv_lock(priv->dmabuf->resv, NULL);
+		if (revoked)
+			priv->revoked = true;
+		dma_buf_invalidate_mappings(priv->dmabuf);
+		dma_resv_wait_timeout(priv->dmabuf->resv,
+				      DMA_RESV_USAGE_BOOKKEEP, false,
+				      MAX_SCHEDULE_TIMEOUT);
+		dma_resv_unlock(priv->dmabuf->resv);
+		if (revoked) {
+			kref_put(&priv->kref, vfio_pci_dma_buf_done);
+			wait_for_completion(&priv->comp);
+			/*
+			 * Re-arm the registered kref reference and the
+			 * completion so the post-revoke state matches the
+			 * post-creation state.  An un-revoke followed by a
+			 * new mapping needs the kref to be non-zero before
+			 * kref_get(), and vfio_pci_dma_buf_cleanup()
+			 * delegates its drain back through this revoke
+			 * path on a possibly-already-revoked dma-buf.
+			 */
+			kref_init(&priv->kref);
+			reinit_completion(&priv->comp);
+		} else {
+			dma_resv_lock(priv->dmabuf->resv, NULL);
+			priv->revoked = false;
+			dma_resv_unlock(priv->dmabuf->resv);
+		}
+	}
+	fput(priv->dmabuf->file);
+}
+
+/*
+ * Revoke or re-arm the dma-bufs of the BARs, which follow the memory enable
+ * bit. A device-specific region is moved by its provider through
+ * vfio_pci_dma_buf_move_region().
+ */
 void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool revoked)
 {
 	struct vfio_pci_dma_buf *priv;
@@ -354,41 +399,23 @@ void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool revoked)
 
 	lockdep_assert_held_write(&vdev->memory_lock);
 
-	list_for_each_entry_safe(priv, tmp, &vdev->dmabufs, dmabufs_elm) {
-		if (!get_file_active(&priv->dmabuf->file))
-			continue;
+	list_for_each_entry_safe(priv, tmp, &vdev->dmabufs, dmabufs_elm)
+		if (priv->region_index < VFIO_PCI_NUM_REGIONS)
+			vfio_pci_dma_buf_move_one(priv, revoked);
+}
 
-		if (priv->revoked != revoked) {
-			dma_resv_lock(priv->dmabuf->resv, NULL);
-			if (revoked)
-				priv->revoked = true;
-			dma_buf_invalidate_mappings(priv->dmabuf);
-			dma_resv_wait_timeout(priv->dmabuf->resv,
-					      DMA_RESV_USAGE_BOOKKEEP, false,
-					      MAX_SCHEDULE_TIMEOUT);
-			dma_resv_unlock(priv->dmabuf->resv);
-			if (revoked) {
-				kref_put(&priv->kref, vfio_pci_dma_buf_done);
-				wait_for_completion(&priv->comp);
-				/*
-				 * Re-arm the registered kref reference and the
-				 * completion so the post-revoke state matches the
-				 * post-creation state.  An un-revoke followed by a
-				 * new mapping needs the kref to be non-zero before
-				 * kref_get(), and vfio_pci_dma_buf_cleanup()
-				 * delegates its drain back through this revoke
-				 * path on a possibly-already-revoked dma-buf.
-				 */
-				kref_init(&priv->kref);
-				reinit_completion(&priv->comp);
-			} else {
-				dma_resv_lock(priv->dmabuf->resv, NULL);
-				priv->revoked = false;
-				dma_resv_unlock(priv->dmabuf->resv);
-			}
-		}
-		fput(priv->dmabuf->file);
-	}
+/* Revoke or re-arm the dma-bufs exported from one device-specific region. */
+void vfio_pci_dma_buf_move_region(struct vfio_pci_core_device *vdev,
+				  unsigned int index, bool revoked)
+{
+	struct vfio_pci_dma_buf *priv;
+	struct vfio_pci_dma_buf *tmp;
+
+	lockdep_assert_held_write(&vdev->memory_lock);
+
+	list_for_each_entry_safe(priv, tmp, &vdev->dmabufs, dmabufs_elm)
+		if (priv->region_index == index)
+			vfio_pci_dma_buf_move_one(priv, revoked);
 }
 
 void vfio_pci_dma_buf_cleanup(struct vfio_pci_core_device *vdev)
@@ -405,7 +432,8 @@ void vfio_pci_dma_buf_cleanup(struct vfio_pci_core_device *vdev)
 	 * ready, so cleanup itself does not need to participate in kref
 	 * bookkeeping.
 	 */
-	vfio_pci_dma_buf_move(vdev, true);
+	list_for_each_entry_safe(priv, tmp, &vdev->dmabufs, dmabufs_elm)
+		vfio_pci_dma_buf_move_one(priv, true);
 
 	list_for_each_entry_safe(priv, tmp, &vdev->dmabufs, dmabufs_elm) {
 		if (!get_file_active(&priv->dmabuf->file))
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index dbede6e24fa9..23bccfbb7eb7 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -141,6 +141,8 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
 				  size_t argsz);
 void vfio_pci_dma_buf_cleanup(struct vfio_pci_core_device *vdev);
 void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool revoked);
+void vfio_pci_dma_buf_move_region(struct vfio_pci_core_device *vdev,
+				  unsigned int index, bool revoked);
 #else
 static inline int
 vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
@@ -156,6 +158,11 @@ static inline void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev,
 					 bool revoked)
 {
 }
+static inline void
+vfio_pci_dma_buf_move_region(struct vfio_pci_core_device *vdev,
+			     unsigned int index, bool revoked)
+{
+}
 #endif
 
 #endif
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index cb9ba92b696a..7dd93ef103cb 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -227,6 +227,11 @@ int vfio_pci_core_register_dev_region(struct vfio_pci_core_device *vdev,
 				      unsigned int type, unsigned int subtype,
 				      const struct vfio_pci_regops *ops,
 				      size_t size, u32 flags, void *data);
+void vfio_pci_core_revoke_region(struct vfio_pci_core_device *vdev,
+				 unsigned int index);
+void vfio_pci_core_rearm_region(struct vfio_pci_core_device *vdev,
+				unsigned int index);
+void vfio_pci_core_clear_memory_enable(struct vfio_pci_core_device *vdev);
 void vfio_pci_core_close_device(struct vfio_device *core_vdev);
 int vfio_pci_core_init_dev(struct vfio_device *core_vdev);
 void vfio_pci_core_release_dev(struct vfio_device *core_vdev);
@@ -250,6 +255,9 @@ ssize_t vfio_pci_core_read(struct vfio_device *core_vdev, char __user *buf,
 		size_t count, loff_t *ppos);
 ssize_t vfio_pci_core_write(struct vfio_device *core_vdev, const char __user *buf,
 		size_t count, loff_t *ppos);
+vm_fault_t __vfio_pci_vmf_insert_pfn(struct vfio_pci_core_device *vdev,
+				     struct vm_fault *vmf, unsigned long pfn,
+				     unsigned int order);
 vm_fault_t vfio_pci_vmf_insert_pfn(struct vfio_pci_core_device *vdev,
 				   struct vm_fault *vmf, unsigned long pfn,
 				   unsigned int order);
-- 
2.53.0

