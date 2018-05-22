Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH v1 1/3] xtensa/PCI: Remove dead code
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org
Date: Tue, 22 May 2018 08:10:14 -0500
Message-ID: <152699461445.162480.8740249758106045185.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152699456050.162480.13521209483758803324.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152699456050.162480.13521209483758803324.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

Remove the following unused functions:

  pcibios_enable_resources()
  pcibios_alloc_controller()
  pci_controller_num()

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/xtensa/include/asm/pci.h |    2 -
 arch/xtensa/kernel/pci.c      |   59 -----------------------------------------
 2 files changed, 61 deletions(-)

diff --git a/arch/xtensa/include/asm/pci.h b/arch/xtensa/include/asm/pci.h
index d5a82153a7c5..a94d4b281f4c 100644
--- a/arch/xtensa/include/asm/pci.h
+++ b/arch/xtensa/include/asm/pci.h
@@ -20,8 +20,6 @@
 
 #define pcibios_assign_all_busses()	0
 
-extern struct pci_controller* pcibios_alloc_controller(void);
-
 /* Assume some values. (We should revise them, if necessary) */
 
 #define PCIBIOS_MIN_IO		0x2000
diff --git a/arch/xtensa/kernel/pci.c b/arch/xtensa/kernel/pci.c
index b7c7a60c7000..d451b4f5b1e0 100644
--- a/arch/xtensa/kernel/pci.c
+++ b/arch/xtensa/kernel/pci.c
@@ -80,50 +80,6 @@ pcibios_align_resource(void *data, const struct resource *res,
 	return start;
 }
 
-int
-pcibios_enable_resources(struct pci_dev *dev, int mask)
-{
-	u16 cmd, old_cmd;
-	int idx;
-	struct resource *r;
-
-	pci_read_config_word(dev, PCI_COMMAND, &cmd);
-	old_cmd = cmd;
-	for(idx=0; idx<6; idx++) {
-		r = &dev->resource[idx];
-		if (!r->start && r->end) {
-			pr_err("PCI: Device %s not available because "
-			       "of resource collisions\n", pci_name(dev));
-			return -EINVAL;
-		}
-		if (r->flags & IORESOURCE_IO)
-			cmd |= PCI_COMMAND_IO;
-		if (r->flags & IORESOURCE_MEM)
-			cmd |= PCI_COMMAND_MEMORY;
-	}
-	if (dev->resource[PCI_ROM_RESOURCE].start)
-		cmd |= PCI_COMMAND_MEMORY;
-	if (cmd != old_cmd) {
-		pr_info("PCI: Enabling device %s (%04x -> %04x)\n",
-			pci_name(dev), old_cmd, cmd);
-		pci_write_config_word(dev, PCI_COMMAND, cmd);
-	}
-	return 0;
-}
-
-struct pci_controller * __init pcibios_alloc_controller(void)
-{
-	struct pci_controller *pci_ctrl;
-
-	pci_ctrl = (struct pci_controller *)alloc_bootmem(sizeof(*pci_ctrl));
-	memset(pci_ctrl, 0, sizeof(struct pci_controller));
-
-	*pci_ctrl_tail = pci_ctrl;
-	pci_ctrl_tail = &pci_ctrl->next;
-
-	return pci_ctrl;
-}
-
 static void __init pci_controller_apertures(struct pci_controller *pci_ctrl,
 					    struct list_head *resources)
 {
@@ -241,21 +197,6 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
 	return 0;
 }
 
-#ifdef CONFIG_PROC_FS
-
-/*
- * Return the index of the PCI controller for device pdev.
- */
-
-int
-pci_controller_num(struct pci_dev *dev)
-{
-	struct pci_controller *pci_ctrl = (struct pci_controller*) dev->sysdata;
-	return pci_ctrl->index;
-}
-
-#endif /* CONFIG_PROC_FS */
-
 /*
  * Platform support for /proc/bus/pci/X/Y mmap()s.
  *  -- paulus.
