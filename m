Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 0/5] PM: Unify the handling of device wakeup settings
Date: Sat, 24 Jun 2017 01:50:55 +0200
Message-ID: <2524735.NRzn8A9HAf@aspire.rjw.lan>
In-Reply-To: <12296383.UdE5HVtyng@aspire.rjw.lan>
References: <12296383.UdE5HVtyng@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday, June 19, 2017 11:31:58 PM Rafael J. Wysocki wrote:
> Hi All,
> 
> The handling of device wakeup settings, especially in the ACPI core and the PCI
> bus type, depends on whether it is about system wakeup from sleep states or
> remote wakeup in the working state (runtime).  However, that distinction is
> mostly based on the ACPI concept of "wakeup" and "runtime" GPEs, which is
> somewhat artificial, because the underlying hardware mechanism is basically
> the same in both cases.
> 
> Moreover, suspend-to-idle is now supported as a sleep state and wakeup from it
> is based on exactly the same hardware capabilities as the working-state
> (runtime) remote wakeup.
> 
> The following patch series removes that distinction and unifies the handling of
> device wakeup settings between system sleep and runtime.  It also fixes one
> issue related to wakeup signaling through PCI bridges.
> 
> [1/6]: Get rid of the "runtime wakeup" concept from the ACPI core.
> [2/6]: Unify device wakeup settings code paths in the ACPI core.
> [3-4/6]: Unify device wakeup settings code paths in the PCI bus type code.
> [5/6]: Fix wakeup-related issue with bridges in the PCI bus type code.
> [6/6]: Get rid of the "runtime wakeup" concept from the driver core.
> 
> The series is based on current linux-next and will be made available for
> testing in the linux-pm.git tree in a couple of days.

Here's a v2 with tentatively added Reviewed-by tags from Mika.

I've dropped patch [5/6] from the previous iteration as it didn't really belong
here and the issue it attempted to fix is rather theoretical.  I'm going to
take a different approach there.

Apart from this, the function previously called acpi_pm_device_wakeup() has
a different name now: acpi_pm_set_device_wakeup(), to possibly avoid
confusion about its purpose.

Also the changelog of patch [3/5] has been modified slightly.

Thanks,
Rafael

