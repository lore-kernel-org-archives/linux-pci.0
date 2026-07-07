Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980083DC4CF
	for <linux-pci@vger.kernel.org>; Tue,  7 Jul 2026 22:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783462697; cv=none; b=tf3FJVw5AJAxIMkwh1VX0ax1LRmrMEgSlDPuUL91Sj45z4zn5WJjPJOxYpVVjZfodGrdhrLByx2u4qYLBkYZuugLMfzdt9R3iC+dud7+t0l+SZiwMM/pdzPUasMCt5hJb71ttn1tqvTEppcuz6aPSVLqzdz9vaedRnYI6P0aPsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783462697; c=relaxed/simple;
	bh=bnqxE8X4pvPf3GSD+Y9zZCa+4NQJqpz1X+1Wxx0EE6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L2VWE1qnzEnvImqSwDnQ7y0ZJlB06yWq8T722gDpYIy61bBhbKNbuI3witHFcmaou8553SqbfcVYVrHFovbzVK5OtrOypywbAdH2XnzdJv7p6ORtC8e9zXAmqKepJi6DdIBw/ixG33A3LtUn+MqKwmiygewJqFW4lJU+wk4wbjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OEMETOTQ; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OEMETOTQ"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-846970f0acaso25201b3a.3
        for <linux-pci@vger.kernel.org>; Tue, 07 Jul 2026 15:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783462693; x=1784067493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WVWxj0Lz3Qf1eVCjdWkT92JWj4kCZ6n8ZhLiEatqE1E=;
        b=OEMETOTQ8+j7IG0udADZOYgm1F/92qLoZHx5+kFUPK9Kzq58YC7nuBsZKG+VZLveKM
         MJ/fQ9tDBBJ1Nq0R4KbWE4nVOtrCtGnLKRwk5QEAcUJoBSSSJQdxSIwSnIIg2z0keAdC
         nIvafC6RXuZpl7YR3IfEoeeEJtxABMq5GGl4QcYx235W/gaFXHy5WSvCvNGJqqi75XEI
         3KilHzg1YeOBiAzCMtarMsp9MhVzriTWcvc8juWb4Su8qfY6u3i9deJmNWGf7Nn+3kzy
         rFrJK9PWy8lhClioPq/hNzF68vgcYeHREyrjfJSSpWq2X0Ha7uQ2sYTL8V6hnnlBfuZt
         IQSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783462693; x=1784067493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WVWxj0Lz3Qf1eVCjdWkT92JWj4kCZ6n8ZhLiEatqE1E=;
        b=p9XAjQSeg8JSDD8ev71u0sr0K2nvriatk0JZY9LKx28/nD8ankOapMOKqgAwSxb8ea
         NYeC9O1o6VS3y3qrSglZRW1uKiJyEPPIpmNlfrwjs/w3vuJyXxQ3j990nU9RP3MYoxKn
         m+hE26EqaO8PqQDKCRRtF+T0RUJx9hM+iky3QaDd7r5m8FOF2HX1lqpamHU6gijod6r+
         GlmiIg24GFdgUi5VZgna2XS7TRIsIU/NxRXIn4MH3jKPFC0/Z0rJkdx8KEQOzBMTLgyN
         /TKfgRiPXFHf0Wo2iw2jrDfvHvYb6WLy7yK6fZsxSUuOHtQnlQD0nhuV8qGDdQ7ufmH1
         qiJA==
X-Gm-Message-State: AOJu0Yz4JeDTD/PHEJ3AoGLgCBI3ZYoiSeiUa+e9qYNibgyy3o37B9rw
	XttIPd5RGKifMZfsqohqLAbm+e8shBRvIvlhKORMWzc4Ux+TOUa2UiqsksIdqI+F
X-Gm-Gg: AfdE7cljLzoZFLtcMoV35ueDrZUeztMkBTXX0IOo5mOQE3/R7E3PPzKkCYtErUCjYYs
	d+/7yW0SDEtyQD3SRDBVq9nZRnhfWr7GuHEJdFG1vqI0JrBdYWk6YsYg1txpynEDQQK8Q7+KEx5
	okK9MVWloazG5xu0Cpv2tSlX/Z95boQrlJ+vjZhCT+ZCcD/mzbZ2dID9H680Y+T7LxJ5GDI/NlT
	t4aeYhdW9lF3wq3Ohl+mmrICBpC0J4lRPf6eRkLyuLRCUx1AmkiycpGinOeeD89jtE83raEQzHj
	LCjmuH3z9VCQlQDutra/4A1XJt1lGeP3xUPt+XUknqrQgSaEE6KpELnYdQIec3CS37YMgn34xLq
	+yPboSKW4OlqACnuggIOc329j3XxLNZJPyy7ZIcQkLp7JmqrUhzi3W4EZ2H63SzqtavtjlN3yvp
	8X1Jld6xwbCqbZzDxtMCDfMCdMz1QEugoLrvQt8/OyPC6o63ezCrY8yFfK33kH8Ydf/We73ZV/Y
	cjvZUHPvg==
