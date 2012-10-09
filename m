Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:23122 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751893Ab2JIDbD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 8 Oct 2012 23:31:03 -0400
Message-ID: <50739A4D.20200@huawei.com>
Date: Tue, 9 Oct 2012 11:30:21 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Jiang Liu <jiang.liu@huawei.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Hanjun Guo <guohanjun@huawei.com>, <linux-pci@vger.kernel.org>,
	Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH] PCI: add pcie max_payload_size debug info
References: <1349751771-9512-1-git-send-email-wangyijing@huawei.com> <507395D3.7010101@huawei.com>
In-Reply-To: <507395D3.7010101@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2012/10/9 11:11, Jiang Liu wrote:
> Why not update MPS setting when hot-adding a PCI device?

I'm not sure whether different mps setting will certainly result the same problem.
Do we need to set all pci devices mps same size in the same path for safe?
Or leave this to boot option "pcie_bus_safe"?

Thanks!
Yijing

> On 2012-10-9 11:02, Yijing Wang wrote:
>> PCIe device mps maybe not equal to its bridge mps after doing pci hotplug.
>> This may result unexpected problem like
>> http://marc.info/?l=linux-scsi&m=134788365823217&w=2. So add mps log for current
>> mps setting to help diagnosis an issue like this.
>>
>> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
>> ---
>>  drivers/pci/probe.c |   38 ++++++++++++++++++++++++++++++++++++++
>>  1 files changed, 38 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index ec909af..ff1f98d 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -1533,6 +1533,42 @@ static void pcie_write_mrrs(struct pci_dev *dev)
>>  			"with pci=pcie_bus_safe.\n");
>>  }
>>  
>> +static void pcie_dump_bus_mps(struct pci_bus *bus);
>> +
>> +static void pcie_dump_dev_mps(struct pci_dev *dev)
>> +{
>> +	int mps, mpss;
>> +
>> +	if (!pci_is_pcie(dev))
>> +		return;
>> +
>> +	if (dev->subordinate)
>> +		pcie_dump_bus_mps(dev->subordinate);
>> +	else {
>> +		mps = pcie_get_mps(dev);
>> +		mpss = 128 << dev->pcie_mpss;
>> +		dev_printk(KERN_DEBUG, &dev->dev, "PCI-E Max_Payload_Size Supported %d, "
>> +			"Max_Payload_Size %d\n", mpss, mps);
>> +	}
>> +}
>> +
>> +static void pcie_dump_bus_mps(struct pci_bus *bus)
>> +{
>> +	int mps, mpss;
>> +	struct pci_dev *dev;
>> +
>> +	if (!bus->self || !pci_is_pcie(bus->self))
>> +		return;
>> +
>> +	mps = pcie_get_mps(bus->self);
>> +	mpss = 128 << bus->self->pcie_mpss;
>> +	dev_printk(KERN_DEBUG, &bus->self->dev, "PCI-E Max_Payload_Size Supported %d, "
>> +		"Max_Payload_Size %d\n", mpss, mps);
>> +
>> +	list_for_each_entry(dev, &bus->devices, bus_list)
>> +		pcie_dump_dev_mps(dev);
>> +}
>> +
>>  static int pcie_bus_configure_set(struct pci_dev *dev, void *data)
>>  {
>>  	int mps, orig_mps;
>> @@ -1564,6 +1600,8 @@ void pcie_bus_configure_settings(struct pci_bus *bus, u8 mpss)
>>  	if (!pci_is_pcie(bus->self))
>>  		return;
>>  
>> +	pcie_dump_bus_mps(bus);
>> +
>>  	if (pcie_bus_config == PCIE_BUS_TUNE_OFF)
>>  		return;
>>  
> 
> 
> 
> .
> 


-- 
Thanks!
Yijing

