Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] PCI: dwc: fix crash seen due to missing ops
To: Joao Pinto <Joao.Pinto@synopsys.com>, <bhelgaas@google.com>,
        <jingoohan1@gmail.com>, <kishon@ti.com>
References: <20170321144354.15452-1-niklass@axis.com>
 <ffb1d92b-a637-2ed9-51d3-6b9fbb790635@synopsys.com>
CC: <linux-arm-kernel@axis.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From: Niklas Cassel <niklas.cassel@axis.com>
Message-ID: <744bf393-4fd8-5e64-423f-f9a033d61106@axis.com>
Date: Thu, 23 Mar 2017 08:40:25 +0100
MIME-Version: 1.0
In-Reply-To: <ffb1d92b-a637-2ed9-51d3-6b9fbb790635@synopsys.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/22/2017 04:47 PM, Joao Pinto wrote:
> Hi Niklas,
>
> Às 2:43 PM de 3/21/2017, Niklas Cassel escreveu:
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
>>
> In the case of pcie-designware-plat you have the declaration of pci->ops:
> https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/tree/drivers/pci/dwc/pcie-designware-plat.c#n78
>
> and in artpec6 in here:
> https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/tree/drivers/pci/dwc/pcie-artpec6.c#n226
>
> Both declarations are made previously of calling dw_pcie_host_init(), so why do
> you need this dummy ops in the probe function? I never had that necessity.

Hello Joao

Since commit 442ec4c04d12, we now have two different ops,
dw_pcie_ops (ops for dw_pcie) and dw_pcie_host_ops (ops for a pcie_port),
note that they are different. The dw_pcie_ops is missing for pcie-artpec6
and pcie-designware-plat (since we are using the generic link-up function).

Before commit 442ec4c04d12, dw_pcie_writel_dbi had dw_pcie_host_ops as
parameter, after the commit it has dw_pcie_ops as parameter.
It should crash on pcie-designware-plat as well, since there are other
functions, like dw_pcie_link_up, that assumes that pci->ops != null.

Another alternative to adding the dummy ops would be to add null checks
for all uses off pci->ops in pcie-designware.c.
I don't like the idea to sprinkle null checks everywhere pci->ops is used.

One could add a null check in dw_pcie_host_init, but without a dummy ops
we would still fail this check, so our drivers would still be non-functional
in Linus's tree.
