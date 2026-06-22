Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCB436EAB2;
	Mon, 22 Jun 2026 07:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782114343; cv=none; b=qDvYDVf35vLdKT/UszTuzfmYJ8gGi2YivMsaiwH+EMAsYGDKru8B82Wb5YHrT2cdkVmXCOCjmfSj9gLoVAIovpCd7UV2OslLNCozCVvxDy+ly5odENv0hzt+cGnNJxj5L2ll22NmZ4VP49vmJX50lQtNLZWcChR+CPB74z3hKwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782114343; c=relaxed/simple;
	bh=gGQtPLQNgyw1QnJc0KcmR+nX5FnipvxpQ0RMhD+xKro=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qtlupE1U7ZdBFgQas5FDRFgo81Pig+hpFfLG707Fb9Ms2riBoPPsn4IgrZALcs8pcPm82yVIzR+c7tcl3dzbH4qEu0jglhIqqby12dlUgCa3mLfFyfQcpsaJcdB4BryC31o0qT0Mm1MN+A6gCvwyiPdAjZapld0kBJaJSB/sd2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=DWIZPgs5; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="DWIZPgs5"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=+gNp84iL2JLpVuAjQy/FRZDmEA9yVf4gqt3WOg0gOWs=;
	b=DWIZPgs5G24PIZW3aRe8SlqoX57l/E8np2Ld/tmAWgXs1R0fVmRUBmwwUb5N6izXaDXM1uAAs
	9wwgtMiZdgw7Aw0uiYcB4UaJ6S+mp+oENWuNrz2KbQPkyJIysear8EbaHR6yVMmTeyGkVd8LDuI
	JEVRdOUuXTJm0B1OMIhanOQ=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gkKlN0Dh8znTXr;
	Mon, 22 Jun 2026 15:36:48 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 185514056C;
	Mon, 22 Jun 2026 15:45:33 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 22 Jun 2026 15:45:32 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>, <helgaas@kernel.org>
CC: <wathsala.vithanage@arm.com>, <wei.huang2@amd.com>, <zhipingz@meta.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v18 10/12] vfio/pci: Add TPH_ENABLE feature skeleton and unsafe module parameter
Date: Mon, 22 Jun 2026 15:45:21 +0800
Message-ID: <20260622074523.38473-11-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260622074523.38473-1-fengchengwen@huawei.com>
References: <20260622074523.38473-1-fengchengwen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemo500009.china.huawei.com (7.202.194.199)

Introduce module param enable_unsafe_tph to gate all TPH related features,
and add VFIO_DEVICE_FEATURE_TPH_ENABLE uapi together with per-device
tph_permit flag.

This is a preparatory implementation: only feature framework is added
for now, actual TPH_CTRL register permission control and steering tag
features (TPH_CPU_ST / TPH_ST_CONFIG) will be attached in subsequent
TPH capability virtualization commits.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/vfio/pci/vfio_pci.c        | 13 ++++++++++++-
 drivers/vfio/pci/vfio_pci_config.c |  1 +
 drivers/vfio/pci/vfio_pci_core.c   | 25 ++++++++++++++++++++++++-
 include/linux/vfio_pci_core.h      |  4 +++-
 include/uapi/linux/vfio.h          |  7 +++++++
 5 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 0c771064c0b8..6d73668459cf 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -60,6 +60,12 @@ static bool disable_denylist;
 module_param(disable_denylist, bool, 0444);
 MODULE_PARM_DESC(disable_denylist, "Disable use of device denylist. Disabling the denylist allows binding to devices with known errata that may lead to exploitable stability or security issues when accessed by untrusted users.");
 
