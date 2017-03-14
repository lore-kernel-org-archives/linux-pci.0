Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 14 Mar 2017 14:30:05 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Stephen Boyd <stephen.boyd@linaro.org>
Subject: Re: [PATCH] PCI: aardvark: Remove msi-controller dt node probing
Message-ID: <20170314193005.GC26264@bhelgaas-glaptop.roam.corp.google.com>
References: <20170314190851.28203-1-stephen.boyd@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20170314190851.28203-1-stephen.boyd@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 14, 2017 at 12:08:51PM -0700, Stephen Boyd wrote:
> This code assigns variables that are never used. Remove them.
> 
> Reported-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>

I love removing unused code!  Applied to pci/host-aardvark for v4.12,
thanks!

> ---
>  drivers/pci/host/pci-aardvark.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-aardvark.c b/drivers/pci/host/pci-aardvark.c
> index 4fce494271cc..56e1aead65fc 100644
> --- a/drivers/pci/host/pci-aardvark.c
> +++ b/drivers/pci/host/pci-aardvark.c
> @@ -917,8 +917,6 @@ static int advk_pcie_probe(struct platform_device *pdev)
>  	struct advk_pcie *pcie;
>  	struct resource *res;
>  	struct pci_bus *bus, *child;
> -	struct msi_controller *msi;
> -	struct device_node *msi_node;
>  	int ret, irq;
>  
>  	pcie = devm_kzalloc(dev, sizeof(struct advk_pcie), GFP_KERNEL);
> @@ -962,12 +960,6 @@ static int advk_pcie_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	msi_node = of_parse_phandle(dev->of_node, "msi-parent", 0);
> -	if (msi_node)
> -		msi = of_pci_find_msi_chip_by_node(msi_node);
> -	else
> -		msi = NULL;
> -
>  	bus = pci_scan_root_bus_msi(dev, 0, &advk_pcie_ops,
>  				    pcie, &pcie->resources, &pcie->msi);
>  	if (!bus) {
> -- 
> 2.10.0.297.gf6727b0
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
