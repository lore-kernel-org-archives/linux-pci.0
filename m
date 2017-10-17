Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <1508257533.16112.484.camel@linux.intel.com>
Subject: Re: [PATCH 12/12] PM / core: Add AVOID_RPM driver flag
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
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
        Kevin Hilman <khilman@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Date: Tue, 17 Oct 2017 19:25:33 +0300
In-Reply-To: <2493317.bKYzDQ0iOo@aspire.rjw.lan>
References: <3806130.B2KCK0tvef@aspire.rjw.lan>
         <2517917.TZ0hdc7mRJ@aspire.rjw.lan>
         <1508254397.16112.481.camel@linux.intel.com>
         <2493317.bKYzDQ0iOo@aspire.rjw.lan>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2017-10-17 at 17:59 +0200, Rafael J. Wysocki wrote:
> On Tuesday, October 17, 2017 5:33:17 PM CEST Andy Shevchenko wrote:
> > On Mon, 2017-10-16 at 03:32 +0200, Rafael J. Wysocki wrote:

> > > If DPM_FLAG_SMART_SUSPEND is not set, DPM_FLAG_AVOID_RPM has no
> > > effect.
> > > 
> > > +	if (dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND)
> > > &&
> > > +	    dev_pm_test_driver_flags(dev, DPM_FLAG_AVOID_RPM)) {
> > 
> > Wasn't interface designed to allow something like:
> > 	if (dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND |
> > DPM_FLAG_AVOID_RPM)) {
> > instead?
> 
> That would return true if any of them was set and both are needed
> here.

Ah, indeed. It would not be equivalent. 

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
