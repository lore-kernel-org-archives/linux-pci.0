Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792445491;
	b=aaKWLl82dGy0mCroTjHYjUc/d2jpT6iGNZGdWRGLFUGvJY+0gNpRF8TrRQ5RCfaDCsUw
	 5Np4MWouXi7NIFFhBOY4I06+0xUG6v37O45mu/tSXOo6K+tj5ELz4wufw6Yzyi4RjzMQI
	 x3Oa11IZe9flw66qLRmueob+nZjo2szc4OshZ2iCgn7S7dVhAGhiITAl0ACMmepNx1ae9
	 rp22g9ogB4AafgY3PtcdunueSwyeFeTngt/gfftS4sycSTEim4paWVKpx20EbCBlp2Cr+
	 i9pRGHhiHyqAA/4DNkUsQCSwu6q2X11wg0TwtbohE53gmpVIkNRkOUNRmMB4L95P5Zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792445491;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=27szfxESPIZuT7PVf91SFMXZ+5PrRuOJzgCi66FtF/Q=;
	b=N+dfns/5QAuWzGYSkrp+MosEBQCpxv9gUxeOI9K1WIRs+YOW5uClrNFOHjJbRSATijNG
	 YUB43Xl3aT7YW7R3BfVGEqMRxuvWXSWUfblcY0cf22+E+hEXRVoKhzlLL2PVt71pqTFRX
	 Lk1FKiZ4m3Lsno6O71NPU/VuSuRavZa/+4RV9jGHM8/O8pFGCE2/MBUhmjDvy2JyqFGYB
	 H4kJZe+3N6v1ihW9+iseILgh0W/QOeXNsvQlFSfEtXz+7+3XnrIjqZBdKopf08XYZ4B2j
	 av9ClJoj/dPVmXlgDZo4xGfOHJ/MRmViKNeOA7mmnh0DvSdZCqq+PUtzUe6wrTNrRXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=i4lrcuR5;
	arc=none smtp.remote-ip=209.85.216.69
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C7B606A32E
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 21:31:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7C7B606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=i4lrcuR5
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38f97b3f853so3476334a91.3
        for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 14:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792445490; x=1793050290; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=27szfxESPIZuT7PVf91SFMXZ+5PrRuOJzgCi66FtF/Q=;
        b=i4lrcuR5Gz3f03/2FaWCGGrOASn2Z8EJMgJpErVvT8tyfFmDQ+pvrxBkXLLzk5LTQi
         0rNv8Df3ri/jYg101eIWcr/8kAP0BGnChC7KfQ5/5O6u3Z9ns0j67XyfF0D2O8IsnfpA
         08mQTrT3dH8UboVu3Emoo9YxxkU54NFTNSWpbteQtQ+kfaFCHYNXeo01hex7+i8r2GxA
         XiDP6Yf9FI8SrbO7sLCzsbHpc+Zf9Nu1IlCtkS3330fIjP9JN9F0qNRF44GJC+BlsDNK
         WdoA79vBUa3NpK9JmePcuCm6djuDjnI6p+fdeWzlqQrNYw1gM0UFGGTTTdpCxoqivYnq
         RqvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792445490; x=1793050290;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=27szfxESPIZuT7PVf91SFMXZ+5PrRuOJzgCi66FtF/Q=;
        b=MnPMEQqA41FCKSp5QRvo0VZYLRVULzHqxsipZQf5DzKsl7TiCdAdTXef4cYaq8u6Ge
         jNJ0WHmBHLBE2PT/BqApOhinZ254Ip0EAKQ3/xbFZGrn4gO4n9AspuEOmgOVAst54GzL
         l++p2yTl/8kh8dUXRCcrChis394+ZwE85KR1YuP4j1m+3Bhsr1hvJ+j7N3OCcUNI36Tz
         Y8MC/FbV11qISp63OwMvtHsRFetmznl9yP+UHlYhYjcGvvziuxRigNp8JSbIxR8exA4X
         NWnaWOgVh/7O0kwv7t+8pp4iF7srRqPoWrOCTZQgILsObeZFDXtFWEb+XrcAz6kA1l6V
         ZpsQ==
X-Forwarded-Encrypted: i=1; AKwUvBzwaXlJ1NDX0O7NEp0y++Bdmq2p8HF11dBwnvi4NCw0tF4sodB5T6wqG7CUHqkABdh/iWEefwKiTMA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLMzPElJcdolTFcbZ+hDGSAvmKQqjWMEjBj5aTEWTjN06cIC+LZ
	1K1We5B/0JYEYUaR41eIDEnQPg3CuXD7nunumBCJ/bIJnMrfBqCxMB5QYKjgZdbtXA0M4AP1RCT
	mFlGsG56khtf3tA==
