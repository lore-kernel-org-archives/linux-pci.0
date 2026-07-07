Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7F43D8121
	for <linux-pci@vger.kernel.org>; Tue,  7 Jul 2026 22:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783462693; cv=none; b=a7jq1qfv7IMNH8GPW8TIjXa05g8fjiJPt0gxuI8Nhb477by4BmhyLCh0wYerP8oTGyLkEDGqkTzwJtIGr+YNvu1Mo+poxACW6xjpljuenq7jJebuYcexZrmeYgsgedP9y64Aov3VI+LKm6POokZMhsSjuUeFkAX67eWoBhgURBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783462693; c=relaxed/simple;
	bh=eYvZt9HUJEvyrKj/J5b+R/jJeFRwP+ZQ25hMK6iHxxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wb7RShFao1NA5HrivhUc9gSQVgzoSk7eOPudHxeYYnslX8qryYlPysla+XNI1axLWYWhLSohJldU22oE0TRRGFKE0XiPYVO1pxJBsQ4w6PWIAN7PLgbDIs82L65lagWMJR4Jw4MSmaV2XpMSgwPtx4L30V8qKmdKZZ9b+WjjxpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JlCpEsbT; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlCpEsbT"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84832ec2615so27551b3a.1
        for <linux-pci@vger.kernel.org>; Tue, 07 Jul 2026 15:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783462686; x=1784067486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mvEm66BuJiE8JJX6e7+lSu2FoVd5gMa3Qf2MSw0j6e4=;
        b=JlCpEsbTSOu82G/JP1IF8btHBuIB9bRu+4srseWU6n2+/2UezQc/wTTfU70v1+nFQH
         3rqMNW/8htB+FUNgjsUvzVD3eTLLsH7EDLqTjFcc1jrjyeASPqdCcy4Xh2jByOREc2oV
         4DoDf6gL/tNZsRDlWqc/UfBtvl7eiD9vBGfAVsPjXeTXUvp4Uf3d1iYKiihtSsghe/HR
         p2gqqiOBcX8lzX5DFVs0cOhMEudxUoYx6HcktqSBlKHpqzHawgfklLiZyx8D//assiqQ
         grENiCs3IpgdLRSPssNsl5tzgzJK7WDjhOf8PB++5Znq0Sn2w0aiMWL1YrVUgQxQSikv
         jpHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783462686; x=1784067486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mvEm66BuJiE8JJX6e7+lSu2FoVd5gMa3Qf2MSw0j6e4=;
        b=fUG/ZwL/otOteeBubJ6FBhOI3PezEufUUOg0Q2Kefc4S7r7Q8qXMzxJi6uLM7sAiVI
         LuufKU4TvsS+YtmGO4EhME85ILAYQMMKDidk/Ld8Y5aY3izKUwfuh+/MnLi5j4aYaG6V
         C4rrG4+w2DxbGZ8lgJNhRkhq9gs6EF0/9jSz8hechyZQK7dfeEiaEcYofa6TJHVhkaKv
         l0mmqMFKAKUix0sKx39OEXX0TRWCVJ9D0tSZvus7Jnrz0dnMGXrO+RB8I2kRq2E2R8EN
         BoCnT4ZuDXTPzWVaGhpZycxHJ1yKo4X6/PQfKrWKevmQG2UPoJ8dFaa5fqQYP2mkisI1
         6gsQ==
X-Gm-Message-State: AOJu0YwAQjJI39mEnAnzeeaKYwH+1OlQx4fvsbTrmeRMct1qrjF4RoXJ
	1FnZ32/jHfU9OkG20oIy4e08ee8OC9FET5f8a7I9seuFZd68nc4Sjdxd2M0eRrbV
X-Gm-Gg: AfdE7cnry/vjza4kw94A9wGmDl1R3Ycn3Cl4+el2++1iRIYvb4CgN0OLhC+rclple9N
	IeWlxXrqZwqsc9e2sM0SSjvwfJeS2pycUrHAudxA6bJuu1PyHOI1Be3305NYU0Gc7FEewyQDnVF
	GDfyd9b2C2HNcy1gi6QqpgZBrCeKKdkM82+H1egHIncfvWO00/sOwO0Zcalq1Hnb3Df9CZHDOvW
	mJlqqzi1kBbT0B+GNNkftbA9vUsJW2Gg4mO3iBjfL3dMgCS1wL29S5mzyq0NSrTldI7TWeLo/uy
	VWz8QpPrf6kleLIz7o3Qz9jAXVj6g3fjODOM5+VH20ANfc/NHtjx6sNH36FDdwTOQyapqLg41qs
	KkCADA1Na6OEG7h5t2lp00+2siduQBSsrefSsPFUCMif69H7fPU1JOnDRAvNZr/vqs3xLmgUdGN
	/ZSgNMScz7LR3uEkAGd+zSroz4gBodC3EowIkVXrIJDHI94bXNolmirAyKgZ6k6+Q8RneW9iV+c
	G/sDY/8Fw==
X-Received: by 2002:a05:6a00:4292:b0:848:2c6c:dfe3 with SMTP id d2e1a72fcca58-84842ee3fd6mr66238b3a.17.1783462685350;
        Tue, 07 Jul 2026 15:18:05 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6b9b389sm6180281b3a.13.2026.07.07.15.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 15:18:04 -0700 (PDT)
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
Subject: [PATCH 2/8] x86/pci: move Intel chipset quirks to arch/x86/pci/fixup.c
Date: Tue,  7 Jul 2026 15:17:54 -0700
Message-ID: <20260707221800.920270-3-rosenp@gmail.com>
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

Move Intel-specific PCI quirk handlers from drivers/pci/quirks.c to
arch/x86/pci/fixup.c, where they logically belong as x86 platform code.
The affected categories are:

- I82371FB PIIX3 passive release (quirk_passive_release)
- 82437/82439 Triton PCI/PCI transfer limit (quirk_triton)
- 82441/82443 Natoma PCI/PCI transfer limit (quirk_natoma)
- PIIX4 ACPI/SMB IO region decode (quirk_piix4_acpi)
- ICH4/ICH5 LPC ACPI & GPIO decode (quirk_ich4_lpc_acpi)
- ICH6 LPC ACPI/GPIO & generic IO decode (quirk_ich6_lpc, ich6_lpc_acpi_gpio,
  ich6_lpc_generic_decode)
- ICH7-10 LPC generic IO decode (quirk_ich7_lpc, ich7_lpc_generic_decode)
- 82380FB transparent bridge (quirk_transparent_bridge)
- P45 bandwidth notification disable (quirk_p45_bw_notifications)
- 450NX PXB C0 restream disable (quirk_disable_pxb)
- ICH3-M IDE mode fixup (quirk_ide_samemode)
- 82375 EISA bridge class fixup (quirk_eisa_bridge)
- P64H2 1KB IO space granularity (quirk_p64h2_1k_io)
- 82865/82875 MCH overflow device unhide (quirk_unhide_mch_dev6)
- 5000/5100 MC read completion coalescing erratum (quirk_intel_mc_errata)
- Ivytown NTB BAR size fixup (quirk_intel_ntb)
- GPU interrupt disable (disable_igfx_irq)
- D3hot delay removal for Intel devices (quirk_remove_d3hot_delay)
- ROM BAR overlap defect workaround (rom_bar_overlap_defect)

