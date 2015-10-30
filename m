Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp08.in.ibm.com ([122.248.162.8]:44737 "EHLO
	e28smtp08.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756561AbbJ3Cs2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 29 Oct 2015 22:48:28 -0400
Received: from /spool/local
	by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Fri, 30 Oct 2015 08:18:26 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
	by d28dlp03.in.ibm.com (Postfix) with ESMTP id 9FBD61258019
	for <linux-pci@vger.kernel.org>; Fri, 30 Oct 2015 08:18:19 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
	by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t9U2mDoE26935418
	for <linux-pci@vger.kernel.org>; Fri, 30 Oct 2015 08:18:13 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
	by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t9U2mC97014634
	for <linux-pci@vger.kernel.org>; Fri, 30 Oct 2015 08:18:12 +0530
Date: Fri, 30 Oct 2015 10:48:08 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, gwshan@linux.vnet.ibm.com,
	bhelgaas@google.com, mpe@ellerman.id.au,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH V10 03/12] powerpc/pci: Cache VF index in pci_dn
Message-ID: <20151030024808.GA3551@richards-mbp.cn.ibm.com>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1445829362-2738-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1445829362-2738-4-git-send-email-weiyang@linux.vnet.ibm.com>
 <5632D077.40304@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5632D077.40304@ozlabs.ru>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 30, 2015 at 01:05:43PM +1100, Alexey Kardashevskiy wrote:
>On 10/26/2015 02:15 PM, Wei Yang wrote:
>>The patch caches the VF index in pci_dn, which can be used to calculate
>>VF's bus, device and function number. Those information helps to locate
>>the VF's PCI device instance when doing hotplug during EEH recovery if
>>necessary.
>
>
>The patch itself does not make much sense and quite small, I'd merge it into
>the one which makes use of this new vf_index.
>

Well, reasonable, will merge it.

>>
>>Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>>Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>---
>>  arch/powerpc/include/asm/pci-bridge.h | 1 +
>>  arch/powerpc/kernel/pci_dn.c          | 4 +++-
>>  2 files changed, 4 insertions(+), 1 deletion(-)
>>
>>diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
>>index b3a226b..3d7e537 100644
>>--- a/arch/powerpc/include/asm/pci-bridge.h
>>+++ b/arch/powerpc/include/asm/pci-bridge.h
>>@@ -210,6 +210,7 @@ struct pci_dn {
>>  #define IODA_INVALID_PE		(-1)
>>  #ifdef CONFIG_PPC_POWERNV
>>  	int	pe_number;
>>+	int     vf_index;		/* VF index in the PF */
>>  #ifdef CONFIG_PCI_IOV
>>  	u16     vfs_expanded;		/* number of VFs IOV BAR expanded */
>>  	u16     num_vfs;		/* number of VFs enabled*/
>>diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
>>index b3b4df9..f771130 100644
>>--- a/arch/powerpc/kernel/pci_dn.c
>>+++ b/arch/powerpc/kernel/pci_dn.c
>>@@ -139,6 +139,7 @@ struct pci_dn *pci_get_pdn(struct pci_dev *pdev)
>>  #ifdef CONFIG_PCI_IOV
>>  static struct pci_dn *add_one_dev_pci_data(struct pci_dn *parent,
>>  					   struct pci_dev *pdev,
>>+					   int vf_index,
>>  					   int busno, int devfn)
>>  {
>>  	struct pci_dn *pdn;
>>@@ -157,6 +158,7 @@ static struct pci_dn *add_one_dev_pci_data(struct pci_dn *parent,
>>  	pdn->parent = parent;
>>  	pdn->busno = busno;
>>  	pdn->devfn = devfn;
>>+	pdn->vf_index = vf_index;
>>  #ifdef CONFIG_PPC_POWERNV
>>  	pdn->pe_number = IODA_INVALID_PE;
>>  #endif
>>@@ -196,7 +198,7 @@ struct pci_dn *add_dev_pci_data(struct pci_dev *pdev)
>>  		return NULL;
>>
>>  	for (i = 0; i < pci_sriov_get_totalvfs(pdev); i++) {
>>-		pdn = add_one_dev_pci_data(parent, NULL,
>>+		pdn = add_one_dev_pci_data(parent, NULL, i,
>>  					   pci_iov_virtfn_bus(pdev, i),
>>  					   pci_iov_virtfn_devfn(pdev, i));
>>  		if (!pdn) {
>>
>
>
>-- 
>Alexey
>--
>To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Richard Yang
Help you, Help me

