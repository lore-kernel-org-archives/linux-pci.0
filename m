Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CDB53D0D7
	for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 17:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790271323; cv=none; b=joh+Qrm7Hkik3ZB1eyNQ7kc/oH7y6wuYf2iKvkhQtl4p5OPzSVfysZpA0msQE+jc1Bwi1xKiWz3ubjCLBKbgy+yQSHOI0lAX/wTMxGIyz7zkgJP/haAMGgtzJ2hGlZvv/FZAbr7zDhuGwO1su6SaWvRUtiv76GS0uH23wAwx/Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790271323; c=relaxed/simple;
	bh=N21gXrbrWAwe48keR4d+NDct6HiJhMueJqu4oaQmTDs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Guw0ftv4tN8qByelSDgTRM5jZliu9Bp25nMnZCKxKLnQ1H8vgOllUMpmgWA/nzzb1HzG4+7aV0OOK4x+r1+CJP+JMlehgOZLb2zIwCKKkUFl2f6gaS/jdidkV5xb4dUxQDSN+CSrq0CwRUPGtAfGgl687s0pgmFiFxkC60d/sCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LKiLC30i; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LKiLC30i"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-39e3dad7ab3so117129a91.2
        for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 10:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790271320; x=1790876120; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PVxqFIwJc63ePK33I85JjQCFTjWjDuCLX3DsCb+RWaY=;
        b=LKiLC30iOx9ViOBsaoFXXm4k9aza3tGk9oDw9PeMw2rcGu3foNfPvzL1r/xca1L8fM
         OuwtyaZq9wq1bZlSZ9vVPSFe92tOsLIC7rVmczebCBhpNHGKLBLLdZUSt1rej5dcR2Gq
         uFroeMeIhIEEJjRFRB0BAym2Pk96/xByOuDsYwmdfCD340y/+vc/7CmKqyyuEtPZms8N
         RmhytL85FKAOuSFBm9BLynDqyiC3dWPx15n7vMecnf4/9ybQtbH5NluWyaVKE89L57Gj
         ixdW6me5p1oG6rGB1WC5iD5H34+NQrLvYdZTUmJwLnpI4RIORapnC/ZB+/IZ7XBKhqyn
         RKeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790271320; x=1790876120;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PVxqFIwJc63ePK33I85JjQCFTjWjDuCLX3DsCb+RWaY=;
        b=uLDZwptFlEfTv+ppCp0DCqiUSGlsLXIN/W2YadQo+clyWXymOkcQ3Yqc2uHZJS89yo
         Rm3oUf2zJv8V4K0figWRR0Tqowsw639Gl6XLbGflrGP6arCVNStn0qi/Bed7ZMhRTcKH
         EXLFYoIKRJfjS4MGBUBAhsGa0Tz8ztMWmXE7r1QGhHdWdANOYK30dAF7MqTLCBkhjOz9
         GL8av3hsA+aWhxGz/GRvuRLG0Iry0GmY46ZNBFrhOylumFUe707mcQF0/1bq90rl6P2r
         Xwxu8ySndC2NTEFmhHkv8LtFlzNX84Lp9kz2v0U2mZeDz9UAXLsFmDhB8mt2jQcL28wA
         ILmg==
X-Forwarded-Encrypted: i=1; AKwUvBzabeaYc951tuU35rO1bMJonxdnAJ0QAZZOSlYOznn7phOv/ZkHu5J2KurbR+U6g+nsqur9/eT15N4=@vger.kernel.org
X-Gm-Message-State: AFuF++m05tC2DxghDFrqYoMAGP55iHQ8ZbBoyXrYEU+tXi/uQR0/VYgP
	Z44WLg0aeOK9FqEoEYKaodeGsH/1Wo4WYo4xSbRupqtnHZdWygIqvOe4AQcFdtp7Z8rrOMQYyVq
	Fd6/+KFRWPgrkmg==
