Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp01.au.ibm.com ([202.81.31.143]:47569 "EHLO
	e23smtp01.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751228AbbFIFu1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 9 Jun 2015 01:50:27 -0400
Received: from /spool/local
	by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Tue, 9 Jun 2015 15:50:26 +1000
Date: Tue, 9 Jun 2015 15:49:23 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, benh@kernel.crashing.org,
	aik@ozlabs.ru, panto@antoniou-consulting.com,
	robherring2@gmail.com, grant.likely@linaro.org
Subject: Re: [PATCH v5 01/42] PCI: Add pcibios_setup_bridge()
Message-ID: <20150609054922.GB25215@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1433400131-18429-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1433400131-18429-2-git-send-email-gwshan@linux.vnet.ibm.com>
 <20150605194432.GN3631@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150605194432.GN3631@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 05, 2015 at 02:44:32PM -0500, Bjorn Helgaas wrote:
>On Thu, Jun 04, 2015 at 04:41:30PM +1000, Gavin Shan wrote:
>> Currently, PowerPC PowerNV platform utilizes ppc_md.pcibios_fixup(),
>> which is called for once after PCI probing and resource assignment
>> are completed, to allocate platform required resources for PCI devices:
>> PE#, IO and MMIO mapping, DMA address translation (TCE) table etc.
>> Obviously, it's not hotplug friendly.
>> 
>> The patch adds weak function pcibios_setup_bridge(), which is called
>> by pci_setup_bridge(). PowerPC PowerNV platform will reuse the function
>> to assign above platform required resources to newly added PCI devices,
>> in order to support PCI hotplug in subsequent patches.
>> 
>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>
>Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>

Thanks for your review, Bjorn.

Thanks,
Gavin

>> ---
>> v5:
>>   * Corrected subject as Bjorn suggested
>>   * pci_setup_bridge() calls pcibios_setup_bridge() and __pci_setup_bridge()
>> ---
>>  drivers/pci/setup-bus.c | 5 +++++
>>  include/linux/pci.h     | 1 +
>>  2 files changed, 6 insertions(+)
>> 
>> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
>> index 4fd0cac..623dee3 100644
>> --- a/drivers/pci/setup-bus.c
>> +++ b/drivers/pci/setup-bus.c
>> @@ -693,11 +693,16 @@ static void __pci_setup_bridge(struct pci_bus *bus, unsigned long type)
>>  	pci_write_config_word(bridge, PCI_BRIDGE_CONTROL, bus->bridge_ctl);
>>  }
>>  
>> +void __weak pcibios_setup_bridge(struct pci_bus *bus, unsigned long type)
>> +{
>> +}
>> +
>>  void pci_setup_bridge(struct pci_bus *bus)
>>  {
>>  	unsigned long type = IORESOURCE_IO | IORESOURCE_MEM |
>>  				  IORESOURCE_PREFETCH;
>>  
>> +	pcibios_setup_bridge(bus, type);
>>  	__pci_setup_bridge(bus, type);
>>  }
>>  
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 94bacfa..5aacd0a 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -811,6 +811,7 @@ void pci_stop_and_remove_bus_device_locked(struct pci_dev *dev);
>>  void pci_stop_root_bus(struct pci_bus *bus);
>>  void pci_remove_root_bus(struct pci_bus *bus);
>>  void pci_setup_cardbus(struct pci_bus *bus);
>> +void pcibios_setup_bridge(struct pci_bus *bus, unsigned long type);
>>  void pci_sort_breadthfirst(void);
>>  #define dev_is_pci(d) ((d)->bus == &pci_bus_type)
>>  #define dev_is_pf(d) ((dev_is_pci(d) ? to_pci_dev(d)->is_physfn : false))
>> -- 
>> 2.1.0
>> 
>

