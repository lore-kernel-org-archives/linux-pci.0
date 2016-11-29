Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Tue, 29 Nov 2016 17:40:39 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Tomasz Nowicki <tn@semihalf.com>
Cc: will.deacon@arm.com, catalin.marinas@arm.com, rafael@kernel.org,
        Lorenzo.Pieralisi@arm.com, arnd@arndb.de, hanjun.guo@linaro.org,
        okaya@codeaurora.org, cov@codeaurora.org, dhdang@apm.com,
        Liviu.Dudau@arm.com, msalter@redhat.com, wangyijing@huawei.com,
        jchandra@broadcom.com, ard.biesheuvel@linaro.org,
        robert.richter@caviumnetworks.com, mw@semihalf.com,
        ddaney@caviumnetworks.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org,
        andrea.gallo@linaro.org, jeremy.linton@arm.com,
        liudongdong3@huawei.com, gabriele.paoloni@huawei.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        jcm@redhat.com, jhugo@codeaurora.org
Subject: Re: [PATCH V6 1/1] ARM64/PCI: Manage controller-specific information
 on the host controller basis
Message-ID: <20161129234039.GB7375@bhelgaas-glaptop.roam.corp.google.com>
References: <1473449047-10499-1-git-send-email-tn@semihalf.com>
 <1479985523-10006-1-git-send-email-tn@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1479985523-10006-1-git-send-email-tn@semihalf.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Nov 24, 2016 at 12:05:23PM +0100, Tomasz Nowicki wrote:
> Currently we use one shared global acpi_pci_root_ops structure to keep
> controller-specific ops. Then its pointer is passed to acpi_pci_root_create()
> and associated with host bridge instance for good. Such design implies
> serious drawback. Any potential manipulation on the single system-wide
> acpi_pci_root_ops leads to kernel crash. The structure content is not
> really changing even across multiple host bridges creation thus it was not
> the issue so far.
> 
> In preparation for adding ECAM quirks mechanism (where controller-specific
> PCI ops may be different for each host bridge) allocate new
> acpi_pci_root_ops and fill in with data for each bridge. Now it is safe
> to have different controller-specific info. As a consequence free
> acpi_pci_root_ops when host bridge is released.
> 
> No functional changes in this patch.
> 
> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>

Applied to pci/ecam for v4.10, thanks, Tomasz!

> ---
>  arch/arm64/kernel/pci.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> index fb439c7..5c08baf 100644
> --- a/arch/arm64/kernel/pci.c
> +++ b/arch/arm64/kernel/pci.c
> @@ -152,33 +152,36 @@ static void pci_acpi_generic_release_info(struct acpi_pci_root_info *ci)
>  
>  	ri = container_of(ci, struct acpi_pci_generic_root_info, common);
>  	pci_ecam_free(ri->cfg);
> +	kfree(ci->ops);
>  	kfree(ri);
>  }
>  
> -static struct acpi_pci_root_ops acpi_pci_root_ops = {
> -	.release_info = pci_acpi_generic_release_info,
> -};
> -
>  /* Interface called from ACPI code to setup PCI host controller */
>  struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
>  {
>  	int node = acpi_get_node(root->device->handle);
>  	struct acpi_pci_generic_root_info *ri;
>  	struct pci_bus *bus, *child;
> +	struct acpi_pci_root_ops *root_ops;
>  
>  	ri = kzalloc_node(sizeof(*ri), GFP_KERNEL, node);
>  	if (!ri)
>  		return NULL;
>  
> +	root_ops = kzalloc_node(sizeof(*root_ops), GFP_KERNEL, node);
> +	if (!root_ops)
> +		return NULL;
> +
>  	ri->cfg = pci_acpi_setup_ecam_mapping(root);
>  	if (!ri->cfg) {
>  		kfree(ri);
> +		kfree(root_ops);
>  		return NULL;
>  	}
>  
> -	acpi_pci_root_ops.pci_ops = &ri->cfg->ops->pci_ops;
> -	bus = acpi_pci_root_create(root, &acpi_pci_root_ops, &ri->common,
> -				   ri->cfg);
> +	root_ops->release_info = pci_acpi_generic_release_info;
> +	root_ops->pci_ops = &ri->cfg->ops->pci_ops;
> +	bus = acpi_pci_root_create(root, root_ops, &ri->common, ri->cfg);
>  	if (!bus)
>  		return NULL;
>  
> -- 
> 2.7.4
> 
