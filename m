Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A17526ABE
	for <linux-pci@vger.kernel.org>; Fri, 18 Sep 2026 20:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789762024; cv=none; b=ZF/2/NQEPtzk5EpZaTSqvCT118+K/YTwdsIosMZ6fGHnG7WrDlG9GA/zbilFk1clnKSyqo4RAC9+50z7Os7yTJZDnGTokxD9CBLw0MZjzc1RH03o6UafeNnZnuNzxlBXwhlaQxT3l+vBo9EN00azeON6UtiGqAINKJUhy8ub+ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789762024; c=relaxed/simple;
	bh=R4Az/uRUuF1PiT5xSJs/E4kzyzqFdBSW3WJkEp2Js04=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cxNVxFsoZZmEeMeIGauls9SH/gg5zsJdBe8euvtkjN/II4bIvjuwtYMxBrUPcCAqyXz4O4iC08ixiU2JMcxgF82JgmyLMOTwPvN80qz3EzfYPotAZMqudydsbuFFXE0xnjUGGUyAE7ofAerO2ztUqj7Rk2IFNZhh9hkt9Qy56/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RzSGmqLp; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RzSGmqLp"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc1cade6b71so1140414a12.0
        for <linux-pci@vger.kernel.org>; Fri, 18 Sep 2026 13:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789762021; x=1790366821; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9ZcqrsSF0ioZzw9gFyyhQYx/Js3WyQJlrd8b2TpGaYs=;
        b=RzSGmqLpCtG5g6LeEX9pvglnVRXlzVQoqbaVXexeJ0VU7mhlxWnvLnEaPI70ioWj2Y
         DTMS86vDme7ulFFMBBMb6GcHg0AU0W49Aiob5b69y5nUab7hxhBbM1i/kXNVvribigCP
         H8rGoUJeMpCucAXzzhWjVIfgKi0/aOqjafCguw/pBxFoMR8nqAP8A3/USbeAHTpARAs9
         JjyHmR+It1jsNPWLrDcs5TXu9X5FkR1xkhc877Rgm+xRiYop3bDm+uyyLj84wFdX5751
         jN5YnaSg9ZCc3fp14K1bu8sFkQMCSzmYaXMOAyGJMmKzKXZc/XseQK4RI4prCw0Azarl
         U2Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789762021; x=1790366821;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9ZcqrsSF0ioZzw9gFyyhQYx/Js3WyQJlrd8b2TpGaYs=;
        b=fks1ivZr2k8mNdk3MpUX0Prw4d9m7+hL9YYHMKlcDm6VIDWhh2r8mg2gDr/QZNwV7y
         q/ADn91C0GyEpdYnSwkphbPHvbhClejsUX19Zw6HRhT0WJbgbuP089u+bySpal6DGYH6
         AQjUEBVFx5WykE7wvAau7Nc8rivfWSwrOuy0YmpynMaiAOpCNd4Up0/ybL2MA2BQtjwD
         22mnGMFdfTYu5IEUl/tcp+kml8Q/NmxD+QZZFzacAfxywXYS2NYPsUpHPr1aJwpqBTQy
         yGht2BxldyLntoVsNTtiUGLduzDTwF+WU+9d4F0p4cpTMs9LF9uo4EseBAZW1//37GDB
         6EEw==
X-Forwarded-Encrypted: i=1; AKwUvBw/SNIytJT6Kw8XJaEX/umLvvshjPlGIM0TpEQLNre3BLoB64h0l4ROPEIi2rOCyM3cRV67PLB9hnw=@vger.kernel.org
X-Gm-Message-State: AFuF++nc23BD6eQgCrlHwsqdjqoWwuYxx6P+aKiF3J885l3vY+JlU5QM
	YlFuC8GgoN5afmdjhVvszUlhNWkmBQS6Acab1ravZlTTeiO4aqwqVFvY45pymoAKGl5Gh/owXvM
	bxDUUduT/qBa/5w==
X-Received: from pgvn14.prod.google.com ([2002:a65:63ce:0:b0:cc1:bda2:d0a3])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:7017:b0:3c8:e304:99d0 with SMTP id adf61e73a8af0-3dd721125e9mr11870192637.0.1789762021113;
 Fri, 18 Sep 2026 13:07:01 -0700 (PDT)
Date: Fri, 18 Sep 2026 20:06:35 +0000
In-Reply-To: <20260918200640.887030-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260918200640.887030-1-dmatlack@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260918200640.887030-10-dmatlack@google.com>
Subject: [PATCH v9 09/13] PCI: liveupdate: Adopt ACS controls in incoming
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
	Pratyush Yadav <pratyush@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"

Adopt Access Control Services (ACS) controls on all incoming preserved
devices (endpoints and upstream bridges) during a Live Update.

Inheriting ACS flags avoids changing routing rules while memory
transactions are in flight from preserved devices. This is also strictly
necessary to ensure that IOMMU group assignments do not change during or
after Live Update.

The adopted controls are recorded by the pci_save_state() call in
pci_bus_add_device(), which runs before drivers bind, so they are
automatically reapplied by pci_restore_state() if the device is reset.
If that save buffer could not be allocated there is nowhere to record
the adopted controls, and they would be silently lost by the first
reset. Program ACS from scratch in that case, which is a better outcome
than leaving ACS disabled.

