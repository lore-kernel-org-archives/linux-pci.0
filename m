Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2673BE632
	for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 21:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783718798; cv=none; b=GyBzq+7n0GMM0e6vEKlN1z04ZvUl/7OZgb0TTQq2bM9Akp7EjZw2yGEVz5HHEzkWCHESfv8LsmhAiUqVhB3+F8n+VWN6CnN0MELtIH7LcWUbIlKre7BCcs2qxnc4IzlRLwlx0t1vZPlE4/tYU4MKuY5ZGdlh7jpGiynJsO3R2Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783718798; c=relaxed/simple;
	bh=pra37XY1BGogOvBFAEnb6quSKA6WjTBoHKuKMwccp6Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J1UXO//cCeVYBcuZg9TNd4ddOvl9kBLDOJT9RtVq6vANT83fIiWVuHQuot1qK8UDcScwi1zMQlv0v8V0dTOuKYrcdw4Ggxqf7qkxCOdhZ0MLaB9TcMz/N04IM+Xwn5PwBXVVtWm+9/IGA75qzdIYitlUIblp0O79hIzZZFpEdoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A8sBo6/y; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A8sBo6/y"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2cae455cf6dso17910815ad.2
        for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 14:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783718790; x=1784323590; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vyFHddSgtH+5JtZtRXs5kryYSNhZjQ+wgfA9vuynw+w=;
        b=A8sBo6/yCojZ7Im+QR1tXLk8XuyEfIcbS7exSBCgEJKUcA6zYFbTdLd1OLIiUY5589
         lN7ERE1czorgXnn5BeYxg+NjHy5Nq0Ci41EsSQFFOIg3dGu+UNCBlVYQn4x9IhvTcfCZ
         bzcphMZVSa2vBRq7Eb5e7i6os3+pQ1Kp5tBXcqnz0yOdgPpHxI/bPdOf7z8KCu/lNxas
         MqJXvVlh1vI30kQ8qm5Gatwrt0RUzte17VDVY9W+1hpnk+5iT/G6sPjzDjtTBJiMmNvR
         W2z2klLlMaNiAhI/1tbkakqyfg/o8YPdk28s5BIqK+BPzwGqeyfaAy8NoxN2pqj8w5Jk
         2NNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783718790; x=1784323590;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vyFHddSgtH+5JtZtRXs5kryYSNhZjQ+wgfA9vuynw+w=;
        b=GAl3/zPGxfRd0xvjWbflpPWHtb3bCcKztOyS10MG75i7KwGfJtBMnbMJG0tpILVPuJ
         cZNED1/873qSAi6rSfbsQvWuRLxQbw/rLE3DDgXF9ma0GUGmHCO6jqEPWtqVa1YUc3ZK
         5EZT/8V/SwhicHdc/X62figCN3H4aGh9gdykg2AYWZVthk+H4+HE7yGFNp5jgLAJMyHb
         DLgJx0mZZMBDcA586cAaGaIVAPH7GMBn9xuyyD5p+t+oov7dRYPJgldDM/DL5n2CabEe
         0bpSUJ0G9RjMcFwxYO9GF5T3U3mzZRyka8IdrG3wtNNoq2OtZaOZwSZf5xpfjx36sWNM
         PgXg==
X-Forwarded-Encrypted: i=1; AHgh+RqORcwp8VY9k8f8oo+9FEyshW0SZ4pqVnSmKEdHAahQvMlYeidGMWH+p8DD3/FPpaxJ1auWmrMb1Hg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhmFCnTsCogUFWQq7z82h9WRRdjkIbR8wTYNHpBBngFDSxdSZW
	geafoSlI6GsieUaMO+olBwp2pNgqBhETGofRGN1u7cvSbWlJxlZQuf5k7LWmoLen+L0ZgMW12mr
	flQw1p5EyyVAlXg==
X-Received: from pldd21.prod.google.com ([2002:a17:902:c195:b0:2c8:4c1:883a])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:32ce:b0:2c9:fa31:84f9 with SMTP id d9443c01a7336-2ce9e9a6c80mr7580575ad.5.1783718789594;
 Fri, 10 Jul 2026 14:26:29 -0700 (PDT)
Date: Fri, 10 Jul 2026 21:26:11 +0000
In-Reply-To: <20260710212616.1351130-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260710212616.1351130-1-dmatlack@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260710212616.1351130-9-dmatlack@google.com>
Subject: [PATCH v7 08/12] PCI: liveupdate: Inherit ACS flags in incoming
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

Inherit Access Control Services (ACS) flags on all incoming preserved
devices (endpoints and upstream bridges) during a Live Update.

Inheriting ACS flags avoids changing routing rules while memory
transactions are in flight from preserved devices. This is also strictly
necessary to ensure that IOMMU group assignments do not change across
a Live Update for preserved devices, as changing ACS configurations can
split or merge IOMMU groups.

Cache the inherited ACS controls established by the previous kernel in
struct pci_dev so that ACS controls do not change after a reset
(pci_restore_state() calls pci_enable_acs()).

