Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDF447F2F2
	for <linux-pci@vger.kernel.org>; Tue,  7 Jul 2026 22:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783462700; cv=none; b=TREA2+6n45+2TWTvWNd7xb8I4/469MtzRJySmnbGjm4zAiggNckWLxDi6zs1+ArQ7ynq6tWmQ/n9VHg5pHVvUDGL2J7h4iSDvkAXcwtVKAGboRG+h6WCF47PdfEjZTYQBHso3Bo4TMAt0Byxq2w/LSvNLkaJFtfLY71ThNgBEfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783462700; c=relaxed/simple;
	bh=WyJTs2XHSk77JmaSgfapEw22z6xX+t55YkVUO/FOlPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gRI6ZLW6KqlgtT5WMQpBSWhtvrjl8o0CzZ+x1AE6nJlpX9/TXJlFZP9F96bxAAS+Ot2acd9nS2DLumEPGABFkiAeMzaCRV51362gGlF3ZUCDzeZfEn2U5fLF61RR8gNSmlWl2MpxokVttaLAmZj1CNbKM+k0UlcAeTlw1fwuA1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RxD/9wOY; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RxD/9wOY"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8482074a000so19496b3a.0
        for <linux-pci@vger.kernel.org>; Tue, 07 Jul 2026 15:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783462695; x=1784067495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bVs3vAT2W9So+7Cv/cUoY9d4XtAJo3ccJhsgHqDv1Xc=;
        b=RxD/9wOY1xhztjIRyeNO3PkDWPUzz8biVmzeU0vPqTkkFpuLhlgfAzvKsiiKwNit8r
         xdiw28fSnfdGclfODTRoKJyk4gn6MV1NiLCtg+iR+wKlq0rIiYd/EjgcCIrHOb79akmZ
         gpp7MhCjbiy7onqDi8ttM2tduuK7HCyNswD9VQjMQAhAQrL4/wzZ28OIOIar5hihkOHd
         91UVXLSrtv0bRxx6vxWrEAQnExv3azCy4taN4pXR8uqFKfgEd1Onvg8Gup/ojf4Tn1M6
         h7pqlOscl9vKveBCVwxq0KFdK2GFIbbBele7O7EaJsKWFzb/f8O/qALUmaFVOojVmFNW
         eCcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783462695; x=1784067495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bVs3vAT2W9So+7Cv/cUoY9d4XtAJo3ccJhsgHqDv1Xc=;
        b=M7o/jEvaSjRHj/funWi4uawVgbkbTeHJso9M+j8PQ9Ti9iIiPryaqsuQ71Ava3L2Fc
         ASYah3Zmq5Zc5IKhQoEx2QZPyI/hxivW1XGw3W08aZ6LVwsld7Q48kyWrVWh/68Q0Mu9
         XIslh+u6r4Vx+bKxzcXy2eukLZaCkxajzGnwK6poTHILGKBi8L+W4QsAMf512bXjvwsp
         9OFDMs8PZlXFY2dX4u1VcN+LxpqkrkljSsCZGPLcG2OfE6doIDqTTeyvmp6VKCHu1EAm
         peKdQYz29K2fyfjCc4+YCuDDUwnaDTXKtgycKVUi65BFAg1C2KOHTAHeuhN5aZsZlSLe
         6Eeg==
X-Gm-Message-State: AOJu0YyRQzNb7JmfHKJepymBotmxepfm/iATxJKGOaNe3jnMpX6P90MA
	olKF/jwy23Ijt13hfF7ZiHZGVKx5L1Epsla9lp4y8BT3rV9j7w5X3wyqoMJ8xvBu
X-Gm-Gg: AfdE7ckPwIn5g54oDFkVg7WXlBzEejmNVYqxrPh72zcOHELLbf+byX717nuCHqvTw6P
	oxn5reCCin2V/Ms5BKGv1ZO+Z3wVi9QriKdsuJVkBBuBdIvhCrnrGzV6A/IIsZ66YR0uz+0URWo
	VXsf2B2S0R4SMJcUTAKNgyr5m7Vt8gnbc+tWCaBvE95zrns3jcRWd3IT12puw0tDK7J4j5yeCnu
	fZeOGqxjuuLMsBDczoFt60xuHcb1d8TOJu2W7cpPxb2VuwsSVHXuacLiNbuDin6ifjv5TkvvZUy
	LLp9V8RCp6El9UmKnwxAmxPl3y4o7jBtZl0NBjr4FjPdzV0bcMjKceLsYyelQA+NI8+f0g2JAQV
	j4NctUP9viBLXyXtwCFsCO1XkbDWqZM553bNQVNR0HBe27cdIjVjW0r8k3X8xQJFr1eC2G81JbA
	lX8v/lBRzUuIQhdQKidNZ8gXAgKITCUyZlzbZW+pSUlurkX1RhbGNqTlK6qGTWYoC9O4W7pplqy
	uCud4QEkg==
X-Received: by 2002:a05:6a00:348a:b0:847:e2c7:59c5 with SMTP id d2e1a72fcca58-8484343720cmr7140b3a.49.1783462694457;
        Tue, 07 Jul 2026 15:18:14 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6b9b389sm6180281b3a.13.2026.07.07.15.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 15:18:13 -0700 (PDT)
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
Subject: [PATCH 8/8] x86/pci: move remaining x86-specific quirks to fixup.c
Date: Tue,  7 Jul 2026 15:18:00 -0700
Message-ID: <20260707221800.920270-9-rosenp@gmail.com>
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

Move the remaining x86-specific PCI quirks from drivers/pci/quirks.c
to arch/x86/pci/fixup.c:

- ATI northbridge MCE I/O port reservation
- Cyrix/National MediaGX/Geode slave disconnect boundary fix
- ServerWorks CSB5 IDE native mode fix
- NVIDIA CK804 PCIe AER extended capability link
- Intel NM10 Tiger Point LPC PM1a_STS.BM_STS clear
- ASUS/HP/Samsung/Compaq SMBus hide/unhide (Intel ICH LPC)
- HyperTransport (HT) MSI mapping helpers and quirks for
  NVIDIA, ALi, ServerWorks, and AMD chipsets
- NVIDIA MCP55 legacy IRQ routing fix
- ASUS P5N32-SLI MCP55 MSI disable
- VT-d spec-defined error masking (Intel 7500/5500 chipsets)
- Apple Cactus Ridge Thunderbolt controller poweroff on suspend

Make quirk_disable_msi() non-static so the HT MSI helpers in
fixup.c can call it.  Add its declaration to drivers/pci/pci.h.
Drop now-unnecessary includes of <linux/ioport.h> and
<linux/platform_data/x86/apple.h> from quirks.c; add them to
fixup.c where needed.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 arch/x86/pci/fixup.c | 774 +++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h    |   3 +
 drivers/pci/quirks.c | 769 +-----------------------------------------
 3 files changed, 779 insertions(+), 767 deletions(-)

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index daeabca290a3..1e5ca05557f8 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -5,15 +5,21 @@
 
 #include <linux/bitfield.h>
 #include <linux/delay.h>
+#include <linux/acpi.h>
 #include <linux/dmi.h>
 #include <linux/isa-dma.h> /* isa_dma_bridge_buggy */
 #include <linux/pci.h>
+#include <linux/platform_data/x86/apple.h>
 #include <linux/suspend.h>
 #include <linux/vgaarb.h>
 #include <asm/amd/node.h>
 #include <asm/hpet.h>
 #include <asm/pci_x86.h>
 
+/* Capability search loop limit (same value as drivers/pci/pci.h) */
+#define PCI_FIND_CAP_TTL	48
+
+void quirk_disable_msi(struct pci_dev *dev);
 const char *pci_resource_name(struct pci_dev *dev, unsigned int i);
 
 static void quirk_io(struct pci_dev *dev, int pos, unsigned int size,
@@ -2591,3 +2597,771 @@ static void quirk_disable_amd_8111_boot_interrupt(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD,   PCI_DEVICE_ID_AMD_8111_SMBUS,	quirk_disable_amd_8111_boot_interrupt);
 DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD,   PCI_DEVICE_ID_AMD_8111_SMBUS,	quirk_disable_amd_8111_boot_interrupt);
 #endif /* CONFIG_X86_IO_APIC */