X-Received: from pga8.prod.google.com ([2002:a05:6a02:4f88:b0:cc7:5b61:d381])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:e705:b0:39e:6c6a:20a0 with SMTP id 98e67ed59e1d1-3a098ac1636mr3075019a91.65.1790271319499;
 Thu, 24 Sep 2026 10:35:19 -0700 (PDT)
Date: Thu, 24 Sep 2026 17:35:00 +0000
In-Reply-To: <20260924173501.856380-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924173501.856380-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260924173501.856380-15-dmatlack@google.com>
Subject: [PATCH 14/15] PCI: Save reserved capability registers in a single pass
From: David Matlack <dmatlack@google.com>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org
Cc: Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>, Lukas Wunner <lukas@wunner.de>, 
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>, "Oliver O'Halloran" <oohall@gmail.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Samiullah Khawaja <skhawaja@google.com>, Vipin Sharma <vipinsh@google.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Every capability that the PCI core saves now reserves room for its
registers during device setup, so the reservation bitmap already records
exactly which configuration space DWORDs pci_save_state() has to read.
Walk the bitmap once instead of dispatching to a save function per
capability.

Values in the store are kept in ascending offset order, the same order
that for_each_set_bit() visits the bitmap, so the generic pass fills
slots sequentially and never has to look one up.

Delete pci_save_pcie_state(), pci_save_pcix_state(), pci_save_ltr_state(),
pci_save_aer_state(), pci_save_ptm_state(), pci_save_tph_state(),
pci_save_dpc_state() and pci_save_vc_state(), along with the PCI_VC_SAVE
arm of the Virtual Channel walker and pci_save_cap_word(), which loses
its last caller. Each of them existed only to rediscover offsets the
bitmap already knows.

pci_save_aspm_l1ss_state() is the one save function that survives,
because it saves the *parent's* L1SS registers into the parent's store,
which a pass over this device's bitmap cannot do. Move its call from the
deleted pci_save_pcie_state() to pci_save_state().

The PCIe capability is the one place where this is not a pure refactor.
pci_save_pcie_state() read each register with pcie_capability_read_word(),
which returns 0 for registers the device does not implement, and stored
that 0 into the containing DWORD's slot. The generic pass reads the DWORD
raw, so those slots now hold whatever the device returns. Restore is
unaffected: pci_restore_pcie_state() still writes through
pcie_capability_write_word(), which skips unimplemented registers. If
anything this is a fix, since a slot shared with another capability can
no longer be fed a synthetic 0 for a register that does not exist; slot N
is now always configuration space DWORD N.

Every other capability used pci_save_cap_word() or pci_save_cap_dword(),
both of which already read the containing DWORD raw, so their saved
values are unchanged.

The cost is a few extra configuration space reads for devices whose save
function had a runtime guard, e.g. TPH only saved its registers while TPH
was enabled. Restore keeps those guards, so the extra reads only make the
store a more faithful snapshot.

Assisted-by: LLM
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/pci.c        | 47 +++++++++-------------------------------
 drivers/pci/pci.h        | 12 +---------
 drivers/pci/pcie/aer.c   | 13 +----------
 drivers/pci/pcie/aspm.c  | 17 +--------------
 drivers/pci/pcie/dpc.c   |  8 -------
 drivers/pci/pcie/ptm.c   |  8 -------
 drivers/pci/saved-caps.c | 35 ++++++++++++++++++++----------
 drivers/pci/tph.c        | 22 -------------------
 drivers/pci/vc.c         | 45 +++++++-------------------------------
 9 files changed, 44 insertions(+), 163 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 171763f560b8..73aa526e6901 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1649,7 +1649,7 @@ int pci_set_power_state_locked(struct pci_dev *dev, pci_power_t state)
 EXPORT_SYMBOL(pci_set_power_state_locked);
 
 /*
- * PCIe capability registers saved and restored by the PCI core. Registers a
+ * PCIe capability registers reserved and restored by the PCI core. Registers a
  * device does not implement are skipped by the pcie_capability_*() accessors,
  * so space is reserved for all of them regardless of the device.
  */
