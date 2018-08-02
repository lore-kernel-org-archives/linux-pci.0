Return-Path: <SRS0=CTFa=KR=codeaurora.org=poza@kernel.org>
Return-Path: <SRS0=CTFa=KR=codeaurora.org=poza@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Thu, 02 Aug 2018 11:56:40 +0530
From: poza@codeaurora.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 bhelgaas@google.com, linux-pci-owner@vger.kernel.org
Subject: Re: [PATCH] PCI/AER: Enable SERR# forwarding in non ACPI flow
In-Reply-To: <6a1266c49a5be0d598dd7f1ded94e93d@codeaurora.org>
References: <1531406719-18606-1-git-send-email-bharat.kumar.gogada@xilinx.com>
 <20180731224706.GO45322@bhelgaas-glaptop.roam.corp.google.com>
 <6a1266c49a5be0d598dd7f1ded94e93d@codeaurora.org>
Message-ID: <ebb558d7b4c273ad6bf18b5d9266c821@codeaurora.org>
List-ID: <linux-pci.vger.kernel.org>

On 2018-08-02 11:53, poza@codeaurora.org wrote:
> On 2018-08-01 04:17, Bjorn Helgaas wrote:
>> On Thu, Jul 12, 2018 at 08:15:19PM +0530, Bharat Kumar Gogada wrote:
>>> Currently PCI_BRIDGE_CTL_SERR is being enabled only in
>>> ACPI flow.
>>> This bit is required for forwarding errors reported
>>> by EP devices to upstream device.
>>> This patch enables SERR# for Type-1 PCI device.
>> 
>> This does seem broken.
>> 
>> Figure 6-3 in PCIe r4.0, sec 6.2.6, would be a helpful reference to
>> include in the commit log.
>> 
>> Semi-related question: there are about 40 drivers that call
>> pci_enable_pcie_error_reporting() and
>> pci_disable_pcie_error_reporting().  I see that the PCI core
>> calls pci_enable_pcie_error_reporting() for Root Ports and Switch
>> Ports in this path:
>> 
>>   aer_probe                     # for root ports only
>>     aer_enable_rootport
>>       set_downstream_devices_error_reporting
>>         set_device_error_reporting
>>           if (ROOT_PORT || UPSTREAM || DOWNSTREAM)
>>             pci_enable_pcie_error_reporting
>>         pci_walk_bus(..., set_device_error_reporting)
>> 
>> But the core doesn't call pci_enable_pcie_error_reporting() for
>> endpoints.  I wonder why not.  Could we?  And then remove the calls
>> from those drivers?  If PCI_EXP_AER_FLAGS should only be set if the
>> driver is prepared, the pci_driver.err_handler would be a good hint.
>> But I suspect we could do something sensible and at least report
>> errors even if the driver doesn't have err_handler callbacks.
>> 
> 
> what about hot-plug case ?
> should not aer_init() call pci_enable_pcie_error_reporting() for all
> the downstream pci_dev ?
> and remove all the calls from drivers..
> 

aer_init will be called for each device (pci_dev) while pciehp does 
re-enumeration.
so probable we might want to call pci_enable_pcie_error_reporting()
but that dictates the design where AER framework is taking decision to 
enable error reporting on behalf of drivers as well.
but thats fine I think, if drivers do not want to participate then they 
have to call  pci_disable_pcie_error_reporting explicitly.
does this make sense ?

>> On MIPS Octeon, it looks like pcibios_plat_dev_init() does already set
>> PCI_EXP_AER_FLAGS for every device.
>> 
>> But this question is obviously far beyond the scope of this current
>> patch.
>> 
>>> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
>>> ---
>>>  drivers/pci/pcie/aer.c |   23 +++++++++++++++++++++++
>>>  1 files changed, 23 insertions(+), 0 deletions(-)
>>> 
>>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>>> index a2e8838..943e084 100644
>>> --- a/drivers/pci/pcie/aer.c
>>> +++ b/drivers/pci/pcie/aer.c
>>> @@ -343,6 +343,19 @@ int pci_enable_pcie_error_reporting(struct 
>>> pci_dev *dev)
>>>  	if (!dev->aer_cap)
>>>  		return -EIO;
>>> 
>>> +	if (!IS_ENABLED(CONFIG_ACPI) &&
>>> +	    dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
>> 
>> I think this test needs to be refined a little bit.  If the kernel
>> happens to be built with CONFIG_ACPI=y but the current platform
>> doesn't support ACPI, we still want to set PCI_BRIDGE_CTL_SERR,
>> don't we?
>> 
>>> +		u16 control;
>>> +
>>> +		/*
>>> +		 * A Type-1 PCI bridge will not forward ERR_ messages coming
>>> +		 * from an endpoint if SERR# forwarding is not enabled.
>>> +		 */
>>> +		pci_read_config_word(dev, PCI_BRIDGE_CONTROL, &control);
>>> +		control |= PCI_BRIDGE_CTL_SERR;
>>> +		pci_write_config_word(dev, PCI_BRIDGE_CONTROL, control);
>>> +	}
>>> +
>>>  	return pcie_capability_set_word(dev, PCI_EXP_DEVCTL, 
>>> PCI_EXP_AER_FLAGS);
>>>  }
>>>  EXPORT_SYMBOL_GPL(pci_enable_pcie_error_reporting);
>>> @@ -352,6 +365,16 @@ int pci_disable_pcie_error_reporting(struct 
>>> pci_dev *dev)
>>>  	if (pcie_aer_get_firmware_first(dev))
>>>  		return -EIO;
>>> 
>>> +	if (!IS_ENABLED(CONFIG_ACPI) &&
>>> +	    dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
>>> +		u16 control;
>>> +
>>> +		/* Clear SERR Forwarding */
>>> +		pci_read_config_word(dev, PCI_BRIDGE_CONTROL, &control);
>>> +		control &= ~PCI_BRIDGE_CTL_SERR;
>>> +		pci_write_config_word(dev, PCI_BRIDGE_CONTROL, control);
>>> +	}
>>> +
>>>  	return pcie_capability_clear_word(dev, PCI_EXP_DEVCTL,
>>>  					  PCI_EXP_AER_FLAGS);
>>>  }
>>> --
>>> 1.7.1
>>> 
