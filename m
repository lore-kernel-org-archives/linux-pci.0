Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792445486;
	b=yik8i0SzSpq5av1Lc+pPYTAg+8LjkUxMesu1w4R5myWFJ8afIpV0zUHR1bAbYlocEVSR
	 hglU8TPThpIpv6SuJD1XXpeIYv+yLYxjFHO6kR6TIXoGasa+dTjQFFpUvzSqtgZ7DNvw/
	 Gxqlc/ARhuikQk/OlhiOpQGOtTSq1ZYWpkmEDt8rAXc5VlEuIn8L+xYlW92kQwTDtFgRZ
	 wIdcDYMeSri2uj/BjZslkApgkfzydqS9wLP8PNMjWiNB/t+b1rgfH6nTqcFJUbi/wZZEZ
	 o7ioPUzU+Jh70PLYFOYWH8QzKLebUao7yZPywJwcNbBhqNS7GqMgxEDJ1IhiCCjhpmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792445486;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=ob0OqST4cKlshaBFbfeFqwou5GMUNnLOz8/rLCUeWMM=;
	b=ScaAIvpJsFZzmdbv08JnSBQyI3l7KVJ9anb+VvciU9r0uiIi9E/HoyuaW9TAeaA78qik
	 WVDYju1bNDy8Kmb5XsoMulPPbi4hHC8awdlTcym8MfcHZf1E7wB6AkOlOKrjg4jDc+SBo
	 6Zy8OxCk18bxTvAkaJtdvdZysyXxx3vCw4x3XINbHXuFKVDJ/6pu/7yPz0B1bx4yE6saa
	 JrEr1HuK8ogFSN4eCmJdql8bt/qClsgQYnYq/FkrgqUftiIQuGbo2ErUIH+t6EgokokjW
	 71wJclRIkZN/echaZAqveMdQuhjYazx3JZrOs1P7Kr1cxlRw1f124s/raZKuaaCWjyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=T4Sro0OZ;
	arc=none smtp.remote-ip=209.85.216.72
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9540760A2606
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 21:31:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9540760A2606
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=T4Sro0OZ
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3ac575a9198so4414554a91.3
        for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 14:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792445485; x=1793050285; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ob0OqST4cKlshaBFbfeFqwou5GMUNnLOz8/rLCUeWMM=;
        b=T4Sro0OZ28fiKwxvpYEt2fs/XjjsSsNpSO94bH2OQtLu/IXEZJZJht2v0BcI0JKV4n
         aQLcBeYaohTHUbSA9J5/u0tzt8PvXV8FK4Y8HDSks3AZ8FxqN6VsrABTSKH4RMQ1B6lQ
         OpuiEbqdaroJoFQtv1F2cYA6XfF6kXOJtLuXzrj6WDXZB4MmqM/+jqWxoB8dkw8SjjPz
         VXmnttPaZ2su7b42g0v6PpSqkp0+2YyNkR/XSutq0vGH9OS88qE4QPpE7xihQ4ZXLpeZ
         WACJ14okGtZVoKw9zDkRZIxJi//iDUkS2f+2aPclxtRjFIiqdhKnAV1I/ZEv+VtpjR4v
         sK6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792445485; x=1793050285;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ob0OqST4cKlshaBFbfeFqwou5GMUNnLOz8/rLCUeWMM=;
        b=ElrjqldEN/4Uwo/CZzXFJATsoBRml4WuCgrhtVb+ru4sdJ/Q6b4HikJEi9ROn/We2X
         AQ8ac1LbYMeanHmPnC2gsFLc4+xE0/RfoH9mjc6rtNzm6Grw7B6HdRZ10vBOsIJ2qSZF
         mzo6qSuDfSy0L7FL15cOsGj7xduJIQ6PCN8FQM4zh9Gnvl7pAwT0aywtLNdgsFD7G8Hk
         VJPmtmv2WIme0wT+kYkYCPMiZmcrdqXfWTWI9kiBQx1dukkHqiAjS70R283f9r4A1dHO
         B5pc02F1A1dFc2CBH6LG6XxC9e6ielx4BfbQt0LiiZtRIheKHyTo29dJ0jUsbfgnY/ed
         6KiQ==
