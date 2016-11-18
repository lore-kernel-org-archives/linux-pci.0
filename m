Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:48888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752366AbcKRBPU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Nov 2016 20:15:20 -0500
Date: Thu, 17 Nov 2016 19:15:15 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH v2 0/9] PCIe port PM: high gloss polish & hotplug support
Message-ID: <20161118011515.GB25762@bhelgaas-glaptop.roam.corp.google.com>
References: <cover.1477611126.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1477611126.git.lukas@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 28, 2016 at 10:52:06AM +0200, Lukas Wunner wrote:
> Respin of this series to polish the runtime PM support for PCIe ports
> that was added with v4.8, and extend it to native hotplug ports:
> 
> - All patches have been reviewed by Rafael, patches 1 to 8 have been
>   tested by Mika.  (Thanks a lot!)
> 
> - Patch 6 ("PCI: Unfold conditions to block runtime PM on PCIe ports")
>   contains a minor change relative to v1 wherein the function returns
>   as soon as a single condition evaluates to true.  (Instead of
>   needlessly evaluating all the remaining conditions.)
> 
> - Patch 9 was rebased to accommodate to this change but is otherwise
>   the same as before.
> 
> As usual I've pushed the series to GitHub to ease reviewing/fetching:
> https://github.com/l1k/linux/commits/pcie_port_pm_v2
> 
> Link to v1:
> http://www.spinics.net/lists/linux-pci/msg55347.html
> 
> Thanks,
> 
> Lukas
> 
> 
> Lukas Wunner (9):
>   PCI: Don't acquire ref on parent in pci_bridge_d3_update()
>   PCI: Autosense device removal in pci_bridge_d3_update()
>   PCI: Speed up algorithm in pci_bridge_d3_update()
>   PCI: Activate runtime PM on a PCIe port only if it can suspend
>   PCI: Consolidate conditions to allow runtime PM on PCIe ports
>   PCI: Unfold conditions to block runtime PM on PCIe ports
>   ACPI / hotplug / PCI: Use cached copy of PCI_EXP_SLTCAP_HPC bit
>   ACPI / hotplug / PCI: Make device_is_managed_by_native_pciehp() public
>   PCI: pciehp: Add runtime PM support for PCIe hotplug ports
> 
>  drivers/pci/bus.c                  |   2 +-
>  drivers/pci/hotplug/acpiphp_glue.c |  31 +-----------
>  drivers/pci/hotplug/pciehp_ctrl.c  |   6 +++
>  drivers/pci/pci-acpi.c             |  24 +++++++++
>  drivers/pci/pci.c                  | 100 ++++++++++++++++++-------------------
>  drivers/pci/pci.h                  |   4 +-
>  drivers/pci/pcie/portdrv_pci.c     |  13 ++---
>  drivers/pci/remove.c               |   2 +-
>  include/linux/pci_hotplug.h        |   2 +
>  9 files changed, 88 insertions(+), 96 deletions(-)

I applied these to pci/pm for v4.10, thanks!

I did make two changes to the changelog of the last patch: you
mentioned the "subordinate" bus, and I changed it to "secondary".  We
have often used "subordinate" to refer to the immediately-downstream
bus, but that's slightly confusing because in the bridge spec,
"subordinate" means the highest bus number downstream from the bridge,
while "secondary" refers to the immediately-downstream bridge.  Am I
making sense or confusing things more?

Bjorn
