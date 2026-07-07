Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B908D3D9678
	for <linux-pci@vger.kernel.org>; Tue,  7 Jul 2026 22:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783462695; cv=none; b=kUFeUNFkfoMbATDq5wflxWoDYxbtLVFnqW15h/3FzyqvHS0P9GMOrgkwrRHw58ENnztS9fKvBbccleuk2d8w7G2cPG3PPe1nKH7DV+wGO4pioFjoJoWx8mgVE6k+/FWX09KhkL1RnUjbt3KxKz0zMp6thduBeWxs3KbZ/MlpAEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783462695; c=relaxed/simple;
	bh=LjklNvaGSg+jpfx16Hq8zHYgAR04/OuGpYvOpeoFbFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GCLxbd1hI8qsXZZKvR1VHoIRnigPlHMBQw7dfjkpjmNZSbN6v5BWefe1FAqOAedZ9hXCvQWy5HPQ/MeDwVz8XJGl/uzef9eCexA6pDX6FfLRCRV6xGw/q2X5gk7O9qphkpwmEsjxuUKVKB/hI1rwNUpUNI1ZAo9wX5LY490VqPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oaT3UMD3; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oaT3UMD3"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8478a25f268so13526b3a.2
        for <linux-pci@vger.kernel.org>; Tue, 07 Jul 2026 15:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783462691; x=1784067491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=asXl/Y6ce56G+hwbiJRySNZsLwd/PGRlUN/mdf5NVdE=;
        b=oaT3UMD3mDkhPXrmEyfhN7JFzA9M1ULCST5+fmAiKtXuecbqympaqraFEzggHlCwg/
         FLyoIq+lupV13NkwZu/WdQYrOzj2v1RLuc4bE1+QMWMRlH9pz0bEfWv03u5zSg+8Wldu
         0RIrbLFYRk0orlpkE4mGdAAZpM80bR2uZUtD1ChcvmqSAz9PTXylij8z/7VEjgAZtomF
         bB1fNK4y+TB2ZLOm0BKbd49WfOWtIm7FoQIJbKLTVjgBGIA1hpHTa6SmwUebxlae5U6Q
         h6jauJMcfT2mBvn5NKKhGI6NZxO7qcrLVqmp3ML+Y6vrByyVgE/fy+JkLyGzFya0xgwW
         6BMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783462691; x=1784067491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=asXl/Y6ce56G+hwbiJRySNZsLwd/PGRlUN/mdf5NVdE=;
        b=WC9NPuuHI5dhfT+K2A7ghsgRqTz+qPoVNuAZXQ+ZtgtYGFzbOqLzqcpI5LoKgVijBp
         cJFw+YG8gmZhh+s7isdSN+RNRghKTIoWlWYZ+sEUTS+y07G2zcNOAG3N285JDWYG968Z
         nU013k/f8IRD/MTkk2kTVI1WknbV+YYk/+iAJh2S9p0LpzlVpJ5ZXg65N6DoYfX4Crrs
         MwzL3ODni5qNEdAmAREiPu57He6bIi9mJAD0+ft/dLjBesxZCvnGPsjtyPhKGPBt2ETd
         gjxHG3oxIWoyJu6durJYG5gfZHsGtDxxhoMSMR2NYOEobeP6PkPrc5YwrrD9J2JlBtiA
         eJhg==
X-Gm-Message-State: AOJu0YyeUK0g69MHR25yc8g8N1tHXN+UjSEsInE4QvV7CKZysE5x0kld
	LuURbpGo/3g7h3/2ePdxqtBB74qoMUu5Gw9LSv1n0YrQ3i/VbwxqTCU0XQmRFAnW
X-Gm-Gg: AfdE7cnUVIb9CWfb18HRrEtFyjBA4xQwoK+scvwmBKRPHuYLCzFUTgBMuBQpVCE4tl5
	MD1xqhf24h8GmnKsia682g5mQjWRgft2dll8SPyOqRTCby58g04nzUX+uuVuSIeqDxXuq5B97ME
	+FA9iKKn4jlsbQechIP1uGH+eV03RgZ/sqwVAwu9rQOLpb4YTo5chm8uWLyGJ6G0jLn39ci6hlu
	N5aHt6aBNHc6WAHXpw7K0Tne/obvCm2ZCuz8R742n1fyS16BGQhkIAubpnq3KBaBzeO2G1yOjig
	24VOPtRrVhD02bOqk6p4U58/DH2nb2e53APHeBR7NZ6bc0HbeYAJeEmzPmqIWDxSeNON2n5E3Mo
	5AaqIYkNevCdp83QuHjwbXXCxG5DYDNBHUXswK1pZIjbZuRHxcItNjAxwTRSVy0e2iY9X6HPHgd
	RMftPmcbcfgAP22XYB3dBTJf5fNDXZplAqEJlUFYaE2BdQ+DijFJd8JXv/IU//FCFteQvxfmfB8
	S5fug7GXQ==
