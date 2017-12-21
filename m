Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:55306 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753122AbdLULse (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 Dec 2017 06:48:34 -0500
Message-ID: <1513885708.2496.10.camel@intel.com>
Subject: Re: [PATCH V3 03/12] PCI: tegra: Retrain link for Gen2 speed
From: Ley Foon Tan <ley.foon.tan@intel.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: thierry.reding@gmail.com, bhelgaas@google.com,
        jonathanh@nvidia.com, vidyas@nvidia.com, mperttunen@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        kthota@nvidia.com, Ley Foon Tan <lftan@altera.com>
Date: Fri, 22 Dec 2017 03:48:28 +0800
In-Reply-To: <20171212143201.GC30799@e107981-ln.cambridge.arm.com>
References: <1509371843-22931-1-git-send-email-mmaddireddy@nvidia.com>
         <1509371843-22931-4-git-send-email-mmaddireddy@nvidia.com>
         <20171212143201.GC30799@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2017-12-12 at 14:32 +0000, Lorenzo Pieralisi wrote:
> [+Ley Foon Tan]
> 
> On Mon, Oct 30, 2017 at 07:27:14PM +0530, Manikanta Maddireddy wrote:
> > 
> > Tegra124, 132, 210 and 186 support Gen2 link speed. After the link
> > is up
> > in Gen1, set target link speed as Gen2 and retrain link. Link
> > switches to
> > Gen2 speed if Gen2 capable end point is connected, else link stays
> > in Gen1.
> > 
> > Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> > ---
> > V3:
> > * Corrected commit log
> > * Replaced jiffies with ktime
> > V2:
> > * no change in this patch
> > 
> >  drivers/pci/host/pci-tegra.c | 42
> > ++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 42 insertions(+)
> > 
> > diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-
> > tegra.c
> > index 068510b40c1a..ed5e8acfdc32 100644
> > --- a/drivers/pci/host/pci-tegra.c
> > +++ b/drivers/pci/host/pci-tegra.c
> > @@ -232,6 +232,8 @@
> >  #define PADS_REFCLK_CFG_PREDI_SHIFT          8  /* 11:8 */
> >  #define PADS_REFCLK_CFG_DRVI_SHIFT           12 /* 15:12 */
> > 
> > +#define LINK_RETRAIN_TIMEOUT 100000
> > +
> >  struct tegra_msi {
> >       struct msi_controller chip;
> >       DECLARE_BITMAP(used, INT_PCI_MSI_NR);
> > @@ -2134,6 +2136,42 @@ static void tegra_pcie_enable_ports(struct
> > tegra_pcie *pcie)
> >       }
> >  }
> > 
> > +static void tegra_pcie_change_link_speed(struct tegra_pcie *pcie,
> > +                                      struct pci_dev *pci_dev)
> > +{
> > +     struct device *dev = pcie->dev;
> > +     ktime_t deadline;
> > +     unsigned short val;
> u16
> 
> > 
> > +     /* Skip if the current device is not a root port */
> > +     if (pci_pcie_type(pci_dev) != PCI_EXP_TYPE_ROOT_PORT)
> > +             return;
> > +
> > +     pcie_capability_read_word(pci_dev, PCI_EXP_LNKCTL2, &val);
> > +     val &= ~PCI_EXP_LNKSTA_CLS;
> > +     val |= PCI_EXP_LNKSTA_CLS_5_0GB;
> > +     pcie_capability_write_word(pci_dev, PCI_EXP_LNKCTL2, val);
> Should you not read the Link Capabilities 2 register ("Supported
> Speed
> Vector") before programming the Link control 2 register Target Link
> Speed value ?
> 
> > 
> > +
> > +     /* Retrain the link */
> > +     pcie_capability_read_word(pci_dev, PCI_EXP_LNKCTL, &val);
> > +     val |= PCI_EXP_LNKCTL_RL;
> > +     pcie_capability_write_word(pci_dev, PCI_EXP_LNKCTL, val);
> > +
> > +     deadline = ktime_add_us(ktime_get(), LINK_RETRAIN_TIMEOUT);
> > +     for (;;) {
> > +             pcie_capability_read_word(pci_dev, PCI_EXP_LNKSTA,
> > &val);
> > +             if (!(val & PCI_EXP_LNKSTA_LT))
> > +                     break;
> > +             if (ktime_after(ktime_get(), deadline))
> > +                     break;
> > +             usleep_range(2000, 3000);
> Ok - I hope we won't end up with every host bridge re-writing its own
> link training loop because at that point in time we should think
> about
> consolidating this.
> 
> CC'ing Ley Foon Tan since I would like to understand why the Altera
> driver link retraining can't be written with the same code as this
> driver - I suspect it has to do with the retraining sequence and when
> the retraining is actually carried out in the host bridge probe
> sequence.
Yes, our hardware requires to poll the LT bit in link status register
&and polling LTSSM status after setting retrain bit link control
register.
> 
> > 
> > +     }
> > +
> > +     if (val & PCI_EXP_LNKSTA_LT)
> > +             dev_err(dev, "link retrain of PCIe slot %u failed\n",
> > +                     PCI_SLOT(pci_dev->devfn));
> > +}
> > +
> >  static const struct tegra_pcie_soc tegra20_pcie = {
> >       .num_ports = 2,
> >       .msi_base_shift = 0,
> > @@ -2335,6 +2373,7 @@ static int tegra_pcie_probe(struct
> > platform_device *pdev)
> >       struct pci_host_bridge *host;
> >       struct tegra_pcie *pcie;
> >       struct pci_bus *child;
> > +     struct pci_dev *pci_dev = NULL;
> >       int err;
> > 
> >       host = devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
> > @@ -2400,6 +2439,9 @@ static int tegra_pcie_probe(struct
> > platform_device *pdev)
> > 
> >       pci_bus_add_devices(host->bus);
> > 
> > +     for_each_pci_dev(pci_dev)
> > +             tegra_pcie_change_link_speed(pcie, pci_dev);
> > +
> Are you sure it is safe to change link speed after adding devices ?
> 
> Lorenzo

"for_each_pci_dev(pci_dev)" will lookup all the PCIe devices in system.
What happen if your system have more than one Tegra PCIe Rootport? Will
it retrains all rootport? And same rootport will retrain for 2 times if
there are 2 rootports?
> 
> > 
> >       if (IS_ENABLED(CONFIG_DEBUG_FS)) {
> >               err = tegra_pcie_debugfs_init(pcie);
> >               if (err < 0)
> > --
> > 2.1.4
> > 
