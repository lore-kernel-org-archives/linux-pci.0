Return-Path: <okaya@codeaurora.org>
Return-Path: <okaya@codeaurora.org>
Subject: Re: [PATCH 1/2] PCI: save and restore device state during bus reset
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1472770801-30671-1-git-send-email-okaya@codeaurora.org>
 <20160913215315.GJ4138@localhost>
 <46a47bf2-ab39-0ee2-0faf-2f4050f2a89d@codeaurora.org>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org, cov@codeaurora.org,
 alex.williamson@redhat.com, vikrams@codeaurora.org,
 linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <f01a23c1-3540-02b7-25e6-fc0537195111@codeaurora.org>
Date: Tue, 13 Sep 2016 19:31:18 -0400
MIME-Version: 1.0
In-Reply-To: <46a47bf2-ab39-0ee2-0faf-2f4050f2a89d@codeaurora.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

On 9/13/2016 7:20 PM, Sinan Kaya wrote:
> On 9/13/2016 5:53 PM, Bjorn Helgaas wrote:
>>> +	pci_bus_restore(dev->bus);
>> This path eventually writes the Bridge Control register:
>>
>>   pci_reset_bridge_secondary_bus
>>     pcibios_reset_secondary_bus
>>       pci_reset_secondary_bus
>>         pci_write_config_word(dev, PCI_BRIDGE_CONTROL, ctrl)
>>
>> But I think it'd be easy to call this on a non-bridge device, and I
>> don't think there's anything in the path that checks whether this is
>> actually a bridge.  I wonder if we should check that somewhere, or
>> maybe even change the interface so it takes a struct pci_bus instead
>> of a pci_dev.
>>
> 
> I'll change it to pci_bus.
> 
>>>> +}
> 
> 

Changing the API seems to become a bigger mess. pcibios_reset_secondary_bus has
weaker friends in different architectures.

I can move the check in pci_parent_bus_reset 

         if (pci_is_root_bus(dev->bus) || dev->subordinate ||
             !dev->bus->self || dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET)
                 return -ENOTTY;

inside pci_reset_bridge_secondary_bus instead.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
