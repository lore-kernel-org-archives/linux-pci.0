Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp08.au.ibm.com ([202.81.31.141]:59311 "EHLO
	e23smtp08.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751587AbbFBDpB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 1 Jun 2015 23:45:01 -0400
Received: from /spool/local
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Tue, 2 Jun 2015 13:44:59 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
	by d23dlp02.au.ibm.com (Postfix) with ESMTP id 722862BB0047
	for <linux-pci@vger.kernel.org>; Tue,  2 Jun 2015 13:44:55 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t523ik9957475116
	for <linux-pci@vger.kernel.org>; Tue, 2 Jun 2015 13:44:55 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t523iMms013248
	for <linux-pci@vger.kernel.org>; Tue, 2 Jun 2015 13:44:22 +1000
Date: Tue, 2 Jun 2015 11:44:04 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, gwshan@linux.vnet.ibm.com,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH V7 03/10] powerpc/pci: Remove VFs prior to PF
Message-ID: <20150602034404.GA6785@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1431999312-10517-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1432032612-21701-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1432032612-21701-4-git-send-email-weiyang@linux.vnet.ibm.com>
 <20150601232005.GD3631@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150601232005.GD3631@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 01, 2015 at 06:20:05PM -0500, Bjorn Helgaas wrote:
>On Tue, May 19, 2015 at 06:50:05PM +0800, Wei Yang wrote:
>> As commit ac205b7b ("PCI: make sriov work with hotplug remove") indicates,
>
>The conventional reference is:
>
>  ac205b7bb72f ("PCI: make sriov work with hotplug remove")
>

Thanks, will change it in next version.

>> VFs, which might be hooked to same PCI bus as their PF should be removed
>> before the PF. Otherwise, the PCI hot unplugging on the PCI bus would
>> cause kernel crash.
>> 
>> The patch applies the above pattern to PowerPC PCI hotplug path.
>> 
>> [gwshan: changelog]
>> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>> Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/kernel/pci-hotplug.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/arch/powerpc/kernel/pci-hotplug.c b/arch/powerpc/kernel/pci-hotplug.c
>> index 7ed85a6..98f84ed 100644
>> --- a/arch/powerpc/kernel/pci-hotplug.c
>> +++ b/arch/powerpc/kernel/pci-hotplug.c
>> @@ -50,7 +50,7 @@ void pcibios_remove_pci_devices(struct pci_bus *bus)
>>  
>>  	pr_debug("PCI: Removing devices on bus %04x:%02x\n",
>>  		 pci_domain_nr(bus),  bus->number);
>> -	list_for_each_entry_safe(dev, tmp, &bus->devices, bus_list) {
>> +	list_for_each_entry_safe_reverse(dev, tmp, &bus->devices, bus_list) {
>>  		pr_debug("   Removing %s...\n", pci_name(dev));
>>  		pci_stop_and_remove_bus_device(dev);
>>  	}
>> -- 
>> 1.7.9.5
>> 

-- 
Richard Yang
Help you, Help me

