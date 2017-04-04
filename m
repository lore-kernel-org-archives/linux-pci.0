Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:55394 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750926AbdDDHy3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Apr 2017 03:54:29 -0400
Subject: Re: [PATCH] PCI: dwc: fix crash seen due to missing ops
To: Bjorn Helgaas <helgaas@kernel.org>
References: <20170321144354.15452-1-niklass@axis.com>
 <20170403231525.GF13232@bhelgaas-glaptop.roam.corp.google.com>
CC: <bhelgaas@google.com>, <jingoohan1@gmail.com>,
        <Joao.Pinto@synopsys.com>, <kishon@ti.com>,
        <linux-arm-kernel@axis.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From: Niklas Cassel <niklas.cassel@axis.com>
Message-ID: <5f1e5394-26fc-b533-b78c-89e409e9e1cf@axis.com>
Date: Tue, 4 Apr 2017 09:54:25 +0200
MIME-Version: 1.0
In-Reply-To: <20170403231525.GF13232@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04/04/2017 01:15 AM, Bjorn Helgaas wrote:
> On Tue, Mar 21, 2017 at 03:43:54PM +0100, Niklas Cassel wrote:
>> From: Niklas Cassel <niklas.cassel@axis.com>
>>
>> Fix the following crash, seen in dwc/pcie-artpec6.
>>
>>   Unable to handle kernel NULL pointer dereference at virtual address 00000004
>>   pgd = c0204000
>>   [00000004] *pgd=00000000
>>   Internal error: Oops: 5 [#1] SMP ARM
>>   Modules linked in:
>>   CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.11.0-rc3-next-20170321 #1
>>   Hardware name: Axis ARTPEC-6 Platform
>>   task: db098000 task.stack: db096000
>>   PC is at dw_pcie_writel_dbi+0x2c/0xd0
>>   ...
>>
>> While at it, fix the same problem for pcie-designware-plat.
>>
>> Fixes: 442ec4c04d12 ("PCI: dwc: all: Split struct pcie_port into host-only and core structures")
>> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
> 
> For artpec6, I think this has already been fixed by Kishon's "PCI: dwc:
> artpec6: Populate cpu_addr_fixup ops".

Agreed.

> 
> Since both the artpec6 and designware-plat issues were introduced by
> 442ec4c04d12, which we merged in the v4.11 merge window, I moved Kishon's
> fix and the designware-plat part of this patch to for-linus for v4.11.

I didn't think that including "PCI: dwc: designware: Add new *ops* for
CPU addr fixup" was an option, but doing so is a cleaner solution imo.

> 
> Please double-check my for-linus branch to make sure it has what we need.

The branch looks good. I did test it, and it works marvelously.

> 
>> ---
>>  drivers/pci/dwc/pcie-artpec6.c         | 4 ++++
>>  drivers/pci/dwc/pcie-designware-plat.c | 4 ++++
>>  2 files changed, 8 insertions(+)
>>
>> diff --git a/drivers/pci/dwc/pcie-artpec6.c b/drivers/pci/dwc/pcie-artpec6.c
>> index fcd3ef845883..6d23683c0892 100644
>> --- a/drivers/pci/dwc/pcie-artpec6.c
>> +++ b/drivers/pci/dwc/pcie-artpec6.c
>> @@ -234,6 +234,9 @@ static int artpec6_add_pcie_port(struct artpec6_pcie *artpec6_pcie,
>>  	return 0;
>>  }
>>  
>> +static const struct dw_pcie_ops dw_pcie_ops = {
>> +};
>> +
>>  static int artpec6_pcie_probe(struct platform_device *pdev)
>>  {
>>  	struct device *dev = &pdev->dev;
>> @@ -252,6 +255,7 @@ static int artpec6_pcie_probe(struct platform_device *pdev)
>>  		return -ENOMEM;
>>  
>>  	pci->dev = dev;
>> +	pci->ops = &dw_pcie_ops;
>>  
>>  	artpec6_pcie->pci = pci;
>>  
>> diff --git a/drivers/pci/dwc/pcie-designware-plat.c b/drivers/pci/dwc/pcie-designware-plat.c
>> index b6c832ba39dd..f20d494922ab 100644
>> --- a/drivers/pci/dwc/pcie-designware-plat.c
>> +++ b/drivers/pci/dwc/pcie-designware-plat.c
>> @@ -86,6 +86,9 @@ static int dw_plat_add_pcie_port(struct pcie_port *pp,
>>  	return 0;
>>  }
>>  
>> +static const struct dw_pcie_ops dw_pcie_ops = {
>> +};
>> +
>>  static int dw_plat_pcie_probe(struct platform_device *pdev)
>>  {
>>  	struct device *dev = &pdev->dev;
>> @@ -103,6 +106,7 @@ static int dw_plat_pcie_probe(struct platform_device *pdev)
>>  		return -ENOMEM;
>>  
>>  	pci->dev = dev;
>> +	pci->ops = &dw_pcie_ops;
>>  
>>  	dw_plat_pcie->pci = pci;
>>  
>> -- 
>> 2.11.0
>>
