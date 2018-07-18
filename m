Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728912AbeGRUYV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 18 Jul 2018 16:24:21 -0400
Subject: [PATCH v3 6/7] PCI/AER: Clear device status bits during ERR_COR
 handling
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
Date: Wed, 18 Jul 2018 14:44:57 -0500
Message-ID: <153194309786.191586.2771045363400479470.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <153194245964.191586.14782253252654776509.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <153194245964.191586.14782253252654776509.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Oza Pawandeep <poza@codeaurora.org>

In case of correctable error, the Correctable Error Detected bit in the
Device Status register is set.  Clear it after handling the error.

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/aer.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index dc67f52b002f..2accfd7a4c9d 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -827,6 +827,7 @@ static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
 		if (pos)
 			pci_write_config_dword(dev, pos + PCI_ERR_COR_STATUS,
 					info->status);
+		pci_aer_clear_device_status(dev);
 	} else if (info->severity == AER_NONFATAL)
 		pcie_do_nonfatal_recovery(dev);
 	else if (info->severity == AER_FATAL)
