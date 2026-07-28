Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074D03AFB19
	for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 22:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785276636; cv=none; b=P1tuPfbCGG9pAtQf9yHwwN7OFZ1rUC5z5uQ0roBxJcE1DZglEqoBgHYGgImQJ0TezbUtikf5NMRvPeqxyirvcxGw672tJoiU8idwczrvKMRQDW4LGuhzKVFUThbNcFzXYKoZkdoW3qk5O7JOJqQkrnMDUISg7z0Ujjd6aHf569c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785276636; c=relaxed/simple;
	bh=FHnxSzR+eYzuTTd9rVvq7SPehF7Y1jgHdL4Ka9ai3TI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jEWOKGkldYKUbNcSGYrbt7IeE5guzhjLs8iK8Nrw5hZWwttzdMQBSnqm4z17h9IvBVp6vFJwXs7XJaZWjUIBtJ7tPMHinxLh2Jh7fxhom7CQqZctIIctg9DbHOktjR2cIN0PE4AZsycVMrkCCfP5Lsl7mNGfybfEffe1lHBb/mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BQMbe5lO; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BQMbe5lO"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38e2f61c09dso348378a91.2
        for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 15:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785276628; x=1785881428; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BE36iWi33jixVQVPZgLI2FSKm7HZpEzWwAe/nuPVtSc=;
        b=BQMbe5lOMFEG95tcaxeFECimcZkhq/qPVh1I4w79KVWcBCkp36iaeJfBXPGDke/N6s
         m6/5FYumoZB5efcjQymb6QvaJxCMIEKXXHfBDbciFTWzNdWkAkzCS6jC8UyZw7Q9hRrq
         vOmMhKKu9/QZ6ZdINqS51qRIk/vhGgb0XU5kfRuBBrYcqoaCi1PakyIz8FUyaat8SwMa
         9bgh4htBoBmmX5hF1ki4mcnXGWe+2zXrbTGpFRxYA/eVxTeMK2b+axlPsd7C9uo4XqlZ
         1yXYiwgHKBLeL4UsqranAVfS52dXr9KuuDILWPPMlXDX/m/YxLZy/ylcmeU+dSjL+2YJ
         jnfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785276628; x=1785881428;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BE36iWi33jixVQVPZgLI2FSKm7HZpEzWwAe/nuPVtSc=;
        b=GhTFsr6BC0gdRP2NuNnxqNmFDJOxbHxuBAmFU2BLX7aeeABeKAKgcqnkP2AI8bcTrD
         I9zezgbF5AoqmqiphYqEugrgWI401NeKXuSukSFgxUChFCld+as3RlNjiq2sDx/p6yjT
         KpQDfzI0nz9VrDFaLuTrskB2XUrN0I6NknOJ5h5DkgrNgRB2N3y/EDyjT9jArY1WKT+R
         PKmn0XbZe0/Mz4jUFt5A1WnTcb4J9KWZfCyaTXx3fUsNCiUcAWFXmf3LsbgHB69S4mdV
         7OhOD+Eue4q8uBZ3YhI5jBJw5QvUcBncw8BQi0EyQ29tilu/FI36lh7x9tWpkulU+Fy0
         enJw==
X-Forwarded-Encrypted: i=1; AHgh+RrqtA5R0HitMI5BTS2O9gKMeR3lk7Az4ALE6je2yY8k+/aTJ0tlDg1Q1yQItx6SwTs5YOON6x/Ddnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfMYkOkH6b+Z+aLjxnIJ9WO/49+57hzJlnvCL3wuaGORta4cHV
	jsYLZPtHU9wcwrySOxzraUIsX3MJvNfEOESltSAtt4++ott2RggTjUbV5FeXa8vVva21asWvc4o
	dQodThizeED6DDg==
X-Received: from pjbnh6.prod.google.com ([2002:a17:90b:3646:b0:381:c4e1:61f9])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3b41:b0:389:8f6c:4d70 with SMTP id 98e67ed59e1d1-38f6a4716aemr4404768a91.28.1785276627711;
 Tue, 28 Jul 2026 15:10:27 -0700 (PDT)
