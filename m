Return-Path: <SRS0=HTKF=DE=nvidia.com=mmaddireddy@kernel.org>
Return-Path: <SRS0=HTKF=DE=nvidia.com=mmaddireddy@kernel.org>
Subject: Re: [PATCH V3 2/7] PCI: Export pci_find_host_bridge()
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <cyndis@kapsi.fi>, <thierry.reding@gmail.com>, <bhelgaas@google.com>,
	<lorenzo.pieralisi@arm.com>, <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
	<frowand.list@gmail.com>, <rjw@rjwysocki.net>, <tglx@linutronix.de>,
	<vidyas@nvidia.com>, <kthota@nvidia.com>, <linux-tegra@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-pm@vger.kernel.org>
References: <1512120007-28088-1-git-send-email-mmaddireddy@nvidia.com>
 <1512120007-28088-3-git-send-email-mmaddireddy@nvidia.com>
 <20171205200402.GF23510@bhelgaas-glaptop.roam.corp.google.com>
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Message-ID: <aebabb88-d894-2b1f-d3e8-63a2acad9665@nvidia.com>
Date: Fri, 8 Dec 2017 14:07:54 +0530
MIME-Version: 1.0
In-Reply-To: <20171205200402.GF23510@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-pci.vger.kernel.org>



On 06-Dec-17 1:34 AM, Bjorn Helgaas wrote:
> On Fri, Dec 01, 2017 at 02:50:02PM +0530, Manikanta Maddireddy wrote:
>> PCI subsystem pass pci_bus pointer to pci_ops callback functions, Tegra
> 
> s/PCI subsystem pass/The PCI subsystem passes a/
> s/, Tegra/.  The Tegra/
> 
>> host driver use pci_find_host_bridge() to get pci_host_bridge from pci_bus.
> 
> s/use/uses/
> 
>> Export pci_find_host_bridge() to allow Tegra PCIe driver to be compiled as
>> loadable kernel module.
> 
> s/allow Tegra/allow the Tegra/
> s/loadable/a loadable/
> 
> But why do you need pci_find_host_bridge() at all?  Most drivers use
> the pci_bus.sysdata pointer for this purpose, e.g., see db271747a04d
> ("PCI: mediatek: Use bus->sysdata to get host private data")
> 

I will send a patch to use bus->sysdata instead of pci_find_host_bridge().

>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>> ---
>> V2:
>> * commit message update
>> V3:
>> * EXPORT_SYMBOL is changed to EXPORT_SYMBOL_GPL
>>
>>  drivers/pci/host-bridge.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/pci/host-bridge.c b/drivers/pci/host-bridge.c
>> index add66236215c..b8c0fcde9bd7 100644
>> --- a/drivers/pci/host-bridge.c
>> +++ b/drivers/pci/host-bridge.c
>> @@ -22,6 +22,7 @@ struct pci_host_bridge *pci_find_host_bridge(struct pci_bus *bus)
>>  
>>  	return to_pci_host_bridge(root_bus->bridge);
>>  }
>> +EXPORT_SYMBOL_GPL(pci_find_host_bridge);
>>  
>>  struct device *pci_get_host_bridge_device(struct pci_dev *dev)
>>  {
>> -- 
>> 2.1.4
>>
