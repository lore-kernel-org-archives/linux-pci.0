Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Tue, 25 Jul 2017 15:46:21 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 3/3] ACPI / PCI / PM: Rework
 acpi_pci_propagate_wakeup()
Message-ID: <20170725124621.GS2369@lahna.fi.intel.com>
References: <3116391.JNS1F4DjTg@aspire.rjw.lan>
 <4853865.5aRGCM4CdQ@aspire.rjw.lan>
 <4690779.IRjbMOd2yB@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4690779.IRjbMOd2yB@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 21, 2017 at 11:30:24PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The acpi_pci_propagate_wakeup() routine is there to handle cases in
> which PCI bridges (or PCIe ports) are expected to signal wakeup
> for devices below them, but currently it doesn't do that correctly.
> 
> The problem is that acpi_pci_propagate_wakeup() uses
> acpi_pm_set_device_wakeup() for bridges and if that routine is
> called for multiple times to disable wakeup for the same device,
> it will disable it on the first invocation and the next calls
> will have no effect (it works analogously when called to enable
> wakeup, but that is not a problem).
> 
> Now, say acpi_pci_propagate_wakeup() has been called for two
> different devices under the same bridge and it has called
> acpi_pm_set_device_wakeup() for that bridge each time.  The
> bridge is now enabled to generate wakeup signals.  Next,
> suppose that one of the devices below it resumes and
> acpi_pci_propagate_wakeup() is called to disable wakeup for that
> device.  It will then call acpi_pm_set_device_wakeup() for the bridge
> and that will effectively disable remote wakeup for all devices under
> it even though some of them may still be suspended and remote wakeup
> may be expected to work for them.
> 
> To address this (arguably theoretical) issue, allow
> wakeup.enable_count under struct acpi_device to grow beyond 1 in
> certain situations.  In particular, allow that to happen in
> acpi_pci_propagate_wakeup() when wakeup is enabled or disabled
> for PCI bridges, so that wakeup is actually disabled for the
> bridge when all devices under it resume and not when just one
> of them does that.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
