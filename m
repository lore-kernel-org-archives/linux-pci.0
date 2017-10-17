Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <1508254397.16112.481.camel@linux.intel.com>
Subject: Re: [PATCH 12/12] PM / core: Add AVOID_RPM driver flag
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
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
Date: Tue, 17 Oct 2017 18:33:17 +0300
In-Reply-To: <2517917.TZ0hdc7mRJ@aspire.rjw.lan>
References: <3806130.B2KCK0tvef@aspire.rjw.lan>
         <2517917.TZ0hdc7mRJ@aspire.rjw.lan>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 2017-10-16 at 03:32 +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Define and document a new driver flag, DPM_FLAG_AVOID_RPM, to inform
> the PM core and middle layer code that the driver has something
> significant to do in its ->suspend and/or ->resume callbacks and
> runtime PM should be disabled for the device when these callbacks
> run.
> 
> Setting DPM_FLAG_AVOID_RPM (in addition to DPM_FLAG_SMART_SUSPEND)
> causes runtime PM to be disabled for the device before invoking the
> driver's ->suspend callback for it and to be enabled again for it
> only after the driver's ->resume callback has returned.  In addition
> to that, if the device is in runtime suspend right after disabling
> runtime PM for it (which means that there was no reason to resume it
> from runtime suspend beforehand), the invocation of the ->suspend
> callback will be skipped for it and it will be left in runtime
> suspend until the "noirq" phase of the subsequent system resume.
> 
> If DPM_FLAG_SMART_SUSPEND is not set, DPM_FLAG_AVOID_RPM has no
> effect.
> 

> +	if (dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND) &&
> +	    dev_pm_test_driver_flags(dev, DPM_FLAG_AVOID_RPM)) {

Wasn't interface designed to allow something like:
	if (dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND | DPM_FLAG_AVOID_RPM)) {
instead?

Does it make sense to have a separate definition for
DPM_FLAG_SMART_SUSPEND | DPM_FLAG_AVOID_RPM ?

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
