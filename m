Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:26241 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750877AbeBZPZO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 26 Feb 2018 10:25:14 -0500
Message-ID: <1519658167.10722.188.camel@linux.intel.com>
Subject: Re: [PATCH v3 0/5] PCI: Fixes for native PCIe and ACPI hotplug
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, Mario.Limonciello@dell.com,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <yehezkel.bernat@intel.com>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Date: Mon, 26 Feb 2018 17:16:07 +0200
In-Reply-To: <20180226132112.81447-1-mika.westerberg@linux.intel.com>
References: <20180226132112.81447-1-mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 2018-02-26 at 16:21 +0300, Mika Westerberg wrote:
> Hi,
> 
> When Thunderbolt controller is configured to be in native enumeration
> mode
> it actually includes two slightly different modes. First there is non-
> RTD3
> mode where the Thunderbolt host controller is only present when there
> is a
> device connected. The second one is RTD3 mode where the controller is
> always present.
> 
> In non-RTD3 mode the Thunderbolt host controller (NHI) and USB host
> (xHCI)
> controller are not hotplugged using native PCIe hotplug but instead
> they
> will be hotplugged via BIOS triggered ACPI Notify() to the root port.
> This
> is done to preserve resources since the NHI and xHCI only need 1 MB of
> MMIO
> space and no additional buses. Currently Linux does not support this
> very
> well and ends up failing the hotplug in one way or another. More
> detailed
> explanation is in changelog of patch [4/5].
> 
> This series fixes this issue and in addition includes fixes for few
> other
> issues found during testing on a system that has Thunderbolt
> controller in
> non-RTD3 native PCIe enumeration mode. However, the fixes here are not
> in
> any way Thunderbolt specific and should be applicable to other systems
> as
> well.
> 

FWIW, 
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> The previous versions of the patch series can be found here:
> 
>   v2: https://www.spinics.net/lists/linux-pci/msg69186.html
>   v1: https://www.spinics.net/lists/linux-acpi/msg80607.html
> 
> Changes from v2:
> 
>   - Added Rafael's tag to patch [1/5].
>   - Updated changelog of patch [1/5] to include more details about how
> the
>     problem can be observed from dmesg and lspci output.
> 
> Changes from v1:
> 
>   - Drop 'cmax - max ?: 1' and use similar construct than we use in
> second
>     pass loop in patch [1/5].
>   - Drop unnecessary parentheses in patch [1/5].
>   - Added Rafael's tag to patches [2-5/5].
> 
> Mika Westerberg (5):
>   PCI: Make sure all bridges reserve at least one bus number
>   PCI: Take bridge window alignment into account when distributing
> resources
>   PCI: pciehp: Clear Presence Detect and Data Link Layer Status
> Changed on resume
>   ACPI / hotplug / PCI: Do not scan all bridges when native PCIe
> hotplug is used
>   ACPI / hotplug / PCI: Mark stale PCI devices disconnected
> 
>  drivers/pci/hotplug/acpiphp.h      |  1 +
>  drivers/pci/hotplug/acpiphp_glue.c | 78
> ++++++++++++++++++++++++++++++--------
>  drivers/pci/hotplug/pciehp.h       |  2 +-
>  drivers/pci/hotplug/pciehp_core.c  |  2 +-
>  drivers/pci/hotplug/pciehp_hpc.c   | 13 ++++++-
>  drivers/pci/probe.c                | 11 ++++--
>  drivers/pci/setup-bus.c            | 41 +++++++++++++++++++-
>  7 files changed, 126 insertions(+), 22 deletions(-)
> 

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
