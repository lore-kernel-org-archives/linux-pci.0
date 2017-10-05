Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 5 Oct 2017 12:55:47 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH v2 7/7] PCI: aardvark: define IRQ related hooks in
 pci_host_bridge
Message-ID: <20171005175547.GT25517@bhelgaas-glaptop.roam.corp.google.com>
References: <20170928125838.11887-1-thomas.petazzoni@free-electrons.com>
 <20170928125838.11887-8-thomas.petazzoni@free-electrons.com>
MIME-Version: 1.0
In-Reply-To: <20170928125838.11887-8-thomas.petazzoni@free-electrons.com>
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
 =?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@free-electrons.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Antoine Tenart <antoine.tenart@free-electrons.com>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Lorenzo]

On Thu, Sep 28, 2017 at 02:58:38PM +0200, Thomas Petazzoni wrote:
> Commit 769b461fc0c0 ("arm64: PCI: Drop DT IRQ allocation from
> pcibios_alloc_irq()") was assuming all PCI host controller drivers had
> been converted to use ->map_irq(), but that wasn't the case:
> pci-aardvark had not been converted. Due to this, it broke the support
> for legacy PCI interrupts when using the pci-aardvark driver (used on
> Marvell Armada 3720 platforms).

Lorenzo is pretty thorough, but maybe pci-aardvark.c got overlooked.
Cc'ing him just to make sure there's nothing deeper than that.

> In order to fix this, we make sure the ->map_irq and ->swizzle_irq
> fields of pci_host_bridge are properly filled in.
> 
> Fixes: 769b461fc0c0 ("arm64: PCI: Drop DT IRQ allocation from pcibios_alloc_irq()")
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: <stable@vger.kernel.org> # v4.13+
> ---
>  drivers/pci/host/pci-aardvark.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/host/pci-aardvark.c b/drivers/pci/host/pci-aardvark.c
> index c1093b023e48..249a088b463c 100644
> --- a/drivers/pci/host/pci-aardvark.c
> +++ b/drivers/pci/host/pci-aardvark.c
> @@ -998,6 +998,8 @@ static int advk_pcie_probe(struct platform_device *pdev)
>  	bridge->sysdata = pcie;
>  	bridge->busnr = 0;
>  	bridge->ops = &advk_pcie_ops;
> +	bridge->map_irq = of_irq_parse_and_map_pci;
> +	bridge->swizzle_irq = pci_common_swizzle;
>  
>  	ret = pci_scan_root_bus_bridge(bridge);
>  	if (ret < 0) {
> -- 
> 2.13.5
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