+
+/*
+ * ATI Northbridge setups MCE the processor if you even read somewhere
+ * between 0x3b0->0x3bb or read 0x3d3
+ */
+static void quirk_ati_exploding_mce(struct pci_dev *dev)
+{
+	pci_info(dev, "ATI Northbridge, reserving I/O ports 0x3b0 to 0x3bb\n");
+	/* Mae rhaid i ni beidio ag edrych ar y lleoliadiau I/O hyn */
+	request_region(0x3b0, 0x0C, "RadeonIGP");
+	request_region(0x3d3, 0x01, "RadeonIGP");
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI,	PCI_DEVICE_ID_ATI_RS100,   quirk_ati_exploding_mce);
+
+/*
+ * Accessing the device between 0x3b0 to 0x3bb or reading 0x3d3 may MCE
+ * on ATI Northbridges. Cyrix MediaGX/Geode has a Slave Disconnect
+ * Boundary issue.
+ */
+static void quirk_mediagx_master(struct pci_dev *dev)
+{
+	u8 reg;
+
+	pci_read_config_byte(dev, 0x41, &reg);
+	if (reg & 2) {
+		reg &= ~2;
+		pci_info(dev, "Fixup for MediaGX/Geode Slave Disconnect Boundary (0x41=0x%02x)\n",
+			 reg);
+		pci_write_config_byte(dev, 0x41, reg);
+	}
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CYRIX,	PCI_DEVICE_ID_CYRIX_PCI_MASTER, quirk_mediagx_master);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_CYRIX,	PCI_DEVICE_ID_CYRIX_PCI_MASTER, quirk_mediagx_master);
+
+/* Serverworks CSB5 IDE does not fully support native mode */
+static void quirk_svwks_csb5ide(struct pci_dev *pdev)
+{
+	u8 prog;
+	pci_read_config_byte(pdev, PCI_CLASS_PROG, &prog);
+	if (prog & 5) {
+		prog &= ~5;
+		pdev->class &= ~5;
+		pci_write_config_byte(pdev, PCI_CLASS_PROG, prog);
+		/* PCI layer will sort out resources */
+	}
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_CSB5IDE, quirk_svwks_csb5ide);
+
+/*
+ * Under some circumstances, AER is not linked with extended capabilities.
+ * Force it to be linked by setting the corresponding control bit in the
+ * config space.
+ */
+static void quirk_nvidia_ck804_pcie_aer_ext_cap(struct pci_dev *dev)
+{
+	uint8_t b;
+
+	if (pci_read_config_byte(dev, 0xf41, &b) == 0) {
+		if (!(b & 0x20)) {
+			pci_write_config_byte(dev, 0xf41, b | 0x20);
+			pci_info(dev, "Linking AER extended capability\n");
+		}
+	}
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA,  PCI_DEVICE_ID_NVIDIA_CK804_PCIE,
+			quirk_nvidia_ck804_pcie_aer_ext_cap);
+DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_NVIDIA,  PCI_DEVICE_ID_NVIDIA_CK804_PCIE,
+			quirk_nvidia_ck804_pcie_aer_ext_cap);
+
+/*
+ * On ASUS P4B boards, the SMBus PCI Device within the ICH2/4 southbridge
+ * is not activated. The myth is that Asus said that they do not want the
+ * users to be irritated by just another PCI Device in the Win98 device
+ * manager. (see the file prog/hotplug/README.p4b in the lm_sensors
+ * package 2.7.0 for details)
+ *
+ * The SMBus PCI Device can be activated by setting a bit in the ICH LPC
+ * bridge. Unfortunately, this device has no subvendor/subdevice ID. So it
+ * becomes necessary to do this tweak in two steps -- the chosen trigger
+ * is either the Host bridge (preferred) or on-board VGA controller.
+ *
+ * Note that we used to unhide the SMBus that way on Toshiba laptops
+ * (Satellite A40 and Tecra M2) but then found that the thermal management
+ * was done by SMM code, which could cause unsynchronized concurrent
+ * accesses to the SMBus registers, with potentially bad effects. Thus you
+ * should be very careful when adding new entries: if SMM is accessing the
+ * Intel SMBus, this is a very good reason to leave it hidden.
+ *
+ * Likewise, many recent laptops use ACPI for thermal management. If the
+ * ACPI DSDT code accesses the SMBus, then Linux should not access it
+ * natively, and keeping the SMBus hidden is the right thing to do. If you
+ * are about to add an entry in the table below, please first disassemble
+ * the DSDT and double-check that there is no code accessing the SMBus.
+ */
+static int asus_hides_smbus;
+
+static void asus_hides_smbus_hostbridge(struct pci_dev *dev)
+{
+	if (unlikely(dev->subsystem_vendor == PCI_VENDOR_ID_ASUSTEK)) {
+		if (dev->device == PCI_DEVICE_ID_INTEL_82845_HB)
+			switch (dev->subsystem_device) {
+			case 0x8025: /* P4B-LX */
+			case 0x8070: /* P4B */
+			case 0x8088: /* P4B533 */
+			case 0x1626: /* L3C notebook */
+				asus_hides_smbus = 1;
+			}
+		else if (dev->device == PCI_DEVICE_ID_INTEL_82845G_HB)
+			switch (dev->subsystem_device) {
+			case 0x80b1: /* P4GE-V */
+			case 0x80b2: /* P4PE */
+			case 0x8093: /* P4B533-V */
+				asus_hides_smbus = 1;
+			}
+		else if (dev->device == PCI_DEVICE_ID_INTEL_82850_HB)
+			switch (dev->subsystem_device) {
+			case 0x8030: /* P4T533 */
+				asus_hides_smbus = 1;
+			}
+		else if (dev->device == PCI_DEVICE_ID_INTEL_7205_0)
+			switch (dev->subsystem_device) {
+			case 0x8070: /* P4G8X Deluxe */
+				asus_hides_smbus = 1;
+			}
+		else if (dev->device == PCI_DEVICE_ID_INTEL_E7501_MCH)
+			switch (dev->subsystem_device) {
+			case 0x80c9: /* PU-DLS */
+				asus_hides_smbus = 1;
+			}
+		else if (dev->device == PCI_DEVICE_ID_INTEL_82855GM_HB)
+			switch (dev->subsystem_device) {
+			case 0x1751: /* M2N notebook */
+			case 0x1821: /* M5N notebook */
+			case 0x1897: /* A6L notebook */
+				asus_hides_smbus = 1;
+			}
+		else if (dev->device == PCI_DEVICE_ID_INTEL_82855PM_HB)
+			switch (dev->subsystem_device) {
+			case 0x184b: /* W1N notebook */
+			case 0x186a: /* M6Ne notebook */
+				asus_hides_smbus = 1;
+			}
+		else if (dev->device == PCI_DEVICE_ID_INTEL_82865_HB)
+			switch (dev->subsystem_device) {
+			case 0x80f2: /* P4P800-X */
+				asus_hides_smbus = 1;
+			}
+		else if (dev->device == PCI_DEVICE_ID_INTEL_82915GM_HB)
+			switch (dev->subsystem_device) {
+			case 0x1882: /* M6V notebook */
+			case 0x1977: /* A6VA notebook */
+				asus_hides_smbus = 1;
+			}
+	} else if (unlikely(dev->subsystem_vendor == PCI_VENDOR_ID_HP)) {
+		if (dev->device ==  PCI_DEVICE_ID_INTEL_82855PM_HB)
+			switch (dev->subsystem_device) {
+			case 0x088C: /* HP Compaq nc8000 */
+			case 0x0890: /* HP Compaq nc6000 */
+				asus_hides_smbus = 1;
+			}
+		else if (dev->device == PCI_DEVICE_ID_INTEL_82865_HB)
+			switch (dev->subsystem_device) {
+			case 0x12bc: /* HP D330L */
+			case 0x12bd: /* HP D530 */
+			case 0x006a: /* HP Compaq nx9500 */
+				asus_hides_smbus = 1;
+			}
+		else if (dev->device == PCI_DEVICE_ID_INTEL_82875_HB)
+			switch (dev->subsystem_device) {
+			case 0x12bf: /* HP xw4100 */
+				asus_hides_smbus = 1;
+			}
+	} else if (unlikely(dev->subsystem_vendor == PCI_VENDOR_ID_SAMSUNG)) {
+		if (dev->device ==  PCI_DEVICE_ID_INTEL_82855PM_HB)
+			switch (dev->subsystem_device) {
+			case 0xC00C: /* Samsung P35 notebook */
+				asus_hides_smbus = 1;
+		}
+	} else if (unlikely(dev->subsystem_vendor == PCI_VENDOR_ID_COMPAQ)) {
+		if (dev->device == PCI_DEVICE_ID_INTEL_82855PM_HB)
+			switch (dev->subsystem_device) {
+			case 0x0058: /* Compaq Evo N620c */
+				asus_hides_smbus = 1;
+			}
+		else if (dev->device == PCI_DEVICE_ID_INTEL_82810_IG3)
+			switch (dev->subsystem_device) {
+			case 0xB16C: /* Compaq Deskpro EP 401963-001 (PCA# 010174) */
+				/* Motherboard doesn't have Host bridge
+				 * subvendor/subdevice IDs, therefore checking
+				 * its on-board VGA controller */
+				asus_hides_smbus = 1;
+			}
+		else if (dev->device == PCI_DEVICE_ID_INTEL_82801DB_2)
+			switch (dev->subsystem_device) {
+			case 0x00b8: /* Compaq Evo D510 CMT */
+			case 0x00b9: /* Compaq Evo D510 SFF */
+			case 0x00ba: /* Compaq Evo D510 USDT */
+				/* Motherboard doesn't have Host bridge
+				 * subvendor/subdevice IDs and on-board VGA
+				 * controller is disabled if an AGP card is
+				 * inserted, therefore checking USB UHCI
+				 * Controller #1 */
+				asus_hides_smbus = 1;
+			}
+		else if (dev->device == PCI_DEVICE_ID_INTEL_82815_CGC)
+			switch (dev->subsystem_device) {
+			case 0x001A: /* Compaq Deskpro EN SSF P667 815E */
+				/* Motherboard doesn't have host bridge
+				 * subvendor/subdevice IDs, therefore checking
+				 * its on-board VGA controller */
+				asus_hides_smbus = 1;
+			}
+	}
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82845_HB,	asus_hides_smbus_hostbridge);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82845G_HB,	asus_hides_smbus_hostbridge);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82850_HB,	asus_hides_smbus_hostbridge);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82865_HB,	asus_hides_smbus_hostbridge);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82875_HB,	asus_hides_smbus_hostbridge);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_7205_0,	asus_hides_smbus_hostbridge);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_E7501_MCH,	asus_hides_smbus_hostbridge);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82855PM_HB,	asus_hides_smbus_hostbridge);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82855GM_HB,	asus_hides_smbus_hostbridge);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82915GM_HB, asus_hides_smbus_hostbridge);
+
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82810_IG3,	asus_hides_smbus_hostbridge);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801DB_2,	asus_hides_smbus_hostbridge);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82815_CGC,	asus_hides_smbus_hostbridge);
+
+static void asus_hides_smbus_lpc(struct pci_dev *dev)
+{
+	u16 val;
+
+	if (likely(!asus_hides_smbus))
+		return;
+
+	pci_read_config_word(dev, 0xF2, &val);
+	if (val & 0x8) {
+		pci_write_config_word(dev, 0xF2, val & (~0x8));
+		pci_read_config_word(dev, 0xF2, &val);
+		if (val & 0x8)
+			pci_info(dev, "i801 SMBus device continues to play 'hide and seek'! 0x%x\n",
+				 val);
+		else
+			pci_info(dev, "Enabled i801 SMBus device\n");
+	}
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801AA_0,	asus_hides_smbus_lpc);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801DB_0,	asus_hides_smbus_lpc);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801BA_0,	asus_hides_smbus_lpc);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801CA_0,	asus_hides_smbus_lpc);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801CA_12,	asus_hides_smbus_lpc);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801DB_12,	asus_hides_smbus_lpc);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801EB_0,	asus_hides_smbus_lpc);
+DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801AA_0,	asus_hides_smbus_lpc);
+DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801DB_0,	asus_hides_smbus_lpc);
+DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801BA_0,	asus_hides_smbus_lpc);
+DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801CA_0,	asus_hides_smbus_lpc);
+DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801CA_12,	asus_hides_smbus_lpc);
+DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801DB_12,	asus_hides_smbus_lpc);
+DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801EB_0,	asus_hides_smbus_lpc);
+
+/* It appears we just have one such device. If not, we have a warning */
+static void __iomem *asus_rcba_base;
+static void asus_hides_smbus_lpc_ich6_suspend(struct pci_dev *dev)
+{
+	u32 rcba;
+
+	if (likely(!asus_hides_smbus))
+		return;
+	WARN_ON(asus_rcba_base);
+
+	pci_read_config_dword(dev, 0xF0, &rcba);
+	/* use bits 31:14, 16 kB aligned */
+	asus_rcba_base = ioremap(rcba & 0xFFFFC000, 0x4000);
+	if (asus_rcba_base == NULL)
+		return;
+}
+
+static void asus_hides_smbus_lpc_ich6_resume_early(struct pci_dev *dev)
+{
+	u32 val;
+
+	if (likely(!asus_hides_smbus || !asus_rcba_base))
+		return;
+
+	/* read the Function Disable register, dword mode only */
+	val = readl(asus_rcba_base + 0x3418);
+
+	/* enable the SMBus device */
+	writel(val & 0xFFFFFFF7, asus_rcba_base + 0x3418);
+}
+
+static void asus_hides_smbus_lpc_ich6_resume(struct pci_dev *dev)
+{
+	if (likely(!asus_hides_smbus || !asus_rcba_base))
+		return;
+
+	iounmap(asus_rcba_base);
+	asus_rcba_base = NULL;
+	pci_info(dev, "Enabled ICH6/i801 SMBus device\n");
+}
+
+static void asus_hides_smbus_lpc_ich6(struct pci_dev *dev)
+{
+	asus_hides_smbus_lpc_ich6_suspend(dev);
+	asus_hides_smbus_lpc_ich6_resume_early(dev);
+	asus_hides_smbus_lpc_ich6_resume(dev);
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH6_1,	asus_hides_smbus_lpc_ich6);
+DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH6_1,	asus_hides_smbus_lpc_ich6_suspend);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH6_1,	asus_hides_smbus_lpc_ich6_resume);
+DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH6_1,	asus_hides_smbus_lpc_ich6_resume_early);
+
+/*
+ * Go through the list of HyperTransport capabilities and return 1 if a HT
+ * MSI capability is found and enabled.
+ */
+static int msi_ht_cap_enabled(struct pci_dev *dev)
+{
+	int pos, ttl = PCI_FIND_CAP_TTL;
+
+	pos = pci_find_ht_capability(dev, HT_CAPTYPE_MSI_MAPPING);
+	while (pos && ttl--) {
+		u8 flags;
+
+		if (pci_read_config_byte(dev, pos + HT_MSI_FLAGS,
+					 &flags) == 0) {
+			pci_info(dev, "Found %s HT MSI Mapping\n",
+				flags & HT_MSI_FLAGS_ENABLE ?
+				"enabled" : "disabled");
+			return (flags & HT_MSI_FLAGS_ENABLE) != 0;
+		}
+
+		pos = pci_find_next_ht_capability(dev, pos,
+						  HT_CAPTYPE_MSI_MAPPING);
+	}
+	return 0;
+}
+
+/* Check the HyperTransport MSI mapping to know whether MSI is enabled or not */
+static void quirk_msi_ht_cap(struct pci_dev *dev)
+{
+	if (!msi_ht_cap_enabled(dev))
+		quirk_disable_msi(dev);
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_HT2000_PCIE,
+			quirk_msi_ht_cap);
+
+/*
+ * The nVidia CK804 chipset may have 2 HT MSI mappings.  MSI is supported
+ * if the MSI capability is set in any of these mappings.
+ */
+static void quirk_nvidia_ck804_msi_ht_cap(struct pci_dev *dev)
+{
+	struct pci_dev *pdev;
+
+	/*
+	 * Check HT MSI cap on this chipset and the root one.  A single one
+	 * having MSI is enough to be sure that MSI is supported.
+	 */
+	pdev = pci_get_slot(dev->bus, 0);
+	if (!pdev)
+		return;
+	if (!msi_ht_cap_enabled(pdev))
+		quirk_msi_ht_cap(dev);
+	pci_dev_put(pdev);
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_CK804_PCIE,
+			quirk_nvidia_ck804_msi_ht_cap);
+
+/* Force enable MSI mapping capability on HT bridges */
+static void ht_enable_msi_mapping(struct pci_dev *dev)
+{
+	int pos, ttl = PCI_FIND_CAP_TTL;
+
+	pos = pci_find_ht_capability(dev, HT_CAPTYPE_MSI_MAPPING);
+	while (pos && ttl--) {
+		u8 flags;
+
+		if (pci_read_config_byte(dev, pos + HT_MSI_FLAGS,
+					 &flags) == 0) {
+			pci_info(dev, "Enabling HT MSI Mapping\n");
+
+			pci_write_config_byte(dev, pos + HT_MSI_FLAGS,
+					      flags | HT_MSI_FLAGS_ENABLE);
+		}
+		pos = pci_find_next_ht_capability(dev, pos,
+						  HT_CAPTYPE_MSI_MAPPING);
+	}
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SERVERWORKS,
+			 PCI_DEVICE_ID_SERVERWORKS_HT1000_PXB,
+			 ht_enable_msi_mapping);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_8132_BRIDGE,
+			 ht_enable_msi_mapping);
+
+/*
+ * The P5N32-SLI motherboards from Asus have a problem with MSI
+ * for the MCP55 NIC. It is not yet determined whether the MSI problem
+ * also affects other devices. As for now, turn off MSI for this device.
+ */
+static void nvenet_msi_disable(struct pci_dev *dev)
+{
+	const char *board_name = dmi_get_system_info(DMI_BOARD_NAME);
+
+	if (board_name &&
+	    (strstr(board_name, "P5N32-SLI PREMIUM") ||
+	     strstr(board_name, "P5N32-E SLI"))) {
+		pci_info(dev, "Disabling MSI for MCP55 NIC on P5N32-SLI\n");
+		dev->no_msi = 1;
+	}
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA,
+			PCI_DEVICE_ID_NVIDIA_NVENET_15,
+			nvenet_msi_disable);
+
+/*
+ * Some versions of the MCP55 bridge from Nvidia have a legacy IRQ routing
+ * config register.  This register controls the routing of legacy
+ * interrupts from devices that route through the MCP55.  If this register
+ * is misprogrammed, interrupts are only sent to the BSP, unlike
+ * conventional systems where the IRQ is broadcast to all online CPUs.  Not
+ * having this register set properly prevents kdump from booting up
+ * properly, so let's make sure that we have it set correctly.
+ * Note that this is an undocumented register.
+ */
+static void nvbridge_check_legacy_irq_routing(struct pci_dev *dev)
+{
+	u32 cfg;
+
+	if (!pci_find_capability(dev, PCI_CAP_ID_HT))
+		return;
+
+	pci_read_config_dword(dev, 0x74, &cfg);
+
+	if (cfg & ((1 << 2) | (1 << 15))) {
+		pr_info("Rewriting IRQ routing register on MCP55\n");
+		cfg &= ~((1 << 2) | (1 << 15));
+		pci_write_config_dword(dev, 0x74, cfg);
+	}
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA,
+			PCI_DEVICE_ID_NVIDIA_MCP55_BRIDGE_V0,
+			nvbridge_check_legacy_irq_routing);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA,
+			PCI_DEVICE_ID_NVIDIA_MCP55_BRIDGE_V4,
+			nvbridge_check_legacy_irq_routing);
+
+static int ht_check_msi_mapping(struct pci_dev *dev)
+{
+	int pos, ttl = PCI_FIND_CAP_TTL;
+	int found = 0;
+
+	/* Check if there is HT MSI cap or enabled on this device */
+	pos = pci_find_ht_capability(dev, HT_CAPTYPE_MSI_MAPPING);
+	while (pos && ttl--) {
+		u8 flags;
+
+		if (found < 1)
+			found = 1;
+		if (pci_read_config_byte(dev, pos + HT_MSI_FLAGS,
+					 &flags) == 0) {
+			if (flags & HT_MSI_FLAGS_ENABLE) {
+				if (found < 2) {
+					found = 2;
+					break;
+				}
+			}
+		}
+		pos = pci_find_next_ht_capability(dev, pos,
+						  HT_CAPTYPE_MSI_MAPPING);
+	}
+
+	return found;
+}
+
+static int host_bridge_with_leaf(struct pci_dev *host_bridge)
+{
+	struct pci_dev *dev;
+	int pos;
+	int i, dev_no;
+	int found = 0;
+
+	dev_no = host_bridge->devfn >> 3;
+	for (i = dev_no + 1; i < 0x20; i++) {
+		dev = pci_get_slot(host_bridge->bus, PCI_DEVFN(i, 0));
+		if (!dev)
+			continue;
+
+		/* found next host bridge? */
+		pos = pci_find_ht_capability(dev, HT_CAPTYPE_SLAVE);
+		if (pos != 0) {
+			pci_dev_put(dev);
+			break;
+		}
+
+		if (ht_check_msi_mapping(dev)) {
+			found = 1;
+			pci_dev_put(dev);
+			break;
+		}
+		pci_dev_put(dev);
+	}
+
+	return found;
+}
+
+#define PCI_HT_CAP_SLAVE_CTRL0     4    /* link control */
+#define PCI_HT_CAP_SLAVE_CTRL1     8    /* link control to */
+
+static int is_end_of_ht_chain(struct pci_dev *dev)
+{
+	int pos, ctrl_off;
+	int end = 0;
+	u16 flags, ctrl;
+
+	pos = pci_find_ht_capability(dev, HT_CAPTYPE_SLAVE);
+
+	if (!pos)
+		goto out;
+
+	pci_read_config_word(dev, pos + PCI_CAP_FLAGS, &flags);
+
+	ctrl_off = ((flags >> 10) & 1) ?
+			PCI_HT_CAP_SLAVE_CTRL0 : PCI_HT_CAP_SLAVE_CTRL1;
+	pci_read_config_word(dev, pos + ctrl_off, &ctrl);
+
+	if (ctrl & (1 << 6))
+		end = 1;
+
+out:
+	return end;
+}
+
+static void nv_ht_enable_msi_mapping(struct pci_dev *dev)
+{
+	struct pci_dev *host_bridge;
+	int pos;
+	int i, dev_no;
+	int found = 0;
+
+	dev_no = dev->devfn >> 3;
+	for (i = dev_no; i >= 0; i--) {
+		host_bridge = pci_get_slot(dev->bus, PCI_DEVFN(i, 0));
+		if (!host_bridge)
+			continue;
+
+		pos = pci_find_ht_capability(host_bridge, HT_CAPTYPE_SLAVE);
+		if (pos != 0) {
+			found = 1;
+			break;
+		}
+		pci_dev_put(host_bridge);
+	}
+
+	if (!found)
+		return;
+
+	/* don't enable end_device/host_bridge with leaf directly here */
+	if (host_bridge == dev && is_end_of_ht_chain(host_bridge) &&
+	    host_bridge_with_leaf(host_bridge))
+		goto out;
+
+	/* root did that ! */
+	if (msi_ht_cap_enabled(host_bridge))
+		goto out;
+
+	ht_enable_msi_mapping(dev);
+
+out:
+	pci_dev_put(host_bridge);
+}
+
+static void ht_disable_msi_mapping(struct pci_dev *dev)
+{
+	int pos, ttl = PCI_FIND_CAP_TTL;
+
+	pos = pci_find_ht_capability(dev, HT_CAPTYPE_MSI_MAPPING);
+	while (pos && ttl--) {
+		u8 flags;
+
+		if (pci_read_config_byte(dev, pos + HT_MSI_FLAGS,
+					 &flags) == 0) {
+			pci_info(dev, "Disabling HT MSI Mapping\n");
+
+			pci_write_config_byte(dev, pos + HT_MSI_FLAGS,
+					      flags & ~HT_MSI_FLAGS_ENABLE);
+		}
+		pos = pci_find_next_ht_capability(dev, pos,
+						  HT_CAPTYPE_MSI_MAPPING);
+	}
+}
+
+static void __nv_msi_ht_cap_quirk(struct pci_dev *dev, int all)
+{
+	struct pci_dev *host_bridge;
+	int pos;
+	int found;
+
+	if (!pci_msi_enabled())
+		return;
+
+	/* check if there is HT MSI cap or enabled on this device */
+	found = ht_check_msi_mapping(dev);
+
+	/* no HT MSI CAP */
+	if (found == 0)
+		return;
+
+	/*
+	 * HT MSI mapping should be disabled on devices that are below
+	 * a non-HyperTransport host bridge. Locate the host bridge.
+	 */
+	host_bridge = pci_get_domain_bus_and_slot(pci_domain_nr(dev->bus), 0,
+						  PCI_DEVFN(0, 0));
+	if (host_bridge == NULL) {
+		pci_warn(dev, "nv_msi_ht_cap_quirk didn't locate host bridge\n");
+		return;
+	}
+
+	pos = pci_find_ht_capability(host_bridge, HT_CAPTYPE_SLAVE);
+	if (pos != 0) {
+		/* Host bridge is to HT */
+		if (found == 1) {
+			/* it is not enabled, try to enable it */
+			if (all)
+				ht_enable_msi_mapping(dev);
+			else
+				nv_ht_enable_msi_mapping(dev);
+		}
+		goto out;
+	}
+
+	/* HT MSI is not enabled */
+	if (found == 1)
+		goto out;
+
+	/* Host bridge is not to HT, disable HT MSI mapping on this device */
+	ht_disable_msi_mapping(dev);
+
+out:
+	pci_dev_put(host_bridge);
+}
+
+static void nv_msi_ht_cap_quirk_all(struct pci_dev *dev)
+{
+	return __nv_msi_ht_cap_quirk(dev, 1);
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AL, PCI_ANY_ID, nv_msi_ht_cap_quirk_all);
+DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_AL, PCI_ANY_ID, nv_msi_ht_cap_quirk_all);
+
+static void nv_msi_ht_cap_quirk_leaf(struct pci_dev *dev)
+{
+	return __nv_msi_ht_cap_quirk(dev, 0);
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID, nv_msi_ht_cap_quirk_leaf);
+DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID, nv_msi_ht_cap_quirk_leaf);
+
+#ifdef CONFIG_HAS_IOPORT
+/*
+ * Intel NM10 "Tiger Point" LPC PM1a_STS.BM_STS must be clear
+ * for some HT machines to use C4 w/o hanging.
+ */
+static void quirk_tigerpoint_bm_sts(struct pci_dev *dev)
+{
+	u32 pmbase;
+	u16 pm1a;
+
+	pci_read_config_dword(dev, 0x40, &pmbase);
+	pmbase = pmbase & 0xff80;
+	pm1a = inw(pmbase);
+
+	if (pm1a & 0x10) {
+		pci_info(dev, FW_BUG "Tiger Point LPC.BM_STS cleared\n");
+		outw(0x10, pmbase);
+	}
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_TGP_LPC, quirk_tigerpoint_bm_sts);
+#endif
+
+#ifdef CONFIG_DMAR_TABLE
+#define VTUNCERRMSK_REG	0x1ac
+#define VTD_MSK_SPEC_ERRORS	(1 << 31)
+/*
+ * This is a quirk for masking VT-d spec-defined errors to platform error
+ * handling logic. Without this, platforms using Intel 7500, 5500 chipsets
+ * (and the derivative chipsets like X58 etc) seem to generate NMI/SMI (based
+ * on the RAS config settings of the platform) when a VT-d fault happens.
+ * The resulting SMI caused the system to hang.
+ *
+ * VT-d spec-related errors are already handled by the VT-d OS code, so no
+ * need to report the same error through other channels.
+ */
+static void vtd_mask_spec_errors(struct pci_dev *dev)
+{
+	u32 word;
+
+	pci_read_config_dword(dev, VTUNCERRMSK_REG, &word);
+	pci_write_config_dword(dev, VTUNCERRMSK_REG, word | VTD_MSK_SPEC_ERRORS);
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x342e, vtd_mask_spec_errors);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x3c28, vtd_mask_spec_errors);
+#endif
+
+#ifdef CONFIG_ACPI
+/*
+ * Apple: Shutdown Cactus Ridge Thunderbolt controller.
+ *
+ * On Apple hardware the Cactus Ridge Thunderbolt controller needs to be
+ * shutdown before suspend. Otherwise the native host interface (NHI) will not
+ * be present after resume if a device was plugged in before suspend.
+ *
+ * The Thunderbolt controller consists of a PCIe switch with downstream
+ * bridges leading to the NHI and to the tunnel PCI bridges.
+ *
+ * This quirk cuts power to the whole chip. Therefore we have to apply it
+ * during suspend_noirq of the upstream bridge.
+ *
+ * Power is automagically restored before resume. No action is needed.
+ */
+static void quirk_apple_poweroff_thunderbolt(struct pci_dev *dev)
+{
+	acpi_handle bridge, SXIO, SXFP, SXLV;
+
+	if (!x86_apple_machine)
+		return;
+	if (pci_pcie_type(dev) != PCI_EXP_TYPE_UPSTREAM)
+		return;
+
+	/*
+	 * SXIO/SXFP/SXLF turns off power to the Thunderbolt controller.
+	 * We don't know how to turn it back on again, but firmware does,
+	 * so we can only use SXIO/SXFP/SXLF if we're suspending via
+	 * firmware.
+	 */
+	if (!pm_suspend_via_firmware())
+		return;
+
+	bridge = ACPI_HANDLE(&dev->dev);
+	if (!bridge)
+		return;
+
+	/*
+	 * SXIO and SXLV are present only on machines requiring this quirk.
+	 * Thunderbolt bridges in external devices might have the same
+	 * device ID as those on the host, but they will not have the
+	 * associated ACPI methods. This implicitly checks that we are at
+	 * the right bridge.
+	 */
+	if (ACPI_FAILURE(acpi_get_handle(bridge, "DSB0.NHI0.SXIO", &SXIO))
+	    || ACPI_FAILURE(acpi_get_handle(bridge, "DSB0.NHI0.SXFP", &SXFP))
+	    || ACPI_FAILURE(acpi_get_handle(bridge, "DSB0.NHI0.SXLV", &SXLV)))
+		return;
+	pci_info(dev, "quirk: cutting power to Thunderbolt controller...\n");
+
+	/* magic sequence */
+	acpi_execute_simple_method(SXIO, NULL, 1);
+	acpi_execute_simple_method(SXFP, NULL, 0);
+	msleep(300);
+	acpi_execute_simple_method(SXLV, NULL, 0);
+	acpi_execute_simple_method(SXIO, NULL, 0);
+	acpi_execute_simple_method(SXLV, NULL, 0);
+}
+DECLARE_PCI_FIXUP_SUSPEND_LATE(PCI_VENDOR_ID_INTEL,
+			       PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C,
+			       quirk_apple_poweroff_thunderbolt);
+#endif
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4469e1a77f3c..8aa7cb972ce5 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -17,6 +17,9 @@ struct pcie_tlp_log;
 
 #define PCI_FIND_CAP_TTL	48
 
