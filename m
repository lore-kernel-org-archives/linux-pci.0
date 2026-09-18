Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E39526AA4
	for <linux-pci@vger.kernel.org>; Fri, 18 Sep 2026 20:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789762023; cv=none; b=XjwiphHffkWSw0AOowbjs+dfj2wBPxV1hrXBBD8pcEGTfO4DHV1dqba7IZ1v5IR3Y/CYyA/JI8xgwc1YyVIotGJM9pjE794Xg/0v7Mx9W91r9xKNkVFcegnHL7FK3V3wYC51dr3WJRcDmYzHS5Ocip2UxCcJvyZziR6PjuH7/1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789762023; c=relaxed/simple;
	bh=nrGrLrEDt4kOjCaEFRcXdThoDJLk6Rvpwa3mIPITmHk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tqCc1XsvteBqAja+yXDk3grPYRxvpaVLj5qXGyW7FJMKEX5xq3Bgz2HQiSxKlvn7q3HYYSxsT2HjwTSa6uc9n++x1AEbx2C52R/mHZTX2oLVdyag5XD9Lj7VQ1QzXpJZCez3pmWXQUPmHtlZ0MeKVjOZtZTCb6n5fHS4GycvK0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E0VjOvS5; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E0VjOvS5"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2db8e9fe9c7so16034145ad.0
        for <linux-pci@vger.kernel.org>; Fri, 18 Sep 2026 13:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789762020; x=1790366820; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8ZYph3SzF8DNc3MuGEDpVyyWuyM4ge/DoPLpl5bxHLs=;
        b=E0VjOvS5qOgT83AN+fTuwQYT/WvoKKtFYK+ztLVvoUm1PVkRuVYicghH+qHRVFB5Ev
         TRsKU1p9U5L8JVUzb0ddvrICeGZcYoxN/IONkxEsIC0N0hugdO1DDMdcvmfUbwwHoF7h
         +IslkvNP9AUPjnRX0KNkpn82zRlB6/JBPyYp0FnhZ9nio6d1wPkeA3kicJcOP4n5xiMa
         tgJR5TSysSecF82dp/bkx7puWtPs9YnSTdIRpwWLBOBxuZz+3GK47SDUVuUIlzxTzjrk
         FkzV6se3ZWmYITxqnsdvtWEtkjngJxYY3USVuEnM5jnfndO4W+gy+1hG79hVZ6hh9PC/
         /UzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789762020; x=1790366820;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8ZYph3SzF8DNc3MuGEDpVyyWuyM4ge/DoPLpl5bxHLs=;
        b=DX/KJMlvCdB7mUpggk4VcaEyZv/4KZEICUdjCa2Vz5qR6fNj9xY0KppcvF0CuU+nkR
         a6/UftYCSlRXstqH/xtJH63hbPwPZ1yxb7cWUTf+zP8RPB5oE8oN+awZsFW8KFrsdh+o
         NmjOoie/07fXKBXge1f3cl5qlB/hX2H/6FZM7NQu+v5++7Q+A4A2O3gahmF/TZbS2BCq
         I5IR1T0Jg7RXFQLSfsAf75vRhNvrHXzAXno14DeWG6pHKrFoQx6G35emzqbLDJZ6ixSI
         C+fpegboIyDCZN+xJFM0suV68eqs1NVkTUwcFAMD6OE9DbWpkPNp4vTmJXLF+EL8CuCx
         N4Bg==
X-Forwarded-Encrypted: i=1; AKwUvBxclwZvBAkoPk4VJAyP3psmHDVupjIN6I7ZD/DWWD6czCgO5L+T2yhWXCsBiTrR7G1woNy2ebJbMhs=@vger.kernel.org
X-Gm-Message-State: AFuF++lM0563EfshJbiEs6QbvUtzsVE4kBFYWzEOCngvmdtVU0ydOjLM
	iuwQ/iIxKJLVMxZCBHFLomF6MKmjOThXkAFMGSFhSvNX2x7GnmauhFVuQIH7t1UN7+XuuabI+cw
	i0uX6GFC4KuLK7g==
X-Received: from plld5.prod.google.com ([2002:a17:902:7285:b0:2dd:4e69:703b])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2ecb:b0:2dd:c100:9439 with SMTP id d9443c01a7336-2ddc1009c48mr9484545ad.55.1789762020378;
 Fri, 18 Sep 2026 13:07:00 -0700 (PDT)
Date: Fri, 18 Sep 2026 20:06:34 +0000
In-Reply-To: <20260918200640.887030-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260918200640.887030-1-dmatlack@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260918200640.887030-9-dmatlack@google.com>
Subject: [PATCH v9 08/13] PCI: Save and restore the ACS Control register
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

