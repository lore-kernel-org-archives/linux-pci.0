Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F783596E3
	for <linux-pci@vger.kernel.org>; Fri,  3 Apr 2026 22:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775255278; cv=none; b=ikiSAWzmziwcsD3bNIjjpT0QuHmE9C7FVEzC9U426Nsz46LZPkBtbKAKUz2k7gn64SrtVIXnxRjqlWfdyHKj2KO4MosI8Kl49rOs57Uby9vhb/br/z6OuANfO4C2G+SWQjdXqRHGxl/+gYe8kT9xqvOaXZuebWH9Xm/lpLj6Jbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775255278; c=relaxed/simple;
	bh=XAkU2xkhijHiYZGAuk35LlXeS8OuyPA6sND6DEWoHag=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=sP6z/gMXaWUr0L+wLey7bq/pD0r6+3mGzOy6kaRBj9UtdkHMDLKomaGJ9dy1v0gGAh5NoAPwHKKPag3qpnlQKkuNPpHux9wsM8/8sltgCXV/Mq+sh+KrLVwzw3rgk4MDn+U7MmDDSRwsKTgKD3VE4vbNvch/ZoMdR9mtexHvb6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cY3zyD7N; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cY3zyD7N"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b0cf396c45so24192145ad.1
        for <linux-pci@vger.kernel.org>; Fri, 03 Apr 2026 15:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775255277; x=1775860077; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gZAEk/NLfvQ39dD9WrECKYPgf8YAimp4ZFpPWFWfn3s=;
        b=cY3zyD7NaK2xuiKU3UvB8c3rgbl/q9QRvSeCcHFRmjBg0BcObINXT1hdfauE+z0sT2
         ZwUqeYEhehL8tOG7mL7W9GWMoAPcUdHjGnOxeIkrwUnTZtxm5KjJUsL7PLajGfi44Fpe
         moZ+fSW7ZiObXKKuhiTw6hSpBGM+0s1Y1EPzp8Orhiw1HTFkqwyOtDmxXZmBEkfDfUb8
         AzsfI+XVs7koUcSl8+rAppnlpJaxmAgrr4nlbxOZV7oCHpV3n1BlNQrc94O2Zz+oUgME
         WOZBikTThAgnL1tl7KnPVcuNzJWb+CYcgJItA/yGZvBdUUu/6K7hMpC4pU1WOmM3qWmv
         SddA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775255277; x=1775860077;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gZAEk/NLfvQ39dD9WrECKYPgf8YAimp4ZFpPWFWfn3s=;
        b=gPVCgVz83yGui5d2sJjR3lQVGZV5DnxMCWzxh/36qkK2OySs9aeonf8MU5FutgcdZA
         qxZKilM4ThRqxEmTHEZ1vZQgOA0GBI+te1khdb7iq4oBIs5snFxt7Hv+Mx+3zI/ntKAB
         eUtF39AbyKBz1cP9nG+jCQw4wnXyhyJm7w3F3dfGB8HFoHM38h9g3vn64yWJjwg4Y/eJ
         il5cqIk4IXY4VVzxVmHAJL9xY2tlPCDGveEUUPS07c1BkZjL0G4b8DEeGpP2D/MLYTJh
         Ic+2abeizYe1GHzPVWQRANUhw76HMZ5i75sJLqLnEynJfxatmoreF7REsHdZS32tK4L9
         BCRw==
X-Forwarded-Encrypted: i=1; AJvYcCVPtbChlXOIaMtAFoqBfHQHNcD43OKkjidJ64CCLlw87eGceZ9FtaDxO4wFSETobrT6Ss2GIs/wiKk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1wE5V/VPn9ufWPTfBbPEnUyjWwRf1O4GC9k0nIjY0pwnG/AmV
	UI+LzmFcXNaki8WwHP2CuhSYvKBds4lBaus5VZHbgdE6iwNYFE8SX7yty0vrkFIMvkBOhyB971S
	C6/7n/48NVorHxQ==