+/* Non-static helpers shared with arch/x86/pci/fixup.c */
+void quirk_disable_msi(struct pci_dev *dev);
+
 #define PCI_VSEC_ID_INTEL_TBT	0x1234	/* Thunderbolt */
 
 #define PCIE_LINK_RETRAIN_TIMEOUT_MS	1000
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 146465404a97..162face38504 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -23,16 +23,13 @@
 #include <linux/iommu.h>
 #include <linux/delay.h>
 #include <linux/acpi.h>
-#include <linux/dmi.h>
-#include <linux/ioport.h>
 #include <linux/sched.h>
 #include <linux/ktime.h>
 #include <linux/mm.h>
 #include <linux/nvme.h>
-#include <linux/platform_data/x86/apple.h>
+
 #include <linux/pm_runtime.h>
 #include <linux/sizes.h>
-#include <linux/suspend.h>
 #include <linux/switchtec.h>
 #include "pci.h"
 
@@ -310,28 +307,6 @@ DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_ANY_ID, PCI_ANY_ID,
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MELLANOX, PCI_DEVICE_ID_MELLANOX_TAVOR, pci_disable_parity);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MELLANOX, PCI_DEVICE_ID_MELLANOX_TAVOR_BRIDGE, pci_disable_parity);
 
-#ifdef CONFIG_HAS_IOPORT
-/*
- * Intel NM10 "Tiger Point" LPC PM1a_STS.BM_STS must be clear
- * for some HT machines to use C4 w/o hanging.
- */
-static void quirk_tigerpoint_bm_sts(struct pci_dev *dev)
-{
-	u32 pmbase;
-	u16 pm1a;
-
-	pci_read_config_dword(dev, 0x40, &pmbase);
-	pmbase = pmbase & 0xff80;
-	pm1a = inw(pmbase);
-
-	if (pm1a & 0x10) {
-		pci_info(dev, FW_BUG "Tiger Point LPC.BM_STS cleared\n");
-		outw(0x10, pmbase);
-	}
-}
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_TGP_LPC, quirk_tigerpoint_bm_sts);
-#endif
-
 /*
  * This chip can cause PCI parity errors if config register 0xA0 is read
  * while DMAs are occurring.
@@ -390,19 +365,6 @@ static void quirk_s3_64M(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_S3,	PCI_DEVICE_ID_S3_868,		quirk_s3_64M);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_S3,	PCI_DEVICE_ID_S3_968,		quirk_s3_64M);
 
-/*
- * ATI Northbridge setups MCE the processor if you even read somewhere
- * between 0x3b0->0x3bb or read 0x3d3
- */
-static void quirk_ati_exploding_mce(struct pci_dev *dev)
-{
-	pci_info(dev, "ATI Northbridge, reserving I/O ports 0x3b0 to 0x3bb\n");
-	/* Mae rhaid i ni beidio ag edrych ar y lleoliadiau I/O hyn */
-	request_region(0x3b0, 0x0C, "RadeonIGP");
-	request_region(0x3d3, 0x01, "RadeonIGP");
-}
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI,	PCI_DEVICE_ID_ATI_RS100,   quirk_ati_exploding_mce);
-
 /*
  * In the AMD NL platform, this device ([1022:7912]) has a class code of
  * PCI_CLASS_SERIAL_USB_XHCI (0x0c0330), which means the xhci driver will
@@ -540,34 +502,6 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_DUNORD,	PCI_DEVICE_ID_DUNORD_I3000,	quirk
  * found at http://www.national.com/analog for info on what these bits do.
  * <christer@weinigel.se>
  */
