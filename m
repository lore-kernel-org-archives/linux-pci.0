Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 5 Oct 2017 12:31:02 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH v2 3/7] PCI: aardvark: set host and device to the same
 MAX payload size
Message-ID: <20171005173102.GR25517@bhelgaas-glaptop.roam.corp.google.com>
References: <20170928125838.11887-1-thomas.petazzoni@free-electrons.com>
 <20170928125838.11887-4-thomas.petazzoni@free-electrons.com>
MIME-Version: 1.0
In-Reply-To: <20170928125838.11887-4-thomas.petazzoni@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Andrew Lunn <andrew@lunn.ch>, Yehuda Yitschak <yehuday@marvell.com>,
 Jason Cooper <jason@lakedaemon.net>, linux-pci@vger.kernel.org,
 Hanna Hawa <hannah@marvell.com>, Nadav Haklai <nadavh@marvell.com>,
 Gregory Clement <gregory.clement@free-electrons.com>,
 Victor Gu <xigu@marvell.com>,
 =?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@free-electrons.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Antoine Tenart <antoine.tenart@free-electrons.com>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Sep 28, 2017 at 02:58:34PM +0200, Thomas Petazzoni wrote:
> From: Victor Gu <xigu@marvell.com>
> 
> Since the Aardvark does not implement a PCIe root bus, 

What exactly do you mean by "does not implement a PCIe root bus"?  I
assume there is still a hierarchy of PCI buses, and I assume the
hierarchy has a top-most ("root") bus.

Maybe there's no Root Port?  There are other systems that don't have
Root Ports, and we've made changes to accommodate that, e.g.,

http://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?id=1b8a6079015f

If we can make the generic code work for whatever the Aardvark
topology is, that would be better than adding Aardvark-specific code
here.

> the Linux PCIe
> subsystem will not align the MAX payload size between the host and the
> device. This patch ensures that the host and device have the same MAX
> payload size, fixing a number of problems with various PCIe devices.
> 
> This is part of fixing bug
> https://bugzilla.kernel.org/show_bug.cgi?id=196339, this commit was
> reported as the user to be important to get a Intel 7260 mini-PCIe
> WiFi card working.
> 
> Fixes: Fixes: 8c39d710363c1 ("PCI: aardvark: Add Aardvark PCI host controller driver")
> Signed-off-by: Victor Gu <xigu@marvell.com>
> Reviewed-by: Evan Wang <xswang@marvell.com>
> Reviewed-by: Nadav Haklai <nadavh@marvell.com>
> [Thomas: tweak commit log.]
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  drivers/pci/host/pci-aardvark.c | 60 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 59 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pci-aardvark.c b/drivers/pci/host/pci-aardvark.c
> index af7a9c4a61a4..c8a97bad6c4c 100644
> --- a/drivers/pci/host/pci-aardvark.c
> +++ b/drivers/pci/host/pci-aardvark.c
> @@ -30,8 +30,10 @@
>  #define PCIE_CORE_DEV_CTRL_STATS_REG				0xc8
>  #define     PCIE_CORE_DEV_CTRL_STATS_RELAX_ORDER_DISABLE	(0 << 4)
>  #define     PCIE_CORE_DEV_CTRL_STATS_MAX_PAYLOAD_SZ_SHIFT	5
> +#define     PCIE_CORE_DEV_CTRL_STATS_MAX_PAYLOAD_SZ		0x2
>  #define     PCIE_CORE_DEV_CTRL_STATS_SNOOP_DISABLE		(0 << 11)
>  #define     PCIE_CORE_DEV_CTRL_STATS_MAX_RD_REQ_SIZE_SHIFT	12
> +#define     PCIE_CORE_MPS_UNIT_BYTE				128
>  #define PCIE_CORE_LINK_CTRL_STAT_REG				0xd0
>  #define     PCIE_CORE_LINK_L0S_ENTRY				BIT(0)
>  #define     PCIE_CORE_LINK_TRAINING				BIT(5)
> @@ -297,7 +299,8 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
>  
>  	/* Set PCIe Device Control and Status 1 PF0 register */
>  	reg = PCIE_CORE_DEV_CTRL_STATS_RELAX_ORDER_DISABLE |
> -		(7 << PCIE_CORE_DEV_CTRL_STATS_MAX_PAYLOAD_SZ_SHIFT) |
> +		(PCIE_CORE_DEV_CTRL_STATS_MAX_PAYLOAD_SZ <<
> +		 PCIE_CORE_DEV_CTRL_STATS_MAX_PAYLOAD_SZ_SHIFT) |
>  		PCIE_CORE_DEV_CTRL_STATS_SNOOP_DISABLE |
>  		PCIE_CORE_DEV_CTRL_STATS_MAX_RD_REQ_SIZE_SHIFT;
>  	advk_writel(pcie, reg, PCIE_CORE_DEV_CTRL_STATS_REG);
> @@ -879,6 +882,58 @@ static int advk_pcie_parse_request_of_pci_ranges(struct advk_pcie *pcie)
>  	return err;
>  }
>  
> +static int advk_pcie_find_smpss(struct pci_dev *dev, void *data)
> +{
> +	u8 *smpss = data;
> +
> +	if (!dev)
> +		return 0;
> +
> +	if (!pci_is_pcie(dev))
> +		return 0;
> +
> +	if (*smpss > dev->pcie_mpss)
> +		*smpss = dev->pcie_mpss;
> +
> +	return 0;
> +}
> +
> +static int advk_pcie_bus_configure_mps(struct pci_dev *dev, void *data)
> +{
> +	int mps;
> +
> +	if (!dev)
> +		return 0;
> +
> +	if (!pci_is_pcie(dev))
> +		return 0;
> +
> +	mps = PCIE_CORE_MPS_UNIT_BYTE << *(u8 *)data;
> +	pcie_set_mps(dev, mps);
> +
> +	return 0;
> +}
> +
> +static void advk_pcie_configure_mps(struct pci_bus *bus, struct advk_pcie *pcie)
> +{
> +	u8 smpss = PCIE_CORE_DEV_CTRL_STATS_MAX_PAYLOAD_SZ;
> +	u32 reg;
> +
> +	/* Find the minimal supported MAX payload size */
> +	advk_pcie_find_smpss(bus->self, &smpss);
> +	pci_walk_bus(bus, advk_pcie_find_smpss, &smpss);
> +
> +	/* Configure RC MAX payload size */
> +	reg = advk_readl(pcie, PCIE_CORE_DEV_CTRL_STATS_REG);
> +	reg &= ~PCI_EXP_DEVCTL_PAYLOAD;
> +	reg |= smpss << PCIE_CORE_DEV_CTRL_STATS_MAX_PAYLOAD_SZ_SHIFT;
> +	advk_writel(pcie, reg, PCIE_CORE_DEV_CTRL_STATS_REG);
> +
> +	/* Configure device MAX payload size */
> +	advk_pcie_bus_configure_mps(bus->self, &smpss);
> +	pci_walk_bus(bus, advk_pcie_bus_configure_mps, &smpss);
> +}
> +
>  static int advk_pcie_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -950,6 +1005,9 @@ static int advk_pcie_probe(struct platform_device *pdev)
>  	list_for_each_entry(child, &bus->children, node)
>  		pcie_bus_configure_settings(child);
>  
> +	/* Configure the MAX pay load size */
> +	advk_pcie_configure_mps(bus, pcie);
> +
>  	pci_bus_add_devices(bus);
>  	return 0;
>  }
> -- 
> 2.13.5
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
