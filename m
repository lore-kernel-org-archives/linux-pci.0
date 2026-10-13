Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F4651DB18
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 16:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791908751; cv=none; b=V1Xt0ErrRSenQCk55a5CD1fqw0LmU8+kY3U6GbFllFpg+T4F1UmW0UOYhvT9dR1qAk9rK7fc59XD8AKNGvrRvqjP+tJcVJBfQxrg5WVlLhw/c6+WzaaNif6aSz2X8o59wEU04SQ+XY4e0V7j0OlixN+qsbaXneBy6kXSce6Lgbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791908751; c=relaxed/simple;
	bh=fjrli6J7bOWUBOw6ZP3y1Rvst2l975QDQFuVck/ru70=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=K97ZUPm8+W7TbBMtGIIAlwvfXX1zJO1pA2UDuW3w8qQq6/9G8snVW0OyKkldo+yBst2mvHdsmxZpfm3Y3RqUSYWwrJA7NLLrTS49eDJefAcqIfBzhJl0ZphuqLiCM/jSJXV2MFLs293LuUWqdAR2pzRboqBL7FaLb8RLCUOpYPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vdk9X/74; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vdk9X/74"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2e80ef3e0a3so46466645ad.3
        for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 09:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791908745; x=1792513545; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dIhOQAQQ+VMM6lVadofyWK2MAH+kCcuj1vkGtb5EfAU=;
        b=vdk9X/74e00LNRMSNImuLYxnRWpH/+t9FFiwgCssdApOaWkKVFm7g7dFbt5i8s0jye
         jUHWaNUKS85XsMK7Rl8d7WSusW/eqgGy+O0sWu7ULJlZPjQPJ8B/1EIteOFPVdQlzyVm
         jEt5fd7PbVjPB5AOJmoplQcvbG4isfs4DwMqcMLSV+XYNqzLDyr/7oTz56gofY1b9Oii
         KQI03llHcIQJGTYBrUVfm5sPV39jXvPfTHaaWoU10fxfkINfjXrjdix1z4UMiDqGMYrV
         PtgZEH3i8TAF6emSM/SJr0z2+/okyRhkFGa+US5eDc47ZSQ4B+KGMCbmq6S2/igc4+YE
         8xWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791908745; x=1792513545;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dIhOQAQQ+VMM6lVadofyWK2MAH+kCcuj1vkGtb5EfAU=;
        b=JRunA/yzAjb9kJm7Y8FtEyygAvc+jJxmvJ2rQG1uE3S85r9Hn8tmAkUwFIAWrRSadt
         kCmc036CU0PRWHwcTJsSHBaDR67EmM8Th6MBs516yJ31U4/sMVADf47L445v4Ey6G9pI
         AqxZxPFtsa+qmEtX7oFMdjM1fT/RDAhuAMdO1zhP+98SBsbo3p3EPI1rfLwA4Cn00HEJ
         yQ086gUPmeZKfuao2OmCqPeAJRw0tKfBW5VVrpZwWm0dMkMGCaGkPBl2boqYZd7sSpnR
         VPBxh2InXjrm77Y4r++32snIxIlzBkIK7nt8d9YicCfWBVdASc/yfcEVnQu1fQHEQxTq
         02Gg==
X-Forwarded-Encrypted: i=1; AKwUvBxZDxnpHugZKxg22lRtC8Yx5VD7L+x5k6VdUnCkY5Crn4/d2d4Z66uggX5LGXhv/v63X84cACwKKi4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJMnCqjNbcfbyZN+W48WTUEBCEJWh5VP2wz/gw+9QOG9w3Hp8eg
	0D74RXwD6+sT4ixcBTz2kCAhHo+U0rkaWb75ec8VuJMXcd7Q5MAoIZC4rQqIGv25eU8yel/Y1BM
	spaUWTj5skF2j0Q==
X-Received: from plin4.prod.google.com ([2002:a17:903:3884:b0:2e2:c744:19ed])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:fc8d:b0:2e3:598:75b8 with SMTP id d9443c01a7336-2e842ab03ddmr108269245ad.27.1791908744336;
 Tue, 13 Oct 2026 09:25:44 -0700 (PDT)
Date: Tue, 13 Oct 2026 16:25:24 +0000
In-Reply-To: <20261013162529.1928093-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261013162529.1928093-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261013162529.1928093-9-dmatlack@google.com>
Subject: [PATCH v10 08/13] PCI: Save and restore the ACS Control register and
 Egress Control Vector
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

Save the ACS Control register and the ACS Egress Control Vector in
pci_save_state() and write them back in pci_restore_state(), instead of
recomputing the ACS controls from scratch with pci_enable_acs().