-static void quirk_mediagx_master(struct pci_dev *dev)
-{
-	u8 reg;
-
-	pci_read_config_byte(dev, 0x41, &reg);
-	if (reg & 2) {
-		reg &= ~2;
-		pci_info(dev, "Fixup for MediaGX/Geode Slave Disconnect Boundary (0x41=0x%02x)\n",
-			 reg);
-		pci_write_config_byte(dev, 0x41, reg);
-	}
-}
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CYRIX,	PCI_DEVICE_ID_CYRIX_PCI_MASTER, quirk_mediagx_master);
-DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_CYRIX,	PCI_DEVICE_ID_CYRIX_PCI_MASTER, quirk_mediagx_master);
-
-/* Serverworks CSB5 IDE does not fully support native mode */
-static void quirk_svwks_csb5ide(struct pci_dev *pdev)
-{
-	u8 prog;
-	pci_read_config_byte(pdev, PCI_CLASS_PROG, &prog);
-	if (prog & 5) {
-		prog &= ~5;
-		pdev->class &= ~5;
-		pci_write_config_byte(pdev, PCI_CLASS_PROG, prog);
-		/* PCI layer will sort out resources */
-	}
-}
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_CSB5IDE, quirk_svwks_csb5ide);
 
 /* Some ATA devices break if put into D3 */
 static void quirk_no_ata_d3(struct pci_dev *pdev)
