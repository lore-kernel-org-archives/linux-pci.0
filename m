Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 04/11] PCI: Use class for quirk for pci_fixup_video
Date: Thu, 23 Feb 2012 23:46:52 -0800
Message-Id: <1330069619-14446-5-git-send-email-yinghai@kernel.org>
In-Reply-To: <1330069619-14446-1-git-send-email-yinghai@kernel.org>
References: <1330069619-14446-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 arch/x86/pci/fixup.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index 24172ff..d0e6e40 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -322,9 +322,6 @@ static void __devinit pci_fixup_video(struct pci_dev *pdev)
 	struct pci_bus *bus;
 	u16 config;
 
-	if ((pdev->class >> 8) != PCI_CLASS_DISPLAY_VGA)
-		return;
-
 	/* Is VGA routed to us? */
 	bus = pdev->bus;
 	while (bus) {
@@ -353,7 +350,8 @@ static void __devinit pci_fixup_video(struct pci_dev *pdev)
 		dev_printk(KERN_DEBUG, &pdev->dev, "Boot video device\n");
 	}
 }
-DECLARE_PCI_FIXUP_FINAL(PCI_ANY_ID, PCI_ANY_ID, pci_fixup_video);
+DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_ANY_ID, PCI_ANY_ID,
+				PCI_CLASS_DISPLAY_VGA, 8, pci_fixup_video);
 
 
 static const struct dmi_system_id __devinitconst msi_k8t_dmi_table[] = {
-- 
1.7.7

