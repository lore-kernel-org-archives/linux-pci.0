Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp08.au.ibm.com ([202.81.31.141]:57919 "EHLO
	e23smtp08.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750722AbaFWIVt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 23 Jun 2014 04:21:49 -0400
Received: from /spool/local
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Mon, 23 Jun 2014 18:21:47 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
	by d23dlp03.au.ibm.com (Postfix) with ESMTP id EA6CD3578048
	for <linux-pci@vger.kernel.org>; Mon, 23 Jun 2014 18:21:44 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s5N7xTuL65732858
	for <linux-pci@vger.kernel.org>; Mon, 23 Jun 2014 17:59:29 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s5N8Lhni024938
	for <linux-pci@vger.kernel.org>; Mon, 23 Jun 2014 18:21:44 +1000
Date: Mon, 23 Jun 2014 16:21:42 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, benh@au1.ibm.com,
	linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com,
	linux-pci@vger.kernel.org, yan@linux.vnet.ibm.com,
	qiudayu@linux.vnet.ibm.com
Subject: Re: [RFC PATCH V3 12/17] powerpc/powernv: implement
 pcibios_sriov_resource_alignment on powernv
Message-ID: <20140623082142.GB4509@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1402365399-5121-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1402365399-5121-13-git-send-email-weiyang@linux.vnet.ibm.com>
 <20140623060947.GB12055@shangw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140623060947.GB12055@shangw>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 23, 2014 at 04:09:47PM +1000, Gavin Shan wrote:
>On Tue, Jun 10, 2014 at 09:56:34AM +0800, Wei Yang wrote:
>>This patch implements the pcibios_sriov_resource_alignment() on powernv
>>platform.
>>
>>Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>>---
>> arch/powerpc/include/asm/machdep.h        |    1 +
>> arch/powerpc/kernel/pci-common.c          |    8 ++++++++
>> arch/powerpc/platforms/powernv/pci-ioda.c |   17 +++++++++++++++++
>> 3 files changed, 26 insertions(+)
>>
>>diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
>>index 2f2e770..3bbc55f 100644
>>--- a/arch/powerpc/include/asm/machdep.h
>>+++ b/arch/powerpc/include/asm/machdep.h
>>@@ -242,6 +242,7 @@ struct machdep_calls {
>> 	resource_size_t (*pcibios_window_alignment)(struct pci_bus *, unsigned long type);
>> #ifdef CONFIG_PCI_IOV
>> 	resource_size_t (*__pci_sriov_resource_size)(struct pci_dev *, int resno);
>>+	resource_size_t (*__pci_sriov_resource_alignment)(struct pci_dev *, int resno, resource_size_t align);
>> #endif /* CONFIG_PCI_IOV */
>>
>> 	/* Called to shutdown machine specific hardware not already controlled
>>diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
>>index c4e2e92..35345ac 100644
>>--- a/arch/powerpc/kernel/pci-common.c
>>+++ b/arch/powerpc/kernel/pci-common.c
>>@@ -128,6 +128,14 @@ resource_size_t pcibios_sriov_resource_size(struct pci_dev *pdev, int resno)
>>
>> 	return 0;
>> }
>>+
>>+resource_size_t pcibios_sriov_resource_alignment(struct pci_dev *pdev, int resno, resource_size_t align)
>>+{
>>+	if (ppc_md.__pci_sriov_resource_alignment)
>>+		return ppc_md.__pci_sriov_resource_alignment(pdev, resno, align);
>>+
>>+	return 0;
>>+}
>> #endif /* CONFIG_PCI_IOV */
>>
>> static resource_size_t pcibios_io_size(const struct pci_controller *hose)
>>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>>index 7dfad6a..b0ac851 100644
>>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
>>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>>@@ -1573,6 +1573,22 @@ static resource_size_t __pnv_pci_sriov_resource_size(struct pci_dev *pdev, int r
>>
>> 	return size;
>> }
>>+
>>+static resource_size_t __pnv_pci_sriov_resource_alignment(struct pci_dev *pdev, int resno,
>>+		resource_size_t align)
>
>The function could be "pcibios_sriov_resource_alignment()", but it's not a big deal.
>If you prefer the original one, then keep it :)

I guess you want to name it to pnv_pcibios_sriov_resource_alignment()?
pcibios_sriov_resource_alignment() is the general name for this function.

If yes, this is changed.

>
>>+{
>>+	struct pci_dn *pdn = pci_get_pdn(pdev);
>>+	resource_size_t iov_align;
>>+
>>+	iov_align = resource_size(&pdev->resource[resno]);
>>+	if (iov_align)
>>+		return iov_align;
>>+
>>+	if (pdn->vfs)
>>+		return pdn->vfs * align;
>>+
>>+	return align;
>>+}
>> #endif /* CONFIG_PCI_IOV */
>>
>> /* Prevent enabling devices for which we couldn't properly
>>@@ -1777,6 +1793,7 @@ void __init pnv_pci_init_ioda_phb(struct device_node *np,
>> 	ppc_md.pcibios_window_alignment = pnv_pci_window_alignment;
>> #ifdef CONFIG_PCI_IOV
>> 	ppc_md.__pci_sriov_resource_size = __pnv_pci_sriov_resource_size;
>>+	ppc_md.__pci_sriov_resource_alignment = __pnv_pci_sriov_resource_alignment;
>> #endif /* CONFIG_PCI_IOV */
>> 	pci_add_flags(PCI_REASSIGN_ALL_RSRC);
>>
>
>Thanks,
>Gavin

-- 
Richard Yang
Help you, Help me

