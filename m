Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Thu, 22 Jun 2017 11:22:10 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/6] PM: Unify the handling of device wakeup settings
Message-ID: <20170622082210.GU629@lahna.fi.intel.com>
References: <12296383.UdE5HVtyng@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <12296383.UdE5HVtyng@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 19, 2017 at 11:31:58PM +0200, Rafael J. Wysocki wrote:
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

Apart from that one minor comment, this looks good to me. I'm happy that
we get rid of those run_wake things which I always find really
confusing :)

For the whole series,

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