X-Received: by 2002:a05:6a00:338c:b0:845:d274:bf9d with SMTP id d2e1a72fcca58-848430040f1mr25336b3a.52.1783462692652;
        Tue, 07 Jul 2026 15:18:12 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6b9b389sm6180281b3a.13.2026.07.07.15.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 15:18:11 -0700 (PDT)
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
Subject: [PATCH 7/8] x86/pci: move x86 ifdef-gated quirks to arch/x86/pci/fixup.c
Date: Tue,  7 Jul 2026 15:17:59 -0700
Message-ID: <20260707221800.920270-8-rosenp@gmail.com>
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

Move PCI quirk handlers guarded by CONFIG_X86_32 or CONFIG_X86_IO_APIC
from drivers/pci/quirks.c to arch/x86/pci/fixup.c:

- ISA DMA hang workaround (quirk_isa_dma_hangs) under CONFIG_X86_32
- VIA 686A/B IO-APIC routing (quirk_via_ioapic)
- VIA 8237 APIC deassert bypass (quirk_via_vt8237_bypass_apic_deassert)
- AMD IO-APIC erratum (quirk_amd_ioapic)
- Intel EESSC IO-APIC BAR fix (quirk_alder_ioapic)
- Boot interrupt reroute for Intel chipsets
  (quirk_reroute_to_boot_interrupts_intel,
   dmi_disable_ioapicreroute, boot_interrupt_dmi_table)
- Boot interrupt disable for Intel (quirk_disable_intel_boot_interrupt),
  Broadcom HT-1000 (quirk_disable_broadcom_boot_interrupt),
  AMD 813x (quirk_disable_amd_813x_boot_interrupt),
  and AMD 8111 (quirk_disable_amd_8111_boot_interrupt)

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 arch/x86/pci/fixup.c | 363 ++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/quirks.c | 364 -------------------------------------------
 2 files changed, 363 insertions(+), 364 deletions(-)

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index f1965cb4f28f..daeabca290a3 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -6,6 +6,7 @@
 #include <linux/bitfield.h>
 #include <linux/delay.h>
 #include <linux/dmi.h>
+#include <linux/isa-dma.h> /* isa_dma_bridge_buggy */
 #include <linux/pci.h>
 #include <linux/suspend.h>
 #include <linux/vgaarb.h>
@@ -2228,3 +2229,365 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_HUDSON2_SATA_IDE,
 DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_HUDSON2_SATA_IDE, quirk_amd_ide_mode);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, 0x7900, quirk_amd_ide_mode);
 DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_AMD, 0x7900, quirk_amd_ide_mode);
