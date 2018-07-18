Return-Path: <SRS0=lf7U=KC=mellanox.com=talgi@kernel.org>
Return-Path: <SRS0=lf7U=KC=mellanox.com=talgi@kernel.org>
Subject: Re: [PATCH v3] PCI: Check for PCIe downtraining conditions
To: Bjorn Helgaas <helgaas@kernel.org>,
 Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc: bhelgaas@google.com, alex_gagniuc@dellteam.com, austin_bolen@dell.com,
 shyam_iyer@dell.com, keith.busch@intel.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
 Ariel Elior <ariel.elior@cavium.com>,
 Michael Chan <michael.chan@broadcom.com>,
 Ganesh Goudar <ganeshgr@chelsio.com>, Tariq Toukan <tariqt@mellanox.com>,
 Jakub Kicinski <jakub.kicinski@netronome.com>,
 Dave Airlie <airlied@gmail.com>, Alex Deucher <alexander.deucher@amd.com>
References: <20180604155523.14906-1-mr.nuke.me@gmail.com>
 <20180716211706.GB12391@bhelgaas-glaptop.roam.corp.google.com>
From: Tal Gilboa <talgi@mellanox.com>
Message-ID: <628346bc-b455-05f2-2051-35a807076ea0@mellanox.com>
Date: Wed, 18 Jul 2018 09:38:10 -0400
MIME-Version: 1.0
In-Reply-To: <20180716211706.GB12391@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 7/16/2018 5:17 PM, Bjorn Helgaas wrote:
> [+cc maintainers of drivers that already use pcie_print_link_status()
> and GPU folks]
> 
> On Mon, Jun 04, 2018 at 10:55:21AM -0500, Alexandru Gagniuc wrote:
>> PCIe downtraining happens when both the device and PCIe port are
>> capable of a larger bus width or higher speed than negotiated.
>> Downtraining might be indicative of other problems in the system, and
>> identifying this from userspace is neither intuitive, nor straigh
>> forward.
> 
> s/straigh/straight/
> In this context, I think "straightforward" should be closed up
> (without the space).
> 
>> The easiest way to detect this is with pcie_print_link_status(),
>> since the bottleneck is usually the link that is downtrained. It's not
>> a perfect solution, but it works extremely well in most cases.
> 
> This is an interesting idea.  I have two concerns:
> 
> Some drivers already do this on their own, and we probably don't want
> duplicate output for those devices.  In most cases (ixgbe and mlx* are
> exceptions), the drivers do this unconditionally so we *could* remove
> it from the driver if we add it to the core.  The dmesg order would
> change, and the message wouldn't be associated with the driver as it
> now is.
> 
> Also, I think some of the GPU devices might come up at a lower speed,
> then download firmware, then reset the device so it comes up at a
> higher speed.  I think this patch will make us complain about about
> the low initial speed, which might confuse users.
> 
> So I'm not sure whether it's better to do this in the core for all
> devices, or if we should just add it to the high-performance drivers
> that really care.
> 
>> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
>> ---
>>
>> Changes since v2:
>>   - Check dev->is_virtfn flag
>>
>> Changes since v1:
>>   - Use pcie_print_link_status() instead of reimplementing logic
>>   
>>   drivers/pci/probe.c | 22 ++++++++++++++++++++++
>>   1 file changed, 22 insertions(+)
>>
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index ac91b6fd0bcd..a88ec8c25dd5 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -2146,6 +2146,25 @@ static struct pci_dev *pci_scan_device(struct pci_bus *bus, int devfn)
>>   	return dev;
>>   }
>>   
>> +static void pcie_check_upstream_link(struct pci_dev *dev)
>> +{
>> +
>> +	if (!pci_is_pcie(dev))
>> +		return;
>> +
>> +	/* Look from the device up to avoid downstream ports with no devices. */
>> +	if ((pci_pcie_type(dev) != PCI_EXP_TYPE_ENDPOINT) &&
>> +	    (pci_pcie_type(dev) != PCI_EXP_TYPE_LEG_END) &&
>> +	    (pci_pcie_type(dev) != PCI_EXP_TYPE_UPSTREAM))
>> +		return;
> 
> Do we care about Upstream Ports here?  I suspect that ultimately we
> only care about the bandwidth to Endpoints, and if an Endpoint is
> constrained by a slow link farther up the tree,
> pcie_print_link_status() is supposed to identify that slow link.
> 
> I would find this test easier to read as
> 
>    if (!(type == PCI_EXP_TYPE_ENDPOINT || type == PCI_EXP_TYPE_LEG_END))
>      return;
> 
> But maybe I'm the only one that finds the conjunction of inequalities
> hard to read.  No big deal either way.
> 
>> +	/* Multi-function PCIe share the same link/status. */
>> +	if ((PCI_FUNC(dev->devfn) != 0) || dev->is_virtfn)
>> +		return;
>> +
>> +	pcie_print_link_status(dev);
>> +}

Is this function called by default for every PCIe device? What about 
VFs? We make an exception for them on our driver since a VF doesn't have 
access to the needed information in order to provide a meaningful message.

>> +
>>   static void pci_init_capabilities(struct pci_dev *dev)
>>   {
>>   	/* Enhanced Allocation */
>> @@ -2181,6 +2200,9 @@ static void pci_init_capabilities(struct pci_dev *dev)
>>   	/* Advanced Error Reporting */
>>   	pci_aer_init(dev);
>>   
>> +	/* Check link and detect downtrain errors */
>> +	pcie_check_upstream_link(dev);
>> +
>>   	if (pci_probe_reset_function(dev) == 0)
>>   		dev->reset_fn = 1;
>>   }
>> -- 
>> 2.14.4
>>
