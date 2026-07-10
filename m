Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F393BF667
	for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 21:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783718795; cv=none; b=KFEL4n+sEk531VOolINpfdQO5bwX85xF8d5IRauhyBtVKFRFVl3bm1460AH71nf7r8uimsL5ZcaQv5CzaHTVolCGYF9wusTcgexMuF/TTd5Kc0TVJi45kkQxfNL0i1dizBjVoAHZ05rCVcljktiTResBKIWf54v45DwNkOl+U3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783718795; c=relaxed/simple;
	bh=TT1r+Sc1kpyFY8Swon5dHUVCA+faxMR/hxQ7WWn8eM0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L17XfmVkmRG+miHfvX/jt1Qld79miv4iQeSrtFz4DABU8htDg0s4WyBi3Ch4boR2alccsQ8qfE4gy82dU1JL5bH2a0cQfi8cxLzjGEdNzcw6/OsJGz1OOR07FRoem5Wtv2kM/AvtNICcecSxt275b8mBQH1JzZyVIhNh5Eiopqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=btGFZDDC; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="btGFZDDC"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ce8a76df2dso18244695ad.2
        for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 14:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783718791; x=1784323591; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8nXcm3EXUYcPcGCSx60NMKl0mL3TQCPUFy3rNzpS5dk=;
        b=btGFZDDCVSBAzv7mxr5PuEWb5CoBlfQHJjjSEz5DNPsh0sx5W/3H41VOX9apv591Xy
         fDzGhzrKRfE7IN62E+nRD6CJ07rHBSrMos5kF3xTIQqggOw+XoerTlN/a7bxQ1Ebvw0E
         bBm13CPNRPTCUmbK42O0d+LkupN5JXppuJJEb+nrsQyg7G2l4wOXABjJnaIbSW9Pwrob
         SELF3Ju2S1NeUR2neMKoUuOcEPtYEh+KwC5MQo08mIFSHfvJnVCi0nAISQyvRdDn3Cze
         gRtCx4Nxu/WN3Ifo10CdYmUI9zodNS3dMutuwsmBJ8MHFc0AdbmGaqDA+NcwydZOqWPQ
         idWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783718791; x=1784323591;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8nXcm3EXUYcPcGCSx60NMKl0mL3TQCPUFy3rNzpS5dk=;
        b=AgpvcrUdxEXI4JjhPJjkaEqhrU7ZPbNDYOq69d3oXSQ8r8x5LhCrQpN2I96jxeqrHo
         E7Lrafom1eRgVIqXZ/U+mB9h4co+4/yQpFoVOOknVY+ipfbHswPq4oOU7kKmcKDxGXAq
         aEV18s0Ted6tZEI70Eux2mR6faVertcwkpfu9MqW1Hlez9QGwaRFnO4FsyKThmOI2UjG
         +NuLgEzhcyzwAEU6PJBvDVMNk1cA3prrPJ2FLZABqznVfrnr/PQXc3JAx+NmfdUFdQ3U
         TCkGUTKe8l46RaVxkWNf6CVpnTt7iUwoLEtOEhhjetQbZX0MD9yFXO0f2XkJFTd0+sKg
         EE2g==
X-Forwarded-Encrypted: i=1; AHgh+Rp0WdI5pWX/H5LED4vt8/5wvaHsh3WSwzqGiumZ4HSbxwTx4O49amSs+pvhyiXu6tK/mylNiV5BffI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv7uUP3RkbFwjKjAPOmUI3ZBhUZxLEQJ8j3fO7lWaXToz5AkgB
	vFwIYWw5M9prmTxBj4XNmYfG102hVKFTm70+hzJkB0TapNnuJ2icBi4uNGypGt4MepwwOtzz07U
	OwLR1V+hhGVASKQ==
X-Received: from plal14.prod.google.com ([2002:a17:903:4e:b0:2cc:da2c:8084])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1c8:b0:2ca:ed41:d33d with SMTP id d9443c01a7336-2ce9f294803mr7037355ad.45.1783718790387;
 Fri, 10 Jul 2026 14:26:30 -0700 (PDT)
