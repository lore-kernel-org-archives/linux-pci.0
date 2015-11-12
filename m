Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp09.au.ibm.com ([202.81.31.142]:37914 "EHLO
	e23smtp09.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753232AbbKLGQa (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 12 Nov 2015 01:16:30 -0500
Received: from /spool/local
	by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Thu, 12 Nov 2015 16:16:27 +1000
Date: Thu, 12 Nov 2015 17:15:25 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, benh@kernel.crashing.org,
	mpe@ellerman.id.au, aik@ozlabs.ru, bhelgaas@google.com,
	grant.likely@linaro.org, robherring2@gmail.com,
	panto@antoniou-consulting.com, frowand.list@gmail.com
Subject: Re: [PATCH v7 39/50] powerpc/powernv: Fundamental reset in
 pnv_pci_reset_secondary_bus()
Message-ID: <20151112061525.GA18894@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1446642770-4681-40-git-send-email-gwshan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1446642770-4681-40-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Nov 05, 2015 at 12:12:39AM +1100, Gavin Shan wrote:
>In pnv_pci_reset_secondary_bus(), we should issue fundamental
>reset if any one subordinate device of the specified is requesting
                                        ^^^^^^^^^^^^^^

                                        the specified bus

I put the note reminding me to admend the changelog in next revision.

>that. Otherwise, the device might not come up after the reset.
>
>Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>---
> arch/powerpc/platforms/powernv/eeh-powernv.c | 21 ++++++++++++++++++++-
> 1 file changed, 20 insertions(+), 1 deletion(-)
>
>diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
>index c69b6a1..ab8b93e 100644
>--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
>+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
>@@ -878,9 +878,28 @@ static int pnv_eeh_bridge_reset(struct pci_dev *dev, int option)
> 	return 0;
> }
>
>+static int pnv_pci_dev_reset_type(struct pci_dev *pdev, void *data)
>+{
>+	int *freset = data;
>+
>+	/*
>+	 * Stop the iteration immediately if there has any one
>+	 * PCI device requesting fundamental reset.
>+	 */
>+	*freset |= pdev->needs_freset;
>+	return *freset;
>+}
>+
> void pnv_pci_reset_secondary_bus(struct pci_dev *dev)
> {
>-	pnv_eeh_bridge_reset(dev, EEH_RESET_HOT);
>+	int option, freset = 0;
>+
>+	if (dev->subordinate)
>+		pci_walk_bus(dev->subordinate,
>+			     pnv_pci_dev_reset_type, &freset);
>+
>+	option = freset ? EEH_RESET_FUNDAMENTAL : EEH_RESET_HOT;
>+	pnv_eeh_bridge_reset(dev, option);
> 	pnv_eeh_bridge_reset(dev, EEH_RESET_DEACTIVATE);
> }
>
>-- 
>2.1.0
>

