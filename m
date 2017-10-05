Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 5 Oct 2017 12:23:30 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH v2 1/7] PCI: aardvark: fix logic in PCI configuration
 read/write functions
Message-ID: <20171005172330.GP25517@bhelgaas-glaptop.roam.corp.google.com>
References: <20170928125838.11887-1-thomas.petazzoni@free-electrons.com>
 <20170928125838.11887-2-thomas.petazzoni@free-electrons.com>
MIME-Version: 1.0
In-Reply-To: <20170928125838.11887-2-thomas.petazzoni@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Andrew Lunn <andrew@lunn.ch>, Yehuda Yitschak <yehuday@marvell.com>,
 Jason Cooper <jason@lakedaemon.net>, linux-pci@vger.kernel.org,
 Hanna Hawa <hannah@marvell.com>, stable@vger.kernel.org,
 Nadav Haklai <nadavh@marvell.com>,
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

On Thu, Sep 28, 2017 at 02:58:32PM +0200, Thomas Petazzoni wrote:
> From: Victor Gu <xigu@marvell.com>
> 
> The PCI configuration space read/write functions were special casing
> the situation where PCI_SLOT(devfn) != 0, and returned
> PCIBIOS_DEVICE_NOT_FOUND in this case.
> 
> However, will this is what is intended for the root bus, it is not
> intended for the child busses, as it prevents discovering devices with
> PCI_SLOT(x) != 0. Therefore, we return PCIBIOS_DEVICE_NOT_FOUND only
> if we're on the root bus.
> 
> Fixes: 8c39d710363c1 ("PCI: aardvark: Add Aardvark PCI host controller driver")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Victor Gu <xigu@marvell.com>
> Reviewed-by: Wilson Ding <dingwei@marvell.com>
> Reviewed-by: Nadav Haklai <nadavh@marvell.com>
> [Thomas: tweak commit log.]
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  drivers/pci/host/pci-aardvark.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-aardvark.c b/drivers/pci/host/pci-aardvark.c
> index 89f4e3d072d7..da2881ba7737 100644
> --- a/drivers/pci/host/pci-aardvark.c
> +++ b/drivers/pci/host/pci-aardvark.c
> @@ -440,7 +440,7 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
>  	u32 reg;
>  	int ret;
>  
> -	if (PCI_SLOT(devfn) != 0) {
> +	if ((bus->number == pcie->root_bus_nr) && (PCI_SLOT(devfn) != 0)) {

I'm fine with this, but please take a look at these:

  8e7ca8ca5fd8 PCI: xilinx: Relax device number checking to allow SR-IOV
  e18934b5e9c7 PCI: designware: Relax device number checking to allow SR-IOV
  d99e30b7936a PCI: altera: Relax device number checking to allow SR-IOV

and make sure that reasoning doesn't apply here, too.

http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=8e7ca8ca5fd8
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=e18934b5e9c7
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=d99e30b7936a

>  		*val = 0xffffffff;
>  		return PCIBIOS_DEVICE_NOT_FOUND;
>  	}
> @@ -494,7 +494,7 @@ static int advk_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
>  	int offset;
>  	int ret;
>  
> -	if (PCI_SLOT(devfn) != 0)
> +	if ((bus->number == pcie->root_bus_nr) && (PCI_SLOT(devfn) != 0))
>  		return PCIBIOS_DEVICE_NOT_FOUND;
>  
>  	if (where % size)
> -- 
> 2.13.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
