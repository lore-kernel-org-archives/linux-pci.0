Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>, x86 <x86@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH -v3 37/47] PCI: Kill pci_is_reassignedev()
Date: Sun, 18 Mar 2012 22:46:26 -0700
Message-Id: <1332135996-13860-38-git-send-email-yinghai@kernel.org>
In-Reply-To: <1332135996-13860-1-git-send-email-yinghai@kernel.org>
References: <1332135996-13860-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Only one user. Just use pci_specified_resource_alignement() directly.
So could only get get align one time for the dev that in the list

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/pci.c |   17 +++--------------
 1 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 8156744..82ed56a 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3685,18 +3685,6 @@ resource_size_t pci_specified_resource_alignment(struct pci_dev *dev)
 	return align;
 }
 
-/**
- * pci_is_reassigndev - check if specified PCI is target device to reassign
- * @dev: the PCI device to check
- *
- * RETURNS: non-zero for PCI device is a target device to reassign,
- *          or zero is not.
- */
-int pci_is_reassigndev(struct pci_dev *dev)
-{
-	return (pci_specified_resource_alignment(dev) != 0);
-}
-
 /*
  * This function disables memory decoding and releases memory resources
  * of the device specified by kernel's boot parameter 'pci=resource_alignment='.
@@ -3711,7 +3699,9 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
 	resource_size_t align, size;
 	u16 command;
 
-	if (!pci_is_reassigndev(dev))
+	/* check if specified PCI is target device to reassign */
+	align = pci_specified_resource_alignment(dev);
+	if (!align)
 		return;
 
 	if (dev->hdr_type == PCI_HEADER_TYPE_NORMAL &&
@@ -3727,7 +3717,6 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
 	command &= ~PCI_COMMAND_MEMORY;
 	pci_write_config_word(dev, PCI_COMMAND, command);
 
-	align = pci_specified_resource_alignment(dev);
 	for (i = 0; i < PCI_BRIDGE_RESOURCES; i++) {
 		r = &dev->resource[i];
 		if (!(r->flags & IORESOURCE_MEM))
-- 
1.7.7