Date: Tue, 28 Jul 2026 22:10:02 +0000
In-Reply-To: <20260728221007.2098560-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260728221007.2098560-1-dmatlack@google.com>
X-Mailer: git-send-email 2.55.0.487.gaf234c4eb3-goog
Message-ID: <20260728221007.2098560-9-dmatlack@google.com>
Subject: [PATCH v8 08/12] PCI: liveupdate: Adopt ACS controls in incoming
 preserved devices
From: David Matlack <dmatlack@google.com>
To: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"

Adopt Access Control Services (ACS) controls on all incoming preserved
devices (endpoints and upstream bridges) during a Live Update.

Inheriting ACS flags avoids changing routing rules while memory
transactions are in flight from preserved devices. This is also strictly
necessary to ensure that IOMMU group assignments do not change during or
after Live Update.

Cache the inherited ACS controls established by the previous kernel in
struct pci_dev so that ACS controls do not change after a reset
(pci_restore_state() calls pci_enable_acs()).

To simplify ACS inheritance, reject preserving any devices that require
quirks to enable ACS as those quirks would also have to take Live Update
into account.

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/liveupdate.c       | 87 ++++++++++++++++++++++++++++++++++
 drivers/pci/liveupdate.h       | 11 +++++
 drivers/pci/pci.c              |  6 +++
 drivers/pci/pci.h              |  5 ++
 drivers/pci/quirks.c           |  7 +++
 include/linux/pci_liveupdate.h |  6 +++
 6 files changed, 122 insertions(+)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index 08e5ff8c1fe7..fb602dd3933e 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -71,6 +71,9 @@
  *
  *  * The device cannot be a Virtual Function (VF).
  *
+ *  * The device cannot require device-specific quirks to enable Access
+ *    Control Services (ACS).
+ *
  * Driver Binding
  * ==============
  *
@@ -113,6 +116,18 @@
  * This enables the PCI core and any drivers bound to the bridge to participate
  * in the Live Update so that preserved endpoints can continue issuing memory
  * transactions during the Live Update.
+ *
+ * Handling Preserved Devices
+ * ==========================
+ *
+ * The PCI core treats preserved devices differently than non-preserved devices.
+ * This section enumerates those differences.
+ *
+ *  * The PCI core adopts all ACS controls enabled on incoming preserved devices
+ *    rather than assigning new ones. This ensures that TLPs are routed the same
+ *    way after Live Update and ensures that IOMMU groups do not change. Note
+ *    that a device will use its adopted ACS controls for the lifetime of its
+ *    struct pci_dev (i.e. even after pci_liveupdate_finish()).
  */
 
 #define pr_fmt(fmt) "PCI: liveupdate: " fmt
@@ -128,6 +143,7 @@
 #include <linux/slab.h>
 
 #include "liveupdate.h"
+#include "pci.h"
 
 /**
  * struct pci_liveupdate_global - Global state for PCI Live Update support
@@ -417,6 +433,16 @@ static int pci_liveupdate_preserve_device(struct pci_flb_outgoing *outgoing,
 		return -EINVAL;
 	}
 
+	/*
+	 * Do not preserve devices that rely on device-specific ACS equivalents
+	 * (for now) since that would complicate keeping ACS constant across
+	 * Live Update.
+	 */
+	if (pci_need_dev_specific_enable_acs(dev)) {
+		pci_warn(dev, "Refusing to preserve device that relies on ACS quirks\n");
+		return -EINVAL;
+	}
+
 	if (dev->liveupdate.outgoing) {
 		if (!dev->liveupdate.outgoing->refcount) {
 			pci_WARN(dev, 1, "Preserved device with 0 refcount!\n");
@@ -668,6 +694,7 @@ void pci_liveupdate_setup_device(struct pci_dev *dev)
 
 	pci_info(dev, "Device was preserved by previous kernel across Live Update\n");
 	dev->liveupdate.incoming = dev_ser;
+	dev->liveupdate.was_preserved = true;
 	pci_liveupdate_flb_put_incoming();
 }
 
@@ -746,6 +773,66 @@ void pci_liveupdate_finish(struct pci_dev *dev)
 }
 EXPORT_SYMBOL_GPL(pci_liveupdate_finish);
 
