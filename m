Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Linux PM <linux-pm@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kevin Hilman <khilman@kernel.org>, linux-i2c@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 11/12] PM: i2c-designware-platdrv: Optimize power management
Date: Thu, 26 Oct 2017 23:14:08 +0200
Message-ID: <7872726.1UjM5oeC1r@aspire.rjw.lan>
In-Reply-To: <20171026204140.wzrq4lronz4nu6la@ninjato>
References: <3806130.B2KCK0tvef@aspire.rjw.lan> <2298462.BTY6P2Oy1l@aspire.rjw.lan> <20171026204140.wzrq4lronz4nu6la@ninjato>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, October 26, 2017 10:41:40 PM CEST Wolfram Sang wrote:
> On Mon, Oct 16, 2017 at 03:31:17AM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > Optimize the power management in i2c-designware-platdrv by making it
> > set the DPM_FLAG_SMART_SUSPEND and DPM_FLAG_LEAVE_SUSPENDED which
> > allows some code to be dropped from its PM callbacks.
> > 
> > First, setting DPM_FLAG_SMART_SUSPEND causes the intel-lpss driver
> > to avoid resuming i2c-designware-platdrv devices in its ->prepare
> > callback, so they can stay in runtime suspend after that point even
> > if the direct-complete feature is not used for them.
> > 
> > It also causes the PM core to avoid invoking "late" and "noirq"
> > suspend callbacks for these devices if they are in runtime suspend
> > at the beginning of the "late" phase of device suspend during
> > system suspend.  That guarantees dw_i2c_plat_suspend() to be
> > called for a device only if it is not in runtime suspend.
> > Moreover, it also causes the PM core to set the device's runtime
> > PM status to "active" after calling dw_i2c_plat_resume() for
> > it, so the driver doesn't need internal flags to avoid invoking
> > either dw_i2c_plat_suspend() or dw_i2c_plat_resume() twice in
> > a row.
> > 
> > Second, setting DPM_FLAG_LEAVE_SUSPENDED enables the optimization
> > allowing the device to stay suspended after system resume under
> > suitable conditions, so again the driver doesn't need to take
> > care of that by itself.
> > 
> > Accordingly, the internal "suspended" and "skip_resume" flags
> > used by the driver are not necessary any more, so drop them and
> > simplify the driver's PM callbacks.
> > 
> > Additionally, notice that dw_i2c_plat_complete() only needs
> > to schedule runtime PM for the device if platform firmware
> > has been involved in resuming the system, so make it call
> > pm_resume_via_firmware() to check that.
> > 
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> So, if the designware maintainers ack it, I will, too.

Thanks!

I need to post a new revision of the core patches, so I'll send this one
again later.  Likely during the next cycle.

Thanks,
Rafael