+
+#ifdef CONFIG_X86_32
+/*
+ * The VIA VP2/VP3/MVP3 seem to have some 'features'. There may be a
+ * workaround but VIA don't answer queries. If you happen to have good
+ * contacts at VIA ask them for me please -- Alan
+ *
+ * This appears to be BIOS not version dependent. So presumably there is a
+ * chipset level fix.
+ */
+static void quirk_isa_dma_hangs(struct pci_dev *dev)
+{
+	if (!isa_dma_bridge_buggy) {
+		isa_dma_bridge_buggy = 1;
+		pci_info(dev, "Activating ISA DMA hang workarounds\n");
+	}
+}
+/*
+ * It's not totally clear which chipsets are the problematic ones.  We know
+ * 82C586 and 82C596 variants are affected.
+ */
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C586_0,	quirk_isa_dma_hangs);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C596,	quirk_isa_dma_hangs);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82371SB_0,  quirk_isa_dma_hangs);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AL,	PCI_DEVICE_ID_AL_M1533,		quirk_isa_dma_hangs);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NEC,	PCI_DEVICE_ID_NEC_CBUS_1,	quirk_isa_dma_hangs);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NEC,	PCI_DEVICE_ID_NEC_CBUS_2,	quirk_isa_dma_hangs);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NEC,	PCI_DEVICE_ID_NEC_CBUS_3,	quirk_isa_dma_hangs);
+#endif
+
+#ifdef CONFIG_X86_IO_APIC
+
+#include <asm/io_apic.h>
+
+/*
+ * VIA 686A/B: If an IO-APIC is active, we need to route all on-chip
+ * devices to the external APIC.
+ *
+ * TODO: When we have device-specific interrupt routers, this code will go
+ * away from quirks.
+ */
+static void quirk_via_ioapic(struct pci_dev *dev)
+{
+	u8 tmp;
+
+	if (nr_ioapics < 1)
+		tmp = 0;    /* nothing routed to external APIC */
+	else
+		tmp = 0x1f; /* all known bits (4-0) routed to external APIC */
+
+	pci_info(dev, "%s VIA external APIC routing\n",
+		 tmp ? "Enabling" : "Disabling");
+
+	/* Offset 0x58: External APIC IRQ output control */
+	pci_write_config_byte(dev, 0x58, tmp);
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686,	quirk_via_ioapic);
+DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686,	quirk_via_ioapic);
+
+/*
+ * VIA 8237: Some BIOSes don't set the 'Bypass APIC De-Assert Message' Bit.
+ * This leads to doubled level interrupt rates.
+ * Set this bit to get rid of cycle wastage.
+ * Otherwise uncritical.
+ */
+static void quirk_via_vt8237_bypass_apic_deassert(struct pci_dev *dev)
+{
+	u8 misc_control2;
+#define BYPASS_APIC_DEASSERT 8
+
+	pci_read_config_byte(dev, 0x5B, &misc_control2);
+	if (!(misc_control2 & BYPASS_APIC_DEASSERT)) {
+		pci_info(dev, "Bypassing VIA 8237 APIC De-Assert Message\n");
+		pci_write_config_byte(dev, 0x5B, misc_control2|BYPASS_APIC_DEASSERT);
+	}
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8237,		quirk_via_vt8237_bypass_apic_deassert);
+DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8237,		quirk_via_vt8237_bypass_apic_deassert);
+
+/*
+ * The AMD IO-APIC can hang the box when an APIC IRQ is masked.
+ * We check all revs >= B0 (yet not in the pre production!) as the bug
+ * is currently marked NoFix
+ *
+ * We have multiple reports of hangs with this chipset that went away with
+ * noapic specified. For the moment we assume it's the erratum. We may be wrong
+ * of course. However the advice is demonstrably good even if so.
+ */
+static void quirk_amd_ioapic(struct pci_dev *dev)
+{
+	if (dev->revision >= 0x02) {
+		pci_warn(dev, "I/O APIC: AMD Erratum #22 may be present. In the event of instability try\n");
+		pci_warn(dev, "        : booting with the \"noapic\" option\n");
+	}
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_VIPER_7410,	quirk_amd_ioapic);
+
+/*
+ * Intel EESSC IO-APIC devices have bogus BARs, fix them up.
+ */
+static void quirk_alder_ioapic(struct pci_dev *pdev)
+{
+	int i;
+
+	if ((pdev->class >> 8) != 0xff00)
+		return;
+
+	/*
+	 * The first BAR is the location of the IO-APIC... we must
+	 * not touch this (and it's already covered by the fixmap), so
+	 * forcibly insert it into the resource tree.
+	 */
+	if (pci_resource_start(pdev, 0) && pci_resource_len(pdev, 0))
+		insert_resource(&iomem_resource, &pdev->resource[0]);
+
+	/*
+	 * The next five BARs all seem to be rubbish, so just clean
+	 * them out.
+	 */
+	for (i = 1; i < PCI_STD_NUM_BARS; i++)
+		memset(&pdev->resource[i], 0, sizeof(pdev->resource[i]));
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_EESSC,	quirk_alder_ioapic);
+
+static int dmi_disable_ioapicreroute(const struct dmi_system_id *d)
+{
+	noioapicreroute = 1;
+	pr_info("%s detected: disable boot interrupt reroute\n", d->ident);
+
+	return 0;
+}
+
+static const struct dmi_system_id boot_interrupt_dmi_table[] = {
+	/*
+	 * Systems to exclude from boot interrupt reroute quirks
+	 */
+	{
+		.callback = dmi_disable_ioapicreroute,
+		.ident = "ASUSTek Computer INC. M2N-LR",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTek Computer INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "M2N-LR"),
+		},
+	},
+	{}
+};
+
+/*
+ * Boot interrupts on some chipsets cannot be turned off. For these chipsets,
+ * remap the original interrupt in the Linux kernel to the boot interrupt, so
+ * that a PCI device's interrupt handler is installed on the boot interrupt
+ * line instead.
+ */
+static void quirk_reroute_to_boot_interrupts_intel(struct pci_dev *dev)
+{
+	dmi_check_system(boot_interrupt_dmi_table);
+	if (noioapicquirk || noioapicreroute)
+		return;
+
+	dev->irq_reroute_variant = INTEL_IRQ_REROUTE_VARIANT;
+	pci_info(dev, "rerouting interrupts for [%04x:%04x]\n",
+		 dev->vendor, dev->device);
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_80333_0,	quirk_reroute_to_boot_interrupts_intel);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_80333_1,	quirk_reroute_to_boot_interrupts_intel);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ESB2_0,	quirk_reroute_to_boot_interrupts_intel);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_PXH_0,	quirk_reroute_to_boot_interrupts_intel);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_PXH_1,	quirk_reroute_to_boot_interrupts_intel);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_PXHV,	quirk_reroute_to_boot_interrupts_intel);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_80332_0,	quirk_reroute_to_boot_interrupts_intel);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_80332_1,	quirk_reroute_to_boot_interrupts_intel);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_80333_0,	quirk_reroute_to_boot_interrupts_intel);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_80333_1,	quirk_reroute_to_boot_interrupts_intel);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ESB2_0,	quirk_reroute_to_boot_interrupts_intel);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_PXH_0,	quirk_reroute_to_boot_interrupts_intel);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_PXH_1,	quirk_reroute_to_boot_interrupts_intel);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_PXHV,	quirk_reroute_to_boot_interrupts_intel);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_80332_0,	quirk_reroute_to_boot_interrupts_intel);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_80332_1,	quirk_reroute_to_boot_interrupts_intel);
+
+/*
+ * On some chipsets we can disable the generation of legacy INTx boot
+ * interrupts.
+ */
+
+/*
+ * IO-APIC1 on 6300ESB generates boot interrupts, see Intel order no
+ * 300641-004US, section 5.7.3.
+ *
+ * Core IO on Xeon E5 1600/2600/4600, see Intel order no 326509-003.
+ * Core IO on Xeon E5 v2, see Intel order no 329188-003.
+ * Core IO on Xeon E7 v2, see Intel order no 329595-002.
+ * Core IO on Xeon E5 v3, see Intel order no 330784-003.
+ * Core IO on Xeon E7 v3, see Intel order no 332315-001US.
+ * Core IO on Xeon E5 v4, see Intel order no 333810-002US.
+ * Core IO on Xeon E7 v4, see Intel order no 332315-001US.
+ * Core IO on Xeon D-1500, see Intel order no 332051-001.
+ * Core IO on Xeon Scalable, see Intel order no 610950.
+ */
+#define INTEL_6300_IOAPIC_ABAR		0x40	/* Bus 0, Dev 29, Func 5 */
+#define INTEL_6300_DISABLE_BOOT_IRQ	(1<<14)
+
+#define INTEL_CIPINTRC_CFG_OFFSET	0x14C	/* Bus 0, Dev 5, Func 0 */
+#define INTEL_CIPINTRC_DIS_INTX_ICH	(1<<25)
+
+static void quirk_disable_intel_boot_interrupt(struct pci_dev *dev)
+{
+	u16 pci_config_word;
+	u32 pci_config_dword;
+
+	if (noioapicquirk)
+		return;
+
+	switch (dev->device) {
+	case PCI_DEVICE_ID_INTEL_ESB_10:
+		pci_read_config_word(dev, INTEL_6300_IOAPIC_ABAR,
+				     &pci_config_word);
+		pci_config_word |= INTEL_6300_DISABLE_BOOT_IRQ;
+		pci_write_config_word(dev, INTEL_6300_IOAPIC_ABAR,
+				      pci_config_word);
+		break;
+	case 0x3c28:	/* Xeon E5 1600/2600/4600	*/
+	case 0x0e28:	/* Xeon E5/E7 V2		*/
+	case 0x2f28:	/* Xeon E5/E7 V3,V4		*/
+	case 0x6f28:	/* Xeon D-1500			*/
+	case 0x2034:	/* Xeon Scalable Family		*/
+		pci_read_config_dword(dev, INTEL_CIPINTRC_CFG_OFFSET,
+				      &pci_config_dword);
+		pci_config_dword |= INTEL_CIPINTRC_DIS_INTX_ICH;
+		pci_write_config_dword(dev, INTEL_CIPINTRC_CFG_OFFSET,
+				       pci_config_dword);
+		break;
+	default:
+		return;
+	}
+	pci_info(dev, "disabled boot interrupts on device [%04x:%04x]\n",
+		 dev->vendor, dev->device);
+}
+/*
+ * Device 29 Func 5 Device IDs of IO-APIC
+ * containing ABAR--APIC1 Alternate Base Address Register
+ */
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ESB_10,
+		quirk_disable_intel_boot_interrupt);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ESB_10,
+		quirk_disable_intel_boot_interrupt);
+
+/*
+ * Device 5 Func 0 Device IDs of Core IO modules/hubs
+ * containing Coherent Interface Protocol Interrupt Control
+ *
+ * Device IDs obtained from volume 2 datasheets of commented
+ * families above.
+ */
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	0x3c28,
+		quirk_disable_intel_boot_interrupt);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	0x0e28,
+		quirk_disable_intel_boot_interrupt);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	0x2f28,
+		quirk_disable_intel_boot_interrupt);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	0x6f28,
+		quirk_disable_intel_boot_interrupt);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	0x2034,
+		quirk_disable_intel_boot_interrupt);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL,	0x3c28,
+		quirk_disable_intel_boot_interrupt);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL,	0x0e28,
+		quirk_disable_intel_boot_interrupt);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL,	0x2f28,
+		quirk_disable_intel_boot_interrupt);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL,	0x6f28,
+		quirk_disable_intel_boot_interrupt);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL,	0x2034,
+		quirk_disable_intel_boot_interrupt);
+
+/* Disable boot interrupts on HT-1000 */
+#define BC_HT1000_FEATURE_REG		0x64
+#define BC_HT1000_PIC_REGS_ENABLE	(1<<0)
+#define BC_HT1000_MAP_IDX		0xC00
+#define BC_HT1000_MAP_DATA		0xC01
+
+static void quirk_disable_broadcom_boot_interrupt(struct pci_dev *dev)
+{
+	u32 pci_config_dword;
+	u8 irq;
+
+	if (noioapicquirk)
+		return;
+
+	pci_read_config_dword(dev, BC_HT1000_FEATURE_REG, &pci_config_dword);
+	pci_write_config_dword(dev, BC_HT1000_FEATURE_REG, pci_config_dword |
+			BC_HT1000_PIC_REGS_ENABLE);
+
+	for (irq = 0x10; irq < 0x10 + 32; irq++) {
+		outb(irq, BC_HT1000_MAP_IDX);
+		outb(0x00, BC_HT1000_MAP_DATA);
+	}
+
+	pci_write_config_dword(dev, BC_HT1000_FEATURE_REG, pci_config_dword);
+
+	pci_info(dev, "disabled boot interrupts on device [%04x:%04x]\n",
+		 dev->vendor, dev->device);
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SERVERWORKS,   PCI_DEVICE_ID_SERVERWORKS_HT1000SB,	quirk_disable_broadcom_boot_interrupt);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_SERVERWORKS,   PCI_DEVICE_ID_SERVERWORKS_HT1000SB,	quirk_disable_broadcom_boot_interrupt);
+
+/* Disable boot interrupts on AMD and ATI chipsets */
+
+/*
+ * NOIOAMODE needs to be disabled to disable "boot interrupts". For AMD 8131
+ * rev. A0 and B0, NOIOAMODE needs to be disabled anyway to fix IO-APIC mode
+ * (due to an erratum).
+ */
+#define AMD_813X_MISC			0x40
+#define AMD_813X_NOIOAMODE		(1<<0)
+#define AMD_813X_REV_B1			0x12
+#define AMD_813X_REV_B2			0x13
+
+static void quirk_disable_amd_813x_boot_interrupt(struct pci_dev *dev)
+{
+	u32 pci_config_dword;
+
+	if (noioapicquirk)
+		return;
+	if ((dev->revision == AMD_813X_REV_B1) ||
+	    (dev->revision == AMD_813X_REV_B2))
+		return;
+
+	pci_read_config_dword(dev, AMD_813X_MISC, &pci_config_dword);
+	pci_config_dword &= ~AMD_813X_NOIOAMODE;
+	pci_write_config_dword(dev, AMD_813X_MISC, pci_config_dword);
+
+	pci_info(dev, "disabled boot interrupts on device [%04x:%04x]\n",
+		 dev->vendor, dev->device);
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_8131_BRIDGE,	quirk_disable_amd_813x_boot_interrupt);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_8131_BRIDGE,	quirk_disable_amd_813x_boot_interrupt);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_8132_BRIDGE,	quirk_disable_amd_813x_boot_interrupt);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_8132_BRIDGE,	quirk_disable_amd_813x_boot_interrupt);
+
+#define AMD_8111_PCI_IRQ_ROUTING	0x56
+
+static void quirk_disable_amd_8111_boot_interrupt(struct pci_dev *dev)
+{
+	u16 pci_config_word;
+
+	if (noioapicquirk)
+		return;
+
+	pci_read_config_word(dev, AMD_8111_PCI_IRQ_ROUTING, &pci_config_word);
+	if (!pci_config_word) {
+		pci_info(dev, "boot interrupts on device [%04x:%04x] already disabled\n",
+			 dev->vendor, dev->device);
+		return;
+	}
+	pci_write_config_word(dev, AMD_8111_PCI_IRQ_ROUTING, 0);
+	pci_info(dev, "disabled boot interrupts on device [%04x:%04x]\n",
+		 dev->vendor, dev->device);
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD,   PCI_DEVICE_ID_AMD_8111_SMBUS,	quirk_disable_amd_8111_boot_interrupt);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD,   PCI_DEVICE_ID_AMD_8111_SMBUS,	quirk_disable_amd_8111_boot_interrupt);
+#endif /* CONFIG_X86_IO_APIC */
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index b504c2636f73..146465404a97 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -19,7 +19,6 @@
 #include <linux/kernel.h>
 #include <linux/export.h>
 #include <linux/pci.h>
