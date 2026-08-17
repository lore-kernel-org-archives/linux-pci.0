Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1969E34D3B9
	for <linux-pci@vger.kernel.org>; Mon, 17 Aug 2026 20:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786998509; cv=none; b=Rc9nJxYHAYsStIedYD84+hWCW6Az/JtzRDqMd+dpF7zy7B2wv+0khRjbwUlbpVMnZ4xHP0jJqA2WK1pbUnHW74r0UhY9C50Akl8mjKq/i5UkjwLO4cucplq/UgUw9LapEogJbEAvs5LWQAhNyyIFY/0r6TK4x50bGP+RUibPxa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786998509; c=relaxed/simple;
	bh=aDxnhQ6FiqcrfRU/2/AckhUywVbzCjbMdykm/xY9l30=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=gbkuoA/olTdmgfd4Z6+wAcqJ5y0IPCImizutVz3ZULIFG8UW5HEzMRp0cm+tikmdBJJL1DEeKMycuVRQrGap2NX1Oo7t2XDf7UhhaY4bFiwesaUcHqP3lCr0okvH4SwLKlhrRHdwB/jEYnsiSSQ1kio7UGdwoGwX0vqio+3Lcis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l3OBKD69; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l3OBKD69"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38ecc48b3c2so6290694a91.1
        for <linux-pci@vger.kernel.org>; Mon, 17 Aug 2026 13:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786998507; x=1787603307; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GJW6PilJrU2i+SPmfb2uKwj6iYMQzDWi+W0fuzs5FQk=;
        b=l3OBKD69j4MSUUnY3nlBQXwVE/6EyDwfI0c9KyadevzXoRySSGA0sJ7oN5IyC7Okyy
         emcAov53uh9QRid7pXSNSXBK1F/0a1M/jjN2/TuO8bPx7dwUQQE2GC+H+z5cVRrgIbBb
         mHyWZ57XD7ag5hV0pelsP1JylzJnZaU+3G07fkrbMnWZqOgpWT/VZEaMScJXaHsAc1mu
         LUarV7Dfh5RYSoAEg0GE+GYljb2MBjyIGnM6UNKBe+x4pWtnsihsWhq0KXmeVkNHYMN5
         tE/5bIXX9w3zwtnbPWwbshHJqMN7y42UK8pD+V2Ak6W8hx8GFgX7Gc7l3ALU25PIh33o
         Jsqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786998507; x=1787603307;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GJW6PilJrU2i+SPmfb2uKwj6iYMQzDWi+W0fuzs5FQk=;
        b=KvcZE4nwzfGPtEpJ8adlZHFybA/9fy/wmghB9G5hHnG9xAay9WYXtJ3V3wf82ydCC2
         3UAnwAz0KomGJk2KZ1qE222ZpUhBWR7sX77orS71TNAMNzZMqs0H+3upfmWU9U//I6LH
         jqdJV8rVwrLNdtXaqb5t3ekjOT33ENs/r2zrysexkxCK6qa2NjcmM2+ByfJpfyvWpv7x
         aqGVuDy8ZRwiqOYkbkOC+hLbI7Vj9afPYLHRlRfY6hh9/q6u+Z6Kn1be/l7cncOB3v7d
         foh+Rg1DYeeMfytF8Xp9fQljNH4RsaJ7UpU1t6hIvJhbRXbmj/sS4kTcZ+aSh29SR7FE
         t/uA==
X-Forwarded-Encrypted: i=1; AHgh+Rr+tpprdvxvlh7W/Ba1nSs7F86JEDzovLlTqthQ2LYpt2J4fG+8QRtj5aj90ssj59oSqw77l0AZvlI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8lwHFPF8o/vW1VXtG0KJvgL3yQ0H1Zn8rHfReNTAETMgvgCKg
	JMJHUvzOTp4trO0K5Cl35RayeRCX6nA/0pJ3en+psHWrvu4Q5bCzSg8t7aJJ9o7JqnYVQWg9QAe
	hHghFi8ozysHPHw==
