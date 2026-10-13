Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7B151DE09
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 16:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791908755; cv=none; b=KvWZmHUn9+4sLWnh6Bx+6il8lM98aQR0/v364hYgd8NLPvb3avPLriVMOMSxIcQfjFDz5AfXC+6Q+/BDNLITSk7+y8bGoLpKcghzpsbMexTO3DuX52oq98u/yjebGgDYew7SBlPiQGaUnpzk3MswFtn9Tovwz71ySWnrnzoVcbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791908755; c=relaxed/simple;
	bh=MlotRTexNwSu2BGIKz0FW9IEEKNoIUPTXJa84+kNnV0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FthQyrkZyTZsRC7Sba1xCUjJiS1069IKcXm5L6WgP7OsGagwdGWyoS0o2dFg1PwN0dWH4kFdp10skRM9GLujYQ1OBLxlcBtNjT1csrmrCI69BESdcS6fit3P71Fur9kGddktr0/S+uVxWgo5LYQsNUDBouzDS6tObRMby53OGdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iKOngI9t; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iKOngI9t"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3ac450b74b0so1076122a91.0
        for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 09:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791908748; x=1792513548; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rbdiAFt+Oje3uTZOnPEvaOqLxPnobGariVTCdptn2ik=;
        b=iKOngI9tap1dFtIBP4WMJ1yFpU2g9vAICM8UrZhCGiP3ZvybgEWG2EKfdk0sMVJwO8
         0m3c/tT5LBnEdw/H341pclundvJ+4WbNZxZRnOwBTBupMqdjZnyljJLD4q8i7ePFEDh1
         9nLJTGI+DApE4/4lfOzmoqQyGIsOsVgszB5zKbtv04FWjDxJWOI+S3VKdt7+7raRlW9p
         +MxYMlimM8fhgOQDYyMuApMQY4KOc+KOpTssxubaiVp0NlAgKxg4lg/tqSgtBcFD6P9G
         jiAtxfEaeTcn89ZXfGGtNV/nYXz/EZBY2o+4fz3xS1VoFldFbnYrjJ/Q2LowX9DFxaGa
         40Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791908748; x=1792513548;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rbdiAFt+Oje3uTZOnPEvaOqLxPnobGariVTCdptn2ik=;
        b=uuDKjEWJcY4SoLxr6dhq3BRz2s8c0Ojrn1CN5t+/NGNW9xVg3YVZsrUuVconWKZnPJ
         ibQR2AlcUEwtsrVTfpgJkV51KH1r5sLCaIyboy39f7//XRqyf5avyDGgfG7v8Rm+Ox0a
         W1E2RFQbvaun5FqCSckqiRKd87pFcdCqNK23cotjt9Uj8iIyqtcQzHIQavImkIqUhhqK
         vXeh+iXE6CCjLRPU91YntAFZCukMYS4dv6OjahEvrZxvUoDrmUTvEYOVQ74uvvxOfQrl
         vF7bH96n6b9fXFcR67L5Jdab1czWk31PJvcrPtQbgfaGow4dGDrNKY8GowP0mJ/CbgFr
         0/Lg==
X-Forwarded-Encrypted: i=1; AKwUvBxLQaDL7/iQwnNCmx51skSJ5n486/iOvBBaZW0Ylu6zHiCOHoBKBaKLPar8BRpCKCMqPqZzjswWY0k=@vger.kernel.org
X-Gm-Message-State: AFq9FYIAx6F1cjdedfDColjvXIr3sVA8kO3RCvbu3NSQCxKNBuCO6fOq
	YmTiTn9G8dr1Wtmlgf/BJ5sgj3fOLcSQbKJ42I4AclcUMJBYsYLEdKYgqQ5bAFH0+JHpxXBde6u
	O5w753WvXJdQPyA==
X-Received: from plbl17.prod.google.com ([2002:a17:902:eb11:b0:2e3:1b6e:33bb])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1d4f:b0:3a4:a592:4cfa with SMTP id 98e67ed59e1d1-3ab3a79d9f8mr10690339a91.45.1791908745986;
 Tue, 13 Oct 2026 09:25:45 -0700 (PDT)
Date: Tue, 13 Oct 2026 16:25:26 +0000
In-Reply-To: <20261013162529.1928093-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261013162529.1928093-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261013162529.1928093-11-dmatlack@google.com>
Subject: [PATCH v10 10/13] PCI: liveupdate: Adopt ARI Forwarding Enable on
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
	Pratyush Yadav <pratyush@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"

Adopt the ARI Forwarding Enable bit on preserved bridges and update
pci_dev->ari_enabled accordingly during a Live Update. This ensures that
the preserved devices on the bridge's secondary bus can be identified
with the same expanded 8-bit function number after a Live Update.