X-Received: from plbbj9.prod.google.com ([2002:a17:902:8509:b0:2b2:6ee9:4674])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f78f:b0:2b2:4d78:eec2 with SMTP id d9443c01a7336-2b281821ca2mr49028735ad.18.1775255276599;
 Fri, 03 Apr 2026 15:27:56 -0700 (PDT)
Date: Fri,  3 Apr 2026 22:27:50 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260403222750.1215002-1-dmatlack@google.com>
Subject: [PATCH v3] PCI: Ensure ATS disabled via quirk before notifying IOMMU drivers
From: David Matlack <dmatlack@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Bartosz Pawlowski <bartosz.pawlowski@intel.com>, David Woodhouse <dwmw2@infradead.org>, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	Lu Baolu <baolu.lu@linux.intel.com>, Raghavendra Rao Ananta <rananta@google.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Ensure that PCI devices always have ATS disable via quirk before IOMMU
drivers are notified about the device. Fix this by converting the
existing quirks from final to header fixups and changing the quirk logic
to set a new no_ats bit in struct pci_dev that prevents pci_dev.ats_cap
from ever getting set.

Use header fixups instead of early fixups since not enough of struct
pci_dev is set up in during early fixups: quirk_amd_harvest_no_ats()
needs subsystem_device and subsystem_vendor to be set.

This change ensures that pci_ats_supported() always takes quirks into
account during iommu_ops.probe_device(), when IOMMU drivers are notified
about devices, and that pci_ats_supported() returns the same value when
the device is released in iommu_ops.release_device().

Notably, the Intel IOMMU driver uses pci_ats_supported() in
probe/release to determine whether to add/remove a device from a data
structure, which easily leads to a use-after-free without this fix.

This change also makes disabling ATS via quirk behave the same way as
the pci=noats command line option, in that pci_ats_init() bails
immediately and never initializes pci_dev.ats_cap.

Note: In practice this fix only matters for PCI devices created after
IOMMU bus notifiers are set up (e.g. hot-plugged devices and VFs).

Fixes: a18615b1cfc0 ("PCI: Disable ATS for specific Intel IPU E2000 devices")
Closes: https://lore.kernel.org/linux-iommu/aYUQ_HkDJU9kjsUl@google.com/
Signed-off-by: David Matlack <dmatlack@google.com>
---
v3:
 - Clarify in commit message that only devices added after boot are
   affected (Baolu)
 - Use header fixups instead of early to avoid breaking
   quirk_amd_harvest_no_ats() (Sashiko)
 - Use u8 instead of unsigned int for no_ats to avoid affecting the
   offsets of existing fields in struct pci_dev (me)

v2: https://lore.kernel.org/linux-pci/20260327211649.3816010-1-dmatlack@google.com/

v1: https://lore.kernel.org/linux-pci/20260223184017.688212-1-dmatlack@google.com/

