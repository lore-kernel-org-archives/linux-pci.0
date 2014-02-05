Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Wed, 5 Feb 2014 12:14:05 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Aaron Lu <aaron.lu@intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 0/24] ACPI / hotplug / PCI: ACPIPHP updates and
 consolidation with ACPI core
Message-ID: <20140205101405.GC18029@intel.com>
References: <2217793.001RY6hKlo@vostro.rjw.lan>
 <1935791.liE9ZlzmO9@vostro.rjw.lan>
 <20140203104408.GQ18029@intel.com>
 <7532948.aJNUotNMpR@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7532948.aJNUotNMpR@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 04, 2014 at 12:12:26AM +0100, Rafael J. Wysocki wrote:
> As I said previously, I have found two concurrency-related bugs more in ACPIPHP
> and I needed to put fixes for those bugs at the top of the series (after previous
> [1-2/13] and the patch at https://patchwork.kernel.org/patch/3567701/).  For this
> reason, I also had to rebase the ACPI/PCI hotplug consolidation patchset
> (https://lkml.org/lkml/2014/2/2/87) which got a few additional cosmetic changes too.
> 
> The following is a combination of the two series with one patch dropped (it would
> conflict with [4-5/24]) and a few patches added.  It is on top of 3.14-rc1.
> 
> Patches [1-5/24], that are regarded as 3.14-rc2 material, are on the bleeding-edge
> branch of linux-pm.git.  The remaining patches will show up in bleeding-edge
> shortly.
> 
> [1/24] Remove entries from bus->devices in reverse order (in ACPIPHP).
> [2/24] Move PCI rescan-remove locking to hotplug_event().
> [3/24] Scan root bus under the PCI rescan-remove lock
> [4/24] Fix race in handle_hotplug_event() related to concurrent bridge removal.
> [5/24] Fix race in hotplug_event() related to dock events and concurrent bridge removal.
> [6/24] Drop dev_in_slot() and rework disable_slot() to walk bus->devices directly.
> [7/24] Fix up two kerneldoc comments in acpiphp_glue.c.
> [8/24] Get rid of an unnecessary label in register_slot().
> [9/24] Drop acpiphp_bus_trim() and use acpi_bus_trim() instead of it directly.
> [10/24] Move the acpi_bus_get_device() call out of acpiphp_no_hotplug().
> [11/24] Store struct acpi_device pointers instead of ACPI handles in struct acpiphp_context.
> [12/24] Drop acpiphp_bus_add() (which has only one user).
> [13/24] Drop crit_sect mutexes (that are redundant).
> [14/24] Clean up the usage of the slot variable in hotplug_event().
> [15/24] Use acpi_handle_debug() in hotplug_event() instead of open-coded stuff.
> [16/24] Do not pass ACPI handle to hotplug_event().
> [17/24] Add a new function to ACPICA allowing a callback to be executed under the
>         namespace mutex after calling acpi_ns_get_attached_data().
> [18/24] Use the new ACPICA's function to fix a couple of potential races related
>         to ACPI notifies.
> [19/24] Move the hotplug context lock definition to the ACPI core (from ACPIPHP).
> [20/24] Consolidate ACPI hotplug signaling for PCI and ACPI core.
> [21/24] Rework the handling of eject requests in the ACPI core.
> [22/24] Simplify a routine for installing hotplug notify handlers.
> [23/24] Dispatch ACPI hotplug notifications for "core" devices and PCI from
>         acpi_bus_notify().
> [24/24] Pass struct acpi_device pointer to acpiphp_check_host_bridge().

Tried your latest bleeding-edge branch (it seemed to have all the above
patches) on my TBT test machines (Acer Aspire S5, Intel NUC and Intel
DZ77RE-75K). TBT hotplug works nicely, no deadlocks or anything like that.

Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
