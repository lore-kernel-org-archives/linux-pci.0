Return-Path: <SRS0=xn0A=IM=linux.intel.com=mika.westerberg@kernel.org>
Return-Path: <SRS0=xn0A=IM=linux.intel.com=mika.westerberg@kernel.org>
Date: Fri, 25 May 2018 09:07:45 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Len Brown <lenb@kernel.org>, Mario.Limonciello@dell.com,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH v6 00/12] PCI: Fixes and cleanups for native PCIe, SHPC
 and ACPI hotplug
Message-ID: <20180525060745.GY15419@lahna.fi.intel.com>
References: <20180510182844.77349-1-mika.westerberg@linux.intel.com>
 <20180524183005.GD95348@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180524183005.GD95348@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 24, 2018 at 01:30:05PM -0500, Bjorn Helgaas wrote:
> I applied the following to pci/hotplug for v4.18:
> 
>   PCI: pciehp: Clear Presence Detect and Data Link Layer Status Changed on resume
>   PCI: Request control of native PCIe hotplug only if supported
>   PCI: Rename host->native_hotplug to host->native_pcie_hotplug
>   PCI: hotplug: Make pciehp_is_native() stricter
>   PCI: hotplug: Convert SHPC to be builtin only
>   PCI: shpchp: Simplify acpi_get_hp_hw_control_from_firmware()
>   PCI: shpchp: Request control of native SHPC hotplug via _OSC
>   PCI: Improve "partially hidden behind bridge" log message
>   ACPI / hotplug / PCI: Drop unnecessary parentheses
> 
> I split a couple of these into smaller pieces and removed one NULL
> pointer check, but otherwise they're straightforward.

Thanks!

> These are the simple pieces that probably don't fix anything by
> themselves.  I'm looking at the other parts too and have a couple
> comments there, but at least we can clear these off the plate.

You are right, the patches you applied don't fix anything and are more
like "nice to have" material. The critical patches that you did not
apply are:

  PCI: Take all bridges into account when calculating bus numbers for extension
  ACPI / hotplug / PCI: Do not scan all bridges when native PCIe hotplug is used

These two IMHO should be prioritized higher than doing some cleanup for
SHPC which pretty much is not used in modern systems anyway. Without the
above two patches all systems using native mode will not work properly
when you plug in TBT or normal USB-C device.
