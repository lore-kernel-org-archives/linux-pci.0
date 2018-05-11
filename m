Return-Path: <SRS0=T3Dv=H6=intel.com=jonathan.derrick@kernel.org>
Return-Path: <SRS0=T3Dv=H6=intel.com=jonathan.derrick@kernel.org>
From: Jon Derrick <jonathan.derrick@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>,
	Keith Busch <keith.busch@intel.com>,
	<linux-pci@vger.kernel.org>
Cc: Joerg Roedel <jroedel@suse.de>,
	Myron Stowe <myron.stowe@redhat.com>,
	Dave Fugate <david.fugate@intel.com>,
	Scott Bauer <scott.bauer@intel.com>,
	Jon Derrick <jonathan.derrick@intel.com>
Subject: [RFC PATCH 3/4] x86/PCI: Add new VMD device root ports to VMD AER quirk
Date: Thu, 10 May 2018 18:49:02 -0600
Message-Id: <20180511004903.19892-4-jonathan.derrick@intel.com>
In-Reply-To: <20180511004903.19892-1-jonathan.derrick@intel.com>
References: <20180511004903.19892-1-jonathan.derrick@intel.com>
List-ID: <linux-pci.vger.kernel.org>

VMD devices change the source id of messages from child devices to the
VMD endpoint. This patch adds the new VMD device id to the AER quirk
which requires walking the bus to determine which devices were throwing
the error.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 arch/x86/pci/fixup.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index 54ef19e90705..13f4485ca388 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -636,6 +636,10 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2030, quirk_no_aersid);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2031, quirk_no_aersid);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2032, quirk_no_aersid);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2033, quirk_no_aersid);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x334a, quirk_no_aersid);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x334b, quirk_no_aersid);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x334c, quirk_no_aersid);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x334d, quirk_no_aersid);
 
 #ifdef CONFIG_PHYS_ADDR_T_64BIT
 
-- 
2.14.3
