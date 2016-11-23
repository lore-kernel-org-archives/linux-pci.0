Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:58660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933122AbcKWSWs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Nov 2016 13:22:48 -0500
Date: Wed, 23 Nov 2016 12:22:43 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Tomasz Nowicki <tn@semihalf.com>
Cc: arnd@arndb.de, will.deacon@arm.com, catalin.marinas@arm.com,
        rafael@kernel.org, hanjun.guo@linaro.org,
        Lorenzo.Pieralisi@arm.com, okaya@codeaurora.org,
        jchandra@broadcom.com, robert.richter@caviumnetworks.com,
        mw@semihalf.com, Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
        wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com,
        msalter@redhat.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
        jcm@redhat.com, andrea.gallo@linaro.org, dhdang@apm.com,
        jeremy.linton@arm.com, liudongdong3@huawei.com, cov@codeaurora.org
Subject: Re: [PATCH V9 11/11] ARM64/PCI: Support for ACPI based PCI host
 controller
Message-ID: <20161123182243.GF16033@bhelgaas-glaptop.roam.corp.google.com>
References: <1465588519-11334-1-git-send-email-tn@semihalf.com>
 <1465588519-11334-12-git-send-email-tn@semihalf.com>
 <20161122231321.GA20246@bhelgaas-glaptop.roam.corp.google.com>
 <edf72769-e9c8-4617-8dc4-8f3d05a678e7@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <edf72769-e9c8-4617-8dc4-8f3d05a678e7@semihalf.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 23, 2016 at 12:21:03PM +0100, Tomasz Nowicki wrote:
> Hi Bjorn,
> 
> On 23.11.2016 00:13, Bjorn Helgaas wrote:
> >Hi Tomasz,
> >
> >On Fri, Jun 10, 2016 at 09:55:19PM +0200, Tomasz Nowicki wrote:
> >>Implement pci_acpi_scan_root and other arch-specific call so that ARM64
> >>can start using ACPI to setup and enumerate PCI buses.
> >>
> >>Prior to buses enumeration the pci_acpi_scan_root() implementation looks
> >>for configuration space start address (obtained through ACPI _CBA method or
> >>MCFG interface). If succeed, it uses ECAM library to create new mapping.
> >>Then it attaches generic ECAM ops (pci_generic_ecam_ops) which are used
> >>for accessing configuration space later on.
> >>...
> >
> >>+static struct acpi_pci_root_ops acpi_pci_root_ops = {
> >>+	.release_info = pci_acpi_generic_release_info,
> >>+};
> >>+
> >>+/* Interface called from ACPI code to setup PCI host controller */
> >> struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
> >> {
> >>-	/* TODO: Should be revisited when implementing PCI on ACPI */
> >>-	return NULL;
> >>+	int node = acpi_get_node(root->device->handle);
> >>+	struct acpi_pci_generic_root_info *ri;
> >>+	struct pci_bus *bus, *child;
> >>+
> >>+	ri = kzalloc_node(sizeof(*ri), GFP_KERNEL, node);
> >>+	if (!ri)
> >>+		return NULL;
> >>+
> >>+	ri->cfg = pci_acpi_setup_ecam_mapping(root);
> >>+	if (!ri->cfg) {
> >>+		kfree(ri);
> >>+		return NULL;
> >>+	}
> >>+
> >>+	acpi_pci_root_ops.pci_ops = &ri->cfg->ops->pci_ops;
> >
> >This has already been merged, but this isn't right, is it?  We're
> >writing a host controller-specific pointer into the single system-wide
> >acpi_pci_root_ops, then passing it on to acpi_pci_root_create().
> >
> >Today, I think ri->cfg->ops->pci_ops is always &pci_generic_ecam_ops,
> >from this path:
> >
> >  ri->cfg = pci_acpi_setup_ecam_mapping
> >    cfg = pci_ecam_create(..., &pci_generic_ecam_ops)
> >      cfg = kzalloc(...)
> >      cfg->ops = ops             # &pci_generic_ecam_ops
> >
> >But we're about to merge the ECAM quirks series, which will mean it
> >may not be &pci_generic_ecam_ops.  Even apart from the ECAM quirks, we
> >should avoid this pattern of putting device-specific info in a single
> >shared structure because it's too difficult to verify that it's
> >correct.
> >
> 
> Well spotted. I agree, we need to fix this. How about this:
> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> index fb439c7..31c0e1c 100644
> --- a/arch/arm64/kernel/pci.c
> +++ b/arch/arm64/kernel/pci.c
> @@ -152,33 +152,35 @@ static void
> pci_acpi_generic_release_info(struct acpi_pci_root_info *ci)
> 
>         ri = container_of(ci, struct acpi_pci_generic_root_info, common);
>         pci_ecam_free(ri->cfg);
> +       kfree(ci->ops);
>         kfree(ri);
>  }
> 
> -static struct acpi_pci_root_ops acpi_pci_root_ops = {
> -       .release_info = pci_acpi_generic_release_info,
> -};
> -
>  /* Interface called from ACPI code to setup PCI host controller */
>  struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
>  {
>         int node = acpi_get_node(root->device->handle);
>         struct acpi_pci_generic_root_info *ri;
>         struct pci_bus *bus, *child;
> +       struct acpi_pci_root_ops *root_ops;
> 
>         ri = kzalloc_node(sizeof(*ri), GFP_KERNEL, node);
>         if (!ri)
>                 return NULL;
> 
> +       root_ops = kzalloc_node(sizeof(*root_ops), GFP_KERNEL, node);
> +       if (!root_ops)
> +               return NULL;
> +
>         ri->cfg = pci_acpi_setup_ecam_mapping(root);
>         if (!ri->cfg) {
>                 kfree(ri);
> +               kfree(root_ops);
>                 return NULL;
>         }
> 
> -       acpi_pci_root_ops.pci_ops = &ri->cfg->ops->pci_ops;
> -       bus = acpi_pci_root_create(root, &acpi_pci_root_ops, &ri->common,
> -                                  ri->cfg);
> +       root_ops->release_info = pci_acpi_generic_release_info;
> +       root_ops->pci_ops = &ri->cfg->ops->pci_ops;
> +       bus = acpi_pci_root_create(root, root_ops, &ri->common, ri->cfg);
>         if (!bus)
>                 return NULL;
> 
> Of course, this should be the part of ECAM quirks core patches.
> 
> The other option we have is to remove "struct pci_ops *pci_ops;"
> from acpi_pci_root_ops structure and pass struct pci_ops as an extra
> argument to acpi_pci_root_create(). What do you think?

I think your patch above is fine and avoids the need to change the x86 and
ia64 code.  Would you mind packaging this up with a changelog and
signed-off-by?  I can take care of putting it in the ECAM series.

Thanks,
  Bjorn