To simplify ACS inheritance, reject preserving any devices that require
quirks to enable ACS as those quirks would also have to take Live Update
into account.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/liveupdate.c       | 68 ++++++++++++++++++++++++++++++++++
 drivers/pci/liveupdate.h       | 11 ++++++
 drivers/pci/pci.c              |  6 +++
 drivers/pci/pci.h              |  5 +++
 drivers/pci/quirks.c           |  7 ++++
 include/linux/pci_liveupdate.h |  6 +++
 6 files changed, 103 insertions(+)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index 7f7710cb1da0..a95bfe5eff77 100644
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
+ *  * The PCI core inherits all ACS flags enabled on incoming preserved devices
+ *    rather than assigning new ones. This ensures that TLPs are routed the same
+ *    way after Live Update and ensures that IOMMU groups do not change. Note
+ *    that a device will use its inherited ACS flags for the lifetime of its
+ *    struct pci_dev (i.e. even after pci_liveupdate_finish()).
  */
 
 #define pr_fmt(fmt) "PCI: " KBUILD_BASENAME ": " fmt
@@ -128,6 +143,7 @@
 #include <linux/slab.h>
 
 #include "liveupdate.h"
+#include "pci.h"
 
 /**
  * struct pci_liveupdate_global - Global state for PCI Live Update support
@@ -374,6 +390,16 @@ static int __pci_liveupdate_preserve_device(struct pci_flb_outgoing *outgoing, s
 {
 	struct pci_dev_ser *dev_ser;
 
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
 	dev_ser = pci_get_empty_or_append(outgoing);
 	if (IS_ERR(dev_ser))
 		return PTR_ERR(dev_ser);
@@ -655,6 +681,7 @@ void pci_liveupdate_setup_device(struct pci_dev *dev)
 
 	pci_info(dev, "Device was preserved by previous kernel across Live Update\n");
 	dev->liveupdate.incoming = dev_ser;
+	dev->liveupdate.was_preserved = true;
 
 	/*
 	 * Hold the ref on the incoming FLB until pci_liveupdate_finish() so
@@ -748,6 +775,47 @@ void pci_liveupdate_finish(struct pci_dev *dev)
 }
 EXPORT_SYMBOL_GPL(pci_liveupdate_finish);
 
+void pci_liveupdate_init_acs(struct pci_dev *dev)
+{
+	guard(rwsem_read)(&pci_liveupdate.rwsem);
+
+	if (!dev->acs_cap || !dev->liveupdate.incoming)
+		return;
+
+	pci_read_config_word(dev, dev->acs_cap + PCI_ACS_CTRL, &dev->liveupdate.acs_ctrl);
+}
+
+int pci_liveupdate_enable_acs(struct pci_dev *dev)
+{
+	u16 acs_ctrl = dev->liveupdate.acs_ctrl;
+	u16 acs_cap = dev->acs_cap;
+
+	/*
+	 * Use liveupdate.was_preserved instead of liveupdate.incoming since the
+	 * device's ACS controls should not change even after the device is
+	 * finished participating in the Live Update.
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
index c763255a8de4..4e8a01bcb4bb 100644
--- a/drivers/pci/liveupdate.h
+++ b/drivers/pci/liveupdate.h
@@ -16,6 +16,8 @@ void pci_liveupdate_cleanup_device(struct pci_dev *dev);
 bool pci_liveupdate_scan_bridge_begin(struct pci_bus *bus, struct pci_dev *dev,
 				      int pass);
 void pci_liveupdate_scan_bridge_end(struct pci_dev *dev, int pass);
+void pci_liveupdate_init_acs(struct pci_dev *dev);
+int pci_liveupdate_enable_acs(struct pci_dev *dev);
 #else
 static inline void pci_liveupdate_setup_device(struct pci_dev *dev)
 {
@@ -35,6 +37,15 @@ static inline bool pci_liveupdate_scan_bridge_begin(struct pci_bus *bus,
 static inline void pci_liveupdate_scan_bridge_end(struct pci_dev *dev, int pass)
 {
 }
+
+static inline void pci_liveupdate_init_acs(struct pci_dev *dev)
+{
+}
+
+static inline int pci_liveupdate_enable_acs(struct pci_dev *dev)
+{
+	return -EINVAL;
+}
 #endif
 
 #endif /* DRIVERS_PCI_LIVEUPDATE_H */
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 77b17b13ee61..739ecaab2e76 100644
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
 
+	if (!pci_liveupdate_enable_acs(dev))
+		return;
+
 	/* If an iommu is present we start with kernel default caps */
 	if (pci_acs_enable) {
 		if (pci_dev_specific_enable_acs(dev))
@@ -3689,6 +3694,7 @@ void pci_acs_init(struct pci_dev *dev)
 
 	pci_read_config_word(dev, pos + PCI_ACS_CAP, &dev->acs_capabilities);
 	pci_disable_broken_acs_cap(dev);
+	pci_liveupdate_init_acs(dev);
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
index 2be98819e313..2446c6d237ca 100644
--- a/include/linux/pci_liveupdate.h
+++ b/include/linux/pci_liveupdate.h
@@ -17,14 +17,20 @@
  * struct pci_liveupdate - PCI Live Update state for a struct pci_dev
  * @outgoing: State preserved for the next kernel.
  * @incoming: State preserved by the previous kernel.
+ * @acs_ctrl: ACS features established by the previous kernel.
  * @inherit_buses: True if the PCI core should inherit the secondary and
  *                 subordinate bus numbers assigned to this device due to
  *                 an ongoing Live Update.
+ * @was_preserved: True if this struct pci_dev was preserved by the previous
+ *                 kernel. Unlike @incoming, this field is not cleared after
+ *                 the device is finished participating in Live Update.
  */
 struct pci_liveupdate {
 	struct pci_dev_ser *outgoing;
 	struct pci_dev_ser *incoming;
+	u16 acs_ctrl;
 	bool inherit_buses;
+	bool was_preserved;
 };
 
 struct pci_dev;
-- 
2.55.0.795.g602f6c329a-goog

