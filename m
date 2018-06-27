Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 27 Jun 2018 17:51:24 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 5/6] PCI: aardvark: Introduce an
 advk_pcie_valid_device() helper
Message-ID: <20180627165124.GA8243@red-moon>
References: <20180406145536.19637-1-thomas.petazzoni@bootlin.com>
 <20180406145536.19637-6-thomas.petazzoni@bootlin.com>
MIME-Version: 1.0
In-Reply-To: <20180406145536.19637-6-thomas.petazzoni@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Antoine Tenart <antoine.tenart@bootlin.com>, linux-pci@vger.kernel.org,
 Gregory Clement <gregory.clement@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>, Victor Gu <xigu@marvell.com>,
 =?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Wilson Ding <dingwei@marvell.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 06, 2018 at 04:55:35PM +0200, Thomas Petazzoni wrote:
> In other to mimic other PCIe host controller drivers, introduce an
> advk_pcie_valid_device() helper, used in the configuration read/write
> functions.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> ---
> Changes since v4:
>  - Move later into the series, so that it doesn't need to be pushed as
>    a fix for stable.
> Changes since v3:
>  - Make the new helper return a bool instead of int
> Changes since v2:
>  - New patch
> ---
>  drivers/pci/host/pci-aardvark.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)

Hi Thomas,

please rebase patch 5 (this patch) and 6 and resend, I will apply them
straight away, sorry for the delay.

Thanks,
Lorenzo

> diff --git a/drivers/pci/host/pci-aardvark.c b/drivers/pci/host/pci-aardvark.c
> index 9abf549631b4..69c4fd50947e 100644
> --- a/drivers/pci/host/pci-aardvark.c
> +++ b/drivers/pci/host/pci-aardvark.c
> @@ -431,6 +431,15 @@ static int advk_pcie_wait_pio(struct advk_pcie *pcie)
>  	return -ETIMEDOUT;
>  }
>  
> +static bool advk_pcie_valid_device(struct advk_pcie *pcie, struct pci_bus *bus,
> +				  int devfn)
> +{
> +	if ((bus->number == pcie->root_bus_nr) && PCI_SLOT(devfn) != 0)
> +		return false;
> +
> +	return true;
> +}
> +
>  static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
>  			     int where, int size, u32 *val)
>  {
> @@ -438,7 +447,7 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
>  	u32 reg;
>  	int ret;
>  
> -	if ((bus->number == pcie->root_bus_nr) && PCI_SLOT(devfn) != 0) {
> +	if (!advk_pcie_valid_device(pcie, bus, devfn)) {
>  		*val = 0xffffffff;
>  		return PCIBIOS_DEVICE_NOT_FOUND;
>  	}
> @@ -492,7 +501,7 @@ static int advk_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
>  	int offset;
>  	int ret;
>  
> -	if ((bus->number == pcie->root_bus_nr) && PCI_SLOT(devfn) != 0)
> +	if (!advk_pcie_valid_device(pcie, bus, devfn))
>  		return PCIBIOS_DEVICE_NOT_FOUND;
>  
>  	if (where % size)
> -- 
> 2.14.3
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
