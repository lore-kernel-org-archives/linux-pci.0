Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E3F364926
	for <linux-pci@vger.kernel.org>; Thu, 18 Jun 2026 08:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781770711; cv=none; b=Z7Q5LMWBCOjF7hHdEJywPZ+ArZ9683toA75uBuyqgS6NAZtUT2Oqmd5IjbG28FTGcnPeakrMVtXv0x/lOrGEAG0YA0JVD7f652mxAG53pNkiNcw5hcfZfhzx3pxCnWfO1bFjUr5Uw3MO7YQchKhP9cXdr8KxeORBGuI0xoc6sjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781770711; c=relaxed/simple;
	bh=028gKn9NBs4GgbPMzeH5U/FvrklT7qLa2vR165Dk20Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cQaF55Tec+CSyxyZs5kJvakZ84/RlxUdLHpVSDUD9evi+mluqMitiEsJba32DlMJRhclTyXFs6cRgyrU7iGnl87WvdyiyawG7TvIAKWh5Wr2NecK0PRrNc/m9NfZyag4hHmPn+SefqVjbZTz69b9nhHEo0YqrI4y2+AZrJD0Gtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=jZ8m717q; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="jZ8m717q"
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6EC673FA70
	for <linux-pci@vger.kernel.org>; Thu, 18 Jun 2026 08:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1781770699;
	bh=OI+Z1sUetge0i/R5QCIrytWYaZnruPh/vV+ntCiLEmI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=jZ8m717q3MLmrR6nvLG6wn1nEaw1K4npa1AX6qyVhuQf8k/hzY8C8n6o8NEND7rip
	 1NCyHbtpTiBMYKGF9a68lOsXNOFuXQfc1P/3WXaEGoXUBDun5pwFCI9g8l7zq25V83
	 pdq2xHU7I81fI3hZWbIEtsa1uxrnbCV7Cqtoysqewh0XfbFzuhzOhvVWqJoIzcEuTL
	 1kOJ+Ai1X1bCXToHHHMouWb1uocEcxqYNWZfdIWtbO8Lp7eQbJiwsX28mHQYrdzs0M
	 /NyIRxbnODVw0djI5UIZuWCSBDLnPNNnH3B/Pxb/XbuqbwPEVLdcG5OWKinD5FxDFN
	 neEYQ3kgRAL0LtidhJtTT4jSEcw1wVaMUCVWBrsJYdMeyO+xV4GhJ/2gQUJW3s0/TW
	 9WSkxEcBdxQr95HgnVx3WKN8EJl6SGCwUUq+xKUQW8IL5T80qcSfDLqGevhiWrIpIW
	 wV3zWy4/pC8CqkBK9tjRhfeW+7qenYxYys+85ZvkhtlqlNsMzP01S5aSKtURPef6Ju
	 dcC7pXGiv3j73i3qut1B3F6ZqqMhS0ztob5cpi96IONWCsRvHew5bT2cVlcpBMKFFE
	 f/rzWe54sYS8fIXX1Qtd8tgDQh5dschTWmvB3FqP1zcPew7ujsuYvoznQkcbqIDuAu
	 Rvz1Zc/2PlZnMcHP8L1+rKyM=
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-461a5d02540so509054f8f.3
        for <linux-pci@vger.kernel.org>; Thu, 18 Jun 2026 01:18:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781770699; x=1782375499;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OI+Z1sUetge0i/R5QCIrytWYaZnruPh/vV+ntCiLEmI=;
        b=kYj2801Q2tIGj6VGUmKdLnZe9JEzSw8KHQlDQ42jWyEl+BewJ4+iWt++fiZ89xHLVS
         hbv3hrtw63Hzk6OPd4iybYLOdyyFv+tqqm1q310KqQ74APSdokOQ1SuR/1hDUEVafPIz
         qxlD8KJBfqBzoc43H4Pyc8mfkBOPbChts4Vms3t/Cro1AQIK17cv9EmNbmzXoG+WKUnE
         lHqZosi6KWmTnUb3T9OnsrX7Yv/w2I2xvtfYFnqYLxk1fT7rdVb6b9t4H8a9t+54zurN
         +YcnYFyhBTpajxQXuvc7ZXonPO+EjHzVfbrOT8mb16Zh71mJhwPQbjf7wvF3akilDZGl
         ZaPQ==
X-Forwarded-Encrypted: i=1; AFNElJ8WiEnGhOPnhJFyYOMRukj751MB19YP5/qV3W7OmMeCgDkzCP+xCEjFEsLLLGP9eNv7mPkxEnCOmsk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8bcIdD6gFXp6DRTXS5IjW1xK+Qq8+yJLuou08MiYLh5asDiLC
	E9su9dvG7Fz7DWH2pipYXg8Tv/2U30IMqetTEjEPJHxGU1W0CsRQzlX0KkzBP9z5WWGczvLdOXJ
	iras/35bYGAi0ZrGoLBz3zlQma9KUybf1B7OUAEGeIwEPucdgEse4ZFxnIJ/8pBY/AXcRj8n8cE
	FihA==
