Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011017.outbound.protection.outlook.com [40.107.208.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED28A479876;
	Tue,  1 Sep 2026 09:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788255242; cv=fail; b=Uo98wS7sS/4Gx7OLQqMyC4cOnNwFDx5+MdtUXX16pa2OlEGH9xUJzYFOnbjwkMC8vLbP6wTc3Uug8QLfNpfi9ZZEbCBZdcQ2AC5Y0oRutgilbfFO1ga6n7Td57VGvySxZayGgG/Ati+siq0bnrPdEAgxFMvsrdMsmoQBXD+PFGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788255242; c=relaxed/simple;
	bh=Iw4gEiXk5lRr2qefpjCONKqU6fA/t+be5+41zix5pvQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mpKGFJOb1HI/WP1NlZFTMsF2bZvUOFf8mY8zvpHSQyAMXpFbtr2BJKxW6G74WvpGzHYzfnr2s+JRBh2ro6UShjj9fEqRmIMzBD01GkXMYCkTZmAaBjsVqcw32DMCgFDdkNt+oE9senricsTg+miK5W83NLM7U+7lMA11JtrU+Wc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XaDHWJIn; arc=fail smtp.client-ip=40.107.208.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XaDHWJIn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KCHvjzF74TtUcnS/OSclkyk8C8MjnCwHgiqhGcb0Qll0QxCVTWy6boXEoAcPFdKRednoah6CoTvNMPTlg8QB40y5ZbAiHS41OT4mg0zYjT4uTOKYT477fBz98bF9npBDkseAl8IrlszrsayoNEZ5IRRcpOUniWnAmPP5arPTVKJZLHoiATwRYJbMybXs38dhbQtv4sJAmOIzjV/A50AEuY1dUoJzxjgOF0h/Cm9ykZR/nRnQ5qetLiwsjF/q/vHYvcM9RXkXlPU5O68UaXmlQLOVu4T9I/fafvxnSvJjWlXYo9p1htffwjbqNtM17HyCSU3N9cDq9oCRjqSCXHhOqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JhaNg42w3D8r+kjVMls62vmV4oSyLHZtbFn3wn45MN8=;
 b=Xy/N3bpEwRQ7ix6U4no4RXcMOrMWhMCGaH0kVrdXsKEEAJ7mSvQyr3tyVVI01RscfbWjWxE4+k6IWBDqXfmllICV0zUvGP6ih05rk7cwoZ+9Yy4I/a4EmCfZ4/AdVl3XvYwPTzwIA/LRslcw+/92dkXMVdoHyhLHkKs63FnHd+ETyR8h59IgGl1EaHdM1wPoC+ngzd3Gq4Vt5HN6xJDJu1z7v3Vu68OejvBasc6cG1pegMqAs7wjiR2kGQKm+BmFoOl107QBitdllLEoVSUJkEJts4WWGPTd1hx1XZZaR9LJFrSKqCRiPUWlZU42yjwnK7oBCYRBVeU0bCaTsFsFwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JhaNg42w3D8r+kjVMls62vmV4oSyLHZtbFn3wn45MN8=;
 b=XaDHWJInkjudh0TiWNbK7RmSpU+gMjGpT72cn5DQ1JPK5ZG/k/slmrtPsaD7Wx4eCxPSDYjpWhT/vih0rfqiMQifXVRb42hAafW2FObIFGdQR6O9ElaLxPMwtFSxxwVRIZNCBcEmYGWvuGe8X+r47ZPg59U2jZojdT85xl3h+0/myIs1DFhSKDJhaFbv3+XUcnwYiTxX95TI4J5iqcaK5/SMKSNY+x+ux5I8YxLsXNZ49ywN4OBnUiUkbN2lrXxrTCqSxnC+m6e7Q76lPqiIgoxAOVKQUJak9hXfo6umdLZVI1CMCSldW40SNiDSw0iCJSSwCdkUN5LsVIdtrNgJqg==
Received: from CH0P220CA0023.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::25)
 by IA0PR12MB8326.namprd12.prod.outlook.com (2603:10b6:208:40d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 09:33:43 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:ef:cafe::a5) by CH0P220CA0023.outlook.office365.com
 (2603:10b6:610:ef::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Tue, 1
 Sep 2026 09:33:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 09:33:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 02:33:28 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 02:33:25 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kbusch@meta.com>, <michal.winiarski@intel.com>,
	<satyanarayana.k.v.p@intel.com>, <sonangp@nvidia.com>, <nathanc@nvidia.com>,
	<mochs@nvidia.com>
Subject: [RFC PATCH 04/19] vfio/pci: Serialize function reset with recovery
Date: Tue, 1 Sep 2026 10:32:02 +0100
Message-ID: <20260901093217.8539-5-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901093217.8539-1-skolothumtho@nvidia.com>
References: <20260901093217.8539-1-skolothumtho@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|IA0PR12MB8326:EE_
X-MS-Office365-Filtering-Correlation-Id: 74c63cee-cc91-4b1c-da07-08df080c1d28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|6133799003|56012099006|10067099003|11063799006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	E7Sl2qdOC8Xst5m+ialE7bMcXs8ns5dvElUL/Idz0cxSNphVyV4o1w5u7ZODowGAs1+0uTzivizA2iez+vobebTyfxYGma/7k20rnQ50qF4/+Np+dO4C1ZiSdI6GVWm/srpnmjrpf14HlKChGAb0VRETc6rh1jeYFtK3G8ycoN8PIrrXKZdS2ec1j3WEnwvkkNGT03rXAoFN92tJEEBOze7lI8QozBffYwkW0n4ebDhje7dz+FlfKq/eZkWwZKd7ZzuLSjOwC0jRkw72Qu9/CWdg/PRyaZ/2dwvHmqZsTNAFURqWJGG0pYwtYG4HPsZD8D3Vr7iBSYnUUQKSDdZyrKOk2Pp7mUtEiZVEaITr0YQwnEbza7I2+RNu8v1rd26dgS75sht/0QP8redK6HlAXFlTfRoKtLLzi7GfzMW0Ycebf3knE7dzB1qgCiLGO/Kg5pEPmVCpaa5n/JbMUv+d+1craq2C8YQwd0fZk/zw4xAQ6OqK/jHqqBJ6T3+Xv+rzxZoJ5p0qZRJidJ1BMOI5jwcM46I24L+nULzfeYjjf+Bs/GVt8rhpW7NHf/OkOZQsbEq+o/chBU1Cm7Tyv2mNC8OnsOY6CePwI9lrEpmGEHKZvRCczepRv/j81PiiesEI/6yc3xlrlhIRaVj0UgpEs0Wbc8v7RYIabe/Wh7/kZiOtHuOs1Bebc2mwYZj7pnQ5t0QDTAwPI3pex7wyYCp/JQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(6133799003)(56012099006)(10067099003)(11063799006)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	a1ZbyUklArfNGIy1Sg1mIQNV3HYLljoBuoSkGLOQTvL47Oet2GSTTzp2nFnFfGA4sxVPZpVbEjIV2DyQd49D4lYZAHNxIw6DQYPPV7ROzEbeWahNykOB4rzpFDPKRz1te8/j4KCBuJpwYXioUK4JtDNPNQtzZHl8GePTC2p2GePvWe2bPevb+FNIfotF6QE6n72/PShcIUebWaphK+ut497PCXuRh539rawUCiZwGngMET4htQw/4VVzmkUrwvGrwTOjX50fSME1tvQY+hsgFBDWoBa768AerXlRPuP/PkEiQyn+Z6CbF0uSQH6iL4WSN3d7mySjo7Qtahs00n827/OA14yai/E/4Ifbup0ejeE+SQ8+HFo3gaBzfCoAkTK3iDeTsjsB+ObeIxoACkMxl/9jfBlG7MBETQwcGrbUOmeDJD5XevvceiLL5Ky0woyN
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 09:33:43.0233
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74c63cee-cc91-4b1c-da07-08df080c1d28
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8326

Add a function reset helper and use it for VFIO_DEVICE_RESET. A later
patch routes the guest triggered config space FLR through it as well.
That path never did the power state transition, so make it optional.

With recovery enabled, take recovery_lock for writing, refuse the reset
with -EBUSY if access is already blocked, otherwise block access and drop
the lock again before revoking mappings or running the reset.
recovery_lock cannot be held across the reset because a reset method can
take pci_bus_sem, and the PCI error callbacks take recovery_lock from
under it.

Dropping it is safe in both directions. The error callbacks hold
recovery_lock for their whole body, so one already running has finished
before the reset starts. One which arrives while the lock is down runs
its own event, and the PCI core calls it with the device lock held, which
pci_try_reset_function() also takes, so it cannot overlap the reset
itself.

Only unblock access at the end for a reset which is still the one
blocking it. An event which started meanwhile owns the state from then
on, and resume() is what ends it.

With recovery not enabled, leave access_blocked alone. Two concurrent
resets still serialize on memory_lock, same as today. Setting the flag
for a device which never opted in would turn a working VFIO_DEVICE_RESET
into -EBUSY.

Access stays blocked until the reset is done and memory state is back,
and the wait queue is woken once it clears. A later patch adds the BAR
fault path, which waits there rather than failing the fault while a
reset is in flight.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 drivers/vfio/pci/vfio_pci_priv.h |  3 ++
 drivers/vfio/pci/vfio_pci_core.c | 85 +++++++++++++++++++++++++++++---
 2 files changed, 82 insertions(+), 6 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index 6daf51669d05..8a7f9fe22386 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -41,6 +41,9 @@ ssize_t vfio_pci_config_rw_single(struct vfio_pci_core_device *vdev,
 				  char __user *buf, size_t count, loff_t *ppos,
 				  bool iswrite);
 
+int vfio_pci_try_reset_function(struct vfio_pci_core_device *vdev,
+				bool reset_power_state);
+
 ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 			size_t count, loff_t *ppos, bool iswrite);
 
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 4194d44d6530..3645daa8891f 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1379,14 +1379,53 @@ static int vfio_pci_ioctl_set_irqs(struct vfio_pci_core_device *vdev,
 	return ret;
 }
 
