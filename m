Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 10 May 2017 13:30:01 +0100
From: Piotr Gregor <piotrgregor@rsyncme.org>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pci: Handle the case when PCI_COMMAND register hasn't
 changed in INTx masking test
Message-ID: <20170510122959.4uupohiz3ukzm4c4@debian1.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The check for interrupt masking support is done by reading
the PCI_COMMAND config word

	pci_read_config_word(dev, PCI_COMMAND, &orig);

then flipping the PCI_COMMAND_INTX_DISABLE bit and writing result back

	pci_write_config_word(dev, PCI_COMMAND,
		orig ^ PCI_COMMAND_INTX_DISABLE);

The expected result is that following read of the PCI_COMMAND

	pci_read_config_word(dev, PCI_COMMAND, &new);

returns PCI_COMMAND with only PCI_COMMAND_INTX_DISABLE bit changed.

There are two possible outcomes:

	1.	Command is the same (hasn't changed)
	2.	Commmand has changed

And the second of them may be decoupled to:

	2.1	Command changed only for PCI_COMMAND_INTX_DISABLE bit
		(hasn't changed for bits different than PCI_COMMAND_INTX_DISABLE)
	2.2	Command changed for bit(s) different than PCI_COMMAND_INTX_DISABLE bit
		(and maybe for PCI_COMMAND_INTX_DISABLE too)

The 2.1 is expected result and anything else is error.
The 2.2 outcome is handled by pci_intx_mask_supported by printing
appropriate message to the log, but outcome 1 is not handled.

Log the message about command not being changed at all.

Signed-off-by: Piotr Gregor <piotrgregor@rsyncme.org>
---
 drivers/pci/pci.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b01bd5b..67a611e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3712,7 +3712,7 @@ EXPORT_SYMBOL_GPL(pci_intx);
  * pci_intx_mask_supported - probe for INTx masking support
  * @dev: the PCI device to operate on
  *
- * Check if the device dev support INTx masking via the config space
+ * Check if the device dev supports INTx masking via the config space
  * command word.
  */
 bool pci_intx_mask_supported(struct pci_dev *dev)
@@ -3736,11 +3736,21 @@ bool pci_intx_mask_supported(struct pci_dev *dev)
 	 * go ahead and check it.
 	 */
 	if ((new ^ orig) & ~PCI_COMMAND_INTX_DISABLE) {
+		/*
+		 * If anything else than PCI_COMMAND_INTX_DISABLE bit has
+		 * changed (and maybe PCI_COMMAND_INTX_DISABLE too)
+		 */
 		dev_err(&dev->dev, "Command register changed from 0x%x to 0x%x: driver or hardware bug?\n",
 			orig, new);
 	} else if ((new ^ orig) & PCI_COMMAND_INTX_DISABLE) {
+		/*
+		 * OK. Only PCI_COMMAND_INTX_DISABLE bit has changed
+		 */
 		mask_supported = true;
 		pci_write_config_word(dev, PCI_COMMAND, orig);
+	} else {
+		dev_err(&dev->dev, "Command register hasn't changed when written from 0x%x to 0x%x: driver or hardware bug?\n",
+			orig, new);
 	}
 
 	pci_cfg_access_unlock(dev);
@@ -3798,7 +3808,7 @@ static bool pci_check_and_set_intx_mask(struct pci_dev *dev, bool mask)
  * @dev: the PCI device to operate on
  *
  * Check if the device dev has its INTx line asserted, mask it and
- * return true in that case. False is returned if not interrupt was
+ * return true in that case. False is returned if interrupt wasn't
  * pending.
  */
 bool pci_check_and_mask_intx(struct pci_dev *dev)
-- 
2.1.4
