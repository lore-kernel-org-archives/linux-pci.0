Return-Path: <okaya@codeaurora.org>
Return-Path: <okaya@codeaurora.org>
Subject: Re: PCI CRS Support
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Bjorn Helgaas <helgaas@kernel.org>
References: <f114c582-8e55-ee1a-a72d-864483077fd0@codeaurora.org>
 <20160824191007.GD23914@localhost>
 <046ebcb0-cb0d-65a5-d7f4-2805fe99199e@codeaurora.org>
 <20160825084441.GA9025@red-moon>
Cc: Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Vikram Sethi <vikrams@codeaurora.org>,
 alex.williamson@redhat.com
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <53c02b52-648d-d64b-a348-b27873e32ab3@codeaurora.org>
Date: Sun, 28 Aug 2016 13:57:00 -0400
MIME-Version: 1.0
In-Reply-To: <20160825084441.GA9025@red-moon>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn, Lorenzo;

On 8/25/2016 4:44 AM, Lorenzo Pieralisi wrote:
> Hi Sinan,
> 
> [+Alex]
> 
> On Wed, Aug 24, 2016 at 03:28:51PM -0400, Sinan Kaya wrote:
>> On 8/24/2016 3:10 PM, Bjorn Helgaas wrote:
>>>> Where do we go from here? I was thinking of putting something deep down into the reset secondary
>>>>> bus function but I'm afraid it will break things especially when we wait up to 60 seconds.
>>> I agree CRS handling after reset is probably all broken.
>>>
>>> I hate the fact that we reset devices without re-enumerating them.  We
>>> have no assurance that the device is the same after reset (it could
>>> have loaded new firmware and been completely reconfigured).
>>>
>>> I don't have any good suggestions for you, so if you have some ideas
>>> and want to fix it, please go ahead.
>>
>> I think I'll make a list of paths that reach to secondary bus reset
>> function and try to keep CRS loop as close as possible to the caller. 
>>
>> I'll focus on FLR later. I won't be heart-broken if somebody took a
>> stab at the FLR.
> 
> Side note, taking advantage of this query: I hope this is a problem
> solved by end of October, if it is not I would suggest adding a track to
> tackle it at LPC16 PCI uconf, I added Alex since I know he is interested
> in the topic too, it makes sense to debate a solution with all
> interested people in one room.
> 

Let's see where this goes.

Here is a list of all the callers I found. Based on what I see, the code
assumes that registers are accessible immediately after pci_reset_bridge_secondary_bus
call.

pci_reset_bridge_secondary_bus also sleeps for 1 seconds. We can maybe assume
that it is OK to sleep additional potential 60 seconds. 

How do you feel about running CRS against all immediate children
of this bridge in pci_reset_secondary_bus function by calling pci_bus_read_dev_vendor_id
for every single child?

Something like:

+ u32 l;

+ list_for_each_entry(dev, &bus->devices, bus_list)
+ 	pci_bus_read_dev_vendor_id(bus, dev->devfn, &l, 60*1000);



trigger_sbr (infiniband/hw/hfi1/pcie.c)
	pci_reset_bridge_secondary_bus (export)
		pcibios_reset_secondary_bus	 (weak)
			pci_reset_secondary_bus

__pci_reset_function
	pci_dev_reset
		__pci_dev_reset
			pci_dev_reset_slot_function
				pci_reset_hotplug_slot
					reset_slot (drivers/pci/hotplug/pciehp_core.c)
						pciehp_reset_slot (drivers/pci/hotplug/pciehp_hpc.c)
							pci_reset_bridge_secondary_bus (export)
								pcibios_reset_secondary_bus	 (weak)
									pci_reset_secondary_bus

							pcie_capability_write_word


			pci_parent_bus_reset
				pci_reset_bridge_secondary_bus
					pcibios_reset_secondary_bus	 (weak)
						pci_reset_secondary_bus

pci_try_reset_function
	__pci_dev_reset
	pci_dev_restore

pcistub_put_pci_dev
	__pci_reset_function_locked
		__pci_dev_reset
	pci_restore_state

pcistub_init_device
	__pci_reset_function_locked
		__pci_dev_reset
	pci_restore_state

handle_error_source
	do_recovery
		reset_link (drivers/pci/pcie/aer/aerdrv_core.c)
			default_reset_link
				pci_reset_bridge_secondary_bus (export)
					pcibios_reset_secondary_bus	 (weak)
						pci_reset_secondary_bus


			driver->reset_link
				aer_root_reset
					pci_reset_bridge_secondary_bus (export)
						pcibios_reset_secondary_bus	 (weak)
							pci_reset_secondary_bus
					pci_read_config_dword

vfio_pci_ioctl (VFIO_DEVICE_PCI_HOT_RESET)
	pci_try_reset_bus
		pci_reset_bridge_secondary_bus
			pcibios_reset_secondary_bus	 (weak)
				pci_reset_secondary_bus

vfio_pci_disable
	vfio_pci_try_bus_reset
		pci_try_reset_bus
			pci_reset_bridge_secondary_bus
				pcibios_reset_secondary_bus	 (weak)
					pci_reset_secondary_bus

	pci_probe_reset_bus (probe =1)
		pci_bus_reset
			pci_reset_bridge_secondary_bus
				pcibios_reset_secondary_bus	 (weak)
					pci_reset_secondary_bus

vfio_pci_ioctl ( VFIO_DEVICE_GET_PCI_HOT_RESET_INFO)
	pci_probe_reset_bus (probe =1)
		pci_bus_reset
			pci_reset_bridge_secondary_bus
				pcibios_reset_secondary_bus	 (weak)
					pci_reset_secondary_bus

pci_reset_bus (no caller)
	pci_probe_reset_bus (probe =1)
		pci_bus_reset
			pci_reset_bridge_secondary_bus
				pcibios_reset_secondary_bus	 (weak)
					pci_reset_secondary_bus




-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
