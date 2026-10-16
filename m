Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010053.outbound.protection.outlook.com [52.101.193.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDFA538D67;
	Fri, 16 Oct 2026 16:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792167718; cv=fail; b=ChUzhzt1/ZE3bazRMdiC+/2+pvwwxs3V6Gb0l9hJ7946TEia3LzbY3+WnSKekyYg/zLAHghSbOULcqhgU8eVniiw7153c+nzYcY49jvOzWFJRMPQLP2eWuGhL1ZN9c+Xu6dBqMSjxs4C9nWuiygYTtI6Qndpa03lGakdxsrxtQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792167718; c=relaxed/simple;
	bh=FRaTp8W5aXG4TsnuFxO9wsBzJsseB6IQXYaXyOhg+ag=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BcQAFVw2jY8/MPk4OPidcr0euXh1y6mS19PBFWyc/n7/NYGrIbehe78PzZTnUKWPHBPpJ/dMTXlCJzOcQp3QgQlfH4sJu8eldAlinRvccTT1NU07A2cwYH85U851gQoo21QK0MhOqd0HdBxn3oTt/wZbgrFlwBVQvOqEP0PLB+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MPK3b/J2; arc=fail smtp.client-ip=52.101.193.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MPK3b/J2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xlG9HYO2MVOZoPttrxtqiqzrG4ioP24sOplbOxM/tVoXGidegqWNoQTAN4o6at3jjrtXrF1Xq+stWiiXWmyxVWC5P0cllm4ktpMuZKCouUHMuW1vp56BUF6MZXxr0T9dZ3P/rejjGAjP38m9FOexmq1zd/bzU4G2a/BpT2kjTR9QSUxgruc3ojs2o1rHZRDHNxPU0XuCN0CNF7krZjH2vbYOHYOPlBl7GSFUj92YYTI4llHGUIco47FXVrYOeRk/uJfW3RlJINRFmNsNfKmT1eZx1VrT+ewfToGZTlRVYsI5RDtQLCt/l3jkMX7v1CQ9veOArXSkLDAq3n4I+JLRLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xy+tYJGlKIKLxX5VyPu+ZpDKMOnU7TnAn2+EE0EABwI=;
 b=W0tzjg7denpHHLk/PRbVoYg+3MonLQwTZ1TTmwBZ5T0yrK3FArgDHbRyL6KafE4hzfecmyXhAu3b2w2L+pGhBYW+nDh1tPUoQmYajSOXKUr59N9easvMsS5mv8AEkaN1lx3CppHkqmug+0D6JLUYkV6sU8BDkZ6wUzzfsY9voYAJHhVMbvKz83e2lJdZRvLjwp2xoLpUJCy4EqIknOfUcNHQ7k5FxW9AORrZgN+kTETqvJ0V6ITW7z9huqjU8EJ/XeNbeSesON3iKhy+7V0Mp3gxcSbZAr2Jb6RDN43W8YGwsxDAScXEUS2Jpb5q44g1+dKWXlRGx336fOuLsM8bzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xy+tYJGlKIKLxX5VyPu+ZpDKMOnU7TnAn2+EE0EABwI=;
 b=MPK3b/J2TzPbkruepfReR1isA8YMe7poq9T4O0wdgqIW59WCehHsZxSLg1qTVeaTg/KPRb+vVhwTbrFlRi4p0tdJ3xS74p/5nLM2yXyurcSqYDI683AfrFy9HlDZCgbskFfTBpUbUa5TMxpLlVn2qxBG4WS3XA3mVOwjnONTZPaAVlgMKDk8PxaeeR4axYI49jApb5qxp/AQ09ZqKpjNU+fBVp5nz8kEaxxlIZaQ65ImOqorDrO2qRZL6q9WKr5sWXKApEpepqx0sBuaR5qWjUqMJVEf0oPpJKAuRmrD90y/4kpJo2HSmag+hwOHshtgWeCK6ClbIK5hwFOK6KEciQ==
Received: from SN7PR04CA0161.namprd04.prod.outlook.com (2603:10b6:806:125::16)
 by SJ0PR12MB5675.namprd12.prod.outlook.com (2603:10b6:a03:42d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Fri, 16 Oct
 2026 16:21:46 +0000
Received: from BN7PEPF000000A7.namprd05.prod.outlook.com
 (2603:10b6:806:125:cafe::51) by SN7PR04CA0161.outlook.office365.com
 (2603:10b6:806:125::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.17 via Frontend Transport; Fri,
 16 Oct 2026 16:21:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN7PEPF000000A7.mail.protection.outlook.com (10.167.245.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 16:21:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 16 Oct
 2026 09:21:17 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 09:21:08 -0700
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
Subject: [PATCH v6 15/31] vfio/pci: Route every reset point through a try-reset helper
Date: Fri, 16 Oct 2026 21:48:22 +0530
Message-ID: <20261016161839.2765592-16-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN7PEPF000000A7:EE_|SJ0PR12MB5675:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bfa7352-b590-4af4-26f2-08df2ba1927a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700016|23010399003|56012099006|921020|11063799006|261009223027099003|22082099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	W9ll7YmMDNInHWp2AsnRMIciI33F8weBccMFzwZGeXk1RWWOY9jjMuHGUtajjxeN4rrYUFYDAKf3nMtLRW/hAPAroRQ23c2LTg0tXRLK3svB04TcHzznXRsfLo3+ZW+GW/7mK69Knzza7ur4HyzkGN6/qA52MaS2Dwhs0kIOv3xmlnO6y61PIJLVCvZwljTouoE/13HkE3myulnM/g1olh8fZowXZ8EUqEcMCvQdD7HEJ+aE41DB1Iii6vGy/GyBHerSe2IegWq+4AJ7M49XxHC0iiotzhYMDaDnBal6N8fXPzfZ1S+Xi81Z0FTKZm/WMPnmq/As2Lui8FG6rEkN8QNXljkDAtMVMcKVQBhgsGvK5Z5L+Vll20p54sYVhUCOMods6wvEkJCxPM8qhh/C9/sdc4dBthNtwbRwOXM6XTtbO2/YNW6ev3ILOroQy4vwc99mQiI4sjGASlO3hM4t93vCwyeR4+OiXOVHbodpR/k36j2lva87Cy3GhhD/038TYNZQfB/i3zJERNyyabGq5TeWFIFYiTWZrShW6E67JZ3s1pmkDCZKh1jkkR16GS9i8aLADoY8F/KDF3tzXC20gCCHGmmkNZ7j1jSUwNj9qkC6mLXZmAUZTLHsuQvzYybxG68BPY+UxOv3YOL7yFmT+SPm/dQ+F7hSK6pj/8VcyyfUcy+/X67eZyMDAZYfIBChH6+HSu6D1stau2qwlGvfYqoopykvhdyROYmNnu5CuBh2AiC3o4O5cV441nSrNf+q
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700016)(23010399003)(56012099006)(921020)(11063799006)(261009223027099003)(22082099003)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	KDXyAP1Q05lu0m5CqIiq/1gfX0ltASkqwOF44qztIDwepwGicCorsDdeTf3H+3Z50pzve/gSl3Izt2ctqhC111EZwgfPrqKp7qJPPwEp3ssNAbpEScoHi4opHJvTtzCO803sJxdHHsZ1YH5BjqXyqEjxfMwAub6RgP4s1zQTjJ98gqXkDNOt+ikb72Cxla1N2UWvmegkhgc6oSJeGestCniajycgoTywrZ1ZPg64U1EyoFTWOq0oPFkNI9ZlBN/7mrNKiGepOyPml3vHt/KEBnrrpFt1ZD9TJ/FeWFjwdZIqWCczIqajKiAgvQBkeOYm5q3rzq4yzPTqvsjFfpb0tj1Ms5Dyf0K7+D7V1QpcnMcDHefWYafkaUmIHjchWXYdt4rbLtjvaxnYgaD6SY7kuz8uZ0nSzLpUHgui4FYoOrVmiVFcZZMe1k8wTiNHGYE+
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 16:21:45.5278
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bfa7352-b590-4af4-26f2-08df2ba1927a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF000000A7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5675

From: Manish Honap <mhonap@nvidia.com>

A provider such as vfio-cxl must reset its device itself: a CXL Type-2
function must not take an FLR, and its reset changes what the provider
lets the fault path map. vfio-pci-core resets a function at five points:
enable, close, VFIO_DEVICE_RESET, a virtualized PCIe or AF FLR, and the
guest's CXL Reset doorbell in the virtualized CXL DVSEC.

Add a mandatory reset op to the provider ops, and refuse to register ops
without it. Add vfio_pci_try_reset_function(), which keeps the trylock
of pci_try_reset_function(): it returns -EAGAIN when the device lock is
contended, and otherwise runs the provider's reset with the device lock
and memory_lock held. The close path keeps its bridge and device trylock
and calls a locked variant. vfio_pci_try_reset_function() saves the PCI
state first, as pci_try_reset_function() does, for the provider's reset
to restore. The locked variant does not save: on close the reset must
restore the open-time state that vfio_pci_core_disable() has just
loaded. A failed save is returned and the reset is not attempted.

The enable path still fails only on -EAGAIN. A provider checks at bind
that it can reset the device, so reset_works is set for a provider
device whatever the result of the first reset.

The CXL Reset doorbell now runs the reset and reports its result in
Status2: Reset Error on failure, Reset Done on success.

Suggested-by: Alex Williamson <alex@shazbot.org>
Assisted-by: LLM
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/vfio/pci/vfio_pci_config.c | 19 ++++++--
 drivers/vfio/pci/vfio_pci_core.c   | 71 ++++++++++++++++++++++++++++--
 drivers/vfio/pci/vfio_pci_priv.h   |  1 +
 include/linux/vfio_pci_core.h      |  7 +++
 4 files changed, 90 insertions(+), 8 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
index 1fc463540211..6fbece95cb9f 100644
--- a/drivers/vfio/pci/vfio_pci_config.c
+++ b/drivers/vfio/pci/vfio_pci_config.c
@@ -910,7 +910,7 @@ static int vfio_exp_config_write(struct vfio_pci_core_device *vdev, int pos,
 		if (!ret && (cap & PCI_EXP_DEVCAP_FLR)) {
 			vfio_pci_zap_and_down_write_memory_lock(vdev);
 			vfio_pci_dma_buf_move(vdev, true);
-			pci_try_reset_function(vdev->pdev);
+			vfio_pci_try_reset_function(vdev);
 			if (__vfio_pci_memory_enabled(vdev))
 				vfio_pci_dma_buf_move(vdev, false);
 			up_write(&vdev->memory_lock);
@@ -995,7 +995,7 @@ static int vfio_af_config_write(struct vfio_pci_core_device *vdev, int pos,
 		if (!ret && (cap & PCI_AF_CAP_FLR) && (cap & PCI_AF_CAP_TP)) {
 			vfio_pci_zap_and_down_write_memory_lock(vdev);
 			vfio_pci_dma_buf_move(vdev, true);
-			pci_try_reset_function(vdev->pdev);
+			vfio_pci_try_reset_function(vdev);
 			if (__vfio_pci_memory_enabled(vdev))
 				vfio_pci_dma_buf_move(vdev, false);
 			up_write(&vdev->memory_lock);
@@ -1786,9 +1786,20 @@ static int vfio_cxl_dvsec_write(struct vfio_pci_core_device *vdev, int pos,
 	if (!(ctrl2 & PCI_DVSEC_CXL_DISABLE_CACHING))
 		status2 &= ~PCI_DVSEC_CXL_CACHE_INV;
 	if (ctrl2 & PCI_DVSEC_CXL_INIT_CXL_RST) {
+		int ret;
+
 		ctrl2 &= ~PCI_DVSEC_CXL_INIT_CXL_RST;
-		status2 &= ~PCI_DVSEC_CXL_RST_ERR;
-		status2 |= PCI_DVSEC_CXL_RST_DONE;
+
+		/* Run the real reset here and report its result in Status2. */
+		vfio_pci_zap_and_down_write_memory_lock(vdev);
+		vfio_pci_dma_buf_move(vdev, true);
+		ret = vfio_pci_try_reset_function(vdev);
+		if (__vfio_pci_memory_enabled(vdev))
+			vfio_pci_dma_buf_move(vdev, false);
+		up_write(&vdev->memory_lock);
+
+		status2 &= ~(PCI_DVSEC_CXL_RST_DONE | PCI_DVSEC_CXL_RST_ERR);
+		status2 |= ret ? PCI_DVSEC_CXL_RST_ERR : PCI_DVSEC_CXL_RST_DONE;
 	}
 
 	*pctrl2 = cpu_to_le16(ctrl2);
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 1e0ac28b7564..6676c561465b 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -605,6 +605,62 @@ static void vfio_pci_core_unmap_bars(struct vfio_pci_core_device *vdev)
 	}
 }
 
+/**
+ * vfio_pci_try_reset_function() - reset the function without blocking
+ * @vdev: vfio PCI device, with memory_lock held for write
+ *
+ * Reset through the PCI core, or let the provider reset a device it serves.
+ * The provider resets the device with its PCI device lock held, so take that
+ * lock here, without waiting, as pci_try_reset_function() does.
+ *
+ * Return: 0 on success, -EAGAIN when the device lock is contended, or the
+ * reset error. For a provider device a failed pci_save_state() is also
+ * returned, and the reset is not attempted: unlike pci_try_reset_function(),
+ * the provider's reset needs a valid saved state to restore.
+ */
+int vfio_pci_try_reset_function(struct vfio_pci_core_device *vdev)
+{
+	struct pci_dev *pdev = vdev->pdev;
+	int ret;
+
+	lockdep_assert_held_write(&vdev->memory_lock);
+
+	if (!vdev->cxl_ops)
+		return pci_try_reset_function(pdev);
+
+	if (!pci_dev_trylock(pdev))
+		return -EAGAIN;
+
+	/*
+	 * The provider restores PCI state from the saved copy, so save the
+	 * current state first, as pci_try_reset_function() does. The locked
+	 * variant on the close path must not: it resets with the state that
+	 * vfio_pci_core_disable() has just loaded.
+	 */
+	ret = pci_save_state(pdev);
+	if (!ret)
+		ret = vdev->cxl_ops->reset(vdev);
+	pci_dev_unlock(pdev);
+
+	return ret;
+}
+
+/*
+ * As vfio_pci_try_reset_function(), for a caller that holds the device lock.
+ * Only the close path calls this. It takes memory_lock with the device lock
+ * held, so user config access is blocked meanwhile: the order a sysfs reset
+ * uses. That cannot deadlock against a PCI_COMMAND write holding memory_lock
+ * because no user remains at close.
+ */
+static int vfio_pci_reset_function_locked(struct vfio_pci_core_device *vdev)
+{
+	if (!vdev->cxl_ops)
+		return __pci_reset_function_locked(vdev->pdev);
+
+	guard(rwsem_write)(&vdev->memory_lock);
+	return vdev->cxl_ops->reset(vdev);
+}
+
 static void vfio_pci_core_free_dev_regions(struct vfio_pci_core_device *vdev)
 {
 	for (int i = 0; i < vdev->num_regions; i++)
@@ -636,11 +692,14 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 		goto out_power;
 
 	/* If reset fails because of the device lock, fail this path entirely */
-	ret = pci_try_reset_function(pdev);
+	down_write(&vdev->memory_lock);
+	ret = vfio_pci_try_reset_function(vdev);
+	up_write(&vdev->memory_lock);
 	if (ret == -EAGAIN)
 		goto out_disable_device;
 
-	vdev->reset_works = !ret;
+	/* A provider checks at bind that it can reset the device. */
+	vdev->reset_works = vdev->cxl_ops || !ret;
 	pci_save_state(pdev);
 	vdev->pci_saved_state = pci_store_saved_state(pdev);
 	if (!vdev->pci_saved_state)
@@ -846,7 +905,7 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
 		if (bridge && !pci_dev_trylock(bridge))
 			goto out_restore_state;
 		if (pci_dev_trylock(pdev)) {
-			if (!__pci_reset_function_locked(pdev))
+			if (!vfio_pci_reset_function_locked(vdev))
 				vdev->needs_reset = false;
 			pci_dev_unlock(pdev);
 		}
@@ -1541,7 +1600,7 @@ static int vfio_pci_ioctl_reset(struct vfio_pci_core_device *vdev,
 	vfio_pci_set_power_state(vdev, PCI_D0);
 
 	vfio_pci_dma_buf_move(vdev, true);
-	ret = pci_try_reset_function(vdev->pdev);
+	ret = vfio_pci_try_reset_function(vdev);
 	if (__vfio_pci_memory_enabled(vdev))
 		vfio_pci_dma_buf_move(vdev, false);
 	up_write(&vdev->memory_lock);
@@ -2397,6 +2456,10 @@ int vfio_pci_core_register_cxl_ops(const struct vfio_cxl_ops *ops)
 {
 	guard(rwsem_write)(&vfio_pci_cxl_ops_rwsem);
 
+	/* vfio-pci-core never resets a provider's device by itself. */
+	if (!ops->reset)
+		return -EINVAL;
+
 	if (vfio_pci_cxl_ops)
 		return -EBUSY;
 
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index 09a68c99b43c..dbede6e24fa9 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -80,6 +80,7 @@ int vfio_pci_set_power_state(struct vfio_pci_core_device *vdev,
 			     pci_power_t state);
 
 void vfio_pci_zap_and_down_write_memory_lock(struct vfio_pci_core_device *vdev);
+int vfio_pci_try_reset_function(struct vfio_pci_core_device *vdev);
 u16 vfio_pci_memory_lock_and_enable(struct vfio_pci_core_device *vdev);
 void vfio_pci_memory_unlock_and_restore(struct vfio_pci_core_device *vdev,
 					u16 cmd);
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 991a3fcd84eb..cb9ba92b696a 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -87,6 +87,13 @@ struct vfio_cxl_ops {
 	 */
 	void	(*reset_prepare)(struct vfio_pci_core_device *vdev);
 	int	(*reset_done)(struct vfio_pci_core_device *vdev);
+	/*
+	 * Reset the function in place of the PCI core; mandatory. Called with
+	 * the PCI device lock and memory_lock (for write) held. The caller
+	 * provides the saved PCI state the reset restores: the try-reset path
+	 * saves it first, the close path keeps the open-time copy.
+	 */
+	int	(*reset)(struct vfio_pci_core_device *vdev);
 	/* Pinned per bound CXL device so vfio-cxl cannot unload under usage */
 	struct module *owner;
 };
-- 
2.53.0

