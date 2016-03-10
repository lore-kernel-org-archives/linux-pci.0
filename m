Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp02.au.ibm.com ([202.81.31.144]:59459 "EHLO
	e23smtp02.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753717AbcCJXUD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 Mar 2016 18:20:03 -0500
Received: from localhost
	by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Fri, 11 Mar 2016 09:20:00 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
	by d23dlp02.au.ibm.com (Postfix) with ESMTP id BE90D2BB0057
	for <linux-pci@vger.kernel.org>; Fri, 11 Mar 2016 10:19:51 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u2ANJhuP46596320
	for <linux-pci@vger.kernel.org>; Fri, 11 Mar 2016 10:19:51 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u2ANJI7t009212
	for <linux-pci@vger.kernel.org>; Fri, 11 Mar 2016 10:19:19 +1100
Date: Fri, 11 Mar 2016 10:18:23 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	mpe@ellerman.id.au, paulus@samba.org, imunsie@au1.ibm.com,
	mikey@neuling.org, andrew.donnellan@au1.ibm.com,
	gwshan@linux.vnet.ibm.com, bhelgaas@google.com
Subject: Re: [PATCH] powerpc/pci: Reuse PHB number on pci_controller add if
 available
Message-ID: <20160310231823.GA5270@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1457633505-19857-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <1457633505-19857-2-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <1457645698.24238.76.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1457645698.24238.76.camel@kernel.crashing.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 11, 2016 at 08:34:58AM +1100, Benjamin Herrenschmidt wrote:
>On Thu, 2016-03-10 at 15:11 -0300, Guilherme G. Piccoli wrote:
>> The domain/PHB field of PCI addresses has its value obtained from a
>> global variable, incremented each time a new domain (represented by
>> struct pci_controller) is added on the system. The domain addition
>> process happens during boot or due to PCI device hotplug.
>
>I'd rather we use a fixed numbering for domains, for example, under
>OPAL, use the opal-id, under phyp, there is also a number in the DT we
>can use (forgot what it's called) etc...
>


guest on phyp has something like below:

ibm,fw-phb-id = <0x8000000 0x20000200>;

However, PowerKVM guest doesn't have it. I guess it's a problem, right?

Thanks,
Gavin

>> As recent kernels are using predictable naming for network
>> interfaces,
>> the network stack is more tied to PCI naming. This can be a problem
>> in
>> hotplug scenarios, because PCI addresses will change if a device is
>> removed and then re-added. This situation seems unusual, but it can
>> happen if a user wants to replace a NIC without rebooting the
>> machine,
>> for example.
>> 
>> This patch changes the way PCI domain values are generated: the
>> global
>> variable is no longer used; instead, a list is introduced, containing
>> a flag that indicates whenever a domain is in use or was released,
>> for
>> example by a PCI hotplug remove. If the new PHB being added finds a
>> free domain, it will use its number; otherwise a new number is
>> generated incrementing the higher domain value present on the system.
>> No functional changes were introduced.
>> 
>> Signed-off-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/kernel/pci-common.c | 47
>> +++++++++++++++++++++++++++++++++++++---
>>  1 file changed, 44 insertions(+), 3 deletions(-)
>> 
>> diff --git a/arch/powerpc/kernel/pci-common.c
>> b/arch/powerpc/kernel/pci-common.c
>> index 0f7a60f..6eac0dd 100644
>> --- a/arch/powerpc/kernel/pci-common.c
>> +++ b/arch/powerpc/kernel/pci-common.c
>> @@ -44,8 +44,12 @@
>>  static DEFINE_SPINLOCK(hose_spinlock);
>>  LIST_HEAD(hose_list);
>>  
>> -/* XXX kill that some day ... */
>> -static int global_phb_number;		/* Global phb counter
>> */
>> +/* Global PHB counter list */
>> +struct global_phb_number {
>> +	bool used;
>> +	struct list_head node;
>> +};
>> +LIST_HEAD(global_phb_number_list);
>>  
>>  /* ISA Memory physical address */
>>  resource_size_t isa_mem_base;
>> @@ -64,6 +68,42 @@ struct dma_map_ops *get_pci_dma_ops(void)
>>  }
>>  EXPORT_SYMBOL(get_pci_dma_ops);
>>  
>> +static int get_phb_number(void)
>> +{
>> +	struct global_phb_number *ptr;
>> +	int latest_number = 0;
>> +
>> +	list_for_each_entry(ptr, &global_phb_number_list, node) {
>> +		if (!ptr->used) {
>> +			ptr->used = true;
>> +			return latest_number;
>> +		}
>> +		latest_number++;
>> +	}
>> +
>> +	ptr = zalloc_maybe_bootmem(sizeof(struct global_phb_number),
>> GFP_KERNEL);
>> +	BUG_ON(ptr == NULL);
>> +
>> +	ptr->used = true;
>> +	list_add_tail(&ptr->node, &global_phb_number_list);
>> +
>> +	return latest_number;
>> +}
>> +
>> +static void release_phb_number(int phb_number)
>> +{
>> +	struct global_phb_number *ptr;
>> +	int current_number = 0;
>> +
>> +	list_for_each_entry(ptr, &global_phb_number_list, node) {
>> +		if (current_number == phb_number) {
>> +			ptr->used = false;
>> +			return;
>> +		}
>> +		current_number++;
>> +	}
>> +}
>> +
>>  struct pci_controller *pcibios_alloc_controller(struct device_node
>> *dev)
>>  {
>>  	struct pci_controller *phb;
>> @@ -72,7 +112,7 @@ struct pci_controller
>> *pcibios_alloc_controller(struct device_node *dev)
>>  	if (phb == NULL)
>>  		return NULL;
>>  	spin_lock(&hose_spinlock);
>> -	phb->global_number = global_phb_number++;
>> +	phb->global_number = get_phb_number();
>>  	list_add_tail(&phb->list_node, &hose_list);
>>  	spin_unlock(&hose_spinlock);
>>  	phb->dn = dev;
>> @@ -94,6 +134,7 @@ EXPORT_SYMBOL_GPL(pcibios_alloc_controller);
>>  void pcibios_free_controller(struct pci_controller *phb)
>>  {
>>  	spin_lock(&hose_spinlock);
>> +	release_phb_number(phb->global_number);
>>  	list_del(&phb->list_node);
>>  	spin_unlock(&hose_spinlock);
>>  
>