-#include <linux/isa-dma.h> /* isa_dma_bridge_buggy */
 #include <linux/init.h>
 #include <linux/iommu.h>
 #include <linux/delay.h>
@@ -311,35 +310,6 @@ DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_ANY_ID, PCI_ANY_ID,
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MELLANOX, PCI_DEVICE_ID_MELLANOX_TAVOR, pci_disable_parity);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MELLANOX, PCI_DEVICE_ID_MELLANOX_TAVOR_BRIDGE, pci_disable_parity);
 
-#ifdef CONFIG_X86_32
-/*
- * The VIA VP2/VP3/MVP3 seem to have some 'features'. There may be a
- * workaround but VIA don't answer queries. If you happen to have good
- * contacts at VIA ask them for me please -- Alan
- *
- * This appears to be BIOS not version dependent. So presumably there is a
- * chipset level fix.
- */
-static void quirk_isa_dma_hangs(struct pci_dev *dev)
-{
-	if (!isa_dma_bridge_buggy) {
-		isa_dma_bridge_buggy = 1;
-		pci_info(dev, "Activating ISA DMA hang workarounds\n");
-	}
-}
-/*
- * It's not totally clear which chipsets are the problematic ones.  We know
- * 82C586 and 82C596 variants are affected.
- */
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C586_0,	quirk_isa_dma_hangs);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C596,	quirk_isa_dma_hangs);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82371SB_0,  quirk_isa_dma_hangs);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AL,	PCI_DEVICE_ID_AL_M1533,		quirk_isa_dma_hangs);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NEC,	PCI_DEVICE_ID_NEC_CBUS_1,	quirk_isa_dma_hangs);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NEC,	PCI_DEVICE_ID_NEC_CBUS_2,	quirk_isa_dma_hangs);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NEC,	PCI_DEVICE_ID_NEC_CBUS_3,	quirk_isa_dma_hangs);
-#endif
-
 #ifdef CONFIG_HAS_IOPORT
 /*
  * Intel NM10 "Tiger Point" LPC PM1a_STS.BM_STS must be clear
@@ -505,74 +475,6 @@ static void quirk_xio2000a(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_XIO2000A,
 			quirk_xio2000a);
 
-#ifdef CONFIG_X86_IO_APIC
-
-#include <asm/io_apic.h>
-
-/*
- * VIA 686A/B: If an IO-APIC is active, we need to route all on-chip
- * devices to the external APIC.
- *
- * TODO: When we have device-specific interrupt routers, this code will go
- * away from quirks.
- */
-static void quirk_via_ioapic(struct pci_dev *dev)
-{
-	u8 tmp;
-
-	if (nr_ioapics < 1)
-		tmp = 0;    /* nothing routed to external APIC */
-	else
-		tmp = 0x1f; /* all known bits (4-0) routed to external APIC */
-
-	pci_info(dev, "%s VIA external APIC routing\n",
-		 tmp ? "Enabling" : "Disabling");
-
-	/* Offset 0x58: External APIC IRQ output control */
-	pci_write_config_byte(dev, 0x58, tmp);
-}
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686,	quirk_via_ioapic);
-DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686,	quirk_via_ioapic);
-
-/*
- * VIA 8237: Some BIOSes don't set the 'Bypass APIC De-Assert Message' Bit.
- * This leads to doubled level interrupt rates.
- * Set this bit to get rid of cycle wastage.
- * Otherwise uncritical.
- */
-static void quirk_via_vt8237_bypass_apic_deassert(struct pci_dev *dev)
-{
-	u8 misc_control2;
-#define BYPASS_APIC_DEASSERT 8
-
-	pci_read_config_byte(dev, 0x5B, &misc_control2);
-	if (!(misc_control2 & BYPASS_APIC_DEASSERT)) {
-		pci_info(dev, "Bypassing VIA 8237 APIC De-Assert Message\n");
-		pci_write_config_byte(dev, 0x5B, misc_control2|BYPASS_APIC_DEASSERT);
-	}
-}
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8237,		quirk_via_vt8237_bypass_apic_deassert);
-DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8237,		quirk_via_vt8237_bypass_apic_deassert);
-
-/*
- * The AMD IO-APIC can hang the box when an APIC IRQ is masked.
- * We check all revs >= B0 (yet not in the pre production!) as the bug
- * is currently marked NoFix
- *
- * We have multiple reports of hangs with this chipset that went away with
- * noapic specified. For the moment we assume it's the erratum. We may be wrong
- * of course. However the advice is demonstrably good even if so.
- */
-static void quirk_amd_ioapic(struct pci_dev *dev)
-{
-	if (dev->revision >= 0x02) {
-		pci_warn(dev, "I/O APIC: AMD Erratum #22 may be present. In the event of instability try\n");
-		pci_warn(dev, "        : booting with the \"noapic\" option\n");
-	}
-}
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_VIPER_7410,	quirk_amd_ioapic);
-#endif /* CONFIG_X86_IO_APIC */
-
 #if defined(CONFIG_ARM64) && defined(CONFIG_PCI_ATS)
 
 static void quirk_cavium_sriov_rnm_link(struct pci_dev *dev)
