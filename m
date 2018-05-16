Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: bhelgaas@google.com
Cc: alex_gagniuc@dellteam.com, austin_bolen@dell.com,
        shyam_iyer@dell.com, Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Keith Busch <keith.busch@intel.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Dongdong Liu <liudongdong3@huawei.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: DPC: Clear AER status bits before disabling port containment
Date: Wed, 16 May 2018 16:33:02 -0500
Message-Id: <20180516213306.27027-1-mr.nuke.me@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

AER status bits are sticky, and they survive system resets. Downstream
devices are usually taken care of after re-enumerating the downstream
busses, as the AER bits are cleared during probe().

However, nothing clears the bits of the port which contained the
error. These sticky bits may leave some BIOSes to think that something
bad happened, and print ominous messages on next boot. To prevent this,
tidy up the AER status bits before releasing containment.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 drivers/pci/pcie/dpc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 8c57d607e603..bf82d6936556 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -112,6 +112,10 @@ static void dpc_work(struct work_struct *work)
 		dpc->rp_pio_status = 0;
 	}
 
+	/* DPC event made a mess of our AER status bits. Clean them up. */
+	pci_cleanup_aer_error_status_regs(pdev);
+	/* TODO: Should we also use aer_print_error to log the event? */
+
 	pci_write_config_word(pdev, cap + PCI_EXP_DPC_STATUS,
 		PCI_EXP_DPC_STATUS_TRIGGER | PCI_EXP_DPC_STATUS_INTERRUPT);
 
-- 
2.14.3
