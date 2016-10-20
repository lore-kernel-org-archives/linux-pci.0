Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35019 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755885AbcJTXV2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Oct 2016 19:21:28 -0400
MIME-Version: 1.0
In-Reply-To: <cover.1476875113.git.lukas@wunner.de>
References: <cover.1476875113.git.lukas@wunner.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 21 Oct 2016 01:21:25 +0200
Message-ID: <CAJZ5v0hPRxpXJY9jhO6hO_WSnMfgs-QNMha+AfjeGH-LjUD46Q@mail.gmail.com>
Subject: Re: [PATCH 0/9] PCIe port PM: high gloss polish & hotplug support
To: Lukas Wunner <lukas@wunner.de>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Keith Busch <keith.busch@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 19, 2016 at 4:07 PM, Lukas Wunner <lukas@wunner.de> wrote:
> Linux v4.8 added support to runtime suspend PCIe ports to D3hot.
>
> Patches 1 to 6 of this series apply high gloss polish to that code to
> speed it up, reduce its size and improve its readability.  None of these
> patches should result in a functional change.  (And they didn't in my
> tests.)
>
> Patches 7 and 8 are cleanups / refactorings for acpiphp.  They're prep
> work for patch 9 and likewise shouldn't cause a functional change.
>
> Patch 9 extends runtime PM support to hotplug ports.
>
>
> @Keith Busch: I seem to recall you're working with large arrays of NVMe
> drives connected to native PCIe hotplug ports.  Perhaps you could give
> this series a spin, it might save quite a bit of power.
>
> To ease reviewing I've pushed this series to GitHub:
> https://github.com/l1k/linux/commits/pcie_port_pm_v1
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

For the whole series:

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

and I'm assuming that it will go in through the PCI tree.

Thanks,
Rafael
