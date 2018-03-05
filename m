Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47032 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933485AbeCEJlg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 5 Mar 2018 04:41:36 -0500
Date: Mon, 5 Mar 2018 09:41:24 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: thierry.reding@gmail.com, bhelgaas@google.com, cyndis@kapsi.fi,
        jonathanh@nvidia.com, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org, vidyas@nvidia.com, kthota@nvidia.com
Subject: Re: [PATCH V9 3/3] PCI: tegra: Add power management support
Message-ID: <20180305094116.GA28109@e107981-ln.cambridge.arm.com>
References: <1519812034-11120-1-git-send-email-mmaddireddy@nvidia.com>
 <1519812034-11120-4-git-send-email-mmaddireddy@nvidia.com>
 <20180302163643.GA18316@e107981-ln.cambridge.arm.com>
 <19831410-9248-61ff-6e75-249c77dcee9a@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <19831410-9248-61ff-6e75-249c77dcee9a@nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Mar 03, 2018 at 01:47:38PM +0530, Manikanta Maddireddy wrote:

[...]

> >> +static int tegra_pcie_pm_resume(struct device *dev)
> >> +{
> >> +	struct tegra_pcie *pcie = dev_get_drvdata(dev);
> >> +	int err;
> >> +
> >> +	err = tegra_pcie_power_on(pcie);
> >> +	if (err) {
> >> +		dev_err(dev, "tegra pcie power on fail: %d\n", err);
> >> +		return err;
> >> +	}
> >> +	err = tegra_pcie_enable_controller(pcie);
> >> +	if (err) {
> >> +		dev_err(dev, "tegra pcie controller enable fail: %d\n", err);
> >> +		goto poweroff;
> >> +	}
> >> +	tegra_pcie_setup_translations(pcie);
> >> +
> >> +	if (IS_ENABLED(CONFIG_PCI_MSI))
> >> +		tegra_pcie_enable_msi(pcie);
> >> +
> >> +	tegra_pcie_enable_ports(pcie);
> > 
> > Is it correct to report a successfull resume if some of the ports fail
> > to come up (whether within runtime PM or system suspend) ? I think that,
> > if any of the ports fails to come up, returning a failure is more
> > appropriate here given that the host bridge is a single device as far as
> > the kernel is concerned.
> > 
> > Thanks,
> > Lorenzo
> > 
> 
> Hi Lorenzo,
> 
> We(Thierry, Vidya Sagar and myself) had a discussion on this topic
> and we chose not to fail probe/resume because host controller is
> initialized properly, so failing the probe/resume is not the right
> thing to do.

What happens then to endpoints downstream a rootport that failed to
resume but we nonetheless reported that it successfully resume instead ?

Thanks,
Lorenzo

> PCIe link may fail to come up if there is no endpoint in the slot
> or interoperable failure where endpoint specific quirk or work
> around required. In such cases host controller driver shouldn't
> fail.
> 
> Also user can connect endpoint in only one slot and expect it to be
> working. Even though host bridge is a single device, driver should
> allow standalone port to work.
> 
> Thanks,
> Manikanta
> 
> >>  
> >>  	return 0;
> >> +
> >> +poweroff:
> >> +	tegra_pcie_power_off(pcie);
> >> +
> >> +	return err;
> >>  }
> >>  
> >> +static const struct dev_pm_ops tegra_pcie_pm_ops = {
> >> +	SET_RUNTIME_PM_OPS(tegra_pcie_pm_suspend, tegra_pcie_pm_resume, NULL)
> >> +	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(tegra_pcie_pm_suspend,
> >> +				      tegra_pcie_pm_resume)
> >> +};
> >> +
> >>  static struct platform_driver tegra_pcie_driver = {
> >>  	.driver = {
> >>  		.name = "tegra-pcie",
> >>  		.of_match_table = tegra_pcie_of_match,
> >>  		.suppress_bind_attrs = true,
> >> +		.pm = &tegra_pcie_pm_ops,
> >>  	},
> >>  	.probe = tegra_pcie_probe,
> >>  	.remove = tegra_pcie_remove,
> >> -- 
> >> 2.1.4
> >>