X-Received: from pgbm24-n2.prod.google.com ([2002:a05:6a02:6198:20b0:cc7:c2bc:cc73])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4d06:b0:3a6:e159:a233 with SMTP id 98e67ed59e1d1-3aceefae03fmr7921990a91.43.1792445489657;
 Mon, 19 Oct 2026 14:31:29 -0700 (PDT)
Date: Mon, 19 Oct 2026 21:30:54 +0000
In-Reply-To: <20261019213054.3157159-1-dmatlack@google.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261019213054.3157159-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261019213054.3157159-11-dmatlack@google.com>
Subject: [PATCH 10/10] PCI: liveupdate: Avoid enabling INTx on incoming devices
From: David Matlack <dmatlack@google.com>
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-pci@vger.kernel.org
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	David Matlack <dmatlack@google.com>, 
	"=?UTF-8?q?Ilpo=20J=C3=A4rvinen?=" <ilpo.jarvinen@linux.intel.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Logan Gunthorpe <logang@deltatee.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

Avoid clearing PCI_COMMAND_INTX_DISABLE on incoming preserved devices.
Pass whether INTx masking is broken on each preserved device to the
next kernel instead of probing it, and skip clearing
PCI_COMMAND_INTX_DISABLE in do_pci_enable_device() for incoming
devices.

Clearing PCI_COMMAND_INTX_DISABLE enables INTx on the device, even if
only temporarily. pci_intx_mask_broken() probes whether INTx masking
works by toggling PCI_COMMAND_INTX_DISABLE during enumeration, and
do_pci_enable_device() clears it when a device that is not using MSI or
MSI-X is enabled. A preserved device may assert INTx at any point
during the Live Update, before its driver in the next kernel has set up
interrupt handling, so enabling INTx could result in interrupts that
no handler claims, on a line that may be shared with other devices.

Pass the result of probing as a new bit in the probed results in
struct pci_dev_ser, PCI_DEV_SER_PROBED_BROKEN_INTX_MASKING, which
reflects struct pci_dev::broken_intx_masking. If the previous kernel
did not pass it, fall back to probing INTx masking.

Drivers bound to incoming devices are responsible for enabling INTx once
they are ready to handle it. pci_alloc_irq_vectors() already does so
with pci_intx() when it falls back to INTx, and vfio-pci clears
PCI_COMMAND_INTX_DISABLE itself in vfio_pci_core_enable().

Assisted-by: LLM
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/liveupdate.c    | 37 ++++++++++++++++++++++++++++++++++++-
 drivers/pci/liveupdate.h    |  6 ++++++
 drivers/pci/pci.c           |  8 ++++++++
 drivers/pci/probe.c         | 10 ++++++++++
 include/linux/kho/abi/pci.h |  3 +++
 5 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index ac4525568818..8a74762c3f7d 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -216,6 +216,11 @@
  *    bridge implements), since that would disrupt memory transactions
  *    targeting the device or devices below it. Instead, the previous kernel
  *    passes the results of probing in struct pci_dev_ser.
+ *
+ *  * The PCI core does not enable INTx (i.e. clear PCI_COMMAND_INTX_DISABLE)
+ *    on incoming preserved devices, neither while probing whether INTx masking
+ *    works nor when the device is enabled, since the device could then raise
+ *    interrupts before its driver is ready to handle them.
  */
 
 #define pr_fmt(fmt) "PCI: liveupdate: " fmt
