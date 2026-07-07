Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCB639DBF4
	for <linux-pci@vger.kernel.org>; Tue,  7 Jul 2026 22:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783462692; cv=none; b=FII5RrnbawSX4iLlHGAZE8mMGWqpNRRBbq4PPz6pXQsD/oSdCmVYcvS+J00xv9d8EuI52+YC+nIYWReCM1tEF4CpkY5jtSlRiuI7DDz0vLU0Ou5hvzE+WjSN0HK8sL2yTL+4BYzTAneRfP5urFFXCwR7f5LuoetnenB6Jtv5d5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783462692; c=relaxed/simple;
	bh=k0H5M1fNCtqhpxc6t2dGrEZ8etMZchZ7ihPzDSoh9pQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EP9w7VRuws8ep2G+hGpvXPKZkEL3qL4Uc7C/EfLbyp8PU/MhZVYa3AIxUdotnEPFKd2byqInLNW2rR9n3fioMXCSlVKOsjF1PoswQqCVgCfXrIGLnXCcdzYbz0ANd43IXlew/PMpDVEHGSL/mkGIUnVY1WsoSXid2wv53bk1WWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sh7X/xGv; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sh7X/xGv"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-845ea8924fdso36695b3a.0
        for <linux-pci@vger.kernel.org>; Tue, 07 Jul 2026 15:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783462689; x=1784067489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/cRr+xUKzZYryoh2CZ2SA41r4zJ+7PurGYY0W3fAZ+Q=;
        b=sh7X/xGvk5cByfbEJ0WgRfrGMa55kbskP+YLqN3cUNC6dVq+yDl6KVaI5XBhAU7lxf
         buhd4CuDs3tLnN7NLK1xFhUFET6g8+F7UcyHG0TcbwTW4B2FohMJZspgHX5JX5V37qK9
         wUvKuP1x0H/6fBP86RbBnyHe3Gfew53esVRNezkcugI+Zi1FyHufNDobKS3Ey59NdFS9
         r9OwfqJplWTPF/WPRXHZJkP4Ik7bpkEi/sGXRa6Hb4zn1IK9DP72ZwBeojxKgy7TGslZ
         SeJwj8wNFxY4lZ7TdornxhuRA1OhGjxKxrVWzKMFymoJ78alaTjJdHbf9J5S2784ftc6
         CwoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783462689; x=1784067489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/cRr+xUKzZYryoh2CZ2SA41r4zJ+7PurGYY0W3fAZ+Q=;
        b=RFtJXqmipv+dGhgdX5x9E4nGPvpxvUjcrf58SMhc9YhXRyhAlbx3aUczceYztujbH0
         509AQ5DKG89z1LDF6cRdFEoX+fx8U6gUoy6qPO8l9UuM9m/HYzS8uGTAvWrORtE5HDZ1
         fSRZN05+dRRsYx+cqNDPJVNVVrDYtxjBB2peoyPZLk5V5rOVCEAn8Kv3ywc8Eyaiqy7X
         CwDcj356h9JDLo3vYycTP0z7OBaK8tj7D/fbRxARuUroQ/ve+ovFpaCGHcoJJb6s2imc
         EOH3SW4Sig1O3f66Tl+z6/6aIj6zt+eMTYFQ5nB85lQVnjQKx9LN1eRdY9A3L59kk8zn
         Znjw==
X-Gm-Message-State: AOJu0Yy5vnvNl1qKvde4n0szo/MqzFFYTWcqMHnM7SPmYZ/nCsUML4Y/
	DEfbdW/UAGO96qTS5IVJgbd1qTWfU08w/NvV4GEUKjOBwVQiVWYGFjxB8kD1WyHM
X-Gm-Gg: AfdE7cnzCLCtfeTXFBzSPOkD+PkYr9RilkwMI74FBcqvTg6vTrImQqRHtBPg570DFCY
	JyIp2WFfyuJxKzAxnlfi6BSToddrgziDLKt+Viq/CcJtrvuoLRw/wrbIpaHEpA9MPMOwjn6BUAx
	7c5q4KlVjzzkdg517eU+oqpf0xC6knW0FUIHEOlrjVw9JgmgcpdyxWZ3bYcGE9lm9N2JyFCK5GK
	tYVGv7IdgzGH93Ho9qdA0fWKSKuIx6+5GY8xtAMPQp0vTTt35e0KLNzzy9p6Hzqgo5lOWuaWOFk
	MLL55g1tbrkCi8PG2pHoBPJT15tBx5oSfrr/NYxmiujBVHNi26lfkrQxfbiHGMLNbA/c2UQBSLl
	IRgWhA6KMg9tQMi+O8tEu6FwMbYA4rYIOjqu0w5e2PYKZWhsQKxr2N6m9Akn/jBayKioBmW11S9
	ija//bp0sw/p5h+6DXKIZ/CCyDWpY/OJMToi9H4CdgKIHPK4sLwkDcdNQs98aum208xigAlM4v2
	L/gh30d5w==
