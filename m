Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.domeneshop.no ([194.63.252.54]:55404 "EHLO
	smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755108Ab3K2N6K (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 29 Nov 2013 08:58:10 -0500
From: =?UTF-8?q?Bj=C3=B8rn=20Erik=20Nilsen?= <ben@datarespons.no>
To: jg1.han@samsung.com
Cc: marex@denx.de, pratyush.anand@gmail.com, bhelgaas@google.com,
	linux-pci@vger.kernel.org, kishon@ti.com, Mohit.KUMAR@st.com,
	ajay.khandelwal@st.com, tharvey@gateworks.com,
	Eric.Nelson@boundarydevices.com, troy.kisky@boundarydevices.com,
	=?UTF-8?q?Bj=C3=B8rn=20Erik=20Nilsen?= <ben@datarespons.no>
Subject: [PATCH v5 2/2] PCI: designware: Remove redundant call to pci_write_config
Date: Fri, 29 Nov 2013 14:35:25 +0100
Message-Id: <1385732125-28630-3-git-send-email-ben@datarespons.no>
In-Reply-To: <1385732125-28630-1-git-send-email-ben@datarespons.no>
References: <003101ceecd5$dd4e79e0$97eb6da0$%han@samsung.com>
 <1385732125-28630-1-git-send-email-ben@datarespons.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

write_msi_msg() does exactly the same so there is no need
to explicitly call pci_write_config and do the same twice.

Signed-off-by: Bjørn Erik Nilsen <ben@datarespons.no>
---
 drivers/pci/host/pcie-designware.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 61345a1..212b8b6 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -345,10 +345,10 @@ static int dw_msi_setup_irq(struct msi_chip *chip, struct pci_dev *pdev,
 	if (irq < 0)
 		return irq;
 
-	msg_ctr &= ~PCI_MSI_FLAGS_QSIZE;
-	msg_ctr |= msgvec << 4;
-	pci_write_config_word(pdev, desc->msi_attrib.pos + PCI_MSI_FLAGS,
-				msg_ctr);
+	/*
+	 * write_msi_msg() will update PCI_MSI_FLAGS so there is
+	 * no need to explicitly call pci_write_config.
+	 */
 	desc->msi_attrib.multiple = msgvec;
 
 	msg.address_lo = virt_to_phys((void *)pp->msi_data);
-- 
1.8.4.4