@@ -587,251 +521,6 @@ DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_AL, PCI_ANY_ID,
 DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_VIA, PCI_ANY_ID,
 				PCI_CLASS_STORAGE_IDE, 8, quirk_no_ata_d3);
 
-/*
- * On ASUS P4B boards, the SMBus PCI Device within the ICH2/4 southbridge
- * is not activated. The myth is that Asus said that they do not want the
- * users to be irritated by just another PCI Device in the Win98 device
- * manager. (see the file prog/hotplug/README.p4b in the lm_sensors
- * package 2.7.0 for details)
- *
- * The SMBus PCI Device can be activated by setting a bit in the ICH LPC
- * bridge. Unfortunately, this device has no subvendor/subdevice ID. So it
- * becomes necessary to do this tweak in two steps -- the chosen trigger
- * is either the Host bridge (preferred) or on-board VGA controller.
- *
- * Note that we used to unhide the SMBus that way on Toshiba laptops
- * (Satellite A40 and Tecra M2) but then found that the thermal management
- * was done by SMM code, which could cause unsynchronized concurrent
- * accesses to the SMBus registers, with potentially bad effects. Thus you
- * should be very careful when adding new entries: if SMM is accessing the
- * Intel SMBus, this is a very good reason to leave it hidden.
- *
- * Likewise, many recent laptops use ACPI for thermal management. If the
- * ACPI DSDT code accesses the SMBus, then Linux should not access it
- * natively, and keeping the SMBus hidden is the right thing to do. If you
- * are about to add an entry in the table below, please first disassemble
- * the DSDT and double-check that there is no code accessing the SMBus.
- */
-static int asus_hides_smbus;
-
-static void asus_hides_smbus_hostbridge(struct pci_dev *dev)
-{
-	if (unlikely(dev->subsystem_vendor == PCI_VENDOR_ID_ASUSTEK)) {
-		if (dev->device == PCI_DEVICE_ID_INTEL_82845_HB)
-			switch (dev->subsystem_device) {
-			case 0x8025: /* P4B-LX */
-			case 0x8070: /* P4B */
-			case 0x8088: /* P4B533 */
-			case 0x1626: /* L3C notebook */
-				asus_hides_smbus = 1;
-			}
-		else if (dev->device == PCI_DEVICE_ID_INTEL_82845G_HB)
-			switch (dev->subsystem_device) {
-			case 0x80b1: /* P4GE-V */
-			case 0x80b2: /* P4PE */
-			case 0x8093: /* P4B533-V */
-				asus_hides_smbus = 1;
-			}
-		else if (dev->device == PCI_DEVICE_ID_INTEL_82850_HB)
-			switch (dev->subsystem_device) {
-			case 0x8030: /* P4T533 */
-				asus_hides_smbus = 1;
-			}
-		else if (dev->device == PCI_DEVICE_ID_INTEL_7205_0)
-			switch (dev->subsystem_device) {
-			case 0x8070: /* P4G8X Deluxe */
-				asus_hides_smbus = 1;
-			}
-		else if (dev->device == PCI_DEVICE_ID_INTEL_E7501_MCH)
-			switch (dev->subsystem_device) {
-			case 0x80c9: /* PU-DLS */
-				asus_hides_smbus = 1;
-			}
-		else if (dev->device == PCI_DEVICE_ID_INTEL_82855GM_HB)
-			switch (dev->subsystem_device) {
-			case 0x1751: /* M2N notebook */
-			case 0x1821: /* M5N notebook */
-			case 0x1897: /* A6L notebook */
-				asus_hides_smbus = 1;
-			}
-		else if (dev->device == PCI_DEVICE_ID_INTEL_82855PM_HB)
-			switch (dev->subsystem_device) {
-			case 0x184b: /* W1N notebook */
-			case 0x186a: /* M6Ne notebook */
-				asus_hides_smbus = 1;
-			}
-		else if (dev->device == PCI_DEVICE_ID_INTEL_82865_HB)
-			switch (dev->subsystem_device) {
-			case 0x80f2: /* P4P800-X */
-				asus_hides_smbus = 1;
-			}
-		else if (dev->device == PCI_DEVICE_ID_INTEL_82915GM_HB)
-			switch (dev->subsystem_device) {
-			case 0x1882: /* M6V notebook */
-			case 0x1977: /* A6VA notebook */
-				asus_hides_smbus = 1;
-			}
-	} else if (unlikely(dev->subsystem_vendor == PCI_VENDOR_ID_HP)) {
-		if (dev->device ==  PCI_DEVICE_ID_INTEL_82855PM_HB)
-			switch (dev->subsystem_device) {
-			case 0x088C: /* HP Compaq nc8000 */
-			case 0x0890: /* HP Compaq nc6000 */
-				asus_hides_smbus = 1;
-			}
-		else if (dev->device == PCI_DEVICE_ID_INTEL_82865_HB)
-			switch (dev->subsystem_device) {
-			case 0x12bc: /* HP D330L */
-			case 0x12bd: /* HP D530 */
-			case 0x006a: /* HP Compaq nx9500 */
-				asus_hides_smbus = 1;
-			}
-		else if (dev->device == PCI_DEVICE_ID_INTEL_82875_HB)
-			switch (dev->subsystem_device) {
-			case 0x12bf: /* HP xw4100 */
-				asus_hides_smbus = 1;
-			}
-	} else if (unlikely(dev->subsystem_vendor == PCI_VENDOR_ID_SAMSUNG)) {
-		if (dev->device ==  PCI_DEVICE_ID_INTEL_82855PM_HB)
-			switch (dev->subsystem_device) {
-			case 0xC00C: /* Samsung P35 notebook */
-				asus_hides_smbus = 1;
-		}
-	} else if (unlikely(dev->subsystem_vendor == PCI_VENDOR_ID_COMPAQ)) {
-		if (dev->device == PCI_DEVICE_ID_INTEL_82855PM_HB)
-			switch (dev->subsystem_device) {
-			case 0x0058: /* Compaq Evo N620c */
-				asus_hides_smbus = 1;
-			}
-		else if (dev->device == PCI_DEVICE_ID_INTEL_82810_IG3)
-			switch (dev->subsystem_device) {
-			case 0xB16C: /* Compaq Deskpro EP 401963-001 (PCA# 010174) */
-				/* Motherboard doesn't have Host bridge
-				 * subvendor/subdevice IDs, therefore checking
-				 * its on-board VGA controller */
-				asus_hides_smbus = 1;
-			}
-		else if (dev->device == PCI_DEVICE_ID_INTEL_82801DB_2)
-			switch (dev->subsystem_device) {
-			case 0x00b8: /* Compaq Evo D510 CMT */
-			case 0x00b9: /* Compaq Evo D510 SFF */
-			case 0x00ba: /* Compaq Evo D510 USDT */
-				/* Motherboard doesn't have Host bridge
-				 * subvendor/subdevice IDs and on-board VGA
-				 * controller is disabled if an AGP card is
-				 * inserted, therefore checking USB UHCI
-				 * Controller #1 */
-				asus_hides_smbus = 1;
-			}
-		else if (dev->device == PCI_DEVICE_ID_INTEL_82815_CGC)
-			switch (dev->subsystem_device) {
-			case 0x001A: /* Compaq Deskpro EN SSF P667 815E */
-				/* Motherboard doesn't have host bridge
-				 * subvendor/subdevice IDs, therefore checking
-				 * its on-board VGA controller */
-				asus_hides_smbus = 1;
-			}
-	}
-}
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82845_HB,	asus_hides_smbus_hostbridge);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82845G_HB,	asus_hides_smbus_hostbridge);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82850_HB,	asus_hides_smbus_hostbridge);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82865_HB,	asus_hides_smbus_hostbridge);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82875_HB,	asus_hides_smbus_hostbridge);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_7205_0,	asus_hides_smbus_hostbridge);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_E7501_MCH,	asus_hides_smbus_hostbridge);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82855PM_HB,	asus_hides_smbus_hostbridge);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82855GM_HB,	asus_hides_smbus_hostbridge);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82915GM_HB, asus_hides_smbus_hostbridge);
-
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82810_IG3,	asus_hides_smbus_hostbridge);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801DB_2,	asus_hides_smbus_hostbridge);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82815_CGC,	asus_hides_smbus_hostbridge);
-
-static void asus_hides_smbus_lpc(struct pci_dev *dev)
-{
-	u16 val;
-
-	if (likely(!asus_hides_smbus))
-		return;
-
-	pci_read_config_word(dev, 0xF2, &val);
-	if (val & 0x8) {
-		pci_write_config_word(dev, 0xF2, val & (~0x8));
-		pci_read_config_word(dev, 0xF2, &val);
-		if (val & 0x8)
-			pci_info(dev, "i801 SMBus device continues to play 'hide and seek'! 0x%x\n",
-				 val);
-		else
-			pci_info(dev, "Enabled i801 SMBus device\n");
-	}
-}
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801AA_0,	asus_hides_smbus_lpc);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801DB_0,	asus_hides_smbus_lpc);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801BA_0,	asus_hides_smbus_lpc);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801CA_0,	asus_hides_smbus_lpc);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801CA_12,	asus_hides_smbus_lpc);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801DB_12,	asus_hides_smbus_lpc);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801EB_0,	asus_hides_smbus_lpc);
-DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801AA_0,	asus_hides_smbus_lpc);
-DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801DB_0,	asus_hides_smbus_lpc);
-DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801BA_0,	asus_hides_smbus_lpc);
-DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801CA_0,	asus_hides_smbus_lpc);
-DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801CA_12,	asus_hides_smbus_lpc);
-DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801DB_12,	asus_hides_smbus_lpc);
-DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801EB_0,	asus_hides_smbus_lpc);
-
-/* It appears we just have one such device. If not, we have a warning */
-static void __iomem *asus_rcba_base;
-static void asus_hides_smbus_lpc_ich6_suspend(struct pci_dev *dev)
-{
-	u32 rcba;
-
-	if (likely(!asus_hides_smbus))
-		return;
-	WARN_ON(asus_rcba_base);
-
-	pci_read_config_dword(dev, 0xF0, &rcba);
-	/* use bits 31:14, 16 kB aligned */
-	asus_rcba_base = ioremap(rcba & 0xFFFFC000, 0x4000);
-	if (asus_rcba_base == NULL)
-		return;
-}
-
-static void asus_hides_smbus_lpc_ich6_resume_early(struct pci_dev *dev)
-{
-	u32 val;
-
-	if (likely(!asus_hides_smbus || !asus_rcba_base))
-		return;
-
-	/* read the Function Disable register, dword mode only */
-	val = readl(asus_rcba_base + 0x3418);
-
-	/* enable the SMBus device */
-	writel(val & 0xFFFFFFF7, asus_rcba_base + 0x3418);
-}
-
-static void asus_hides_smbus_lpc_ich6_resume(struct pci_dev *dev)
-{
-	if (likely(!asus_hides_smbus || !asus_rcba_base))
-		return;
-
-	iounmap(asus_rcba_base);
-	asus_rcba_base = NULL;
-	pci_info(dev, "Enabled ICH6/i801 SMBus device\n");
-}
-
-static void asus_hides_smbus_lpc_ich6(struct pci_dev *dev)
-{
-	asus_hides_smbus_lpc_ich6_suspend(dev);
-	asus_hides_smbus_lpc_ich6_resume_early(dev);
-	asus_hides_smbus_lpc_ich6_resume(dev);
-}
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH6_1,	asus_hides_smbus_lpc_ich6);
-DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH6_1,	asus_hides_smbus_lpc_ich6_suspend);
-DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH6_1,	asus_hides_smbus_lpc_ich6_resume);
-DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH6_1,	asus_hides_smbus_lpc_ich6_resume_early);
-
 #if defined(CONFIG_ATA) || defined(CONFIG_ATA_MODULE)
 
 /*
@@ -1311,27 +1000,6 @@ static void fixup_rev1_53c810(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NCR, PCI_DEVICE_ID_NCR_53C810, fixup_rev1_53c810);
 
-/*
- * Under some circumstances, AER is not linked with extended capabilities.
- * Force it to be linked by setting the corresponding control bit in the
- * config space.
- */
-static void quirk_nvidia_ck804_pcie_aer_ext_cap(struct pci_dev *dev)
-{
-	uint8_t b;
-
-	if (pci_read_config_byte(dev, 0xf41, &b) == 0) {
-		if (!(b & 0x20)) {
-			pci_write_config_byte(dev, 0xf41, b | 0x20);
-			pci_info(dev, "Linking AER extended capability\n");
-		}
-	}
-}
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA,  PCI_DEVICE_ID_NVIDIA_CK804_PCIE,
-			quirk_nvidia_ck804_pcie_aer_ext_cap);
-DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_NVIDIA,  PCI_DEVICE_ID_NVIDIA_CK804_PCIE,
-			quirk_nvidia_ck804_pcie_aer_ext_cap);
-
 static void quirk_brcm_5719_limit_mrrs(struct pci_dev *dev)
 {
 	u32 rev;
@@ -1373,7 +1041,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SI, 0x0761, quirk_disable_all_msi);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SAMSUNG, 0xa5e3, quirk_disable_all_msi);
 
 /* Disable MSI on chipsets that are known to not support it */
