Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Mon, 25 Sep 2017 18:56:58 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jan Luebbe <jlu@pengutronix.de>
Subject: Re: [PATCH 2/2] PCI: mvebu: Check DRAM window size
Message-ID: <20170925235658.GK15970@bhelgaas-glaptop.roam.corp.google.com>
References: <20170828152517.24506-1-jlu@pengutronix.de>
 <20170828152517.24506-3-jlu@pengutronix.de>
MIME-Version: 1.0
In-Reply-To: <20170828152517.24506-3-jlu@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@pengutronix.de,
 Gregory Clement <gregory.clement@free-electrons.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 28, 2017 at 05:25:17PM +0200, Jan Luebbe wrote:
> The sum of the DRAM windows may exceed 4GB (at least on Armada XP).
> Return an error in that case.
> 
> Signed-off-by: Jan Luebbe <jlu@pengutronix.de>

Looking for an ack from Thomas or Jason before applying this...

> ---
>  drivers/pci/host/pci-mvebu.c | 27 ++++++++++++++++++++++-----
>  1 file changed, 22 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
> index f353a6eb2f01..5d74af81d104 100644
> --- a/drivers/pci/host/pci-mvebu.c
> +++ b/drivers/pci/host/pci-mvebu.c
> @@ -206,10 +206,10 @@ static void mvebu_pcie_set_local_dev_nr(struct mvebu_pcie_port *port, int nr)
>   * BAR[0,2] -> disabled, BAR[1] -> covers all DRAM banks
>   * WIN[0-3] -> DRAM bank[0-3]
>   */
> -static void mvebu_pcie_setup_wins(struct mvebu_pcie_port *port)
> +static int mvebu_pcie_setup_wins(struct mvebu_pcie_port *port)
>  {
>  	const struct mbus_dram_target_info *dram;
> -	u32 size;
> +	u64 size;
>  	int i;
>  
>  	dram = mv_mbus_dram_info();
> @@ -252,19 +252,32 @@ static void mvebu_pcie_setup_wins(struct mvebu_pcie_port *port)
>  	if ((size & (size - 1)) != 0)
>  		size = 1 << fls(size);
>  
> +	if (size > 0x100000000) {
> +		dev_err(&port->pcie->pdev->dev,
> +			"Could not configure DRAM window (too large): 0x%llx\n",
> +			size);
> +
> +		return -EINVAL;
> +	}
> +
>  	/* Setup BAR[1] to all DRAM banks. */
>  	mvebu_writel(port, dram->cs[0].base, PCIE_BAR_LO_OFF(1));
>  	mvebu_writel(port, 0, PCIE_BAR_HI_OFF(1));
>  	mvebu_writel(port, ((size - 1) & 0xffff0000) | 1,
>  		     PCIE_BAR_CTRL_OFF(1));
> +
> +	return 0;
>  }
>  
> -static void mvebu_pcie_setup_hw(struct mvebu_pcie_port *port)
> +static int mvebu_pcie_setup_hw(struct mvebu_pcie_port *port)
>  {
>  	u32 cmd, mask;
> +	int ret;
>  
>  	/* Point PCIe unit MBUS decode windows to DRAM space. */
> -	mvebu_pcie_setup_wins(port);
> +	ret = mvebu_pcie_setup_wins(port);
> +	if (ret)
> +		return ret;
>  
>  	/* Master + slave enable. */
>  	cmd = mvebu_readl(port, PCIE_CMD_OFF);
> @@ -277,6 +290,8 @@ static void mvebu_pcie_setup_hw(struct mvebu_pcie_port *port)
>  	mask = mvebu_readl(port, PCIE_MASK_OFF);
>  	mask |= PCIE_MASK_ENABLE_INTS;
>  	mvebu_writel(port, mask, PCIE_MASK_OFF);
> +
> +	return 0;
>  }
>  
>  static int mvebu_pcie_hw_rd_conf(struct mvebu_pcie_port *port,
> @@ -882,7 +897,9 @@ static int mvebu_pcie_setup(int nr, struct pci_sys_data *sys)
>  
>  		if (!port->base)
>  			continue;
> -		mvebu_pcie_setup_hw(port);
> +		err = mvebu_pcie_setup_hw(port);
> +		if (err)
> +			return 0;
>  	}
>  
>  	return 1;
> -- 
> 2.11.0
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
