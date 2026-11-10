Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794270837;
	b=T8il+aEz+ExG7GuYQVG52+zawRbQTmP4gDj4rZb6J1MYMqi3e1xVHVIPhGkz285U6B3u
	 ygTXbeVuF9pifc2dDd1XqBK+og7usSOM4UrD6Tf1EaW7BSLoj5PqQrLWCX4dcIc67Mx/i
	 uEgnjYOy42UPg7rDQpVd3EMEpoX6OMWKR5qXgDTeUYh9qtqGWe2cFQS9fcHw9rYDTP0DE
	 yjAd8zwlEVX/RIudgTrB21BvMOmpPVu8za8Q1hHldgJ6Eb2RRLdrPCkbZrvXLJzTcdWms
	 dV2w0chTfYD/fZ9TCYN1bi9Pqh83AVmCwwefai3ib/HGYsPb5A/EXGxlP1wCs34h+9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794270837;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=dp/SivdZSMdHaGB18E3d/UpPfEwdEk+NeiPPW1rS6/U=;
	b=YS/4uNi0666SimumUOD5CMLh8o9W0o6Lan2ZVvE5mGAiE2TWxDy12GDBeAzxX1Gg1fkE
	 MJ3vBlOy/+bldGitUUhjL0RzL94LqGeVrsYI1TXZPxD9HbYUDQxB5W0LmpeINl4EkJCcj
	 cozrk1MQDJEhGnig9bttU7zDzLYk6HtWTK2AhhzzdUo/7skMkx4CNqjS9Dn3UHWtjsRZo
	 Cc98S+rR5pnzr9BjjJTYBtRS9PZhDP2gwv1W8xWt33pQv3VzzHB2qqq+fvJxrPFPXm+/D
	 baQNUe90bloCIkmBj14/H1e1uY5LDUtSKbWIYCO87OG2zQTghzXKwWVusFsbJb+UqAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="gj4kDU/w";
	arc=none smtp.remote-ip=209.85.160.70
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F385E606A321
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 00:33:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F385E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gj4kDU/w
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-47d75bcf3ebso1464670fac.0
        for <linux-pci@vger.kernel.org>; Mon, 09 Nov 2026 16:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794270836; x=1794875636; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dp/SivdZSMdHaGB18E3d/UpPfEwdEk+NeiPPW1rS6/U=;
        b=gj4kDU/wkQUJ8LZC/AKb18sO4i5uA/HHxRQNddoct+D3hyM/H7gC0xNNoKYOY3QkZi
         XLfeguuHDbF2qUnBTBFdDJY2JY26dYWR/VaJWMmHQ/tEDH47F5R6roNwwZWf13Hwq6QM
         0bmYWiwnS5F3PE+pAABDwdElwtMEwHaBCzbQgZxthPRooyiXbd5I+rOnwoBi7Oowy1MR
         zcy0JYs7ouyLuNS+gEOgsKZhblr15I5J6egEowj+GgRTB6rHYOIxs0MfyuPiJfazp0Zy
         rgfFNJ4BWBXRb8U1BB6ax0w5RlX87Qs4bEEWTZ1AqYw7lqdm/CSN1PHL8n/iYanL/JdC
         HQ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794270836; x=1794875636;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dp/SivdZSMdHaGB18E3d/UpPfEwdEk+NeiPPW1rS6/U=;
        b=IOWw3Whx5hyilkvLtmrZuFzLLmo5/CItvqE9QhOViNqPmFnBCYN9PSashw0yRhSp9S
         EwnoZ6KSJNXKwl3M5Ax6H1fdJRiSXIbrsNISWnExPMWH5zz8vrRoECLVSnJpsMvIS9i+
         tG4mRqse85YJyekmyySLz5vTBMQHUTZHFSqBhiAhI9X9FyoY84XXG7kkRAtT4bllGj93
         UlojMyADAePKG9RdNxrwAE7Iy+fVMaWPBMsHsQz+cvMKJaD3A+UhBCmJcj8UQpB15AMo
         M7/xOIfDC6OQhiet5kSVP+6YvBE/heLPLF1QL8+8cuW1vPoNTw9shhCJ/imt6aiOa81Q
         X5Nw==
X-Forwarded-Encrypted: i=1; AL+hErFEedE8buY4fcFFkqMUYTeEvmJMTTIEImjsQ4ECTzL8Egx8AzKX6+OWM/Va0kAkKMOXU1AKQl360kw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Y4LtkOH8H6H2ge5HU4Qy/GsRyuq0yerY30VYtS7c/pWbwnBdb
	9nRBDpscbrgZHdQi7zO+v7okXoXu7r2Rt/idMrVfozNqxSOJUL7ACudoTeRAhpdFEyrX3Wa6GS1
	h5v11uv5Y51k5CQ==
