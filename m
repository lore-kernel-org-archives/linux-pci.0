Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp03.au.ibm.com ([202.81.31.145]:56604 "EHLO
	e23smtp03.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932389AbcDTBh2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 19 Apr 2016 21:37:28 -0400
Received: from localhost
	by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Wed, 20 Apr 2016 11:37:25 +1000
Date: Wed, 20 Apr 2016 11:36:10 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, benh@kernel.crashing.org,
	mpe@ellerman.id.au, dja@axtens.net, bhelgaas@google.com,
	robherring2@gmail.com, grant.likely@linaro.org
Subject: Re: [PATCH v8 35/45] powerpc/powernv: Fundamental reset in
 pnv_pci_reset_secondary_bus()
Message-ID: <20160420013610.GA25585@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1455680668-23298-36-git-send-email-gwshan@linux.vnet.ibm.com>
 <5715F493.2030002@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5715F493.2030002@ozlabs.ru>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 19, 2016 at 07:04:19PM +1000, Alexey Kardashevskiy wrote:
>On 02/17/2016 02:44 PM, Gavin Shan wrote:
>>In pnv_pci_reset_secondary_bus(), we should issue fundamental reset
>>if any one subordinate device of the specified bus is requesting that.
>>Otherwise, the device might not come up after the reset.
>>
>>Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>
>
>Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>
>
>Out of curiosity - what does "fundamental" reset actually do?
>

Please refer to the skiboot patches - power off/on the target slot.

>
>>---
>>  arch/powerpc/platforms/powernv/eeh-powernv.c | 21 ++++++++++++++++++++-
>>  1 file changed, 20 insertions(+), 1 deletion(-)
>>
>>diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
>>index 593b8dc..c7454ba 100644
>>--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
>>+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
>>@@ -866,9 +866,28 @@ static int pnv_eeh_bridge_reset(struct pci_dev *dev, int option)
>>  	return 0;
>>  }
>>
>>+static int pnv_pci_dev_reset_type(struct pci_dev *pdev, void *data)
>>+{
>>+	int *freset = data;
>>+
>>+	/*
>>+	 * Stop the iteration immediately if there has any one
>>+	 * PCI device requesting fundamental reset.
>>+	 */
>>+	*freset |= pdev->needs_freset;
>>+	return *freset;
>>+}
>>+
>>  void pnv_pci_reset_secondary_bus(struct pci_dev *dev)
>>  {
>>-	pnv_eeh_bridge_reset(dev, EEH_RESET_HOT);
>>+	int option, freset = 0;
>>+
>>+	if (dev->subordinate)
>>+		pci_walk_bus(dev->subordinate,
>>+			     pnv_pci_dev_reset_type, &freset);
>>+
>>+	option = freset ? EEH_RESET_FUNDAMENTAL : EEH_RESET_HOT;
>>+	pnv_eeh_bridge_reset(dev, option);
>>  	pnv_eeh_bridge_reset(dev, EEH_RESET_DEACTIVATE);
>>  }
>>
>>
>
>
>-- 
>Alexey
>

