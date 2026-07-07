Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49A43D648A
	for <linux-pci@vger.kernel.org>; Tue,  7 Jul 2026 22:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783462692; cv=none; b=qA4gMxozuuAh3YJghsNx9pr2OFDi5NCADjynyfF4yarkPLO5ndsy0/sxh/Wuwy+R5ihNd5NzxhoAQ1JbhiNOO8YN6MudX5onReamfHsJfpj6a033AGTIcMaV+d/3XZf8ZnZ/t6i1VZwEuZcndrI5Pe+bHGL59r7z+cAyHeoAGuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783462692; c=relaxed/simple;
	bh=hyeXi4L6bn3G1jOEUH1PSahW2BC/CLM5zLNF0O2Z3UU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=spdfk1UaD+kLylBLecRhxYztf/zwCdK4sYrqm883qd9y/a8do11FFbfVjdGGP+h7LTBYAS60raE8kmeykMrxunVL+/w7vXbcDNo1sE83Z+B2jcsN4F5ivk/lIRvh+/bH7hnw5LTZ++IIGL+RnIuXv6dPm5d+jhO/Yza9vi9CTu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q3J5vrFe; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q3J5vrFe"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8482074a000so19415b3a.0
        for <linux-pci@vger.kernel.org>; Tue, 07 Jul 2026 15:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783462687; x=1784067487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M9X59wJNQ3y51boKONUiZu1rHneZgmoOh0cEmCo9Brg=;
        b=Q3J5vrFeJxJWO84D+NROQbAVcwb5bzXLploZw8wGHz/oXrA+m1jmm3isNEDkKAaTDz
         SXgjkm9X5XQnVBnFpFk1n2SSieCiAz+WEqwQcp7W3WEH9ESt5VYLPKZn1i2J8aisyKMc
         TmWZOi3GLqxaarCCYkQOiKcdmkZW+SVSk32fJKe4TkGDzk9Zlwm3vH5tFqro+aQXOVJR
         7QaweCgylG1mvthMc45ofXl7jt74ZK/s8W2P2gzQBX67jSPcwTiRxtwEs2mlVwwEr/af
         F5Qkt/+bYdMhtpF55d9uQuzCXx+V2SrV1qCJxyY+2hOVq951es14JtnANfmOWrpfoIwU
         /AFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783462687; x=1784067487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=M9X59wJNQ3y51boKONUiZu1rHneZgmoOh0cEmCo9Brg=;
        b=O2zh2dU7PxsJj6iJ/kG5rJHNJDb5Z1MCrEIstOeYDEMHAiA3NGjubTPaAQETzJDPgl
         BxeaYlmHjmiF9pAKFfMKz+1jRfFsGFT+uTgxtmfkn7pQmW5VeGkaiz38wLQTm5gor336
         QklGiE6Nvp3OFUBe3VHULVgGCbtyndunFI6fcziFKA2A2VsO1Rv526N9d572N8GwHoJ3
         WHAfV2eDrutnk799k86YIds9Q+3TiT7GIpy/BHfbAT9ZBjaD+HEbG1DaavMvHus3jJW7
         M7YiGSTbMtGFWABUEDHrGSIRIi4sj63Ybv3UrcSuWR3gdv2qnbnjmISNHsOkzxEIarop
         CmXw==
X-Gm-Message-State: AOJu0Yyfza049Rk85fMaH8kyOkq7RgM4C79TmYKBerK2/9yHMFNat4TC
	ySQp8R1JUDHR/Aai5q5WPQHG7Cj1h0KrjIa8410fXkygV1Eejj7sJ9ZmnJx+wRca
X-Gm-Gg: AfdE7cmRn+m1GocGHNIdAbkq2VOKX10RTk7gwSfokd7juMLVXVCIrt8WY2xiH49X9vo
	eaLM6eCJOiH1l2etOggBh0FKMud+bFT4rCuANrL4NOzXcxq2s8UpZmGUiJk5xS4iH2AFKAqQSrL
	6503m8XuKT2Jcbfh7T8W48ALSG58oFcns8S7XfoClGdq8XbMy5/hjjTyjl5Zyn6lvuJIwHS1QjI
	BgPw3eyiQk9AghcS6o6n42vSAD2/ckaAzM/l5sYHwS9J4Qo2f6AlRfrZieT+7Xv+kYGzfJIHedj
	LYeOnLLutMUoYTVzhcXOxuf5mxQRb5im7apmzE9vtcEZwZIVQyhjJXjVdAuDwm1BEcoiL+SojXx
	ERmNqujzqMhpfIKAahSCLTXbGd5Rd6Q+eAmut3SwrJiGbk72lLx9DXR+aaidkuLhs+wdFsItBMv
	3GDA9ZWdPmmILF6oX6W9u4QxirHU5yowGReYHlvyuVHi5E/gOX4Elm4e+JBAYFP82x1dZFNaqqA
	9dGt7rwEg==
