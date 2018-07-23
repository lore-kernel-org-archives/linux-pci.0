Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v5] PCI: Check for PCIe downtraining conditions
To: Jakub Kicinski <jakub.kicinski@netronome.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "keith.busch@intel.com" <keith.busch@intel.com>,
        "alex_gagniuc@dellteam.com" <alex_gagniuc@dellteam.com>,
        "austin_bolen@dell.com" <austin_bolen@dell.com>,
        "shyam_iyer@dell.com" <shyam_iyer@dell.com>,
        "jeffrey.t.kirsher@intel.com" <jeffrey.t.kirsher@intel.com>,
        "ariel.elior@cavium.com" <ariel.elior@cavium.com>,
        "michael.chan@broadcom.com" <michael.chan@broadcom.com>,
        "ganeshgr@chelsio.com" <ganeshgr@chelsio.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
        "mike.marciniszyn@intel.com" <mike.marciniszyn@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20180718215359.GG128988@bhelgaas-glaptop.roam.corp.google.com>
 <20180723200339.23943-1-mr.nuke.me@gmail.com>
 <20180723140143.1a46902f@cakuba.netronome.com>
From: Tal Gilboa <talgi@mellanox.com>
Message-ID: <b9a6b3b8-56cf-8bb5-2568-071ccd8a4f28@mellanox.com>
Date: Tue, 24 Jul 2018 00:52:22 +0300
MIME-Version: 1.0
In-Reply-To: <20180723140143.1a46902f@cakuba.netronome.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 7/24/2018 12:01 AM, Jakub Kicinski wrote:
> On Mon, 23 Jul 2018 15:03:38 -0500, Alexandru Gagniuc wrote:
>> PCIe downtraining happens when both the device and PCIe port are
>> capable of a larger bus width or higher speed than negotiated.
>> Downtraining might be indicative of other problems in the system, and
>> identifying this from userspace is neither intuitive, nor
>> straightforward.
>>
>> The easiest way to detect this is with pcie_print_link_status(),
>> since the bottleneck is usually the link that is downtrained. It's not
>> a perfect solution, but it works extremely well in most cases.
>>
>> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
>> ---
>>
>> For the sake of review, I've created a __pcie_print_link_status() which
>> takes a 'verbose' argument. If we agree want to go this route, and update
>> the users of pcie_print_link_status(), I can split this up in two patches.
>> I prefer just printing this information in the core functions, and letting
>> drivers not have to worry about this. Though there seems to be strong for
>> not going that route, so here it goes:
> 
> FWIW the networking drivers print PCIe BW because sometimes the network
> bandwidth is simply over-provisioned on multi port cards, e.g. 80Gbps
> card on a x8 link.
> 
> Sorry to bike shed, but currently the networking cards print the info
> during probe.  Would it make sense to move your message closer to probe
> time?  Rather than when device is added.  If driver structure is
> available, we could also consider adding a boolean to struct pci_driver
> to indicate if driver wants the verbose message?  This way we avoid
> duplicated prints.
> 
> I have no objection to current patch, it LGTM.  Just a thought.

I don't see the reason for having two functions. What's the problem with 
adding the verbose argument to the original function?