@@ -1022,32 +924,6 @@ DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, PCI_CLASS_STORA
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_JMICRON, 0x2362, quirk_jmicron_async_suspend);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_JMICRON, 0x236f, quirk_jmicron_async_suspend);
 
-#ifdef CONFIG_X86_IO_APIC
-static void quirk_alder_ioapic(struct pci_dev *pdev)
-{
-	int i;
-
-	if ((pdev->class >> 8) != 0xff00)
-		return;
-
-	/*
-	 * The first BAR is the location of the IO-APIC... we must
-	 * not touch this (and it's already covered by the fixmap), so
-	 * forcibly insert it into the resource tree.
-	 */
-	if (pci_resource_start(pdev, 0) && pci_resource_len(pdev, 0))
-		insert_resource(&iomem_resource, &pdev->resource[0]);
-
-	/*
-	 * The next five BARs all seem to be rubbish, so just clean
-	 * them out.
-	 */
-	for (i = 1; i < PCI_STD_NUM_BARS; i++)
-		memset(&pdev->resource[i], 0, sizeof(pdev->resource[i]));
-}
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_EESSC,	quirk_alder_ioapic);
-#endif
-
 static void quirk_no_msi(struct pci_dev *dev)
 {
 	pci_info(dev, "avoiding MSI to work around a hardware defect\n");
@@ -1203,246 +1079,6 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x15e0, quirk_ryzen_xhci_d3hot);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x15e1, quirk_ryzen_xhci_d3hot);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1639, quirk_ryzen_xhci_d3hot);
 
