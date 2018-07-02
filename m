Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org
Subject: [PATCH V5 2/3] PCI: pciehp: reuse pciehp_mask/unmask_irq() in
 reset_slot()
Date: Mon,  2 Jul 2018 18:52:46 -0400
Message-Id: <1530571967-19099-3-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1530571967-19099-1-git-send-email-okaya@codeaurora.org>
References: <1530571967-19099-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <keith.busch@intel.com>, Oza Pawandeep <poza@codeaurora.org>,
 Kees Cook <keescook@chromium.org>, linux-arm-msm@vger.kernel.org,
 open list <linux-kernel@vger.kernel.org>, Sinan Kaya <okaya@codeaurora.org>,
 Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Markus Elfring <elfring@users.sourceforge.net>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Now that we have individual functions to mask/unmask hotplug interrupts
avoid code duplication and reuse the new API in multiple places.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/hotplug/pciehp_hpc.c | 23 ++---------------------
 1 file changed, 2 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index d44e2c6..ebf9b3b 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -726,34 +726,15 @@ static void pcie_disable_notification(struct controller *ctrl)
 int pciehp_reset_slot(struct slot *slot, int probe)
 {
 	struct controller *ctrl = slot->ctrl;
-	struct pci_dev *pdev = ctrl_dev(ctrl);
-	u16 stat_mask = 0, ctrl_mask = 0;
 	int rc;
 
 	if (probe)
 		return 0;
 
-	if (!ATTN_BUTTN(ctrl)) {
-		ctrl_mask |= PCI_EXP_SLTCTL_PDCE;
-		stat_mask |= PCI_EXP_SLTSTA_PDC;
-	}
-	ctrl_mask |= PCI_EXP_SLTCTL_DLLSCE;
-	stat_mask |= PCI_EXP_SLTSTA_DLLSC;
-
-	pcie_write_cmd(ctrl, 0, ctrl_mask);
-	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
-		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, 0);
-	if (pciehp_poll_mode)
-		del_timer_sync(&ctrl->poll_timer);
-
+	pciehp_mask_irq(slot);
 	rc = pci_bridge_secondary_bus_reset(ctrl->pcie->port);
+	pciehp_unmask_irq(slot);
 
-	pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, stat_mask);
-	pcie_write_cmd_nowait(ctrl, ctrl_mask, ctrl_mask);
-	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
-		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, ctrl_mask);
-	if (pciehp_poll_mode)
-		int_poll_timeout(&ctrl->poll_timer);
 	return rc;
 }
 
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
