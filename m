Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752418AbdJTVhf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Oct 2017 17:37:35 -0400
Date: Fri, 20 Oct 2017 16:37:32 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <yehezkel.bernat@intel.com>,
        Mario.Limonciello@dell.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/8] PCI: Improvements for native PCIe hotplug
Message-ID: <20171020213732.GS6332@bhelgaas-glaptop.roam.corp.google.com>
References: <20171013183548.68283-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171013183548.68283-1-mika.westerberg@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 13, 2017 at 09:35:40PM +0300, Mika Westerberg wrote:
> Currently when plugging PCIe device using native PCIe hotplug Linux PCI
> core tries to allocate bus space and resources so that the newly enumerated
> topology barely fits there. Now, if the PCIe topology that was just plugged
> in has more PCIe hotplug ports we will run out of bus space and resources
> pretty quickly. There is a workaround for this by passing pci=hpbussize=N
> in the kernel command line but it runs to the same situation after next
> hotplug.
> 
> A good example where this is a problem is Thunderbolt where each
> Thunderbolt device includes PCIe switch and the topology can be extended up
> to 6 chained devices.
> 
> Future platforms will move from BIOS assisted (ACPI) hotplug from native
> PCIe hotplug because then it is possible to power down PCIe hotplug ports
> without confusing the SMI handler which is not necessary when native PCIe
> hotplug is used. Also Apple Macs have been using native PCIe hotplug from
> the beginning. Windows already knows how to handle these complex PCIe
> topologies and we will reuse the same knowledge in Linux with this patch
> series.
> 
> The idea is to distribute available bus space and resources to hotplug PCIe
> downstream ports so that the PCIe chain can be extended from those points.
> The initial available space is configured by the BIOS to the root port in
> question.
> 
> This series first teaches the Linux PCI core to distribute available bus
> space and resources if PCIe hotplug is used. Then following are fixes for
> issues found while testing.
> 
> With this series applied I can connect the maximum length Thunderbolt PCIe
> chain (6 devices) to a Macbook Pro as can be seen from the 'lspci -t'
> output below:
> 
> -[0000:00]-+-00.0
>            +-02.0
>            +-14.0
>            +-16.0
>            +-19.0
>            +-1c.0-[01]----00.0
>            +-1c.4-[03-78]----00.0-[04-78]--+-00.0-[05]----00.0
>            |                               +-01.0-[07-3f]----00.0-[08-3f]--+-01.0-[09]----00.0
>            |                               |                               \-04.0-[0a-3f]----00.0-[0b-3f]--+-01.0-[0c]----00.0
>            |                               |                                                               \-04.0-[0d-3f]----00.0-[0e-3f]--+-01.0-[0f]--
>            |                               |                                                                                               \-04.0-[10-3f]----00.0-[11-3f]--+-01.0-[12]----00.0
>            |                               |                                                                                                                               \-04.0-[13-3f]----00.0-[14-3f]--+-01.0-[15]----00.0
>            |                               |                                                                                                                                                               \-04.0-[16-3f]----00.0-[17-3f]----00.0-[18-3f]----00.0
>            |                               +-02.0-[06]----00.0
>            |                               \-04.0-[40-78]--
>            +-1d.0-[79-ee]----00.0-[7a-ee]--+-00.0-[7b]----00.0
>            |                               +-01.0-[7d-b5]--
>            |                               +-02.0-[7c]----00.0
>            |                               \-04.0-[b6-ee]--
>            +-1d.3-[02]----00.0
>            +-1e.0
>            +-1e.1
>            +-1e.3
>            +-1f.0
>            +-1f.2
>            +-1f.3
>            \-1f.4
> 
> The previous version (v1) of the patch series can be found here:
> 
>   https://www.spinics.net/lists/linux-pci/msg64841.html
> 
> Changes from v1:
> 
>   * Rebase on top of Andy's for_each_pci_bridge() patch
>   * Move pci_hp_add_bridge() to drivers/pci/probe.c
>   * Split open-coding of the two pass scan loop into a separate patch
>   * Drop [PATCH 2/7] PCI: Introduce pcie_upstream_port()
>   * Keep pci_scan_bridge_extend() and pci_scan_child_bus_extend() internal
>     to drivers/pci/probe.c
>   * Add another separate loop to count number of hotplug and normal bridges
>   * Reword comment about two scans
>   * Generalize patches 4 and 5 so that they could work also on conventional
>     PCI by dropping tests for PCIe.
> 
> Mika Westerberg (8):
>   PCI: Move pci_hp_add_bridge() to drivers/pci/probe.c
>   PCI: Open-code the two pass loop when scanning bridges
>   PCI: Do not allocate more buses than available in parent
>   PCI: Distribute available buses to hotplug capable bridges
>   PCI: Distribute available resources to hotplug capable bridges
>   PCI: pciehp: Fix race condition handling surprise link down
>   PCI: pciehp: Do not clear Presence Detect Changed during initialization
>   PCI: pciehp: Check that the device is really present before touching it
> 
>  drivers/pci/Makefile              |   3 -
>  drivers/pci/hotplug-pci.c         |  29 ------
>  drivers/pci/hotplug/pciehp_ctrl.c |   7 +-
>  drivers/pci/hotplug/pciehp_hpc.c  |  13 ++-
>  drivers/pci/hotplug/pciehp_pci.c  |  18 +++-
>  drivers/pci/probe.c               | 188 +++++++++++++++++++++++++++++++++++---
>  drivers/pci/setup-bus.c           | 177 +++++++++++++++++++++++++++++++++++
>  7 files changed, 379 insertions(+), 56 deletions(-)
>  delete mode 100644 drivers/pci/hotplug-pci.c

Looks very nice!

I applied all but the last patch ("Check that the device is really
present") on pci/hotplug for v4.15, thanks!
