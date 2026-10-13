Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA9051B18C
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 16:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791908750; cv=none; b=aUgvgTcd1AlhSGwH8JxTJDFd/ZJwPJ+GA0BZpcurSmHFT90Bx1J3i554DUyhDDviCNNFmznISaXEWbJ15+rnujsGMe6E2hfdbIxd2d74IPMPYdyLMq8MofSRzILQ5M8sbgBeGgOY7XncwwJmoOmCkjQM5henayekrs92BhdqPQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791908750; c=relaxed/simple;
	bh=4X+S1ZH32Ejax5jbL60Olx8aZAiC9O5mfuV/0CBXLMc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=A+1q9cTk8QxChz8romYn7zZwgga3zdOKuOwgcN17cqXd9INI874osslGxF8P2zfkb9LNNL8rbUOPmW7b/47Eekzu9wEhLytZkFRdOYdbXYis9hdndguxM31NtaFzL0BTRD/pN6dx4TmCfGCsJk2WuHZT1q3TnML1My7Edtn2dv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GX3m76mj; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GX3m76mj"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2e6188d1e51so39228385ad.0
        for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 09:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791908745; x=1792513545; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nMZY6hne5ICVXiyWI18wg5NrB0TiBOxG7wJ7j+K7UmM=;
        b=GX3m76mjPFI150L7NbgBOixFvOfrcmk7ZjNs1KU3OBGMxtwZXKrDQgPVH7ff8y3q03
         7wkYBxkQ5d6EHH8t3za/8IMMv3nvZnmVk8MZlx2DaOhtaVCRIIPlBCdIz9OEY/FUATNy
         A78pcy5/g7bfDO2wAeiiVELp4K8mIyaggna0dbytXPPPfkvo5tL5Z2nOT1C0pmvEkpOl
         Wc4ZWRPyPmRQOIxD8F6+TxyhBDck4xzg1gWeXgblMIoD24x60HuSLvK6ouoPFD44GOm4
         yw2/RYB4ZdvSSXUovqy+k+/fL5+TiOm0EDRtobCHW7MpfclnFDNYH6Fp1i2mC4Jamyup
         3TWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791908745; x=1792513545;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nMZY6hne5ICVXiyWI18wg5NrB0TiBOxG7wJ7j+K7UmM=;
        b=e/N27b2WHa62MkIKT1G6CZogeJquT+lI7AAte/R1rsMlDB2rOcxOtCQgRRORdjLQrX
         V+VxpoKxCqAoNulrSjMu3OGh5joruO51M/lsaXGcElZTSZBRp/bAZr1oYxMahp2CDlhN
         uX/fcrTnduH2M9U4BP+UVyZIFiAG+bAp4im4Rmm0FZ8jO43CGqgeomqitNaOu0p9hSX8
         Hgudlujawlg0fuc9ZFf5L5fcohWEDelGXCqHqRQgCRQUdP/3e4roHfFEHER2sgCYnkyg
         FQWZ3+8Nm+dwwlRYQplumtbY4/SBOd95BynDLGDjlPOvfz4Z1kFqSeTp5cP+igsm7UbE
         DGpQ==
X-Forwarded-Encrypted: i=1; AKwUvBzpp1eo/PDXrwGgyt9qEj5mxvtuAWlZ5/E1Tp5EGeA8EI/jP39ZScRwOqrnbnWhwgm7V42XESvG2xY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIFd8bzaaQUeMGo6v0IcQGKyopfdV8gO7dJOAVADE8/5Pdguujl
	85Njel/YFmwU50ue4XCxlpF3B2e95A5npaqlxWYshnVZLryR7E2PWM0ksU96YXf/DHB6VunVujT
	x9mxm+TeUGpmDuw==
X-Received: from plgt1.prod.google.com ([2002:a17:902:e841:b0:2e4:cc48:2a25])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:3550:b0:2e5:cb9d:3207 with SMTP id d9443c01a7336-2e842805bcdmr115538865ad.1.1791908745197;
 Tue, 13 Oct 2026 09:25:45 -0700 (PDT)
Date: Tue, 13 Oct 2026 16:25:25 +0000
In-Reply-To: <20261013162529.1928093-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261013162529.1928093-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261013162529.1928093-10-dmatlack@google.com>
Subject: [PATCH v10 09/13] PCI: liveupdate: Adopt ACS controls in incoming
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
index 8d5ad26e948c..1d2324d339da 100644
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
@@ -520,6 +536,16 @@ static int pci_liveupdate_preserve_device(struct pci_flb_outgoing *outgoing,
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
@@ -844,6 +870,58 @@ void pci_liveupdate_finish(struct pci_dev *dev)
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
index 944590fdef48..650d7f92f93a 100644
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
@@ -1164,6 +1166,9 @@ void pci_enable_acs(struct pci_dev *dev)
 	bool enable_acs = false;
 	int pos;
 
+	if (!pci_liveupdate_adopt_acs(dev))
+		return;
+
 	/* If an iommu is present we start with kernel default caps */
 	if (pci_acs_enable) {
 		if (pci_dev_specific_enable_acs(dev))
-- 
2.56.0.385.gd3acb90ef8-goog

