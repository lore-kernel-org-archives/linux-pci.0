Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19806358D16
	for <linux-pci@vger.kernel.org>; Tue,  3 Mar 2026 00:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772496057; cv=none; b=CS03BrOn/fsIaHcmIJPtebPZXOEsmxhTlhc8mkBeld4pCV1FAxeAYIQJaOkSLANxlavjA+qlgy4CGj/kFXtOEbpZZgtswPIcLkf+XF3sJHnpylQyo92UxgXHfi0tojdds816k1IRXH7riImQL4GZHKeNjhzkv7YGZUELykkKznE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772496057; c=relaxed/simple;
	bh=1n96MsTFYt+0lf1K1FZL00OaK3eQpjrMWO7P7u6692M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aohkCzdMs67r2v9e96MaJcxYjSnPJlNod2+cQLg/Sx7iEvFRiDHdmbKjyhtrDVsCbXINQyFW7OZC5JiSxN00kKsRM2zWIr/1jWi2CYy1Gv0Ie8RKZhwOAI9MPfK03PQcBkGXj30ZdDgwADj6DkoUJ2UO1mBB/J2bwJ8EzEMLQis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NR/jLSvL; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NR/jLSvL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772496055; x=1804032055;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1n96MsTFYt+0lf1K1FZL00OaK3eQpjrMWO7P7u6692M=;
  b=NR/jLSvLsbOl0KcQyeSX4pf4xZmKchgdJFsB02wMqw+ksNfHbvoV3dun
   9qw1/HiqEFEuuy/He2p+/WXkl/8UUup89YB+kR5p/pYBvvc6NKsa6fMLy
   AU4//FvHiYAD5b81GBydq2vzd1lae+hPiHvLwf3wcgpCDbNRMzJiX4KCc
   scXyZP8kLnTqDbilLTGR8kDGv2QKFCnFJQU6/euNy+WTYzgHFpwbHg4lg
   l9h6BhUjmtG7wM+NY+j6sP7sj3kJjY8Am16wow2epeulsF6IdD8IrENrm
   hSTppTAKR3HcniUVBr2YfVk3yJXy2t0ZrK0mokqJKWrDuEGwZ+xammG09
   A==;
X-CSE-ConnectionGUID: 4Xk6CiKkTLW3d/oZ3eLKig==
X-CSE-MsgGUID: tbg80KqtRUOailP2PnXk3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="73482832"
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="73482832"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 16:00:54 -0800
X-CSE-ConnectionGUID: /mzito/PTxmr3IJutKcYdA==
X-CSE-MsgGUID: X9pbtQlWQ+mmvFcusZDnoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="214967070"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by fmviesa006.fm.intel.com with ESMTP; 02 Mar 2026 16:00:53 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	aik@amd.com,
	aneesh.kumar@kernel.org,
	yilun.xu@linux.intel.com,
	bhelgaas@google.com,
	alistair23@gmail.com,
	lukas@wunner.de,
	jgg@nvidia.com
Subject: [PATCH v2 01/19] PCI/TSM: Report active IDE streams per host bridge
Date: Mon,  2 Mar 2026 16:01:49 -0800
Message-ID: <20260303000207.1836586-2-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260303000207.1836586-1-dan.j.williams@intel.com>
References: <20260303000207.1836586-1-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first attempt at an ABI for this failed to account for naming
collisions across host bridges:

Commit a4438f06b1db ("PCI/TSM: Report active IDE streams")

Revive this ABI with a per host bridge link that appears at first stream
creation for a given host bridge and disappears after the last stream is
removed.

For systems with many host bridge objects it allows:

    ls /sys/class/tsm/tsmN/pci*/stream*

...to find all the host bridges with active streams without first iterating
over all host bridges. Yilun notes that is handy to have this short cut [1]
and from an administrator perspective it helps with inventory for
constrained stream resources.

Link: http://lore.kernel.org/aXLtILY85oMU5qlb@yilunxu-OptiPlex-7050 [1]
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/ABI/testing/sysfs-class-tsm | 13 +++
 include/linux/pci-ide.h                   |  2 +
 include/linux/tsm.h                       |  3 +
 drivers/pci/ide.c                         |  4 +
 drivers/virt/coco/tsm-core.c              | 97 +++++++++++++++++++++++
 5 files changed, 119 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-tsm b/Documentation/ABI/testing/sysfs-class-tsm
