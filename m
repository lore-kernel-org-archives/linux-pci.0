Return-Path: <SRS0=IfUz=OK=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7B4C04EB9
	for <linux-pci@archiver.kernel.org>; Sat,  1 Dec 2018 20:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43DF32147D
	for <linux-pci@archiver.kernel.org>; Sat,  1 Dec 2018 20:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JSUbWhbc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43DF32147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725743AbeLBHzN (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 2 Dec 2018 02:55:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:52974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725726AbeLBHzN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 2 Dec 2018 02:55:13 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [40.87.65.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FA7221486;
        Sat,  1 Dec 2018 20:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543696910;
        bh=tpL6eAUpbiOOTUrjlNodxpjn5AE4o2eUa9zyLxEmeVc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JSUbWhbca+Q3FYqR1mR8ZDUO07BYW9rwZLmaUGARxfQ/e26Z6/Lqf3UpdzqjISF6K
         k/6V6dEM+uyhOgPRlmtCiS3137mHSw6k7gLlnTbw0GpMpBMEME8iBW/MNcbzcwqXtU
         rvzImdysQkF3SSeTlhQqIWY4fYGRqpEkuDRGXtNM=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Sinan Kaya <okaya@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Robert Moore <robert.moore@intel.com>,
        Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v1 2/2] PCI/ACPI: alloc ACPI to be built without PCI support
Date:   Sat,  1 Dec 2018 20:41:36 +0000
Message-Id: <20181201204137.1786-2-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181201204137.1786-1-okaya@kernel.org>
References: <20181201204137.1786-1-okaya@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

We are compiling PCI code today for systems with ACPI and no PCI
device present. Remove the useless code and reduce the tight
dependency.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 arch/x86/include/asm/pci_x86.h | 5 +++++
 drivers/acpi/Kconfig           | 1 -
 drivers/acpi/Makefile          | 2 +-
 drivers/acpi/internal.h        | 5 +++++
 drivers/pci/Makefile           | 2 +-
 include/acpi/acpi_drivers.h    | 5 +++++
 include/linux/acpi.h           | 6 ++++++
 include/linux/pci.h            | 4 ++++
 8 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
index 959d618dbb17..940cf12e7d05 100644
--- a/arch/x86/include/asm/pci_x86.h
+++ b/arch/x86/include/asm/pci_x86.h
@@ -121,7 +121,12 @@ extern void __init dmi_check_pciprobe(void);
 extern void __init dmi_check_skip_isa_align(void);
 
 /* some common used subsys_initcalls */
+#ifdef CONFIG_PCI
 extern int __init pci_acpi_init(void);
+#else
+static inline int  __init pci_acpi_init(void)
+{ return -EINVAL; }
+#endif
 extern void __init pcibios_irq_init(void);
 extern int __init pcibios_init(void);
 extern int pci_legacy_init(void);
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 7cea769c37df..a0abcb3bd673 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -9,7 +9,6 @@ config ARCH_SUPPORTS_ACPI
 menuconfig ACPI
 	bool "ACPI (Advanced Configuration and Power Interface) Support"
 	depends on ARCH_SUPPORTS_ACPI
-	depends on PCI
 	select PNP
 	default y if X86
 	help
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index edc039313cd6..7c6afc111d76 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -39,7 +39,7 @@ acpi-y				+= processor_core.o
 acpi-$(CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC) += processor_pdc.o
 acpi-y				+= ec.o
 acpi-$(CONFIG_ACPI_DOCK)	+= dock.o
-acpi-y				+= pci_root.o pci_link.o pci_irq.o
+acpi-$(CONFIG_PCI)		+= pci_root.o pci_link.o pci_irq.o
 obj-$(CONFIG_ACPI_MCFG)		+= pci_mcfg.o
 acpi-y				+= acpi_lpss.o acpi_apd.o
 acpi-y				+= acpi_platform.o
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 530a3f675490..b7060dae2789 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -25,8 +25,13 @@ int acpi_osi_init(void);
 acpi_status acpi_os_initialize1(void);
 void init_acpi_device_notify(void);
 int acpi_scan_init(void);
+#ifdef CONFIG_PCI
 void acpi_pci_root_init(void);
 void acpi_pci_link_init(void);
+#else
+static inline void acpi_pci_root_init(void) {}
+static inline void acpi_pci_link_init(void) {}
+#endif
 void acpi_processor_init(void);
 void acpi_platform_init(void);
 void acpi_pnp_init(void);
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index f2bda77a2df1..657d642fcc67 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -11,6 +11,7 @@ ifdef CONFIG_PCI
 obj-$(CONFIG_PROC_FS)		+= proc.o
 obj-$(CONFIG_SYSFS)		+= slot.o
 obj-$(CONFIG_OF)		+= of.o
+obj-$(CONFIG_ACPI)		+= pci-acpi.o
 endif
 
 obj-$(CONFIG_PCI_QUIRKS)	+= quirks.o
@@ -20,7 +21,6 @@ obj-$(CONFIG_PCI_MSI)		+= msi.o
 obj-$(CONFIG_PCI_ATS)		+= ats.o
 obj-$(CONFIG_PCI_IOV)		+= iov.o
 obj-$(CONFIG_PCI_BRIDGE_EMUL)	+= pci-bridge-emul.o
-obj-$(CONFIG_ACPI)		+= pci-acpi.o
 obj-$(CONFIG_PCI_LABEL)		+= pci-label.o
 obj-$(CONFIG_X86_INTEL_MID)	+= pci-mid.o
 obj-$(CONFIG_PCI_SYSCALL)	+= syscall.o
diff --git a/include/acpi/acpi_drivers.h b/include/acpi/acpi_drivers.h
index 14499757338f..9b7f87d86448 100644
--- a/include/acpi/acpi_drivers.h
+++ b/include/acpi/acpi_drivers.h
@@ -88,7 +88,12 @@ int acpi_pci_link_free_irq(acpi_handle handle);
 
 struct pci_bus;
 
+#ifdef CONFIG_PCI
 struct pci_dev *acpi_get_pci_dev(acpi_handle);
+#else
+static inline struct pci_dev *acpi_get_pci_dev(acpi_handle hndl)
+{ return NULL; }
+#endif
 
 /* Arch-defined function to add a bus to the system */
 
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index ed80f147bd50..3273e7a62128 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -340,7 +340,13 @@ struct pci_dev;
 int acpi_pci_irq_enable (struct pci_dev *dev);
 void acpi_penalize_isa_irq(int irq, int active);
 bool acpi_isa_irq_available(int irq);
+#ifdef CONFIG_PCI
 void acpi_penalize_sci_irq(int irq, int trigger, int polarity);
+#else
+static inline void acpi_penalize_sci_irq(int irq, int trigger,
+					int polarity)
+{}
+#endif
 void acpi_pci_irq_disable (struct pci_dev *dev);
 
 extern int ec_read(u8 addr, u8 *val);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 15407f469d41..206c6a55e538 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1992,7 +1992,11 @@ int pcibios_set_pcie_reset_state(struct pci_dev *dev,
 				 enum pcie_reset_state state);
 int pcibios_add_device(struct pci_dev *dev);
 void pcibios_release_device(struct pci_dev *dev);
+#ifdef CONFIG_PCI
 void pcibios_penalize_isa_irq(int irq, int active);
+#else
+static inline void pcibios_penalize_isa_irq(int irq, int active) {}
+#endif
 int pcibios_alloc_irq(struct pci_dev *dev);
 void pcibios_free_irq(struct pci_dev *dev);
 resource_size_t pcibios_default_alignment(void);
-- 
2.19.0