@@ -1685,24 +1685,6 @@ struct pci_cap_saved_state *pci_find_saved_ext_cap(struct pci_dev *dev, u16 cap)
 	return _pci_find_saved_cap(dev, cap, true);
 }
 
-static void pci_save_pcie_state(struct pci_dev *dev)
-{
-	unsigned int i;
-	u16 val;
-
-	if (!pci_is_pcie(dev))
-		return;
-
-	for (i = 0; i < ARRAY_SIZE(pcie_saved_regs); i++) {
-		pcie_capability_read_word(dev, pcie_saved_regs[i], &val);
-		pci_write_saved_cap_word(dev, dev->pcie_cap + pcie_saved_regs[i],
-					 val);
-	}
-
-	pci_save_aspm_l1ss_state(dev);
-	pci_save_ltr_state(dev);
-}
-
 static void pci_restore_pcie_state(struct pci_dev *dev)
 {
 	unsigned int i;
@@ -1733,17 +1715,6 @@ static void pci_restore_pcie_state(struct pci_dev *dev)
 	}
 }
 
-static void pci_save_pcix_state(struct pci_dev *dev)
-{
-	int pos;
-
-	pos = pci_find_capability(dev, PCI_CAP_ID_PCIX);
-	if (!pos)
-		return;
-
-	pci_save_cap_word(dev, pos + PCI_X_CMD);
-}
-
 static void pci_restore_pcix_state(struct pci_dev *dev)
 {
 	int pos;
@@ -1771,13 +1742,15 @@ int pci_save_state(struct pci_dev *dev)
 	}
 	dev->state_saved = true;
 
-	pci_save_pcie_state(dev);
-	pci_save_pcix_state(dev);
-	pci_save_dpc_state(dev);
-	pci_save_aer_state(dev);
-	pci_save_ptm_state(dev);
-	pci_save_tph_state(dev);
-	pci_save_vc_state(dev);
+	pci_save_caps(dev);
+
+	/*
+	 * L1SS is the one capability whose state does not live entirely in
+	 * this device's store: an endpoint's L1 substates only take effect if
+	 * its upstream port is programmed to match, so the two are saved and
+	 * restored together.
+	 */
+	pci_save_aspm_l1ss_state(dev);
 
 	return 0;
 }
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 68c19f5025de..99de55799826 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -265,7 +265,7 @@ void pci_saved_caps_finalize(struct pci_dev *dev);
 void pci_saved_caps_release(struct pci_dev *dev);
 int pci_reserve_saved_cap(struct pci_dev *dev, unsigned int off, unsigned int len);
 bool pci_saved_cap_reserved(struct pci_dev *dev, unsigned int off);
-void pci_save_cap_word(struct pci_dev *dev, unsigned int off);
+void pci_save_caps(struct pci_dev *dev);
 void pci_save_cap_dword(struct pci_dev *dev, unsigned int off);
 void pci_restore_cap_word(struct pci_dev *dev, unsigned int off);
 void pci_restore_cap_dword(struct pci_dev *dev, unsigned int off);
@@ -359,7 +359,6 @@ void pci_vpd_init(struct pci_dev *dev);
 extern const struct attribute_group pci_dev_vpd_attr_group;
 
 /* PCI Virtual Channel */
-void pci_save_vc_state(struct pci_dev *dev);
 void pci_restore_vc_state(struct pci_dev *dev);
 void pci_vc_reserve_saved_caps(struct pci_dev *dev);
 