+#ifdef CONFIG_PCIE_TPH
+static bool enable_unsafe_tph;
+module_param(enable_unsafe_tph, bool, 0444);
+MODULE_PARM_DESC(enable_unsafe_tph, "Enable PCIe TPH (Transaction Processing Hints) support. It may break platform isolation. If you do not know what this is for, step away. (default: false)");
+#endif
+
 static bool vfio_pci_dev_in_denylist(struct pci_dev *pdev)
 {
 	switch (pdev->vendor) {
@@ -257,12 +263,17 @@ static int __init vfio_pci_init(void)
 {
 	int ret;
 	bool is_disable_vga = true;
+	bool is_enable_unsafe_tph = false;
 
 #ifdef CONFIG_VFIO_PCI_VGA
 	is_disable_vga = disable_vga;
 #endif
+#ifdef CONFIG_PCIE_TPH
+	is_enable_unsafe_tph = enable_unsafe_tph;
+#endif
 
-	vfio_pci_core_set_params(nointxmask, is_disable_vga, disable_idle_d3);
+	vfio_pci_core_set_params(nointxmask, is_disable_vga, disable_idle_d3,
+				 is_enable_unsafe_tph);
 
 	/* Register and scan for devices */
 	ret = pci_register_driver(&vfio_pci_driver);
diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
index 5c6ab172df6c..251d3ec7fdd4 100644
--- a/drivers/vfio/pci/vfio_pci_config.c
+++ b/drivers/vfio/pci/vfio_pci_config.c
@@ -1783,6 +1783,7 @@ int vfio_config_init(struct vfio_pci_core_device *vdev)
 		goto out;
 
 	vdev->bardirty = true;
+	vdev->tph_permit = false;
 
 	/*
 	 * XXX can we just pci_load_saved_state/pci_restore_state?
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index a28f1e99362c..b0193afca875 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -41,6 +41,7 @@
 static bool nointxmask;
 static bool disable_vga;
 static bool disable_idle_d3;
+static bool enable_unsafe_tph;
 
 static void vfio_pci_eventfd_rcu_free(struct rcu_head *rcu)
 {
@@ -1554,6 +1555,24 @@ static int vfio_pci_core_feature_token(struct vfio_pci_core_device *vdev,
 	return 0;
 }
 
+static int vfio_pci_core_feature_tph_enable(struct vfio_pci_core_device *vdev,
+					    u32 flags, size_t argsz)
+{
+	int ret;
+
+	if (!enable_unsafe_tph)
+		return -EOPNOTSUPP;
+
+	ret = vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_SET, 0);
+	if (ret <= 0)
+		return ret;
+
+	if (!vdev->tph_permit)
+		vdev->tph_permit = 1;
+
+	return 0;
+}
+
 int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
 				void __user *arg, size_t argsz)
 {
@@ -1572,6 +1591,8 @@ int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
 		return vfio_pci_core_feature_token(vdev, flags, arg, argsz);
 	case VFIO_DEVICE_FEATURE_DMA_BUF:
 		return vfio_pci_core_feature_dma_buf(vdev, flags, arg, argsz);
+	case VFIO_DEVICE_FEATURE_TPH_ENABLE:
+		return vfio_pci_core_feature_tph_enable(vdev, flags, argsz);
 	default:
 		return -ENOTTY;
 	}
@@ -2615,11 +2636,13 @@ static void vfio_pci_dev_set_try_reset(struct vfio_device_set *dev_set)
 }
 
 void vfio_pci_core_set_params(bool is_nointxmask, bool is_disable_vga,
-			      bool is_disable_idle_d3)
+			      bool is_disable_idle_d3,
+			      bool is_enable_unsafe_tph)
 {
 	nointxmask = is_nointxmask;
 	disable_vga = is_disable_vga;
 	disable_idle_d3 = is_disable_idle_d3;
+	enable_unsafe_tph = is_enable_unsafe_tph;
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_set_params);
 
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 5fc6ce4dd786..d551e530dd86 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -128,6 +128,7 @@ struct vfio_pci_core_device {
 	bool			pm_intx_masked:1;
 	bool			pm_runtime_engaged:1;
 	bool			sriov_active;
+	bool			tph_permit;
 	struct pci_saved_state	*pci_saved_state;
 	struct pci_saved_state	*pm_save;
 	int			ioeventfds_nr;
@@ -158,7 +159,8 @@ int vfio_pci_core_register_dev_region(struct vfio_pci_core_device *vdev,
 				      const struct vfio_pci_regops *ops,
 				      size_t size, u32 flags, void *data);
 void vfio_pci_core_set_params(bool nointxmask, bool is_disable_vga,
-			      bool is_disable_idle_d3);
+			      bool is_disable_idle_d3,
+			      bool is_enable_unsafe_tph);
 void vfio_pci_core_close_device(struct vfio_device *core_vdev);
 int vfio_pci_core_init_dev(struct vfio_device *core_vdev);
 void vfio_pci_core_release_dev(struct vfio_device *core_vdev);
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 5de618a3a5ee..e5a4d1d7091b 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -1534,6 +1534,13 @@ struct vfio_device_feature_dma_buf {
  */
 #define VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2  12
 
+/*
+ * Device-level opt-in for TPH (Transaction Processing Hints) support.
+ * When set, allows access to TPH_CPU_ST and TPH_ST_CONFIG features.
+ * Requires global enable_unsafe_tph module parameter to be enabled.
+ */
+#define VFIO_DEVICE_FEATURE_TPH_ENABLE	13
+
 /* -------- API for Type1 VFIO IOMMU -------- */
 
 /**
-- 
2.17.1

