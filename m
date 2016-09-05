Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Sun, 4 Sep 2016 21:59:08 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Tomasz Nowicki <tn@semihalf.com>
Subject: Re: [RFC PATCH V5 3/5] PCI: Check platform specific ECAM quirks
Message-ID: <20160905025908.GG30488@localhost>
References: <1470661541-26270-1-git-send-email-tn@semihalf.com>
 <1470661541-26270-4-git-send-email-tn@semihalf.com>
MIME-Version: 1.0
In-Reply-To: <1470661541-26270-4-git-send-email-tn@semihalf.com>
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

On Mon, Aug 08, 2016 at 03:05:39PM +0200, Tomasz Nowicki wrote:
> Some platforms may not be fully compliant with generic set of PCI config
> accessors. For these cases we implement the way to overwrite accessors
> set. Algorithm traverses available quirk list (static array),
> matches against <oem_id, oem_table_id, rev, domain, bus number range> and
> returns pci_config_window structure with fancy PCI config ops.
> oem_id, oem_table_id and rev come from MCFG table standard header.
> 
> It is possible to define custom init call which is responsible for
> setting up PCI configuration access accordingly to quirk requirements.
> If custom init call is not defined, use standard pci_acpi_setup_ecam_mapping().
> 
> pci_generic_ecam_ops will be used for platforms free from quirks.
> 
> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
> Signed-off-by: Christopher Covington <cov@codeaurora.org>
> ---
>  drivers/pci/host/Makefile      |  1 +
>  drivers/pci/host/mcfg-quirks.c | 86 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/pci/host/mcfg-quirks.h | 20 ++++++++++
>  include/linux/pci-acpi.h       |  2 +
>  4 files changed, 109 insertions(+)
>  create mode 100644 drivers/pci/host/mcfg-quirks.c
>  create mode 100644 drivers/pci/host/mcfg-quirks.h
> 
> diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
> index 8843410..500cf78 100644
> --- a/drivers/pci/host/Makefile
> +++ b/drivers/pci/host/Makefile
> @@ -31,3 +31,4 @@ obj-$(CONFIG_PCI_HOST_THUNDER_ECAM) += pci-thunder-ecam.o
>  obj-$(CONFIG_PCI_HOST_THUNDER_PEM) += pci-thunder-pem.o
>  obj-$(CONFIG_PCIE_ARMADA_8K) += pcie-armada8k.o
>  obj-$(CONFIG_PCIE_ARTPEC6) += pcie-artpec6.o
> +obj-$(CONFIG_ACPI_MCFG) += mcfg-quirks.o
> diff --git a/drivers/pci/host/mcfg-quirks.c b/drivers/pci/host/mcfg-quirks.c
> new file mode 100644
> index 0000000..aa9907b
> --- /dev/null
> +++ b/drivers/pci/host/mcfg-quirks.c
> @@ -0,0 +1,86 @@
> +/*
> + * Copyright (C) 2016 Semihalf
> + *	Author: Tomasz Nowicki <tn@semihalf.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License, version 2, as
> + * published by the Free Software Foundation (the "GPL").
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License version 2 (GPLv2) for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * version 2 (GPLv2) along with this source code.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/ioport.h>
> +#include <linux/pci.h>
> +#include <linux/pci-acpi.h>
> +#include <linux/pci-ecam.h>
> +
> +#include "mcfg-quirks.h"
> +
> +struct pci_cfg_fixup {
> +	char oem_id[ACPI_OEM_ID_SIZE + 1];
> +	char oem_table_id[ACPI_OEM_TABLE_ID_SIZE + 1];
> +	u32 oem_revision;
> +	struct resource domain_range;
> +	struct resource bus_range;
> +	struct pci_ops *ops;
> +	struct pci_config_window *(*init)(struct acpi_pci_root *root,
> +					  struct pci_ops *ops);
> +};
> +
> +#define MCFG_DOM_RANGE(start, end)	DEFINE_RES_NAMED((start),	\
> +						((end) - (start) + 1), NULL, 0)
> +#define MCFG_DOM_ANY			MCFG_DOM_RANGE(0x0, 0xffff)
> +#define MCFG_BUS_RANGE(start, end)	DEFINE_RES_NAMED((start),	\
> +						((end) - (start) + 1),	\
> +						NULL, IORESOURCE_BUS)
> +#define MCFG_BUS_ANY			MCFG_BUS_RANGE(0x0, 0xff)
> +
> +static struct pci_cfg_fixup mcfg_quirks[] __initconst = {
> +/*	{ OEM_ID, OEM_TABLE_ID, REV, DOMAIN, BUS_RANGE, pci_ops, init_hook }, */
> +};
> +
> +static bool pci_mcfg_fixup_match(struct pci_cfg_fixup *f,
> +				 struct acpi_table_header *mcfg_header)
> +{
> +	return (!memcmp(f->oem_id, mcfg_header->oem_id, ACPI_OEM_ID_SIZE) &&
> +		!memcmp(f->oem_table_id, mcfg_header->oem_table_id,
> +			ACPI_OEM_TABLE_ID_SIZE) &&
> +		f->oem_revision == mcfg_header->oem_revision);
> +}
> +
> +struct pci_config_window *pci_mcfg_match_quirks(struct acpi_pci_root *root)
> +{
> +	struct resource dom_res = MCFG_DOM_RANGE(root->segment, root->segment);
> +	struct resource *bus_res = &root->secondary;
> +	struct pci_cfg_fixup *f = mcfg_quirks;
> +	struct acpi_table_header *mcfg_header;
> +	acpi_status status;
> +	int i;
> +
> +	status = acpi_get_table(ACPI_SIG_MCFG, 0, &mcfg_header);
> +	if (ACPI_FAILURE(status))
> +		return NULL;

I remember working out why pci_mcfg_parse() has to cache the data from
MCFG, but I don't remember the actual reason...  a comment there would
have been helpful.  Anyway, now I wonder why it's OK to call
acpi_get_table(ACPI_SIG_MCFG) again here.  I guess I'd be inclined to
just cache the OEM info along with the rest of the data so you don't
have to get the table again here.

> +	/*
> +	 * First match against PCI topology <domain:bus> then use OEM ID, OEM
> +	 * table ID, and OEM revision from MCFG table standard header.
> +	 */
> +	for (i = 0; i < ARRAY_SIZE(mcfg_quirks); i++, f++) {
> +		if (resource_contains(&f->domain_range, &dom_res) &&
> +		    resource_contains(&f->bus_range, bus_res) &&
> +		    pci_mcfg_fixup_match(f, mcfg_header)) {
> +			dev_info(&root->device->dev, "Applying PCI MCFG quirks for %s %s rev: %d\n",
> +				 f->oem_id, f->oem_table_id, f->oem_revision);
> +			return f->init ? f->init(root, f->ops) :
> +				pci_acpi_setup_ecam_mapping(root, f->ops);
> +		}
> +	}
> +	return pci_acpi_setup_ecam_mapping(root, &pci_generic_ecam_ops.pci_ops);

I think the scope of these MCFG quirks is to:

  1) Override (or even fabricate) a MEM resource to be used as ECAM
     space, and

  2) Supply a pci_ecam_ops structure if we need something other than
     pci_generic_ecam_ops

