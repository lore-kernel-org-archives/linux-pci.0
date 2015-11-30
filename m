Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46999 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751120AbbK3SHH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 30 Nov 2015 13:07:07 -0500
Date: Mon, 30 Nov 2015 12:07:02 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Imre Deak <imre.deak@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Jani Nikula <jani.nikula@intel.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	intel-gfx@lists.freedesktop.org,
	Linux PCI <linux-pci@vger.kernel.org>,
	Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v4] PCI / PM: tune down RPM suspend error message with
 EBUSY and EAGAIN retval
Message-ID: <20151130180702.GB29242@localhost>
References: <1448648254-12639-1-git-send-email-imre.deak@intel.com>
 <1448699664-4178-1-git-send-email-imre.deak@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1448699664-4178-1-git-send-email-imre.deak@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Imre,

> PCI / PM: tune down RPM suspend error message with EBUSY and EAGAIN retval

Please capitalize the first word, e.g., "Tune ..."

Maybe "Tune down non-fatal runtime suspend error messages" would be
more to the point.  Or maybe "retryable," since it sounds like that's
what's supposed to happen.


On Sat, Nov 28, 2015 at 10:34:24AM +0200, Imre Deak wrote:
> The runtime PM core doesn't treat EBUSY and EAGAIN retvals from the driver
> suspend hooks as errors, but they still show up as errors in dmesg. Tune
> them down.

I looked briefly for the place in the runtime PM core where we handle
EBUSY and EAGAIN specially, but I didn't find it.  A pointer would be
helpful.

> One problem caused by this was noticed by Daniel: the i915 driver
> returns EAGAIN to signal a temporary failure to suspend and as a request
> towards the RPM core for scheduling a suspend again. This is a normal
> event, but the resulting error message flags a breakage during the
> driver's automated testing which parses dmesg and picks up the error.
> 
> v2:
> - fix compile breake when CONFIG_PM_SLEEP=n (0-day builder)
> v3:
> - instead of modifying the suspend_report_result() helper to disinguish
>   between the runtime and system suspend case, inline the error
>   printing, it's not used anywhere else (Rafael)
> v4:
> - don't refer to log levels as flags in code comment (Rafael)
> - use pr_debug(), pr_err() instead of the corresponding printk() (Rafael)

The version history is very useful during development but not after
merging, so I prefer it to go after the "---" marker so it doesn't get
included in the permanent changelog.

> Reported-by: Daniel Vetter <daniel.vetter@intel.com>
> Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=92992
> CC: Bjorn Helgaas <bhelgaas@google.com>
> CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Imre Deak <imre.deak@intel.com>
> ---
>  drivers/pci/pci-driver.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 4446fcb..32a9947 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -1146,9 +1146,21 @@ static int pci_pm_runtime_suspend(struct device *dev)
>  	pci_dev->state_saved = false;
>  	pci_dev->no_d3cold = false;
>  	error = pm->runtime_suspend(dev);
> -	suspend_report_result(pm->runtime_suspend, error);
> -	if (error)
> +	if (error) {
> +		/*
> +		 * -EBUSY and -EAGAIN is used to request the runtime PM core
> +		 * to schedule a new suspend, so log the event only with debug
> +		 * log level.
> +		 */
> +		if (error == -EBUSY || error == -EAGAIN)
> +			pr_debug("%s(): %pF returns %d\n", __func__,
> +				 pm->runtime_suspend, error);
> +		else
> +			pr_err("%s(): %pF returns %d\n", __func__,
> +			       pm->runtime_suspend, error);

This looks fine to me in principle.

We have the device pointer, so please use dev_printk(KERN_DEBUG) and
dev_err().  If you're OK with changing the semantics so the debug
message is only emitted when dynamically enabled, you could use
dev_dbg().

I don't know what a user is supposed to do with a message like:

  pci_pm_runtime_suspend(): ata_port_runtime_suspend+0x0/0x200 returns -12

It feels a little bit ... internal.  Using dev_err() will help anchor
it to a specific device.  It's not related to a specific PC in the
function, so maybe use %pf instead of %pF to get rid of the function
offset and size.  And the message doesn't say anything about what the
return code *means*; maybe something like:

  ata_piix 0000:00:14.0: can't suspend now (ata_port_runtime_suspend returned -11)
  ata_piix 0000:00:14.0: can't suspend (ata_port_runtime_suspend returned -12)

> +
>  		return error;
> +	}
>  	if (!pci_dev->d3cold_allowed)
>  		pci_dev->no_d3cold = true;
>  
> -- 
> 2.5.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