X-Received: by 2002:a05:6a00:4c14:b0:847:1013:f8e0 with SMTP id d2e1a72fcca58-84842fe9a21mr28099b3a.7.1783462686743;
        Tue, 07 Jul 2026 15:18:06 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6b9b389sm6180281b3a.13.2026.07.07.15.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 15:18:06 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT))
Subject: [PATCH 3/8] x86/pci: move VIA chipset quirks to arch/x86/pci/fixup.c
Date: Tue,  7 Jul 2026 15:17:55 -0700
Message-ID: <20260707221800.920270-4-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260707221800.920270-1-rosenp@gmail.com>
References: <20260707221800.920270-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move VIA-specific PCI quirk handlers from drivers/pci/quirks.c to
arch/x86/pci/fixup.c. The affected categories and functions:

- PCI latency fix for KT133 (quirk_vialatency)
- ETBF for VP3 (quirk_viaetbf)
- VIA VT82C576 VSFX fix (quirk_vsfx)
- VT82C586/686/8235 ACPI IO region decode (quirk_vt82c586_acpi,
  quirk_vt82c686_acpi, quirk_vt8235_acpi)
- ACPI SCI IRQ fixup (quirk_via_acpi)
- VLink bridge detection and IRQ routing (quirk_via_bridge,
  quirk_via_vlink, via_vlink_dev_lo, via_vlink_dev_hi)
- VT82C598 device ID correction (quirk_vt82c598_id)
- ASUS A8V onboard AC97/MC97 enable (asus_hides_ac97_lpc)
- CX700 PCI parking/caching workaround (quirk_via_cx700_pci_parking_caching)