X-Gm-Gg: AfdE7clnLi0iSj7+/X2wipVnfOCHx6EkYwCxc4eRpOqD6FlY2Ej0vgpBgC0nNLTxuk4
	A+MEMFwYbBE3s2vRG3MmdkgHo0zDw35Q78Si/WKbw+9LF4IOXdwa8bGpgoOmBDEyfKQW48zmDEA
	+c6R5c/IuClRNt4rJlYzd0N0hLSCm0Dw6UZgaqBgNnrypIthBO0wenNaqgDkgmGR0JUxLFSxj5o
	R1apvsJGAVRD3Yp8YTtmCDuPW3QDq2r6+7qrUWcGXvfHkqEGu569b6720qfDXh15xrNdwKGNVom
	oT6S1FXPGffNFv+d9yJVu5qpWhxy6Go2nGJuJLElor8fjNcSHXjTnWXzy/74G4s/xcxY1vDyh69
	DwcLx9IaFLsythP2KWuKMIAyFPh9Ijc9/qmdQ78xS+2NsfzxJ+0hWFZLeaZ5T1cbBLMoAdEBRlB
	1zv3EAUw9I
X-Received: by 2002:a5d:6d44:0:b0:460:3234:293f with SMTP id ffacd0b85a97d-4623983b959mr10593218f8f.42.1781770698703;
        Thu, 18 Jun 2026 01:18:18 -0700 (PDT)
X-Received: by 2002:a5d:6d44:0:b0:460:3234:293f with SMTP id ffacd0b85a97d-4623983b959mr10593171f8f.42.1781770698207;
        Thu, 18 Jun 2026 01:18:18 -0700 (PDT)
Received: from localhost.localdomain ([103.155.100.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2b0d4fsm66042968f8f.24.2026.06.18.01.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 01:18:17 -0700 (PDT)
From: Aaron Ma <aaron.ma@canonical.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: mario.limonciello@amd.com
Subject: [PATCH] PCI: vgaarb: Include 0x0380 devices in default selection
Date: Thu, 18 Jun 2026 16:18:03 +0800
Message-ID: <20260618081803.2790848-1-aaron.ma@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some firmware boot GPUs report class 0x0380 (PCI_CLASS_DISPLAY_OTHER)
instead of PCI_CLASS_DISPLAY_VGA. vgaarb only registers pci_is_vga()
devices, so those GPUs are not considered by vga_is_firmware_default().

On these systems the AMD GPU matches the EFI framebuffer but is
excluded from vgaarb because it is class 0x0380, while the NVIDIA GPU
does not match the EFI framebuffer but becomes vga_default_device()
through the vgaarb's enabled-device fallback.

Register legacy VGA and 0x0380 devices in vgaarb, and expose boot_vga
for the same set of devices, so the firmware default device can be
selected correctly.

Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
---
 drivers/pci/pci-sysfs.c |  3 ++-
 drivers/pci/vgaarb.c    | 10 +++++-----
 include/linux/pci.h     | 14 ++++++++++++++
 3 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index d37860841260c..843d83ec9550a 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1717,7 +1717,8 @@ static umode_t pci_dev_attrs_are_visible(struct kobject *kobj,
 	struct device *dev = kobj_to_dev(kobj);
 	struct pci_dev *pdev = to_pci_dev(dev);
 
-	if (a == &dev_attr_boot_vga.attr && pci_is_vga(pdev))
+	if (a == &dev_attr_boot_vga.attr &&
+	    pci_is_vga_or_other_display(pdev))
 		return a->mode;
 
 	if (a == &dev_attr_serial_number.attr && pci_get_dsn(pdev))
diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
index c360eee11dd9e..0e0878189e3d8 100644
--- a/drivers/pci/vgaarb.c
+++ b/drivers/pci/vgaarb.c
@@ -796,7 +796,7 @@ static bool vga_arbiter_add_pci_device(struct pci_dev *pdev)
 	}
 
 	if (vga_is_boot_device(vgadev)) {
-		vgaarb_info(&pdev->dev, "setting as boot VGA device%s\n",
+		vgaarb_info(&pdev->dev, "setting as boot display device%s\n",
 			    vga_default_device() ?
 			    " (overriding previous)" : "");
 		vga_set_default_device(pdev);
@@ -1483,8 +1483,8 @@ static int pci_notify(struct notifier_block *nb, unsigned long action,
 
 	vgaarb_dbg(dev, "%s\n", __func__);
 
-	/* Only deal with VGA class devices */
-	if (!pci_is_vga(pdev))
+	/* Only deal with legacy VGA and other display controller devices */
+	if (!pci_is_vga_or_other_display(pdev))
 		return 0;
 
 	/*
@@ -1530,12 +1530,12 @@ static int __init vga_arb_device_init(void)
 
 	bus_register_notifier(&pci_bus_type, &pci_notifier);
 
-	/* Add all VGA class PCI devices by default */
+	/* Add legacy VGA and other display controller PCI devices by default */
 	pdev = NULL;
 	while ((pdev =
 		pci_get_subsys(PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
 			       PCI_ANY_ID, pdev)) != NULL) {
-		if (pci_is_vga(pdev))
+		if (pci_is_vga_or_other_display(pdev))
 			vga_arbiter_add_pci_device(pdev);
 	}
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 2c4454583c115..195ec1bdac863 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -792,6 +792,20 @@ static inline bool pci_is_vga(struct pci_dev *pdev)
 	return false;
 }
 
+/**
+ * pci_is_vga_or_other_display - check if the PCI device is VGA or 0x0380
+ * @pdev: PCI device
+ *
+ * Return true for legacy VGA-compatible devices and for "other display
+ * controller" devices.  Some firmware-selected boot display devices expose
+ * class 0x0380 instead of PCI_CLASS_DISPLAY_VGA.
+ */
+static inline bool pci_is_vga_or_other_display(struct pci_dev *pdev)
+{
+	return pci_is_vga(pdev) ||
+		(pdev->class >> 8) == PCI_CLASS_DISPLAY_OTHER;
+}
+
 /**
  * pci_is_display - check if the PCI device is a display controller
  * @pdev: PCI device
-- 
2.43.0

