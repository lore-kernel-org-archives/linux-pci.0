Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp08.au.ibm.com ([202.81.31.141]:52840 "EHLO
	e23smtp08.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752700AbcDTAyF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 19 Apr 2016 20:54:05 -0400
Received: from localhost
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Wed, 20 Apr 2016 10:54:02 +1000
Date: Wed, 20 Apr 2016 10:52:46 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, benh@kernel.crashing.org,
	mpe@ellerman.id.au, dja@axtens.net, bhelgaas@google.com,
	robherring2@gmail.com, grant.likely@linaro.org
Subject: Re: [PATCH v8 18/45] powerpc/powernv: Increase PE# capacity
Message-ID: <20160420005246.GA19640@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1455680668-23298-19-git-send-email-gwshan@linux.vnet.ibm.com>
 <571591AF.7080804@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <571591AF.7080804@ozlabs.ru>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 19, 2016 at 12:02:23PM +1000, Alexey Kardashevskiy wrote:
>On 02/17/2016 02:44 PM, Gavin Shan wrote:
>>Each PHB maintains an array helping to translate 2-bytes Request
>>ID (RID) to PE# with the assumption that PE# takes one byte, meaning
>>that we can't have more than 256 PEs. However, pci_dn->pe_number
>>already had 4-bytes for the PE#.
>>
>>This extends the PE# capacity for every PHB. After that, the PE number
>>is represented by 4-bytes value. Then we can reuse IODA_INVALID_PE to
>>check the PE# in phb->pe_rmap[] is valid or not.
>
>
>This should be merged into "[PATCH v8 21/45] powerpc/powernv: Create PEs at
>PCI hot plugging time" as it does not make sense alone (this patch does the
>initialization but only 3 patches apart this default value is analyzed ->
>hard to review).
>

Indeed, will move accordingly in next revision.

>>Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>Reviewed-by: Daniel Axtens <dja@axtens.net>
>>---
>>  arch/powerpc/platforms/powernv/pci-ioda.c | 6 +++++-
>>  arch/powerpc/platforms/powernv/pci.h      | 7 ++-----
>>  2 files changed, 7 insertions(+), 6 deletions(-)
>>
>>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>>index 59782fba..7800897 100644
>>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
>>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>>@@ -757,7 +757,7 @@ static int pnv_ioda_deconfigure_pe(struct pnv_phb *phb, struct pnv_ioda_pe *pe)
>>
>>  	/* Clear the reverse map */
>>  	for (rid = pe->rid; rid < rid_end; rid++)
>>-		phb->ioda.pe_rmap[rid] = 0;
>>+		phb->ioda.pe_rmap[rid] = IODA_INVALID_PE;
>>
>>  	/* Release from all parents PELT-V */
>>  	while (parent) {
>>@@ -3387,6 +3387,10 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
>>  	if (prop32)
>>  		phb->ioda.reserved_pe_idx = be32_to_cpup(prop32);
>>
>>+	/* Invalidate RID to PE# mapping */
>>+	for (i = 0; i < ARRAY_SIZE(phb->ioda.pe_rmap); ++i)
>>+		phb->ioda.pe_rmap[i] = IODA_INVALID_PE;
>>+
>>  	/* Parse 64-bit MMIO range */
>>  	pnv_ioda_parse_m64_window(phb);
>>
>>diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
>>index 350e630..928cf81 100644
>>--- a/arch/powerpc/platforms/powernv/pci.h
>>+++ b/arch/powerpc/platforms/powernv/pci.h
>>@@ -160,11 +160,8 @@ struct pnv_phb {
>>  		struct list_head	pe_list;
>>  		struct mutex            pe_list_mutex;
>>
>>-		/* Reverse map of PEs, will have to extend if
>>-		 * we are to support more than 256 PEs, indexed
>>-		 * bus { bus, devfn }
>>-		 */
>>-		unsigned char		pe_rmap[0x10000];
>>+		/* Reverse map of PEs, indexed by {bus, devfn} */
>>+		int			pe_rmap[0x10000];
>>
>>  		/* TCE cache invalidate registers (physical and
>>  		 * remapped)
>>
>
>
>-- 
>Alexey
>

