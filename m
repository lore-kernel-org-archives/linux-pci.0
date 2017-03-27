Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:55624 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751124AbdC0Q0x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Mar 2017 12:26:53 -0400
Subject: Re: [PATCH] PCI: dwc: fix crash seen due to missing ops
To: Niklas Cassel <niklas.cassel@axis.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>, <bhelgaas@google.com>,
        <jingoohan1@gmail.com>, <kishon@ti.com>
References: <20170321144354.15452-1-niklass@axis.com>
 <ffb1d92b-a637-2ed9-51d3-6b9fbb790635@synopsys.com>
 <e6cf73c0-f930-c29a-8caa-843320ec5f8a@axis.com>
CC: <linux-arm-kernel@axis.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <375f3e73-f3a0-31b7-b148-0fdb7abd05f0@synopsys.com>
Date: Mon, 27 Mar 2017 17:26:31 +0100
MIME-Version: 1.0
In-Reply-To: <e6cf73c0-f930-c29a-8caa-843320ec5f8a@axis.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Às 7:19 AM de 3/23/2017, Niklas Cassel escreveu:
> On 03/22/2017 04:47 PM, Joao Pinto wrote:
>> Hi Niklas,
>>
>> Às 2:43 PM de 3/21/2017, Niklas Cassel escreveu:
>>> From: Niklas Cassel <niklas.cassel@axis.com>
>>>
>>> Fix the following crash, seen in dwc/pcie-artpec6.
>>>
>>>   Unable to handle kernel NULL pointer dereference at virtual address 00000004
>>>   pgd = c0204000
>>>   [00000004] *pgd=00000000
>>>   Internal error: Oops: 5 [#1] SMP ARM
>>>   Modules linked in:
>>>   CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.11.0-rc3-next-20170321 #1
>>>   Hardware name: Axis ARTPEC-6 Platform
>>>   task: db098000 task.stack: db096000
>>>   PC is at dw_pcie_writel_dbi+0x2c/0xd0
>>>   ...
>>>
>>> While at it, fix the same problem for pcie-designware-plat.
>>>
>>> Fixes: 442ec4c04d12 ("PCI: dwc: all: Split struct pcie_port into host-only and core structures")
>>> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
>>> ---
>>>  drivers/pci/dwc/pcie-artpec6.c         | 4 ++++
>>>  drivers/pci/dwc/pcie-designware-plat.c | 4 ++++
>>>  2 files changed, 8 insertions(+)
>>>
>>> diff --git a/drivers/pci/dwc/pcie-artpec6.c b/drivers/pci/dwc/pcie-artpec6.c
>>> index fcd3ef845883..6d23683c0892 100644
>>> --- a/drivers/pci/dwc/pcie-artpec6.c
>>> +++ b/drivers/pci/dwc/pcie-artpec6.c
>>> @@ -234,6 +234,9 @@ static int artpec6_add_pcie_port(struct artpec6_pcie *artpec6_pcie,
>>>  	return 0;
>>>  }
>>>  
>>> +static const struct dw_pcie_ops dw_pcie_ops = {
>>> +};
>>> +
>>>  static int artpec6_pcie_probe(struct platform_device *pdev)
>>>  {
>>>  	struct device *dev = &pdev->dev;
>>> @@ -252,6 +255,7 @@ static int artpec6_pcie_probe(struct platform_device *pdev)
>>>  		return -ENOMEM;
>>>  
>>>  	pci->dev = dev;
>>> +	pci->ops = &dw_pcie_ops;
>>>  
>>>  	artpec6_pcie->pci = pci;
>>>  
>>> diff --git a/drivers/pci/dwc/pcie-designware-plat.c b/drivers/pci/dwc/pcie-designware-plat.c
>>> index b6c832ba39dd..f20d494922ab 100644
>>> --- a/drivers/pci/dwc/pcie-designware-plat.c
>>> +++ b/drivers/pci/dwc/pcie-designware-plat.c
>>> @@ -86,6 +86,9 @@ static int dw_plat_add_pcie_port(struct pcie_port *pp,
>>>  	return 0;
>>>  }
>>>  
>>> +static const struct dw_pcie_ops dw_pcie_ops = {
>>> +};
>>> +
>>>  static int dw_plat_pcie_probe(struct platform_device *pdev)
>>>  {
>>>  	struct device *dev = &pdev->dev;
>>> @@ -103,6 +106,7 @@ static int dw_plat_pcie_probe(struct platform_device *pdev)
>>>  		return -ENOMEM;
>>>  
>>>  	pci->dev = dev;
>>> +	pci->ops = &dw_pcie_ops;
>>>  
>>>  	dw_plat_pcie->pci = pci;
>>>  
>>>
>> In the case of pcie-designware-plat you have the declaration of pci->ops:
>> https://urldefense.proofpoint.com/v2/url?u=https-3A__git.kernel.org_pub_scm_linux_kernel_git_helgaas_pci.git_tree_drivers_pci_dwc_pcie-2Ddesignware-2Dplat.c-23n78&d=DwID-g&c=DPL6_X_6JkXFx7AXWqB0tg&r=s2fO0hii0OGNOv9qQy_HRXy-xAJUD1NNoEcc3io_kx0&m=28B2KMSJPmdGukxJhVcT-K6O76mP27iVn-XTqDwJ4p0&s=glxSZ800DErbgYPvxr-U26UBSVliExhaYEW-MIYIs7U&e= 
>>
>> and in artpec6 in here:
>> https://urldefense.proofpoint.com/v2/url?u=https-3A__git.kernel.org_pub_scm_linux_kernel_git_helgaas_pci.git_tree_drivers_pci_dwc_pcie-2Dartpec6.c-23n226&d=DwID-g&c=DPL6_X_6JkXFx7AXWqB0tg&r=s2fO0hii0OGNOv9qQy_HRXy-xAJUD1NNoEcc3io_kx0&m=28B2KMSJPmdGukxJhVcT-K6O76mP27iVn-XTqDwJ4p0&s=_9PXmcF7fsBh4pqYI4lOl4kwCY48xSyUzg6VlCDIy9w&e= 
>>
>> Both declarations are made previously of calling dw_pcie_host_init(), so why do
>> you need this dummy ops in the probe function? I never had that necessity.
> 
> Hello Joao
> 
> Since commit 442ec4c04d12, we now have two different ops,
> dw_pcie_ops (ops for dw_pcie) and dw_pcie_host_ops (ops for a pcie_port),
> note that they are different. The dw_pcie_ops is missing for pcie-artpec6
> and pcie-designware-plat (since we are using the generic link-up function).
> 
> Before commit 442ec4c04d12, dw_pcie_writel_dbi had dw_pcie_host_ops as
> parameter, after the commit it has dw_pcie_ops as parameter.
> It should crash on pcie-designware-plat as well, since there are other
> functions, like dw_pcie_link_up, that assumes that pci->ops != null.
> 
> Another alternative to adding the dummy ops would be to add null checks
> for all uses off pci->ops in pcie-designware.c.
> I don't like the idea to sprinkle null checks everywhere pci->ops is used.
> 
> One could add a null check in dw_pcie_host_init, but without a dummy ops
> we would still fail this check, so our drivers would still be non-functional
> in Linus's tree.

Agree.
Acked-by: Joao Pinto <jpinto@synopsys.com>