X-Received: by 2002:a05:6a00:3e12:b0:847:8d56:1f69 with SMTP id d2e1a72fcca58-84842fcd66cmr27173b3a.52.1783462690944;
        Tue, 07 Jul 2026 15:18:10 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6b9b389sm6180281b3a.13.2026.07.07.15.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 15:18:10 -0700 (PDT)
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
Subject: [PATCH 6/8] x86/pci: move AMD x86 chipset quirks to arch/x86/pci/fixup.c
Date: Tue,  7 Jul 2026 15:17:58 -0700
Message-ID: <20260707221800.920270-7-rosenp@gmail.com>
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

Move AMD x86-specific PCI quirk handlers from drivers/pci/quirks.c to
arch/x86/pci/fixup.c:

- AMD 8151 AGP bridge erratum 24 (quirk_nopciamd)
- AMD CS5536 ISA bridge VSA header fix (quirk_cs5536_vsa)
- AMD FE GATE 700C PCI ordering fix (quirk_amd_ordering)
- AMD/ATI SBx00/Hudson-2 SATA IDE-to-AHCI mode switch
  (quirk_amd_ide_mode)

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 arch/x86/pci/fixup.c | 113 +++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/quirks.c | 111 ------------------------------------------
 2 files changed, 113 insertions(+), 111 deletions(-)

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index 747a98dbfa88..f1965cb4f28f 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -13,6 +13,35 @@
 #include <asm/hpet.h>
 #include <asm/pci_x86.h>
 
