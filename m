Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:10673 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751197AbeA2ErH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 28 Jan 2018 23:47:07 -0500
Subject: Re: [PATCH V6 7/7] PCI: tegra: Add power management support
To: Thierry Reding <thierry.reding@gmail.com>
CC: <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <cyndis@kapsi.fi>, <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <frowand.list@gmail.com>, <rjw@rjwysocki.net>,
        <tglx@linutronix.de>, <vidyas@nvidia.com>, <kthota@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-pm@vger.kernel.org>
References: <1515650888-9459-1-git-send-email-mmaddireddy@nvidia.com>
 <1515650888-9459-8-git-send-email-mmaddireddy@nvidia.com>
 <20180125144814.GI27888@ulmo>
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Message-ID: <83c2cbe2-f50b-cbee-9748-85d21edb08c7@nvidia.com>
Date: Mon, 29 Jan 2018 10:16:45 +0530
MIME-Version: 1.0
In-Reply-To: <20180125144814.GI27888@ulmo>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 25-Jan-18 8:18 PM, Thierry Reding wrote:
> On Thu, Jan 11, 2018 at 11:38:08AM +0530, Manikanta Maddireddy wrote:
>> Tegra186 powergate driver is implemented as power domain driver, power
>> partition ungate/gate are registered as power_on/power_off callback
>> functions. There are no direct functions to power gate/ungate host
>> controller in Tegra186. Host controller driver should add "power-domains"
>> property in device tree and implement runtime suspend and resume
>> callback functons. Power gate and ungate is taken care by power domain
>> driver when host controller driver calls pm_runtime_put_sync and
>> pm_runtime_get_sync respectively.
>>
>> Register suspend_noirq & resume_noirq callback functions to allow PCIe to
>> come up after resume from RAM. Both runtime and noirq pm ops share same
>> callback functions.
>>
>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>> ---
>> V2:
>> * no change in this patch
>> V3:
>> * no change in this patch
>> V4:
>> * no change in this patch
>> V5:
>> * Decoupled from https://patchwork.ozlabs.org/patch/832053/ and
>> rebased on linux-next
>> V6:
>> * no change in this patch
>>
>>  drivers/pci/host/pci-tegra.c | 181 ++++++++++++++++++++++++++-----------------
>>  1 file changed, 110 insertions(+), 71 deletions(-)
>>
>> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
> [...]
>> @@ -1536,37 +1526,41 @@ static int tegra_pcie_enable_msi(struct tegra_pcie *pcie)
>>  	int err;
>>  	u32 reg;
>>  
>> -	mutex_init(&msi->lock);
>> +	if (!msi->phys) {
>> +		mutex_init(&msi->lock);
>>  
>> -	msi->chip.dev = dev;
>> -	msi->chip.setup_irq = tegra_msi_setup_irq;
>> -	msi->chip.teardown_irq = tegra_msi_teardown_irq;
>> +		msi->chip.dev = dev;
>> +		msi->chip.setup_irq = tegra_msi_setup_irq;
>> +		msi->chip.teardown_irq = tegra_msi_teardown_irq;
>>  
>> -	msi->domain = irq_domain_add_linear(dev->of_node, INT_PCI_MSI_NR,
>> -					    &msi_domain_ops, &msi->chip);
>> -	if (!msi->domain) {
>> -		dev_err(dev, "failed to create IRQ domain\n");
>> -		return -ENOMEM;
>> -	}
>> +		msi->domain = irq_domain_add_linear(dev->of_node,
>> +						    INT_PCI_MSI_NR,
>> +						    &msi_domain_ops,
>> +						    &msi->chip);
>> +		if (!msi->domain) {
>> +			dev_err(dev, "failed to create IRQ domain\n");
>> +			return -ENOMEM;
>> +		}
>>  
>> -	err = platform_get_irq_byname(pdev, "msi");
>> -	if (err < 0) {
>> -		dev_err(dev, "failed to get IRQ: %d\n", err);
>> -		goto err;
>> -	}
>> +		err = platform_get_irq_byname(pdev, "msi");
>> +		if (err < 0) {
>> +			dev_err(dev, "failed to get IRQ: %d\n", err);
>> +			goto err;
>> +		}
>>  
>> -	msi->irq = err;
>> +		msi->irq = err;
>>  
>> -	err = request_irq(msi->irq, tegra_pcie_msi_irq, IRQF_NO_THREAD,
>> -			  tegra_msi_irq_chip.name, pcie);
>> -	if (err < 0) {
>> -		dev_err(dev, "failed to request IRQ: %d\n", err);
>> -		goto err;
>> -	}
>> +		err = request_irq(msi->irq, tegra_pcie_msi_irq, IRQF_NO_THREAD,
>> +				  tegra_msi_irq_chip.name, pcie);
>> +		if (err < 0) {
>> +			dev_err(dev, "failed to request IRQ: %d\n", err);
>> +			goto err;
>> +		}
>>  
>> -	/* setup AFI/FPCI range */
>> -	msi->pages = __get_free_pages(GFP_KERNEL, 0);
>> -	msi->phys = virt_to_phys((void *)msi->pages);
>> +		/* setup AFI/FPCI range */
>> +		msi->pages = __get_free_pages(GFP_KERNEL, 0);
>> +		msi->phys = virt_to_phys((void *)msi->pages);
>> +	}
> 
> I think it'd be better to split this off into a separate function so
> that we can get rid of the confusing if (!msi->phys) conditional. It
> looks as though this would work, but it's confusing to have that code
> in a resume handler.
> 
> It also becomes very asymmetric when you set up the MSIs in the resume
> handler, but then don't call tegra_pcie_msi_disable() from the suspend
> handler.
> 
> I'd suggest just pulling out all of the allocations and such into a
> separate function, perhaps tegra_pcie_msi_setup(), and similarily split
> off the resource part of tegra_pcie_disable_msi() into a separate
> function, perhaps tegra_pcie_msi_teardown().
> 
> That way, suspend/resume will do only what they need (write registers)
> and everything will look more symmetric again. That in turn makes the
> code a lot easier to follow and maintain.
I'll do this change in next version.
> 
> Thierry
> 