@@ -944,7 +943,6 @@ struct rcec_ea {
 #endif
 
 #ifdef CONFIG_PCIE_DPC
-void pci_save_dpc_state(struct pci_dev *dev);
 void pci_restore_dpc_state(struct pci_dev *dev);
 void pci_dpc_init(struct pci_dev *pdev);
 void dpc_process_error(struct pci_dev *pdev);
@@ -952,7 +950,6 @@ pci_ers_result_t dpc_reset_link(struct pci_dev *pdev);
 bool pci_dpc_recovered(struct pci_dev *pdev);
 unsigned int dpc_tlp_log_len(struct pci_dev *dev);
 #else
-static inline void pci_save_dpc_state(struct pci_dev *dev) { }
 static inline void pci_restore_dpc_state(struct pci_dev *dev) { }
 static inline void pci_dpc_init(struct pci_dev *pdev) { }
 static inline bool pci_dpc_recovered(struct pci_dev *pdev) { return false; }
@@ -1077,25 +1074,21 @@ static inline int pci_resource_num_to_vf_bar(int resno)
 
 #ifdef CONFIG_PCIE_TPH
 void pci_restore_tph_state(struct pci_dev *dev);
-void pci_save_tph_state(struct pci_dev *dev);
 void pci_no_tph(void);
 void pci_tph_init(struct pci_dev *dev);
 #else
 static inline void pci_restore_tph_state(struct pci_dev *dev) { }
-static inline void pci_save_tph_state(struct pci_dev *dev) { }
 static inline void pci_no_tph(void) { }
 static inline void pci_tph_init(struct pci_dev *dev) { }
 #endif
 
 #ifdef CONFIG_PCIE_PTM
 void pci_ptm_init(struct pci_dev *dev);
-void pci_save_ptm_state(struct pci_dev *dev);
 void pci_restore_ptm_state(struct pci_dev *dev);
 void pci_suspend_ptm(struct pci_dev *dev);
 void pci_resume_ptm(struct pci_dev *dev);
 #else
 static inline void pci_ptm_init(struct pci_dev *dev) { }
-static inline void pci_save_ptm_state(struct pci_dev *dev) { }
 static inline void pci_restore_ptm_state(struct pci_dev *dev) { }
 static inline void pci_suspend_ptm(struct pci_dev *dev) { }
 static inline void pci_resume_ptm(struct pci_dev *dev) { }
@@ -1145,7 +1138,6 @@ bool pcie_wait_for_link(struct pci_dev *pdev, bool active);
 int pcie_retrain_link(struct pci_dev *pdev, bool use_lt);
 
 /* ASPM-related functionality we need even without CONFIG_PCIEASPM */
-void pci_save_ltr_state(struct pci_dev *dev);
 void pci_restore_ltr_state(struct pci_dev *dev);
 void pci_configure_aspm_l1ss(struct pci_dev *dev);
 void pci_save_aspm_l1ss_state(struct pci_dev *dev);
@@ -1354,7 +1346,6 @@ extern const struct attribute_group aer_attr_group;
 void pci_aer_clear_fatal_status(struct pci_dev *dev);
 int pci_aer_clear_status(struct pci_dev *dev);
 int pci_aer_raw_clear_status(struct pci_dev *dev);
-void pci_save_aer_state(struct pci_dev *dev);
 void pci_restore_aer_state(struct pci_dev *dev);
 #else
 static inline void pci_no_aer(void) { }
@@ -1363,7 +1354,6 @@ static inline void pci_aer_exit(struct pci_dev *d) { }
 static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
 static inline int pci_aer_clear_status(struct pci_dev *dev) { return -EINVAL; }
 static inline int pci_aer_raw_clear_status(struct pci_dev *dev) { return -EINVAL; }
-static inline void pci_save_aer_state(struct pci_dev *dev) { }
 static inline void pci_restore_aer_state(struct pci_dev *dev) { }
 #endif
 
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 765899cf4046..8ebe5b5a1aef 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -353,7 +353,7 @@ int pci_aer_clear_status(struct pci_dev *dev)
 }
 
 /*
- * AER registers saved and restored by the PCI core. PCI_ERR_ROOT_COMMAND is
+ * AER registers reserved and restored by the PCI core. PCI_ERR_ROOT_COMMAND is
  * only implemented by Root Ports and Root Complex Event Collectors (PCIe
  * r6.0, sec 7.8.4.9) and so must come last.
  */
