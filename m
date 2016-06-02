Return-Path: <arnd@arndb.de>
Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Tomasz Nowicki <tn@semihalf.com>
Cc: helgaas@kernel.org, will.deacon@arm.com, catalin.marinas@arm.com, rafael@kernel.org, hanjun.guo@linaro.org, Lorenzo.Pieralisi@arm.com, okaya@codeaurora.org, jchandra@broadcom.com, robert.richter@caviumnetworks.com, mw@semihalf.com, Liviu.Dudau@arm.com, ddaney@caviumnetworks.com, wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com, msalter@redhat.com, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, jcm@redhat.com, andrea.gallo@linaro.org, dhdang@apm.com, jeremy.linton@arm.com, liudongdong3@huawei.com, cov@codeaurora.org
Subject: Re: [RFC PATCH 1/3] pci, acpi: Match PCI config space accessors against platfrom specific ECAM quirks.
Date: Thu, 02 Jun 2016 13:42:43 +0200
Message-ID: <4347711.qDrKz2s8lr@wuerfel>
In-Reply-To: <1464856864-18049-2-git-send-email-tn@semihalf.com>
References: <1464856864-18049-1-git-send-email-tn@semihalf.com> <1464856864-18049-2-git-send-email-tn@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pci.vger.kernel.org>

On Thursday, June 2, 2016 10:41:01 AM CEST Tomasz Nowicki wrote:
> +struct pci_ecam_ops *pci_mcfg_get_ops(struct acpi_pci_root *root)
> +{
> +       int bus_num = root->secondary.start;
> +       int domain = root->segment;
> +       struct pci_cfg_fixup *f;
> +
> +       if (!mcfg_table)
> +               return &pci_generic_ecam_ops;
> +
> +       /*
> +        * Match against platform specific quirks and return corresponding
> +        * CAM ops.
> +        *
> +        * First match against PCI topology <domain:bus> then use OEM ID and
> +        * OEM revision from MCFG table standard header.
> +        */
> +       for (f = __start_acpi_mcfg_fixups; f < __end_acpi_mcfg_fixups; f++) {
> +               if ((f->domain == domain || f->domain == PCI_MCFG_DOMAIN_ANY) &&
> +                   (f->bus_num == bus_num || f->bus_num == PCI_MCFG_BUS_ANY) &&
> +                   (!strncmp(f->oem_id, mcfg_table->header.oem_id,
> +                             ACPI_OEM_ID_SIZE)) &&
> +                   (f->oem_revision == mcfg_table->header.oem_revision))
> +                       return f->ops;
> +       }
> +       /* No quirks, use ECAM */
> +       return &pci_generic_ecam_ops;
> +}
> +
>  int pci_mcfg_lookup(struct acpi_pci_root *root)

Can you explain the use of pci_ecam_ops instead of pci_ops here?

I was hoping we'd be able to fold all of pci-ecam code into the
generic PCI layer at some point and get rid of pci_ecam_ops in the
process.

	Arnd