index 2949468deaf7..1ddb8f357961 100644
--- a/Documentation/ABI/testing/sysfs-class-tsm
+++ b/Documentation/ABI/testing/sysfs-class-tsm
@@ -7,3 +7,16 @@ Description:
 		signals when the PCI layer is able to support establishment of
 		link encryption and other device-security features coordinated
 		through a platform tsm.
+
+What:		/sys/class/tsm/tsmN/pciDDDD:BB
+Contact:	linux-pci@vger.kernel.org
+Description:
+		(RO) When a PCIe host bridge has established a secure connection
+		via a TSM to an endpoint, this symlink appears. It facilitates a
+		TSM instance scoped view of PCIe Link Encryption and Secure
+		Session resource consumption across host bridges. The symlink
+		appears when a host bridge has 1 or more IDE streams established
+		with this TSM, and disappears when that number returns to 0. See
+		Documentation/ABI/testing/sysfs-devices-pci-host-bridge for the
+		description of the pciDDDD:BB/streamH.R.E symlink and the
+		pciDDDD:BB/available_secure_streams attribute.
diff --git a/include/linux/pci-ide.h b/include/linux/pci-ide.h
index ae07d9f699c0..381a1bf22a95 100644
--- a/include/linux/pci-ide.h
+++ b/include/linux/pci-ide.h
@@ -82,6 +82,7 @@ struct pci_ide_regs {
  * @host_bridge_stream: allocated from host bridge @ide_stream_ida pool
  * @stream_id: unique Stream ID (within Partner Port pairing)
  * @name: name of the established Selective IDE Stream in sysfs
+ * @tsm_dev: For TSM established IDE, the TSM device context
  *
  * Negative @stream_id values indicate "uninitialized" on the
  * expectation that with TSM established IDE the TSM owns the stream_id
@@ -93,6 +94,7 @@ struct pci_ide {
 	u8 host_bridge_stream;
 	int stream_id;
 	const char *name;
+	struct tsm_dev *tsm_dev;
 };
 
 /*
diff --git a/include/linux/tsm.h b/include/linux/tsm.h
index 22e05b2aac69..a3b7ab668eff 100644
--- a/include/linux/tsm.h
+++ b/include/linux/tsm.h
@@ -123,4 +123,7 @@ int tsm_report_unregister(const struct tsm_report_ops *ops);
 struct tsm_dev *tsm_register(struct device *parent, struct pci_tsm_ops *ops);
 void tsm_unregister(struct tsm_dev *tsm_dev);
 struct tsm_dev *find_tsm_dev(int id);
+struct pci_ide;
+int tsm_ide_stream_register(struct pci_ide *ide);
+void tsm_ide_stream_unregister(struct pci_ide *ide);
 #endif /* __TSM_H */
diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
index 23f554490539..9629f3ceb213 100644
--- a/drivers/pci/ide.c
+++ b/drivers/pci/ide.c
@@ -11,6 +11,7 @@
 #include <linux/pci_regs.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
+#include <linux/tsm.h>
 
 #include "pci.h"
 
@@ -372,6 +373,9 @@ void pci_ide_stream_release(struct pci_ide *ide)
 	if (ide->partner[PCI_IDE_EP].enable)
 		pci_ide_stream_disable(pdev, ide);
 
+	if (ide->tsm_dev)
+		tsm_ide_stream_unregister(ide);
+
 	if (ide->partner[PCI_IDE_RP].setup)
 		pci_ide_stream_teardown(rp, ide);
 
diff --git a/drivers/virt/coco/tsm-core.c b/drivers/virt/coco/tsm-core.c
index 8712df8596a1..3c99c38cfaa5 100644
--- a/drivers/virt/coco/tsm-core.c
+++ b/drivers/virt/coco/tsm-core.c
@@ -4,10 +4,12 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/tsm.h>
+#include <linux/pci.h>
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/cleanup.h>
 #include <linux/pci-tsm.h>
+#include <linux/pci-ide.h>
 
 static struct class *tsm_class;
 static DEFINE_IDA(tsm_ida);
@@ -104,6 +106,100 @@ void tsm_unregister(struct tsm_dev *tsm_dev)
 }
 EXPORT_SYMBOL_GPL(tsm_unregister);
 
