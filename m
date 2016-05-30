Return-Path: <arnd@arndb.de>
Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Tomasz Nowicki <tn@semihalf.com>
Cc: helgaas@kernel.org, will.deacon@arm.com, catalin.marinas@arm.com, rafael@kernel.org, hanjun.guo@linaro.org, Lorenzo.Pieralisi@arm.com, okaya@codeaurora.org, jchandra@broadcom.com, robert.richter@caviumnetworks.com, mw@semihalf.com, Liviu.Dudau@arm.com, ddaney@caviumnetworks.com, wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com, msalter@redhat.com, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, jcm@redhat.com, andrea.gallo@linaro.org, dhdang@apm.com, jeremy.linton@arm.com, liudongdong3@huawei.com, cov@codeaurora.org
Subject: Re: [PATCH V8 9/9] pci, acpi: ARM64 support for ACPI based generic PCI host controller
Date: Mon, 30 May 2016 17:38:13 +0200
Message-ID: <8385994.W7ve9PrvHG@wuerfel>
In-Reply-To: <1464621262-26770-10-git-send-email-tn@semihalf.com>
References: <1464621262-26770-1-git-send-email-tn@semihalf.com> <1464621262-26770-10-git-send-email-tn@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pci.vger.kernel.org>

On Monday, May 30, 2016 5:14:22 PM CEST Tomasz Nowicki wrote:
> +       bsz = 1 << pci_generic_ecam_ops.bus_shift;
> +       cfgres.start = root->mcfg_addr + bus_res->start * bsz;
> +       cfgres.end = cfgres.start + resource_size(bus_res) * bsz - 1;
> +       cfgres.flags = IORESOURCE_MEM;
> +       cfg = pci_ecam_create(&root->device->dev, &cfgres, bus_res,
> +                             &pci_generic_ecam_ops);
> +       if (IS_ERR(cfg)) {
> +               pr_err("%04x:%pR error %ld mapping CAM\n", seg, bus_res,
> +                      PTR_ERR(cfg));
> +               return PTR_ERR(cfg);
> +       }
> +
> +       ri->cfg = cfg;
> +       return 0;
> +}

I wonder if we could do this a little simpler and just put a pointer
to the mmconfig space into struct pci_host_bridge, and then have a trivial
map_bus function alongside pci_generic_config_read/pci_generic_config_write.

As this code is specific to arch/arm64, we don't need any of the complexity
of drivers/pci/ecam.c, which basically only exists to work around the
limited virtual address space of 32-bit machines.

	Arnd
