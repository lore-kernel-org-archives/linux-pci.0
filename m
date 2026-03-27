Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB112D0620
	for <linux-pci@vger.kernel.org>; Fri, 27 Mar 2026 21:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774646222; cv=none; b=UwZLCn9fA63+ie+bplasiZzx824QqS1VL+E3o+ELhk0pYoYiM/SrXiC+gmCxf0rm+ATwhu+5QM3VJHcNNvpbNXP01nSTwatgvI0N53lxigAktz845k4xUYdKQgRhvl6X2v1z1UzS8zQZCeODCjd3gNgyYci4vewTLyTOCs6pnqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774646222; c=relaxed/simple;
	bh=GsELgrNxz8NysXFVGpuJJb49OBemyS6+o7WjbjUqBrQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZAad4l8fnjiMN9RkDoZG3AI9f20H3CZNU2iibHxIJTYMF7cWGBDvYtm2fjJXzYw47MipXx6vQwjNSTJgGpBNcO8ZiaSHKgaUfRaHh1DMH5ZFD4OZ//SSdoz3JCi5KyJI9dMTjaxkKJNpKKjuh7ZqXIWmS+rSYI0Et/NQFO1RVv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jerDzyr8; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jerDzyr8"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35c0bd3a968so2508436a91.0
        for <linux-pci@vger.kernel.org>; Fri, 27 Mar 2026 14:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774646220; x=1775251020; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=trO8rmzZPr0RQOymFCLZQOIxeJZ/gPQu+3jTXW69zB0=;
        b=jerDzyr8g1/PV3aJWcODRsQNtUbIg8oGt2n+6fr8SH6Hf8BPdCZwNUQ1aMMPtfdEyK
         FyEfAqAUbYaBZ6yztd/MscakCNR0Z1QGP1oLXmtDtQziASzCawx+zUHo9PqfatBj69+w
         Z+S6UNVtM3BeOLmLFuohDBrlLg0CgfvlB13yOGzEYTSHnL7Ccnklv6gW6eFQq2MiyV3h
         iYu060dZls0BwXizp3cpCrk6qg7sXTJkzF7kDe16idjvX5vNFXcmFablAcFQ+HN7UZ6B
         EbsObRyCDPbh6dk3X/EO9nu0QC9tqsKgWO8+ZNeo+wz161l1iqv+l049BLOmh9SZUIvL
         fkbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774646220; x=1775251020;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=trO8rmzZPr0RQOymFCLZQOIxeJZ/gPQu+3jTXW69zB0=;
        b=mV1Sshpu5AX9dXpFHJSN2PKIO2KJr/2YPN097cpI/sOdF320nxrIcDwcTkQonTeR/D
         2C/6/5aP6OK1a4WKyGMgoBuHGZupi018P2nGpq/i45I7w08HoCjkiBVubDuqgs/uOwft
         eX7bRbJh3y707BzNmFo8RrBgy1XxTRhMNw2T+yJJPYNwmiwiVo/uAY2EWXSoqKgIJZDw
         dYoe/RdGWtCtIeag2hoDUkGo5/X2qIlsVc2MRiKXkY6RBpKXf2SXZTmqNJxUJjFS5gRd
         1ttDJZv0Q5l+Gh41Uvrm8IjpdJlomQ1lR/YapvEub0/0FRsR/xijIErfsFh8w2CqSauC
         gzFw==
X-Forwarded-Encrypted: i=1; AJvYcCVBeWr+s4zlQ0iTli7EGs5wdL6PWayObDeCOnemP8RE7uQYfOpAsVJfwrOxxQ+pkfgICLnqLd19918=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYnZ5RMYNzKuzEKUVnsNbR3NdteUQL4bRZxlwP+S4DEEty+t58
	KcEXawKQ4Q6ep+k7Fvep+X6iaHB+l2Gj+i/cmbN67fee87TXY9cLvvMvTgCOh+bMc+l1vlj9K46
	fCF7SyqFX2lvzgA==
X-Received: from pjbpv14.prod.google.com ([2002:a17:90b:3c8e:b0:35c:2b6d:7890])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4cc6:b0:35b:e4f8:7cb0 with SMTP id 98e67ed59e1d1-35c300c19c4mr3887836a91.21.1774646220375;
 Fri, 27 Mar 2026 14:17:00 -0700 (PDT)
Date: Fri, 27 Mar 2026 21:16:40 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260327211649.3816010-1-dmatlack@google.com>
Subject: [PATCH v2] PCI: Disable ATS via quirk before notifying IOMMU drivers
From: David Matlack <dmatlack@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Bartosz Pawlowski <bartosz.pawlowski@intel.com>, David Woodhouse <dwmw2@infradead.org>, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	Lu Baolu <baolu.lu@linux.intel.com>, Raghavendra Rao Ananta <rananta@google.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Ensure that PCI devices with ATS disabled via quirk have it disabled
before IOMMU drivers are notified about the device rather than after.
Fix this by converting the existing quirks from final to early fixups
and changing the quirk logic to set a new no_ats bit in struct pci_dev
that prevents pci_dev.ats_cap from ever gettting set.

