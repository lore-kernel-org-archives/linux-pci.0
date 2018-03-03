Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:19125 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751823AbeCCISK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 3 Mar 2018 03:18:10 -0500
Subject: Re: [PATCH V9 3/3] PCI: tegra: Add power management support
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC: <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <cyndis@kapsi.fi>, <jonathanh@nvidia.com>,
        <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <vidyas@nvidia.com>, <kthota@nvidia.com>
References: <1519812034-11120-1-git-send-email-mmaddireddy@nvidia.com>
 <1519812034-11120-4-git-send-email-mmaddireddy@nvidia.com>
 <20180302163643.GA18316@e107981-ln.cambridge.arm.com>
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Message-ID: <19831410-9248-61ff-6e75-249c77dcee9a@nvidia.com>
Date: Sat, 3 Mar 2018 13:47:38 +0530
MIME-Version: 1.0
In-Reply-To: <20180302163643.GA18316@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 02-Mar-18 10:06 PM, Lorenzo Pieralisi wrote:
> On Wed, Feb 28, 2018 at 03:30:34PM +0530, Manikanta Maddireddy wrote:
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
> 
> Hi Manikanta,
> 
> I think that overall the series is ready to go now but first I have a
> question for you and Thierry on this specific patch.
> 
>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>> Acked-by: Thierry Reding <treding@nvidia.com>
>> Tested-by: Thierry Reding <treding@nvidia.com>
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
>> V7:
>> * memory & irq alloc and AFI programming for MSI are split in two functions
>> V8:
>> * Rebased on top of latest patch-2 & 3
>> V9:
>> * no change in this patch
>>
>>  drivers/pci/host/pci-tegra.c | 180 +++++++++++++++++++++++++++----------------
>>  1 file changed, 113 insertions(+), 67 deletions(-)
>>
>> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
>> index 60b1d5e1cfa4..3813820554b2 100644
>> --- a/drivers/pci/host/pci-tegra.c
>> +++ b/drivers/pci/host/pci-tegra.c
>> @@ -1293,31 +1293,25 @@ static int tegra_pcie_get_resources(struct tegra_pcie *pcie)
>>  		}
>>  	}
>>  
>> -	err = tegra_pcie_power_on(pcie);
>> -	if (err) {
>> -		dev_err(dev, "failed to power up: %d\n", err);
>> -		goto phys_put;
>> -	}
>> -
>>  	pads = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pads");
>>  	pcie->pads = devm_ioremap_resource(dev, pads);
>>  	if (IS_ERR(pcie->pads)) {
>>  		err = PTR_ERR(pcie->pads);
>> -		goto poweroff;
>> +		goto phys_put;
>>  	}
>>  
>>  	afi = platform_get_resource_byname(pdev, IORESOURCE_MEM, "afi");
>>  	pcie->afi = devm_ioremap_resource(dev, afi);
>>  	if (IS_ERR(pcie->afi)) {
>>  		err = PTR_ERR(pcie->afi);
>> -		goto poweroff;
>> +		goto phys_put;
>>  	}
>>  
>>  	/* request configuration space, but remap later, on demand */
>>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cs");
>>  	if (!res) {
>>  		err = -EADDRNOTAVAIL;
>> -		goto poweroff;
>> +		goto phys_put;
>>  	}
>>  
>>  	pcie->cs = *res;
>> @@ -1328,14 +1322,14 @@ static int tegra_pcie_get_resources(struct tegra_pcie *pcie)
>>  	pcie->cfg = devm_ioremap_resource(dev, &pcie->cs);
>>  	if (IS_ERR(pcie->cfg)) {
>>  		err = PTR_ERR(pcie->cfg);
>> -		goto poweroff;
>> +		goto phys_put;
>>  	}
>>  
>>  	/* request interrupt */
>>  	err = platform_get_irq_byname(pdev, "intr");
>>  	if (err < 0) {
>>  		dev_err(dev, "failed to get IRQ: %d\n", err);
>> -		goto poweroff;
>> +		goto phys_put;
>>  	}
>>  
>>  	pcie->irq = err;
>> @@ -1343,7 +1337,7 @@ static int tegra_pcie_get_resources(struct tegra_pcie *pcie)
>>  	err = request_irq(pcie->irq, tegra_pcie_isr, IRQF_SHARED, "PCIE", pcie);
>>  	if (err) {
>>  		dev_err(dev, "failed to register IRQ: %d\n", err);
>> -		goto poweroff;
>> +		goto phys_put;
>>  	}
>>  
>>  	return 0;
>> @@ -1351,8 +1345,6 @@ static int tegra_pcie_get_resources(struct tegra_pcie *pcie)
>>  phys_put:
>>  	if (soc->program_uphy)
>>  		tegra_pcie_phys_put(pcie);
>> -poweroff:
>> -	tegra_pcie_power_off(pcie);
>>  	return err;
>>  }
>>  
>> @@ -1363,8 +1355,6 @@ static int tegra_pcie_put_resources(struct tegra_pcie *pcie)
>>  	if (pcie->irq > 0)
>>  		free_irq(pcie->irq, pcie);
>>  
>> -	tegra_pcie_power_off(pcie);
>> -
>>  	if (soc->program_uphy)
>>  		tegra_pcie_phys_put(pcie);
>>  
>> @@ -1533,15 +1523,13 @@ static const struct irq_domain_ops msi_domain_ops = {
>>  	.map = tegra_msi_map,
>>  };
>>  
>> -static int tegra_pcie_enable_msi(struct tegra_pcie *pcie)
>> +static int tegra_pcie_msi_setup(struct tegra_pcie *pcie)
>>  {
>>  	struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
>>  	struct platform_device *pdev = to_platform_device(pcie->dev);
>> -	const struct tegra_pcie_soc *soc = pcie->soc;
>>  	struct tegra_msi *msi = &pcie->msi;
>>  	struct device *dev = pcie->dev;
>>  	int err;
>> -	u32 reg;
>>  
>>  	mutex_init(&msi->lock);
>>  
>> @@ -1574,6 +1562,20 @@ static int tegra_pcie_enable_msi(struct tegra_pcie *pcie)
>>  	/* setup AFI/FPCI range */
>>  	msi->pages = __get_free_pages(GFP_KERNEL, 0);
>>  	msi->phys = virt_to_phys((void *)msi->pages);
>> +	host->msi = &msi->chip;
>> +
>> +	return 0;
>> +
>> +err:
>> +	irq_domain_remove(msi->domain);
>> +	return err;
>> +}
>> +
>> +static void tegra_pcie_enable_msi(struct tegra_pcie *pcie)
>> +{
>> +	const struct tegra_pcie_soc *soc = pcie->soc;
>> +	struct tegra_msi *msi = &pcie->msi;
>> +	u32 reg;
>>  
>>  	afi_writel(pcie, msi->phys >> soc->msi_base_shift, AFI_MSI_FPCI_BAR_ST);
>>  	afi_writel(pcie, msi->phys, AFI_MSI_AXI_BAR_ST);
>> @@ -1594,20 +1596,29 @@ static int tegra_pcie_enable_msi(struct tegra_pcie *pcie)
>>  	reg = afi_readl(pcie, AFI_INTR_MASK);
>>  	reg |= AFI_INTR_MASK_MSI_MASK;
>>  	afi_writel(pcie, reg, AFI_INTR_MASK);
>> +}
>>  
>> -	host->msi = &msi->chip;
>> +static void tegra_pcie_msi_teardown(struct tegra_pcie *pcie)
>> +{
>> +	struct tegra_msi *msi = &pcie->msi;
>> +	unsigned int i, irq;
>>  
>> -	return 0;
>> +	free_pages(msi->pages, 0);
>> +
>> +	if (msi->irq > 0)
>> +		free_irq(msi->irq, pcie);
>> +
>> +	for (i = 0; i < INT_PCI_MSI_NR; i++) {
>> +		irq = irq_find_mapping(msi->domain, i);
>> +		if (irq > 0)
>> +			irq_dispose_mapping(irq);
>> +	}
>>  
>> -err:
>>  	irq_domain_remove(msi->domain);
>> -	return err;
>>  }
>>  
>>  static int tegra_pcie_disable_msi(struct tegra_pcie *pcie)
>>  {
>> -	struct tegra_msi *msi = &pcie->msi;
>> -	unsigned int i, irq;
>>  	u32 value;
>>  
>>  	/* mask the MSI interrupt */
>> @@ -1625,19 +1636,6 @@ static int tegra_pcie_disable_msi(struct tegra_pcie *pcie)
>>  	afi_writel(pcie, 0, AFI_MSI_EN_VEC6);
>>  	afi_writel(pcie, 0, AFI_MSI_EN_VEC7);
>>  
>> -	free_pages(msi->pages, 0);
>> -
>> -	if (msi->irq > 0)
>> -		free_irq(msi->irq, pcie);
>> -
>> -	for (i = 0; i < INT_PCI_MSI_NR; i++) {
>> -		irq = irq_find_mapping(msi->domain, i);
>> -		if (irq > 0)
>> -			irq_dispose_mapping(irq);
>> -	}
>> -
>> -	irq_domain_remove(msi->domain);
>> -
>>  	return 0;
>>  }
>>  
>> @@ -2136,10 +2134,8 @@ static void tegra_pcie_disable_ports(struct tegra_pcie *pcie)
>>  {
>>  	struct tegra_pcie_port *port, *tmp;
>>  
>> -	list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
>> +	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
>>  		tegra_pcie_port_disable(port);
>> -		tegra_pcie_port_free(port);
>> -	}
>>  }
>>  
>>  static const struct tegra_pcie_port_soc tegra20_pcie_ports[] = {
>> @@ -2394,26 +2390,22 @@ static int tegra_pcie_probe(struct platform_device *pdev)
>>  		return err;
>>  	}
>>  
>> -	err = tegra_pcie_enable_controller(pcie);
>> -	if (err)
>> +	err = tegra_pcie_msi_setup(pcie);
>> +	if (err < 0) {
>> +		dev_err(dev, "failed to enable MSI support: %d\n", err);
>>  		goto put_resources;
>> +	}
>>  
>> -	err = tegra_pcie_request_resources(pcie);
>> -	if (err)
>> -		goto disable_controller;
>> -
>> -	/* setup the AFI address translations */
>> -	tegra_pcie_setup_translations(pcie);
>> -
>> -	if (IS_ENABLED(CONFIG_PCI_MSI)) {
>> -		err = tegra_pcie_enable_msi(pcie);
>> -		if (err < 0) {
>> -			dev_err(dev, "failed to enable MSI support: %d\n", err);
>> -			goto free_resources;
>> -		}
>> +	pm_runtime_enable(pcie->dev);
>> +	err = pm_runtime_get_sync(pcie->dev);
>> +	if (err) {
>> +		dev_err(dev, "fail to enable pcie controller: %d\n", err);
>> +		goto teardown_msi;
>>  	}
>>  
>> -	tegra_pcie_enable_ports(pcie);
>> +	err = tegra_pcie_request_resources(pcie);
>> +	if (err)
>> +		goto pm_runtime_put;
>>  
>>  	host->busnr = pcie->busn.start;
>>  	host->dev.parent = &pdev->dev;
>> @@ -2424,7 +2416,7 @@ static int tegra_pcie_probe(struct platform_device *pdev)
>>  	err = pci_scan_root_bus_bridge(host);
>>  	if (err < 0) {
>>  		dev_err(dev, "failed to register host: %d\n", err);
>> -		goto disable_ports;
>> +		goto free_resources;
>>  	}
>>  
>>  	pci_bus_size_bridges(host->bus);
>> @@ -2443,14 +2435,13 @@ static int tegra_pcie_probe(struct platform_device *pdev)
>>  
>>  	return 0;
>>  
>> -disable_ports:
>> -	tegra_pcie_disable_ports(pcie);
>> -	if (IS_ENABLED(CONFIG_PCI_MSI))
>> -		tegra_pcie_disable_msi(pcie);
>>  free_resources:
>>  	tegra_pcie_free_resources(pcie);
>> -disable_controller:
>> -	tegra_pcie_disable_controller(pcie);
>> +pm_runtime_put:
>> +	pm_runtime_put_sync(pcie->dev);
>> +	pm_runtime_disable(pcie->dev);
>> +teardown_msi:
>> +	tegra_pcie_msi_teardown(pcie);
>>  put_resources:
>>  	tegra_pcie_put_resources(pcie);
>>  	return err;
>> @@ -2460,13 +2451,32 @@ static int tegra_pcie_remove(struct platform_device *pdev)
>>  {
>>  	struct tegra_pcie *pcie = platform_get_drvdata(pdev);
>>  	struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
>> -	struct tegra_pcie_port *port;
>> +	struct tegra_pcie_port *port, *tmp;
>>  
>>  	if (IS_ENABLED(CONFIG_DEBUG_FS))
>>  		tegra_pcie_debugfs_exit(pcie);
>>  
>>  	pci_stop_root_bus(host->bus);
>>  	pci_remove_root_bus(host->bus);
>> +	tegra_pcie_free_resources(pcie);
>> +	pm_runtime_put_sync(pcie->dev);
>> +	pm_runtime_disable(pcie->dev);
>> +
>> +	if (IS_ENABLED(CONFIG_PCI_MSI))
>> +		tegra_pcie_msi_teardown(pcie);
>> +
>> +	tegra_pcie_put_resources(pcie);
>> +
>> +	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
>> +		tegra_pcie_port_free(port);
>> +
>> +	return 0;
>> +}
>> +
>> +static int tegra_pcie_pm_suspend(struct device *dev)
>> +{
>> +	struct tegra_pcie *pcie = dev_get_drvdata(dev);
>> +	struct tegra_pcie_port *port;
>>  
>>  	list_for_each_entry(port, &pcie->ports, list)
>>  		tegra_pcie_pme_turnoff(port);
>> @@ -2476,18 +2486,54 @@ static int tegra_pcie_remove(struct platform_device *pdev)
>>  	if (IS_ENABLED(CONFIG_PCI_MSI))
>>  		tegra_pcie_disable_msi(pcie);
>>  
>> -	tegra_pcie_free_resources(pcie);
>>  	tegra_pcie_disable_controller(pcie);
>> -	tegra_pcie_put_resources(pcie);
>> +	tegra_pcie_power_off(pcie);
>> +
>> +	return 0;
>> +}
>> +
>> +static int tegra_pcie_pm_resume(struct device *dev)
>> +{
>> +	struct tegra_pcie *pcie = dev_get_drvdata(dev);
>> +	int err;
>> +
>> +	err = tegra_pcie_power_on(pcie);
>> +	if (err) {
>> +		dev_err(dev, "tegra pcie power on fail: %d\n", err);
>> +		return err;
>> +	}
>> +	err = tegra_pcie_enable_controller(pcie);
>> +	if (err) {
>> +		dev_err(dev, "tegra pcie controller enable fail: %d\n", err);
>> +		goto poweroff;
>> +	}
>> +	tegra_pcie_setup_translations(pcie);
>> +
>> +	if (IS_ENABLED(CONFIG_PCI_MSI))
>> +		tegra_pcie_enable_msi(pcie);
>> +
>> +	tegra_pcie_enable_ports(pcie);
> 
> Is it correct to report a successfull resume if some of the ports fail
> to come up (whether within runtime PM or system suspend) ? I think that,
> if any of the ports fails to come up, returning a failure is more
> appropriate here given that the host bridge is a single device as far as
> the kernel is concerned.
> 
> Thanks,
> Lorenzo
> 

Hi Lorenzo,

We(Thierry, Vidya Sagar and myself) had a discussion on this topic
and we chose not to fail probe/resume because host controller is
initialized properly, so failing the probe/resume is not the right
thing to do.

PCIe link may fail to come up if there is no endpoint in the slot
or interoperable failure where endpoint specific quirk or work
around required. In such cases host controller driver shouldn't
fail.

Also user can connect endpoint in only one slot and expect it to be
working. Even though host bridge is a single device, driver should
allow standalone port to work.

Thanks,
Manikanta

>>  
>>  	return 0;
>> +
>> +poweroff:
>> +	tegra_pcie_power_off(pcie);
>> +
>> +	return err;
>>  }
>>  
>> +static const struct dev_pm_ops tegra_pcie_pm_ops = {
>> +	SET_RUNTIME_PM_OPS(tegra_pcie_pm_suspend, tegra_pcie_pm_resume, NULL)
>> +	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(tegra_pcie_pm_suspend,
>> +				      tegra_pcie_pm_resume)
>> +};
>> +
>>  static struct platform_driver tegra_pcie_driver = {
>>  	.driver = {
>>  		.name = "tegra-pcie",
>>  		.of_match_table = tegra_pcie_of_match,
>>  		.suppress_bind_attrs = true,
>> +		.pm = &tegra_pcie_pm_ops,
>>  	},
>>  	.probe = tegra_pcie_probe,
>>  	.remove = tegra_pcie_remove,
>> -- 
>> 2.1.4
>>
