Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Cc: bhelgaas@google.com, lenb@kernel.org, catalin.marinas@arm.com,
	will.deacon@arm.com, hanjun.guo@linaro.org,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V3 0/4] PCI: ACPI: Setting up DMA coherency for PCI device from _CCA attribute
Date: Wed, 09 Sep 2015 22:38:50 +0200
Message-ID: <8172790.rR5Ld4j83C@vostro.rjw.lan>
In-Reply-To: <55F02331.2060001@amd.com>
References: <1440597279-11802-1-git-send-email-Suravee.Suthikulpanit@amd.com> <55F02331.2060001@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, September 09, 2015 07:16:49 PM Suthikulpanit, Suravee wrote:
> Hi All,
> 
> Are there any other concerns about this patch series?

I have none, but then it sort of missed the merge window.

I can easily queue it up for the next one unless it is super-urgent,
but in that case I need to know why that's the case.


> On 8/26/2015 8:54 PM, Suravee Suthikulpanit wrote:
> > This patch adds support to setup DMA coherency for PCI device using
> > the ACPI _CCA attribute. According to the ACPI spec, the _CCA attribute
> > is required for ARM64. Therefore, this patch is a pre-req for ACPI PCI
> > support for ARM64 which is currently in development.
> >
> > Also, this should not affect other architectures that does not define
> > CONFIG_ACPI_CCA_REQUIRED, since the default value is coherent.
> >
> > I have included the following patch from Jeremy before cleaning up
> > the acpi_check_dma() function (in patch 2).
> >
> >      http://www.spinics.net/lists/linux-usb/msg128582.html)
> >
> > Changes from V2: (https://lkml.org/lkml/2015/8/25/549)
> >      * Return -ENOSUPP instead of -1 (per Rafael's suggestion)
> >      * Add WARN() when fail to setup DMA for PCI device when booting
> >        ACPI (per Arnd's suggestion)
> >      * Added Acked-by from Rob.
> >      * Minor clean up
> >
> > Changes from V1: (https://lkml.org/lkml/2015/8/13/182)
> >      * Include patch 1 from Jeremy to enable support for _CCA=0
> >      * Clean up acpi_check_dma() per Bjorn suggestions
> >      * Split the original V1 patch into two patches (patch 3 and 4)
> >
> >
> > Jeremy Linton (1):
> >    Honor ACPI _CCA attribute setting
> >
> > Suravee Suthikulpanit (3):
> >    ACPI/scan: Clean up acpi_check_dma
> >    PCI: OF: Move of_pci_dma_configure() to pci_dma_configure()
> >    PCI: ACPI: Add support for PCI device DMA coherency
> >
> >   drivers/acpi/acpi_platform.c |  7 ++++++-
> >   drivers/acpi/glue.c          |  6 +++---
> >   drivers/acpi/scan.c          | 39 +++++++++++++++++++++++++++++++++++++++
> >   drivers/base/property.c      | 10 +++++++---
> >   drivers/of/of_pci.c          | 20 --------------------
> >   drivers/pci/probe.c          | 35 +++++++++++++++++++++++++++++++++--
> >   include/acpi/acpi_bus.h      | 35 ++---------------------------------
> >   include/linux/acpi.h         |  4 ++--
> >   include/linux/of_pci.h       |  3 ---
> >   9 files changed, 92 insertions(+), 67 deletions(-)
> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