+/**
+ * pci_liveupdate_cache_adopted_acs_controls() - Cache adopted ACS controls
+ * @dev: The PCI device to cache ACS controls from
+ *
+ * If @dev is an incoming Live Update device, read its current ACS configuration
+ * from hardware (which was set by the previous kernel) and cache it.
+ */
+void pci_liveupdate_cache_adopted_acs_controls(struct pci_dev *dev)
+{
+	guard(rwsem_read)(&pci_liveupdate.rwsem);
+
+	if (!dev->liveupdate.incoming)
+		return;
+
+	pci_read_config_word(dev, dev->acs_cap + PCI_ACS_CTRL, &dev->liveupdate.acs_ctrl);
+}
+
+/**
+ * pci_liveupdate_enable_adopted_acs_controls() - Enable adopted ACS controls
+ * @dev: The PCI device to enable adopted ACS controls for
+ *
+ * For devices preserved across a Live Update, write the cached ACS controls
+ * back into the hardware's ACS Capability. This ensures that the device
+ * continues to use the ACS rules established by the previous kernel.
+ *
+ * Return: 0 on success, or -EINVAL if the device was not preserved or requires
+ * device-specific quirks.
+ */
+int pci_liveupdate_enable_adopted_acs_controls(struct pci_dev *dev)
+{
+	u16 acs_ctrl = dev->liveupdate.acs_ctrl;
+	u16 acs_cap = dev->acs_cap;
+
+	/*
+	 * Check if the device was preserved over a previous Live Update (even
+	 * if it has already gone through pci_liveupdate_finish()). This ensures
+	 * that the device continues to use the ACS controls established by the
+	 * previous kernel.
+	 */
+	if (!dev->liveupdate.was_preserved)
+		return -EINVAL;
+
+	/*
+	 * The previous kernel should not have preserved any devices that
+	 * require device-specific quirks to enable ACS, but if such a device is
+	 * detected (e.g. new device-specific ACS quirk in the current kernel),
+	 * log a big warning and fall back to the normal enable ACS path.
+	 */
+	if (pci_need_dev_specific_enable_acs(dev)) {
+		pci_warn(dev, "Device-specific quirk required to enable ACS!\n");
+		WARN_ON_ONCE(true);
+		return -EINVAL;
+	}
+
+	if (acs_cap)
+		pci_write_config_word(dev, acs_cap + PCI_ACS_CTRL, acs_ctrl);
+
+	return 0;
+}
+
 /**
  * pci_liveupdate_is_incoming() - Check if a device is incoming-preserved
  * @dev: The PCI device to check
diff --git a/drivers/pci/liveupdate.h b/drivers/pci/liveupdate.h
index 107881183fda..ac5b8bf2edf5 100644
--- a/drivers/pci/liveupdate.h
+++ b/drivers/pci/liveupdate.h
@@ -16,6 +16,8 @@ void pci_liveupdate_cleanup_device(struct pci_dev *dev);
 bool pci_liveupdate_preserve_bus_numbers(struct pci_bus *bus,
 					 struct pci_dev *dev);
 void pci_liveupdate_scan_bridge_end(struct pci_dev *dev);
+void pci_liveupdate_cache_adopted_acs_controls(struct pci_dev *dev);
+int pci_liveupdate_enable_adopted_acs_controls(struct pci_dev *dev);
 #else
 static inline void pci_liveupdate_setup_device(struct pci_dev *dev)
 {
@@ -34,6 +36,15 @@ static inline bool pci_liveupdate_preserve_bus_numbers(struct pci_bus *bus,
 static inline void pci_liveupdate_scan_bridge_end(struct pci_dev *dev)
 {
 }
+
+static inline void pci_liveupdate_cache_adopted_acs_controls(struct pci_dev *dev)
+{
+}
+
+static inline int pci_liveupdate_enable_adopted_acs_controls(struct pci_dev *dev)
+{
+	return -EINVAL;
+}
 #endif
 
 #endif /* DRIVERS_PCI_LIVEUPDATE_H */
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 77b17b13ee61..22001bdf4c97 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -34,6 +34,8 @@
 #include <linux/aer.h>
 #include <linux/bitfield.h>
 #include <linux/suspend.h>