+const char *pci_resource_name(struct pci_dev *dev, unsigned int i);
+
+static void quirk_io(struct pci_dev *dev, int pos, unsigned int size,
+		     const char *name)
+{
+	u32 region;
+	struct pci_bus_region bus_region;
+	struct resource *res = pci_resource_n(dev, pos);
+	const char *res_name = pci_resource_name(dev, pos);
+
+	pci_read_config_dword(dev, PCI_BASE_ADDRESS_0 + (pos << 2), &region);
+
+	if (!region)
+		return;
+
+	res->name = pci_name(dev);
+	res->flags = region & ~PCI_BASE_ADDRESS_IO_MASK;
+	res->flags |=
+		(IORESOURCE_IO | IORESOURCE_PCI_FIXED | IORESOURCE_SIZEALIGN);
+	region &= ~(size - 1);
+
+	/* Convert from PCI bus to resource space */
+	bus_region.start = region;
+	bus_region.end = region + size - 1;
+	pcibios_bus_to_resource(dev->bus, res, &bus_region);
+
+	pci_info(dev, FW_BUG "%s %pR: %s quirk\n", res_name, res, name);
+}
+
 static void quirk_io_region(struct pci_dev *dev, int port,
 			    unsigned int size, int nr, const char *name)
 {
@@ -2115,3 +2144,87 @@ static void quirk_ali7101_acpi(struct pci_dev *dev)
 	quirk_io_region(dev, 0xE2, 32, PCI_BRIDGE_RESOURCES+1, "ali7101 SMB");
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL,	PCI_DEVICE_ID_AL_M7101,		quirk_ali7101_acpi);
+
+static void quirk_nopciamd(struct pci_dev *dev)
+{
+	u8 rev;
+	pci_read_config_byte(dev, 0x08, &rev);
+	if (rev == 0x13) {
+		/* Erratum 24 */
+		pci_info(dev, "Chipset erratum: Disabling direct PCI/AGP transfers\n");
+		pci_pci_problems |= PCIAGP_FAIL;
+	}
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_8151_0,	quirk_nopciamd);
+
+/*
+ * Some CS5536 BIOSes (for example, the Soekris NET5501 board w/ comBIOS
+ * ver. 1.33  20070103) don't set the correct ISA PCI region header info.
+ * BAR0 should be 8 bytes; instead, it may be set to something like 8k
+ * (which conflicts w/ BAR1's memory range).
+ *
+ * CS553x's ISA PCI BARs may also be read-only (ref:
+ * https://bugzilla.kernel.org/show_bug.cgi?id=85991 - Comment #4 forward).
+ */
+static void quirk_cs5536_vsa(struct pci_dev *dev)
+{
+	static char *name = "CS5536 ISA bridge";
+
+	if (pci_resource_len(dev, 0) != 8) {
+		quirk_io(dev, 0,   8, name);	/* SMB */
+		quirk_io(dev, 1, 256, name);	/* GPIO */
+		quirk_io(dev, 2,  64, name);	/* MFGPT */
+		pci_info(dev, "%s bug detected (incorrect header); workaround applied\n",
+			 name);
+	}
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CS5536_ISA, quirk_cs5536_vsa);
+
+/*
+ * Following the PCI ordering rules is optional on the AMD762. I'm not sure
+ * what the designers were smoking but let's not inhale...
+ *
+ * To be fair to AMD, it follows the spec by default, it's BIOS people who
+ * turn it off!
+ */
+static void quirk_amd_ordering(struct pci_dev *dev)
+{
+	u32 pcic;
+	pci_read_config_dword(dev, 0x4C, &pcic);
+	if ((pcic & 6) != 6) {
+		pcic |= 6;
+		pci_warn(dev, "BIOS failed to enable PCI standards compliance; fixing this error\n");
+		pci_write_config_dword(dev, 0x4C, pcic);
+		pci_read_config_dword(dev, 0x84, &pcic);
+		pcic |= (1 << 23);	/* Required in this mode */
+		pci_write_config_dword(dev, 0x84, pcic);
+	}
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_FE_GATE_700C, quirk_amd_ordering);
+DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_FE_GATE_700C, quirk_amd_ordering);
+
+static void quirk_amd_ide_mode(struct pci_dev *pdev)
+{
+	/* set SBX00/Hudson-2 SATA in IDE mode to AHCI mode */
+	u8 tmp;
+
+	pci_read_config_byte(pdev, PCI_CLASS_DEVICE, &tmp);
+	if (tmp == 0x01) {
+		pci_read_config_byte(pdev, 0x40, &tmp);
+		pci_write_config_byte(pdev, 0x40, tmp|1);
+		pci_write_config_byte(pdev, 0x9, 1);
+		pci_write_config_byte(pdev, 0xa, 6);
+		pci_write_config_byte(pdev, 0x40, tmp);
+
+		pdev->class = PCI_CLASS_STORAGE_SATA_AHCI;
+		pci_info(pdev, "set SATA to AHCI mode\n");
+	}
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP600_SATA, quirk_amd_ide_mode);
+DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP600_SATA, quirk_amd_ide_mode);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP700_SATA, quirk_amd_ide_mode);
+DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP700_SATA, quirk_amd_ide_mode);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_HUDSON2_SATA_IDE, quirk_amd_ide_mode);
+DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_HUDSON2_SATA_IDE, quirk_amd_ide_mode);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, 0x7900, quirk_amd_ide_mode);
+DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_AMD, 0x7900, quirk_amd_ide_mode);
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 368305ed16fd..b504c2636f73 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -362,18 +362,6 @@ static void quirk_tigerpoint_bm_sts(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_TGP_LPC, quirk_tigerpoint_bm_sts);
 #endif
 
