Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <54FF1383.7030301@broadcom.com>
Date: Tue, 10 Mar 2015 08:53:39 -0700
From: Ray Jui <rjui@broadcom.com>
MIME-Version: 1.0
To: Alex Williamson <alex.williamson@redhat.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Paul Bolle <pebolle@tiscali.nl>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Dmitry Torokhov <dtor@google.com>,
	Anatol Pomazau <anatol@google.com>,
	Scott Branden <sbranden@broadcom.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<bcm-kernel-feedback-list@broadcom.com>,
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 1/4] PCI: Export symbols of PCI functions
References: <1425946878-13169-1-git-send-email-rjui@broadcom.com>	 <1425946878-13169-2-git-send-email-rjui@broadcom.com> <1425949234.25026.24.camel@redhat.com>
In-Reply-To: <1425949234.25026.24.camel@redhat.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Alex,

On 3/9/2015 6:00 PM, Alex Williamson wrote:
> On Mon, 2015-03-09 at 17:21 -0700, Ray Jui wrote:
>> Export symbols of the following PCI functions so they can be referenced
>> by a PCI driver compiled as a kernel loadable module:
>>
>> pci_common_swizzle
>> pci_create_root_bus
>> pci_stop_root_bus
>> pci_remove_root_bus
>> pci_assign_unassigned_bus_resources
>> pci_fixup_irqs
>>
>> Signed-off-by: Ray Jui <rjui@broadcom.com>
>> ---
>>  drivers/pci/pci.c       |    1 +
>>  drivers/pci/probe.c     |    1 +
>>  drivers/pci/remove.c    |    2 ++
>>  drivers/pci/setup-bus.c |    1 +
>>  drivers/pci/setup-irq.c |    1 +
>>  5 files changed, 6 insertions(+)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 81f06e8..fb4a3da 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -2492,6 +2492,7 @@ u8 pci_common_swizzle(struct pci_dev *dev, u8 *pinp)
>>  	*pinp = pin;
>>  	return PCI_SLOT(dev->devfn);
>>  }
>> +EXPORT_SYMBOL(pci_common_swizzle);
>>  
>>  /**
>>   *	pci_release_region - Release a PCI bar
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index 8d2f400..eb24ef9 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -1993,6 +1993,7 @@ err_out:
>>  	kfree(b);
>>  	return NULL;
>>  }
>> +EXPORT_SYMBOL(pci_create_root_bus);
>>  
>>  int pci_bus_insert_busn_res(struct pci_bus *b, int bus, int bus_max)
>>  {
>> diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
>> index 8bd76c9..c523159 100644
>> --- a/drivers/pci/remove.c
>> +++ b/drivers/pci/remove.c
>> @@ -139,6 +139,7 @@ void pci_stop_root_bus(struct pci_bus *bus)
>>  	/* stop the host bridge */
>>  	device_release_driver(&host_bridge->dev);
>>  }
>> +EXPORT_SYMBOL(pci_stop_root_bus);
>>  
>>  void pci_remove_root_bus(struct pci_bus *bus)
>>  {
>> @@ -158,3 +159,4 @@ void pci_remove_root_bus(struct pci_bus *bus)
>>  	/* remove the host bridge */
>>  	device_unregister(&host_bridge->dev);
>>  }
>> +EXPORT_SYMBOL(pci_remove_root_bus);
>> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
>> index e3e17f3..932c9e5 100644
>> --- a/drivers/pci/setup-bus.c
>> +++ b/drivers/pci/setup-bus.c
>> @@ -1750,3 +1750,4 @@ void pci_assign_unassigned_bus_resources(struct pci_bus *bus)
>>  	__pci_bus_assign_resources(bus, &add_list, NULL);
>>  	BUG_ON(!list_empty(&add_list));
>>  }
>> +EXPORT_SYMBOL(pci_assign_unassigned_bus_resources);
>> diff --git a/drivers/pci/setup-irq.c b/drivers/pci/setup-irq.c
>> index 4e2d595..9d2bbb6 100644
>> --- a/drivers/pci/setup-irq.c
>> +++ b/drivers/pci/setup-irq.c
>> @@ -65,3 +65,4 @@ void pci_fixup_irqs(u8 (*swizzle)(struct pci_dev *, u8 *),
>>  	for_each_pci_dev(dev)
>>  		pdev_fixup_irq(dev, swizzle, map_irq);
>>  }
>> +EXPORT_SYMBOL(pci_fixup_irqs);
> 
> 
> Why not EXPORT_SYMBOL_GPL for all of these?  Some of these seem fairly
> close to PCI core functionality for arbitrarily licensed modules.
> 

I have no issue with that. I know there have been a lot of debates on
EXPORT_SYMBOL vs. EXPORT_SYMBOL_GPL use. If EXPORT_SYMBOL_GPL is
preferred on these PCI functions here, I'll make the change.


I'm still waiting for comments from Bjorn on the Broadcom iProc PCI
driver itself. This change will go with other changes in the iProc PCI
driver.

Thanks,

Ray