-#ifdef CONFIG_X86_IO_APIC
-static int dmi_disable_ioapicreroute(const struct dmi_system_id *d)
-{
-	noioapicreroute = 1;
-	pr_info("%s detected: disable boot interrupt reroute\n", d->ident);
-
-	return 0;
-}
-
-static const struct dmi_system_id boot_interrupt_dmi_table[] = {
-	/*
-	 * Systems to exclude from boot interrupt reroute quirks
-	 */
-	{
-		.callback = dmi_disable_ioapicreroute,
-		.ident = "ASUSTek Computer INC. M2N-LR",
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTek Computer INC."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "M2N-LR"),
-		},
-	},
-	{}
-};
-
-/*
- * Boot interrupts on some chipsets cannot be turned off. For these chipsets,
- * remap the original interrupt in the Linux kernel to the boot interrupt, so
- * that a PCI device's interrupt handler is installed on the boot interrupt
- * line instead.
- */
-static void quirk_reroute_to_boot_interrupts_intel(struct pci_dev *dev)
-{
-	dmi_check_system(boot_interrupt_dmi_table);
-	if (noioapicquirk || noioapicreroute)
-		return;
-
-	dev->irq_reroute_variant = INTEL_IRQ_REROUTE_VARIANT;
-	pci_info(dev, "rerouting interrupts for [%04x:%04x]\n",
-		 dev->vendor, dev->device);
-}
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_80333_0,	quirk_reroute_to_boot_interrupts_intel);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_80333_1,	quirk_reroute_to_boot_interrupts_intel);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ESB2_0,	quirk_reroute_to_boot_interrupts_intel);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_PXH_0,	quirk_reroute_to_boot_interrupts_intel);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_PXH_1,	quirk_reroute_to_boot_interrupts_intel);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_PXHV,	quirk_reroute_to_boot_interrupts_intel);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_80332_0,	quirk_reroute_to_boot_interrupts_intel);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_80332_1,	quirk_reroute_to_boot_interrupts_intel);
-DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_80333_0,	quirk_reroute_to_boot_interrupts_intel);
-DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_80333_1,	quirk_reroute_to_boot_interrupts_intel);
-DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ESB2_0,	quirk_reroute_to_boot_interrupts_intel);
-DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_PXH_0,	quirk_reroute_to_boot_interrupts_intel);
-DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_PXH_1,	quirk_reroute_to_boot_interrupts_intel);
-DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_PXHV,	quirk_reroute_to_boot_interrupts_intel);
-DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_80332_0,	quirk_reroute_to_boot_interrupts_intel);
-DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_80332_1,	quirk_reroute_to_boot_interrupts_intel);
-
-/*
- * On some chipsets we can disable the generation of legacy INTx boot
- * interrupts.
- */
-
-/*
- * IO-APIC1 on 6300ESB generates boot interrupts, see Intel order no
- * 300641-004US, section 5.7.3.
- *
- * Core IO on Xeon E5 1600/2600/4600, see Intel order no 326509-003.
- * Core IO on Xeon E5 v2, see Intel order no 329188-003.
- * Core IO on Xeon E7 v2, see Intel order no 329595-002.
- * Core IO on Xeon E5 v3, see Intel order no 330784-003.
- * Core IO on Xeon E7 v3, see Intel order no 332315-001US.
- * Core IO on Xeon E5 v4, see Intel order no 333810-002US.
- * Core IO on Xeon E7 v4, see Intel order no 332315-001US.
- * Core IO on Xeon D-1500, see Intel order no 332051-001.
- * Core IO on Xeon Scalable, see Intel order no 610950.
- */
-#define INTEL_6300_IOAPIC_ABAR		0x40	/* Bus 0, Dev 29, Func 5 */
-#define INTEL_6300_DISABLE_BOOT_IRQ	(1<<14)
-
-#define INTEL_CIPINTRC_CFG_OFFSET	0x14C	/* Bus 0, Dev 5, Func 0 */
-#define INTEL_CIPINTRC_DIS_INTX_ICH	(1<<25)
-
-static void quirk_disable_intel_boot_interrupt(struct pci_dev *dev)
-{
-	u16 pci_config_word;
-	u32 pci_config_dword;
-
-	if (noioapicquirk)
-		return;
-
-	switch (dev->device) {
-	case PCI_DEVICE_ID_INTEL_ESB_10:
-		pci_read_config_word(dev, INTEL_6300_IOAPIC_ABAR,
-				     &pci_config_word);
-		pci_config_word |= INTEL_6300_DISABLE_BOOT_IRQ;
-		pci_write_config_word(dev, INTEL_6300_IOAPIC_ABAR,
-				      pci_config_word);
-		break;
-	case 0x3c28:	/* Xeon E5 1600/2600/4600	*/
-	case 0x0e28:	/* Xeon E5/E7 V2		*/
-	case 0x2f28:	/* Xeon E5/E7 V3,V4		*/
-	case 0x6f28:	/* Xeon D-1500			*/
-	case 0x2034:	/* Xeon Scalable Family		*/
-		pci_read_config_dword(dev, INTEL_CIPINTRC_CFG_OFFSET,
-				      &pci_config_dword);
-		pci_config_dword |= INTEL_CIPINTRC_DIS_INTX_ICH;
-		pci_write_config_dword(dev, INTEL_CIPINTRC_CFG_OFFSET,
-				       pci_config_dword);
-		break;
-	default:
-		return;
-	}
-	pci_info(dev, "disabled boot interrupts on device [%04x:%04x]\n",
-		 dev->vendor, dev->device);
-}
-/*
- * Device 29 Func 5 Device IDs of IO-APIC
- * containing ABAR--APIC1 Alternate Base Address Register
- */
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ESB_10,
-		quirk_disable_intel_boot_interrupt);
-DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ESB_10,
-		quirk_disable_intel_boot_interrupt);
-
-/*
- * Device 5 Func 0 Device IDs of Core IO modules/hubs
- * containing Coherent Interface Protocol Interrupt Control
- *
- * Device IDs obtained from volume 2 datasheets of commented
- * families above.
- */
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	0x3c28,
-		quirk_disable_intel_boot_interrupt);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	0x0e28,
-		quirk_disable_intel_boot_interrupt);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	0x2f28,
-		quirk_disable_intel_boot_interrupt);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	0x6f28,
-		quirk_disable_intel_boot_interrupt);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	0x2034,
-		quirk_disable_intel_boot_interrupt);
-DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL,	0x3c28,
-		quirk_disable_intel_boot_interrupt);
-DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL,	0x0e28,
-		quirk_disable_intel_boot_interrupt);
-DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL,	0x2f28,
-		quirk_disable_intel_boot_interrupt);
-DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL,	0x6f28,
-		quirk_disable_intel_boot_interrupt);
-DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL,	0x2034,
-		quirk_disable_intel_boot_interrupt);
-
-/* Disable boot interrupts on HT-1000 */
-#define BC_HT1000_FEATURE_REG		0x64
-#define BC_HT1000_PIC_REGS_ENABLE	(1<<0)
-#define BC_HT1000_MAP_IDX		0xC00
-#define BC_HT1000_MAP_DATA		0xC01
-
-static void quirk_disable_broadcom_boot_interrupt(struct pci_dev *dev)
-{
-	u32 pci_config_dword;
-	u8 irq;
-
-	if (noioapicquirk)
-		return;
-
-	pci_read_config_dword(dev, BC_HT1000_FEATURE_REG, &pci_config_dword);
-	pci_write_config_dword(dev, BC_HT1000_FEATURE_REG, pci_config_dword |
-			BC_HT1000_PIC_REGS_ENABLE);
-
-	for (irq = 0x10; irq < 0x10 + 32; irq++) {
-		outb(irq, BC_HT1000_MAP_IDX);
-		outb(0x00, BC_HT1000_MAP_DATA);
-	}
-
-	pci_write_config_dword(dev, BC_HT1000_FEATURE_REG, pci_config_dword);
-
-	pci_info(dev, "disabled boot interrupts on device [%04x:%04x]\n",
-		 dev->vendor, dev->device);
-}
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SERVERWORKS,   PCI_DEVICE_ID_SERVERWORKS_HT1000SB,	quirk_disable_broadcom_boot_interrupt);
-DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_SERVERWORKS,   PCI_DEVICE_ID_SERVERWORKS_HT1000SB,	quirk_disable_broadcom_boot_interrupt);
-
-/* Disable boot interrupts on AMD and ATI chipsets */
-
-/*
- * NOIOAMODE needs to be disabled to disable "boot interrupts". For AMD 8131
- * rev. A0 and B0, NOIOAMODE needs to be disabled anyway to fix IO-APIC mode
- * (due to an erratum).
- */
-#define AMD_813X_MISC			0x40
-#define AMD_813X_NOIOAMODE		(1<<0)
-#define AMD_813X_REV_B1			0x12
-#define AMD_813X_REV_B2			0x13
-
-static void quirk_disable_amd_813x_boot_interrupt(struct pci_dev *dev)
-{
-	u32 pci_config_dword;
-
-	if (noioapicquirk)
-		return;
-	if ((dev->revision == AMD_813X_REV_B1) ||
-	    (dev->revision == AMD_813X_REV_B2))
-		return;
-
-	pci_read_config_dword(dev, AMD_813X_MISC, &pci_config_dword);
-	pci_config_dword &= ~AMD_813X_NOIOAMODE;
-	pci_write_config_dword(dev, AMD_813X_MISC, pci_config_dword);
-
-	pci_info(dev, "disabled boot interrupts on device [%04x:%04x]\n",
-		 dev->vendor, dev->device);
-}
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_8131_BRIDGE,	quirk_disable_amd_813x_boot_interrupt);
-DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_8131_BRIDGE,	quirk_disable_amd_813x_boot_interrupt);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_8132_BRIDGE,	quirk_disable_amd_813x_boot_interrupt);
-DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_8132_BRIDGE,	quirk_disable_amd_813x_boot_interrupt);
-
-#define AMD_8111_PCI_IRQ_ROUTING	0x56
-
-static void quirk_disable_amd_8111_boot_interrupt(struct pci_dev *dev)
-{
-	u16 pci_config_word;
-
-	if (noioapicquirk)
-		return;
-
-	pci_read_config_word(dev, AMD_8111_PCI_IRQ_ROUTING, &pci_config_word);
-	if (!pci_config_word) {
-		pci_info(dev, "boot interrupts on device [%04x:%04x] already disabled\n",
-			 dev->vendor, dev->device);
-		return;
-	}
-	pci_write_config_word(dev, AMD_8111_PCI_IRQ_ROUTING, 0);
-	pci_info(dev, "disabled boot interrupts on device [%04x:%04x]\n",
-		 dev->vendor, dev->device);
-}
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD,   PCI_DEVICE_ID_AMD_8111_SMBUS,	quirk_disable_amd_8111_boot_interrupt);
-DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD,   PCI_DEVICE_ID_AMD_8111_SMBUS,	quirk_disable_amd_8111_boot_interrupt);
-#endif /* CONFIG_X86_IO_APIC */
-
 /*
  * Toshiba TC86C001 IDE controller reports the standard 8-byte BAR0 size
  * but the PIO transfers won't work if BAR0 falls at the odd 8 bytes.
-- 
2.55.0

