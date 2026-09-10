Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8E4562609
	for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 17:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789061823; cv=none; b=qBJugYJ/IJtev4G7bIqP4dUWyja3ylmji0CRxRGCXL6M9wL0mGyuk+FQgN+O+57uw8DG5i1lf0Z+pYFa/o4tsnUow/CIKNk7RFB5Pk57TFmej4rMrd18DowgozW5cAEihIKlCd2OSBPB3+WFQehV0rBaEkz0uK5oGd3ACHe9PRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789061823; c=relaxed/simple;
	bh=Z4lFJfFkdMxPK9HpWMnKdIxtOkfliG7SzLgpPy11Zf8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pTecjxHc4gNJQbiUNNoUfrDKsGVo9Cd6Qs5xnhO3NX84vMjD6YyTZkteLWouQfPcTcW42/pT5fPHibzrAp+q07jids2LOyUEHfP9JicNY8s2LA7OjSJxPdxNqUG/si2ZVfwl19ECgUtGg7/kDbDapa4xR4eOaTJ5q+J1BXLgwVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--loganodell.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bi4FkKfg; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--loganodell.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bi4FkKfg"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-855f662439aso5749547b3a.1
        for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 10:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789061815; x=1789666615; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AqgXfHUqiopZ3f8VymwvbjUvfeF4pVsfogr0PPZqSSI=;
        b=Bi4FkKfgU+vjIAn63jZxqCWw+QnP//LoPLLcMPtg9l+8IqPP3y56/UnXd7r92EfyAj
         3+5+0ial0FXYqqxg/hNstVUvX4ODriAzk7SHkMi9cR+lbP4/sbqbSddjbrki504+ge6T
         UWZ3ACM0hWxyaicsexFlh9RdLzeEz66ZSPFevB5q2Nj9mPzbzyz3iqPHEe+APlK87RoS
         buAZhkiHQnotBtHKF7bEsyg2+Db0U4RBdoaUJhvIxnpWLNclELSD6LVMrReay73dsfBg
         6OBsMFkunUYH1eEhdwY36/XM9c6EdV8z9dv0RNH4xchA9+bx3CCCEixydmebkgUFVN3W
         SNmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789061815; x=1789666615;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AqgXfHUqiopZ3f8VymwvbjUvfeF4pVsfogr0PPZqSSI=;
        b=hVQuEWHaVy4AkDrPEw14KRMMgc2YA8ynulcXRaOkLuzdSS1ILHm7w1yGuuptfsBFHP
         YjNRlqmv3tecZFxW4TB5frsjdJZUuuHg0F8kKUmj5h3jx7f+LXQwB6Bh2e2+ZwtMB9Kh
         mLlHmnFFSSLeDN58ypj5SMc+vUNoak4P6uejtJ4OCfk4Y28XlYGGqISQjZUcELn5h8U2
         cSMueN3MZy9Jnn2+1d1gm0TLBl3Evdoadnrbnu0TegWBGFV0k9C17AjZwhvM+dx25rEP
         73wjHqGJH7hUUu8ZN2ZwdJsznGy7N+CZZXwCqm0HSU5HIt1BcbUNuLQiEtkc9+zA+jWR
         fliA==
X-Gm-Message-State: AFuF++nfRRLqf2l2atURTLGlpk7h2k3uYO00HJzVqcM883s0dkKygZcU
	ZBJYe5bTkLR6AUmvqqfujJSVcLlQBIMR5McxAmMuMOfHUnOxjVimw+wPqiePIwYQZvdHlwMRUqc
	HoAcrVR4SGDcE1DioDKtr0A==
X-Received: from pfrg28.prod.google.com ([2002:aa7:9f1c:0:b0:86a:d502:932a])
 (user=loganodell job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:c206:b0:851:d12e:389b with SMTP id d2e1a72fcca58-8628622c78fmr37659272b3a.14.1789061815249;
 Thu, 10 Sep 2026 10:36:55 -0700 (PDT)
Date: Thu, 10 Sep 2026 10:36:48 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
Message-ID: <20260910173648.1304517-1-loganodell@google.com>
Subject: [PATCH] PCI/IOV: Make VF config reads match PCIe 7.0 spec
From: Logan Odell <loganodell@google.com>
To: karahmed@amazon.de, bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Logan Odell <loganodell@google.com>
Content-Type: text/plain; charset="UTF-8"

The revision and subsystem ID of the VFs for a given PF do not all have
to match per 7.5.1.1.5 and 7.5.1.2.3[1]. Read these values from the
config space instead of using cached values from VF0. Class codes and
subsystem vendor IDs do need to match per 7.5.1.1.6 and 7.5.1.2.3. Use
the PF's value instead of reading from the VF config space. Per
7.5.1.1.9, the header type for a VF should be 0, so hardcode that
assignment.

[1] https://members.pcisig.com/wg/PCI-SIG/document/previewpdf/22464

Fixes: cf0921bea66c ("PCI/IOV: Use VF0 cached config registers for other VFs")
Signed-off-by: Logan Odell <loganodell@google.com>
---
 drivers/pci/iov.c   | 25 -------------------------
 drivers/pci/pci.h   |  4 ----
 drivers/pci/probe.c | 14 +++++++++-----
 3 files changed, 9 insertions(+), 34 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 9d408fb8ac25..9185934a900f 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -179,29 +179,6 @@ bool pci_iov_is_memory_decoding_enabled(struct pci_dev *dev)
 	return cmd & PCI_SRIOV_CTRL_MSE;
 }
 