This makes ACS symmetric with the rest of a device's saved state. Today
pci_save_state() ignores ACS entirely and pci_restore_state() re-enables
the ACS controls from the kernel's current ACS policy. As a result, a
device can come out of a reset with different ACS controls than it went
in with, e.g. any controls programmed outside of pci_enable_acs() are
silently dropped.

Notably, this prepares the kernel to be able to adopt the ACS controls
established by a previous kernel across a Live Update rather than
assigning new ones through pci_enable_acs().

Save and restore the Egress Control Vector as well to keep it in sync
with the now-properly-restored Egress Control Enable bit in the ACS
control register. The kernel never enables Egress Controls or programs
the vector, but the firmware could have and they need to be kept in sync
to avoid changing how P2P traffic is routed.

The Egress Control Vector Size is a HwInit field of the ACS Capability
register, so read it directly from the device to size the save buffer
in pci_allocate_cap_save_buffers(), similar to how the VC capability
relies on its HwInit fields.

pci_enable_acs() runs when a driver binds to a device
(pci_dma_configure()), i.e. after pci_bus_add_device() has already saved
the device's state. Refresh the saved ACS state there as well, otherwise
a subsequent reset would revert ACS back to the configuration left
behind by firmware.

Devices that rely on device-specific quirks to enable an ACS equivalent
keep that configuration outside of the ACS Control register, so keep
configuring ACS from scratch for them. Do the same for devices that have
no saved ACS state at all.

Assisted-by: LLM
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/pci.c    | 146 ++++++++++++++++++++++++++++++++++++++++++-
 drivers/pci/pci.h    |   5 ++
 drivers/pci/quirks.c |   7 +++
 3 files changed, 157 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b2879a6be5f8..944590fdef48 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1021,6 +1021,139 @@ static void pci_std_enable_acs(struct pci_dev *dev, struct pci_acs *caps)
 		caps->ctrl |= (dev->acs_capabilities & PCI_ACS_TB);
 }
 
