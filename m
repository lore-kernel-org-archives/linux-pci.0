Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Sat, 2 Jun 2018 00:50:50 -0500
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
Message-ID: <20180602055050.GC187972@bhelgaas-glaptop.roam.corp.google.com>
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

I applied all these on pci/hotplug for v4.18.

Thanks for your help and patience!  I reordered some things and
tweaked some changelogs, so let me know if I broke anything.  I'll put
this into -next as soon as the 0-day robot builds it.

Bjorn