Date: Fri, 10 Jul 2026 21:26:12 +0000
In-Reply-To: <20260710212616.1351130-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260710212616.1351130-1-dmatlack@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260710212616.1351130-10-dmatlack@google.com>
Subject: [PATCH v7 09/12] PCI: liveupdate: Inherit ARI Forwarding Enable on
 preserved bridges
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

Inherit the ARI Forwarding Enable on preserved bridges and update
pci_dev->ari_enabled accordingly during a Live Update. This ensures that
the preserved devices on the bridge's secondary bus can be identified
with the same expanded 8-bit function number after a Live Update.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/liveupdate.c | 18 ++++++++++++++++++
 drivers/pci/liveupdate.h |  6 ++++++
 drivers/pci/pci.c        |  8 +++++++-
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index a95bfe5eff77..74a11e520f0d 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -128,6 +128,10 @@
  *    way after Live Update and ensures that IOMMU groups do not change. Note
  *    that a device will use its inherited ACS flags for the lifetime of its
  *    struct pci_dev (i.e. even after pci_liveupdate_finish()).
+ *
+ *  * The PCI core inherits ARI Forwarding Enable on all bridges with downstream
+ *    preserved devices to ensure that all preserved devices on the bridge's
+ *    secondary bus are addressable after the Live Update.
  */
 
 #define pr_fmt(fmt) "PCI: " KBUILD_BASENAME ": " fmt
@@ -816,6 +820,20 @@ int pci_liveupdate_enable_acs(struct pci_dev *dev)
 	return 0;
 }
 
+int pci_liveupdate_configure_ari(struct pci_dev *dev)
+{
+	u16 val;
+
+	guard(rwsem_read)(&pci_liveupdate.rwsem);
+
+	if (!dev->liveupdate.incoming)
+		return -EINVAL;
+
+	pcie_capability_read_word(dev, PCI_EXP_DEVCTL2, &val);
+	dev->ari_enabled = !!(val & PCI_EXP_DEVCTL2_ARI);
+	return 0;
+}
+
 /**
  * pci_liveupdate_is_incoming() - Check if a device is incoming-preserved
  * @dev: The PCI device to check
diff --git a/drivers/pci/liveupdate.h b/drivers/pci/liveupdate.h
index 4e8a01bcb4bb..6f21ec50927b 100644
--- a/drivers/pci/liveupdate.h
+++ b/drivers/pci/liveupdate.h
@@ -18,6 +18,7 @@ bool pci_liveupdate_scan_bridge_begin(struct pci_bus *bus, struct pci_dev *dev,
 void pci_liveupdate_scan_bridge_end(struct pci_dev *dev, int pass);
 void pci_liveupdate_init_acs(struct pci_dev *dev);
 int pci_liveupdate_enable_acs(struct pci_dev *dev);
+int pci_liveupdate_configure_ari(struct pci_dev *dev);
 #else
 static inline void pci_liveupdate_setup_device(struct pci_dev *dev)
 {
@@ -46,6 +47,11 @@ static inline int pci_liveupdate_enable_acs(struct pci_dev *dev)
 {
 	return -EINVAL;
 }
+
+static inline int pci_liveupdate_configure_ari(struct pci_dev *dev)
+{
+	return -EINVAL;
+}
 #endif
 
 #endif /* DRIVERS_PCI_LIVEUPDATE_H */
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 739ecaab2e76..e0c133b66a35 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3528,7 +3528,7 @@ void pci_configure_ari(struct pci_dev *dev)
 	u32 cap;
 	struct pci_dev *bridge;
 
-	if (pcie_ari_disabled || !pci_is_pcie(dev) || dev->devfn)
+	if (!pci_is_pcie(dev) || dev->devfn)
 		return;
 
 	bridge = dev->bus->self;
@@ -3539,6 +3539,12 @@ void pci_configure_ari(struct pci_dev *dev)
 	if (!(cap & PCI_EXP_DEVCAP2_ARI))
 		return;
 
+	if (!pci_liveupdate_configure_ari(bridge))
+		return;
+
+	if (pcie_ari_disabled)
+		return;
+
 	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ARI)) {
 		pcie_capability_set_word(bridge, PCI_EXP_DEVCTL2,
 					 PCI_EXP_DEVCTL2_ARI);
-- 
2.55.0.795.g602f6c329a-goog