To simplify ACS inheritance, reject preserving any devices that require
quirks to enable ACS as those quirks would also have to take Live Update
into account.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/liveupdate.c | 78 ++++++++++++++++++++++++++++++++++++++++
 drivers/pci/liveupdate.h |  6 ++++
 drivers/pci/pci.c        |  5 +++
 3 files changed, 89 insertions(+)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index 686887a6c8d9..0145399b3834 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -123,6 +123,9 @@
  *
  *  * The device cannot be a Virtual Function (VF).
  *
+ *  * The device cannot require device-specific quirks to enable Access
+ *    Control Services (ACS).
+ *
  * Driver Binding
  * ==============
  *
@@ -174,6 +177,18 @@
  * bus, since the bus numbers of the failed bridge can no longer be read from
  * hardware and handing them to another bridge would let an unrelated device
  * inherit the BDF of a preserved device.
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
@@ -189,6 +204,7 @@
 #include <linux/slab.h>
 
 #include "liveupdate.h"
+#include "pci.h"
 
 /**
  * struct pci_liveupdate_global - Global state for PCI Live Update support
@@ -502,6 +518,16 @@ static int pci_liveupdate_preserve_device(struct pci_flb_outgoing *outgoing,
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
 	/*
 	 * Endpoint devices should not be preserved more than once.
 	 * Bridges are preserved once for every downstream device that
@@ -826,6 +852,58 @@ void pci_liveupdate_finish(struct pci_dev *dev)
 }
 EXPORT_SYMBOL_GPL(pci_liveupdate_finish);
 
+/**
+ * pci_liveupdate_adopt_acs() - Adopt ACS controls
+ * @dev: The PCI device to adopt ACS controls for
+ *
+ * For devices preserved across a Live Update, leave the ACS controls
+ * established by the previous kernel alone instead of programming new ones.
+ * The adopted controls are recorded by the pci_save_state() call in
+ * pci_bus_add_device(), so they are reapplied by pci_restore_state() if the
+ * device is subsequently reset.
+ *
+ * Return: 0 on success, or -EINVAL if the device was not preserved, requires
+ * device-specific quirks, or has nowhere to record the adopted controls.
+ */
+int pci_liveupdate_adopt_acs(struct pci_dev *dev)
+{
+	/*
+	 * Check if the device was preserved over a previous Live Update (even
+	 * if it has already gone through pci_liveupdate_finish()). This ensures
+	 * that the device continues to use the ACS controls established by the
+	 * previous kernel.
+	 */
+	if (!dev->liveupdate.was_incoming)
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
+	/*
+	 * Adopting the previous kernel's controls depends on them being
+	 * captured in the ACS save buffer, so that they are reapplied if the
+	 * device is later reset. Without that buffer, e.g. because it could
+	 * not be allocated under memory pressure, the adopted controls would
+	 * be silently lost by the first reset. Program ACS from scratch
+	 * instead, which is a better outcome than leaving ACS disabled.
+	 */
+	if (dev->acs_cap && !pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_ACS)) {
+		pci_err(dev, "No ACS save buffer, not adopting ACS controls\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 /**
  * pci_liveupdate_is_incoming() - Check if a device is incoming-preserved
  * @dev: The PCI device to check
diff --git a/drivers/pci/liveupdate.h b/drivers/pci/liveupdate.h
index e5d2a19d2ca2..d4721ffcecb2 100644
--- a/drivers/pci/liveupdate.h
+++ b/drivers/pci/liveupdate.h
@@ -15,6 +15,7 @@ void pci_liveupdate_setup_device(struct pci_dev *dev);
 void pci_liveupdate_cleanup_device(struct pci_dev *dev);
 bool pci_liveupdate_preserve_bus_numbers(void);
 bool pci_liveupdate_refuse_bus_numbers(struct pci_bus *bus, struct pci_dev *dev);
+int pci_liveupdate_adopt_acs(struct pci_dev *dev);
 #else
 static inline void pci_liveupdate_setup_device(struct pci_dev *dev)
 {
@@ -34,6 +35,11 @@ static inline bool pci_liveupdate_refuse_bus_numbers(struct pci_bus *bus,
 {
 	return false;
 }
+
+static inline int pci_liveupdate_adopt_acs(struct pci_dev *dev)
+{
+	return -EINVAL;
+}
 #endif
 
 #endif /* DRIVERS_PCI_LIVEUPDATE_H */
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index dd25c01736b4..47d8229115b8 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -35,6 +35,8 @@
 #include <linux/aer.h>
 #include <linux/bitfield.h>
 #include <linux/suspend.h>
+
+#include "liveupdate.h"
 #include "pci.h"
 
 DEFINE_MUTEX(pci_slot_mutex);
@@ -1080,6 +1082,9 @@ void pci_enable_acs(struct pci_dev *dev)
 	bool enable_acs = false;
 	int pos;
 
+	if (!pci_liveupdate_adopt_acs(dev))
+		return;
+
 	/* If an iommu is present we start with kernel default caps */
 	if (pci_acs_enable) {
 		if (pci_dev_specific_enable_acs(dev))
-- 
2.55.0.1082.g2b9226bbc0-goog

