Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.22
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794493098;
	b=JtZZe8me4UGNwsUklnId4jFMgM7G2DGP+XiY7xLQ1m8iYmFYyU99+aOdOW7Gm40ukZW3
	 PinuBu2TuDVKKC3QX5EMWZOPVeaaDe4GOjUgfyqKGz13/7lZMF16uCu3/B4hHHnjnFein
	 d3LfSb6jmmpZWTTPn5+b7doeTDV99SFlm3nMG+TSsd06TSaejNZ3bwNw1eIBQdOCpT0oy
	 kFevov6ih25qbJp0vfox3GNajVX8zXELPetcFomg6FWfT+8hhDWPNoHv78uQsJZWklQGk
	 w8QPFx+oiwLALCJAjRDqb5jVZbZ7i54RA2CBNn2/oy6nCBW6hdD99r77VRJk3ycMcdA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493098;
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
	bh=XvI2VCwWU9h3G6oPiFP0Koyjb7E6buXkIeQYwBjsJF8=;
	b=AcuqIlVe5DPa0neIguRr59/fsUdEMMzdSP9a54ctB/W3G8zeb7YUBPncmRCMIn+uGEgf
	 vU/nIoCcz0BfcIKKF8y+zdhK6pSkCcnbubO2KN4I1dVOEJoZ9Ezp50fw5igSaqAgSqlt0
	 PZpbnxjoS5rVW7F8b4+P+8bSaqUuCQ9X4krw6oKEYho3qsv4KniLFUXHUDkrCHAkNXC/y
	 fMSwEhaesbZzlL23Vk5YcG8iXgZtw2ri0QMuxZOOcK87B3SK4Nmg4xkYWZ7XIxEqOhnUe
	 I4+4UL7puZm//uuGXsvrAgZZ/LVjeHOVIgFsRJdoSu95gTSVp1+QEG3lo/XB08LnrIA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=q6a6+znX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.22
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010022.outbound.protection.outlook.com [52.101.193.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F323160A3806;
	Thu, 12 Nov 2026 14:18:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F323160A3806
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=q6a6+znX
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wo/TD2Q8/+t0D87GYv13QF3vRxYIgxQaX1qekX+q0R1NgsLvE4blHVJrPw259k6cUknka2k3mo1Jjm+1dNOiagos00FZNAfqzPKPvqGYtwfbI/OomCjeMohztG7EAJCHcwfHy/R926h5zYVIBCaAWht7oS5yNPlku1r79ROdgY67UKQ+7VQW1C/zMWeSEey55GiZfU0xzR7en8icq7KKoWqHjZzeq2VwBKLDBXBjqJx7Vxb4DCyscsixoxzAODp1K976gjqNsZUb+ZduQNvKBZBwIknhW2o61YFu3TUucju/anjuwsY/fdjO/fUEmlH3ze/VoErJqL1XgbUclMXTEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XvI2VCwWU9h3G6oPiFP0Koyjb7E6buXkIeQYwBjsJF8=;
 b=JD7WMRUtGnWKyyj5aV162PJ38+VdDqtgOvHqNPkewJjoa/1GoXrNemHhsSxStGkiaHmEITcGqMfCIIosUFMQqY5DVgnG8EX5ZCLE8QP5SE0PrvZ3RFkPGrkIG8AdjcyZ3f9o0BMMCrJWhDPHj8kb0hrOJ4tWcPzHgk3Q/oMBXSDLVBsL4PSkKQ7nJ65ohaKv+Qy7WXLN5wb0MAS4qxTTC6+LEQ4Pc7wNekZnUmcOGN2H4O6PbJ5/bWN9dOnVaBpDbVzZ4kmO0V4mXADKlHC75FRA0oNp60z/QEyzokgxSeDbF3H+eik1beYptlr7Jvu0LewRas89ch8FVuJE4PEgGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XvI2VCwWU9h3G6oPiFP0Koyjb7E6buXkIeQYwBjsJF8=;
 b=q6a6+znXRXm41YqPYsCOMxS++G4QKXJb6Pr1BG4v+lAcxRnnE5g+Xl5OH81iltVNOy6uB/1sMpiT49GqpMNxn7Y25gW3S+T2sY7xQ0rkj7cKrZwI1QxFE/0eDAwJ0eCNnl+43aIcUkhagJExQ15u0JfNwfesDWypkcLXbila6FWK/T9ra5hTPDAZ/FZiQ9UZI+O7PTVNOSMmDloxNBJ/9ws8tjL14psQBGhDfsMPR8e79OqgpcBR8iSF0IZXUhRYOz3qFFk7hLJNDZ3gybCWvLRkmt1MUtNSR+DcUMmuCjxQAPkADOR+t9zrZ15ydwCrJBM4Vh56PyJ03+aCJW+HeQ==
Received: from SJ2P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5da::9)
 by LY0PR12MB635447.namprd12.prod.outlook.com (2603:10b6:408:3b9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 14:18:09 +0000
Received: from MWH0EPF000A6734.namprd04.prod.outlook.com
 (2603:10b6:a03:5da:cafe::20) by SJ2P220CA0012.outlook.office365.com
 (2603:10b6:a03:5da::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Thu, 12
 Nov 2026 14:18:08 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A6734.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 12 Nov 2026 14:18:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 12 Nov
 2026 06:17:45 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 12 Nov
 2026 06:17:42 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kbusch@meta.com>, <michal.winiarski@intel.com>,
	<satyanarayana.k.v.p@intel.com>, <sonangp@nvidia.com>, <ankita@nvidia.com>,
	<nathanc@nvidia.com>, <mochs@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [RFC PATCH v3 01/20] vfio/pci: Add SRCU-protected access ops
Date: Thu, 12 Nov 2026 14:16:13 +0000
Message-ID: <20261112141632.918954-2-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6734:EE_|LY0PR12MB635447:EE_
X-MS-Office365-Filtering-Correlation-Id: bd051bb6-9b19-4083-3f8c-08df40c7c6c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|36860700016|82310400026|10067099003|11063799006|56012099006|261022113327099003|261022105027099003|261022075727099003|261028144727099003|261026121527099003|261026140227099003|261021121427099003|261102130727099003|261102123227099003|261009223027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	XhROUj65LKBxGz/kzrRZnQG6wbRYy8Lj4XjykM4PYAz6SJnsa+sTy31jgtLysuYhbozL65IigAdr7z5hB2sE5kYytilFAD2yzOyalfuessmatFe0o2z31sjez3v4pRZvWrNEO2LLEorL7I3uwo7lBXR0mFWjNR13s8d0vn1DbYeaAYepknFiPhdXKBrWvn+zUU1/vns7RmMuoLJoZNwEtskKFZG4BDoQiKANIZEOttmEG8zAxpP2pmublZVhUGcwzodJHOmpCGaTq3b3fy7Rlt99DAD6Mw/09aiCI+1aUS4s7+FQL87OOiRiUTas0uAdzRHh//V//Fr1oTDIJBpenE2OVJc9nkENK4s/niDqqJn8RAa3BM9pYz0nHV3zUGgNd/OZhxyxhhJfKW1ldedq1TE7j9eKAJVWVG1GWh4jFR9f+N4PENk2s+sLiz6ZY94BYfEjMYIjNlVNcdkE/CITaM5LXtU19dn3Qgd9hKAdjqhas01K6qkyF78IWNuvSlpj9ZIFhVe5+GKSKWkR/4amHjJ2K4mj1ElEJOJ9xhQyN0xICq89/m5yLdiX+wzmKYdEWJVx75ixq/tKStEEyJybt6ZX+9ZcjFKMNvEqoLXQjKTfFsmxp7t6ioRN29FmQIl5cm3NojNy0baDz4LPFCn3AqgTyTB4T0UBuODdO8xsjBdUVAsD/gekH/DdYKcv85i4aX7Z8nrldMMqqedDVVqQhQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(36860700016)(82310400026)(10067099003)(11063799006)(56012099006)(261022113327099003)(261022105027099003)(261022075727099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021121427099003)(261102130727099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0QfONHWH8EczCMi/DEDTxmxr2cY4I+jLXdOG/EoA18jxYwJ+sqkE+vMr6vp7oNx8gGgCGVJ9qG5EKhQSgnq+RSGTMeBrg1nx93f5+7iWuSLgcZ9/Tc5HLG+UQrNVdNqjQUfNIkD3xOKDrOdX6r9AOQqBbDkHnOOo350YmFSqfxjka7T/nV1NsVK3CFJuETlrtgt47Xc8Br0vdWAEQJX6Zw4M6DFPkDs3Q56mEjzkeY1rcSNFkMP+T+umwIGCiRz5faHqlhGWaRL4ixb924KMHv/2sZwOkSzLazv7GdqeRjhHo7VDZevGqaImz5rjaPgQ1TOezM0vZan0OGG8+0OIoFBMePpfvjk1vUGpbIbv/hR5IkXGVvrNswPrdK+MpRWV7PfYoE2picgJhNktVHJFJhWRUj3Smhz9jYf8fwfUK5gspwtvwtg6UsenRDk0tcf9
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 14:18:08.6331
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd051bb6-9b19-4083-3f8c-08df40c7c6c5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6734.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LY0PR12MB635447

Before recovering a device, VFIO needs to stop new hardware accesses and
wait for operations already in progress to finish.

Give each open device an SRCU instance to track hardware accesses.
Enable SRCU access tracking only for devices with
pci_recovery_supported set.
Select and call the access operation within the same SRCU read-side
section. Keep copies to and from userspace outside that section so a
page fault cannot hold up recovery.

Introduce live and blocked tables. Initialize the ops pointer to blocked
when the device is created, and select live ops when open finishes.
Close uses a blocking transition that installs blocked ops and drains
SRCU readers before teardown. Open publishes live ops after setup.
Serialize these transitions with access_lock. Internal setup and cleanup
use their own helpers.

Provide an accessor for operations that use their existing synchronization
instead of SRCU. The accessor only returns the selected table. It does
not acquire a lock or keep the device's per-open resources alive.

Subsequent patches convert hardware access paths to these ops and add
support for host PCI error recovery using the same blocked table.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 drivers/vfio/pci/vfio_pci_priv.h | 15 ++++++
 include/linux/vfio_pci_core.h    | 10 ++++
 drivers/vfio/pci/vfio_pci_core.c | 86 ++++++++++++++++++++++++++++++++
 3 files changed, 111 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index 4e7162234a2e..97b69e4bc8be 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -73,6 +73,21 @@ u16 vfio_pci_memory_lock_and_enable(struct vfio_pci_core_device *vdev);
 void vfio_pci_memory_unlock_and_restore(struct vfio_pci_core_device *vdev,
 					u16 cmd);
 
+/* Operations receive kernel buffers only. User copies stay outside SRCU. */
+typedef long (*vfio_pci_access_fn)(struct vfio_pci_core_device *vdev,
+				 void *data);
+long vfio_pci_core_access(struct vfio_pci_core_device *vdev,
+			  vfio_pci_access_fn fn, void *data);
+
+struct vfio_pci_access_ops {
+	/* Select and call within SRCU. The callback receives kernel buffers. */
+	long (*execute)(struct vfio_pci_core_device *vdev,
+			vfio_pci_access_fn fn, void *data);
+};
+
+const struct vfio_pci_access_ops *
+vfio_pci_access_ops(struct vfio_pci_core_device *vdev);
+
 #ifdef CONFIG_VFIO_PCI_IGD
 bool vfio_pci_is_intel_display(struct pci_dev *pdev);
 int vfio_pci_igd_init(struct vfio_pci_core_device *vdev);
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 2f3fa2787737..88aa7b752231 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -14,6 +14,7 @@
 #include <linux/vfio.h>
 #include <linux/irqbypass.h>
 #include <linux/rcupdate.h>
+#include <linux/srcu.h>
 #include <linux/types.h>
 #include <linux/uuid.h>
 #include <linux/notifier.h>
@@ -97,6 +98,8 @@ static inline int vfio_pci_core_get_dmabuf_phys(
 }
 #endif
 
+struct vfio_pci_access_ops;
+
 struct vfio_pci_core_device {
 	struct vfio_device	vdev;
 	struct pci_dev		*pdev;
@@ -131,6 +134,7 @@ struct vfio_pci_core_device {
 	bool			disable_idle_d3:1;
 	bool			nointxmask:1;
 	bool			disable_vga:1;
+	bool			pci_recovery_supported:1;
 	/* Flags modified at runtime - dedicated storage unit */
 	bool			needs_reset;
 	bool			pm_intx_masked;
@@ -150,6 +154,12 @@ struct vfio_pci_core_device {
 	struct vfio_pci_core_device	*sriov_pf_core_dev;
 	struct notifier_block	nb;
 	struct rw_semaphore	memory_lock;
+	struct srcu_struct	access_srcu;
+	/* Updated under access_lock. */
+	const struct vfio_pci_access_ops __rcu *access_ops;
+	/* Set after open completes, cleared before close tears down state. */
+	bool			device_open;
+	struct mutex		access_lock;	/* protects changes to access ops and flags */
 	struct list_head	dmabufs;
 };
 
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index fcbb2da860e2..b7d81233b99b 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -312,6 +312,65 @@ static void vfio_pci_probe_power_state(struct vfio_pci_core_device *vdev)
 	vdev->needs_pm_restore = !(pmcsr & PCI_PM_CTRL_NO_SOFT_RESET);
 }
 
+static long vfio_pci_access_live(struct vfio_pci_core_device *vdev,
+				 vfio_pci_access_fn fn, void *data)
+{
+	return fn(vdev, data);
+}
+
+static long vfio_pci_access_blocked(struct vfio_pci_core_device *vdev,
+				    vfio_pci_access_fn fn, void *data)
+{
+	return -EIO;
+}
+
+static const struct vfio_pci_access_ops vfio_pci_live_ops = {
+	.execute = vfio_pci_access_live,
+};
+
+static const struct vfio_pci_access_ops vfio_pci_blocked_ops = {
+	.execute = vfio_pci_access_blocked,
+};
+
+/*
+ * The ops tables are static and remain valid across open and close.
+ * Ordinary access callbacks run through vfio_pci_core_access(), which
+ * holds SRCU across table selection and callback execution.
+ */
+const struct vfio_pci_access_ops *
+vfio_pci_access_ops(struct vfio_pci_core_device *vdev)
+{
+	if (!vdev->pci_recovery_supported)
+		return &vfio_pci_live_ops;
+	return rcu_dereference_raw(vdev->access_ops);
+}
+
+/* Block new operations and drain ordinary accesses before teardown or recovery. */
+static void vfio_pci_core_block_access(struct vfio_pci_core_device *vdev)
+{
+	lockdep_assert_held(&vdev->access_lock);
+	rcu_assign_pointer(vdev->access_ops, &vfio_pci_blocked_ops);
+
+	synchronize_srcu(&vdev->access_srcu);
+}
+
+long vfio_pci_core_access(struct vfio_pci_core_device *vdev,
+			  vfio_pci_access_fn fn, void *data)
+{
+	const struct vfio_pci_access_ops *ops;
+	long ret;
+	int idx;
+
+	if (!vdev->pci_recovery_supported)
+		return vfio_pci_live_ops.execute(vdev, fn, data);
+
+	idx = srcu_read_lock(&vdev->access_srcu);
+	ops = srcu_dereference(vdev->access_ops, &vdev->access_srcu);
+	ret = ops->execute(vdev, fn, data);
+	srcu_read_unlock(&vdev->access_srcu, idx);
+	return ret;
+}
+
 /*
  * pci_set_power_state() wrapper handling devices which perform a soft reset on
  * D3->D0 transition.  Save state prior to D0/1/2->D3, stash it on the vdev,
@@ -649,10 +708,18 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 	if (!vfio_vga_disabled(vdev) && vfio_pci_is_vga(pdev))
 		vdev->has_vga = true;
 
+	if (vdev->pci_recovery_supported) {
+		ret = init_srcu_struct(&vdev->access_srcu);
+		if (ret)
+			goto out_free_config;
+	}
+
 	vfio_pci_core_map_bars(vdev);
 
 	return 0;
 
+out_free_config:
+	vfio_config_free(vdev);
 out_free_zdev:
 	vfio_pci_zdev_close_device(vdev);
 out_free_state:
@@ -799,6 +866,9 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
 	/* Put the pm-runtime usage counter acquired during enable */
 	if (!vdev->disable_idle_d3)
 		pm_runtime_put(&pdev->dev);
+
+	if (vdev->pci_recovery_supported)
+		cleanup_srcu_struct(&vdev->access_srcu);
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_disable);
 
@@ -807,6 +877,13 @@ void vfio_pci_core_close_device(struct vfio_device *core_vdev)
 	struct vfio_pci_core_device *vdev =
 		container_of(core_vdev, struct vfio_pci_core_device, vdev);
 
+	if (vdev->pci_recovery_supported) {
+		scoped_guard(mutex, &vdev->access_lock) {
+			WRITE_ONCE(vdev->device_open, false);
+			vfio_pci_core_block_access(vdev);
+		}
+	}
+
 	if (vdev->sriov_pf_core_dev) {
 		mutex_lock(&vdev->sriov_pf_core_dev->vf_token->lock);
 		WARN_ON(!vdev->sriov_pf_core_dev->vf_token->users);
@@ -839,6 +916,12 @@ void vfio_pci_core_finish_enable(struct vfio_pci_core_device *vdev)
 		vdev->sriov_pf_core_dev->vf_token->users++;
 		mutex_unlock(&vdev->sriov_pf_core_dev->vf_token->lock);
 	}
+
+	if (vdev->pci_recovery_supported) {
+		guard(mutex)(&vdev->access_lock);
+		WRITE_ONCE(vdev->device_open, true);
+		rcu_assign_pointer(vdev->access_ops, &vfio_pci_live_ops);
+	}
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_finish_enable);
 
@@ -2183,6 +2266,8 @@ int vfio_pci_core_init_dev(struct vfio_device *core_vdev)
 	if (ret && ret != -EOPNOTSUPP)
 		return ret;
 	INIT_LIST_HEAD(&vdev->dmabufs);
+	mutex_init(&vdev->access_lock);
+	RCU_INIT_POINTER(vdev->access_ops, &vfio_pci_blocked_ops);
 	init_rwsem(&vdev->memory_lock);
 	xa_init(&vdev->ctx);
 
@@ -2197,6 +2282,7 @@ void vfio_pci_core_release_dev(struct vfio_device *core_vdev)
 
 	mutex_destroy(&vdev->igate);
 	mutex_destroy(&vdev->ioeventfds_lock);
+	mutex_destroy(&vdev->access_lock);
 	kfree(vdev->region);
 	kfree(vdev->pm_save);
 }
-- 
2.43.0

