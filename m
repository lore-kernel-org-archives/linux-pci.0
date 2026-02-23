Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C403E30DEB2
	for <linux-pci@vger.kernel.org>; Mon, 23 Feb 2026 18:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771872026; cv=none; b=Hov0Z/AiweeMWwo+8pdX3tW2TD8/GYMkNeGU4Zv0JUGgWAD9NUGo5xvkccfxaI/O6iPUWjSCpsSVHzUVgRxi8k94Km5SxaGz16ScfXSNS1ZUGmHDeI2fXqAu24flfiJn4h4Pi/91L9POqu3hPA6K2AsYOc6yz0gKDlablKnws04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771872026; c=relaxed/simple;
	bh=PEW60uE6mf0oWwEUpjKiIai0CeHDPntrzOKJY99hrv4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kWS+C4dYo1JPOo8bmzIS2Rme9+RAnTbrYZ2Nz+mO+F4p6Vif8NvE7FPH5TDe9/LY4jya0GP5+QeJaukKWpmJcnKp7cHht0WctrwY8cCKr7mJqomJ36cGB7ChE/xOKd46bMsnDdEo0pyw10TMI6J9LOuoIA1b7/nJXljRAwCm+ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rmVWSese; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rmVWSese"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2a75ed2f89dso43743185ad.1
        for <linux-pci@vger.kernel.org>; Mon, 23 Feb 2026 10:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771872024; x=1772476824; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hr64EFuXq0VWSV0H6j2gO6901ICKZlFpt5P+iy1UzFE=;
        b=rmVWSeseJAHTvUi3Wp7cohmiaQ4y+9oHiqfoDILA6RtyLUgYYX1p6qYxWJJNivfJ3y
         EnXCdsIHGDhoRT6ABcGC1Fc9t9/UCaW52EBV1JMShMZ6M6P7hyIZrMa8j+G/ZJyoULmJ
         Wv3kbHWChjR68jkGmdeQLs7XoXOizOdOo6IeBjCcF9jl+UmED1cd/6J8REVe2UW6ZbxI
         dC+G9ooKz2HXBTI+MUkfqnsV8cyYs1lYq9bn6AbAQZJeXQiXSkDqayGZ8t0oSpgV3Emf
         wAWSYRNjL6hmQ9EkfCoZqmvP3sXnTe5ZBLuUAr4NWBTdAIBg2sH8WKvVvq4Tfh3Bp1DZ
         6MXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771872024; x=1772476824;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hr64EFuXq0VWSV0H6j2gO6901ICKZlFpt5P+iy1UzFE=;
        b=r4wasut7FkClTeMegdEy/e0p1g26apb6dzxEdgFf1GivWFZVVz8fwlRRCeGmItCOTU
         GyoS96faV/P+9WxLiCyGg9Z8TuqisCjhcxCcq2MpfuebmfrJes2aDhWhGvjLG7j8PhxM
         J1GBqRcjL3IVpHitw5Qyf0Sjd3QIJ7gDA+huD7p+qVRFDmcniL8M+JQjOPv7kDLUUrOP
         H1XWUXXlJn0zNqWtqmnsi8l6KbAcTQbIS+pJIJHsZzSSMfDHTLsDXtS18U4Iqua6mxGt
         2yxcpJSYFhnIj5uVJSetviyS8EBF38gUNbNykaKCh9J3u0VH2YuH3eDWTz+A+MSNOMNx
         xgxA==
X-Forwarded-Encrypted: i=1; AJvYcCX1d/Z8iRexgTyFvIISu46hU3yJM2QBtTm5gxWJs1eqbECuFSzFK3siihABa9LAS9hpiCWhUBzmn+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1cqgjA9pgHVx3tIj64OAxSni4pdln4ZLrN7yGo/LLM5uNVv8Y
	tkNNQAjKnKaOCxqfP9tDoub5iEAoyJYIcMmGGMgwHiJGNv/BIBv+Fay2dnLeiDBDui1VIknpju7
	JXpZpZK7UyBaOTA==
X-Received: from pllx13.prod.google.com ([2002:a17:902:7c0d:b0:2a9:5b1d:9c8a])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d4d2:b0:2aa:d287:6949 with SMTP id d9443c01a7336-2ad74457070mr85524915ad.5.1771872023851;
 Mon, 23 Feb 2026 10:40:23 -0800 (PST)
Date: Mon, 23 Feb 2026 18:40:16 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.371.g1d285c8824-goog
Message-ID: <20260223184017.688212-1-dmatlack@google.com>
Subject: [PATCH] PCI: Disable ATS via quirk before notifying IOMMU drivers
From: David Matlack <dmatlack@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Bartosz Pawlowski <bartosz.pawlowski@intel.com>, David Woodhouse <dwmw2@infradead.org>, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	Lu Baolu <baolu.lu@linux.intel.com>, Raghavendra Rao Ananta <rananta@google.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Ensure that PCI devices that have ATS disabled via quirk have it
disabled before IOMMU drivers are notified about the device. Otherwise
the IOMMU driver will see that the device has ATS enabled during probing
and then later it will get disabled.

This fixes at least one bug in the Intel IOMMU driver where it adds the
device to an rbtree because it sees ATS is enabled, but then ATS gets
disabled via quirk. When the device is destroyed (e.g. hot-unplug, VF
destruction, etc.) the driver sees that ATS is disabled and does not
remove it from the rbtree. This inevitably leads to a use-after-free
and corruption of the rbtree.

Fix this by disabling ATS via quirk during "early" fixups instead of
"final" fixups.

Fixes: a18615b1cfc0 ("PCI: Disable ATS for specific Intel IPU E2000 devices")
Closes: https://lore.kernel.org/linux-iommu/aYUQ_HkDJU9kjsUl@google.com/
Cc: Raghavendra Rao Ananta <rananta@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/ats.c    |  3 +++
 drivers/pci/quirks.c | 50 ++++++++++++++++++++++----------------------
 include/linux/pci.h  |  1 +
 3 files changed, 29 insertions(+), 25 deletions(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index ec6c8dbdc5e9..85306198c232 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -24,6 +24,9 @@ void pci_ats_init(struct pci_dev *dev)
 	if (pci_ats_disabled())
 		return;
 
+	if (dev->no_ats)
+		return;
+
 	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ATS);
 	if (!pos)
 		return;
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
index 1c270f1d5123..5880942bba65 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -537,6 +537,7 @@ struct pci_dev {
 		struct pci_sriov	*sriov;		/* PF: SR-IOV info */
 		struct pci_dev		*physfn;	/* VF: related PF */
 	};
+	unsigned int	no_ats:1;	/* ATS disabled via quirk */
 	u16		ats_cap;	/* ATS Capability offset */
 	u8		ats_stu;	/* ATS Smallest Translation Unit */
 #endif

base-commit: a95f71ad3e2e224277508e006580c333d0a5fe36
-- 
2.53.0.371.g1d285c8824-goog

