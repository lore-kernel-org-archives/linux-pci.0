Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 11/11] PCI: Use class for quirk for usb host controller fixup
Date: Thu, 23 Feb 2012 23:46:59 -0800
Message-Id: <1330069619-14446-12-git-send-email-yinghai@kernel.org>
In-Reply-To: <1330069619-14446-1-git-send-email-yinghai@kernel.org>
References: <1330069619-14446-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/usb/host/pci-quirks.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
index caf8742..30f3aa0 100644
--- a/drivers/usb/host/pci-quirks.c
+++ b/drivers/usb/host/pci-quirks.c
@@ -876,4 +876,5 @@ static void __devinit quirk_usb_early_handoff(struct pci_dev *pdev)
 	else if (pdev->class == PCI_CLASS_SERIAL_USB_XHCI)
 		quirk_usb_handoff_xhci(pdev);
 }
-DECLARE_PCI_FIXUP_FINAL(PCI_ANY_ID, PCI_ANY_ID, quirk_usb_early_handoff);
+DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_ANY_ID, PCI_ANY_ID,
+			PCI_CLASS_SERIAL_USB, 8, quirk_usb_early_handoff);
-- 
1.7.7

