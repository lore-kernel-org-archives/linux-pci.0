Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp08.in.ibm.com ([122.248.162.8]:57369 "EHLO
	e28smtp08.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751971AbaFWG5C (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 23 Jun 2014 02:57:02 -0400
Received: from /spool/local
	by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Mon, 23 Jun 2014 12:26:59 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by d28dlp03.in.ibm.com (Postfix) with ESMTP id AEF8E125805E
	for <linux-pci@vger.kernel.org>; Mon, 23 Jun 2014 12:26:26 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s5N6vBCo10682854
	for <linux-pci@vger.kernel.org>; Mon, 23 Jun 2014 12:27:11 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
	by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s5N6usni026171
	for <linux-pci@vger.kernel.org>; Mon, 23 Jun 2014 12:26:55 +0530
Date: Mon, 23 Jun 2014 14:56:52 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, benh@au1.ibm.com,
	linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com,
	linux-pci@vger.kernel.org, yan@linux.vnet.ibm.com,
	qiudayu@linux.vnet.ibm.com
Subject: Re: [RFC PATCH V3 11/17] ppc/pnv: Expand VF resources according to
 the number of total_pe
Message-ID: <20140623065651.GD5172@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1402365399-5121-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1402365399-5121-12-git-send-email-weiyang@linux.vnet.ibm.com>
 <20140623060707.GA12055@shangw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140623060707.GA12055@shangw>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 23, 2014 at 04:07:07PM +1000, Gavin Shan wrote:
>On Tue, Jun 10, 2014 at 09:56:33AM +0800, Wei Yang wrote:
>>On PHB3, VF resources will be covered by M64 BAR to have better PE isolation.
>>Mostly the total_pe number is different from the total_VFs, which will lead to
>>a conflict between MMIO space and the PE number.
>>
>>This patch expands the VF resource size to reserve total_pe number of VFs'
>>resource, which prevents the conflict.
>>
>>Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>>---
>> arch/powerpc/include/asm/machdep.h        |    6 +++
>> arch/powerpc/include/asm/pci-bridge.h     |    3 ++
>> arch/powerpc/kernel/pci-common.c          |   15 ++++++
>> arch/powerpc/platforms/powernv/pci-ioda.c |   83 +++++++++++++++++++++++++++++
>> 4 files changed, 107 insertions(+)
>>
>>diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
>>index ad3025d..2f2e770 100644
>>--- a/arch/powerpc/include/asm/machdep.h
>>+++ b/arch/powerpc/include/asm/machdep.h
>>@@ -234,9 +234,15 @@ struct machdep_calls {
>>
>> 	/* Called after scan and before resource survey */
>> 	void (*pcibios_fixup_phb)(struct pci_controller *hose);
>>+#ifdef CONFIG_PCI_IOV
>>+	void (*pcibios_fixup_sriov)(struct pci_bus *bus);
>>+#endif /* CONFIG_PCI_IOV */
>>
>> 	/* Called during PCI resource reassignment */
>> 	resource_size_t (*pcibios_window_alignment)(struct pci_bus *, unsigned long type);
>>+#ifdef CONFIG_PCI_IOV
>>+	resource_size_t (*__pci_sriov_resource_size)(struct pci_dev *, int resno);
>
>	resource_size_t (*pcibios_sriov_resource_size)(struct pci_dev *, int resno);
>
>You probably can put all SRIOV related functions together:
>
>#ifdef CONFIG_PCI_IOV
>	func_a;
>	func_b;
>	 :
>#endif
>
>>+#endif /* CONFIG_PCI_IOV */
>>
>> 	/* Called to shutdown machine specific hardware not already controlled
>> 	 * by other drivers.
>>diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
>>index 4ca90a3..8c849d8 100644
>>--- a/arch/powerpc/include/asm/pci-bridge.h
>>+++ b/arch/powerpc/include/asm/pci-bridge.h
>>@@ -168,6 +168,9 @@ struct pci_dn {
>> #define IODA_INVALID_PE		(-1)
>> #ifdef CONFIG_PPC_POWERNV
>> 	int	pe_number;
>>+#ifdef CONFIG_PCI_IOV
>>+	u16     vfs;
>>+#endif /* CONFIG_PCI_IOV */
>> #endif
>> };
>>
>>diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
>>index c449a26..c4e2e92 100644
>>--- a/arch/powerpc/kernel/pci-common.c
>>+++ b/arch/powerpc/kernel/pci-common.c
>>@@ -120,6 +120,16 @@ resource_size_t pcibios_window_alignment(struct pci_bus *bus,
>> 	return 1;
>> }
>>
>>+#ifdef CONFIG_PCI_IOV
>>+resource_size_t pcibios_sriov_resource_size(struct pci_dev *pdev, int resno)
>>+{
>>+	if (ppc_md.__pci_sriov_resource_size)
>>+		return ppc_md.__pci_sriov_resource_size(pdev, resno);
>>+
>>+	return 0;
>>+}
>>+#endif /* CONFIG_PCI_IOV */
>>+
>> static resource_size_t pcibios_io_size(const struct pci_controller *hose)
>> {
>> #ifdef CONFIG_PPC64
>>@@ -1675,6 +1685,11 @@ void pcibios_scan_phb(struct pci_controller *hose)
>> 	if (ppc_md.pcibios_fixup_phb)
>> 		ppc_md.pcibios_fixup_phb(hose);
>>
>>+#ifdef CONFIG_PCI_IOV
>>+	if (ppc_md.pcibios_fixup_sriov)
>>+		ppc_md.pcibios_fixup_sriov(bus);
>
>One question I probably asked before: why we can't put the logic
>of ppc_md.pcibios_fixup_sriov() to ppc_md.pcibios_fixup_phb()?
>

Yep, you have asked before and I replied before too :-)

During EEH hotplug, if the PF are removed, the IOV BAR will be retrieved from
the device itself again. If I merge this fixup into
ppc_md.pcibios_fixup_phb(), this is not proper to be invoked at hotplug event.

Or fixup the phb during EEH hotplug is reasonable?


-- 
Richard Yang
Help you, Help me