X-Forwarded-Encrypted: i=1; AKwUvBzbSW6MJJytbenJ8tOXDagiHmnXAHw8PeDTcPF5Cdk30L4GfwMlD2SsK4P+lmM8MniFVdeHifIf0ac=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ3G9C62uI4FenFXioffvjrKHduz+I+uJCmy3jS45owFvZkZyMK
	OdVxaCqguFYpj96vyMULnBkoTSxFkcVMA7qlfmJlFzC9NVUVhdkBFg/hWO14HKQvTa3p/bnVVG3
	+7/AbTGGuVJy8rQ==
X-Received: from plxe4.prod.google.com ([2002:a17:902:ef44:b0:2e9:73da:58d6])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2b48:b0:3ac:9f00:3bc7 with SMTP id 98e67ed59e1d1-3acef0c88a8mr8307573a91.33.1792445484749;
 Mon, 19 Oct 2026 14:31:24 -0700 (PDT)
Date: Mon, 19 Oct 2026 21:30:48 +0000
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
Message-ID: <20261019213054.3157159-5-dmatlack@google.com>
Subject: [PATCH 04/10] PCI: liveupdate: Avoid probing windows of incoming bridges
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

Avoid probing which windows incoming preserved bridges implement during
enumeration. Instead, add a new optional feature for passing the
results of probing in struct pci_dev_ser, and use it to pass which
windows each preserved bridge implements.

pci_probe_bridge_windows() always writes all 1s to the Prefetchable
Base Upper 32 Bits register of bridges with a 64-bit prefetchable
window to check that it is writable. This temporarily disables the
prefetchable window, so the bridge stops forwarding memory transactions
targeting devices below it, such as P2PDMA from other preserved devices,
or MMIO from VMs whose vCPUs keep running during kexec.

The new optional feature, PCI_SER_OPTIONAL_PROBED, appends two bitmasks
to struct pci_dev_ser: @probed holds the results of probing properties
of the device that require temporarily writing to it, one bit per
property (PCI_DEV_SER_PROBED_*), and @probed_supported indicates which
bits of @probed are valid. This allows passing the results of more
probes in the future (e.g. whether INTx masking is broken) without
adding a new feature flag for each one, and lets the next kernel use
the results it understands and probe the rest.

If the previous kernel did not pass which windows a bridge implements,
fall back to probing the windows.

Assisted-by: LLM
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/liveupdate.c    | 93 ++++++++++++++++++++++++++++++++++++-
 drivers/pci/liveupdate.h    |  6 +++
 drivers/pci/probe.c         |  9 ++++
 include/linux/kho/abi/pci.h | 24 ++++++++++
 4 files changed, 131 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index f48cab3cc232..72ad4fd00f7b 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -204,6 +204,12 @@
  *    vCPUs keep running during kexec). Instead, the previous kernel passes the
  *    size of each BAR in struct pci_dev_ser. Everything else about the BARs
  *    (e.g. their addresses and types) is read from the device as usual.
+ *
+ *  * The PCI core does not probe properties of incoming preserved devices
+ *    that require temporarily writing to the device (e.g. which windows a
+ *    bridge implements), since that would disrupt memory transactions
+ *    targeting the device or devices below it. Instead, the previous kernel
+ *    passes the results of probing in struct pci_dev_ser.
  */
 
 #define pr_fmt(fmt) "PCI: liveupdate: " fmt
