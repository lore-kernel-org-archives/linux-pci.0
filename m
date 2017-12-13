Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:33696 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753573AbdLMSu5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Dec 2017 13:50:57 -0500
Date: Wed, 13 Dec 2017 18:51:37 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: thierry.reding@gmail.com, bhelgaas@google.com,
        jonathanh@nvidia.com, vidyas@nvidia.com, mperttunen@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        kthota@nvidia.com, Ley Foon Tan <lftan@altera.com>
Subject: Re: [PATCH V3 03/12] PCI: tegra: Retrain link for Gen2 speed
Message-ID: <20171213185137.GE4060@red-moon>
References: <1509371843-22931-1-git-send-email-mmaddireddy@nvidia.com>
 <1509371843-22931-4-git-send-email-mmaddireddy@nvidia.com>
 <20171212143201.GC30799@e107981-ln.cambridge.arm.com>
 <bc949c6d-1947-164f-d1f4-2e9e77be56d9@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <bc949c6d-1947-164f-d1f4-2e9e77be56d9@nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Dec 13, 2017 at 11:24:03PM +0530, Manikanta Maddireddy wrote:
> 
> 
> On 12-Dec-17 8:02 PM, Lorenzo Pieralisi wrote:
> > [+Ley Foon Tan]
> > 
> > On Mon, Oct 30, 2017 at 07:27:14PM +0530, Manikanta Maddireddy wrote:
> >> Tegra124, 132, 210 and 186 support Gen2 link speed. After the link is up
> >> in Gen1, set target link speed as Gen2 and retrain link. Link switches to
> >> Gen2 speed if Gen2 capable end point is connected, else link stays in Gen1.
> >>
> >> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> >> ---
> >> V3:
> >> * Corrected commit log
> >> * Replaced jiffies with ktime
> >> V2:
> >> * no change in this patch
> >>
> >>  drivers/pci/host/pci-tegra.c | 42 ++++++++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 42 insertions(+)
> >>
> >> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
> >> index 068510b40c1a..ed5e8acfdc32 100644
> >> --- a/drivers/pci/host/pci-tegra.c
> >> +++ b/drivers/pci/host/pci-tegra.c
> >> @@ -232,6 +232,8 @@
> >>  #define PADS_REFCLK_CFG_PREDI_SHIFT		8  /* 11:8 */
> >>  #define PADS_REFCLK_CFG_DRVI_SHIFT		12 /* 15:12 */
> >>  
> >> +#define LINK_RETRAIN_TIMEOUT 100000
> >> +
> >>  struct tegra_msi {
> >>  	struct msi_controller chip;
> >>  	DECLARE_BITMAP(used, INT_PCI_MSI_NR);
> >> @@ -2134,6 +2136,42 @@ static void tegra_pcie_enable_ports(struct tegra_pcie *pcie)
> >>  	}
> >>  }
> >>  
> >> +static void tegra_pcie_change_link_speed(struct tegra_pcie *pcie,
> >> +					 struct pci_dev *pci_dev)
> >> +{
> >> +	struct device *dev = pcie->dev;
> >> +	ktime_t deadline;
> >> +	unsigned short val;
> > 
> > u16
> > 
> >> +	/* Skip if the current device is not a root port */
> >> +	if (pci_pcie_type(pci_dev) != PCI_EXP_TYPE_ROOT_PORT)
> >> +		return;
> >> +
> >> +	pcie_capability_read_word(pci_dev, PCI_EXP_LNKCTL2, &val);
> >> +	val &= ~PCI_EXP_LNKSTA_CLS;
> >> +	val |= PCI_EXP_LNKSTA_CLS_5_0GB;
> >> +	pcie_capability_write_word(pci_dev, PCI_EXP_LNKCTL2, val);
> > 
> > Should you not read the Link Capabilities 2 register ("Supported Speed
> > Vector") before programming the Link control 2 register Target Link
> > Speed value ?
> > 
> Link Capabilities 2 register is hardwired to 0 and not used in Tegra.
> This information is documented in Tegra TRM.

You should add a comment to explain that then.

> >> +	/* Retrain the link */
> >> +	pcie_capability_read_word(pci_dev, PCI_EXP_LNKCTL, &val);
> >> +	val |= PCI_EXP_LNKCTL_RL;
> >> +	pcie_capability_write_word(pci_dev, PCI_EXP_LNKCTL, val);
> >> +
> >> +	deadline = ktime_add_us(ktime_get(), LINK_RETRAIN_TIMEOUT);
> >> +	for (;;) {
> >> +		pcie_capability_read_word(pci_dev, PCI_EXP_LNKSTA, &val);
> >> +		if (!(val & PCI_EXP_LNKSTA_LT))
> >> +			break;
> >> +		if (ktime_after(ktime_get(), deadline))
> >> +			break;
> >> +		usleep_range(2000, 3000);
> > 
> > Ok - I hope we won't end up with every host bridge re-writing its own
> > link training loop because at that point in time we should think about
> > consolidating this.
> > 
> Are you saying that we need to add common link retrain function in
> pci core driver and reuse it in all host drivers?

We do not need to, we should aim for it though. There is nothing
(well - I wish) platform specific in what you are doing.

> > CC'ing Ley Foon Tan since I would like to understand why the Altera
> > driver link retraining can't be written with the same code as this
> > driver - I suspect it has to do with the retraining sequence and when
> > the retraining is actually carried out in the host bridge probe
> > sequence.
> >
> >> +	}
> >> +
> >> +	if (val & PCI_EXP_LNKSTA_LT)
> >> +		dev_err(dev, "link retrain of PCIe slot %u failed\n",
> >> +			PCI_SLOT(pci_dev->devfn));
> >> +}
> >> +
> >>  static const struct tegra_pcie_soc tegra20_pcie = {
> >>  	.num_ports = 2,
> >>  	.msi_base_shift = 0,
> >> @@ -2335,6 +2373,7 @@ static int tegra_pcie_probe(struct platform_device *pdev)
> >>  	struct pci_host_bridge *host;
> >>  	struct tegra_pcie *pcie;
> >>  	struct pci_bus *child;
> >> +	struct pci_dev *pci_dev = NULL;
> >>  	int err;
> >>  
> >>  	host = devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
> >> @@ -2400,6 +2439,9 @@ static int tegra_pcie_probe(struct platform_device *pdev)
> >>  
> >>  	pci_bus_add_devices(host->bus);
> >>  
> >> +	for_each_pci_dev(pci_dev)
> >> +		tegra_pcie_change_link_speed(pcie, pci_dev);
> >> +
> > 
> > Are you sure it is safe to change link speed after adding devices ?
> > 
> > Lorenzo
> I tried to do link retrain right after 'linkup in Gen1' i.e before pci_bus_add_devices(),
> but it taking more time than timeout(100 msec) I added in tegra_pcie_change_link_speed().

You should not try, you should understand the reason behind it.

> So I moved it here to have minimum delay for retraining link. I didn't see any issue
> here, link speed is moving to Gen2 without any issue. Do you want me look into anything
> particular here?

At that point you can have devices matched to drivers - I do not think
that's correct to carry out the retraining after devices are added even
if it may work for you.

Yes, I want you please to look into the reasons that bring to the timeout
and the consequent retraining code placement in the probe path.

Thanks,
Lorenzo