@@ -373,17 +373,6 @@ static unsigned int aer_nr_saved_regs(struct pci_dev *dev)
 	return ARRAY_SIZE(aer_saved_regs) - 1;
 }
 
-void pci_save_aer_state(struct pci_dev *dev)
-{
-	unsigned int i;
-
-	if (!dev->aer_cap)
-		return;
-
-	for (i = 0; i < aer_nr_saved_regs(dev); i++)
-		pci_save_cap_dword(dev, dev->aer_cap + aer_saved_regs[i]);
-}
-
 void pci_restore_aer_state(struct pci_dev *dev)
 {
 	unsigned int i;
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 9d64c6aebb9f..a026bda8c364 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -27,21 +27,6 @@
 
 #include "../pci.h"
 
-void pci_save_ltr_state(struct pci_dev *dev)
-{
-	int ltr;
-
-	if (!pci_is_pcie(dev))
-		return;
-
-	ltr = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_LTR);
-	if (!ltr)
-		return;
-
-	/* Some broken devices only support dword access to LTR */
-	pci_save_cap_dword(dev, ltr + PCI_LTR_MAX_SNOOP_LAT);
-}
-
 void pci_restore_ltr_state(struct pci_dev *dev)
 {
 	int ltr;
@@ -86,7 +71,7 @@ void pci_save_aspm_l1ss_state(struct pci_dev *pdev)
 
 	/*
 	 * Save L1 substate configuration. The ASPM L0s/L1 configuration
-	 * in PCI_EXP_LNKCTL_ASPMC is saved by pci_save_pcie_state().
+	 * in PCI_EXP_LNKCTL_ASPMC is saved by pci_save_caps().
 	 */
 	pci_save_cap_dword(pdev, pdev->l1ss + PCI_L1SS_CTL2);
 	pci_save_cap_dword(pdev, pdev->l1ss + PCI_L1SS_CTL1);
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 6f40cf2c712c..1f3ba582a31c 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -43,14 +43,6 @@ static const char * const rp_pio_error_string[] = {
 	"Memory Request Completion Timeout",		 /* Bit Position 18 */
 };
 
-void pci_save_dpc_state(struct pci_dev *dev)
-{
-	if (!dev->dpc_cap)
-		return;
-
-	pci_save_cap_word(dev, dev->dpc_cap + PCI_EXP_DPC_CTL);
-}
-
 void pci_restore_dpc_state(struct pci_dev *dev)
 {
 	if (!dev->dpc_cap)
diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
index a9e29e19b0f9..b2c1e2a4b81e 100644
--- a/drivers/pci/pcie/ptm.c
+++ b/drivers/pci/pcie/ptm.c
@@ -89,14 +89,6 @@ void pci_ptm_init(struct pci_dev *dev)
 		dev->ptm_requester = 1;
 }
 
-void pci_save_ptm_state(struct pci_dev *dev)
-{
-	if (!dev->ptm_cap)
-		return;
-
-	pci_save_cap_dword(dev, dev->ptm_cap + PCI_PTM_CTRL);
-}
-
 void pci_restore_ptm_state(struct pci_dev *dev)
 {
 	if (!dev->ptm_cap)
diff --git a/drivers/pci/saved-caps.c b/drivers/pci/saved-caps.c
index eaacc3b3ea74..a5755bdf8e01 100644
--- a/drivers/pci/saved-caps.c
+++ b/drivers/pci/saved-caps.c
@@ -94,9 +94,9 @@ bool pci_saved_cap_reserved(struct pci_dev *dev, unsigned int off)
  * @off: offset of the register in configuration space
  * @len: size of the register in bytes
  *
- * Reserve room to save the register at @off, which may then be saved with
- * pci_save_cap_word() and friends. Must be called during device setup, before
- * the store is finalized.
+ * Reserve room to save the register at @off, which pci_save_caps() then reads
+ * into the store. Must be called during device setup, before the store is
+ * finalized.
  *
  * Return: 0 on success, negative errno otherwise.
  */
@@ -136,28 +136,39 @@ int pci_reserve_saved_cap(struct pci_dev *dev, unsigned int off, unsigned int le
 }
 
 /**
- * pci_save_cap_dword - save a 32-bit capability register
+ * pci_save_caps - save every reserved capability register
  * @dev: the PCI device
- * @off: offset of the register in configuration space
+ *
+ * Read all of the configuration space DWORDs that capabilities reserved during
+ * device setup into the store. Values are kept in ascending offset order, the
+ * same order that for_each_set_bit() walks the reservation bitmap, so the
+ * destination slot advances in lockstep with the bitmap and needs no lookup.
  */
-void pci_save_cap_dword(struct pci_dev *dev, unsigned int off)
+void pci_save_caps(struct pci_dev *dev)
 {
-	u32 *slot = pci_saved_cap_slot(dev, off);
+	struct pci_saved_caps *caps = &dev->saved_caps;
+	unsigned int dword, i = 0;
 
-	if (!slot)
+	if (!caps->dword_val)
 		return;
 
-	pci_read_config_dword(dev, ALIGN_DOWN(off, sizeof(u32)), slot);
+	for_each_set_bit(dword, caps->dword_map, PCI_CFG_SPACE_EXP_DWORDS)
+		pci_read_config_dword(dev, dword * sizeof(u32), &caps->dword_val[i++]);
 }
 
 /**
- * pci_save_cap_word - save a 16-bit capability register
+ * pci_save_cap_dword - save a 32-bit capability register
  * @dev: the PCI device
  * @off: offset of the register in configuration space
  */
-void pci_save_cap_word(struct pci_dev *dev, unsigned int off)
+void pci_save_cap_dword(struct pci_dev *dev, unsigned int off)
 {
-	pci_save_cap_dword(dev, ALIGN_DOWN(off, sizeof(u32)));
+	u32 *slot = pci_saved_cap_slot(dev, off);
+
+	if (!slot)
+		return;
+
+	pci_read_config_dword(dev, ALIGN_DOWN(off, sizeof(u32)), slot);
 }
 
 /**
diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
index fa9f60e5a431..6f46d55eba54 100644
--- a/drivers/pci/tph.c
+++ b/drivers/pci/tph.c
@@ -457,28 +457,6 @@ void pci_restore_tph_state(struct pci_dev *pdev)
 	}
 }
 
-void pci_save_tph_state(struct pci_dev *pdev)
-{
-	int num_entries, i, offset;
-
-	if (!pdev->tph_cap)
-		return;
-
-	if (!pdev->tph_enabled)
-		return;
-
-	/* Save control register */
-	pci_save_cap_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL);
-
-	/* Save all ST entries in extended capability structure */
-	offset = PCI_TPH_BASE_SIZEOF;
-	num_entries = pcie_tph_get_st_table_size(pdev);
-	for (i = 0; i < num_entries; i++) {
-		pci_save_cap_word(pdev, pdev->tph_cap + offset);
-		offset += sizeof(u16);
-	}
-}
-
 void pci_no_tph(void)
 {
 	pci_tph_disabled = true;
diff --git a/drivers/pci/vc.c b/drivers/pci/vc.c
index d72d67dae78e..49725bbc2a9e 100644
--- a/drivers/pci/vc.c
+++ b/drivers/pci/vc.c
@@ -19,12 +19,11 @@
 /* What to do with the registers of a VC capability */
 enum pci_vc_op {
 	PCI_VC_RESERVE,		/* Reserve room to save them */
-	PCI_VC_SAVE,		/* Copy them into the saved capabilities */
 	PCI_VC_RESTORE,		/* Write the saved capabilities back */
 };
 
 /**
- * pci_vc_do_word - Reserve, save, or restore a word
+ * pci_vc_do_word - Reserve or restore a word
  * @dev: device
  * @pos: config space position
  * @op: what to do with it
@@ -36,9 +35,6 @@ static int pci_vc_do_word(struct pci_dev *dev, int pos, enum pci_vc_op op)
 	switch (op) {
 	case PCI_VC_RESERVE:
 		return pci_reserve_saved_cap(dev, pos, sizeof(u16));
-	case PCI_VC_SAVE:
-		pci_save_cap_word(dev, pos);
-		break;
 	case PCI_VC_RESTORE:
 		if (!pci_saved_cap_reserved(dev, pos))
 			return -ENOENT;
@@ -51,7 +47,7 @@ static int pci_vc_do_word(struct pci_dev *dev, int pos, enum pci_vc_op op)
 }
 
 /**
- * pci_vc_do_dwords - Reserve, save, or restore a series of dwords
+ * pci_vc_do_dwords - Reserve or restore a series of dwords
  * @dev: device
  * @pos: starting config space position
  * @dwords: number of dwords
@@ -70,18 +66,14 @@ static int pci_vc_do_dwords(struct pci_dev *dev, int pos, int dwords,
 	/*
 	 * The device supplies the table offsets and sizes, so what it reports
 	 * now may not match what was reserved during setup, e.g. if it is no
-	 * longer responding. Save or restore all of the table, or none of it.
+	 * longer responding. Restore all of the table or none of it.
 	 */
 	for (i = 0; i < dwords; i++)
 		if (!pci_saved_cap_reserved(dev, pos + i * sizeof(u32)))
 			return -ENOENT;
 
-	for (i = 0; i < dwords; i++, pos += sizeof(u32)) {
-		if (op == PCI_VC_SAVE)
-			pci_save_cap_dword(dev, pos);
-		else
-			pci_restore_cap_dword(dev, pos);
-	}
+	for (i = 0; i < dwords; i++, pos += sizeof(u32))
+		pci_restore_cap_dword(dev, pos);
 
 	return 0;
 }
