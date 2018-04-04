Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 4 Apr 2018 12:28:43 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 1/6] PCI: aardvark: Introduce an
 advk_pcie_valid_device() helper
Message-ID: <20180404112843.GA24669@red-moon>
References: <20180329083946.25970-1-thomas.petazzoni@bootlin.com>
 <20180329083946.25970-2-thomas.petazzoni@bootlin.com>
MIME-Version: 1.0
In-Reply-To: <20180329083946.25970-2-thomas.petazzoni@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Antoine Tenart <antoine.tenart@bootlin.com>, linux-pci@vger.kernel.org,
 Gregory Clement <gregory.clement@bootlin.com>, stable@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>, Victor Gu <xigu@marvell.com>,
 =?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 29, 2018 at 10:39:41AM +0200, Thomas Petazzoni wrote:
> In other to mimic other PCIe host controller drivers, introduce an
> advk_pcie_valid_device() helper, used in the configuration read/write
> functions.
> 
> This patch by itself is not a fix, but it is required for a follow-up
> patch that is a fix, hence the Fixes tag and the Cc to stable.

Should not we just reshuffle patch 1 and 2 instead of sending this
patch to stable ? I appreciate the merge window is open and timing is
quite tight, it is just to avoid sending churn to stable kernels
for not much.

Thanks,
Lorenzo

> Fixes: 8c39d710363c1 ("PCI: aardvark: Add Aardvark PCI host controller driver")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> ---
> Changes since v3:
>  - Make the new helper return a bool instead of int
> Changes since v2:
>  - New patch
> ---
>  drivers/pci/host/pci-aardvark.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-aardvark.c b/drivers/pci/host/pci-aardvark.c
> index b04d37b3c5de..82bff709a4b3 100644
> --- a/drivers/pci/host/pci-aardvark.c
> +++ b/drivers/pci/host/pci-aardvark.c
> @@ -430,6 +430,15 @@ static int advk_pcie_wait_pio(struct advk_pcie *pcie)
>  	return -ETIMEDOUT;
>  }
>  
> +static bool advk_pcie_valid_device(struct advk_pcie *pcie, struct pci_bus *bus,
> +				  int devfn)
> +{
> +	if (PCI_SLOT(devfn) != 0)
> +		return false;
> +
> +	return true;
> +}
> +
>  static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
>  			     int where, int size, u32 *val)
>  {
> @@ -437,7 +446,7 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
>  	u32 reg;
>  	int ret;
>  
> -	if (PCI_SLOT(devfn) != 0) {
> +	if (!advk_pcie_valid_device(pcie, bus, devfn)) {
>  		*val = 0xffffffff;
>  		return PCIBIOS_DEVICE_NOT_FOUND;
>  	}
> @@ -491,7 +500,7 @@ static int advk_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
>  	int offset;
>  	int ret;
>  
> -	if (PCI_SLOT(devfn) != 0)
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