The helper functions quirk_io(), quirk_io_region(), piix4_io_quirk()
and piix4_mem_quirk() are left in drivers/pci/quirks.c as non-static
symbols since they are shared with VIA/ALi quirks which will be moved
in follow-up commits.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 arch/x86/pci/fixup.c | 577 ++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/quirks.c | 578 +------------------------------------------
 2 files changed, 580 insertions(+), 575 deletions(-)

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index b301c6c8df75..034c29123e45 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -13,6 +13,61 @@
 #include <asm/hpet.h>
 #include <asm/pci_x86.h>
 
+/* Non-static helpers from drivers/pci/quirks.c */
+extern void quirk_io_region(struct pci_dev *dev, int port, unsigned int size, int nr, const char *name);
+
+static void piix4_io_quirk(struct pci_dev *dev, const char *name, unsigned int port, unsigned int enable)
+{
+	u32 devres;
+	u32 mask, size, base;
+
+	pci_read_config_dword(dev, port, &devres);
+	if ((devres & enable) != enable)
+		return;
+	mask = (devres >> 16) & 15;
+	base = devres & 0xffff;
+	size = 16;
+	for (;;) {
+		unsigned int bit = size >> 1;
+		if ((bit & mask) == bit)
+			break;
+		size = bit;
+	}
+	/*
+	 * For now we only print it out. Eventually we'll want to
+	 * reserve it (at least if it's in the 0x1000+ range), but
+	 * let's get enough confirmation reports first.
+	 */
+	base &= -size;
+	pci_info(dev, "%s PIO at %04x-%04x\n", name, base, base + size - 1);
+}
+
+static void piix4_mem_quirk(struct pci_dev *dev, const char *name, unsigned int port, unsigned int enable)
+{
+	u32 devres;
+	u32 mask, size, base;
+
+	pci_read_config_dword(dev, port, &devres);
+	if ((devres & enable) != enable)
+		return;
+	base = devres & 0xffff0000;
+	mask = (devres & 0x3f) << 16;
+	size = 128 << 16;
+	for (;;) {
+		unsigned int bit = size >> 1;
+		if ((bit & mask) == bit)
+			break;
+		size = bit;
+	}
+
+	/*
+	 * For now we only print it out. Eventually we'll want to
+	 * reserve it, but let's get enough confirmation reports first.
+	 */
+	base &= -size;
+	pci_info(dev, "%s MMIO at %04x-%04x\n", name, base, base + size - 1);
+}
+
 static void pci_fixup_i450nx(struct pci_dev *d)
 {
 	/*
@@ -1081,3 +1136,525 @@ static void quirk_tuxeo_rp_d3(struct pci_dev *pdev)
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1502, quirk_tuxeo_rp_d3);
 #endif /* CONFIG_SUSPEND */
+
+/*
+ * Deal with broken BIOSes that neglect to enable passive release,
+ * which can cause problems in combination with the 82441FX/PPro MTRRs
+ */
+static void quirk_passive_release(struct pci_dev *dev)
+{
+	struct pci_dev *d = NULL;
+	unsigned char dlc;
+
+	/*
+	 * We have to make sure a particular bit is set in the PIIX3
+	 * ISA bridge, so we have to go out and find it.
+	 */
+	while ((d = pci_get_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371SB_0, d))) {
+		pci_read_config_byte(d, 0x82, &dlc);
+		if (!(dlc & 1<<1)) {
+			pci_info(d, "PIIX3: Enabling Passive Release\n");
+			dlc |= 1<<1;
+			pci_write_config_byte(d, 0x82, dlc);
+		}
+	}
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82441,	quirk_passive_release);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82441,	quirk_passive_release);
+
+/* Triton requires workarounds to be used by the drivers */
+static void quirk_triton(struct pci_dev *dev)
+{
+	if ((pci_pci_problems&PCIPCI_TRITON) == 0) {
+		pci_info(dev, "Limiting direct PCI/PCI transfers\n");
+		pci_pci_problems |= PCIPCI_TRITON;
+	}
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82437,	quirk_triton);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82437VX,	quirk_triton);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82439,	quirk_triton);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82439TX,	quirk_triton);
+
+/* Natoma has some interesting boundary conditions with Zoran stuff at least */
+static void quirk_natoma(struct pci_dev *dev)
+{
+	if ((pci_pci_problems&PCIPCI_NATOMA) == 0) {
+		pci_info(dev, "Limiting direct PCI/PCI transfers\n");
+		pci_pci_problems |= PCIPCI_NATOMA;
+	}
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82441,	quirk_natoma);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82443LX_0,	quirk_natoma);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82443LX_1,	quirk_natoma);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82443BX_0,	quirk_natoma);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82443BX_1,	quirk_natoma);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82443BX_2,	quirk_natoma);
+
+/*
+ * PIIX4 ACPI: Two IO regions pointed to by longwords at
+ *	0x40 (64 bytes of ACPI registers)
+ *	0x90 (16 bytes of SMB registers)
+ * and a few strange programmable PIIX4 device resources.
+ */
+static void quirk_piix4_acpi(struct pci_dev *dev)
+{
+	u32 res_a;
+
+	quirk_io_region(dev, 0x40, 64, PCI_BRIDGE_RESOURCES, "PIIX4 ACPI");
+	quirk_io_region(dev, 0x90, 16, PCI_BRIDGE_RESOURCES+1, "PIIX4 SMB");
+
+	/* Device resource A has enables for some of the other ones */
+	pci_read_config_dword(dev, 0x5c, &res_a);
+
+	piix4_io_quirk(dev, "PIIX4 devres B", 0x60, 3 << 21);
+	piix4_io_quirk(dev, "PIIX4 devres C", 0x64, 3 << 21);
+
+	/* Device resource D is just bitfields for static resources */
+
+	/* Device 12 enabled? */
+	if (res_a & (1 << 29)) {
+		piix4_io_quirk(dev, "PIIX4 devres E", 0x68, 1 << 20);
+		piix4_mem_quirk(dev, "PIIX4 devres F", 0x6c, 1 << 7);
+	}
+	/* Device 13 enabled? */
+	if (res_a & (1 << 30)) {
+		piix4_io_quirk(dev, "PIIX4 devres G", 0x70, 1 << 20);
+		piix4_mem_quirk(dev, "PIIX4 devres H", 0x74, 1 << 7);
+	}
+	piix4_io_quirk(dev, "PIIX4 devres I", 0x78, 1 << 20);
+	piix4_io_quirk(dev, "PIIX4 devres J", 0x7c, 1 << 20);
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82371AB_3,	quirk_piix4_acpi);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82443MX_3,	quirk_piix4_acpi);
+
+#define ICH_PMBASE	0x40
+#define ICH_ACPI_CNTL	0x44
+#define  ICH4_ACPI_EN	0x10
+#define  ICH6_ACPI_EN	0x80
+#define ICH4_GPIOBASE	0x58
+#define ICH4_GPIO_CNTL	0x5c
+#define  ICH4_GPIO_EN	0x10
+#define ICH6_GPIOBASE	0x48
+#define ICH6_GPIO_CNTL	0x4c
+#define  ICH6_GPIO_EN	0x10
+
+/*
+ * ICH4, ICH4-M, ICH5, ICH5-M ACPI: Three IO regions pointed to by longwords at
+ *	0x40 (128 bytes of ACPI, GPIO & TCO registers)
+ *	0x58 (64 bytes of GPIO I/O space)
+ */
+static void quirk_ich4_lpc_acpi(struct pci_dev *dev)
+{
+	u8 enable;
+
+	/*
+	 * The check for PCIBIOS_MIN_IO is to ensure we won't create a conflict
+	 * with low legacy (and fixed) ports. We don't know the decoding
+	 * priority and can't tell whether the legacy device or the one created
+	 * here is really at that address.  This happens on boards with broken
+	 * BIOSes.
+	 */
+	pci_read_config_byte(dev, ICH_ACPI_CNTL, &enable);
+	if (enable & ICH4_ACPI_EN)
+		quirk_io_region(dev, ICH_PMBASE, 128, PCI_BRIDGE_RESOURCES,
+				 "ICH4 ACPI/GPIO/TCO");
+
+	pci_read_config_byte(dev, ICH4_GPIO_CNTL, &enable);
+	if (enable & ICH4_GPIO_EN)
+		quirk_io_region(dev, ICH4_GPIOBASE, 64, PCI_BRIDGE_RESOURCES+1,
+				"ICH4 GPIO");
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82801AA_0,		quirk_ich4_lpc_acpi);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82801AB_0,		quirk_ich4_lpc_acpi);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82801BA_0,		quirk_ich4_lpc_acpi);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82801BA_10,	quirk_ich4_lpc_acpi);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82801CA_0,		quirk_ich4_lpc_acpi);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82801CA_12,	quirk_ich4_lpc_acpi);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82801DB_0,		quirk_ich4_lpc_acpi);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82801DB_12,	quirk_ich4_lpc_acpi);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82801EB_0,		quirk_ich4_lpc_acpi);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_ESB_1,		quirk_ich4_lpc_acpi);
+
+static void ich6_lpc_acpi_gpio(struct pci_dev *dev)
+{
+	u8 enable;
+
+	pci_read_config_byte(dev, ICH_ACPI_CNTL, &enable);
+	if (enable & ICH6_ACPI_EN)
+		quirk_io_region(dev, ICH_PMBASE, 128, PCI_BRIDGE_RESOURCES,
+				 "ICH6 ACPI/GPIO/TCO");
+
+	pci_read_config_byte(dev, ICH6_GPIO_CNTL, &enable);
+	if (enable & ICH6_GPIO_EN)
+		quirk_io_region(dev, ICH6_GPIOBASE, 64, PCI_BRIDGE_RESOURCES+1,
+				"ICH6 GPIO");
+}
+
+static void ich6_lpc_generic_decode(struct pci_dev *dev, unsigned int reg,
+				    const char *name, int dynsize)
+{
+	u32 val;
+	u32 size, base;
+
+	pci_read_config_dword(dev, reg, &val);
+
+	/* Enabled? */
+	if (!(val & 1))
+		return;
+	base = val & 0xfffc;
+	if (dynsize) {
+		/*
+		 * This is not correct. It is 16, 32 or 64 bytes depending on
+		 * register D31:F0:ADh bits 5:4.
+		 *
+		 * But this gets us at least _part_ of it.
+		 */
+		size = 16;
+	} else {
+		size = 128;
+	}
+	base &= ~(size-1);
+
+	/*
+	 * Just print it out for now. We should reserve it after more
+	 * debugging.
+	 */
+	pci_info(dev, "%s PIO at %04x-%04x\n", name, base, base+size-1);
+}
+
+static void quirk_ich6_lpc(struct pci_dev *dev)
+{
+	/* Shared ACPI/GPIO decode with all ICH6+ */
+	ich6_lpc_acpi_gpio(dev);
+
+	/* ICH6-specific generic IO decode */
+	ich6_lpc_generic_decode(dev, 0x84, "LPC Generic IO decode 1", 0);
+	ich6_lpc_generic_decode(dev, 0x88, "LPC Generic IO decode 2", 1);
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH6_0, quirk_ich6_lpc);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH6_1, quirk_ich6_lpc);
+
+static void ich7_lpc_generic_decode(struct pci_dev *dev, unsigned int reg,
+				    const char *name)
+{
+	u32 val;
+	u32 mask, base;
+
+	pci_read_config_dword(dev, reg, &val);
+
+	/* Enabled? */
+	if (!(val & 1))
+		return;
+
+	/* IO base in bits 15:2, mask in bits 23:18, both are dword-based */
+	base = val & 0xfffc;
+	mask = (val >> 16) & 0xfc;
+	mask |= 3;
+
+	/*
+	 * Just print it out for now. We should reserve it after more
+	 * debugging.
+	 */
+	pci_info(dev, "%s PIO at %04x (mask %04x)\n", name, base, mask);
+}
+
+/* ICH7-10 has the same common LPC generic IO decode registers */
+static void quirk_ich7_lpc(struct pci_dev *dev)
+{
+	/* We share the common ACPI/GPIO decode with ICH6 */
+	ich6_lpc_acpi_gpio(dev);
+
+	/* And have 4 ICH7+ generic decodes */
+	ich7_lpc_generic_decode(dev, 0x84, "ICH7 LPC Generic IO decode 1");
+	ich7_lpc_generic_decode(dev, 0x88, "ICH7 LPC Generic IO decode 2");
+	ich7_lpc_generic_decode(dev, 0x8c, "ICH7 LPC Generic IO decode 3");
+	ich7_lpc_generic_decode(dev, 0x90, "ICH7 LPC Generic IO decode 4");
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH7_0, quirk_ich7_lpc);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH7_1, quirk_ich7_lpc);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH7_31, quirk_ich7_lpc);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH8_0, quirk_ich7_lpc);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH8_2, quirk_ich7_lpc);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH8_3, quirk_ich7_lpc);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH8_1, quirk_ich7_lpc);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH8_4, quirk_ich7_lpc);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH9_2, quirk_ich7_lpc);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH9_4, quirk_ich7_lpc);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH9_7, quirk_ich7_lpc);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_ICH9_8, quirk_ich7_lpc);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_ICH10_1, quirk_ich7_lpc);
+
+static void quirk_transparent_bridge(struct pci_dev *dev)
+{
+	dev->transparent = 1;
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82380FB,	quirk_transparent_bridge);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TOSHIBA,	0x605,	quirk_transparent_bridge);
+
+/*
+ * Enabling Link Bandwidth Management Interrupts (BW notifications) can cause
+ * boot hangs on P45.
+ */
+static void quirk_p45_bw_notifications(struct pci_dev *dev)
+{
+	dev->no_bw_notif = 1;
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2e21, quirk_p45_bw_notifications);
+
+/*
+ * Ensure C0 rev restreaming is off. This is normally done by the BIOS but
+ * in the odd case it is not the results are corruption hence the presence
+ * of a Linux check.
+ */
+static void quirk_disable_pxb(struct pci_dev *pdev)
+{
+	u16 config;
+
+	if (pdev->revision != 0x04)		/* Only C0 requires this */
+		return;
+	pci_read_config_word(pdev, 0x40, &config);
+	if (config & (1<<6)) {
+		config &= ~(1<<6);
+		pci_write_config_word(pdev, 0x40, config);
+		pci_info(pdev, "C0 revision 450NX. Disabling PCI restreaming\n");
+	}
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82454NX,	quirk_disable_pxb);
+DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82454NX,	quirk_disable_pxb);
+
+/* Intel 82801CAM ICH3-M datasheet says IDE modes must be the same */
+static void quirk_ide_samemode(struct pci_dev *pdev)
+{
+	u8 prog;
+
+	pci_read_config_byte(pdev, PCI_CLASS_PROG, &prog);
+
+	if (((prog & 1) && !(prog & 4)) || ((prog & 4) && !(prog & 1))) {
+		pci_info(pdev, "IDE mode mismatch; forcing legacy mode\n");
+		prog &= ~5;
+		pdev->class &= ~5;
+		pci_write_config_byte(pdev, PCI_CLASS_PROG, prog);
+	}
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_10, quirk_ide_samemode);
+
+/*
+ * This was originally an Alpha-specific thing, but it really fits here.
+ * The i82375 PCI/EISA bridge appears as non-classified. Fix that.
+ */
+static void quirk_eisa_bridge(struct pci_dev *dev)
+{
+	dev->class = PCI_CLASS_BRIDGE_EISA << 8;
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82375,	quirk_eisa_bridge);
+
+/* Enable 1k I/O space granularity on the Intel P64H2 */
+static void quirk_p64h2_1k_io(struct pci_dev *dev)
+{
+	u16 en1k;
+
+	pci_read_config_word(dev, 0x40, &en1k);
+
+	if (en1k & 0x200) {
+		pci_info(dev, "Enable I/O Space to 1KB granularity\n");
+		dev->io_window_1k = 1;
+	}
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x1460, quirk_p64h2_1k_io);
+
+/*
+ * Originally in EDAC sources for i82875P: Intel tells BIOS developers to
+ * hide device 6 which configures the overflow device access containing the
+ * DRBs - this is where we expose device 6.
+ * http://www.x86-secret.com/articles/tweak/pat/patsecrets-2.htm
+ */
+static void quirk_unhide_mch_dev6(struct pci_dev *dev)
+{
+	u8 reg;
+
+	if (pci_read_config_byte(dev, 0xF4, &reg) == 0 && !(reg & 0x02)) {
+		pci_info(dev, "Enabling MCH 'Overflow' Device\n");
+		pci_write_config_byte(dev, 0xF4, reg | 0x02);
+	}
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82865_HB,
+			quirk_unhide_mch_dev6);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82875_HB,
+			quirk_unhide_mch_dev6);
+
+/*
+ * Intel 5000 and 5100 Memory controllers have an erratum with read completion
+ * coalescing (which is enabled by default on some BIOSes) and MPS of 256B.
+ * Since there is no way of knowing what the PCIe MPS on each fabric will be
+ * until all of the devices are discovered and buses walked, read completion
+ * coalescing must be disabled.  Unfortunately, it cannot be re-enabled because
+ * it is possible to hotplug a device with MPS of 256B.
+ */
+static void quirk_intel_mc_errata(struct pci_dev *dev)
+{
+	int err;
+	u16 rcc;
+
+	if (pcie_bus_config == PCIE_BUS_TUNE_OFF ||
+	    pcie_bus_config == PCIE_BUS_DEFAULT)
+		return;
+
+	/*
+	 * Intel erratum specifies bits to change but does not say what
+	 * they are.  Keeping them magical until such time as the registers
+	 * and values can be explained.
+	 */
+	err = pci_read_config_word(dev, 0x48, &rcc);
+	if (err) {
+		pci_err(dev, "Error attempting to read the read completion coalescing register\n");
+		return;
+	}
+
+	if (!(rcc & (1 << 10)))
+		return;
+
+	rcc &= ~(1 << 10);
+
+	err = pci_write_config_word(dev, 0x48, rcc);
+	if (err) {
+		pci_err(dev, "Error attempting to write the read completion coalescing register\n");
+		return;
+	}
+
+	pr_info_once("Read completion coalescing disabled due to hardware erratum relating to 256B MPS\n");
+}
+/* Intel 5000 series memory controllers and ports 2-7 */
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x25c0, quirk_intel_mc_errata);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x25d0, quirk_intel_mc_errata);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x25d4, quirk_intel_mc_errata);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x25d8, quirk_intel_mc_errata);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x25e2, quirk_intel_mc_errata);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x25e3, quirk_intel_mc_errata);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x25e4, quirk_intel_mc_errata);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x25e5, quirk_intel_mc_errata);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x25e6, quirk_intel_mc_errata);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x25e7, quirk_intel_mc_errata);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x25f7, quirk_intel_mc_errata);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x25f8, quirk_intel_mc_errata);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x25f9, quirk_intel_mc_errata);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x25fa, quirk_intel_mc_errata);
+/* Intel 5100 series memory controllers and ports 2-7 */
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x65c0, quirk_intel_mc_errata);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x65e2, quirk_intel_mc_errata);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x65e3, quirk_intel_mc_errata);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x65e4, quirk_intel_mc_errata);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x65e5, quirk_intel_mc_errata);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x65e6, quirk_intel_mc_errata);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x65e7, quirk_intel_mc_errata);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x65f7, quirk_intel_mc_errata);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x65f8, quirk_intel_mc_errata);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x65f9, quirk_intel_mc_errata);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x65fa, quirk_intel_mc_errata);
+
+/*
+ * Ivytown NTB BAR sizes are misreported by the hardware due to an erratum.
+ * To work around this, query the size it should be configured to by the
+ * device and modify the resource end to correspond to this new size.
+ */
+static void quirk_intel_ntb(struct pci_dev *dev)
+{
+	int rc;
+	u8 val;
+
+	rc = pci_read_config_byte(dev, 0x00D0, &val);
+	if (rc)
+		return;
+
+	resource_set_size(&dev->resource[2], (resource_size_t)1 << val);
+
+	rc = pci_read_config_byte(dev, 0x00D1, &val);
+	if (rc)
+		return;
+
+	resource_set_size(&dev->resource[4], (resource_size_t)1 << val);
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x0e08, quirk_intel_ntb);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x0e0d, quirk_intel_ntb);
+
+/*
+ * Some BIOS implementations leave the Intel GPU interrupts enabled, even
+ * though no one is handling them (e.g., if the i915 driver is never
+ * loaded).  Additionally the interrupt destination is not set up properly
+ * and the interrupt ends up -somewhere-.
+ *
+ * These spurious interrupts are "sticky" and the kernel disables the
+ * (shared) interrupt line after 100,000+ generated interrupts.
+ *
+ * Fix it by disabling the still enabled interrupts.  This resolves crashes
+ * often seen on monitor unplug.
+ */
+#define I915_DEIER_REG 0x4400c
+static void disable_igfx_irq(struct pci_dev *dev)
+{
+	void __iomem *regs = pci_iomap(dev, 0, 0);
+	if (regs == NULL) {
+		pci_warn(dev, "igfx quirk: Can't iomap PCI device\n");
+		return;
+	}
+
+	/* Check if any interrupt line is still enabled */
+	if (readl(regs + I915_DEIER_REG) != 0) {
+		pci_warn(dev, "BIOS left Intel GPU interrupts enabled; disabling\n");
+
+		writel(0, regs + I915_DEIER_REG);
+	}
+
+	pci_iounmap(dev, regs);
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0042, disable_igfx_irq);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0046, disable_igfx_irq);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x004a, disable_igfx_irq);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0102, disable_igfx_irq);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0106, disable_igfx_irq);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x010a, disable_igfx_irq);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0152, disable_igfx_irq);
+
+/*
+ * PCI devices which are on Intel chips can skip the 10ms delay
+ * before entering D3 mode.
+ */
+static void quirk_remove_d3hot_delay(struct pci_dev *dev)
+{
+	dev->d3hot_delay = 0;
+}
+/* C600 Series devices do not need 10ms d3hot_delay */
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0412, quirk_remove_d3hot_delay);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0c00, quirk_remove_d3hot_delay);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0c0c, quirk_remove_d3hot_delay);
+/* Lynxpoint-H PCH devices do not need 10ms d3hot_delay */
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x8c02, quirk_remove_d3hot_delay);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x8c18, quirk_remove_d3hot_delay);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x8c1c, quirk_remove_d3hot_delay);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x8c20, quirk_remove_d3hot_delay);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x8c22, quirk_remove_d3hot_delay);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x8c26, quirk_remove_d3hot_delay);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x8c2d, quirk_remove_d3hot_delay);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x8c31, quirk_remove_d3hot_delay);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x8c3a, quirk_remove_d3hot_delay);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x8c3d, quirk_remove_d3hot_delay);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x8c4e, quirk_remove_d3hot_delay);
+/* Intel Cherrytrail devices do not need 10ms d3hot_delay */
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x2280, quirk_remove_d3hot_delay);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x2298, quirk_remove_d3hot_delay);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x229c, quirk_remove_d3hot_delay);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x22b0, quirk_remove_d3hot_delay);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x22b5, quirk_remove_d3hot_delay);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x22b7, quirk_remove_d3hot_delay);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x22b8, quirk_remove_d3hot_delay);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x22d8, quirk_remove_d3hot_delay);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x22dc, quirk_remove_d3hot_delay);
+
+static void rom_bar_overlap_defect(struct pci_dev *dev)
+{
+	pci_info(dev, "working around ROM BAR overlap defect\n");
+	dev->rom_bar_overlap = 1;
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1533, rom_bar_overlap_defect);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1536, rom_bar_overlap_defect);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1537, rom_bar_overlap_defect);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1538, rom_bar_overlap_defect);
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index b09f27f7846f..5cf3a9722eba 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -37,6 +37,8 @@
 #include <linux/switchtec.h>
 #include "pci.h"
 