X-Received: by 2002:a05:6a00:182a:b0:848:2f6e:e538 with SMTP id d2e1a72fcca58-84843241b9dmr19807b3a.76.1783462689397;
        Tue, 07 Jul 2026 15:18:09 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6b9b389sm6180281b3a.13.2026.07.07.15.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 15:18:08 -0700 (PDT)
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
Subject: [PATCH 5/8] x86/pci: move ALi chipset quirks to arch/x86/pci/fixup.c
Date: Tue,  7 Jul 2026 15:17:57 -0700
Message-ID: <20260707221800.920270-6-rosenp@gmail.com>
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

Move ALi-specific PCI quirk handlers from drivers/pci/quirks.c to
arch/x86/pci/fixup.c:

- ALi M1647/M1651 AGP DMA workaround (quirk_alimagik)
- ALi M7101 southbridge ACPI/SMB IO region decode (quirk_ali7101_acpi)

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 arch/x86/pci/fixup.c | 64 +++++++++++++++++++++++++++++++++++++++++--
 drivers/pci/quirks.c | 65 --------------------------------------------
 2 files changed, 62 insertions(+), 67 deletions(-)

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index 035723d2cb64..747a98dbfa88 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -13,8 +13,36 @@
 #include <asm/hpet.h>
 #include <asm/pci_x86.h>
 
-/* Non-static helpers from drivers/pci/quirks.c */
-extern void quirk_io_region(struct pci_dev *dev, int port, unsigned int size, int nr, const char *name);
+static void quirk_io_region(struct pci_dev *dev, int port,
+			    unsigned int size, int nr, const char *name)
+{
+	u16 region;
+	struct pci_bus_region bus_region;
+	struct resource *res = pci_resource_n(dev, nr);
+
+	pci_read_config_word(dev, port, &region);
+	region &= ~(size - 1);
+
+	if (!region)
+		return;
+
+	res->name = pci_name(dev);
+	res->flags = IORESOURCE_IO;
+
+	/* Convert from PCI bus to resource space */
+	bus_region.start = region;
+	bus_region.end = region + size - 1;
+	pcibios_bus_to_resource(dev->bus, res, &bus_region);
+
+	/*
+	 * "res" is typically a bridge window resource that's not being
+	 * used for a bridge window, so it's just a place to stash this
+	 * non-standard resource.  Printing "nr" or pci_resource_name() of
+	 * it doesn't really make sense.
+	 */
+	if (!pci_claim_resource(dev, nr))
+		pci_info(dev, "quirk: %pR claimed by %s\n", res, name);
+}
 
 static void piix4_io_quirk(struct pci_dev *dev, const char *name, unsigned int port, unsigned int enable)
 {
@@ -2055,3 +2083,35 @@ static void quirk_sis_503(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_503,		quirk_sis_503);
 DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_503,		quirk_sis_503);
+
+/*
+ * ALi Magik requires workarounds to be used by the drivers that DMA to AGP
+ * space. Latency must be set to 0xA and Triton workaround applied too.
+ * [Info kindly provided by ALi]
+ */
+static void quirk_alimagik(struct pci_dev *dev)
+{
+	if ((pci_pci_problems&PCIPCI_ALIMAGIK) == 0) {
+		pci_info(dev, "Limiting direct PCI/PCI transfers\n");
+		pci_pci_problems |= PCIPCI_ALIMAGIK|PCIPCI_TRITON;
+	}
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AL,	PCI_DEVICE_ID_AL_M1647,		quirk_alimagik);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AL,	PCI_DEVICE_ID_AL_M1651,		quirk_alimagik);
+
+/*
+ * Let's make the southbridge information explicit instead of having to
+ * worry about people probing the ACPI areas, for example.. (Yes, it
+ * happens, and if you read the wrong ACPI register it will put the machine
+ * to sleep with no way of waking it up again. Bummer).
+ *
+ * ALI M7101: Two IO regions pointed to by words at
+ *	0xE0 (64 bytes of ACPI registers)
+ *	0xE2 (32 bytes of SMB registers)
+ */
+static void quirk_ali7101_acpi(struct pci_dev *dev)
+{
+	quirk_io_region(dev, 0xE0, 64, PCI_BRIDGE_RESOURCES, "ali7101 ACPI");
+	quirk_io_region(dev, 0xE2, 32, PCI_BRIDGE_RESOURCES+1, "ali7101 SMB");
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL,	PCI_DEVICE_ID_AL_M7101,		quirk_ali7101_acpi);
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 71df81882049..368305ed16fd 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -37,8 +37,6 @@
 #include <linux/switchtec.h>
 #include "pci.h"
 