This change ensures that pci_ats_supported() takes quirks into account
during iommu_ops.probe_device(), when IOMMU drivers are first notified
about devices. It also ensures that pci_ats_supported() returns the same
value when the device is released in iommu_ops.release_device().

Notably, the Intel IOMMU driver uses pci_ats_supported() in
probe/release to determine whether to add/remove a device from a data
structure, which easily leads to a use-after-free without this fix.

This change also makes disabling ATS via quirk behave the same way as
the pci=noats command line option, in that pci_ats_init() bails
immediately and never intializes pci_dev.ats_cap.

Fixes: a18615b1cfc0 ("PCI: Disable ATS for specific Intel IPU E2000 devices")
Closes: https://lore.kernel.org/linux-iommu/aYUQ_HkDJU9kjsUl@google.com/
Signed-off-by: David Matlack <dmatlack@google.com>
---
v2:
 - Update the commit message with reasons why this is being fixed in the
   PCI core, rather than applying a point fix to the Intel IOMMU driver
   (Andy)
 - Condense the pci_ats_disabled() and dev->no_ats checks into a single
   line in pci_ats_init()
 - Reorder the no_ats bitfield to be after ats_stu since there is likely
   u8-sized gap there for alignment purposes

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
index 48946cca4be7..2c7e11830e45 100644
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
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_ATI, 0x98e4, quirk_amd_harvest_no_ats);
 /* AMD Iceland dGPU */
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x6900, quirk_amd_harvest_no_ats);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_ATI, 0x6900, quirk_amd_harvest_no_ats);
 /* AMD Navi10 dGPU */
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7310, quirk_amd_harvest_no_ats);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7312, quirk_amd_harvest_no_ats);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7318, quirk_amd_harvest_no_ats);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7319, quirk_amd_harvest_no_ats);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x731a, quirk_amd_harvest_no_ats);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x731b, quirk_amd_harvest_no_ats);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x731e, quirk_amd_harvest_no_ats);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x731f, quirk_amd_harvest_no_ats);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_ATI, 0x7310, quirk_amd_harvest_no_ats);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_ATI, 0x7312, quirk_amd_harvest_no_ats);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_ATI, 0x7318, quirk_amd_harvest_no_ats);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_ATI, 0x7319, quirk_amd_harvest_no_ats);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_ATI, 0x731a, quirk_amd_harvest_no_ats);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_ATI, 0x731b, quirk_amd_harvest_no_ats);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_ATI, 0x731e, quirk_amd_harvest_no_ats);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_ATI, 0x731f, quirk_amd_harvest_no_ats);
 /* AMD Navi14 dGPU */
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7340, quirk_amd_harvest_no_ats);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7341, quirk_amd_harvest_no_ats);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7347, quirk_amd_harvest_no_ats);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x734f, quirk_amd_harvest_no_ats);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_ATI, 0x7340, quirk_amd_harvest_no_ats);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_ATI, 0x7341, quirk_amd_harvest_no_ats);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_ATI, 0x7347, quirk_amd_harvest_no_ats);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_ATI, 0x734f, quirk_amd_harvest_no_ats);
 /* AMD Raven platform iGPU */
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x15d8, quirk_amd_harvest_no_ats);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_ATI, 0x15d8, quirk_amd_harvest_no_ats);
 
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
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1451, quirk_intel_e2000_no_ats);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1452, quirk_intel_e2000_no_ats);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1453, quirk_intel_e2000_no_ats);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1454, quirk_intel_e2000_no_ats);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1455, quirk_intel_e2000_no_ats);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1457, quirk_intel_e2000_no_ats);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1459, quirk_intel_e2000_no_ats);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x145a, quirk_intel_e2000_no_ats);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x145c, quirk_intel_e2000_no_ats);
 #endif /* CONFIG_PCI_ATS */
 
 /* Freescale PCIe doesn't support MSI in RC mode */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 1c270f1d5123..850100f209e3 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -539,6 +539,7 @@ struct pci_dev {
 	};
 	u16		ats_cap;	/* ATS Capability offset */
 	u8		ats_stu;	/* ATS Smallest Translation Unit */
+	unsigned int	no_ats:1;	/* ATS disabled via quirk */
 #endif
 #ifdef CONFIG_PCI_PRI
 	u16		pri_cap;	/* PRI Capability offset */

base-commit: 7df48e36313029e4c0907b2023905dd7213fd678
-- 
2.53.0.1018.g2bb0e51243-goog