+
+#include "liveupdate.h"
 #include "pci.h"
 
 DEFINE_MUTEX(pci_slot_mutex);
@@ -1008,6 +1010,9 @@ void pci_enable_acs(struct pci_dev *dev)
 	bool enable_acs = false;
 	int pos;
 
+	if (!pci_liveupdate_enable_adopted_acs_controls(dev))
+		return;
+
 	/* If an iommu is present we start with kernel default caps */
 	if (pci_acs_enable) {
 		if (pci_dev_specific_enable_acs(dev))
@@ -3689,6 +3694,7 @@ void pci_acs_init(struct pci_dev *dev)
 
 	pci_read_config_word(dev, pos + PCI_ACS_CAP, &dev->acs_capabilities);
 	pci_disable_broken_acs_cap(dev);
+	pci_liveupdate_cache_adopted_acs_controls(dev);
 }
 
 /**
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4469e1a77f3c..988a18b3204a 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1047,6 +1047,7 @@ void pci_acs_init(struct pci_dev *dev);
 void pci_enable_acs(struct pci_dev *dev);
 #ifdef CONFIG_PCI_QUIRKS
 int pci_dev_specific_acs_enabled(struct pci_dev *dev, u16 acs_flags);
+bool pci_need_dev_specific_enable_acs(struct pci_dev *dev);
 int pci_dev_specific_enable_acs(struct pci_dev *dev);
 int pci_dev_specific_disable_acs_redir(struct pci_dev *dev);
 void pci_disable_broken_acs_cap(struct pci_dev *pdev);
@@ -1057,6 +1058,10 @@ static inline int pci_dev_specific_acs_enabled(struct pci_dev *dev,
 {
 	return -ENOTTY;
 }
+static inline bool pci_need_dev_specific_enable_acs(struct pci_dev *dev)
+{
+	return false;
+}
 static inline int pci_dev_specific_enable_acs(struct pci_dev *dev)
 {
 	return -ENOTTY;
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 7ac39ec2843e..99b819f38e49 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5473,6 +5473,13 @@ static const struct pci_dev_acs_ops *pci_dev_acs_ops_get(struct pci_dev *dev)
 	return NULL;
 }
 
+bool pci_need_dev_specific_enable_acs(struct pci_dev *dev)
+{
+	const struct pci_dev_acs_ops *p = pci_dev_acs_ops_get(dev);
+
+	return p && p->enable_acs;
+}
+
 int pci_dev_specific_enable_acs(struct pci_dev *dev)
 {
 	const struct pci_dev_acs_ops *p = pci_dev_acs_ops_get(dev);
diff --git a/include/linux/pci_liveupdate.h b/include/linux/pci_liveupdate.h
index fc1f5640968a..04a2b2a3102a 100644
--- a/include/linux/pci_liveupdate.h
+++ b/include/linux/pci_liveupdate.h
@@ -17,14 +17,20 @@
  * struct pci_liveupdate - PCI Live Update state for a struct pci_dev
  * @outgoing: State preserved for the next kernel.
  * @incoming: State preserved by the previous kernel.
+ * @acs_ctrl: ACS features established by the previous kernel.
  * @preserve_bus_numbers: True if the PCI core should preserve the secondary and
  *                        subordinate bus numbers assigned to this device due to
  *                        an ongoing Live Update.
+ * @was_preserved: True if this struct pci_dev was preserved by the previous
+ *                 kernel. Unlike @incoming, this field is not cleared after
+ *                 the device is finished participating in Live Update.
  */
 struct pci_liveupdate {
 	struct pci_dev_ser *outgoing;
 	struct pci_dev_ser *incoming;
+	u16 acs_ctrl;
 	bool preserve_bus_numbers;
+	bool was_preserved;
 };
 
 struct pci_dev;
-- 
2.55.0.487.gaf234c4eb3-goog