+void quirk_io_region(struct pci_dev *dev, int port, unsigned int size, int nr, const char *name);
+
 static bool pcie_lbms_seen(struct pci_dev *dev, u16 lnksta)
 {
 	if (test_bit(PCI_LINK_LBMS_SEEN, &dev->priv_flags))
@@ -311,31 +313,6 @@ DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_ANY_ID, PCI_ANY_ID,
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MELLANOX, PCI_DEVICE_ID_MELLANOX_TAVOR, pci_disable_parity);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MELLANOX, PCI_DEVICE_ID_MELLANOX_TAVOR_BRIDGE, pci_disable_parity);
 
-/*
- * Deal with broken BIOSes that neglect to enable passive release,
- * which can cause problems in combination with the 82441FX/PPro MTRRs
- */
-static void quirk_passive_release(struct pci_dev *dev)
-{
-	struct pci_dev *d = NULL;
-	unsigned char dlc;
-
-	/*
-	 * We have to make sure a particular bit is set in the PIIX3
-	 * ISA bridge, so we have to go out and find it.
-	 */
-	while ((d = pci_get_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371SB_0, d))) {
-		pci_read_config_byte(d, 0x82, &dlc);
-		if (!(dlc & 1<<1)) {
-			pci_info(d, "PIIX3: Enabling Passive Release\n");
-			dlc |= 1<<1;
-			pci_write_config_byte(d, 0x82, dlc);
-		}
-	}
-}
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82441,	quirk_passive_release);
-DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82441,	quirk_passive_release);
-
 #ifdef CONFIG_X86_32
 /*
  * The VIA VP2/VP3/MVP3 seem to have some 'features'. There may be a
@@ -410,19 +387,6 @@ static void quirk_nopciamd(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_8151_0,	quirk_nopciamd);
 
-/* Triton requires workarounds to be used by the drivers */
-static void quirk_triton(struct pci_dev *dev)
-{
-	if ((pci_pci_problems&PCIPCI_TRITON) == 0) {
-		pci_info(dev, "Limiting direct PCI/PCI transfers\n");
-		pci_pci_problems |= PCIPCI_TRITON;
-	}
-}
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82437,	quirk_triton);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82437VX,	quirk_triton);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82439,	quirk_triton);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82439TX,	quirk_triton);
-
 /*
  * VIA Apollo KT133 needs PCI latency patch
  * Made according to a Windows driver-based patch by George E. Breese;
@@ -529,21 +493,6 @@ static void quirk_alimagik(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AL,	PCI_DEVICE_ID_AL_M1647,		quirk_alimagik);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AL,	PCI_DEVICE_ID_AL_M1651,		quirk_alimagik);
 
-/* Natoma has some interesting boundary conditions with Zoran stuff at least */
-static void quirk_natoma(struct pci_dev *dev)
-{
-	if ((pci_pci_problems&PCIPCI_NATOMA) == 0) {
-		pci_info(dev, "Limiting direct PCI/PCI transfers\n");
-		pci_pci_problems |= PCIPCI_NATOMA;
-	}
-}
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82441,	quirk_natoma);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82443LX_0,	quirk_natoma);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82443LX_1,	quirk_natoma);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82443BX_0,	quirk_natoma);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82443BX_1,	quirk_natoma);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82443BX_2,	quirk_natoma);
-
 /*
  * This chip can cause PCI parity errors if config register 0xA0 is read
  * while DMAs are occurring.
@@ -652,7 +601,7 @@ static void quirk_cs5536_vsa(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CS5536_ISA, quirk_cs5536_vsa);
 
-static void quirk_io_region(struct pci_dev *dev, int port,
+void quirk_io_region(struct pci_dev *dev, int port,
 			    unsigned int size, int nr, const char *name)
 {
 	u16 region;
@@ -766,252 +715,6 @@ static void quirk_ali7101_acpi(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL,	PCI_DEVICE_ID_AL_M7101,		quirk_ali7101_acpi);
 
-static void piix4_io_quirk(struct pci_dev *dev, const char *name, unsigned int port, unsigned int enable)
-{
-	u32 devres;
-	u32 mask, size, base;
-
-	pci_read_config_dword(dev, port, &devres);
-	if ((devres & enable) != enable)
-		return;
-	mask = (devres >> 16) & 15;
-	base = devres & 0xffff;
-	size = 16;
-	for (;;) {
-		unsigned int bit = size >> 1;
-		if ((bit & mask) == bit)
-			break;
-		size = bit;
-	}
-	/*
-	 * For now we only print it out. Eventually we'll want to
-	 * reserve it (at least if it's in the 0x1000+ range), but
-	 * let's get enough confirmation reports first.
-	 */
-	base &= -size;
-	pci_info(dev, "%s PIO at %04x-%04x\n", name, base, base + size - 1);
-}
-
-static void piix4_mem_quirk(struct pci_dev *dev, const char *name, unsigned int port, unsigned int enable)
-{
-	u32 devres;
-	u32 mask, size, base;
-
-	pci_read_config_dword(dev, port, &devres);
-	if ((devres & enable) != enable)
-		return;
-	base = devres & 0xffff0000;
-	mask = (devres & 0x3f) << 16;
-	size = 128 << 16;
-	for (;;) {
-		unsigned int bit = size >> 1;
-		if ((bit & mask) == bit)
-			break;
-		size = bit;
-	}
-
-	/*
-	 * For now we only print it out. Eventually we'll want to
-	 * reserve it, but let's get enough confirmation reports first.
-	 */
-	base &= -size;
-	pci_info(dev, "%s MMIO at %04x-%04x\n", name, base, base + size - 1);
-}
-
-/*
- * PIIX4 ACPI: Two IO regions pointed to by longwords at
- *	0x40 (64 bytes of ACPI registers)
- *	0x90 (16 bytes of SMB registers)
- * and a few strange programmable PIIX4 device resources.
- */
-static void quirk_piix4_acpi(struct pci_dev *dev)
-{
-	u32 res_a;
-
-	quirk_io_region(dev, 0x40, 64, PCI_BRIDGE_RESOURCES, "PIIX4 ACPI");
-	quirk_io_region(dev, 0x90, 16, PCI_BRIDGE_RESOURCES+1, "PIIX4 SMB");
-
-	/* Device resource A has enables for some of the other ones */
-	pci_read_config_dword(dev, 0x5c, &res_a);
-
-	piix4_io_quirk(dev, "PIIX4 devres B", 0x60, 3 << 21);
-	piix4_io_quirk(dev, "PIIX4 devres C", 0x64, 3 << 21);
-
-	/* Device resource D is just bitfields for static resources */
-
-	/* Device 12 enabled? */
-	if (res_a & (1 << 29)) {
-		piix4_io_quirk(dev, "PIIX4 devres E", 0x68, 1 << 20);
-		piix4_mem_quirk(dev, "PIIX4 devres F", 0x6c, 1 << 7);
-	}
-	/* Device 13 enabled? */
-	if (res_a & (1 << 30)) {
-		piix4_io_quirk(dev, "PIIX4 devres G", 0x70, 1 << 20);
-		piix4_mem_quirk(dev, "PIIX4 devres H", 0x74, 1 << 7);
-	}
-	piix4_io_quirk(dev, "PIIX4 devres I", 0x78, 1 << 20);
-	piix4_io_quirk(dev, "PIIX4 devres J", 0x7c, 1 << 20);
-}
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82371AB_3,	quirk_piix4_acpi);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82443MX_3,	quirk_piix4_acpi);
-
-#define ICH_PMBASE	0x40
-#define ICH_ACPI_CNTL	0x44
-#define  ICH4_ACPI_EN	0x10
-#define  ICH6_ACPI_EN	0x80
-#define ICH4_GPIOBASE	0x58
-#define ICH4_GPIO_CNTL	0x5c
-#define  ICH4_GPIO_EN	0x10
-#define ICH6_GPIOBASE	0x48
-#define ICH6_GPIO_CNTL	0x4c
-#define  ICH6_GPIO_EN	0x10
-
-/*
- * ICH4, ICH4-M, ICH5, ICH5-M ACPI: Three IO regions pointed to by longwords at
- *	0x40 (128 bytes of ACPI, GPIO & TCO registers)
- *	0x58 (64 bytes of GPIO I/O space)
- */
-static void quirk_ich4_lpc_acpi(struct pci_dev *dev)
-{
-	u8 enable;
-
-	/*
-	 * The check for PCIBIOS_MIN_IO is to ensure we won't create a conflict
-	 * with low legacy (and fixed) ports. We don't know the decoding
-	 * priority and can't tell whether the legacy device or the one created
-	 * here is really at that address.  This happens on boards with broken
-	 * BIOSes.
-	 */
-	pci_read_config_byte(dev, ICH_ACPI_CNTL, &enable);
-	if (enable & ICH4_ACPI_EN)
-		quirk_io_region(dev, ICH_PMBASE, 128, PCI_BRIDGE_RESOURCES,
-				 "ICH4 ACPI/GPIO/TCO");
-
-	pci_read_config_byte(dev, ICH4_GPIO_CNTL, &enable);
-	if (enable & ICH4_GPIO_EN)
-		quirk_io_region(dev, ICH4_GPIOBASE, 64, PCI_BRIDGE_RESOURCES+1,
-				"ICH4 GPIO");
-}
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82801AA_0,		quirk_ich4_lpc_acpi);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82801AB_0,		quirk_ich4_lpc_acpi);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82801BA_0,		quirk_ich4_lpc_acpi);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82801BA_10,	quirk_ich4_lpc_acpi);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82801CA_0,		quirk_ich4_lpc_acpi);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82801CA_12,	quirk_ich4_lpc_acpi);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82801DB_0,		quirk_ich4_lpc_acpi);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82801DB_12,	quirk_ich4_lpc_acpi);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82801EB_0,		quirk_ich4_lpc_acpi);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_ESB_1,		quirk_ich4_lpc_acpi);
-
-static void ich6_lpc_acpi_gpio(struct pci_dev *dev)
-{
-	u8 enable;
-
-	pci_read_config_byte(dev, ICH_ACPI_CNTL, &enable);
-	if (enable & ICH6_ACPI_EN)
-		quirk_io_region(dev, ICH_PMBASE, 128, PCI_BRIDGE_RESOURCES,
-				 "ICH6 ACPI/GPIO/TCO");
-
-	pci_read_config_byte(dev, ICH6_GPIO_CNTL, &enable);
-	if (enable & ICH6_GPIO_EN)
-		quirk_io_region(dev, ICH6_GPIOBASE, 64, PCI_BRIDGE_RESOURCES+1,
-				"ICH6 GPIO");
-}
-
-static void ich6_lpc_generic_decode(struct pci_dev *dev, unsigned int reg,
-				    const char *name, int dynsize)
-{
-	u32 val;
-	u32 size, base;
-
-	pci_read_config_dword(dev, reg, &val);
-
-	/* Enabled? */
-	if (!(val & 1))
-		return;
-	base = val & 0xfffc;
-	if (dynsize) {
-		/*
-		 * This is not correct. It is 16, 32 or 64 bytes depending on
-		 * register D31:F0:ADh bits 5:4.
-		 *
-		 * But this gets us at least _part_ of it.
-		 */
-		size = 16;
-	} else {
-		size = 128;
-	}
-	base &= ~(size-1);
-
-	/*
-	 * Just print it out for now. We should reserve it after more
-	 * debugging.
-	 */
-	pci_info(dev, "%s PIO at %04x-%04x\n", name, base, base+size-1);
-}
-
-static void quirk_ich6_lpc(struct pci_dev *dev)
-{
-	/* Shared ACPI/GPIO decode with all ICH6+ */
-	ich6_lpc_acpi_gpio(dev);
-
-	/* ICH6-specific generic IO decode */
-	ich6_lpc_generic_decode(dev, 0x84, "LPC Generic IO decode 1", 0);
-	ich6_lpc_generic_decode(dev, 0x88, "LPC Generic IO decode 2", 1);
-}
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH6_0, quirk_ich6_lpc);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH6_1, quirk_ich6_lpc);
-
-static void ich7_lpc_generic_decode(struct pci_dev *dev, unsigned int reg,
-				    const char *name)
-{
-	u32 val;
-	u32 mask, base;
-
-	pci_read_config_dword(dev, reg, &val);
-
-	/* Enabled? */
-	if (!(val & 1))
-		return;
-
-	/* IO base in bits 15:2, mask in bits 23:18, both are dword-based */
-	base = val & 0xfffc;
-	mask = (val >> 16) & 0xfc;
-	mask |= 3;
-
-	/*
-	 * Just print it out for now. We should reserve it after more
-	 * debugging.
-	 */
-	pci_info(dev, "%s PIO at %04x (mask %04x)\n", name, base, mask);
-}
-
-/* ICH7-10 has the same common LPC generic IO decode registers */
-static void quirk_ich7_lpc(struct pci_dev *dev)
-{
-	/* We share the common ACPI/GPIO decode with ICH6 */
-	ich6_lpc_acpi_gpio(dev);
-
-	/* And have 4 ICH7+ generic decodes */
-	ich7_lpc_generic_decode(dev, 0x84, "ICH7 LPC Generic IO decode 1");
-	ich7_lpc_generic_decode(dev, 0x88, "ICH7 LPC Generic IO decode 2");
-	ich7_lpc_generic_decode(dev, 0x8c, "ICH7 LPC Generic IO decode 3");
-	ich7_lpc_generic_decode(dev, 0x90, "ICH7 LPC Generic IO decode 4");
-}
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH7_0, quirk_ich7_lpc);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH7_1, quirk_ich7_lpc);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH7_31, quirk_ich7_lpc);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH8_0, quirk_ich7_lpc);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH8_2, quirk_ich7_lpc);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH8_3, quirk_ich7_lpc);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH8_1, quirk_ich7_lpc);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH8_4, quirk_ich7_lpc);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH9_2, quirk_ich7_lpc);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH9_4, quirk_ich7_lpc);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH9_7, quirk_ich7_lpc);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH9_8, quirk_ich7_lpc);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_ICH10_1, quirk_ich7_lpc);
-
 /*
  * VIA ACPI: One IO region pointed to by longword at
  *	0x48 or 0x20 (256 bytes of ACPI registers)
@@ -1338,23 +1041,6 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_DUNORD,	PCI_DEVICE_ID_DUNORD_I3000,	quirk
  * decoding (transparent), and does indicate this in the ProgIf.
  * Unfortunately, the ProgIf value is wrong - 0x80 instead of 0x01.
  */