@@ -650,7 +655,11 @@ static void pci_liveupdate_save_bar_masks(struct pci_dev *dev,
 static void pci_liveupdate_preserve_probed(struct pci_dev *dev,
 					   struct pci_dev_ser *dev_ser)
 {
-	u64 supported = 0, probed = 0;
+	u64 supported = PCI_DEV_SER_PROBED_BROKEN_INTX_MASKING;
+	u64 probed = 0;
+
+	if (dev->broken_intx_masking)
+		probed |= PCI_DEV_SER_PROBED_BROKEN_INTX_MASKING;
 
 	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
 		supported |= PCI_DEV_SER_PROBED_WINDOWS;
@@ -1213,6 +1222,32 @@ int pci_liveupdate_read_bridge_windows(struct pci_dev *bridge)
 	return 0;
 }
 
+/**
+ * pci_liveupdate_intx_mask_broken() - Get whether INTx masking is broken on an
+ *                                     incoming device
+ * @dev: The PCI device
+ *
+ * Get whether INTx masking is broken on @dev as determined by the previous
+ * kernel, so that INTx masking does not need to be probed.
+ *
+ * Return: 1 if INTx masking is broken, 0 if it is not, or -ENODATA if @dev is
+ * not incoming-preserved or the previous kernel did not pass whether INTx
+ * masking is broken on @dev.
+ */
+int pci_liveupdate_intx_mask_broken(struct pci_dev *dev)
+{
+	u64 probed;
+
+	guard(rwsem_read)(&pci_liveupdate.rwsem);
+
+	if (!pci_liveupdate_read_probed(dev,
+					PCI_DEV_SER_PROBED_BROKEN_INTX_MASKING,
+					&probed))
+		return -ENODATA;
+
+	return !!probed;
+}
+
 /*
  * Check if the windows of @bridge have been read from hardware. Outside of x86
  * that does not happen during scanning.
diff --git a/drivers/pci/liveupdate.h b/drivers/pci/liveupdate.h
index 98d23e217308..7f86cc85deee 100644
--- a/drivers/pci/liveupdate.h
+++ b/drivers/pci/liveupdate.h
@@ -22,6 +22,7 @@ bool pci_liveupdate_is_outgoing(struct pci_dev *dev);
 int pci_liveupdate_read_bar_masks(struct pci_dev *dev, unsigned int nr_bars,
 				  u32 *bar_masks, u32 *rom_mask);
 int pci_liveupdate_read_bridge_windows(struct pci_dev *bridge);
+int pci_liveupdate_intx_mask_broken(struct pci_dev *dev);
 void pci_liveupdate_claim_bus_resources(struct pci_bus *bus);
 #else
 static inline void pci_liveupdate_setup_device(struct pci_dev *dev)
@@ -74,6 +75,11 @@ static inline int pci_liveupdate_read_bridge_windows(struct pci_dev *bridge)
 	return -EINVAL;
 }
 
+static inline int pci_liveupdate_intx_mask_broken(struct pci_dev *dev)
+{
+	return -EINVAL;
+}
+
 static inline void pci_liveupdate_claim_bus_resources(struct pci_bus *bus)
 {
 }
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 853c84a2c782..43af72d1e5c9 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2184,6 +2184,14 @@ static int do_pci_enable_device(struct pci_dev *dev, int bars)
 	if (dev->msi_enabled || dev->msix_enabled)
 		return 0;
 
+	/*
+	 * Leave INTx disabled on devices preserved across Live Update, since
+	 * the device could raise interrupts before its driver is ready. It is
+	 * up to the driver to enable INTx once it is ready.
+	 */
+	if (pci_liveupdate_is_incoming(dev))
+		return 0;
+
 	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
 	if (pin) {
 		pci_read_config_word(dev, PCI_COMMAND, &cmd);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index a53d0077a08b..badce31b34f8 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1976,6 +1976,16 @@ static u8 pci_hdr_type(struct pci_dev *dev)
 static int pci_intx_mask_broken(struct pci_dev *dev)
 {
 	u16 orig, toggle, new;
+	int ret;
+
+	/*
+	 * Toggling PCI_COMMAND_INTX_DISABLE could let a device preserved across
+	 * Live Update raise interrupts before its driver is ready, so use the
+	 * result determined by the previous kernel for those devices.
+	 */
+	ret = pci_liveupdate_intx_mask_broken(dev);
+	if (ret >= 0)
+		return ret;
 
 	pci_read_config_word(dev, PCI_COMMAND, &orig);
 	toggle = orig ^ PCI_COMMAND_INTX_DISABLE;
diff --git a/include/linux/kho/abi/pci.h b/include/linux/kho/abi/pci.h
index 84a1bf71eeca..badcf2f01be7 100644
--- a/include/linux/kho/abi/pci.h
+++ b/include/linux/kho/abi/pci.h
@@ -95,10 +95,13 @@ struct pci_dev_ser {
  *    window.
  *  * PCI_DEV_SER_PROBED_PREF_64_WINDOW: The bridge's prefetchable memory
  *    window is 64-bit.
+ *  * PCI_DEV_SER_PROBED_BROKEN_INTX_MASKING: INTx masking cannot be used on
+ *    the device, i.e. struct pci_dev::broken_intx_masking is set.
  */
 #define PCI_DEV_SER_PROBED_IO_WINDOW		BIT_ULL(0)
 #define PCI_DEV_SER_PROBED_PREF_WINDOW		BIT_ULL(1)
 #define PCI_DEV_SER_PROBED_PREF_64_WINDOW	BIT_ULL(2)
+#define PCI_DEV_SER_PROBED_BROKEN_INTX_MASKING	BIT_ULL(3)
 
 /*
  * The size of struct pci_dev_ser when this ABI was introduced. Since fields
-- 
2.56.0.212.g129ede20d9-goog