+static DEFINE_XARRAY(tsm_ide_streams);
+static DEFINE_MUTEX(tsm_ide_streams_lock);
+
+/* tracker for the bridge symlink when the bridge has any streams */
+struct tsm_ide_stream {
+	struct tsm_dev *tsm_dev;
+	struct pci_host_bridge *bridge;
+	struct kref kref;
+};
+
+static struct tsm_ide_stream *create_streams(struct tsm_dev *tsm_dev,
+					    struct pci_host_bridge *bridge)
+{
+	int rc;
+
+	struct tsm_ide_stream *streams __free(kfree) =
+		kzalloc(sizeof(*streams), GFP_KERNEL);
+	if (!streams)
+		return NULL;
+
+	streams->tsm_dev = tsm_dev;
+	streams->bridge = bridge;
+	kref_init(&streams->kref);
+	rc = xa_insert(&tsm_ide_streams, (unsigned long)bridge, streams,
+		       GFP_KERNEL);
+	if (rc)
+		return NULL;
+
+	rc = sysfs_create_link(&tsm_dev->dev.kobj, &bridge->dev.kobj,
+			       dev_name(&bridge->dev));
+	if (rc) {
+		xa_erase(&tsm_ide_streams, (unsigned long)bridge);
+		return NULL;
+	}
+
+	return no_free_ptr(streams);
+}
+
+int tsm_ide_stream_register(struct pci_ide *ide)
+{
+	struct tsm_ide_stream *streams;
+	struct pci_dev *pdev = ide->pdev;
+	struct pci_tsm *tsm = pdev->tsm;
+	struct tsm_dev *tsm_dev = tsm->tsm_dev;
+	struct pci_host_bridge *bridge = pci_find_host_bridge(pdev->bus);
+
+	guard(mutex)(&tsm_ide_streams_lock);
+	streams = xa_load(&tsm_ide_streams, (unsigned long)bridge);
+	if (streams)
+		kref_get(&streams->kref);
+	else
+		streams = create_streams(tsm_dev, bridge);
+
+	if (!streams)
+		return -ENOMEM;
+	ide->tsm_dev = tsm_dev;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tsm_ide_stream_register);
+
+static void destroy_streams(struct kref *kref)
+{
+	struct tsm_ide_stream *streams =
+		container_of(kref, struct tsm_ide_stream, kref);
+	struct tsm_dev *tsm_dev = streams->tsm_dev;
+	struct pci_host_bridge *bridge = streams->bridge;
+
+	lockdep_assert_held(&tsm_ide_streams_lock);
+	sysfs_remove_link(&tsm_dev->dev.kobj, dev_name(&bridge->dev));
+	xa_erase(&tsm_ide_streams, (unsigned long)bridge);
+	kfree(streams);
+}
+
+void tsm_ide_stream_unregister(struct pci_ide *ide)
+{
+	struct tsm_ide_stream *streams;
+	struct tsm_dev *tsm_dev = ide->tsm_dev;
+	struct pci_dev *pdev = ide->pdev;
+	struct pci_host_bridge *bridge = pci_find_host_bridge(pdev->bus);
+
+	guard(mutex)(&tsm_ide_streams_lock);
+	streams = xa_load(&tsm_ide_streams, (unsigned long)bridge);
+	/* catch API abuse */
+	if (dev_WARN_ONCE(&tsm_dev->dev,
+			  !streams || streams->tsm_dev != tsm_dev,
+			  "no IDE streams associated with %s\n",
+			  dev_name(&bridge->dev)))
+		return;
+	kref_put(&streams->kref, destroy_streams);
+	ide->tsm_dev = NULL;
+}
+EXPORT_SYMBOL_GPL(tsm_ide_stream_unregister);
+
 static void tsm_release(struct device *dev)
 {
 	struct tsm_dev *tsm_dev = container_of(dev, typeof(*tsm_dev), dev);
@@ -126,6 +222,7 @@ module_init(tsm_init)
 static void __exit tsm_exit(void)
 {
 	class_destroy(tsm_class);
+	xa_destroy(&tsm_ide_streams);
 }
 module_exit(tsm_exit)
 
-- 
2.52.0