The via_vlink_dev_lo/hi global variables move with the VLink code since
they are only referenced by quirk_via_bridge and quirk_via_vlink.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 arch/x86/pci/fixup.c | 333 +++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/quirks.c | 333 -------------------------------------------
 2 files changed, 333 insertions(+), 333 deletions(-)

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index 034c29123e45..81f9cd5d9885 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -1658,3 +1658,336 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1533, rom_bar_overlap_defect);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1536, rom_bar_overlap_defect);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1537, rom_bar_overlap_defect);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1538, rom_bar_overlap_defect);
+
+/*
+ * VIA Apollo KT133 needs PCI latency patch
+ * Made according to a Windows driver-based patch by George E. Breese;
+ * see PCI Latency Adjust on http://www.viahardware.com/download/viatweak.shtm
+ * Also see http://www.au-ja.org/review-kt133a-1-en.phtml for the info on
+ * which Mr Breese based his work.
+ *
+ * Updated based on further information from the site and also on
+ * information provided by VIA
+ */
+static void quirk_vialatency(struct pci_dev *dev)
+{
+	struct pci_dev *p;
+	u8 busarb;
+
+	/*
+	 * Ok, we have a potential problem chipset here. Now see if we have
+	 * a buggy southbridge.
+	 */
+	p = pci_get_device(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686, NULL);
+	if (p != NULL) {
+
+		/*
+		 * 0x40 - 0x4f == 686B, 0x10 - 0x2f == 686A;
+		 * thanks Dan Hollis.
+		 * Check for buggy part revisions
+		 */
+		if (p->revision < 0x40 || p->revision > 0x42)
+			goto exit;
+	} else {
+		p = pci_get_device(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8231, NULL);
+		if (p == NULL)	/* No problem parts */
+			goto exit;
+
+		/* Check for buggy part revisions */
+		if (p->revision < 0x10 || p->revision > 0x12)
+			goto exit;
+	}
+
+	/*
+	 * Ok we have the problem. Now set the PCI master grant to occur
+	 * every master grant. The apparent bug is that under high PCI load
+	 * (quite common in Linux of course) you can get data loss when the
+	 * CPU is held off the bus for 3 bus master requests.  This happens
+	 * to include the IDE controllers....
+	 *
+	 * VIA only apply this fix when an SB Live! is present but under
+	 * both Linux and Windows this isn't enough, and we have seen
+	 * corruption without SB Live! but with things like 3 UDMA IDE
+	 * controllers. So we ignore that bit of the VIA recommendation..
+	 */
+	pci_read_config_byte(dev, 0x76, &busarb);
+
+	/*
+	 * Set bit 4 and bit 5 of byte 76 to 0x01
+	 * "Master priority rotation on every PCI master grant"
+	 */
+	busarb &= ~(1<<5);
+	busarb |= (1<<4);
+	pci_write_config_byte(dev, 0x76, busarb);
+	pci_info(dev, "Applying VIA southbridge workaround\n");
+exit:
+	pci_dev_put(p);
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8363_0,	quirk_vialatency);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8371_1,	quirk_vialatency);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8361,		quirk_vialatency);
+/* Must restore this on a resume from RAM */
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8363_0,	quirk_vialatency);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8371_1,	quirk_vialatency);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8361,		quirk_vialatency);
+
+/* VIA Apollo VP3 needs ETBF on BT848/878 */
+static void quirk_viaetbf(struct pci_dev *dev)
+{
+	if ((pci_pci_problems&PCIPCI_VIAETBF) == 0) {
+		pci_info(dev, "Limiting direct PCI/PCI transfers\n");
+		pci_pci_problems |= PCIPCI_VIAETBF;
+	}
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C597_0,	quirk_viaetbf);
+
+static void quirk_vsfx(struct pci_dev *dev)
+{
+	if ((pci_pci_problems&PCIPCI_VSFX) == 0) {
+		pci_info(dev, "Limiting direct PCI/PCI transfers\n");
+		pci_pci_problems |= PCIPCI_VSFX;
+	}
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C576,	quirk_vsfx);
+
+/*
+ * VIA ACPI: One IO region pointed to by longword at
+ *	0x48 or 0x20 (256 bytes of ACPI registers)
+ */
+static void quirk_vt82c586_acpi(struct pci_dev *dev)
+{
+	if (dev->revision & 0x10)
+		quirk_io_region(dev, 0x48, 256, PCI_BRIDGE_RESOURCES,
+				"vt82c586 ACPI");
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C586_3,	quirk_vt82c586_acpi);
+
+/*
+ * VIA VT82C686 ACPI: Three IO region pointed to by (long)words at
+ *	0x48 (256 bytes of ACPI registers)
+ *	0x70 (128 bytes of hardware monitoring register)
+ *	0x90 (16 bytes of SMB registers)
+ */
+static void quirk_vt82c686_acpi(struct pci_dev *dev)
+{
+	quirk_vt82c586_acpi(dev);
+
+	quirk_io_region(dev, 0x70, 128, PCI_BRIDGE_RESOURCES+1,
+				 "vt82c686 HW-mon");
+
+	quirk_io_region(dev, 0x90, 16, PCI_BRIDGE_RESOURCES+2, "vt82c686 SMB");
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686_4,	quirk_vt82c686_acpi);
+
+/*
+ * VIA VT8235 ISA Bridge: Two IO regions pointed to by words at
+ *	0x88 (128 bytes of power management registers)
+ *	0xd0 (16 bytes of SMB registers)
+ */
+static void quirk_vt8235_acpi(struct pci_dev *dev)
+{
+	quirk_io_region(dev, 0x88, 128, PCI_BRIDGE_RESOURCES, "vt8235 PM");
+	quirk_io_region(dev, 0xd0, 16, PCI_BRIDGE_RESOURCES+1, "vt8235 SMB");
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8235,	quirk_vt8235_acpi);
+
+/*
+ * FIXME: it is questionable that quirk_via_acpi() is needed.  It shows up
+ * as an ISA bridge, and does not support the PCI_INTERRUPT_LINE register
+ * at all.  Therefore it seems like setting the pci_dev's IRQ to the value
+ * of the ACPI SCI interrupt is only done for convenience.
+ *	-jgarzik
+ */
+static void quirk_via_acpi(struct pci_dev *d)
+{
+	u8 irq;
+
+	/* VIA ACPI device: SCI IRQ line in PCI config byte 0x42 */
+	pci_read_config_byte(d, 0x42, &irq);
+	irq &= 0xf;
+	if (irq && (irq != 2))
+		d->irq = irq;
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C586_3,	quirk_via_acpi);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686_4,	quirk_via_acpi);
+
+/* VIA bridges which have VLink */
+static int via_vlink_dev_lo = -1, via_vlink_dev_hi = 18;
+
+static void quirk_via_bridge(struct pci_dev *dev)
+{
+	/* See what bridge we have and find the device ranges */
+	switch (dev->device) {
+	case PCI_DEVICE_ID_VIA_82C686:
+		/*
+		 * The VT82C686 is special; it attaches to PCI and can have
+		 * any device number. All its subdevices are functions of
+		 * that single device.
+		 */
+		via_vlink_dev_lo = PCI_SLOT(dev->devfn);
+		via_vlink_dev_hi = PCI_SLOT(dev->devfn);
+		break;
+	case PCI_DEVICE_ID_VIA_8237:
+	case PCI_DEVICE_ID_VIA_8237A:
+		via_vlink_dev_lo = 15;
+		break;
+	case PCI_DEVICE_ID_VIA_8235:
+		via_vlink_dev_lo = 16;
+		break;
+	case PCI_DEVICE_ID_VIA_8231:
+	case PCI_DEVICE_ID_VIA_8233_0:
+	case PCI_DEVICE_ID_VIA_8233A:
+	case PCI_DEVICE_ID_VIA_8233C_0:
+		via_vlink_dev_lo = 17;
+		break;
+	}
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686,	quirk_via_bridge);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8231,		quirk_via_bridge);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8233_0,	quirk_via_bridge);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8233A,	quirk_via_bridge);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8233C_0,	quirk_via_bridge);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8235,		quirk_via_bridge);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8237,		quirk_via_bridge);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8237A,	quirk_via_bridge);
+
+/*
+ * quirk_via_vlink		-	VIA VLink IRQ number update
+ * @dev: PCI device
+ *
+ * If the device we are dealing with is on a PIC IRQ we need to ensure that
+ * the IRQ line register which usually is not relevant for PCI cards, is
+ * actually written so that interrupts get sent to the right place.
+ *
+ * We only do this on systems where a VIA south bridge was detected, and
+ * only for VIA devices on the motherboard (see quirk_via_bridge above).
+ */
+static void quirk_via_vlink(struct pci_dev *dev)
+{
+	u8 irq, new_irq;
+
+	/* Check if we have VLink at all */
+	if (via_vlink_dev_lo == -1)
+		return;
+
+	new_irq = dev->irq;
+
+	/* Don't quirk interrupts outside the legacy IRQ range */
+	if (!new_irq || new_irq > 15)
+		return;
+
+	/* Internal device ? */
+	if (dev->bus->number != 0 || PCI_SLOT(dev->devfn) > via_vlink_dev_hi ||
+	    PCI_SLOT(dev->devfn) < via_vlink_dev_lo)
+		return;
+
+	/*
+	 * This is an internal VLink device on a PIC interrupt. The BIOS
+	 * ought to have set this but may not have, so we redo it.
+	 */
+	pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
+	if (new_irq != irq) {
+		pci_info(dev, "VIA VLink IRQ fixup, from %d to %d\n",
+			irq, new_irq);
+		udelay(15);	/* unknown if delay really needed */
+		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, new_irq);
+	}
+}
+DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_ANY_ID, quirk_via_vlink);
+
+/*
+ * VIA VT82C598 has its device ID settable and many BIOSes set it to the ID
+ * of VT82C597 for backward compatibility.  We need to switch it off to be
+ * able to recognize the real type of the chip.
+ */
+static void quirk_vt82c598_id(struct pci_dev *dev)
+{
+	pci_write_config_byte(dev, 0xfc, 0);
+	pci_read_config_word(dev, PCI_DEVICE_ID, &dev->device);
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C597_0,	quirk_vt82c598_id);
+
+/*
+ * On ASUS A8V and A8V Deluxe boards, the onboard AC97 audio controller
+ * and MC97 modem controller are disabled when a second PCI soundcard is
+ * present. This patch, tweaking the VT8237 ISA bridge, enables them.
+ * -- bjd
+ */
+static void asus_hides_ac97_lpc(struct pci_dev *dev)
+{
+	u8 val;
+	int asus_hides_ac97 = 0;
+
+	if (likely(dev->subsystem_vendor == PCI_VENDOR_ID_ASUSTEK)) {
+		if (dev->device == PCI_DEVICE_ID_VIA_8237)
+			asus_hides_ac97 = 1;
+	}
+
+	if (!asus_hides_ac97)
+		return;
+
+	pci_read_config_byte(dev, 0x50, &val);
+	if (val & 0xc0) {
+		pci_write_config_byte(dev, 0x50, val & (~0xc0));
+		pci_read_config_byte(dev, 0x50, &val);
+		if (val & 0xc0)
+			pci_info(dev, "Onboard AC97/MC97 devices continue to play 'hide and seek'! 0x%x\n",
+				 val);
+		else
+			pci_info(dev, "Enabled onboard AC97/MC97 devices\n");
+	}
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8237, asus_hides_ac97_lpc);
+DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8237, asus_hides_ac97_lpc);
+
+static void quirk_via_cx700_pci_parking_caching(struct pci_dev *dev)
+{
+	/*
+	 * Disable PCI Bus Parking and PCI Master read caching on CX700
+	 * which causes unspecified timing errors with a VT6212L on the PCI
+	 * bus leading to USB2.0 packet loss.
+	 *
+	 * This quirk is only enabled if a second (on the external PCI bus)
+	 * VT6212L is found -- the CX700 core itself also contains a USB
+	 * host controller with the same PCI ID as the VT6212L.
+	 */
+
+	/* Count VT6212L instances */
+	struct pci_dev *p = pci_get_device(PCI_VENDOR_ID_VIA,
+		PCI_DEVICE_ID_VIA_8235_USB_2, NULL);
+	uint8_t b;
+
+	/*
+	 * p should contain the first (internal) VT6212L -- see if we have
+	 * an external one by searching again.
+	 */
+	p = pci_get_device(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8235_USB_2, p);
+	if (!p)
+		return;
+	pci_dev_put(p);
+
+	if (pci_read_config_byte(dev, 0x76, &b) == 0) {
+		if (b & 0x40) {
+			/* Turn off PCI Bus Parking */
+			pci_write_config_byte(dev, 0x76, b ^ 0x40);
+
+			pci_info(dev, "Disabling VIA CX700 PCI parking\n");
+		}
+	}
+
+	if (pci_read_config_byte(dev, 0x72, &b) == 0) {
+		if (b != 0) {
+			/* Turn off PCI Master read caching */
+			pci_write_config_byte(dev, 0x72, 0x0);
+
+			/* Set PCI Master Bus time-out to "1x16 PCLK" */
+			pci_write_config_byte(dev, 0x75, 0x1);
+
+			/* Disable "Read FIFO Timer" */
+			pci_write_config_byte(dev, 0x77, 0x0);
+
+			pci_info(dev, "Disabling VIA CX700 PCI caching\n");
+		}
+	}
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA, 0x324e, quirk_via_cx700_pci_parking_caching);
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 5cf3a9722eba..e8813811d935 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -387,97 +387,6 @@ static void quirk_nopciamd(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_8151_0,	quirk_nopciamd);
 