+/*
+ * Layout of the ACS save buffer. @ecv holds the ACS Egress Control Vector, if
+ * implemented, and is sized by pci_allocate_acs_save_buffer().
+ */
+struct pci_acs_saved_state {
+	u16 ctrl;
+	u32 ecv[];
+};
+
+/*
+ * Return the number of DWORDs in the ACS Egress Control Vector, or 0 if the
+ * device does not implement P2P Egress Control. The Egress Control Vector
+ * Size is HwInit, so it is read directly from the ACS Capability register.
+ */
+static unsigned int pci_acs_ecv_dwords(struct pci_dev *dev, int pos)
+{
+	unsigned int bits;
+	u16 cap;
+	u8 size;
+
+	pci_read_config_word(dev, pos + PCI_ACS_CAP, &cap);
+	if (!(cap & PCI_ACS_EC))
+		return 0;
+
+	/* An Egress Control Vector Size of 0 means 256 bits */
+	pci_read_config_byte(dev, pos + PCI_ACS_EGRESS_BITS, &size);
+	bits = size ?: 256;
+
+	return DIV_ROUND_UP(bits, 32);
+}
+
+/*
+ * Return the number of Egress Control Vector DWORDs held in @save_state, as
+ * sized by pci_allocate_acs_save_buffer().
+ */
+static unsigned int
+pci_acs_saved_ecv_dwords(struct pci_cap_saved_state *save_state)
+{
+	return (save_state->cap.size -
+		offsetof(struct pci_acs_saved_state, ecv)) / sizeof(u32);
+}
+
+static void pci_allocate_acs_save_buffer(struct pci_dev *dev)
+{
+	size_t size;
+	int pos;
+
+	/* dev->acs_cap is not set yet, pci_acs_init() runs later */
+	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ACS);
+	if (!pos)
+		return;
+
+	size = struct_size_t(struct pci_acs_saved_state, ecv,
+			     pci_acs_ecv_dwords(dev, pos));
+	if (pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_ACS, size))
+		pci_err(dev, "unable to allocate suspend buffer for ACS\n");
+}
+
+/**
+ * pci_save_acs_state - save the ACS Control register and Egress Control Vector
+ * @dev: the PCI device
+ *
+ * Record the ACS configuration currently programmed in hardware so that
+ * pci_restore_acs_state() can reapply it after a reset.
+ */
+static void pci_save_acs_state(struct pci_dev *dev)
+{
+	struct pci_cap_saved_state *save_state;
+	struct pci_acs_saved_state *acs;
+	unsigned int i, dwords;
+	int ecv_pos;
+
+	if (!dev->acs_cap)
+		return;
+
+	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_ACS);
+	if (!save_state)
+		return;
+
+	acs = (struct pci_acs_saved_state *)save_state->cap.data;
+
+	pci_read_config_word(dev, dev->acs_cap + PCI_ACS_CTRL, &acs->ctrl);
+
+	ecv_pos = dev->acs_cap + PCI_ACS_EGRESS_CTL_V;
+	dwords = pci_acs_saved_ecv_dwords(save_state);
+	for (i = 0; i < dwords; i++)
+		pci_read_config_dword(dev, ecv_pos + i * sizeof(u32),
+				      &acs->ecv[i]);
+}
+
+/**
+ * pci_restore_acs_state - restore the ACS Control register and Egress Control
+ *			   Vector
+ * @dev: the PCI device
+ */
+static void pci_restore_acs_state(struct pci_dev *dev)
+{
+	struct pci_cap_saved_state *save_state = NULL;
+	struct pci_acs_saved_state *acs;
+	unsigned int i, dwords;
+	int ecv_pos;
+
+	if (dev->acs_cap && !pci_need_dev_specific_enable_acs(dev))
+		save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_ACS);
+
+	/*
+	 * Devices that rely on device-specific quirks to enable an ACS
+	 * equivalent keep that configuration outside of the ACS Control
+	 * register, so there is nothing useful to restore for them. Configure
+	 * ACS from scratch instead, which also covers devices that have no
+	 * saved ACS state at all.
+	 */
+	if (!save_state) {
+		pci_enable_acs(dev);
+		return;
+	}
+
+	acs = (struct pci_acs_saved_state *)save_state->cap.data;
+
+	/*
+	 * Restore the Egress Control Vector before the ACS Control register.
+	 * The vector resets to zero, so enabling P2P Egress Control first
+	 * would briefly apply the reset vector instead of the saved one.
+	 */
+	ecv_pos = dev->acs_cap + PCI_ACS_EGRESS_CTL_V;
+	dwords = pci_acs_saved_ecv_dwords(save_state);
+	for (i = 0; i < dwords; i++)
+		pci_write_config_dword(dev, ecv_pos + i * sizeof(u32),
+				       acs->ecv[i]);
+
+	pci_write_config_word(dev, dev->acs_cap + PCI_ACS_CTRL, acs->ctrl);
+}
+
 /**
  * pci_enable_acs - enable ACS if hardware support it
  * @dev: the PCI device
@@ -1057,6 +1190,15 @@ void pci_enable_acs(struct pci_dev *dev)
 	__pci_config_acs(dev, &caps, config_acs_param, 0, 0);
 
 	pci_write_config_word(dev, pos + PCI_ACS_CTRL, caps.ctrl);
+
+	/*
+	 * pci_enable_acs() runs when a driver binds to the device, i.e. after
+	 * pci_bus_add_device() has already saved the device's state. Refresh
+	 * the saved ACS state so that a subsequent reset restores the
+	 * configuration programmed here rather than the one left behind by
+	 * firmware.
+	 */
+	pci_save_acs_state(dev);
 }
 
 /**
@@ -1800,6 +1942,7 @@ int pci_save_state(struct pci_dev *dev)
 	pci_save_aer_state(dev);
 	pci_save_ptm_state(dev);
 	pci_save_tph_state(dev);
+	pci_save_acs_state(dev);
 	return pci_save_vc_state(dev);
 }
 EXPORT_SYMBOL(pci_save_state);
@@ -1877,7 +2020,7 @@ void pci_restore_state(struct pci_dev *dev)
 	pci_restore_msi_state(dev);
 
 	/* Restore ACS and IOV configuration state */
-	pci_enable_acs(dev);
+	pci_restore_acs_state(dev);
 	pci_restore_iov_state(dev);
 
 	dev->state_saved = false;
@@ -3532,6 +3675,7 @@ void pci_allocate_cap_save_buffers(struct pci_dev *dev)
 	if (error)
 		pci_err(dev, "unable to allocate suspend buffer for LTR\n");
 
+	pci_allocate_acs_save_buffer(dev);
 	pci_allocate_vc_save_buffers(dev);
 }
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index ba3c3fddddc2..037c1674f164 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1095,6 +1095,7 @@ void pci_acs_init(struct pci_dev *dev);
 void pci_enable_acs(struct pci_dev *dev);
 #ifdef CONFIG_PCI_QUIRKS
 int pci_dev_specific_acs_enabled(struct pci_dev *dev, u16 acs_flags);
+bool pci_need_dev_specific_enable_acs(struct pci_dev *dev);
 int pci_dev_specific_enable_acs(struct pci_dev *dev);
 int pci_dev_specific_disable_acs_redir(struct pci_dev *dev);
 void pci_disable_broken_acs_cap(struct pci_dev *pdev);
@@ -1105,6 +1106,10 @@ static inline int pci_dev_specific_acs_enabled(struct pci_dev *dev,
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
index 7aee30734303..e500c202d2ec 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5476,6 +5476,13 @@ static const struct pci_dev_acs_ops *pci_dev_acs_ops_get(struct pci_dev *dev)
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
-- 
2.56.0.385.gd3acb90ef8-goog

