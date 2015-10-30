Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp05.au.ibm.com ([202.81.31.147]:35975 "EHLO
	e23smtp05.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758134AbbJ3HAR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 30 Oct 2015 03:00:17 -0400
Received: from localhost
	by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Fri, 30 Oct 2015 17:00:15 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
	by d23dlp02.au.ibm.com (Postfix) with ESMTP id 9AAFD2BB0055
	for <linux-pci@vger.kernel.org>; Fri, 30 Oct 2015 18:00:13 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t9U6xxqu14549246
	for <linux-pci@vger.kernel.org>; Fri, 30 Oct 2015 18:00:08 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t9U6xeSV022075
	for <linux-pci@vger.kernel.org>; Fri, 30 Oct 2015 17:59:41 +1100
Date: Fri, 30 Oct 2015 14:59:14 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, gwshan@linux.vnet.ibm.com,
	bhelgaas@google.com, mpe@ellerman.id.au,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH V10 07/12] powerpc/eeh: Create PE for VFs
Message-ID: <20151030065914.GD5940@richards-mbp.cn.ibm.com>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1445829362-2738-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1445829362-2738-8-git-send-email-weiyang@linux.vnet.ibm.com>
 <5632E81B.6060003@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5632E81B.6060003@ozlabs.ru>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 30, 2015 at 02:46:35PM +1100, Alexey Kardashevskiy wrote:
>On 10/26/2015 02:15 PM, Wei Yang wrote:
>>Current EEH recovery code works with the assumption: the PE has primary
>>bus. Unfortunately, that's not true for VF PEs, which generally contains
>>one or multiple VFs (for VF group case).
>
>What is that "VF group case"? Is not it a "compound PE" thingy which you were
>removing in "SRIOV redesign patchset"?
>

I think you are right.

The commit log is not correct, especially after SRIOV redesign.
Will remove this part.

>The patch might be ok but the commit log above does not explain why the
>existing way of PEs allocation would not work - somehow it works for a
>primary bus now, why would not it work on other buses?
>
>
>>The patch creates PEs for VFs in the weak function
>>pcibios_bus_add_device().Those PEs for VFs are identified with newly
>>introduced flag EEH_PE_VF so that we handle them differently during EEH
>>recovery.
>>
>>[gwshan: changelog and code refactoring]
>>Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>>Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>---
>>  arch/powerpc/include/asm/eeh.h               |  1 +
>>  arch/powerpc/kernel/eeh_pe.c                 | 10 ++++++++--
>>  arch/powerpc/platforms/powernv/eeh-powernv.c | 16 ++++++++++++++++
>>  3 files changed, 25 insertions(+), 2 deletions(-)
>>
>>diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
>>index 6c383ad..ec21f8f 100644
>>--- a/arch/powerpc/include/asm/eeh.h
>>+++ b/arch/powerpc/include/asm/eeh.h
>>@@ -72,6 +72,7 @@ struct pci_dn;
>>  #define EEH_PE_PHB	(1 << 1)	/* PHB PE    */
>>  #define EEH_PE_DEVICE 	(1 << 2)	/* Device PE */
>>  #define EEH_PE_BUS	(1 << 3)	/* Bus PE    */
>>+#define EEH_PE_VF	(1 << 4)	/* VF PE     */
>>
>>  #define EEH_PE_ISOLATED		(1 << 0)	/* Isolated PE		*/
>>  #define EEH_PE_RECOVERING	(1 << 1)	/* Recovering PE	*/
>>diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
>>index 35f0b62..260a701 100644
>>--- a/arch/powerpc/kernel/eeh_pe.c
>>+++ b/arch/powerpc/kernel/eeh_pe.c
>>@@ -299,7 +299,10 @@ static struct eeh_pe *eeh_pe_get_parent(struct eeh_dev *edev)
>>  	 * EEH device already having associated PE, but
>>  	 * the direct parent EEH device doesn't have yet.
>>  	 */
>>-	pdn = pdn ? pdn->parent : NULL;
>>+	if (edev->physfn)
>>+		pdn = pci_get_pdn(edev->physfn);
>>+	else
>>+		pdn = pdn ? pdn->parent : NULL;
>>  	while (pdn) {
>>  		/* We're poking out of PCI territory */
>>  		parent = pdn_to_eeh_dev(pdn);
>>@@ -382,7 +385,10 @@ int eeh_add_to_parent_pe(struct eeh_dev *edev)
>>  	}
>>
>>  	/* Create a new EEH PE */
>>-	pe = eeh_pe_alloc(edev->phb, EEH_PE_DEVICE);
>>+	if (edev->physfn)
>>+		pe = eeh_pe_alloc(edev->phb, EEH_PE_VF);
>>+	else
>>+		pe = eeh_pe_alloc(edev->phb, EEH_PE_DEVICE);
>>  	if (!pe) {
>>  		pr_err("%s: out of memory!\n", __func__);
>>  		return -ENOMEM;
>>diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
>>index 7cf0df8..cfd55dd 100644
>>--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
>>+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
>>@@ -1524,6 +1524,22 @@ static struct eeh_ops pnv_eeh_ops = {
>>  	.restore_config		= pnv_eeh_restore_config
>>  };
>>
>>+void pcibios_bus_add_device(struct pci_dev *pdev)
>>+{
>>+	struct pci_dn *pdn = pci_get_pdn(pdev);
>>+
>>+	if (!pdev->is_virtfn)
>>+		return;
>>+
>>+	/*
>>+	 * The following operations will fail if VF's sysfs files
>>+	 * aren't created or its resources aren't finalized.
>>+	 */
>>+	eeh_add_device_early(pdn);
>>+	eeh_add_device_late(pdev);
>>+	eeh_sysfs_add_device(pdev);
>>+}
>>+
>>  /**
>>   * eeh_powernv_init - Register platform dependent EEH operations
>>   *
>>
>
>
>-- 
>Alexey

-- 
Richard Yang
Help you, Help me

