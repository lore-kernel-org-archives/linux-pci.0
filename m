Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:49860 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751763AbaAGIyR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 7 Jan 2014 03:54:17 -0500
Message-ID: <52CBC0B6.1090904@linux.intel.com>
Date: Tue, 07 Jan 2014 16:54:14 +0800
From: Jiang Liu <jiang.liu@linux.intel.com>
MIME-Version: 1.0
To: Yijing Wang <wangyijing@huawei.com>,
	Dongsheng Wang <dongsheng.wang@freescale.com>,
	bhelgaas@google.com, rjw@rjwysocki.net
CC: scottwood@freescale.com, galak@codeaurora.org,
	roy.zang@freescale.com, linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/2] pci: Fix root port bus->self is NULL
References: <1389081848-26506-1-git-send-email-dongsheng.wang@freescale.com> <52CBBA86.7020401@huawei.com>
In-Reply-To: <52CBBA86.7020401@huawei.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 2014/1/7 16:27, Yijing Wang wrote:
> On 2014/1/7 16:04, Dongsheng Wang wrote:
>> From: Wang Dongsheng <dongsheng.wang@freescale.com>
>>
>> the root port bus->self always NULL, so put root port pci device
>> into root port bus->self.
>>
>> Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
>>
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index 38e403d..7f2d1ab 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -1472,6 +1472,9 @@ int pci_scan_slot(struct pci_bus *bus, int devfn)
>>  	if (!dev->is_added)
>>  		nr++;
>>  
>> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
>> +		bus->self = dev;
> 
> In this case, bus is the pci root bus I think, so why set bus->self = root port ?
> "bus->self" should pointer to the pci device that bridge out this bus.
Yes, this patch seems wrong. If dev is root port, bus should be root
bus, so we shouldn't set root_bus->self = pci_dev_of_root_port.

Actually PCI core has correctly setup pci_bus->self for secondary bus
of PCIe root port.

Thanks!
Gerry

> 
>> +
>>  	for (fn = next_fn(bus, dev, 0); fn > 0; fn = next_fn(bus, dev, fn)) {
>>  		dev = pci_scan_single_device(bus, devfn + fn);
>>  		if (dev) {
>>
> 
> 