pci_liveupdate_adopt_ari() updates the bridge's ari_enabled the same way,
and from the same context, as pci_configure_ari() already does when it
enables or disables ARI Forwarding on the bridge.

Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/liveupdate.c | 35 +++++++++++++++++++++++++++++++++++
 drivers/pci/liveupdate.h |  6 ++++++
 drivers/pci/pci.c        |  8 +++++++-
 3 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index 1d2324d339da..e640794cc8e6 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -189,6 +189,10 @@
  *    way after Live Update and ensures that IOMMU groups do not change. Note
  *    that a device will use its adopted ACS controls for the lifetime of its
  *    struct pci_dev (i.e. even after pci_liveupdate_finish()).
+ *
+ *  * The PCI core adopts ARI Forwarding Enable on all bridges with downstream
+ *    preserved devices to ensure that all preserved devices on the bridge's
+ *    secondary bus are addressable after the Live Update.
  */
 
 #define pr_fmt(fmt) "PCI: liveupdate: " fmt
@@ -922,6 +926,37 @@ int pci_liveupdate_adopt_acs(struct pci_dev *dev)
 	return 0;
 }
 
+/**
+ * pci_liveupdate_adopt_ari() - Adopt ARI configuration
+ * @dev: The PCI device to adopt ARI configuration for
+ *
+ * For devices preserved across a Live Update, read the ARI state from
+ * hardware and adopt it. This ensures the device continues to use the ARI
+ * configuration established by the previous kernel.
+ *
+ * Return: 0 on success, or -EINVAL if the device was not preserved.
+ */
+int pci_liveupdate_adopt_ari(struct pci_dev *dev)
+{
+	u16 val;
+
+	guard(rwsem_read)(&pci_liveupdate.rwsem);
+
+	/*
+	 * Unlike ACS, only adopt ARI while the bridge is incoming-preserved.
+	 * Once all devices below the bridge have finished, recomputing ARI
+	 * Forwarding Enable yields the same result for the same device, and
+	 * must be allowed to change if a different device is hot-plugged.
+	 */
+	if (!dev->liveupdate.incoming)
+		return -EINVAL;
+
+	pcie_capability_read_word(dev, PCI_EXP_DEVCTL2, &val);
+
+	dev->ari_enabled = !!(val & PCI_EXP_DEVCTL2_ARI);
+	return 0;
+}
+
 /**
  * pci_liveupdate_is_incoming() - Check if a device is incoming-preserved
  * @dev: The PCI device to check
diff --git a/drivers/pci/liveupdate.h b/drivers/pci/liveupdate.h
index d4721ffcecb2..90b2754ecc0c 100644
--- a/drivers/pci/liveupdate.h
+++ b/drivers/pci/liveupdate.h
@@ -16,6 +16,7 @@ void pci_liveupdate_cleanup_device(struct pci_dev *dev);
 bool pci_liveupdate_preserve_bus_numbers(void);
 bool pci_liveupdate_refuse_bus_numbers(struct pci_bus *bus, struct pci_dev *dev);
 int pci_liveupdate_adopt_acs(struct pci_dev *dev);
+int pci_liveupdate_adopt_ari(struct pci_dev *dev);
 #else
 static inline void pci_liveupdate_setup_device(struct pci_dev *dev)
 {
@@ -40,6 +41,11 @@ static inline int pci_liveupdate_adopt_acs(struct pci_dev *dev)
 {
 	return -EINVAL;
 }
+
+static inline int pci_liveupdate_adopt_ari(struct pci_dev *dev)
+{
+	return -EINVAL;
+}
 #endif
 
 #endif /* DRIVERS_PCI_LIVEUPDATE_H */
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 650d7f92f93a..e5b960ca26e6 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3705,7 +3705,7 @@ void pci_configure_ari(struct pci_dev *dev)
 	u32 cap;
 	struct pci_dev *bridge;
 
-	if (pcie_ari_disabled || !pci_is_pcie(dev) || dev->devfn)
+	if (!pci_is_pcie(dev) || dev->devfn)
 		return;
 
 	bridge = dev->bus->self;
@@ -3716,6 +3716,12 @@ void pci_configure_ari(struct pci_dev *dev)
 	if (!(cap & PCI_EXP_DEVCAP2_ARI))
 		return;
 
+	if (!pci_liveupdate_adopt_ari(bridge))
+		return;
+
+	if (pcie_ari_disabled)
+		return;
+
 	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ARI)) {
 		pcie_capability_set_word(bridge, PCI_EXP_DEVCTL2,
 					 PCI_EXP_DEVCTL2_ARI);
-- 
2.56.0.385.gd3acb90ef8-goog

