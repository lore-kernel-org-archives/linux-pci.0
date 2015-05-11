Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp01.au.ibm.com ([202.81.31.143]:58175 "EHLO
	e23smtp01.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752512AbbEKGsW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 11 May 2015 02:48:22 -0400
Received: from /spool/local
	by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Mon, 11 May 2015 16:48:20 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
	by d23dlp03.au.ibm.com (Postfix) with ESMTP id E0124357804F
	for <linux-pci@vger.kernel.org>; Mon, 11 May 2015 16:48:17 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t4B6m9ba47054966
	for <linux-pci@vger.kernel.org>; Mon, 11 May 2015 16:48:17 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t4B6liw1014285
	for <linux-pci@vger.kernel.org>; Mon, 11 May 2015 16:47:45 +1000
Date: Mon, 11 May 2015 16:47:20 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	benh@kernel.crashing.org, bhelgaas@google.com
Subject: Re: [PATCH v4 10/21] powerpc/powernv: Fundamental reset for PCI bus
 reset
Message-ID: <20150511064720.GB8241@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1430460188-31343-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1430460188-31343-11-git-send-email-gwshan@linux.vnet.ibm.com>
 <554E15C2.40506@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <554E15C2.40506@ozlabs.ru>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, May 10, 2015 at 12:12:18AM +1000, Alexey Kardashevskiy wrote:
>On 05/01/2015 04:02 PM, Gavin Shan wrote:
>>Function pnv_pci_reset_secondary_bus() is used to reset specified
>>PCI bus, which is leaded by root complex or PCI bridge. That means
>>the function shouldn't be called on PCI root bus and the patch
>>removes the logic for that case.
>>
>>Also, some adapters beneath the indicated PCI bus may require
>>fundamental reset in order to successfully reload their firmwares
>>after the reset. The patch translates hot reset to fundamental reset
>>for that case.
>>
>>Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>---
>>  arch/powerpc/platforms/powernv/eeh-powernv.c | 35 +++++++++++++++++++++-------
>>  1 file changed, 26 insertions(+), 9 deletions(-)
>>
>>diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
>>index 3c01095..58e4dcf 100644
>>--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
>>+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
>>@@ -888,18 +888,35 @@ static int pnv_eeh_bridge_reset(struct pci_dev *dev, int option)
>>  	return (rc == OPAL_SUCCESS) ? 0 : -EIO;
>>  }
>>
>>-void pnv_pci_reset_secondary_bus(struct pci_dev *dev)
>
>
>Why changing dev to pdev? Keeping "dev" could make the patch simpler.
>

In the early stage when I wrote the EEH code, I had "dev" to refer PCI
device, which isn't precisely enough. Actually, "dev" means "struct device"
while "pdev" stands for "struct pci_dev". That's why I changed it.

>>+static int pnv_pci_dev_reset_type(struct pci_dev *pdev, void *data)
>>  {
>>-	struct pci_controller *hose;
>>+	int *freset = data;
>>
>>-	if (pci_is_root_bus(dev->bus)) {
>>-		hose = pci_bus_to_host(dev->bus);
>>-		pnv_eeh_phb_reset(hose, EEH_RESET_HOT);
>>-		pnv_eeh_phb_reset(hose, EEH_RESET_DEACTIVATE);
>>-	} else {
>>-		pnv_eeh_bridge_reset(dev, EEH_RESET_HOT);
>>-		pnv_eeh_bridge_reset(dev, EEH_RESET_DEACTIVATE);
>>+	/*
>>+	 * Stop the iteration immediately if there is any
>>+	 * one PCI device requesting fundamental reset
>>+	 */
>>+	*freset |= pdev->needs_freset;
>>+	return *freset;
>>+}
>>+
>>+void pnv_pci_reset_secondary_bus(struct pci_dev *pdev)
>>+{
>>+	int option = EEH_RESET_HOT;
>>+	int freset = 0;
>>+
>>+	/* Check if there're any PCI devices asking for fundamental reset */
>>+	if (pdev->subordinate) {
>>+		pci_walk_bus(pdev->subordinate,
>>+			     pnv_pci_dev_reset_type,
>>+			     &freset);
>>+		if (freset)
>>+			option = EEH_RESET_FUNDAMENTAL;
>>  	}
>>+
>>+	/* Issue the requested type of reset */
>>+	pnv_eeh_bridge_reset(pdev, option);
>>+	pnv_eeh_bridge_reset(pdev, EEH_RESET_DEACTIVATE);
>>  }
>>
>>  /**
>>

Thanks,
Gavin