@@ -282,7 +288,13 @@ struct pci_flb_incoming {
  * Bits in struct pci_ser::optional_flags that this kernel knows how to handle.
  * This kernel also provides all of them to the next kernel.
  */
-#define PCI_SER_OPTIONAL_FLAGS_SUPPORTED	PCI_SER_OPTIONAL_BAR_MASKS
+#define PCI_SER_OPTIONAL_FLAGS_SUPPORTED \
+	(PCI_SER_OPTIONAL_BAR_MASKS | PCI_SER_OPTIONAL_PROBED)
+
+#define PCI_DEV_SER_PROBED_WINDOWS		\
+	(PCI_DEV_SER_PROBED_IO_WINDOW |		\
+	 PCI_DEV_SER_PROBED_PREF_WINDOW |	\
+	 PCI_DEV_SER_PROBED_PREF_64_WINDOW)
 
 /*
  * The minimum size of struct pci_dev_ser given the optional features that are
@@ -295,6 +307,9 @@ static u32 pci_dev_ser_min_size(u64 optional_flags)
 	if (optional_flags & PCI_SER_OPTIONAL_BAR_MASKS)
 		size = max(size, offsetofend(struct pci_dev_ser, rom_mask));
 
+	if (optional_flags & PCI_SER_OPTIONAL_PROBED)
+		size = max(size, offsetofend(struct pci_dev_ser, probed));
+
 	return size;
 }
 
@@ -626,6 +641,28 @@ static void pci_liveupdate_save_bar_masks(struct pci_dev *dev,
 	dev_ser->rom_mask = lower_32_bits(mask);
 }
 
+static void pci_liveupdate_preserve_probed(struct pci_dev *dev,
+					   struct pci_dev_ser *dev_ser)
+{
+	u64 supported = 0, probed = 0;
+
+	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
+		supported |= PCI_DEV_SER_PROBED_WINDOWS;
+
+		if (dev->io_window)
+			probed |= PCI_DEV_SER_PROBED_IO_WINDOW;
+
+		if (dev->pref_window)
+			probed |= PCI_DEV_SER_PROBED_PREF_WINDOW;
+
+		if (dev->pref_64_window)
+			probed |= PCI_DEV_SER_PROBED_PREF_64_WINDOW;
+	}
+
+	dev_ser->probed_supported = supported;
+	dev_ser->probed = probed;
+}
+
 static int pci_liveupdate_preserve_device(struct pci_flb_outgoing *outgoing,
 					  struct pci_dev *dev)
 {
@@ -671,6 +708,8 @@ static int pci_liveupdate_preserve_device(struct pci_flb_outgoing *outgoing,
 		if (IS_ERR(dev_ser))
 			return PTR_ERR(dev_ser);
 
+		pci_liveupdate_preserve_probed(dev, dev_ser);
+
 		pci_info(dev, "Device will be preserved across next Live Update\n");
 		outgoing->ser->nr_devices++;
 		outgoing->ser->devices = kho_block_set_head_pa(&outgoing->block_set);
@@ -1116,6 +1155,58 @@ int pci_liveupdate_read_bar_masks(struct pci_dev *dev, unsigned int nr_bars,
 	return 0;
 }
 
+/*
+ * Get the results of probing @bits on the incoming device @dev, as passed by
+ * the previous kernel. Returns false if the previous kernel did not pass all of
+ * @bits, in which case they must be probed.
+ */
+static bool pci_liveupdate_read_probed(struct pci_dev *dev, u64 bits,
+				       u64 *probed)
+{
+	struct pci_dev_ser *dev_ser = dev->liveupdate.incoming;
+
+	lockdep_assert_held(&pci_liveupdate.rwsem);
+
+	if (!dev_ser)
+		return false;
+
+	if (!(pci_liveupdate.incoming_optional_flags & PCI_SER_OPTIONAL_PROBED))
+		return false;
+
+	if ((dev_ser->probed_supported & bits) != bits)
+		return false;
+
+	*probed = dev_ser->probed & bits;
+	return true;
+}
+
+/**
+ * pci_liveupdate_read_bridge_windows() - Get the windows of an incoming bridge
+ * @bridge: The PCI bridge
+ *
+ * Set which windows @bridge implements (@bridge->io_window, pref_window, and
+ * pref_64_window) as determined by the previous kernel, so that the windows do
+ * not need to be probed.
+ *
+ * Return: 0 on success, or -ENODATA if @bridge is not incoming-preserved or
+ * the previous kernel did not pass which windows @bridge implements.
+ */
+int pci_liveupdate_read_bridge_windows(struct pci_dev *bridge)
+{
+	u64 probed;
+
+	guard(rwsem_read)(&pci_liveupdate.rwsem);
+
+	if (!pci_liveupdate_read_probed(bridge, PCI_DEV_SER_PROBED_WINDOWS,
+					&probed))
+		return -ENODATA;
+
+	bridge->io_window = !!(probed & PCI_DEV_SER_PROBED_IO_WINDOW);
+	bridge->pref_window = !!(probed & PCI_DEV_SER_PROBED_PREF_WINDOW);
+	bridge->pref_64_window = !!(probed & PCI_DEV_SER_PROBED_PREF_64_WINDOW);
+	return 0;
+}
+
 /**
  * pci_liveupdate_is_incoming() - Check if a device is incoming-preserved
  * @dev: The PCI device to check
diff --git a/drivers/pci/liveupdate.h b/drivers/pci/liveupdate.h
index 80749f14beea..4c4104025a7e 100644
--- a/drivers/pci/liveupdate.h
+++ b/drivers/pci/liveupdate.h
@@ -21,6 +21,7 @@ int pci_liveupdate_adopt_ari(struct pci_dev *dev);
 bool pci_liveupdate_is_outgoing(struct pci_dev *dev);
 int pci_liveupdate_read_bar_masks(struct pci_dev *dev, unsigned int nr_bars,
 				  u32 *bar_masks, u32 *rom_mask);
+int pci_liveupdate_read_bridge_windows(struct pci_dev *bridge);
 #else
 static inline void pci_liveupdate_setup_device(struct pci_dev *dev)
 {
@@ -66,6 +67,11 @@ static inline int pci_liveupdate_read_bar_masks(struct pci_dev *dev,
 {
 	return -EINVAL;
 }
+
+static inline int pci_liveupdate_read_bridge_windows(struct pci_dev *bridge)
+{
+	return -EINVAL;
+}
 #endif
 
 #endif /* DRIVERS_PCI_LIVEUPDATE_H */
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 473e4389ffae..184d93aa8522 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -529,6 +529,15 @@ static void pci_probe_bridge_windows(struct pci_dev *bridge)
 	u16 io;
 	u32 pmem, tmp;
 
+	/*
+	 * Writing to the window registers would disrupt memory transactions
+	 * that bridges preserved across Live Update forward to devices below
+	 * them, so use the windows determined by the previous kernel for those
+	 * bridges.
+	 */
+	if (!pci_liveupdate_read_bridge_windows(bridge))
+		return;
+
 	pci_read_config_word(bridge, PCI_IO_BASE, &io);
 	if (!io) {
 		pci_write_config_word(bridge, PCI_IO_BASE, 0xe0f0);
diff --git a/include/linux/kho/abi/pci.h b/include/linux/kho/abi/pci.h
index 5fa2ecfe5b6d..84a1bf71eeca 100644
--- a/include/linux/kho/abi/pci.h
+++ b/include/linux/kho/abi/pci.h
@@ -66,6 +66,13 @@
  *             which requires disabling decoding and would disrupt memory
  *             transactions targeting the device.
  * @rom_mask: Same as @bar_masks, but for the Expansion ROM BAR.
+ * @probed_supported: The ``PCI_DEV_SER_PROBED_*`` bits that are valid in
+ *                    @probed.
+ * @probed: The results of probing properties of the device that require
+ *          temporarily writing to it (``PCI_DEV_SER_PROBED_*``). Used by the
+ *          next kernel instead of probing the device again, which would
+ *          disrupt memory transactions targeting the device or devices below
+ *          it.
  *
  * Each field after @refcount is only present if the ``PCI_SER_OPTIONAL_*``
  * flag that covers it is set in ``pci_ser.optional_flags``.
@@ -76,8 +83,23 @@ struct pci_dev_ser {
 	u16 refcount;
 	u32 bar_masks[PCI_STD_NUM_BARS];
 	u32 rom_mask;
+	u64 probed_supported;
+	u64 probed;
 } __packed;
 
+/*
+ * Bits in struct pci_dev_ser::probed_supported and probed:
+ *
+ *  * PCI_DEV_SER_PROBED_IO_WINDOW: The bridge has an I/O window.
+ *  * PCI_DEV_SER_PROBED_PREF_WINDOW: The bridge has a prefetchable memory
+ *    window.
+ *  * PCI_DEV_SER_PROBED_PREF_64_WINDOW: The bridge's prefetchable memory
+ *    window is 64-bit.
+ */
+#define PCI_DEV_SER_PROBED_IO_WINDOW		BIT_ULL(0)
+#define PCI_DEV_SER_PROBED_PREF_WINDOW		BIT_ULL(1)
+#define PCI_DEV_SER_PROBED_PREF_64_WINDOW	BIT_ULL(2)
+
 /*
  * The size of struct pci_dev_ser when this ABI was introduced. Since fields
  * can only be appended, every struct pci_dev_ser is at least this large.
@@ -113,7 +135,9 @@ struct pci_ser {
  * large enough to contain the fields of struct pci_dev_ser that it covers:
  *
  *  * PCI_SER_OPTIONAL_BAR_MASKS: @bar_masks and @rom_mask
+ *  * PCI_SER_OPTIONAL_PROBED: @probed_supported and @probed
  */
 #define PCI_SER_OPTIONAL_BAR_MASKS	BIT_ULL(0)
+#define PCI_SER_OPTIONAL_PROBED		BIT_ULL(1)
 
 #endif /* _LINUX_KHO_ABI_PCI_H */
-- 
2.56.0.212.g129ede20d9-goog

