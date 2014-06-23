Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp02.au.ibm.com ([202.81.31.144]:36783 "EHLO
	e23smtp02.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751121AbaFWHJQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 23 Jun 2014 03:09:16 -0400
Received: from /spool/local
	by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Mon, 23 Jun 2014 17:08:59 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
	by d23dlp02.au.ibm.com (Postfix) with ESMTP id 94B752BB0055
	for <linux-pci@vger.kernel.org>; Mon, 23 Jun 2014 17:08:57 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s5N6qbgB28442716
	for <linux-pci@vger.kernel.org>; Mon, 23 Jun 2014 16:52:38 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s5N78uuf006631
	for <linux-pci@vger.kernel.org>; Mon, 23 Jun 2014 17:08:56 +1000
Date: Mon, 23 Jun 2014 17:08:57 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, benh@au1.ibm.com,
	linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com,
	linux-pci@vger.kernel.org, yan@linux.vnet.ibm.com,
	qiudayu@linux.vnet.ibm.com
Subject: Re: [RFC PATCH V3 11/17] ppc/pnv: Expand VF resources according to
 the number of total_pe
Message-ID: <20140623070857.GA22440@shangw>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1402365399-5121-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1402365399-5121-12-git-send-email-weiyang@linux.vnet.ibm.com>
 <20140623060707.GA12055@shangw>
 <20140623065651.GD5172@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140623065651.GD5172@richard>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 23, 2014 at 02:56:52PM +0800, Wei Yang wrote:
>On Mon, Jun 23, 2014 at 04:07:07PM +1000, Gavin Shan wrote:
>>On Tue, Jun 10, 2014 at 09:56:33AM +0800, Wei Yang wrote:
>>>On PHB3, VF resources will be covered by M64 BAR to have better PE isolation.
>>>Mostly the total_pe number is different from the total_VFs, which will lead to
>>>a conflict between MMIO space and the PE number.
>>>
>>>This patch expands the VF resource size to reserve total_pe number of VFs'
>>>resource, which prevents the conflict.
>>>
>>>Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>>>---
>>> arch/powerpc/include/asm/machdep.h        |    6 +++
>>> arch/powerpc/include/asm/pci-bridge.h     |    3 ++
>>> arch/powerpc/kernel/pci-common.c          |   15 ++++++
>>> arch/powerpc/platforms/powernv/pci-ioda.c |   83 +++++++++++++++++++++++++++++
>>> 4 files changed, 107 insertions(+)
>>>
>>>diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
>>>index ad3025d..2f2e770 100644
>>>--- a/arch/powerpc/include/asm/machdep.h
>>>+++ b/arch/powerpc/include/asm/machdep.h
>>>@@ -234,9 +234,15 @@ struct machdep_calls {
>>>
>>> 	/* Called after scan and before resource survey */
>>> 	void (*pcibios_fixup_phb)(struct pci_controller *hose);
>>>+#ifdef CONFIG_PCI_IOV
>>>+	void (*pcibios_fixup_sriov)(struct pci_bus *bus);
>>>+#endif /* CONFIG_PCI_IOV */
>>>
>>> 	/* Called during PCI resource reassignment */
>>> 	resource_size_t (*pcibios_window_alignment)(struct pci_bus *, unsigned long type);
>>>+#ifdef CONFIG_PCI_IOV
>>>+	resource_size_t (*__pci_sriov_resource_size)(struct pci_dev *, int resno);
>>
>>	resource_size_t (*pcibios_sriov_resource_size)(struct pci_dev *, int resno);
>>
>>You probably can put all SRIOV related functions together:
>>
>>#ifdef CONFIG_PCI_IOV
>>	func_a;
>>	func_b;
>>	 :
>>#endif
>>
>>>+#endif /* CONFIG_PCI_IOV */
>>>
>>> 	/* Called to shutdown machine specific hardware not already controlled
>>> 	 * by other drivers.
>>>diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
>>>index 4ca90a3..8c849d8 100644
>>>--- a/arch/powerpc/include/asm/pci-bridge.h
>>>+++ b/arch/powerpc/include/asm/pci-bridge.h
>>>@@ -168,6 +168,9 @@ struct pci_dn {
>>> #define IODA_INVALID_PE		(-1)
>>> #ifdef CONFIG_PPC_POWERNV
>>> 	int	pe_number;
>>>+#ifdef CONFIG_PCI_IOV
>>>+	u16     vfs;
>>>+#endif /* CONFIG_PCI_IOV */
>>> #endif
>>> };
>>>
>>>diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
>>>index c449a26..c4e2e92 100644
>>>--- a/arch/powerpc/kernel/pci-common.c
>>>+++ b/arch/powerpc/kernel/pci-common.c
>>>@@ -120,6 +120,16 @@ resource_size_t pcibios_window_alignment(struct pci_bus *bus,
>>> 	return 1;
>>> }
>>>
>>>+#ifdef CONFIG_PCI_IOV
>>>+resource_size_t pcibios_sriov_resource_size(struct pci_dev *pdev, int resno)
>>>+{
>>>+	if (ppc_md.__pci_sriov_resource_size)
>>>+		return ppc_md.__pci_sriov_resource_size(pdev, resno);
>>>+
>>>+	return 0;
>>>+}
>>>+#endif /* CONFIG_PCI_IOV */
>>>+
>>> static resource_size_t pcibios_io_size(const struct pci_controller *hose)
>>> {
>>> #ifdef CONFIG_PPC64
>>>@@ -1675,6 +1685,11 @@ void pcibios_scan_phb(struct pci_controller *hose)
>>> 	if (ppc_md.pcibios_fixup_phb)
>>> 		ppc_md.pcibios_fixup_phb(hose);
>>>
>>>+#ifdef CONFIG_PCI_IOV
>>>+	if (ppc_md.pcibios_fixup_sriov)
>>>+		ppc_md.pcibios_fixup_sriov(bus);
>>
>>One question I probably asked before: why we can't put the logic
>>of ppc_md.pcibios_fixup_sriov() to ppc_md.pcibios_fixup_phb()?
>>
>
>Yep, you have asked before and I replied before too :-)
>
>During EEH hotplug, if the PF are removed, the IOV BAR will be retrieved from
>the device itself again. If I merge this fixup into
>ppc_md.pcibios_fixup_phb(), this is not proper to be invoked at hotplug event.
>
>Or fixup the phb during EEH hotplug is reasonable?
>

Yeah. It's not reasonable to apply fixup to PHB when doing hotplug on PF.

Thanks,
Gavin