X-Received: from pjbnl15.prod.google.com ([2002:a17:90b:384f:b0:38f:a3cc:f600])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5447:b0:393:1cf4:d972 with SMTP id 98e67ed59e1d1-3933b6e6db1mr28510221a91.3.1786998507269;
 Mon, 17 Aug 2026 13:28:27 -0700 (PDT)
Date: Mon, 17 Aug 2026 20:28:23 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.699.gb54405d56f-goog
Message-ID: <20260817202823.2172548-1-dmatlack@google.com>
Subject: [PATCH v4] PCI: Ensure ATS disabled via quirk before notifying IOMMU drivers
From: David Matlack <dmatlack@google.com>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, Alex Deucher <alexander.deucher@amd.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Bartosz Pawlowski <bartosz.pawlowski@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, David Woodhouse <dwmw2@infradead.org>, 
	Guchun Chen <guchun.chen@amd.com>, Joerg Roedel <jroedel@suse.de>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Raghavendra Rao Ananta <rananta@google.com>, 
	David Matlack <dmatlack@google.com>, Pranjal Shrivastava <praan@google.com>
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

The Intel IOMMU driver uses pci_ats_supported() in probe/release to
determine whether to add/remove a device from a tracking rbtree. This
strict reliance on pci_ats_supported() remaining constant between probe
and release was introduced by commit 89436f4f5412 ("iommu/vt-d: Fix
WARN_ON in iommu probe path"). Because FINAL quirks evaluate too late
(in pci_bus_add_device()), pci_ats_supported() evaluated to true during
IOMMU probe but false during release. This mismatch bypassed the rbtree
removal upon device release, leading to a later use-after-free.

Note that this fix only matters for PCI devices created after IOMMU bus
notifiers are set up (e.g. hot-plugged devices and VFs).

Fixes: a18615b1cfc0 ("PCI: Disable ATS for specific Intel IPU E2000 devices")
Fixes: 9b44b0b09dec ("PCI: Mark AMD Stoney GPU ATS as broken")
Fixes: 3f1271b54edc ("PCI: Mark all AMD Navi10 and Navi14 GPU ATS as broken")
Closes: https://lore.kernel.org/linux-iommu/aYUQ_HkDJU9kjsUl@google.com/
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Tested-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
v4:
 - Rebase onto tip of Linus' tree
 - Add Pranjal's Reviewed-by and Tested-by tags

v3: https://lore.kernel.org/linux-pci/20260403222750.1215002-1-dmatlack@google.com/
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
index 96efa00d9743..772fb1968f3c 100644
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
index b09f27f7846f..34f1aee744ac 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5646,7 +5646,7 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0422, quirk_no_ext_tags);
 static void quirk_no_ats(struct pci_dev *pdev)
 {
 	pci_info(pdev, "disabling ATS\n");
-	pdev->ats_cap = 0;
+	pdev->no_ats = 1;
 }
 
 /*
@@ -5669,25 +5669,25 @@ static void quirk_amd_harvest_no_ats(struct pci_dev *pdev)
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
@@ -5698,15 +5698,15 @@ static void quirk_intel_e2000_no_ats(struct pci_dev *pdev)
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
 
 static bool quirk_nvidia_gpu_ats_required(struct pci_dev *pdev)
 {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 64b308b6e61c..393eb77112c9 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -546,6 +546,7 @@ struct pci_dev {
 	};
 	u16		ats_cap;	/* ATS Capability offset */
 	u8		ats_stu;	/* ATS Smallest Translation Unit */
+	u8		no_ats:1;	/* ATS disabled via quirk */
 #endif
 #ifdef CONFIG_PCI_PRI
 	u16		pri_cap;	/* PRI Capability offset */

base-commit: 8d3ae59288f1e7d58d76558a6ee96d533bc5019f
-- 
2.55.0.699.gb54405d56f-goog

