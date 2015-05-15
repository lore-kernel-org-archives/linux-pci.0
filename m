Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp02.au.ibm.com ([202.81.31.144]:37761 "EHLO
	e23smtp02.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933133AbbEOHiN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 15 May 2015 03:38:13 -0400
Received: from /spool/local
	by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Fri, 15 May 2015 17:38:12 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
	by d23dlp03.au.ibm.com (Postfix) with ESMTP id 23D64357804C
	for <linux-pci@vger.kernel.org>; Fri, 15 May 2015 17:38:09 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t4F7c1dh17236132
	for <linux-pci@vger.kernel.org>; Fri, 15 May 2015 17:38:09 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t4F7bZe9002922
	for <linux-pci@vger.kernel.org>; Fri, 15 May 2015 17:37:36 +1000
Date: Fri, 15 May 2015 17:37:10 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: gwshan@linux.vnet.ibm.com, bhelgaas@google.com,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH V4 10/11] powerpc/powernv: use "compound" as the child's
 list_head for compound PE
Message-ID: <20150515073710.GB7980@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1431668786-30371-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1431668786-30371-11-git-send-email-weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1431668786-30371-11-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 15, 2015 at 01:46:25PM +0800, Wei Yang wrote:
>Commit 262af557dd75(powerpc/powernv: Enable M64 aperatus for PHB3)
>introduces the concept of compound PE, and they are linked together to
>master PE's slaves lish_head with the list field. While this field is
>usually used to linked to the phb->ioda.pe_list to represents the PE is
>used.
>
>This patch introduces a field "compound" to link those compound PEs.
>

I don't think we needn't it with:

- VF PEs are classified to master and slave PEs.
- Master PEs is linked to phb->list;
- Slave PEs is linked to master->slaves;
- When iterating all PEs, you have to check PE's flag to cover all
  (master & slave) VF PEs:

  for_each_pe_in_phb_list {
         /* Things we're doing */
         if (pe_is_not_vf_pe ||
             pe_is_not_master_pe)
             continue;

         for_each_pe_in_master_vf_pe_list {
               /* slave VF PEs */
         }
  }

Thanks,
Gavin

>Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>---
> arch/powerpc/platforms/powernv/pci-ioda.c |    8 ++++----
> arch/powerpc/platforms/powernv/pci.h      |    1 +
> 2 files changed, 5 insertions(+), 4 deletions(-)
>
>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>index 920c252..843457b 100644
>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>@@ -344,7 +344,7 @@ done:
> 		} else {
> 			pe->flags |= PNV_IODA_PE_SLAVE;
> 			pe->master = master_pe;
>-			list_add_tail(&pe->list, &master_pe->slaves);
>+			list_add_tail(&pe->compound, &master_pe->slaves);
> 		}
> 	}
>
>@@ -428,7 +428,7 @@ static void pnv_ioda_freeze_pe(struct pnv_phb *phb, int pe_no)
> 	if (!(pe->flags & PNV_IODA_PE_MASTER))
> 		return;
>
>-	list_for_each_entry(slave, &pe->slaves, list) {
>+	list_for_each_entry(slave, &pe->slaves, compound) {
> 		rc = opal_pci_eeh_freeze_set(phb->opal_id,
> 					     slave->pe_number,
> 					     OPAL_EEH_ACTION_SET_FREEZE_ALL);
>@@ -464,7 +464,7 @@ static int pnv_ioda_unfreeze_pe(struct pnv_phb *phb, int pe_no, int opt)
> 		return 0;
>
> 	/* Clear frozen state for slave PEs */
>-	list_for_each_entry(slave, &pe->slaves, list) {
>+	list_for_each_entry(slave, &pe->slaves, compound) {
> 		rc = opal_pci_eeh_freeze_clear(phb->opal_id,
> 					     slave->pe_number,
> 					     opt);
>@@ -516,7 +516,7 @@ static int pnv_ioda_get_pe_state(struct pnv_phb *phb, int pe_no)
> 	if (!(pe->flags & PNV_IODA_PE_MASTER))
> 		return state;
>
>-	list_for_each_entry(slave, &pe->slaves, list) {
>+	list_for_each_entry(slave, &pe->slaves, compound) {
> 		rc = opal_pci_eeh_freeze_status(phb->opal_id,
> 						slave->pe_number,
> 						&fstate,
>diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
>index 070ee88..540ab1e 100644
>--- a/arch/powerpc/platforms/powernv/pci.h
>+++ b/arch/powerpc/platforms/powernv/pci.h
>@@ -73,6 +73,7 @@ struct pnv_ioda_pe {
> 	/* PEs in compound case */
> 	struct pnv_ioda_pe	*master;
> 	struct list_head	slaves;
>+	struct list_head	compound;
>
> 	/* Link in list of PE#s */
> 	struct list_head	dma_link;
>-- 
>1.7.9.5
>

