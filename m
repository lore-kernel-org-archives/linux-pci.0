Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Mon, 3 Apr 2017 15:18:14 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Tomasz Nowicki <tn@semihalf.com>
Subject: Re: [PATCH 1/1] PCI: Fix for PEM-specific resource reservation for
 legacy firmware case
Message-ID: <20170403201814.GA13232@bhelgaas-glaptop.roam.corp.google.com>
References: <1490972804-25830-1-git-send-email-tn@semihalf.com>
MIME-Version: 1.0
In-Reply-To: <1490972804-25830-1-git-send-email-tn@semihalf.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Lorenzo.Pieralisi@arm.com, Sunil.Goutham@cavium.com, rafael@kernel.org,
 linux-pci@vger.kernel.org, linu.cherian@cavium.com, ddaney@caviumnetworks.com,
 geethasowjanya.akula@gmail.com, linux-acpi@vger.kernel.org,
 robert.richter@caviumnetworks.com, Vadim.Lomovtsev@caviumnetworks.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 31, 2017 at 05:06:44PM +0200, Tomasz Nowicki wrote:
> SZ_16M PEM resource size includes PEM-specific register and its children
> resources. Reservation of the whole SZ_16M range leads to child device
> driver failure when pcieport driver is requesting resources:
> pcieport 0004:1f:00.0: can't enable device: BAR 0 [mem 0x87e0c0f00000-0x87e0c0ffffff 64bit] not claimed
> So we cannot reserve full 16M here and instead we want to reserve
> PEM-specific register only which is SZ_64K.
> 
> At the end increase PEM resource to SZ_16M since this is what
> thunder_pem_init() call expects for proper initialization.
> 
> Fixes: 9abb27c7594a ("PCI: thunder-pem: Add legacy firmware support for Cavium ThunderX host controller")
> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> CC: stable@vger.kernel.org	# v4.10+

Applied to for-linus for v4.11, thanks!

> ---
>  drivers/pci/host/pci-thunder-pem.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-thunder-pem.c b/drivers/pci/host/pci-thunder-pem.c
> index b89c373..6e031b5 100644
> --- a/drivers/pci/host/pci-thunder-pem.c
> +++ b/drivers/pci/host/pci-thunder-pem.c
> @@ -375,7 +375,6 @@ static void thunder_pem_legacy_fw(struct acpi_pci_root *root,
>  	index -= node * PEM_MAX_DOM_IN_NODE;
>  	res_pem->start = PEM_RES_BASE | FIELD_PREP(PEM_NODE_MASK, node) |
>  					FIELD_PREP(PEM_INDX_MASK, index);
> -	res_pem->end = res_pem->start + SZ_16M - 1;
>  	res_pem->flags = IORESOURCE_MEM;
>  }
>  
> @@ -399,8 +398,15 @@ static int thunder_pem_acpi_init(struct pci_config_window *cfg)
>  	 */
>  	if (ret) {
>  		thunder_pem_legacy_fw(root, res_pem);
> -		/* Reserve PEM-specific resources and PCI configuration space */
> +		/*
> +		 * Reserve 64K size PEM specific resources. The full 16M range
> +		 * size is required for thunder_pem_init() call.
> +		 */
> +		res_pem->end = res_pem->start + SZ_64K - 1;
>  		thunder_pem_reserve_range(dev, root->segment, res_pem);
> +		res_pem->end = res_pem->start + SZ_16M - 1;
> +
> +		/* Reserve PCI configuration space as well. */
>  		thunder_pem_reserve_range(dev, root->segment, &cfg->res);
>  	}
>  
> -- 
> 2.7.4
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