-static void quirk_transparent_bridge(struct pci_dev *dev)
-{
-	dev->transparent = 1;
-}
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82380FB,	quirk_transparent_bridge);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TOSHIBA,	0x605,	quirk_transparent_bridge);
-
-/*
- * Enabling Link Bandwidth Management Interrupts (BW notifications) can cause
- * boot hangs on P45.
- */
-static void quirk_p45_bw_notifications(struct pci_dev *dev)
-{
-	dev->no_bw_notif = 1;
-}
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2e21, quirk_p45_bw_notifications);
-
 /*
  * Common misconfiguration of the MediaGX/Geode PCI master that will reduce
  * PCI bandwidth from 70MB/s to 25MB/s.  See the GXM/GXLV/GX1 datasheets
@@ -1376,27 +1062,6 @@ static void quirk_mediagx_master(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CYRIX,	PCI_DEVICE_ID_CYRIX_PCI_MASTER, quirk_mediagx_master);
 DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_CYRIX,	PCI_DEVICE_ID_CYRIX_PCI_MASTER, quirk_mediagx_master);
 
-/*
- * Ensure C0 rev restreaming is off. This is normally done by the BIOS but
- * in the odd case it is not the results are corruption hence the presence
- * of a Linux check.
- */
-static void quirk_disable_pxb(struct pci_dev *pdev)
-{
-	u16 config;
-
-	if (pdev->revision != 0x04)		/* Only C0 requires this */
-		return;
-	pci_read_config_word(pdev, 0x40, &config);
-	if (config & (1<<6)) {
-		config &= ~(1<<6);
-		pci_write_config_word(pdev, 0x40, config);
-		pci_info(pdev, "C0 revision 450NX. Disabling PCI restreaming\n");
-	}
-}
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82454NX,	quirk_disable_pxb);
-DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82454NX,	quirk_disable_pxb);
-
 static void quirk_amd_ide_mode(struct pci_dev *pdev)
 {
 	/* set SBX00/Hudson-2 SATA in IDE mode to AHCI mode */
@@ -1437,22 +1102,6 @@ static void quirk_svwks_csb5ide(struct pci_dev *pdev)
 }
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_CSB5IDE, quirk_svwks_csb5ide);
 
