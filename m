Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 1 Sep 2016 13:23:45 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Tomasz Nowicki <tn@semihalf.com>
Subject: Re: [RFC PATCH V5 1/5] PCI: Embed pci_ecam_ops in pci_config_window
 structure
Message-ID: <20160901182345.GA18461@localhost>
References: <1470661541-26270-1-git-send-email-tn@semihalf.com>
 <1470661541-26270-2-git-send-email-tn@semihalf.com>
MIME-Version: 1.0
In-Reply-To: <1470661541-26270-2-git-send-email-tn@semihalf.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: gabriele.paoloni@huawei.com, rafael@kernel.org, catalin.marinas@arm.com,
 will.deacon@arm.com, okaya@codeaurora.org, wangyijing@huawei.com,
 andrea.gallo@linaro.org, Lorenzo.Pieralisi@arm.com, jhugo@codeaurora.org,
 linaro-acpi@lists.linaro.org, ddaney@caviumnetworks.com,
 linux-acpi@vger.kernel.org, robert.richter@caviumnetworks.com,
 liudongdong3@huawei.com, linux-pci@vger.kernel.org, Liviu.Dudau@arm.com,
 arnd@arndb.de, jcm@redhat.com, msalter@redhat.com, cov@codeaurora.org,
 mw@semihalf.com, linux-arm-kernel@lists.infradead.org, jchandra@broadcom.com,
 ard.biesheuvel@linaro.org, dhdang@apm.com, linux-kernel@vger.kernel.org,
 jeremy.linton@arm.com, hanjun.guo@linaro.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 08, 2016 at 03:05:37PM +0200, Tomasz Nowicki wrote:
> pci_config_window keeps pointer to pci_ecam_ops and every time
> we want to deallocate pci_config_window (pci_ecam_free()) we need to make
> sure to free pci_ecam_ops in case it was dynamically allocated prior to
> pci_ecam_create() call.

I think this is a theoretical problem, right?  All the current callers
pass a pointer to a static pci_ecam_ops struct that does not need to
be deallocated.

I see that the next patch uses a pci_ecam_ops struct on the stack,
which would definitely cause issues without this patch, so I agree we
need something like this; I'm just trying to make the changelog make
more sense.

> To avoid that extra effort, embed pci_ecam_ops in pci_config_window,
> instead of just a pointer.
> 
> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> To: Jayachandran C <jchandra@broadcom.com>

This looks like an editing mistake?

> ---
>  arch/arm64/kernel/pci.c  | 2 +-
>  drivers/pci/ecam.c       | 6 +++---
>  include/linux/pci-ecam.h | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> index acf3872..981e828 100644
> --- a/arch/arm64/kernel/pci.c
> +++ b/arch/arm64/kernel/pci.c
> @@ -183,7 +183,7 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
>  		return NULL;
>  	}
>  
> -	acpi_pci_root_ops.pci_ops = &ri->cfg->ops->pci_ops;
> +	acpi_pci_root_ops.pci_ops = &ri->cfg->ops.pci_ops;
>  	bus = acpi_pci_root_create(root, &acpi_pci_root_ops, &ri->common,
>  				   ri->cfg);
>  	if (!bus)
> diff --git a/drivers/pci/ecam.c b/drivers/pci/ecam.c
> index 43ed08d..24242f0 100644
> --- a/drivers/pci/ecam.c
> +++ b/drivers/pci/ecam.c
> @@ -52,7 +52,7 @@ struct pci_config_window *pci_ecam_create(struct device *dev,
>  		return ERR_PTR(-ENOMEM);
>  
>  	cfg->parent = dev;
> -	cfg->ops = ops;
> +	cfg->ops = *ops;
>  	cfg->busr.start = busr->start;
>  	cfg->busr.end = busr->end;
>  	cfg->busr.flags = IORESOURCE_BUS;
> @@ -138,7 +138,7 @@ void __iomem *pci_ecam_map_bus(struct pci_bus *bus, unsigned int devfn,
>  			       int where)
>  {
>  	struct pci_config_window *cfg = bus->sysdata;
> -	unsigned int devfn_shift = cfg->ops->bus_shift - 8;
> +	unsigned int devfn_shift = cfg->ops.bus_shift - 8;
>  	unsigned int busn = bus->number;
>  	void __iomem *base;
>  
> @@ -149,7 +149,7 @@ void __iomem *pci_ecam_map_bus(struct pci_bus *bus, unsigned int devfn,
>  	if (per_bus_mapping)
>  		base = cfg->winp[busn];
>  	else
> -		base = cfg->win + (busn << cfg->ops->bus_shift);
> +		base = cfg->win + (busn << cfg->ops.bus_shift);
>  	return base + (devfn << devfn_shift) + where;
>  }
>  
> diff --git a/include/linux/pci-ecam.h b/include/linux/pci-ecam.h
> index 7adad20..0ce2920 100644
> --- a/include/linux/pci-ecam.h
> +++ b/include/linux/pci-ecam.h
> @@ -39,7 +39,7 @@ struct pci_config_window {
>  	struct resource			res;
>  	struct resource			busr;
>  	void				*priv;
> -	struct pci_ecam_ops		*ops;
> +	struct pci_ecam_ops		ops;
>  	union {
>  		void __iomem		*win;	/* 64-bit single mapping */
>  		void __iomem		**winp; /* 32-bit per-bus mapping */
> -- 
> 1.9.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