-static void quirk_disable_msi(struct pci_dev *dev)
+void quirk_disable_msi(struct pci_dev *dev)
 {
 	if (dev->subordinate) {
 		pci_warn(dev, "MSI quirk detected; subordinate MSI disabled\n");
@@ -1405,109 +1073,6 @@ static void quirk_amd_780_apc_msi(struct pci_dev *host_bridge)
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x9600, quirk_amd_780_apc_msi);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x9601, quirk_amd_780_apc_msi);
 
-/*
- * Go through the list of HyperTransport capabilities and return 1 if a HT
- * MSI capability is found and enabled.
- */
-static int msi_ht_cap_enabled(struct pci_dev *dev)
-{
-	int pos, ttl = PCI_FIND_CAP_TTL;
-
-	pos = pci_find_ht_capability(dev, HT_CAPTYPE_MSI_MAPPING);
-	while (pos && ttl--) {
-		u8 flags;
-
-		if (pci_read_config_byte(dev, pos + HT_MSI_FLAGS,
-					 &flags) == 0) {
-			pci_info(dev, "Found %s HT MSI Mapping\n",
-				flags & HT_MSI_FLAGS_ENABLE ?
-				"enabled" : "disabled");
-			return (flags & HT_MSI_FLAGS_ENABLE) != 0;
-		}
-
-		pos = pci_find_next_ht_capability(dev, pos,
-						  HT_CAPTYPE_MSI_MAPPING);
-	}
-	return 0;
-}
-
-/* Check the HyperTransport MSI mapping to know whether MSI is enabled or not */
-static void quirk_msi_ht_cap(struct pci_dev *dev)
-{
-	if (!msi_ht_cap_enabled(dev))
-		quirk_disable_msi(dev);
-}
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_HT2000_PCIE,
-			quirk_msi_ht_cap);
-
-/*
- * The nVidia CK804 chipset may have 2 HT MSI mappings.  MSI is supported
- * if the MSI capability is set in any of these mappings.
- */
-static void quirk_nvidia_ck804_msi_ht_cap(struct pci_dev *dev)
-{
-	struct pci_dev *pdev;
-
-	/*
-	 * Check HT MSI cap on this chipset and the root one.  A single one
-	 * having MSI is enough to be sure that MSI is supported.
-	 */
-	pdev = pci_get_slot(dev->bus, 0);
-	if (!pdev)
-		return;
-	if (!msi_ht_cap_enabled(pdev))
-		quirk_msi_ht_cap(dev);
-	pci_dev_put(pdev);
-}
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_CK804_PCIE,
-			quirk_nvidia_ck804_msi_ht_cap);
-
-/* Force enable MSI mapping capability on HT bridges */
-static void ht_enable_msi_mapping(struct pci_dev *dev)
-{
-	int pos, ttl = PCI_FIND_CAP_TTL;
-
-	pos = pci_find_ht_capability(dev, HT_CAPTYPE_MSI_MAPPING);
-	while (pos && ttl--) {
-		u8 flags;
-
-		if (pci_read_config_byte(dev, pos + HT_MSI_FLAGS,
-					 &flags) == 0) {
-			pci_info(dev, "Enabling HT MSI Mapping\n");
-
-			pci_write_config_byte(dev, pos + HT_MSI_FLAGS,
-					      flags | HT_MSI_FLAGS_ENABLE);
-		}
-		pos = pci_find_next_ht_capability(dev, pos,
-						  HT_CAPTYPE_MSI_MAPPING);
-	}
-}
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SERVERWORKS,
-			 PCI_DEVICE_ID_SERVERWORKS_HT1000_PXB,
-			 ht_enable_msi_mapping);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_8132_BRIDGE,
-			 ht_enable_msi_mapping);
-
-/*
- * The P5N32-SLI motherboards from Asus have a problem with MSI
- * for the MCP55 NIC. It is not yet determined whether the MSI problem
- * also affects other devices. As for now, turn off MSI for this device.
- */
-static void nvenet_msi_disable(struct pci_dev *dev)
-{
-	const char *board_name = dmi_get_system_info(DMI_BOARD_NAME);
-
-	if (board_name &&
-	    (strstr(board_name, "P5N32-SLI PREMIUM") ||
-	     strstr(board_name, "P5N32-E SLI"))) {
-		pci_info(dev, "Disabling MSI for MCP55 NIC on P5N32-SLI\n");
-		dev->no_msi = 1;
-	}
-}
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA,
-			PCI_DEVICE_ID_NVIDIA_NVENET_15,
-			nvenet_msi_disable);
-
 /*
  * PCIe spec r6.0 sec 6.1.4.3 says that if MSI/MSI-X is enabled, the device
  * can't use INTx interrupts. Tegra's PCIe Root Ports don't generate MSI
@@ -1570,248 +1135,6 @@ DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_NVIDIA, 0x229e,
 			      PCI_CLASS_BRIDGE_PCI, 8,
 			      pci_quirk_nvidia_tegra_disable_rp_msi);
 
-/*
- * Some versions of the MCP55 bridge from Nvidia have a legacy IRQ routing
- * config register.  This register controls the routing of legacy
- * interrupts from devices that route through the MCP55.  If this register
- * is misprogrammed, interrupts are only sent to the BSP, unlike
- * conventional systems where the IRQ is broadcast to all online CPUs.  Not
- * having this register set properly prevents kdump from booting up
- * properly, so let's make sure that we have it set correctly.
- * Note that this is an undocumented register.
- */
-static void nvbridge_check_legacy_irq_routing(struct pci_dev *dev)
-{
-	u32 cfg;
-
-	if (!pci_find_capability(dev, PCI_CAP_ID_HT))
-		return;
-
-	pci_read_config_dword(dev, 0x74, &cfg);
-
-	if (cfg & ((1 << 2) | (1 << 15))) {
-		pr_info("Rewriting IRQ routing register on MCP55\n");
-		cfg &= ~((1 << 2) | (1 << 15));
-		pci_write_config_dword(dev, 0x74, cfg);
-	}
-}
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA,
-			PCI_DEVICE_ID_NVIDIA_MCP55_BRIDGE_V0,
-			nvbridge_check_legacy_irq_routing);
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA,
-			PCI_DEVICE_ID_NVIDIA_MCP55_BRIDGE_V4,
-			nvbridge_check_legacy_irq_routing);
-
-static int ht_check_msi_mapping(struct pci_dev *dev)
-{
-	int pos, ttl = PCI_FIND_CAP_TTL;
-	int found = 0;
-
-	/* Check if there is HT MSI cap or enabled on this device */
-	pos = pci_find_ht_capability(dev, HT_CAPTYPE_MSI_MAPPING);
-	while (pos && ttl--) {
-		u8 flags;
-
-		if (found < 1)
-			found = 1;
-		if (pci_read_config_byte(dev, pos + HT_MSI_FLAGS,
-					 &flags) == 0) {
-			if (flags & HT_MSI_FLAGS_ENABLE) {
-				if (found < 2) {
-					found = 2;
-					break;
-				}
-			}
-		}
-		pos = pci_find_next_ht_capability(dev, pos,
-						  HT_CAPTYPE_MSI_MAPPING);
-	}
-
-	return found;
-}
-
-static int host_bridge_with_leaf(struct pci_dev *host_bridge)
-{
-	struct pci_dev *dev;
-	int pos;
-	int i, dev_no;
-	int found = 0;
-
-	dev_no = host_bridge->devfn >> 3;
-	for (i = dev_no + 1; i < 0x20; i++) {
-		dev = pci_get_slot(host_bridge->bus, PCI_DEVFN(i, 0));
-		if (!dev)
-			continue;
-
-		/* found next host bridge? */
-		pos = pci_find_ht_capability(dev, HT_CAPTYPE_SLAVE);
-		if (pos != 0) {
-			pci_dev_put(dev);
-			break;
-		}
-
-		if (ht_check_msi_mapping(dev)) {
-			found = 1;
-			pci_dev_put(dev);
-			break;
-		}
-		pci_dev_put(dev);
-	}
-
-	return found;
-}
-
-#define PCI_HT_CAP_SLAVE_CTRL0     4    /* link control */
-#define PCI_HT_CAP_SLAVE_CTRL1     8    /* link control to */
-
-static int is_end_of_ht_chain(struct pci_dev *dev)
-{
-	int pos, ctrl_off;
-	int end = 0;
-	u16 flags, ctrl;
-
-	pos = pci_find_ht_capability(dev, HT_CAPTYPE_SLAVE);
-
-	if (!pos)
-		goto out;
-
-	pci_read_config_word(dev, pos + PCI_CAP_FLAGS, &flags);
-
-	ctrl_off = ((flags >> 10) & 1) ?
-			PCI_HT_CAP_SLAVE_CTRL0 : PCI_HT_CAP_SLAVE_CTRL1;
-	pci_read_config_word(dev, pos + ctrl_off, &ctrl);
-
-	if (ctrl & (1 << 6))
-		end = 1;
-
-out:
-	return end;
-}
-
-static void nv_ht_enable_msi_mapping(struct pci_dev *dev)
-{
-	struct pci_dev *host_bridge;
-	int pos;
-	int i, dev_no;
-	int found = 0;
-
-	dev_no = dev->devfn >> 3;
-	for (i = dev_no; i >= 0; i--) {
-		host_bridge = pci_get_slot(dev->bus, PCI_DEVFN(i, 0));
-		if (!host_bridge)
-			continue;
-
-		pos = pci_find_ht_capability(host_bridge, HT_CAPTYPE_SLAVE);
-		if (pos != 0) {
-			found = 1;
-			break;
-		}
-		pci_dev_put(host_bridge);
-	}
-
-	if (!found)
-		return;
-
-	/* don't enable end_device/host_bridge with leaf directly here */
-	if (host_bridge == dev && is_end_of_ht_chain(host_bridge) &&
-	    host_bridge_with_leaf(host_bridge))
-		goto out;
-
-	/* root did that ! */
-	if (msi_ht_cap_enabled(host_bridge))
-		goto out;
-
-	ht_enable_msi_mapping(dev);
-
-out:
-	pci_dev_put(host_bridge);
-}
-
-static void ht_disable_msi_mapping(struct pci_dev *dev)
-{
-	int pos, ttl = PCI_FIND_CAP_TTL;
-
-	pos = pci_find_ht_capability(dev, HT_CAPTYPE_MSI_MAPPING);
-	while (pos && ttl--) {
-		u8 flags;
-
-		if (pci_read_config_byte(dev, pos + HT_MSI_FLAGS,
-					 &flags) == 0) {
-			pci_info(dev, "Disabling HT MSI Mapping\n");
-
-			pci_write_config_byte(dev, pos + HT_MSI_FLAGS,
-					      flags & ~HT_MSI_FLAGS_ENABLE);
-		}
-		pos = pci_find_next_ht_capability(dev, pos,
-						  HT_CAPTYPE_MSI_MAPPING);
-	}
-}
-
-static void __nv_msi_ht_cap_quirk(struct pci_dev *dev, int all)
-{
-	struct pci_dev *host_bridge;
-	int pos;
-	int found;
-
-	if (!pci_msi_enabled())
-		return;
-
-	/* check if there is HT MSI cap or enabled on this device */
-	found = ht_check_msi_mapping(dev);
-
-	/* no HT MSI CAP */
-	if (found == 0)
-		return;
-
-	/*
-	 * HT MSI mapping should be disabled on devices that are below
-	 * a non-HyperTransport host bridge. Locate the host bridge.
-	 */
-	host_bridge = pci_get_domain_bus_and_slot(pci_domain_nr(dev->bus), 0,
-						  PCI_DEVFN(0, 0));
-	if (host_bridge == NULL) {
-		pci_warn(dev, "nv_msi_ht_cap_quirk didn't locate host bridge\n");
-		return;
-	}
-
-	pos = pci_find_ht_capability(host_bridge, HT_CAPTYPE_SLAVE);
-	if (pos != 0) {
-		/* Host bridge is to HT */
-		if (found == 1) {
-			/* it is not enabled, try to enable it */
-			if (all)
-				ht_enable_msi_mapping(dev);
-			else
-				nv_ht_enable_msi_mapping(dev);
-		}
-		goto out;
-	}
-
-	/* HT MSI is not enabled */
-	if (found == 1)
-		goto out;
-
-	/* Host bridge is not to HT, disable HT MSI mapping on this device */
-	ht_disable_msi_mapping(dev);
-
-out:
-	pci_dev_put(host_bridge);
-}
-
-static void nv_msi_ht_cap_quirk_all(struct pci_dev *dev)
-{
-	return __nv_msi_ht_cap_quirk(dev, 1);
-}
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AL, PCI_ANY_ID, nv_msi_ht_cap_quirk_all);
-DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_AL, PCI_ANY_ID, nv_msi_ht_cap_quirk_all);
-
-static void nv_msi_ht_cap_quirk_leaf(struct pci_dev *dev)
-{
-	return __nv_msi_ht_cap_quirk(dev, 0);
-}
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID, nv_msi_ht_cap_quirk_leaf);
-DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID, nv_msi_ht_cap_quirk_leaf);
-
 static void quirk_msi_intx_disable_bug(struct pci_dev *dev)
 {
 	dev->dev_flags |= PCI_DEV_FLAGS_MSI_INTX_DISABLE_BUG;
@@ -2052,30 +1375,6 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_RICOH, PCI_DEVICE_ID_RICOH_R5CE823, ricoh_
 DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_RICOH, PCI_DEVICE_ID_RICOH_R5CE823, ricoh_mmc_fixup_r5c832);
 #endif /*CONFIG_MMC_RICOH_MMC*/
 