@@ -250,13 +242,13 @@ static void pci_vc_restore_res_ctrl(struct pci_dev *dev, int pos, int res)
 }
 
 /**
- * pci_vc_do_saved_caps - Reserve, save, or restore VC state
+ * pci_vc_do_saved_caps - Reserve or restore VC state
  * @dev: device
  * @pos: starting position of VC capability (VC/VC9/MFVC)
  * @op: what to do with the registers found along the way
  *
- * Walking Virtual Channel config space is complicated, so reserving, saving
- * and restoring it are all driven from one function to reduce code and
+ * Walking Virtual Channel config space is complicated, so reserving and
+ * restoring it are both driven from one function to reduce code and
  * guarantee that they agree on which registers are involved.
  *
  * Return: 0 on success, negative errno otherwise.
@@ -387,27 +379,6 @@ static struct {
 		{ PCI_EXT_CAP_ID_VC, "VC" },
 		{ PCI_EXT_CAP_ID_VC9, "VC9" } };
 
-/**
- * pci_save_vc_state - Save VC state to the saved capability store
- * @dev: device
- *
- * For each type of VC capability, VC/VC9/MFVC, find the capability and
- * save it to the previously reserved capability store.
- */
-void pci_save_vc_state(struct pci_dev *dev)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(vc_caps); i++) {
-		int pos = pci_find_ext_capability(dev, vc_caps[i].id);
-
-		if (!pos)
-			continue;
-
-		pci_vc_do_saved_caps(dev, pos, PCI_VC_SAVE);
-	}
-}
-
 /**
  * pci_restore_vc_state - Restore VC state from the saved capability store
  * @dev: device
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