-/* Intel 82801CAM ICH3-M datasheet says IDE modes must be the same */
-static void quirk_ide_samemode(struct pci_dev *pdev)
-{
-	u8 prog;
-
-	pci_read_config_byte(pdev, PCI_CLASS_PROG, &prog);
-
-	if (((prog & 1) && !(prog & 4)) || ((prog & 4) && !(prog & 1))) {
-		pci_info(pdev, "IDE mode mismatch; forcing legacy mode\n");
-		prog &= ~5;
-		pdev->class &= ~5;
-		pci_write_config_byte(pdev, PCI_CLASS_PROG, prog);
-	}
-}
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_10, quirk_ide_samemode);
-
 /* Some ATA devices break if put into D3 */
 static void quirk_no_ata_d3(struct pci_dev *pdev)
 {
@@ -1471,16 +1120,6 @@ DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_AL, PCI_ANY_ID,
 DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_VIA, PCI_ANY_ID,
 				PCI_CLASS_STORAGE_IDE, 8, quirk_no_ata_d3);
 
-/*
- * This was originally an Alpha-specific thing, but it really fits here.
- * The i82375 PCI/EISA bridge appears as non-classified. Fix that.
- */
-static void quirk_eisa_bridge(struct pci_dev *dev)
-{
-	dev->class = PCI_CLASS_BRIDGE_EISA << 8;
-}
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82375,	quirk_eisa_bridge);
-
 /*
  * On ASUS P4B boards, the SMBus PCI Device within the ICH2/4 southbridge
  * is not activated. The myth is that Asus said that they do not want the
@@ -2557,20 +2196,6 @@ static void fixup_rev1_53c810(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NCR, PCI_DEVICE_ID_NCR_53C810, fixup_rev1_53c810);
 
-/* Enable 1k I/O space granularity on the Intel P64H2 */
-static void quirk_p64h2_1k_io(struct pci_dev *dev)
-{
-	u16 en1k;
-
-	pci_read_config_word(dev, 0x40, &en1k);
-
-	if (en1k & 0x200) {
-		pci_info(dev, "Enable I/O Space to 1KB granularity\n");
-		dev->io_window_1k = 1;
-	}
-}
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x1460, quirk_p64h2_1k_io);
-
 /*
  * Under some circumstances, AER is not linked with extended capabilities.
  * Force it to be linked by setting the corresponding control bit in the
@@ -2661,26 +2286,6 @@ DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_BROADCOM,
 			 PCI_DEVICE_ID_TIGON3_5719,
 			 quirk_brcm_5719_limit_mrrs);
 
-/*
- * Originally in EDAC sources for i82875P: Intel tells BIOS developers to
- * hide device 6 which configures the overflow device access containing the
- * DRBs - this is where we expose device 6.
- * http://www.x86-secret.com/articles/tweak/pat/patsecrets-2.htm
- */
-static void quirk_unhide_mch_dev6(struct pci_dev *dev)
-{
-	u8 reg;
-
-	if (pci_read_config_byte(dev, 0xF4, &reg) == 0 && !(reg & 0x02)) {
-		pci_info(dev, "Enabling MCH 'Overflow' Device\n");
-		pci_write_config_byte(dev, 0xF4, reg | 0x02);
-	}
-}
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82865_HB,
-			quirk_unhide_mch_dev6);
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82875_HB,
-			quirk_unhide_mch_dev6);
-
 #ifdef CONFIG_PCI_MSI
 /*
  * Some chipsets do not support MSI. We cannot easily rely on setting
@@ -3436,173 +3041,6 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SOLARFLARE,
 			PCI_DEVICE_ID_SOLARFLARE_SFC4000B, fixup_mpss_256);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_ASMEDIA, 0x0612, fixup_mpss_256);
 
-/*
- * Intel 5000 and 5100 Memory controllers have an erratum with read completion
- * coalescing (which is enabled by default on some BIOSes) and MPS of 256B.
- * Since there is no way of knowing what the PCIe MPS on each fabric will be
- * until all of the devices are discovered and buses walked, read completion
- * coalescing must be disabled.  Unfortunately, it cannot be re-enabled because
- * it is possible to hotplug a device with MPS of 256B.
- */
-static void quirk_intel_mc_errata(struct pci_dev *dev)
-{
-	int err;
-	u16 rcc;
-
-	if (pcie_bus_config == PCIE_BUS_TUNE_OFF ||
-	    pcie_bus_config == PCIE_BUS_DEFAULT)
-		return;
-
-	/*
-	 * Intel erratum specifies bits to change but does not say what
-	 * they are.  Keeping them magical until such time as the registers
-	 * and values can be explained.
-	 */
-	err = pci_read_config_word(dev, 0x48, &rcc);
-	if (err) {
-		pci_err(dev, "Error attempting to read the read completion coalescing register\n");
-		return;
-	}
-
-	if (!(rcc & (1 << 10)))
-		return;
-
-	rcc &= ~(1 << 10);
-
-	err = pci_write_config_word(dev, 0x48, rcc);
-	if (err) {
-		pci_err(dev, "Error attempting to write the read completion coalescing register\n");
-		return;
-	}
-
-	pr_info_once("Read completion coalescing disabled due to hardware erratum relating to 256B MPS\n");
-}
-/* Intel 5000 series memory controllers and ports 2-7 */
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x25c0, quirk_intel_mc_errata);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x25d0, quirk_intel_mc_errata);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x25d4, quirk_intel_mc_errata);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x25d8, quirk_intel_mc_errata);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x25e2, quirk_intel_mc_errata);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x25e3, quirk_intel_mc_errata);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x25e4, quirk_intel_mc_errata);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x25e5, quirk_intel_mc_errata);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x25e6, quirk_intel_mc_errata);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x25e7, quirk_intel_mc_errata);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x25f7, quirk_intel_mc_errata);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x25f8, quirk_intel_mc_errata);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x25f9, quirk_intel_mc_errata);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x25fa, quirk_intel_mc_errata);
-/* Intel 5100 series memory controllers and ports 2-7 */
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x65c0, quirk_intel_mc_errata);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x65e2, quirk_intel_mc_errata);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x65e3, quirk_intel_mc_errata);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x65e4, quirk_intel_mc_errata);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x65e5, quirk_intel_mc_errata);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x65e6, quirk_intel_mc_errata);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x65e7, quirk_intel_mc_errata);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x65f7, quirk_intel_mc_errata);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x65f8, quirk_intel_mc_errata);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x65f9, quirk_intel_mc_errata);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x65fa, quirk_intel_mc_errata);
-
-/*
- * Ivytown NTB BAR sizes are misreported by the hardware due to an erratum.
- * To work around this, query the size it should be configured to by the
- * device and modify the resource end to correspond to this new size.
- */
-static void quirk_intel_ntb(struct pci_dev *dev)
-{
-	int rc;
-	u8 val;
-
-	rc = pci_read_config_byte(dev, 0x00D0, &val);
-	if (rc)
-		return;
-
-	resource_set_size(&dev->resource[2], (resource_size_t)1 << val);
-
-	rc = pci_read_config_byte(dev, 0x00D1, &val);
-	if (rc)
-		return;
-
-	resource_set_size(&dev->resource[4], (resource_size_t)1 << val);
-}
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x0e08, quirk_intel_ntb);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x0e0d, quirk_intel_ntb);
-
-/*
- * Some BIOS implementations leave the Intel GPU interrupts enabled, even
- * though no one is handling them (e.g., if the i915 driver is never
- * loaded).  Additionally the interrupt destination is not set up properly
- * and the interrupt ends up -somewhere-.
- *
- * These spurious interrupts are "sticky" and the kernel disables the
- * (shared) interrupt line after 100,000+ generated interrupts.
- *
- * Fix it by disabling the still enabled interrupts.  This resolves crashes
- * often seen on monitor unplug.
- */
-#define I915_DEIER_REG 0x4400c
-static void disable_igfx_irq(struct pci_dev *dev)
-{
-	void __iomem *regs = pci_iomap(dev, 0, 0);
-	if (regs == NULL) {
-		pci_warn(dev, "igfx quirk: Can't iomap PCI device\n");
-		return;
-	}
-
-	/* Check if any interrupt line is still enabled */
-	if (readl(regs + I915_DEIER_REG) != 0) {
-		pci_warn(dev, "BIOS left Intel GPU interrupts enabled; disabling\n");
-
-		writel(0, regs + I915_DEIER_REG);
-	}
-
-	pci_iounmap(dev, regs);
-}
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0042, disable_igfx_irq);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0046, disable_igfx_irq);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x004a, disable_igfx_irq);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0102, disable_igfx_irq);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0106, disable_igfx_irq);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x010a, disable_igfx_irq);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0152, disable_igfx_irq);
-
-/*
- * PCI devices which are on Intel chips can skip the 10ms delay
- * before entering D3 mode.
- */
-static void quirk_remove_d3hot_delay(struct pci_dev *dev)
-{
-	dev->d3hot_delay = 0;
-}
-/* C600 Series devices do not need 10ms d3hot_delay */
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0412, quirk_remove_d3hot_delay);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0c00, quirk_remove_d3hot_delay);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0c0c, quirk_remove_d3hot_delay);
-/* Lynxpoint-H PCH devices do not need 10ms d3hot_delay */
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x8c02, quirk_remove_d3hot_delay);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x8c18, quirk_remove_d3hot_delay);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x8c1c, quirk_remove_d3hot_delay);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x8c20, quirk_remove_d3hot_delay);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x8c22, quirk_remove_d3hot_delay);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x8c26, quirk_remove_d3hot_delay);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x8c2d, quirk_remove_d3hot_delay);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x8c31, quirk_remove_d3hot_delay);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x8c3a, quirk_remove_d3hot_delay);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x8c3d, quirk_remove_d3hot_delay);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x8c4e, quirk_remove_d3hot_delay);
-/* Intel Cherrytrail devices do not need 10ms d3hot_delay */
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x2280, quirk_remove_d3hot_delay);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x2298, quirk_remove_d3hot_delay);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x229c, quirk_remove_d3hot_delay);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x22b0, quirk_remove_d3hot_delay);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x22b5, quirk_remove_d3hot_delay);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x22b7, quirk_remove_d3hot_delay);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x22b8, quirk_remove_d3hot_delay);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x22d8, quirk_remove_d3hot_delay);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x22dc, quirk_remove_d3hot_delay);
-
 /*
  * Some devices may pass our check in pci_intx_mask_supported() if
  * PCI_COMMAND_INTX_DISABLE works though they actually do not properly
@@ -6270,16 +5708,6 @@ static void nvidia_ion_ahci_fixup(struct pci_dev *pdev)
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA, 0x0ab8, nvidia_ion_ahci_fixup);
 
-static void rom_bar_overlap_defect(struct pci_dev *dev)
-{
-	pci_info(dev, "working around ROM BAR overlap defect\n");
-	dev->rom_bar_overlap = 1;
-}
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1533, rom_bar_overlap_defect);
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1536, rom_bar_overlap_defect);
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1537, rom_bar_overlap_defect);
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1538, rom_bar_overlap_defect);
-
 #ifdef CONFIG_PCIEASPM
 /*
  * Several Intel DG2 graphics devices advertise that they can only tolerate
-- 
2.55.0

