Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A3635C1A1
	for <linux-pci@vger.kernel.org>; Mon, 22 Jun 2026 06:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782108844; cv=none; b=hS/DztL9t2Q6tKDuc3NX2k4KMRxg15An47rq5LCsyeqbDi316ZhZs0WfBD0bwwrG1jstxdzSs350jpeYrYBpFlu3N8tMGkoju3nencU1wqAZVlDjnJrnWwtJLq0w8LH96DnKuaX0eO3a9VNUUf/q/lqtkrhYWpH750pTW0xgrA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782108844; c=relaxed/simple;
	bh=DACF+/kCI3HYV6NUW6AC4u5ZD3MsUz9SlCQaQKrz6U0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IzHC9gu9n0C+LlUyNNE5VauoWnEWkb2lG+DOg59JIoBbIMa+z8UBcAFPI+vJvWLa4M1+P9TtXIvNIDTShlA63s0oQtpPPGwI1c5xcQbetdo6Ylesa60SBW97kGaFCu7BsEFUOUSYdYuvF0vMg5yrLNsfszPgkdtn2jOR2SmZc0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=NEAMro+0; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="NEAMro+0"
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 54DAF3F1B9
	for <linux-pci@vger.kernel.org>; Mon, 22 Jun 2026 06:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1782108841;
	bh=B94a++msrIAkNJ9KWAX6eOvEE0q8EqUDuyuG7fQs0gQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=NEAMro+0F7Yvj1PmDtj/mXjHn7+QL8Ml9hNbLKwnH9UUtFU4/YufnQh8kV91S8pxA
	 DJMP5ypfqcWZH+7bKGAvULRK5kfzuBPKJTIJwS/hu5pbmMoPmAbMR2zK1HvZsYiY0t
	 7vf45aJ26oGAMNGtrmy8//vhTu6WQ0MHAjpejY/tXD6UqzBNWshAoaMfCI1M1veRut
	 9rXzGLS72qmEd1GmW8bz9MXLw1WEY3pOe27JCirfxZQK+0hUFkO33ejYv8xW4ZA3jO
	 zWds2EElascPUrh3z9IqbpkIWcmPVsay1J1adt52GQ7g9lTBjDyVZzYS0uVt2V2Jsm
	 zPB6pQkZtHAVWMqMAfPUdo8g8HBMO5XGHoaywe7PUe1d9c7pXi/gkUo4gugopkMbvJ
	 H1aer5GZX3ABwWljX6kHV8CcCt89U8DghVX0nJNq209Xv9NwsB0cc6FS+EzMW60tHX
	 SUBXqymsj7Ft/GWM/ACqdyxR81kq0otIZUHidYD6d+Q2U34gBnyky6w2HdZbKob1qU
	 9zCgQEKwREtdwzw8tX8nE4WbMaiD5Dzy06rs1tJcBsTaw7nn5opOjG/LjB70wfkp5G
	 9PQrTBoYn+bxhAkVllaMhbH2BMUdQd5ChIZ29zRLk1jrng3EmEP/Jpw8JAJqW43V61
	 Y66H+oFR6ZFiuRz/Yk4sDHNE=
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2c725d3e886so49907845ad.0
        for <linux-pci@vger.kernel.org>; Sun, 21 Jun 2026 23:14:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782108840; x=1782713640;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B94a++msrIAkNJ9KWAX6eOvEE0q8EqUDuyuG7fQs0gQ=;
        b=QWPgrHCz1NcOKXuywU7kF5VnS9WWqmgn1A+bZlQHR0ntazagnJWfsgG1xkQ/aTYEoO
         mIsFI9QkCcI+mY/oIBMswa78p/flwME1L2M0eAU4b59r7iE4PUZV5XclSOaU60nxzIy2
         OWGbLdbJpvaACVcFIug9ZPHxglOS/XeNXVl2drRmrLjmi2nNLEQY0DrKXII/VjthBS1G
         m5IpYWtVJfRyVoEvdjOQAZiHHBO+BapUocLbijzMkuYjOseN1TcqqT+fa8uILqlAI0Eq
         JdGZ1lrGTXhwf/b88Us8oBOYquZUxVP28YPW209MI1CE4R1scXagymCSQC4jBV5BuqJu
         ATGg==
X-Forwarded-Encrypted: i=1; AHgh+RoXro5RUR9YLxzu18o2gLvoE+rQnSpldwmUWgE9dzAv0+sd987MHpzjRTfI3zaqeG0FPXS6ODatFAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlCXpvsqMCfcWcLaB60lBI4Lg0uwNsC2B3OcOC/0YXpHIrCAph
	0UP/j5f/xURNgZG0Wn9pH8xRpl5xl7nXrbsRRlPkMb49Ls8SupAB1CEFINhjFdh00NPP++4W0zP
	5f0RD/r8btOXtBxTznVGKdbm1DkmqNfBK4Jh5eCmXmx08lpuC+8fqRL2WEPZMl9PmxfuvoDmryA
	eECw==
X-Gm-Gg: AfdE7cn00QlCX3P50pQH22gwJsX9SM758St//WNqT8bMxBQDSvH6pHWKVgaBZD/hlNh
	ifJ3iDv3gsAxUwP/lcP2oc2GLGn2xMMtAKQ6AvYLmLKBujZL4IZmTjBqA2iUp0mBs5vGGjjZqaR
	ms13mF9HkmaBdiP2GHIpf/b8xBPc0QS04Jxiw0qMz79SKyNFparLes+O0g2t9xPnQezEYqtMGbV
	F1OYcef16VKGJHswJ8Vm616nCqhQJ2frBu4Prs0oK8PeI8gqieXttzzLjATKquICTDj5vQH+LDE
	04zGOFbEHvUJhtR9rVbbT3QMiM2xbxT/Xv641qGpZcxu6jC8unEUTHeN8jFIX2YQAK9s8Hi1K8q
	vmOxOHHv6KrbWODNWS0s0JtSU4Ys9egOBXpufX3TL0sn//0hS23Ll6uerJBegnEcTsZdg9AMLXG
	FATIwQMHc=