-static void pci_read_vf_config_common(struct pci_dev *virtfn)
-{
-	struct pci_dev *physfn = virtfn->physfn;
-
-	/*
-	 * Some config registers are the same across all associated VFs.
-	 * Read them once from VF0 so we can skip reading them from the
-	 * other VFs.
-	 *
-	 * PCIe r4.0, sec 9.3.4.1, technically doesn't require all VFs to
-	 * have the same Revision ID and Subsystem ID, but we assume they
-	 * do.
-	 */
-	pci_read_config_dword(virtfn, PCI_CLASS_REVISION,
-			      &physfn->sriov->class);
-	pci_read_config_byte(virtfn, PCI_HEADER_TYPE,
-			     &physfn->sriov->hdr_type);
-	pci_read_config_word(virtfn, PCI_SUBSYSTEM_VENDOR_ID,
-			     &physfn->sriov->subsystem_vendor);
-	pci_read_config_word(virtfn, PCI_SUBSYSTEM_ID,
-			     &physfn->sriov->subsystem_device);
-}
-
 int pci_iov_sysfs_link(struct pci_dev *dev,
 		struct pci_dev *virtfn, int id)
 {
@@ -329,8 +306,6 @@ static struct pci_dev *pci_iov_scan_device(struct pci_dev *dev, int id,
 	virtfn->physfn = pci_dev_get(dev);
 	virtfn->no_command_memory = 1;
 
-	if (id == 0)
-		pci_read_vf_config_common(virtfn);
 
 	rc = pci_setup_device(virtfn);
 	if (rc) {
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index ba3c3fddddc2..5b3dd1adbf35 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -711,10 +711,6 @@ struct pci_sriov {
 	u16		driver_max_VFs;	/* Max num VFs driver supports */
 	struct pci_dev	*dev;		/* Lowest numbered PF */
 	struct pci_dev	*self;		/* This PF */
-	u32		class;		/* VF device */
-	u8		hdr_type;	/* VF header type */
-	u16		subsystem_vendor; /* VF subsystem vendor */
-	u16		subsystem_device; /* VF subsystem device */
 	resource_size_t	barsz[PCI_SRIOV_NUM_BARS];	/* VF BAR size */
 	u16		vf_rebar_cap;	/* VF Resizable BAR capability offset */
 	bool		drivers_autoprobe; /* Auto probing of VFs by driver */
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 27008e2ea5af..693c07cf45ff 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1888,10 +1888,14 @@ int pci_cfg_space_size(struct pci_dev *dev)
 static u32 pci_class(struct pci_dev *dev)
 {
 	u32 class;
+	u8 rev;
 
 #ifdef CONFIG_PCI_IOV
-	if (dev->is_virtfn)
-		return dev->physfn->sriov->class;
+	if (dev->is_virtfn) {
+		if (pci_read_config_byte(dev, PCI_REVISION_ID, &rev))
+			rev = 0;
+		return (dev->physfn->class << 8) | rev;
+	}
 #endif
 	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class);
 	return class;
@@ -1901,8 +1905,8 @@ static void pci_subsystem_ids(struct pci_dev *dev, u16 *vendor, u16 *device)
 {
 #ifdef CONFIG_PCI_IOV
 	if (dev->is_virtfn) {
-		*vendor = dev->physfn->sriov->subsystem_vendor;
-		*device = dev->physfn->sriov->subsystem_device;
+		*vendor = dev->physfn->subsystem_vendor;
+		pci_read_config_word(dev, PCI_SUBSYSTEM_ID, device);
 		return;
 	}
 #endif
@@ -1916,7 +1920,7 @@ static u8 pci_hdr_type(struct pci_dev *dev)
 
 #ifdef CONFIG_PCI_IOV
 	if (dev->is_virtfn)
-		return dev->physfn->sriov->hdr_type;
+		return 0;
 #endif
 	pci_read_config_byte(dev, PCI_HEADER_TYPE, &hdr_type);
 	return hdr_type;
-- 
2.55.0.1007.g17ff1f9808-goog