-static int vfio_pci_ioctl_reset(struct vfio_pci_core_device *vdev,
-				void __user *arg)
+int vfio_pci_try_reset_function(struct vfio_pci_core_device *vdev,
+				bool reset_power_state)
 {
+	struct pci_dev *pdev = vdev->pdev;
+	bool enabled = false;
+	bool supported = vdev->pci_recovery_supported;
 	int ret;
 
-	if (!vdev->reset_works)
-		return -EINVAL;
+	/*
+	 * Claim the device against recovery before resetting it. The PCI
+	 * error callbacks hold recovery_lock for their whole body, so taking
+	 * it for writing here waits for one already running, and
+	 * access_blocked keeps a later one away while the lock is dropped.
+	 */
+	if (supported) {
+		down_write(&vdev->recovery_lock);
+		if (!vdev->pci_recovery_device_open) {
+			ret = -ENODEV;
+			goto out_recovery;
+		}
 
+		enabled = vdev->pci_recovery_enabled;
+
+		/*
+		 * Only claim access_blocked when recovery is enabled.
+		 * error_detected() returns early for a device which has not
+		 * enabled it, so there is nothing to exclude, and claiming it
+		 * anyway would fail the second of two concurrent
+		 * VFIO_DEVICE_RESET calls with -EBUSY.
+		 */
+		if (enabled) {
+			if (vdev->pci_recovery_access_blocked) {
+				ret = -EBUSY;
+				goto out_recovery;
+			}
+			WRITE_ONCE(vdev->pci_recovery_access_blocked, true);
+		}
+		up_write(&vdev->recovery_lock);
+	}
+
+	/*
+	 * On a device which supports recovery, taking recovery_lock for
+	 * writing above waited for anything already past its access check,
+	 * and if recovery is enabled access_blocked keeps new ones out. Do
+	 * not hold recovery_lock while taking memory_lock or running a reset
+	 * method, since a reset can take pci_bus_sem.
+	 */
 	vfio_pci_zap_and_down_write_memory_lock(vdev);
 
 	/*
@@ -1398,15 +1437,49 @@ static int vfio_pci_ioctl_reset(struct vfio_pci_core_device *vdev,
 	 * reset without restoring the original state (saved locally in
 	 * 'vdev->pm_save').
 	 */
-	vfio_pci_set_power_state(vdev, PCI_D0);
+	if (reset_power_state)
+		vfio_pci_set_power_state(vdev, PCI_D0);
 
 	vfio_pci_dma_buf_move(vdev, true);
-	ret = pci_try_reset_function(vdev->pdev);
+	ret = pci_try_reset_function(pdev);
 	if (__vfio_pci_memory_enabled(vdev))
 		vfio_pci_dma_buf_move(vdev, false);
 	up_write(&vdev->memory_lock);
 
+	if (enabled) {
+		down_write(&vdev->recovery_lock);
+		/*
+		 * An error callback can have started an event while the lock
+		 * was down. Leave the state to it. Only unblock access for a
+		 * reset which is still the one holding it.
+		 */
+		if (vdev->pci_recovery_device_open &&
+		    !(vdev->pci_recovery_flags & (VFIO_PCI_RECOVERY_IN_PROGRESS |
+						  VFIO_PCI_RECOVERY_FAILED)))
+			WRITE_ONCE(vdev->pci_recovery_access_blocked, false);
+		up_write(&vdev->recovery_lock);
+		/*
+		 * Access is blocked for the length of the reset, so anything
+		 * waiting for it to clear has to be woken here. A later patch
+		 * adds the BAR fault path which waits on this.
+		 */
+		wake_up_all(&vdev->pci_recovery_wait);
+	}
+
 	return ret;
+
+out_recovery:
+	up_write(&vdev->recovery_lock);
+	return ret;
+}
+
+static int vfio_pci_ioctl_reset(struct vfio_pci_core_device *vdev,
+				void __user *arg)
+{
+	if (!vdev->reset_works)
+		return -EINVAL;
+
+	return vfio_pci_try_reset_function(vdev, true);
 }
 
 static int vfio_pci_ioctl_get_pci_hot_reset_info(
-- 
2.43.0