-void quirk_io_region(struct pci_dev *dev, int port, unsigned int size, int nr, const char *name);
-
 static bool pcie_lbms_seen(struct pci_dev *dev, u16 lnksta)
 {
 	if (test_bit(PCI_LINK_LBMS_SEEN, &dev->priv_flags))
@@ -376,21 +374,6 @@ static void quirk_nopciamd(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_8151_0,	quirk_nopciamd);
 
-/*
- * ALi Magik requires workarounds to be used by the drivers that DMA to AGP
- * space. Latency must be set to 0xA and Triton workaround applied too.
- * [Info kindly provided by ALi]
- */
-static void quirk_alimagik(struct pci_dev *dev)
-{
-	if ((pci_pci_problems&PCIPCI_ALIMAGIK) == 0) {
-		pci_info(dev, "Limiting direct PCI/PCI transfers\n");
-		pci_pci_problems |= PCIPCI_ALIMAGIK|PCIPCI_TRITON;
-	}
-}
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AL,	PCI_DEVICE_ID_AL_M1647,		quirk_alimagik);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AL,	PCI_DEVICE_ID_AL_M1651,		quirk_alimagik);
-
 /*
  * This chip can cause PCI parity errors if config register 0xA0 is read
  * while DMAs are occurring.
@@ -499,37 +482,6 @@ static void quirk_cs5536_vsa(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CS5536_ISA, quirk_cs5536_vsa);
 
-void quirk_io_region(struct pci_dev *dev, int port,
-			    unsigned int size, int nr, const char *name)
-{
-	u16 region;
-	struct pci_bus_region bus_region;
-	struct resource *res = pci_resource_n(dev, nr);
-
-	pci_read_config_word(dev, port, &region);
-	region &= ~(size - 1);
-
-	if (!region)
-		return;
-
-	res->name = pci_name(dev);
-	res->flags = IORESOURCE_IO;
-
-	/* Convert from PCI bus to resource space */
-	bus_region.start = region;
-	bus_region.end = region + size - 1;
-	pcibios_bus_to_resource(dev->bus, res, &bus_region);
-
-	/*
-	 * "res" is typically a bridge window resource that's not being
-	 * used for a bridge window, so it's just a place to stash this
-	 * non-standard resource.  Printing "nr" or pci_resource_name() of
-	 * it doesn't really make sense.
-	 */
-	if (!pci_claim_resource(dev, nr))
-		pci_info(dev, "quirk: %pR claimed by %s\n", res, name);
-}
-
 /*
  * ATI Northbridge setups MCE the processor if you even read somewhere
  * between 0x3b0->0x3bb or read 0x3d3
@@ -596,23 +548,6 @@ DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_VENDOR_ID_SYNOPSYS, PCI_ANY_ID,
 			       PCI_CLASS_SERIAL_USB_XHCI, 0,
 			       quirk_synopsys_haps);
 
-/*
- * Let's make the southbridge information explicit instead of having to
- * worry about people probing the ACPI areas, for example.. (Yes, it
- * happens, and if you read the wrong ACPI register it will put the machine
- * to sleep with no way of waking it up again. Bummer).
- *
- * ALI M7101: Two IO regions pointed to by words at
- *	0xE0 (64 bytes of ACPI registers)
- *	0xE2 (32 bytes of SMB registers)
- */
-static void quirk_ali7101_acpi(struct pci_dev *dev)
-{
-	quirk_io_region(dev, 0xE0, 64, PCI_BRIDGE_RESOURCES, "ali7101 ACPI");
-	quirk_io_region(dev, 0xE2, 32, PCI_BRIDGE_RESOURCES+1, "ali7101 SMB");
-}
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL,	PCI_DEVICE_ID_AL_M7101,		quirk_ali7101_acpi);
-
 /*
  * TI XIO2000a PCIe-PCI Bridge erroneously reports it supports fast
  * back-to-back: Disable fast back-to-back on the secondary bus segment
-- 
2.55.0

