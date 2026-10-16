Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011061.outbound.protection.outlook.com [52.101.52.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2F85293ED;
	Fri, 16 Oct 2026 16:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792167735; cv=fail; b=BHjQJ5/A9SW+x4uXG/Kxp4ZxJeb/zP2x2Z65mxpUmv5MntIsgoqMqvEl9eX3aOkAIrfBZSuuF5awmecNxI7+OUN5FdePFpRbvpwTEPin7DII1mXhVjQYA5BCrK3jglRY1oZTJahSn05Ah/EOYNilIcawenT4/YpuKQAu6w91eME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792167735; c=relaxed/simple;
	bh=G2xsFMLpRuYqJW2m99Soit1qXw52hXP2RoNDabypgVU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g/IkHKpUg5/julBIdzYchUsNrRQ3x7VeMxv2PyhUIZ9c3+dRi6UJNoEGVB1YdI061/aPn6tUAYi064WF80QGq0gTVsYFRpE+LEYyLcSu441odn9IhjfEcexpiegy+U3tAQ+KM4Ky3o6bQRYAeptGNu9EEO6GtWa2qRUII9QyeNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Dnmybfi+; arc=fail smtp.client-ip=52.101.52.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Dnmybfi+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kTY/gE5kWW9cUB0KOfGGI4/l4sTX+MUxsOCShaoh4Jqapk7nBBuxVWNCWoVYCoEeKB8aB+7s0PE7RZIY0+hjek9V1mkYtqO35zZB6uG9CelwS/oQuy7l6Bc3P6blpBFlDIZ2MOpKDSeyU1UI4hCz7oFMCoZseYba++FylUoU3oMpXTP4ZKpus5neKE6H31obheiDex611CADL4sImO5Xx301aE50xSGXvosMIiyIADgXuw8WqAs4EoQKQ1U/jLH5BFEBwWOlcQg8A5gCdDzqGsw+SaHBVFSNMMBGSzSA/qePz3fmnJXsbezCG45+CI0KcNmYjbbQt7qHLdKYTwNpQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ybObwtKhRIQI3OWCUbkvFW3+NqjKrHblMljMPMshk3Q=;
 b=CEyzudfatmNUZTip6o4hoiAkHUCNoE9Yawgivf9+KGEe1GTUSWwo1CzRtWVRZT6XvrHrHaGgZoBGDygqc06jWksSnUI1KlSspHcN1bwREOTvXPMHAdthqexkelCL5jzDGD2lZN25ePhei0woD2vKS7BfBR4p9WOtLkgmhlcJnk2uFa9utS00UDW1tFrEuShVjGWt2Q86ws+ur3pqoWFESHEYBhOkgi71x+XTcyfOdwRlS21ACaBz1Q6l2Z9R/suVFR0Gufy6tlcmyhgbXA7ZCFkB7yE8zYoti2AQvGohzqesE/okJADCmjxYVv3fqczIAvGIchQWuEX4jXzYzXVsyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ybObwtKhRIQI3OWCUbkvFW3+NqjKrHblMljMPMshk3Q=;
 b=Dnmybfi+IoTaLDTgXIRiatNItnThshVWvGbSDHX8xhQLwme8uZ+F3PBfl78ZzyU890MBfWPXoq8X2Ph1YAjHcBN7c5YBF3+x6aenx/yrNN9FGawTBWV+GB523C71D7uKQ4yim/ZELUsiGBq8WD43fL7yRrUcAd0hGq0REe7lxdJ3C+nRHhBFmJo36vNPY7IwC4/N9PrPtlP1SenBV0v6YxjbKaE+ax01tLwCWd2vPjyzxTehvP3BGGtpldw6P6jw3ueY1zNduvxA8cBxybmWbN7RDei41ln9kFTk4aNbF4+pY+EPHNNmm4lseC8nT7wt0quliExvQo0Ji3DyXfaasQ==
Received: from MN2PR03CA0005.namprd03.prod.outlook.com (2603:10b6:208:23a::10)
 by LV0PR12MB659346.namprd12.prod.outlook.com (2603:10b6:408:608::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Fri, 16 Oct
 2026 16:22:08 +0000
Received: from BN7PEPF000000A4.namprd05.prod.outlook.com
 (2603:10b6:208:23a:cafe::68) by MN2PR03CA0005.outlook.office365.com
 (2603:10b6:208:23a::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Fri, 16
 Oct 2026 16:22:08 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN7PEPF000000A4.mail.protection.outlook.com (10.167.245.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 16:22:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 16 Oct
 2026 09:21:35 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 09:21:26 -0700
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
Subject: [PATCH v6 17/31] vfio/pci: Call the device provider across low-power transitions
Date: Fri, 16 Oct 2026 21:48:24 +0530
Message-ID: <20261016161839.2765592-18-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN7PEPF000000A4:EE_|LV0PR12MB659346:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c19fe2a-ae48-46b6-d576-08df2ba19fdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|7416014|22082099003|18002099003|10067099003|921020|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	9wb/QYToQqYEDCpq51TD9XZEovH7+syq0BlvpNAQv6adqSj9HAxVN7+hftPJ5QpsXp+HUQSIdTdCkKKgqDhdCZk+YkiVJu9/T7OwGf7xVPgLDA+l688BTsvTriVZvdI7ntD3XzOMfXUaUROEABy2glUi9go3Wh3RP4Z3Fke0nshnPalmm02dsc91dYGR07OYKxB9KqaJQuhU4CPdYC99a0G+UmeGJgcoGhbkeXL/vxXlbfQ4oM18iEmpAO/6f7U6Yp3QOGzQWCisDfJSb5RVj662KZb+bIc1/Uu9nQpX8dLD6SmhuetzLAQN/q+p39z1xIWZRPNpzaooEF0r2ACP6afIKXONtrgndVQGWUFwlY3ciUsdkQhRyh6uvPoEwu+B1BoYg+HOK2V7xSZ1ZDjo4dzN9jXS0a+xwLVsxvtSF12mizOQrn2SeHp4USagbIQLYIGay8skVtckjsYCTW+W+hFx8BxgmfxzSujEcur12QEI1PTnaqOsaNn8CLBDnkYtTEZtSd1JTB/zMdjiOpodNwYpiEImTUNaGGE4VaTbZD5ymrZcq0Xt4VyniU/LvWFj0Cg82x5fDNj5LpfPWJWrJ1soR+gp25AOIZsT6vI7V/y3rbp9eDcBwkLWf+x6OsKjbnd5tAodytjzir8ezIPx7Dx5wlXqlua+GJ+sMoM7PJnZZYaM00FPaqXFg1blczS4CFCVXyWkuYXz3i2XmoOAAJR2qPCCtFtpXwT9Wjugo0P/pQ4wcvmW7SL7zr5P5SiC
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(7416014)(22082099003)(18002099003)(10067099003)(921020)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+veP+tkr4yEjCAcLLA4UlbM5cViaXYW4kypO7XdtRs1yuXZJaRLDIw63qkoyURkV64v3zESq/RxsEi7TsSINfShYn62ecGsPR+nkcr9N2XOyYIukNTIgO1b2JBHRNKxPRo1cOFsgTEMnwsKwFT7XvgsZ60r/St7BkRLokZHe1+zD+cFHc3C4nYhPTlQ2uJZJsuGB/GzfxoOwecW3Z120z2/uI25uEuKngodkfmocgBK9MxyHRn8w5wNY3/MR8EJdK5R/0ZvNw8gyUU8x88QKWdffvLFC2u+7TrKQ4oB7M1hJHwsxrc3vXChJAHg+yJ91m11hUVXrECHfw0f4Pg/g6teJ3meIawWY8cFgHBUj9hBalesr1fE7htxnb4CGPLDssNqu8cR5FQvdydjLGzRtJ+a1pT2Ldwz8yeS0azLJTuNdtXO9iyZUpURshHajmjNT
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 16:22:08.0005
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c19fe2a-ae48-46b6-d576-08df2ba19fdf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF000000A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB659346

From: Manish Honap <mhonap@nvidia.com>

A provider may serve state that does not survive low power. A CXL Type-2
device loses its committed HDM decoder in D3hot or D3cold, and the HDM
memory region must stay out of use until the host restores the decoder.
Without a hook the provider can only keep the device in D0.

Add optional power_down and power_up ops. vfio-pci-core calls power_down
with memory_lock held for write before the device leaves D0: in
vfio_pci_set_power_state() for a lower state, and in runtime suspend
before the PCI core moves the device to low power. It calls power_up
with memory_lock held after the device is back in D0 with its config
space restored: after a guest PM control write returns the device to D0,
and in runtime resume. If a request for a lower state leaves the device
in D0, because the transition failed or a quirk keeps it there,
vfio-pci-core calls power_up at once.

The other paths that return a device to D0 either reset it afterwards
(close, VFIO_DEVICE_RESET and the hot reset ioctl), where the provider
restores its state, or tear it down (unregister).

Suggested-by: Alex Williamson <alex@shazbot.org>
Assisted-by: LLM
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/vfio/pci/vfio_pci_config.c |  4 +++
 drivers/vfio/pci/vfio_pci_core.c   | 40 +++++++++++++++++++++++++++++-
 drivers/vfio/pci/vfio_pci_priv.h   |  1 +
 include/linux/vfio_pci_core.h      |  7 ++++++
 4 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
index 6fbece95cb9f..ec556921ecd4 100644
--- a/drivers/vfio/pci/vfio_pci_config.c
+++ b/drivers/vfio/pci/vfio_pci_config.c
@@ -712,6 +712,8 @@ static int __init init_pci_cap_basic_perm(struct perm_bits *perm)
 static void vfio_lock_and_set_power_state(struct vfio_pci_core_device *vdev,
 					  pci_power_t state)
 {
+	pci_power_t prev = vdev->pdev->current_state;
+
 	if (state >= PCI_D3hot) {
 		vfio_pci_zap_and_down_write_memory_lock(vdev);
 		vfio_pci_dma_buf_move(vdev, true);
@@ -720,6 +722,8 @@ static void vfio_lock_and_set_power_state(struct vfio_pci_core_device *vdev,
 	}
 
 	vfio_pci_set_power_state(vdev, state);
+	if (state == PCI_D0 && prev > PCI_D0)
+		vfio_pci_provider_power_up(vdev);
 	if (__vfio_pci_memory_enabled(vdev))
 		vfio_pci_dma_buf_move(vdev, false);
 	up_write(&vdev->memory_lock);
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 9d0c22a4f3c6..be2acab625c0 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -318,10 +318,31 @@ static void vfio_pci_probe_power_state(struct vfio_pci_core_device *vdev)
  * by PM capability emulation and separately from pci_dev internal saved state
  * to avoid it being overwritten and consumed around other resets.
  */
+/*
+ * A provider whose device state does not survive low power is told before
+ * the device leaves D0 and after it is back in D0 with its config space
+ * restored. Both run with memory_lock held for write.
+ */
+static void vfio_pci_provider_power_down(struct vfio_pci_core_device *vdev)
+{
+	lockdep_assert_held_write(&vdev->memory_lock);
+
+	if (vdev->cxl_ops && vdev->cxl_ops->power_down)
+		vdev->cxl_ops->power_down(vdev);
+}
+
+void vfio_pci_provider_power_up(struct vfio_pci_core_device *vdev)
+{
+	lockdep_assert_held_write(&vdev->memory_lock);
+
+	if (vdev->cxl_ops && vdev->cxl_ops->power_up)
+		vdev->cxl_ops->power_up(vdev);
+}
+
 int vfio_pci_set_power_state(struct vfio_pci_core_device *vdev, pci_power_t state)
 {
 	struct pci_dev *pdev = vdev->pdev;
-	bool needs_restore = false, needs_save = false;
+	bool needs_restore = false, needs_save = false, powered_down = false;
 	int ret;
 
 	/* Prevent changing power state for PFs with VFs enabled */
@@ -329,6 +350,11 @@ int vfio_pci_set_power_state(struct vfio_pci_core_device *vdev, pci_power_t stat
 		lockdep_assert_held_write(&vdev->memory_lock);
 		if (vdev->sriov_active)
 			return -EBUSY;
+
+		if (pdev->current_state == PCI_D0) {
+			vfio_pci_provider_power_down(vdev);
+			powered_down = true;
+		}
 	}
 
 	if (vdev->needs_pm_restore) {
@@ -366,6 +392,14 @@ int vfio_pci_set_power_state(struct vfio_pci_core_device *vdev, pci_power_t stat
 		}
 	}
 
+	/*
+	 * The device stayed in D0: the transition failed, or a quirk keeps it
+	 * there. No later D0 transition will call power_up, so undo power_down
+	 * now.
+	 */
+	if (powered_down && pdev->current_state == PCI_D0)
+		vfio_pci_provider_power_up(vdev);
+
 	return ret;
 }
 
@@ -502,6 +536,8 @@ static int vfio_pci_core_runtime_suspend(struct device *dev)
 	 * (saved locally in 'vdev->pm_save').
 	 */
 	vfio_pci_set_power_state(vdev, PCI_D0);
+	/* The PCI core moves the device to low power once this returns. */
+	vfio_pci_provider_power_down(vdev);
 	up_write(&vdev->memory_lock);
 
 	/*
@@ -526,6 +562,8 @@ static int vfio_pci_core_runtime_resume(struct device *dev)
 	 * low power mode.
 	 */
 	down_write(&vdev->memory_lock);
+	/* The PCI core has restored the config space of the device. */
+	vfio_pci_provider_power_up(vdev);
 	if (vdev->pm_wake_eventfd_ctx) {
 		eventfd_signal(vdev->pm_wake_eventfd_ctx);
 		__vfio_pci_runtime_pm_exit(vdev);
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index 23bccfbb7eb7..411adc2ba379 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -78,6 +78,7 @@ void vfio_config_free(struct vfio_pci_core_device *vdev);
 
 int vfio_pci_set_power_state(struct vfio_pci_core_device *vdev,
 			     pci_power_t state);
+void vfio_pci_provider_power_up(struct vfio_pci_core_device *vdev);
 
 void vfio_pci_zap_and_down_write_memory_lock(struct vfio_pci_core_device *vdev);
 int vfio_pci_try_reset_function(struct vfio_pci_core_device *vdev);
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 7dd93ef103cb..ec1660e0d6d2 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -94,6 +94,13 @@ struct vfio_cxl_ops {
 	 * saves it first, the close path keeps the open-time copy.
 	 */
 	int	(*reset)(struct vfio_pci_core_device *vdev);
+	/*
+	 * Optional. Called with memory_lock held for write before the device
+	 * leaves D0, and after it returns to D0 with its config space
+	 * restored. power_down may be called again while already powered down.
+	 */
+	void	(*power_down)(struct vfio_pci_core_device *vdev);
+	void	(*power_up)(struct vfio_pci_core_device *vdev);
 	/* Pinned per bound CXL device so vfio-cxl cannot unload under usage */
 	struct module *owner;
 };
-- 
2.53.0