Today, pci_mcfg_lookup() merely returns a physical address.  I didn't
chase down where (or whether) that is turned into a struct resource
that we put in the iomem tree.  I wonder if pci_mcfg_lookup() could be
extended to return a resource and a pci_ecam_ops pointer, and handle
the quirk application internally, e.g.,

  int pci_mcfg_lookup(u16 seg, struct resource *bus_res,
                      struct resource *cfgres, struct pci_ecam_ops **ecam_ops)
  {
    struct resource res;
    struct pci_ecam_ops *ops;
    struct mcfg_entry *e;

    memset(&res, 0, sizeof(res));
    res.flags = IORESOURCE_MEM;

    e = pci_mcfg_list_search(seg, bus_res);
    if (e) {
      res.start = e->addr;
      res.end = res.start + ...;
    }

    ops = &pci_generic_ecam_ops;
    ret = pci_mcfg_match_quirks(seg, bus_res, &res, &ops);
    if (ret)
      return ret;

    *cfgres = res;
    *ecam_ops = ops;
    return 0;
  }

Then the quirks would see any mem resource we discovered via MCFG, and
they would see the default pci_ecam_ops, and they could override
whatever they needed to.

That would make pci_acpi_setup_ecam_mapping() look something like this:

  pci_acpi_setup_ecam_mapping(struct acpi_pci_root *root)
  {
    struct resource cfgres;
    struct pci_ecam_ops *ecam_ops;

    ret = pci_mcfg_lookup(root->segment, &root->secondary, &cfgres, &ecam_ops);
    if (ret) {
      dev_err(..., "ECAM region not found\n");
      return ret;
    }

    cfg = pci_ecam_create(&root->device->dev, &cfgres, bus_res,
                          ecam_ops);
  }

> +}
> diff --git a/drivers/pci/host/mcfg-quirks.h b/drivers/pci/host/mcfg-quirks.h
> new file mode 100644
> index 0000000..45cbd16
> --- /dev/null
> +++ b/drivers/pci/host/mcfg-quirks.h
> @@ -0,0 +1,20 @@
> +/*
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License, version 2, as
> + * published by the Free Software Foundation (the "GPL").
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License version 2 (GPLv2) for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * version 2 (GPLv2) along with this source code.
> + */
> +
> +#ifndef __MCFG_QUIRKS_H__
> +#define __MCFG_QUIRKS_H__
> +
> +/* MCFG quirks initialize call list */
> +
> +#endif /* __MCFG_QUIRKS_H__ */
> diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
> index e9bfe00..28cdce4 100644
> --- a/include/linux/pci-acpi.h
> +++ b/include/linux/pci-acpi.h
> @@ -25,6 +25,8 @@ static inline acpi_status pci_acpi_remove_pm_notifier(struct acpi_device *dev)
>  extern phys_addr_t acpi_pci_root_get_mcfg_addr(acpi_handle handle);
>  
>  extern phys_addr_t pci_mcfg_lookup(u16 domain, struct resource *bus_res);
> +extern struct pci_config_window *
> +pci_mcfg_match_quirks(struct acpi_pci_root *root);
>  
>  extern struct pci_config_window *
>  pci_acpi_setup_ecam_mapping(struct acpi_pci_root *root, struct pci_ops *ops);
> -- 
> 1.9.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
