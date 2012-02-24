Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 03/11] PCI: Use class quirk for intel fix_transparent_bridge
Date: Thu, 23 Feb 2012 23:46:51 -0800
Message-Id: <1330069619-14446-4-git-send-email-yinghai@kernel.org>
In-Reply-To: <1330069619-14446-1-git-send-email-yinghai@kernel.org>
References: <1330069619-14446-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 arch/x86/pci/fixup.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index 6dd8955..24172ff 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -164,11 +164,11 @@ DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8367_0, pci_fixup_
  */
 static void __devinit pci_fixup_transparent_bridge(struct pci_dev *dev)
 {
-	if ((dev->class >> 8) == PCI_CLASS_BRIDGE_PCI &&
-	    (dev->device & 0xff00) == 0x2400)
+	if ((dev->device & 0xff00) == 0x2400)
 		dev->transparent = 1;
 }
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_ANY_ID, pci_fixup_transparent_bridge);
+DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_VENDOR_ID_INTEL, PCI_ANY_ID,
+			 PCI_CLASS_BRIDGE_PCI, 8, pci_fixup_transparent_bridge);
 
 /*
  * Fixup for C1 Halt Disconnect problem on nForce2 systems.
-- 
1.7.7