-static void quirk_nopciamd(struct pci_dev *dev)
-{
-	u8 rev;
-	pci_read_config_byte(dev, 0x08, &rev);
-	if (rev == 0x13) {
-		/* Erratum 24 */
-		pci_info(dev, "Chipset erratum: Disabling direct PCI/AGP transfers\n");
-		pci_pci_problems |= PCIAGP_FAIL;
-	}
-}
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_8151_0,	quirk_nopciamd);
-
 /*
  * This chip can cause PCI parity errors if config register 0xA0 is read
  * while DMAs are occurring.
@@ -432,56 +420,6 @@ static void quirk_s3_64M(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_S3,	PCI_DEVICE_ID_S3_868,		quirk_s3_64M);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_S3,	PCI_DEVICE_ID_S3_968,		quirk_s3_64M);
 
-static void quirk_io(struct pci_dev *dev, int pos, unsigned int size,
-		     const char *name)
-{
-	u32 region;
-	struct pci_bus_region bus_region;
-	struct resource *res = pci_resource_n(dev, pos);
-	const char *res_name = pci_resource_name(dev, pos);
-
-	pci_read_config_dword(dev, PCI_BASE_ADDRESS_0 + (pos << 2), &region);
-
-	if (!region)
-		return;
-
-	res->name = pci_name(dev);
-	res->flags = region & ~PCI_BASE_ADDRESS_IO_MASK;
-	res->flags |=
-		(IORESOURCE_IO | IORESOURCE_PCI_FIXED | IORESOURCE_SIZEALIGN);
-	region &= ~(size - 1);
-
-	/* Convert from PCI bus to resource space */
-	bus_region.start = region;
-	bus_region.end = region + size - 1;
-	pcibios_bus_to_resource(dev->bus, res, &bus_region);
-
-	pci_info(dev, FW_BUG "%s %pR: %s quirk\n", res_name, res, name);
-}
-
-/*
- * Some CS5536 BIOSes (for example, the Soekris NET5501 board w/ comBIOS
- * ver. 1.33  20070103) don't set the correct ISA PCI region header info.
- * BAR0 should be 8 bytes; instead, it may be set to something like 8k
- * (which conflicts w/ BAR1's memory range).
- *
- * CS553x's ISA PCI BARs may also be read-only (ref:
- * https://bugzilla.kernel.org/show_bug.cgi?id=85991 - Comment #4 forward).
- */
-static void quirk_cs5536_vsa(struct pci_dev *dev)
-{
-	static char *name = "CS5536 ISA bridge";
-
-	if (pci_resource_len(dev, 0) != 8) {
-		quirk_io(dev, 0,   8, name);	/* SMB */
-		quirk_io(dev, 1, 256, name);	/* GPIO */
-		quirk_io(dev, 2,  64, name);	/* MFGPT */
-		pci_info(dev, "%s bug detected (incorrect header); workaround applied\n",
-			 name);
-	}
-}
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CS5536_ISA, quirk_cs5536_vsa);
-
 /*
  * ATI Northbridge setups MCE the processor if you even read somewhere
  * between 0x3b0->0x3bb or read 0x3d3
@@ -673,29 +611,6 @@ DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_ANY_ID, PCI_ANY_ID,
 DECLARE_PCI_FIXUP_CLASS_RESUME_EARLY(PCI_ANY_ID, PCI_ANY_ID,
 			PCI_CLASS_BRIDGE_CARDBUS, 8, quirk_cardbus_legacy);
 
-/*
- * Following the PCI ordering rules is optional on the AMD762. I'm not sure
- * what the designers were smoking but let's not inhale...
- *
- * To be fair to AMD, it follows the spec by default, it's BIOS people who
- * turn it off!
- */
-static void quirk_amd_ordering(struct pci_dev *dev)
-{
-	u32 pcic;
-	pci_read_config_dword(dev, 0x4C, &pcic);
-	if ((pcic & 6) != 6) {
-		pcic |= 6;
-		pci_warn(dev, "BIOS failed to enable PCI standards compliance; fixing this error\n");
-		pci_write_config_dword(dev, 0x4C, pcic);
-		pci_read_config_dword(dev, 0x84, &pcic);
-		pcic |= (1 << 23);	/* Required in this mode */
-		pci_write_config_dword(dev, 0x84, pcic);
-	}
-}
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_FE_GATE_700C, quirk_amd_ordering);
-DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_FE_GATE_700C, quirk_amd_ordering);
-
 /*
  * DreamWorks-provided workaround for Dunord I-3000 problem
  *
@@ -738,32 +653,6 @@ static void quirk_mediagx_master(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CYRIX,	PCI_DEVICE_ID_CYRIX_PCI_MASTER, quirk_mediagx_master);
 DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_CYRIX,	PCI_DEVICE_ID_CYRIX_PCI_MASTER, quirk_mediagx_master);
 
-static void quirk_amd_ide_mode(struct pci_dev *pdev)
-{
-	/* set SBX00/Hudson-2 SATA in IDE mode to AHCI mode */
-	u8 tmp;
-
-	pci_read_config_byte(pdev, PCI_CLASS_DEVICE, &tmp);
-	if (tmp == 0x01) {
-		pci_read_config_byte(pdev, 0x40, &tmp);
-		pci_write_config_byte(pdev, 0x40, tmp|1);
-		pci_write_config_byte(pdev, 0x9, 1);
-		pci_write_config_byte(pdev, 0xa, 6);
-		pci_write_config_byte(pdev, 0x40, tmp);
-
-		pdev->class = PCI_CLASS_STORAGE_SATA_AHCI;
-		pci_info(pdev, "set SATA to AHCI mode\n");
-	}
-}
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP600_SATA, quirk_amd_ide_mode);
-DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP600_SATA, quirk_amd_ide_mode);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP700_SATA, quirk_amd_ide_mode);
-DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP700_SATA, quirk_amd_ide_mode);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_HUDSON2_SATA_IDE, quirk_amd_ide_mode);
-DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_HUDSON2_SATA_IDE, quirk_amd_ide_mode);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, 0x7900, quirk_amd_ide_mode);
-DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_AMD, 0x7900, quirk_amd_ide_mode);
-
 /* Serverworks CSB5 IDE does not fully support native mode */
 static void quirk_svwks_csb5ide(struct pci_dev *pdev)
 {
-- 
2.55.0

