Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/6] ACPI / PM: Consolidate device wakeup settings code
Date: Fri, 23 Jun 2017 03:05:57 +0200
Message-ID: <8111646.zzkDnlQnPE@aspire.rjw.lan>
In-Reply-To: <4634255.ux8TmyfYTx@aspire.rjw.lan>
References: <12296383.UdE5HVtyng@aspire.rjw.lan> <20170622073937.GR629@lahna.fi.intel.com> <4634255.ux8TmyfYTx@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, June 22, 2017 04:38:49 PM Rafael J. Wysocki wrote:
> On Thursday, June 22, 2017 10:39:37 AM Mika Westerberg wrote:
> > On Mon, Jun 19, 2017 at 11:33:52PM +0200, Rafael J. Wysocki wrote:
> > > -#ifdef CONFIG_PM_SLEEP
> > > -/**
> > > - * acpi_pm_device_sleep_wake - Enable or disable device to wake up the system.
> > > - * @dev: Device to enable/desible to wake up the system from sleep states.
> > > - * @enable: Whether to enable or disable @dev to wake up the system.
> > > - */
> > > -int acpi_pm_device_sleep_wake(struct device *dev, bool enable)
> > > +int acpi_pm_device_wakeup(struct device *dev, bool enable)
> > 
> > Can we call it acpi_pm_device_enable_wakeup() and then provide
> > corresponding acpi_pm_device_disable_wakeup()? I find those easier to
> > understand than acpi_pm_device_wakeup() that sounds like the device
> > should be woken up now.
> 
> OK, fair enough.  I'll change it this way.

Well, sorry, I'd rather not to, or we'll have to add a wrapper around them in
pci-acpi.c. :-)

I can rename it to acpi_pm_device_set_wakeup(), though.

Thanks,
Rafael