-#ifdef CONFIG_DMAR_TABLE
-#define VTUNCERRMSK_REG	0x1ac
-#define VTD_MSK_SPEC_ERRORS	(1 << 31)
-/*
- * This is a quirk for masking VT-d spec-defined errors to platform error
- * handling logic. Without this, platforms using Intel 7500, 5500 chipsets
- * (and the derivative chipsets like X58 etc) seem to generate NMI/SMI (based
- * on the RAS config settings of the platform) when a VT-d fault happens.
- * The resulting SMI caused the system to hang.
- *
- * VT-d spec-related errors are already handled by the VT-d OS code, so no
- * need to report the same error through other channels.
- */
-static void vtd_mask_spec_errors(struct pci_dev *dev)
-{
-	u32 word;
-
-	pci_read_config_dword(dev, VTUNCERRMSK_REG, &word);
-	pci_write_config_dword(dev, VTUNCERRMSK_REG, word | VTD_MSK_SPEC_ERRORS);
-}
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x342e, vtd_mask_spec_errors);
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x3c28, vtd_mask_spec_errors);
-#endif
-
 static void fixup_ti816x_class(struct pci_dev *dev)
 {
 	u32 class = dev->class;
@@ -2366,70 +1665,6 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_PORT_RIDGE,
 			quirk_thunderbolt_hotplug_msi);
 