Save the ACS Control register in pci_save_state() and write it back
in pci_restore_state(), instead of recomputing the ACS controls from
scratch with pci_enable_acs().

This makes ACS symmetric with the rest of a device's saved state. Today
pci_save_state() ignores ACS entirely and pci_restore_state() re-enables
the ACS controls from the kernel's current ACS policy. As a result, a
device can come out of a reset with different ACS controls than it went
in with, e.g. any controls programmed outside of pci_enable_acs() are
silently dropped.

pci_enable_acs() runs when a driver binds to a device
(pci_dma_configure()), i.e. after pci_bus_add_device() has already saved
the device's state. Refresh the saved ACS Control register there as
well, otherwise a subsequent reset would revert ACS back to the
configuration left behind by firmware.

Devices that rely on device-specific quirks to enable an ACS equivalent
keep that configuration outside of the ACS Control register, so keep
configuring ACS from scratch for them. Do the same for devices that have
no saved ACS state at all.

Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
Assisted-by: Claude:claude-opus-5
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/pci.c    | 66 +++++++++++++++++++++++++++++++++++++++++++-
 drivers/pci/pci.h    |  5 ++++
 drivers/pci/quirks.c |  7 +++++
 3 files changed, 77 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b2879a6be5f8..dd25c01736b4 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1021,6 +1021,55 @@ static void pci_std_enable_acs(struct pci_dev *dev, struct pci_acs *caps)
 		caps->ctrl |= (dev->acs_capabilities & PCI_ACS_TB);
 }
 
+/**
+ * pci_save_acs_state - save the ACS Control register
+ * @dev: the PCI device
+ *
+ * Record the ACS controls currently programmed in hardware so that
+ * pci_restore_acs_state() can reapply them after a reset.
+ */
+static void pci_save_acs_state(struct pci_dev *dev)
+{
+	struct pci_cap_saved_state *save_state;
+
+	if (!dev->acs_cap)
+		return;
+
+	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_ACS);
+	if (!save_state)
+		return;
+
+	pci_read_config_word(dev, dev->acs_cap + PCI_ACS_CTRL,
+			     (u16 *)&save_state->cap.data[0]);
+}
+
+/**
+ * pci_restore_acs_state - restore the ACS Control register
+ * @dev: the PCI device
+ */
+static void pci_restore_acs_state(struct pci_dev *dev)
+{
+	struct pci_cap_saved_state *save_state = NULL;
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
+	pci_write_config_word(dev, dev->acs_cap + PCI_ACS_CTRL,
+			      *(u16 *)&save_state->cap.data[0]);
+}
+
 /**
  * pci_enable_acs - enable ACS if hardware support it
  * @dev: the PCI device
@@ -1057,6 +1106,15 @@ void pci_enable_acs(struct pci_dev *dev)
 	__pci_config_acs(dev, &caps, config_acs_param, 0, 0);
 
 	pci_write_config_word(dev, pos + PCI_ACS_CTRL, caps.ctrl);
+
+	/*
+	 * pci_enable_acs() runs when a driver binds to the device, i.e. after
+	 * pci_bus_add_device() has already saved the device's state. Refresh
+	 * the saved ACS Control register so that a subsequent reset restores
+	 * the controls programmed here rather than the ones left behind by
+	 * firmware.
+	 */
+	pci_save_acs_state(dev);
 }
 
 /**
@@ -1800,6 +1858,7 @@ int pci_save_state(struct pci_dev *dev)
 	pci_save_aer_state(dev);
 	pci_save_ptm_state(dev);
 	pci_save_tph_state(dev);
+	pci_save_acs_state(dev);
 	return pci_save_vc_state(dev);
 }
 EXPORT_SYMBOL(pci_save_state);
@@ -1877,7 +1936,7 @@ void pci_restore_state(struct pci_dev *dev)
 	pci_restore_msi_state(dev);
 
 	/* Restore ACS and IOV configuration state */
-	pci_enable_acs(dev);
+	pci_restore_acs_state(dev);
 	pci_restore_iov_state(dev);
 
 	dev->state_saved = false;
@@ -3532,6 +3591,11 @@ void pci_allocate_cap_save_buffers(struct pci_dev *dev)
 	if (error)
 		pci_err(dev, "unable to allocate suspend buffer for LTR\n");
 
+	error = pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_ACS,
+					    sizeof(u16));
+	if (error)
+		pci_err(dev, "unable to allocate suspend buffer for ACS\n");
+
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
2.55.0.1082.g2b9226bbc0-goog

