Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:50201 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757599Ab2IYQYR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 25 Sep 2012 12:24:17 -0400
Received: by lbon3 with SMTP id n3so382233lbo.19
        for <linux-pci@vger.kernel.org>; Tue, 25 Sep 2012 09:24:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1348561590-28067-1-git-send-email-yinghai@kernel.org>
References: <1348561590-28067-1-git-send-email-yinghai@kernel.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 25 Sep 2012 10:23:55 -0600
Message-ID: <CAErSpo5Arj=rh4mZJk3tEsaWKBFqxK6tAu1N5SKn2Cq=vTj+bw@mail.gmail.com>
Subject: Re: [PATCH 00/29] PCI: use pci host bridge to loop pci root bus
To: Yinghai Lu <yinghai@kernel.org>
Cc: Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 25, 2012 at 2:26 AM, Yinghai Lu <yinghai@kernel.org> wrote:
> could remove pci_root_buses list.
>
> Yinghai Lu (29):
>   PCI, x86: Separate out pcibios_allocate_bridge_resources()
>   PCI. x86: Separate out pcibios_allocate_dev_resources()
>   PCI, x86: Let pcibios_allocate_bus_resources() take bus instead
>   PCI, x86: Separate out rom resource claim
>   PCI: rename pci_release_bus_bridge_dev to pci_release_host_bridge_dev
>   PCI: Add dummy bus_type for pci_host_bridge
>   PCI, ACPI: add acpi_bus_type for host bridge
>   PCI, ACPI: Remove acpi_find_bridge_device for acpi_bus_type
>   PCI, libata: remove find_bridge in acpi_bus_type
>   PCI, USB: remove find_bridge in acpi_bus_type
>   PCI, ACPI: remove find_bridge in acpi_bus_type
>   PCI: Add for_each_pci_host_bridge() and pci_get_next_host_bridge

I'm not thrilled about adding a new iterator for all host bridges.

The iterator design pattern does not work for collections that can
change over time.  In this case, it looks like you're adding a safer
way to iterate through all host bridges we know about at this time.
But we still have the problem of the host bridge that's added
tomorrow.

I'd prefer a design where the PCI core provides an interface that
means "call this function for every host bridge we know about now
*and* for every one that's added in the future."

>   PCI, hotplug: kill pci_find_next_bus n sgi_hotplug
>   PCI: kill pci_find_next_bus in pci_sysfs
>   PCI, edac: kill pci_find_next_bus in edac
>   PCI, x86: kill pci_find_next_bus in pcibios_scan_root
>   PCI, x86: kill pci_root_buses in resources reservations
>   PCI, drm: kill pci_root_buses in alpha hose setting
>   PCI: kill pci_root_buses in setup-bus
>   PCI, sparc: kill pci_find_next_bus
>   PCI, ia64: kill pci_find_next_bus
>   PCI, alpha: kill pci_root_buses
>   PCI, arm: kill pci_root_buses
>   PCI, frv: kill pci_root_buses in resources reservations
>   PCI, microblaze: kill pci_root_buses in resources reservations
>   PCI, mn10300: kill pci_root_buses in resources reservations
>   PCI, powerpc: kill pci_root_buses in resources reservations
>   PCI: kill pci_find_next_bus
>   PCI: kill pci_root_buses
>
>  arch/alpha/kernel/pci.c                 |    6 +-
>  arch/arm/kernel/bios32.c                |    9 +-
>  arch/frv/mb93090-mb00/pci-frv.c         |   37 ++++---
>  arch/ia64/hp/common/sba_iommu.c         |    7 +-
>  arch/ia64/sn/kernel/io_common.c         |    5 +-
>  arch/microblaze/pci/pci-common.c        |   10 +-
>  arch/mn10300/unit-asb2305/pci-asb2305.c |   62 ++++++------
>  arch/powerpc/kernel/pci-common.c        |   13 +--
>  arch/powerpc/kernel/pci_64.c            |    7 +-
>  arch/sparc/kernel/pci.c                 |    6 +-
>  arch/x86/pci/common.c                   |    9 +-
>  arch/x86/pci/i386.c                     |  162 +++++++++++++++++++------------
>  drivers/acpi/glue.c                     |   22 +----
>  drivers/ata/libata-acpi.c               |    6 -
>  drivers/edac/i7core_edac.c              |    6 +-
>  drivers/gpu/drm/drm_fops.c              |   10 ++-
>  drivers/pci/hotplug/sgi_hotplug.c       |    6 +-
>  drivers/pci/pci-acpi.c                  |   13 ++-
>  drivers/pci/pci-driver.c                |   11 ++-
>  drivers/pci/pci-sysfs.c                 |    6 +-
>  drivers/pci/probe.c                     |   13 +--
>  drivers/pci/search.c                    |   60 ++++++------
>  drivers/pci/setup-bus.c                 |   24 +++--
>  drivers/usb/core/usb-acpi.c             |    1 -
>  include/acpi/acpi_bus.h                 |    2 -
>  include/linux/pci.h                     |   11 +--
>  26 files changed, 281 insertions(+), 243 deletions(-)
>
> --
> 1.7.7
>