> 
>>   drivers/pci/pci.c   | 22 ++++++++++++++++++----
>>   drivers/pci/probe.c | 21 +++++++++++++++++++++
>>   include/linux/pci.h |  1 +
>>   3 files changed, 40 insertions(+), 4 deletions(-) >>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 316496e99da9..414ad7b3abdb 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -5302,14 +5302,15 @@ u32 pcie_bandwidth_capable(struct pci_dev *dev, enum pci_bus_speed *speed,
>>   }
>>   
>>   /**
>> - * pcie_print_link_status - Report the PCI device's link speed and width
>> + * __pcie_print_link_status - Report the PCI device's link speed and width
>>    * @dev: PCI device to query
>> + * @verbose: Be verbose -- print info even when enough bandwidth is available.
>>    *
>>    * Report the available bandwidth at the device.  If this is less than the
>>    * device is capable of, report the device's maximum possible bandwidth and
>>    * the upstream link that limits its performance to less than that.
>>    */
>> -void pcie_print_link_status(struct pci_dev *dev)
>> +void __pcie_print_link_status(struct pci_dev *dev, bool verbose)
>>   {
>>   	enum pcie_link_width width, width_cap;
>>   	enum pci_bus_speed speed, speed_cap;
>> @@ -5319,11 +5320,11 @@ void pcie_print_link_status(struct pci_dev *dev)
>>   	bw_cap = pcie_bandwidth_capable(dev, &speed_cap, &width_cap);
>>   	bw_avail = pcie_bandwidth_available(dev, &limiting_dev, &speed, &width);
>>   
>> -	if (bw_avail >= bw_cap)
>> +	if (bw_avail >= bw_cap && verbose)
>>   		pci_info(dev, "%u.%03u Gb/s available PCIe bandwidth (%s x%d link)\n",
>>   			 bw_cap / 1000, bw_cap % 1000,
>>   			 PCIE_SPEED2STR(speed_cap), width_cap);
>> -	else
>> +	else if (bw_avail < bw_cap)
>>   		pci_info(dev, "%u.%03u Gb/s available PCIe bandwidth, limited by %s x%d link at %s (capable of %u.%03u Gb/s with %s x%d link)\n",
>>   			 bw_avail / 1000, bw_avail % 1000,
>>   			 PCIE_SPEED2STR(speed), width,
>> @@ -5331,6 +5332,19 @@ void pcie_print_link_status(struct pci_dev *dev)
>>   			 bw_cap / 1000, bw_cap % 1000,
>>   			 PCIE_SPEED2STR(speed_cap), width_cap);
>>   }
>> +
>> +/**
>> + * pcie_print_link_status - Report the PCI device's link speed and width
>> + * @dev: PCI device to query
>> + *
>> + * Report the available bandwidth at the device.  If this is less than the
>> + * device is capable of, report the device's maximum possible bandwidth and
>> + * the upstream link that limits its performance to less than that.
>> + */
>> +void pcie_print_link_status(struct pci_dev *dev)
>> +{
>> +	__pcie_print_link_status(dev, true);
>> +}
>>   EXPORT_SYMBOL(pcie_print_link_status);
>>   
>>   /**
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index ac876e32de4b..1f7336377c3b 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -2205,6 +2205,24 @@ static struct pci_dev *pci_scan_device(struct pci_bus *bus, int devfn)
>>   	return dev;
>>   }
>>   
>> +static void pcie_check_upstream_link(struct pci_dev *dev)
>> +{
>> +	if (!pci_is_pcie(dev))
>> +		return;
>> +
>> +	/* Look from the device up to avoid downstream ports with no devices. */
>> +	if ((pci_pcie_type(dev) != PCI_EXP_TYPE_ENDPOINT) &&
>> +	    (pci_pcie_type(dev) != PCI_EXP_TYPE_LEG_END) &&
>> +	    (pci_pcie_type(dev) != PCI_EXP_TYPE_UPSTREAM))
>> +		return;
>> +
>> +	/* Multi-function PCIe share the same link/status. */
>> +	if (PCI_FUNC(dev->devfn) != 0 || dev->is_virtfn)
>> +		return;
>> +
>> +	__pcie_print_link_status(dev, false);
>> +}
>> +
>>   static void pci_init_capabilities(struct pci_dev *dev)
>>   {
>>   	/* Enhanced Allocation */
>> @@ -2240,6 +2258,9 @@ static void pci_init_capabilities(struct pci_dev *dev)
>>   	/* Advanced Error Reporting */
>>   	pci_aer_init(dev);
>>   
>> +	/* Check link and detect downtrain errors */
>> +	pcie_check_upstream_link(dev);

This is called for every PCIe device right? Won't there be a duplicated 
print in case a device loads with lower PCIe bandwidth than needed?

>> +
>>   	if (pci_probe_reset_function(dev) == 0)
>>   		dev->reset_fn = 1;
>>   }
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index abd5d5e17aee..15bfab8f7a1b 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -1088,6 +1088,7 @@ int pcie_set_mps(struct pci_dev *dev, int mps);
>>   u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
>>   			     enum pci_bus_speed *speed,
>>   			     enum pcie_link_width *width);
>> +void __pcie_print_link_status(struct pci_dev *dev, bool verbose);
>>   void pcie_print_link_status(struct pci_dev *dev);
>>   int pcie_flr(struct pci_dev *dev);
>>   int __pci_reset_function_locked(struct pci_dev *dev);
> 