X-Received: by 2002:a17:902:ce11:b0:2c6:dde5:45c1 with SMTP id d9443c01a7336-2c718f76f6dmr155715905ad.37.1782108839957;
        Sun, 21 Jun 2026 23:13:59 -0700 (PDT)
X-Received: by 2002:a17:902:ce11:b0:2c6:dde5:45c1 with SMTP id d9443c01a7336-2c718f76f6dmr155715765ad.37.1782108839603;
        Sun, 21 Jun 2026 23:13:59 -0700 (PDT)
Received: from localhost.localdomain ([103.155.100.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7436af590sm77396025ad.17.2026.06.21.23.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 23:13:59 -0700 (PDT)
From: Aaron Ma <aaron.ma@canonical.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: mario.limonciello@amd.com
Subject: [PATCH v2] PCI: vgaarb: Include 0x0380 devices in boot VGA selection
Date: Mon, 22 Jun 2026 14:13:39 +0800
Message-ID: <20260622061339.3306046-1-aaron.ma@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some firmware boot displays use PCI class 0x0380
(PCI_CLASS_DISPLAY_OTHER). vgaarb only registers pci_is_vga()
devices, so those devices are skipped by vga_is_firmware_default()
and cannot become vga_default_device().

On hybrid systems this can leave a discrete VGA GPU as
vga_default_device() even when the firmware framebuffer is on the
0x0380 device. That makes boot_vga point at the wrong GPU and can
make boot_display report multiple devices through different paths.

Register legacy VGA and 0x0380 display devices for default selection
and boot_vga visibility. Keep legacy VGA decode ownership limited to
pci_is_vga() devices so 0x0380 devices are not treated as legacy VGA
decoders.

Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
---
Changes in v2:
- Keep legacy VGA decodes and owns limited to pci_is_vga() devices.
- Keep 0x0380 devices eligible for firmware/default selection and
  boot_vga visibility without treating them as legacy VGA decoders.
- Update the commit message to describe the boot_vga compatibility goal.

 drivers/pci/pci-sysfs.c |  3 ++-
 drivers/pci/vgaarb.c    | 27 +++++++++++++++------------
 include/linux/pci.h     | 14 ++++++++++++++
 3 files changed, 31 insertions(+), 13 deletions(-)

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
index c360eee11dd9e..56a86779e6d28 100644
--- a/drivers/pci/vgaarb.c
+++ b/drivers/pci/vgaarb.c
@@ -741,6 +741,7 @@ static bool vga_arbiter_add_pci_device(struct pci_dev *pdev)
 	unsigned long flags;
 	struct pci_bus *bus;
 	struct pci_dev *bridge;
+	bool legacy_vga = pci_is_vga(pdev);
 	u16 cmd;
 
 	/* Allocate structure */
@@ -762,21 +763,23 @@ static bool vga_arbiter_add_pci_device(struct pci_dev *pdev)
 	}
 	vgadev->pdev = pdev;
 
-	/* By default, assume we decode everything */
-	vgadev->decodes = VGA_RSRC_LEGACY_IO | VGA_RSRC_LEGACY_MEM |
-			  VGA_RSRC_NORMAL_IO | VGA_RSRC_NORMAL_MEM;
+	/* By default, assume VGA devices decode everything */
+	vgadev->decodes = VGA_RSRC_NORMAL_IO | VGA_RSRC_NORMAL_MEM;
+	if (legacy_vga)
+		vgadev->decodes |= VGA_RSRC_LEGACY_IO | VGA_RSRC_LEGACY_MEM;
 
-	/* By default, mark it as decoding */
-	vga_decode_count++;
+	/* By default, mark legacy VGA devices as decoding */
+	if (vgadev->decodes & VGA_RSRC_LEGACY_MASK)
+		vga_decode_count++;
 
 	/*
 	 * Mark that we "own" resources based on our enables, we will
 	 * clear that below if the bridge isn't forwarding.
 	 */
 	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
-	if (cmd & PCI_COMMAND_IO)
+	if (legacy_vga && (cmd & PCI_COMMAND_IO))
 		vgadev->owns |= VGA_RSRC_LEGACY_IO;
-	if (cmd & PCI_COMMAND_MEMORY)
+	if (legacy_vga && (cmd & PCI_COMMAND_MEMORY))
 		vgadev->owns |= VGA_RSRC_LEGACY_MEM;
 
 	/* Check if VGA cycles can get down to us */
@@ -796,7 +799,7 @@ static bool vga_arbiter_add_pci_device(struct pci_dev *pdev)
 	}
 
 	if (vga_is_boot_device(vgadev)) {
-		vgaarb_info(&pdev->dev, "setting as boot VGA device%s\n",
+		vgaarb_info(&pdev->dev, "setting as boot display device%s\n",
 			    vga_default_device() ?
 			    " (overriding previous)" : "");
 		vga_set_default_device(pdev);
@@ -1483,8 +1486,8 @@ static int pci_notify(struct notifier_block *nb, unsigned long action,
 
 	vgaarb_dbg(dev, "%s\n", __func__);
 
-	/* Only deal with VGA class devices */
-	if (!pci_is_vga(pdev))
+	/* Only deal with legacy VGA and other display controller devices */
+	if (!pci_is_vga_or_other_display(pdev))
 		return 0;
 
 	/*
@@ -1530,12 +1533,12 @@ static int __init vga_arb_device_init(void)
 
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
