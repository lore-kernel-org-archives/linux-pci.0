Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay0075.hostedemail.com ([216.40.44.75]:59281 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752765AbdFLWSV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Jun 2017 18:18:21 -0400
Message-ID: <1497305895.18751.1.camel@perches.com>
Subject: Re: [PATCH v2 5/8] PM / sleep: Print timing information if debug is
 enabled
From: Joe Perches <joe@perches.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux USB <linux-usb@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Mario Limonciello <mario_limonciello@dell.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Hans De Goede <hdegoede@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>
Date: Mon, 12 Jun 2017 15:18:15 -0700
In-Reply-To: <7222456.034JZvbkBs@aspire.rjw.lan>
References: <8918199.uo13RZ8hZk@aspire.rjw.lan>
         <1615075.mBkoKApGGc@aspire.rjw.lan> <7222456.034JZvbkBs@aspire.rjw.lan>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 2017-06-12 at 22:51 +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Avoid printing the device suspend/resume timing information if
> CONFIG_PM_DEBUG is not set to reduce the log noise level.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/base/power/main.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> Index: linux-pm/drivers/base/power/main.c
> ===================================================================
> --- linux-pm.orig/drivers/base/power/main.c
> +++ linux-pm/drivers/base/power/main.c
> @@ -417,6 +417,7 @@ static void pm_dev_err(struct device *de
>  		dev_name(dev), pm_verb(state.event), info, error);
>  }
>  
> +#ifdef CONFIG_PM_DEBUG
>  static void dpm_show_time(ktime_t starttime, pm_message_t state, char *info)
>  {
>  	ktime_t calltime;
> @@ -433,6 +434,9 @@ static void dpm_show_time(ktime_t startt
>  		info ?: "", info ? " " : "", pm_verb(state.event),
>  		usecs / USEC_PER_MSEC, usecs % USEC_PER_MSEC);
>  }
> +#else
> +static inline void dpm_show_time(ktime_t starttime, pm_message_t state, char *info) {}
> +#endif /* CONFIG_PM_DEBUG */
>  
>  static int dpm_run_callback(pm_callback_t cb, struct device *dev,
>  			    pm_message_t state, char *info)
> 

trivia:

This style of code can be reduced a few lines of code
using a single definition.

static type func(args...)
{
#ifdef CONFIG_<FOO>
	[code ...]
#endif
}

and compilers will generate the same code for the
!defined CONFIG_<FOO> case.

This style can help avoid defects of updating one
function definition and not the other and only
compile testing the updated version.
