Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ch1ehsobe005.messaging.microsoft.com ([216.32.181.185]:39419
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753024Ab2LGIRn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 7 Dec 2012 03:17:43 -0500
From: Saurav Kashyap <saurav.kashyap@qlogic.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: Dept-Eng Linux Driver <Linux-Driver@qlogic.com>,
	Andrew Vasquez <andrew.vasquez@qlogic.com>,
	"James E.J. Bottomley" <JBottomley@parallels.com>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 04/12] [SCSI] qla2xxx: Use standard PCIe Capability Link
 register field names
Date: Fri, 7 Dec 2012 08:17:38 +0000
Message-ID: <F5D084D6342F9B479C34599BB0A03E4D020128@AVMB1.qlogic.org>
In-Reply-To: <20121205205740.13851.43284.stgit@bhelgaas.mtv.corp.google.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Acked-by: Saurav Kashyap <saurav.kashyap@qlogic.com>

Thanks,
~Saurav



>Use the standard #defines for PCIe Link Capability register fields
>rather than bare numbers.  This also uses the new PCI Express Capability
>accessor rather than reading the capability directly.
>
>Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>CC: Andrew Vasquez <andrew.vasquez@qlogic.com>
>CC: linux-driver@qlogic.com
>CC: "James E.J. Bottomley" <JBottomley@parallels.com>
>CC: linux-scsi@vger.kernel.org
>---
> drivers/scsi/qla2xxx/qla_os.c |   14 +++++---------
> 1 files changed, 5 insertions(+), 9 deletions(-)
>
>diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
>index d501bf5..b5d070f 100644
>--- a/drivers/scsi/qla2xxx/qla_os.c
>+++ b/drivers/scsi/qla2xxx/qla_os.c
>@@ -480,18 +480,14 @@ qla24xx_pci_info_str(struct scsi_qla_host *vha,
>char *str)
>       static char *pci_bus_modes[] = { "33", "66", "100", "133", };
>       struct qla_hw_data *ha = vha->hw;
>       uint32_t pci_bus;
>-      int pcie_reg;
>
>-      pcie_reg = pci_pcie_cap(ha->pdev);
>-      if (pcie_reg) {
>+      if (pci_is_pcie(ha->pdev)) {
>               char lwstr[6];
>-              uint16_t pcie_lstat, lspeed, lwidth;
>+              uint32_t lstat, lspeed, lwidth;
>
>-              pcie_reg += PCI_EXP_LNKCAP;
>-              pci_read_config_word(ha->pdev, pcie_reg, &pcie_lstat);
>-              lspeed = pcie_lstat & (BIT_0 | BIT_1 | BIT_2 | BIT_3);
>-              lwidth = (pcie_lstat &
>-                  (BIT_4 | BIT_5 | BIT_6 | BIT_7 | BIT_8 | BIT_9)) >> 4;
>+              pcie_capability_read_dword(ha->pdev, PCI_EXP_LNKCAP, &lstat);
>+              lspeed = lstat & PCI_EXP_LNKCAP_SLS;
>+              lwidth = (lstat & PCI_EXP_LNKCAP_MLW) >> 4;
>
>               strcpy(str, "PCIe (");
>               if (lspeed == 1)
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


________________________________

This message and any attached documents contain information from QLogic Corporation or its wholly-owned subsidiaries that may be confidential. If you are not the intended recipient, you may not read, copy, distribute, or use this information. If you have received this transmission in error, please notify the sender immediately by reply e-mail and then delete this message.

