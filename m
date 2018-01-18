Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Hans de Goede <hdegoede@redhat.com>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Robert Moore <robert.moore@intel.com>,
        Lv Zheng <lv.zheng@intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, devel@acpica.org
Subject: ACPI: Do not call _STA on battery devices with unmet dependencies
Date: Thu, 18 Jan 2018 17:03:55 +0100
Message-Id: <20180118160359.29971-1-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi All,

The ACPI code already contains quite a bit of code to not bind the
ACPI-battery until all deps for an ACPI battery device have been met,
but on some devices calling _STA before all deps are met is a problem
too because the _STA method uses an i2c OpRegion there.

Here is the DSDT of the device I'm seeing this on:
https://fedorapeople.org/~jwrdegoede/toshiba-click-mini-dsdt.dsl

This series modifies the kernel to not call _STA until all deps are met,
mirroring the binding behavior of the battery driver.

Without this series a total of 32 ACPI errors get printend to the console
on boot, there are 4 errors per _STA call, 2 battery devices on this
system and 4 _STA calls per battery device.

The first commit is a preparation commit for making the ACPICA changes
in the 4th commit, this commit is necessary to not break things after
the ACPICA changes.

The second commit modifies acpi_bus_get_status to not call _STA on
battery devices until all deps are met. This fixes 2 of the 4 too early
_STA calls triggering these errors.

The third commit makes the device instantiation code use
acpi_bus_get_status instead of acpi_bus_get_status_handle so that the
code to get the initial status also does not makes 1 too early _STA call.

The fourth commit changes the ACPICA acpi_get_object_info function to not
call _STA. Only 1 user (which is fixed in the first commit) cares about
acpi_device_info.current_status. And the ACPICA code has this comment:

 * Note: This interface is intended to be used during the initial device
 * discovery namespace traversal. Therefore, no complex methods can be
 * executed, especially those that access operation regions. Therefore, do
 * not add any additional methods that could cause problems in this area.
 * Because of this reason support for the following methods has been removed:
 * this was the fate of the _SUB method which was found to cause such
 * problems and was removed (11/2015).

The described problems with the _SUB method clearly also apply to the _STA
method, so removing it from acpi_get_object_info seems like it is the right
thing to do here. This too fixes 1 too early _STA call, so that with all
4 patches in place we've fixed all 4 too early _STA calls.

Regards,

Hans
