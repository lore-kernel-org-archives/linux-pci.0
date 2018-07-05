Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 5 Jul 2018 15:15:22 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 1/2] PCI: aardvark: Size bridges before resources
 allocation
Message-ID: <20180705141522.GA13716@red-moon>
References: <20180629091620.31503-1-thomas.petazzoni@bootlin.com>
 <20180629091620.31503-2-thomas.petazzoni@bootlin.com>
MIME-Version: 1.0
In-Reply-To: <20180629091620.31503-2-thomas.petazzoni@bootlin.com>
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
 Bjorn Helgaas <bhelgaas@google.com>, Zachary Zhang <zhangzg@marvell.com>,
 Wilson Ding <dingwei@marvell.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 29, 2018 at 11:16:19AM +0200, Thomas Petazzoni wrote:
> From: Zachary Zhang <zhangzg@marvell.com>
> 
> The PCIE I/O and MEM resource allocation mechanism is that root bus
> goes through the following steps:
> 
> 1. Check PCI bridges' range and computes I/O and Mem base/limits.
> 
> 2. Sort all subordinate devices I/O and MEM resource requirements and
>    allocate the resources and writes/updates subordinate devices'
>    requirements to PCI bridges I/O and Mem MEM/limits registers.
> 
> Currently, PCI Aardvark driver only handles the second step and lacks
> the first step, so there is an I/O and MEM resource allocation failure
> when using a PCI switch. This commit fixes that by sizing bridges
> before doing the resource allocation.
> 
> Signed-off-by: Zachary Zhang <zhangzg@marvell.com>
> [Thomas: edit commit log.]
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> ---
>  drivers/pci/controller/pci-aardvark.c | 1 +
>  1 file changed, 1 insertion(+)

Hi Thomas,

I am queueing these two patches but this one seems a serious bug,
I reckon we should send it to stable kernels (and would be grateful
if you provide me with a Fixes tag and a kernel log to add to the
commit log).

Thanks,
Lorenzo

> 
> diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> index 486c41721c89..8e92231214e3 100644
> --- a/drivers/pci/controller/pci-aardvark.c
> +++ b/drivers/pci/controller/pci-aardvark.c
> @@ -1065,6 +1065,7 @@ static int advk_pcie_probe(struct platform_device *pdev)
>  
>  	bus = bridge->bus;
>  
> +	pci_bus_size_bridges(bus);
>  	pci_bus_assign_resources(bus);
>  
>  	list_for_each_entry(child, &bus->children, node)
> -- 
> 2.14.4
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
