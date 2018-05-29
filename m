Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Tue, 29 May 2018 08:26:17 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Mario.Limonciello@dell.com,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v8 0/7] PCI: Fixes and cleanups for native PCIe, SHPC and
 ACPI hotplug
Message-ID: <20180529132617.GB79098@bhelgaas-glaptop.roam.corp.google.com>
References: <20180528124756.78512-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180528124756.78512-1-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 28, 2018 at 03:47:49PM +0300, Mika Westerberg wrote:
> When Thunderbolt host router is configured to be in native enumeration mode
> it is only present in the system if there is something connected to the
> ports. This pretty much follows how the BIOS assisted mode works.
> 
> In native enumeration mode the Thunderbolt host controller (NHI) and USB
> host controller (xHCI) are not hot-added using native PCIe hotplug but
> instead they will be hotplugged via BIOS triggered ACPI Notify() to the
> root port. This is done to preserve resources since NHI and xHCI only need
> 1 MB of MMIO space and no additional buses. Currently Linux does not
> support this very well and ends up failing the hotplug in one way or
> another. More detailed explanation is in changelog of patch [4/7].
> 
> This series fixes this issue and in addition includes fixes for few other
> issues found during testing on a system that has Thunderbolt controller in
> native PCIe enumeration mode. However, the fixes here are not in any way
> Thunderbolt specific and should be applicable to other systems as well.
> 
> The previous versions of the patch series can be found here:
> 
>   v7: https://www.spinics.net/lists/linux-pci/msg72558.html
>   v6: https://www.spinics.net/lists/linux-pci/msg72267.html
>   v5: https://www.spinics.net/lists/linux-pci/msg71339.html
>   v4: https://www.spinics.net/lists/linux-pci/msg71006.html
>   v3: https://www.spinics.net/lists/linux-acpi/msg80876.html
>   v2: https://www.spinics.net/lists/linux-pci/msg69186.html
>   v1: https://www.spinics.net/lists/linux-acpi/msg80607.html
> 
> Changes from v7:
> 
>   - Rebased on top of pci.git pci/hotplug
>   - Make acpi_get_hp_hw_control_from_firmware() call shpchp_is_native()
>   - Drop !bridge check from shpchp_is_native() and update callers to handle
>     possibly NULL pdev
>   - Split out hotplug_is_native() into a separate patch
> 
> Changes from v6:
> 
>   - Use IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE) and IS_ENABLED(CONFIG_HOTPLUG_PCI_SHPC)
>     directly instaed of wrapping them in macro
>   - Check for !bridge in the same condition than we check whether certain
>     native hotplug is enabled
>   - Add Rafael's Reviewed-by
> 
> Changes from v5:
> 
>   - Dropped patch "PCI: Take bridge window alignment into account when
>     distributing resources"
>   - Rework pciehp_is_native() to be more stricter
>   - Make standard PCI hotplug driver (SHPC) builtin
>   - Rework the way we request OS control of native PCIe
>     hotplug (pciehp) and standard PCI hotplug (SHPC)
>   - Make acpiphp to avoid bridges where hotplug_is_native() returns true
>     (this is combined from pciehp and SHPC)
>   - Updated changelog of patch [7/12]
>   - Use hotplug_bridges + normal_bridges == 1 in patch [9/12] and also
>     remove one indent level from the loop.
> 
> Because patch [7/12] looks quite different now I dropped Reviewed-by and
> stable tag (it now depends on reworked pciehp/SHCP support that most
> probably is not suitable for stable trees).
> 
> I also was not able to test that SHPC really works because I don't have
> hardware that supports it.
> 
> Changes from v4:
> 
>   - Updated message in patch [8/9] following Rafael's suggestion
>   - Added Rafael's tag to patches 6, 7, 9.
> 
> Changes from v3:
> 
>   - Added Andy's tag to patches [1-5]
>   - Improved changelog and subject line of patch [1/9] to match better what
>     it is trying to solve
>   - Improved comment in patch [1/9]
>   - Improved changelog of patches [2/9] and [4/9] accordingly to match
>     better why they are needed
>   - Added cleanup patches [6-9/9]
> 
> Changes from v2:
> 
>   - Added Rafael's tag to patch [1/5]
>   - Updated changelog of patch [1/5] to include more details about how the
>     problem can be observed from dmesg and lspci output
> 
> Changes from v1:
> 
>   - Drop 'cmax - max ?: 1' and use similar construct than we use in second
>     pass loop in patch [1/5]
>   - Drop unnecessary parentheses in patch [1/5]
>   - Added Rafael's tag to patches [2-5/5]
> 
> Mika Westerberg (7):
>   PCI: Take all bridges into account when calculating bus numbers for extension
>   PCI: Introduce shpchp_is_native()
>   PCI: Introduce hotplug_is_native()
>   ACPI / hotplug / PCI: Do not scan all bridges when native PCIe hotplug is used
>   ACPI / hotplug / PCI: Mark stale PCI devices disconnected
>   PCI: Move resource distribution for a single bridge outside of the loop
>   PCI: Document return value of pci_scan_bridge() and pci_scan_bridge_extend()

I only see these on the mailing list and in patchwork:

  [PATCH v8 1/7] PCI: Take all bridges into account when calculating bus numbers for extension
  [PATCH v8 2/7] PCI: Introduce shpchp_is_native()
  [PATCH v8 3/7] PCI: Introduce hotplug_is_native()
  [PATCH v8 6/7] PCI: Move resource distribution for a single bridge outside of the loop
  [PATCH v8 7/7] PCI: Document return value of pci_scan_bridge() and pci_scan_bridge_extend()

Looks like patches 4 and 5 are missing for some reason.
