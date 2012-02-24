Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 09/11] PCI: Use class for quirk for intel e100 interrupt fixup
Date: Thu, 23 Feb 2012 23:46:57 -0800
Message-Id: <1330069619-14446-10-git-send-email-yinghai@kernel.org>
In-Reply-To: <1330069619-14446-1-git-send-email-yinghai@kernel.org>
References: <1330069619-14446-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/quirks.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 03e455a..91733a2 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1957,7 +1957,8 @@ static void __devinit quirk_e100_interrupt(struct pci_dev *dev)
 
 	iounmap(csr);
 }
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, PCI_ANY_ID, quirk_e100_interrupt);
+DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_INTEL, PCI_ANY_ID,
+			PCI_CLASS_NETWORK_ETHERNET, 8, quirk_e100_interrupt);
 
 /*
  * The 82575 and 82598 may experience data corruption issues when transitioning
-- 
1.7.7

