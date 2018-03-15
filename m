Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Thu, 15 Mar 2018 08:00:05 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, Mario.Limonciello@dell.com,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <yehezkel.bernat@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3 0/5] PCI: Fixes for native PCIe and ACPI hotplug
Message-ID: <20180315060005.GO2703@lahna.fi.intel.com>
References: <20180226132112.81447-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180226132112.81447-1-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 26, 2018 at 04:21:07PM +0300, Mika Westerberg wrote:
> Hi,
> 
> When Thunderbolt controller is configured to be in native enumeration mode
> it actually includes two slightly different modes. First there is non-RTD3
> mode where the Thunderbolt host controller is only present when there is a
> device connected. The second one is RTD3 mode where the controller is
> always present.
> 
> In non-RTD3 mode the Thunderbolt host controller (NHI) and USB host (xHCI)
> controller are not hotplugged using native PCIe hotplug but instead they
> will be hotplugged via BIOS triggered ACPI Notify() to the root port. This
> is done to preserve resources since the NHI and xHCI only need 1 MB of MMIO
> space and no additional buses. Currently Linux does not support this very
> well and ends up failing the hotplug in one way or another. More detailed
> explanation is in changelog of patch [4/5].
> 
> This series fixes this issue and in addition includes fixes for few other
> issues found during testing on a system that has Thunderbolt controller in
> non-RTD3 native PCIe enumeration mode. However, the fixes here are not in
> any way Thunderbolt specific and should be applicable to other systems as
> well.
> 
> The previous versions of the patch series can be found here:
> 
>   v2: https://www.spinics.net/lists/linux-pci/msg69186.html
>   v1: https://www.spinics.net/lists/linux-acpi/msg80607.html
> 
> Changes from v2:
> 
>   - Added Rafael's tag to patch [1/5].
>   - Updated changelog of patch [1/5] to include more details about how the
>     problem can be observed from dmesg and lspci output.
> 
> Changes from v1:
> 
>   - Drop 'cmax - max ?: 1' and use similar construct than we use in second
>     pass loop in patch [1/5].
>   - Drop unnecessary parentheses in patch [1/5].
>   - Added Rafael's tag to patches [2-5/5].

Hi Bjorn,

Do you have any comments on the series? It would be nice to get it
merged for v4.17 if no objections.

Thanks!