-#ifdef CONFIG_ACPI
-/*
- * Apple: Shutdown Cactus Ridge Thunderbolt controller.
- *
- * On Apple hardware the Cactus Ridge Thunderbolt controller needs to be
- * shutdown before suspend. Otherwise the native host interface (NHI) will not
- * be present after resume if a device was plugged in before suspend.
- *
- * The Thunderbolt controller consists of a PCIe switch with downstream
- * bridges leading to the NHI and to the tunnel PCI bridges.
- *
- * This quirk cuts power to the whole chip. Therefore we have to apply it
- * during suspend_noirq of the upstream bridge.
- *
- * Power is automagically restored before resume. No action is needed.
- */
-static void quirk_apple_poweroff_thunderbolt(struct pci_dev *dev)
-{
-	acpi_handle bridge, SXIO, SXFP, SXLV;
-
-	if (!x86_apple_machine)
-		return;
-	if (pci_pcie_type(dev) != PCI_EXP_TYPE_UPSTREAM)
-		return;
-
-	/*
-	 * SXIO/SXFP/SXLF turns off power to the Thunderbolt controller.
-	 * We don't know how to turn it back on again, but firmware does,
-	 * so we can only use SXIO/SXFP/SXLF if we're suspending via
-	 * firmware.
-	 */
-	if (!pm_suspend_via_firmware())
-		return;
-
-	bridge = ACPI_HANDLE(&dev->dev);
-	if (!bridge)
-		return;
-
-	/*
-	 * SXIO and SXLV are present only on machines requiring this quirk.
-	 * Thunderbolt bridges in external devices might have the same
-	 * device ID as those on the host, but they will not have the
-	 * associated ACPI methods. This implicitly checks that we are at
-	 * the right bridge.
-	 */
-	if (ACPI_FAILURE(acpi_get_handle(bridge, "DSB0.NHI0.SXIO", &SXIO))
-	    || ACPI_FAILURE(acpi_get_handle(bridge, "DSB0.NHI0.SXFP", &SXFP))
-	    || ACPI_FAILURE(acpi_get_handle(bridge, "DSB0.NHI0.SXLV", &SXLV)))
-		return;
-	pci_info(dev, "quirk: cutting power to Thunderbolt controller...\n");
-
-	/* magic sequence */
-	acpi_execute_simple_method(SXIO, NULL, 1);
-	acpi_execute_simple_method(SXFP, NULL, 0);
-	msleep(300);
-	acpi_execute_simple_method(SXLV, NULL, 0);
-	acpi_execute_simple_method(SXIO, NULL, 0);
-	acpi_execute_simple_method(SXLV, NULL, 0);
-}
-DECLARE_PCI_FIXUP_SUSPEND_LATE(PCI_VENDOR_ID_INTEL,
-			       PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C,
-			       quirk_apple_poweroff_thunderbolt);
-#endif
-
 /*
  * Following are device-specific reset methods which can be used to
  * reset a single function if other methods (e.g. FLR, PM D0->D3) are
-- 
2.55.0

