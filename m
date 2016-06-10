Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:22939 "EHLO
	mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751630AbcFJEek (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jun 2016 00:34:40 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u5A4XtNi110626
	for <linux-pci@vger.kernel.org>; Fri, 10 Jun 2016 00:34:39 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
	by mx0a-001b2d01.pphosted.com with ESMTP id 23fm51afd4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 10 Jun 2016 00:34:39 -0400
Received: from localhost
	by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Fri, 10 Jun 2016 14:34:36 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
	by d23dlp01.au.ibm.com (Postfix) with ESMTP id 234532CE805A
	for <linux-pci@vger.kernel.org>; Fri, 10 Jun 2016 14:34:23 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u5A4YNt052232326
	for <linux-pci@vger.kernel.org>; Fri, 10 Jun 2016 14:34:23 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u5A4YLgd000592
	for <linux-pci@vger.kernel.org>; Fri, 10 Jun 2016 14:34:22 +1000
Date: Fri, 10 Jun 2016 14:33:49 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	benh@kernel.crashing.org, mpe@ellerman.id.au, alistair@popple.id.au
Subject: Re: [PATCH v10 09/18] powerpc/powernv: Extend PCI bridge resources
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1463726502-14679-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1463726502-14679-10-git-send-email-gwshan@linux.vnet.ibm.com>
 <9bd72b5a-c4c5-9ab7-7c82-cb4d7e8d51fd@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <9bd72b5a-c4c5-9ab7-7c82-cb4d7e8d51fd@ozlabs.ru>
Message-Id: <20160610043349.GA17817@gwshan>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 08, 2016 at 01:47:16PM +1000, Alexey Kardashevskiy wrote:
>On 20/05/16 16:41, Gavin Shan wrote:
>> The PCI slots are associated with root port or downstream ports
>> of the PCIe switch connected to root port. When adapter is hot
>> added to the PCI slot, it usually requests more IO or memory
>> resource from the directly connected parent bridge (port) and
>> update the bridge's windows accordingly. The resource windows
>> of upstream bridges can't be updated automatically. It possibly
>> leads to unbalanced resource across the bridges: The window of
>> downstream bridge is overruning that of upstream bridge. The
>> IO or MMIO path won't work.
>> 
>> This resolves the above issue by extending bridge windows of
>> root port and upstream port of the PCIe switch connected to
>> the root port to PHB's windows.
>> 
>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>
>
>This breaks Garrison machine (g86l):
>
>EEH: Frozen PE#f9 on PHB#5 detected
>EEH: PE location: Backplane PLX, PHB location: N/A
>EEH: This PCI device has failed 1 times in the last hour
>EEH: Notify device drivers to shutdown
>EEH: Collect temporary log
>

Thanks for reporting the issue. I don't think the issue was caused by
the code in this patch. Actually, it's likely caused by hardware defect
- we can't set 2GB (0x80000000 - 0xffffffff) to RC's memory window.
Otherwise, it *seems* the window is disabled. I tried updating the
window with (0x80000000 - 0xffefffff) or (0x80000000 - 0xffdffff), no
EEH error was seen. I already got 0x00001000 on read despite whatever
I wrote to 0x20 reg.

The hardware is broken. In order to fix this, I intend to include a
bitmap for every PHB device node in skiboot. Kernel uses this to apply
fixup accordingly. One bit is reserved on Garrison platform to avoid
this issue. The fix can be a patch inserted before this patch in next
revision or as a followup patch after this series of patches.

>
>PHB#5 has a boot device so we end up in initramdisk.
>
>
>│0005:03:00.0 USB controller: Texas Instruments TUSB73x0 SuperSpeed USB 3.0
>xHCI Host Controller (rev 02)
>│0005:04:00.0 SATA controller: Marvell Technology Group Ltd. 88SE9235 PCIe
>2.0 x2 4-port SATA 6 Gb/s Controller (rev 11)
>│0005:05:00.0 PCI bridge: ASPEED Technology, Inc. AST1150 PCI-to-PCI Bridge
>(rev 03)
>│0005:06:00.0 VGA compatible controller: ASPEED Technology, Inc. ASPEED
>Graphics Family (rev 30)
>
>
>
>> ---
>>  arch/powerpc/platforms/powernv/pci-ioda.c | 46 +++++++++++++++++++++++++++++++
>>  1 file changed, 46 insertions(+)
>> 
>> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>> index 3186a29..e97a5fa 100644
>> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
>> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>> @@ -3221,6 +3221,49 @@ static resource_size_t pnv_pci_window_alignment(struct pci_bus *bus,
>>  	return phb->ioda.io_segsize;
>>  }
>>  
>> +/*
>> + * We are updating root port or the upstream port of the
>> + * bridge behind the root port with PHB's windows in order
>> + * to accommodate the changes on required resources during
>> + * PCI (slot) hotplug, which is connected to either root
>> + * port or the downstream ports of PCIe switch behind the
>> + * root port.
>> + */
>> +static void pnv_pci_fixup_bridge_resources(struct pci_bus *bus,
>> +					   unsigned long type)
>> +{
>> +	struct pci_controller *hose = pci_bus_to_host(bus);
>> +	struct pnv_phb *phb = hose->private_data;
>> +	struct pci_dev *bridge = bus->self;
>> +	struct resource *r, *w;
>> +	int i;
>> +
>> +	/* Check if we need apply fixup to the bridge's windows */
>> +	if (!pci_is_root_bus(bridge->bus) &&
>> +	    !pci_is_root_bus(bridge->bus->self->bus))
>> +		return;
>> +
>> +	/* Fixup the resources */
>> +	for (i = 0; i < PCI_BRIDGE_RESOURCE_NUM; i++) {
>> +		r = &bridge->resource[PCI_BRIDGE_RESOURCES + i];
>> +		if (!r->flags || !r->parent)
>> +			continue;
>> +
>> +		w = NULL;
>> +		if (r->flags & type & IORESOURCE_IO)
>> +			w = &hose->io_resource;
>> +		else if (pnv_pci_is_mem_pref_64(r->flags) &&
>> +			 (type & IORESOURCE_PREFETCH) &&
>> +			 phb->ioda.m64_segsize)
>> +			w = &hose->mem_resources[1];
>> +		else if (r->flags & type & IORESOURCE_MEM)
>> +			w = &hose->mem_resources[0];
>> +
>> +		r->start = w->start;
>> +		r->end = w->end;
>> +	}
>> +}
>> +
>>  static void pnv_pci_setup_bridge(struct pci_bus *bus, unsigned long type)
>>  {
>>  	struct pci_controller *hose = pci_bus_to_host(bus);
>> @@ -3229,6 +3272,9 @@ static void pnv_pci_setup_bridge(struct pci_bus *bus, unsigned long type)
>>  	struct pnv_ioda_pe *pe;
>>  	bool all = (pci_pcie_type(bridge) == PCI_EXP_TYPE_PCI_BRIDGE);
>>  
>> +	/* Extend bridge's windows if necessary */
>> +	pnv_pci_fixup_bridge_resources(bus, type);
>> +
>>  	/* The PE for root bus should be realized before any one else */
>>  	if (!phb->ioda.root_pe_populated) {
>>  		pe = pnv_ioda_setup_bus_PE(phb->hose->bus, false);
>> 
>
>
>-- 
>Alexey
>

