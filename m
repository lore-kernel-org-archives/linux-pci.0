Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp01.au.ibm.com ([202.81.31.143]:41123 "EHLO
	e23smtp01.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752142AbbEOF6L (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 15 May 2015 01:58:11 -0400
Received: from /spool/local
	by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Fri, 15 May 2015 15:58:09 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
	by d23dlp03.au.ibm.com (Postfix) with ESMTP id 9E307357804F
	for <linux-pci@vger.kernel.org>; Fri, 15 May 2015 15:58:08 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t4F5w0Nv41287910
	for <linux-pci@vger.kernel.org>; Fri, 15 May 2015 15:58:08 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t4F5vZ5r011691
	for <linux-pci@vger.kernel.org>; Fri, 15 May 2015 15:57:36 +1000
Date: Fri, 15 May 2015 15:57:10 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: gwshan@linux.vnet.ibm.com, bhelgaas@google.com,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH V4 02/11] powerpc/pci_dn: cache vf_index in pci_dn
Message-ID: <20150515055710.GB27029@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1431668786-30371-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1431668786-30371-3-git-send-email-weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1431668786-30371-3-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 15, 2015 at 01:46:17PM +0800, Wei Yang wrote:
>The patch caches the VF index in pci_dn, which can be used to calculate
>VF's bus, device and function number. Those information helps to locate
>the VF's PCI device instance when doing hotplug during EEH recovery if
>necessary.
>
>Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>

Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Thanks,
Gavin


>---
> arch/powerpc/include/asm/pci-bridge.h |    1 +
> arch/powerpc/kernel/pci_dn.c          |    4 +++-
> 2 files changed, 4 insertions(+), 1 deletion(-)
>
>diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
>index 1811c44..d78afe4 100644
>--- a/arch/powerpc/include/asm/pci-bridge.h
>+++ b/arch/powerpc/include/asm/pci-bridge.h
>@@ -199,6 +199,7 @@ struct pci_dn {
> #ifdef CONFIG_PCI_IOV
> 	u16     vfs_expanded;		/* number of VFs IOV BAR expanded */
> 	u16     num_vfs;		/* number of VFs enabled*/
>+	int     vf_index;		/* VF index in the PF */
> 	int     offset;			/* PE# for the first VF PE */
> #define M64_PER_IOV 4
> 	int     m64_per_iov;
>diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
>index b3b4df9..f771130 100644
>--- a/arch/powerpc/kernel/pci_dn.c
>+++ b/arch/powerpc/kernel/pci_dn.c
>@@ -139,6 +139,7 @@ struct pci_dn *pci_get_pdn(struct pci_dev *pdev)
> #ifdef CONFIG_PCI_IOV
> static struct pci_dn *add_one_dev_pci_data(struct pci_dn *parent,
> 					   struct pci_dev *pdev,
>+					   int vf_index,
> 					   int busno, int devfn)
> {
> 	struct pci_dn *pdn;
>@@ -157,6 +158,7 @@ static struct pci_dn *add_one_dev_pci_data(struct pci_dn *parent,
> 	pdn->parent = parent;
> 	pdn->busno = busno;
> 	pdn->devfn = devfn;
>+	pdn->vf_index = vf_index;
> #ifdef CONFIG_PPC_POWERNV
> 	pdn->pe_number = IODA_INVALID_PE;
> #endif
>@@ -196,7 +198,7 @@ struct pci_dn *add_dev_pci_data(struct pci_dev *pdev)
> 		return NULL;
>
> 	for (i = 0; i < pci_sriov_get_totalvfs(pdev); i++) {
>-		pdn = add_one_dev_pci_data(parent, NULL,
>+		pdn = add_one_dev_pci_data(parent, NULL, i,
> 					   pci_iov_virtfn_bus(pdev, i),
> 					   pci_iov_virtfn_devfn(pdev, i));
> 		if (!pdn) {
>-- 
>1.7.9.5
>