Cc: Raghavendra Rao Ananta <rananta@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

 drivers/pci/ats.c    |  2 +-
 drivers/pci/quirks.c | 50 ++++++++++++++++++++++----------------------
 include/linux/pci.h  |  1 +
 3 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index ec6c8dbdc5e9..ceb6f5d3cb10 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -21,7 +21,7 @@ void pci_ats_init(struct pci_dev *dev)
 {
 	int pos;
 
-	if (pci_ats_disabled())
+	if (pci_ats_disabled() || dev->no_ats)
 		return;
 
 	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ATS);
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 48946cca4be7..da010d15b239 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5653,7 +5653,7 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0422, quirk_no_ext_tags);
 static void quirk_no_ats(struct pci_dev *pdev)
 {
 	pci_info(pdev, "disabling ATS\n");
-	pdev->ats_cap = 0;
+	pdev->no_ats = 1;
 }
 
 /*
@@ -5676,25 +5676,25 @@ static void quirk_amd_harvest_no_ats(struct pci_dev *pdev)
 }
 
 /* AMD Stoney platform GPU */
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x98e4, quirk_amd_harvest_no_ats);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATI, 0x98e4, quirk_amd_harvest_no_ats);
 /* AMD Iceland dGPU */
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x6900, quirk_amd_harvest_no_ats);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATI, 0x6900, quirk_amd_harvest_no_ats);
 /* AMD Navi10 dGPU */
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7310, quirk_amd_harvest_no_ats);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7312, quirk_amd_harvest_no_ats);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7318, quirk_amd_harvest_no_ats);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7319, quirk_amd_harvest_no_ats);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x731a, quirk_amd_harvest_no_ats);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x731b, quirk_amd_harvest_no_ats);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x731e, quirk_amd_harvest_no_ats);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x731f, quirk_amd_harvest_no_ats);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATI, 0x7310, quirk_amd_harvest_no_ats);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATI, 0x7312, quirk_amd_harvest_no_ats);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATI, 0x7318, quirk_amd_harvest_no_ats);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATI, 0x7319, quirk_amd_harvest_no_ats);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATI, 0x731a, quirk_amd_harvest_no_ats);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATI, 0x731b, quirk_amd_harvest_no_ats);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATI, 0x731e, quirk_amd_harvest_no_ats);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATI, 0x731f, quirk_amd_harvest_no_ats);
 /* AMD Navi14 dGPU */
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7340, quirk_amd_harvest_no_ats);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7341, quirk_amd_harvest_no_ats);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7347, quirk_amd_harvest_no_ats);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x734f, quirk_amd_harvest_no_ats);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATI, 0x7340, quirk_amd_harvest_no_ats);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATI, 0x7341, quirk_amd_harvest_no_ats);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATI, 0x7347, quirk_amd_harvest_no_ats);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATI, 0x734f, quirk_amd_harvest_no_ats);
 /* AMD Raven platform iGPU */
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x15d8, quirk_amd_harvest_no_ats);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATI, 0x15d8, quirk_amd_harvest_no_ats);
 
 /*
  * Intel IPU E2000 revisions before C0 implement incorrect endianness
@@ -5705,15 +5705,15 @@ static void quirk_intel_e2000_no_ats(struct pci_dev *pdev)
 	if (pdev->revision < 0x20)
 		quirk_no_ats(pdev);
 }
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1451, quirk_intel_e2000_no_ats);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1452, quirk_intel_e2000_no_ats);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1453, quirk_intel_e2000_no_ats);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1454, quirk_intel_e2000_no_ats);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1455, quirk_intel_e2000_no_ats);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1457, quirk_intel_e2000_no_ats);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1459, quirk_intel_e2000_no_ats);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x145a, quirk_intel_e2000_no_ats);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x145c, quirk_intel_e2000_no_ats);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x1451, quirk_intel_e2000_no_ats);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x1452, quirk_intel_e2000_no_ats);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x1453, quirk_intel_e2000_no_ats);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x1454, quirk_intel_e2000_no_ats);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x1455, quirk_intel_e2000_no_ats);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x1457, quirk_intel_e2000_no_ats);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x1459, quirk_intel_e2000_no_ats);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x145a, quirk_intel_e2000_no_ats);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x145c, quirk_intel_e2000_no_ats);
 #endif /* CONFIG_PCI_ATS */
 
 /* Freescale PCIe doesn't support MSI in RC mode */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 1c270f1d5123..f9729ee71a96 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -539,6 +539,7 @@ struct pci_dev {
 	};
 	u16		ats_cap;	/* ATS Capability offset */
 	u8		ats_stu;	/* ATS Smallest Translation Unit */
+	u8		no_ats:1;	/* ATS disabled via quirk */
 #endif
 #ifdef CONFIG_PCI_PRI
 	u16		pri_cap;	/* PRI Capability offset */

base-commit: 7df48e36313029e4c0907b2023905dd7213fd678
-- 
2.53.0.1213.gd9a14994de-goog