X-Received: from ilei3-n1.prod.google.com ([2002:a05:6e02:61c3:10b0:53c:124b:c693])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:4f10:b0:4cb:818f:d573 with SMTP id 5614622812f47-5683c9beb98mr967085b6e.27.1794270835400;
 Mon, 09 Nov 2026 16:33:55 -0800 (PST)
Date: Tue, 10 Nov 2026 00:33:53 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
Message-ID: <20261110003353.1824793-1-dmatlack@google.com>
Subject: [PATCH v5] PCI: Ensure ATS disabled via quirk before notifying IOMMU drivers
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

Apply the quirks that disable ATS before IOMMU drivers are notified
about the device. Convert the quirks from final to header fixups and
have them set a new no_ats bit in struct pci_dev, which keeps
pci_ats_init() from setting pci_dev.ats_cap.

Header fixups run in pci_device_add() before pci_init_capabilities()
initializes ATS and before device_add() notifies IOMMU drivers. Final
fixups run later, in pci_bus_add_device(). Use header fixups instead of
early fixups because quirk_amd_harvest_no_ats() needs subsystem_vendor
and subsystem_device, which are not yet set during early fixups.

This ensures that pci_ats_supported() returns the same value in
iommu_ops.probe_device() and iommu_ops.release_device(). Since commit
89436f4f5412 ("iommu/vt-d: Fix WARN_ON in iommu probe path"), the Intel
IOMMU driver relies on this to decide whether to add a device to, and
remove it from, iommu->device_rbtree. With final fixups,
pci_ats_supported() returns true at probe but false at release, so the
device is never removed from the rbtree, leading to a later
use-after-free.

This only affects PCI devices added after IOMMU bus notifiers are set
up, e.g. hot-plugged devices and VFs.

Fixes: a18615b1cfc0 ("PCI: Disable ATS for specific Intel IPU E2000 devices")
Fixes: 9b44b0b09dec ("PCI: Mark AMD Stoney GPU ATS as broken")
Fixes: 3f1271b54edc ("PCI: Mark all AMD Navi10 and Navi14 GPU ATS as broken")
Closes: https://lore.kernel.org/linux-iommu/aYUQ_HkDJU9kjsUl@google.com/
Signed-off-by: David Matlack <dmatlack@google.com>
Tested-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
---
v5:
 - Rebase onto v7.4-rc2
 - Add Lu Baolu's Reviewed-by tag
 - Reword commit message to explain fixup ordering and fix typos

v4: https://lore.kernel.org/linux-pci/20260817202823.2172548-1-dmatlack@google.com/
v3: https://lore.kernel.org/linux-pci/20260403222750.1215002-1-dmatlack@google.com/
v2: https://lore.kernel.org/linux-pci/20260327211649.3816010-1-dmatlack@google.com/
v1: https://lore.kernel.org/linux-pci/20260223184017.688212-1-dmatlack@google.com/



 drivers/pci/ats.c    |  2 +-
 drivers/pci/quirks.c | 50 ++++++++++++++++++++++----------------------
 include/linux/pci.h  |  1 +
 3 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 9cb23780093d..af0257790016 100644
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
index 7f1f47ea2ee4..c7ac2eda9e19 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5816,7 +5816,7 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0422, quirk_no_ext_tags);
 static void quirk_no_ats(struct pci_dev *pdev)
 {
 	pci_info(pdev, "disabling ATS\n");
-	pdev->ats_cap = 0;
+	pdev->no_ats = 1;
 }
 
 /*
@@ -5839,25 +5839,25 @@ static void quirk_amd_harvest_no_ats(struct pci_dev *pdev)
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
@@ -5868,15 +5868,15 @@ static void quirk_intel_e2000_no_ats(struct pci_dev *pdev)
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
index aa3765a20a96..f125dac17757 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -551,6 +551,7 @@ struct pci_dev {
 	};
 	u16		ats_cap;	/* ATS Capability offset */
 	u8		ats_stu;	/* ATS Smallest Translation Unit */
+	u8		no_ats:1;	/* ATS disabled via quirk */
 #endif
 #ifdef CONFIG_PCI_PRI
 	u16		pri_cap;	/* PRI Capability offset */

base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
-- 
2.56.0.506.g506a7eabc5-goog

