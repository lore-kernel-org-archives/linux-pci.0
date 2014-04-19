Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Myron Stowe <myron.stowe@redhat.com>
Subject: [PATCH v2 5/5] PCI: Remove redundant 'quirk_amd_nb_node'
To: bhelgaas@google.com, linux-pci@vger.kernel.org
Cc: suravee.suthikulpanit@amd.com, aravind.gopalakrishnan@amd.com,
	kim.naru@amd.com, andreas.herrmann3@amd.com, daniel@numascale.com,
	tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
	x86@kernel.org, bp@suse.de, sp@numascale.com,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 18 Apr 2014 20:53:46 -0600
Message-ID: <20140419025345.2408.99229.stgit@amt.stowe>
In-Reply-To: <20140419025308.2408.51252.stgit@amt.stowe>
References: <20140419025308.2408.51252.stgit@amt.stowe>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

With the amd_bus.c updates to support additional AMD processors (11h, 12h,
14h 15h  and 16h) 'quirk_amd_nb_node' seems to be redundant.  This patch
removes it.

Signed-off-by: Myron Stowe <myron.stowe@redhat.com>
---

 arch/x86/kernel/quirks.c |   58 ----------------------------------------------
 1 files changed, 0 insertions(+), 58 deletions(-)

diff --git a/arch/x86/kernel/quirks.c b/arch/x86/kernel/quirks.c
index ff898bb..abbd6bc 100644
--- a/arch/x86/kernel/quirks.c
+++ b/arch/x86/kernel/quirks.c
@@ -514,64 +514,6 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_SBX00_SMBUS,
 
 #endif
 
-#if defined(CONFIG_PCI) && defined(CONFIG_NUMA)
-/* Set correct numa_node information for AMD NB functions */
-static void quirk_amd_nb_node(struct pci_dev *dev)
-{
-	struct pci_dev *nb_ht;
-	unsigned int devfn;
-	u32 node;
-	u32 val;
-
-	devfn = PCI_DEVFN(PCI_SLOT(dev->devfn), 0);
-	nb_ht = pci_get_slot(dev->bus, devfn);
-	if (!nb_ht)
-		return;
-
-	pci_read_config_dword(nb_ht, 0x60, &val);
-	node = pcibus_to_node(dev->bus) | (val & 7);
-	/*
-	 * Some hardware may return an invalid node ID,
-	 * so check it first:
-	 */
-	if (node_online(node))
-		set_dev_node(&dev->dev, node);
-	pci_dev_put(nb_ht);
-}
-
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_K8_NB,
-			quirk_amd_nb_node);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_K8_NB_ADDRMAP,
-			quirk_amd_nb_node);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_K8_NB_MEMCTL,
-			quirk_amd_nb_node);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_K8_NB_MISC,
-			quirk_amd_nb_node);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_10H_NB_HT,
-			quirk_amd_nb_node);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_10H_NB_MAP,
-			quirk_amd_nb_node);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_10H_NB_DRAM,
-			quirk_amd_nb_node);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_10H_NB_MISC,
-			quirk_amd_nb_node);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_10H_NB_LINK,
-			quirk_amd_nb_node);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_15H_NB_F0,
-			quirk_amd_nb_node);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_15H_NB_F1,
-			quirk_amd_nb_node);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_15H_NB_F2,
-			quirk_amd_nb_node);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_15H_NB_F3,
-			quirk_amd_nb_node);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_15H_NB_F4,
-			quirk_amd_nb_node);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_15H_NB_F5,
-			quirk_amd_nb_node);
-
-#endif
-
 #ifdef CONFIG_PCI
 /*
  * Processor does not ensure DRAM scrub read/write sequence