-/*
- * VIA Apollo KT133 needs PCI latency patch
- * Made according to a Windows driver-based patch by George E. Breese;
- * see PCI Latency Adjust on http://www.viahardware.com/download/viatweak.shtm
- * Also see http://www.au-ja.org/review-kt133a-1-en.phtml for the info on
- * which Mr Breese based his work.
- *
- * Updated based on further information from the site and also on
- * information provided by VIA
- */
-static void quirk_vialatency(struct pci_dev *dev)
-{
-	struct pci_dev *p;
-	u8 busarb;
-
-	/*
-	 * Ok, we have a potential problem chipset here. Now see if we have
-	 * a buggy southbridge.
-	 */
-	p = pci_get_device(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686, NULL);
-	if (p != NULL) {
-
-		/*
-		 * 0x40 - 0x4f == 686B, 0x10 - 0x2f == 686A;
-		 * thanks Dan Hollis.
-		 * Check for buggy part revisions
-		 */
-		if (p->revision < 0x40 || p->revision > 0x42)
-			goto exit;
-	} else {
-		p = pci_get_device(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8231, NULL);
-		if (p == NULL)	/* No problem parts */
-			goto exit;
-
-		/* Check for buggy part revisions */
-		if (p->revision < 0x10 || p->revision > 0x12)
-			goto exit;
-	}
-
-	/*
-	 * Ok we have the problem. Now set the PCI master grant to occur
-	 * every master grant. The apparent bug is that under high PCI load
-	 * (quite common in Linux of course) you can get data loss when the
-	 * CPU is held off the bus for 3 bus master requests.  This happens
-	 * to include the IDE controllers....
-	 *
-	 * VIA only apply this fix when an SB Live! is present but under
-	 * both Linux and Windows this isn't enough, and we have seen
-	 * corruption without SB Live! but with things like 3 UDMA IDE
-	 * controllers. So we ignore that bit of the VIA recommendation..
-	 */
-	pci_read_config_byte(dev, 0x76, &busarb);
-
-	/*
-	 * Set bit 4 and bit 5 of byte 76 to 0x01
-	 * "Master priority rotation on every PCI master grant"
-	 */
-	busarb &= ~(1<<5);
-	busarb |= (1<<4);
-	pci_write_config_byte(dev, 0x76, busarb);
-	pci_info(dev, "Applying VIA southbridge workaround\n");
-exit:
-	pci_dev_put(p);
-}
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8363_0,	quirk_vialatency);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8371_1,	quirk_vialatency);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8361,		quirk_vialatency);
-/* Must restore this on a resume from RAM */
-DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8363_0,	quirk_vialatency);
-DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8371_1,	quirk_vialatency);
-DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8361,		quirk_vialatency);
-
-/* VIA Apollo VP3 needs ETBF on BT848/878 */
-static void quirk_viaetbf(struct pci_dev *dev)
-{
-	if ((pci_pci_problems&PCIPCI_VIAETBF) == 0) {
-		pci_info(dev, "Limiting direct PCI/PCI transfers\n");
-		pci_pci_problems |= PCIPCI_VIAETBF;
-	}
-}
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C597_0,	quirk_viaetbf);
-
-static void quirk_vsfx(struct pci_dev *dev)
-{
-	if ((pci_pci_problems&PCIPCI_VSFX) == 0) {
-		pci_info(dev, "Limiting direct PCI/PCI transfers\n");
-		pci_pci_problems |= PCIPCI_VSFX;
-	}
-}
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C576,	quirk_vsfx);
-
 /*
  * ALi Magik requires workarounds to be used by the drivers that DMA to AGP
  * space. Latency must be set to 0xA and Triton workaround applied too.
@@ -715,47 +624,6 @@ static void quirk_ali7101_acpi(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL,	PCI_DEVICE_ID_AL_M7101,		quirk_ali7101_acpi);
 
-/*
- * VIA ACPI: One IO region pointed to by longword at
- *	0x48 or 0x20 (256 bytes of ACPI registers)
- */
-static void quirk_vt82c586_acpi(struct pci_dev *dev)
-{
-	if (dev->revision & 0x10)
-		quirk_io_region(dev, 0x48, 256, PCI_BRIDGE_RESOURCES,
-				"vt82c586 ACPI");
-}
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C586_3,	quirk_vt82c586_acpi);
-
-/*
- * VIA VT82C686 ACPI: Three IO region pointed to by (long)words at
- *	0x48 (256 bytes of ACPI registers)
- *	0x70 (128 bytes of hardware monitoring register)
- *	0x90 (16 bytes of SMB registers)
- */
-static void quirk_vt82c686_acpi(struct pci_dev *dev)
-{
-	quirk_vt82c586_acpi(dev);
-
-	quirk_io_region(dev, 0x70, 128, PCI_BRIDGE_RESOURCES+1,
-				 "vt82c686 HW-mon");
-
-	quirk_io_region(dev, 0x90, 16, PCI_BRIDGE_RESOURCES+2, "vt82c686 SMB");
-}
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686_4,	quirk_vt82c686_acpi);
-
-/*
- * VIA VT8235 ISA Bridge: Two IO regions pointed to by words at
- *	0x88 (128 bytes of power management registers)
- *	0xd0 (16 bytes of SMB registers)
- */
-static void quirk_vt8235_acpi(struct pci_dev *dev)
-{
-	quirk_io_region(dev, 0x88, 128, PCI_BRIDGE_RESOURCES, "vt8235 PM");
-	quirk_io_region(dev, 0xd0, 16, PCI_BRIDGE_RESOURCES+1, "vt8235 SMB");
-}
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8235,	quirk_vt8235_acpi);
-
 /*
  * TI XIO2000a PCIe-PCI Bridge erroneously reports it supports fast
  * back-to-back: Disable fast back-to-back on the secondary bus segment
@@ -868,122 +736,6 @@ static void quirk_amd_8131_mmrbc(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_8131_BRIDGE, quirk_amd_8131_mmrbc);
 
-/*
- * FIXME: it is questionable that quirk_via_acpi() is needed.  It shows up
- * as an ISA bridge, and does not support the PCI_INTERRUPT_LINE register
- * at all.  Therefore it seems like setting the pci_dev's IRQ to the value
- * of the ACPI SCI interrupt is only done for convenience.
- *	-jgarzik
- */
-static void quirk_via_acpi(struct pci_dev *d)
-{
-	u8 irq;
-
-	/* VIA ACPI device: SCI IRQ line in PCI config byte 0x42 */
-	pci_read_config_byte(d, 0x42, &irq);
-	irq &= 0xf;
-	if (irq && (irq != 2))
-		d->irq = irq;
-}
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C586_3,	quirk_via_acpi);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686_4,	quirk_via_acpi);
-
-/* VIA bridges which have VLink */
-static int via_vlink_dev_lo = -1, via_vlink_dev_hi = 18;
-
-static void quirk_via_bridge(struct pci_dev *dev)
-{
-	/* See what bridge we have and find the device ranges */
-	switch (dev->device) {
-	case PCI_DEVICE_ID_VIA_82C686:
-		/*
-		 * The VT82C686 is special; it attaches to PCI and can have
-		 * any device number. All its subdevices are functions of
-		 * that single device.
-		 */
-		via_vlink_dev_lo = PCI_SLOT(dev->devfn);
-		via_vlink_dev_hi = PCI_SLOT(dev->devfn);
-		break;
-	case PCI_DEVICE_ID_VIA_8237:
-	case PCI_DEVICE_ID_VIA_8237A:
-		via_vlink_dev_lo = 15;
-		break;
-	case PCI_DEVICE_ID_VIA_8235:
-		via_vlink_dev_lo = 16;
-		break;
-	case PCI_DEVICE_ID_VIA_8231:
-	case PCI_DEVICE_ID_VIA_8233_0:
-	case PCI_DEVICE_ID_VIA_8233A:
-	case PCI_DEVICE_ID_VIA_8233C_0:
-		via_vlink_dev_lo = 17;
-		break;
-	}
-}
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686,	quirk_via_bridge);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8231,		quirk_via_bridge);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8233_0,	quirk_via_bridge);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8233A,	quirk_via_bridge);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8233C_0,	quirk_via_bridge);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8235,		quirk_via_bridge);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8237,		quirk_via_bridge);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8237A,	quirk_via_bridge);
-
-/*
- * quirk_via_vlink		-	VIA VLink IRQ number update
- * @dev: PCI device
- *
- * If the device we are dealing with is on a PIC IRQ we need to ensure that
- * the IRQ line register which usually is not relevant for PCI cards, is
- * actually written so that interrupts get sent to the right place.
- *
- * We only do this on systems where a VIA south bridge was detected, and
- * only for VIA devices on the motherboard (see quirk_via_bridge above).
- */
-static void quirk_via_vlink(struct pci_dev *dev)
-{
-	u8 irq, new_irq;
-
-	/* Check if we have VLink at all */
-	if (via_vlink_dev_lo == -1)
-		return;
-
-	new_irq = dev->irq;
-
-	/* Don't quirk interrupts outside the legacy IRQ range */
-	if (!new_irq || new_irq > 15)
-		return;
-
-	/* Internal device ? */
-	if (dev->bus->number != 0 || PCI_SLOT(dev->devfn) > via_vlink_dev_hi ||
-	    PCI_SLOT(dev->devfn) < via_vlink_dev_lo)
-		return;
-
-	/*
-	 * This is an internal VLink device on a PIC interrupt. The BIOS
-	 * ought to have set this but may not have, so we redo it.
-	 */
-	pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
-	if (new_irq != irq) {
-		pci_info(dev, "VIA VLink IRQ fixup, from %d to %d\n",
-			irq, new_irq);
-		udelay(15);	/* unknown if delay really needed */
-		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, new_irq);
-	}
-}
-DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_ANY_ID, quirk_via_vlink);
-
-/*
- * VIA VT82C598 has its device ID settable and many BIOSes set it to the ID
- * of VT82C597 for backward compatibility.  We need to switch it off to be
- * able to recognize the real type of the chip.
- */
-static void quirk_vt82c598_id(struct pci_dev *dev)
-{
-	pci_write_config_byte(dev, 0xfc, 0);
-	pci_read_config_word(dev, PCI_DEVICE_ID, &dev->device);
-}
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C597_0,	quirk_vt82c598_id);
-
 /*
  * CardBus controllers have a legacy base address that enables them to
  * respond as i82365 PCMCIA controllers.  We don't want them to do this.
@@ -1418,39 +1170,6 @@ static void quirk_sis_503(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_503,		quirk_sis_503);
 DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_503,		quirk_sis_503);
 
-/*
- * On ASUS A8V and A8V Deluxe boards, the onboard AC97 audio controller
- * and MC97 modem controller are disabled when a second PCI soundcard is
- * present. This patch, tweaking the VT8237 ISA bridge, enables them.
- * -- bjd
- */
-static void asus_hides_ac97_lpc(struct pci_dev *dev)
-{
-	u8 val;
-	int asus_hides_ac97 = 0;
-
-	if (likely(dev->subsystem_vendor == PCI_VENDOR_ID_ASUSTEK)) {
-		if (dev->device == PCI_DEVICE_ID_VIA_8237)
-			asus_hides_ac97 = 1;
-	}
-
-	if (!asus_hides_ac97)
-		return;
-
-	pci_read_config_byte(dev, 0x50, &val);
-	if (val & 0xc0) {
-		pci_write_config_byte(dev, 0x50, val & (~0xc0));
-		pci_read_config_byte(dev, 0x50, &val);
-		if (val & 0xc0)
-			pci_info(dev, "Onboard AC97/MC97 devices continue to play 'hide and seek'! 0x%x\n",
-				 val);
-		else
-			pci_info(dev, "Enabled onboard AC97/MC97 devices\n");
-	}
-}
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8237, asus_hides_ac97_lpc);
-DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8237, asus_hides_ac97_lpc);
-
 #if defined(CONFIG_ATA) || defined(CONFIG_ATA_MODULE)
 
 /*
@@ -2217,58 +1936,6 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA,  PCI_DEVICE_ID_NVIDIA_CK804_PCIE,
 DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_NVIDIA,  PCI_DEVICE_ID_NVIDIA_CK804_PCIE,
 			quirk_nvidia_ck804_pcie_aer_ext_cap);
 
-static void quirk_via_cx700_pci_parking_caching(struct pci_dev *dev)
-{
-	/*
-	 * Disable PCI Bus Parking and PCI Master read caching on CX700
-	 * which causes unspecified timing errors with a VT6212L on the PCI
-	 * bus leading to USB2.0 packet loss.
-	 *
-	 * This quirk is only enabled if a second (on the external PCI bus)
-	 * VT6212L is found -- the CX700 core itself also contains a USB
-	 * host controller with the same PCI ID as the VT6212L.
-	 */
-
-	/* Count VT6212L instances */
-	struct pci_dev *p = pci_get_device(PCI_VENDOR_ID_VIA,
-		PCI_DEVICE_ID_VIA_8235_USB_2, NULL);
-	uint8_t b;
-
-	/*
-	 * p should contain the first (internal) VT6212L -- see if we have
-	 * an external one by searching again.
-	 */
-	p = pci_get_device(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8235_USB_2, p);
-	if (!p)
-		return;
-	pci_dev_put(p);
-
-	if (pci_read_config_byte(dev, 0x76, &b) == 0) {
-		if (b & 0x40) {
-			/* Turn off PCI Bus Parking */
-			pci_write_config_byte(dev, 0x76, b ^ 0x40);
-
-			pci_info(dev, "Disabling VIA CX700 PCI parking\n");
-		}
-	}
-
-	if (pci_read_config_byte(dev, 0x72, &b) == 0) {
-		if (b != 0) {
-			/* Turn off PCI Master read caching */
-			pci_write_config_byte(dev, 0x72, 0x0);
-
-			/* Set PCI Master Bus time-out to "1x16 PCLK" */
-			pci_write_config_byte(dev, 0x75, 0x1);
-
-			/* Disable "Read FIFO Timer" */
-			pci_write_config_byte(dev, 0x77, 0x0);
-
-			pci_info(dev, "Disabling VIA CX700 PCI caching\n");
-		}
-	}
-}
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA, 0x324e, quirk_via_cx700_pci_parking_caching);
-
 static void quirk_brcm_5719_limit_mrrs(struct pci_dev *dev)
 {
 	u32 rev;
-- 
2.55.0

