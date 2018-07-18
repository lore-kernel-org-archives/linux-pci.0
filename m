Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729642AbeGRUYC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 18 Jul 2018 16:24:02 -0400
Subject: [PATCH v3 3/7] PCI/AER: Factor out ERR_NONFATAL status bit clearing
From: Bjorn Helgaas <helgaas@kernel.org>
To: Oza Pawandeep <poza@codeaurora.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Dongdong Liu <liudongdong3@huawei.com>,
        Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
        Sinan Kaya <okaya@kernel.org>,
        Timur Tabi <timur@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Wed, 18 Jul 2018 14:44:38 -0500
Message-ID: <153194307824.191586.2110241671895539992.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <153194245964.191586.14782253252654776509.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <153194245964.191586.14782253252654776509.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Oza Pawandeep <poza@codeaurora.org>

aer_error_resume() clears all ERR_NONFATAL error status bits.  This is
exactly what pci_cleanup_aer_uncorrect_error_status(), so use that instead
of duplicating the code.

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>
[bhelgaas: split to separate patch]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/aer.c |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 6f0f131b5e6a..b8972fe85043 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1356,20 +1356,13 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
  */
 static void aer_error_resume(struct pci_dev *dev)
 {
-	int pos;
-	u32 status, mask;
 	u16 reg16;
 
 	/* Clean up Root device status */
 	pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &reg16);
 	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, reg16);
 
-	/* Clean AER Root Error Status */
-	pos = dev->aer_cap;
-	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, &status);
-	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, &mask);
-	status &= ~mask; /* Clear corresponding nonfatal bits */
-	pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, status);
+	pci_cleanup_aer_uncorrect_error_status(dev);
 }
 
 static struct pcie_port_service_driver aerdriver = {
