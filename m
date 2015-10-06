Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Tue, 6 Oct 2015 15:34:42 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Daniel Vetter <daniel.vetter@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [RFC][PATCH v3 3/3] input: i8042: Avoid resetting controller on
 system suspend/resume
Message-ID: <20151006223442.GA31850@dtor-ws>
References: <10641052.oOBhM6BU9G@vostro.rjw.lan>
 <5472042.4c1h9diL7E@vostro.rjw.lan>
 <2723857.EVg1dAvTli@vostro.rjw.lan>
 <3385784.1Q539YNd1G@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3385784.1Q539YNd1G@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 07, 2015 at 12:53:49AM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> If the upcoming system suspend is not going to be handled by the
> platform firmware, like in the suspend-to-idle case, it is not
> necessary to reset the controller in i8042_pm_suspend(), so avoid
> doing that.
> 
> Moreover, if the system resume currently in progress has not been
> started by the platform firmware, like in the suspend-to-idle case,
> i8042_controller_resume() need not be called by i8042_pm_resume(),
> so avoid doing that too in that case.
> 
> Additionally, try to catch the event that woke up the system by
> calling the interrupt handler early during system resume if it has
> not been started by the platform firmware.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/input/serio/i8042.c |   15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> Index: linux-pm/drivers/input/serio/i8042.c
> ===================================================================
> --- linux-pm.orig/drivers/input/serio/i8042.c
> +++ linux-pm/drivers/input/serio/i8042.c
> @@ -24,6 +24,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/i8042.h>
>  #include <linux/slab.h>
> +#include <linux/suspend.h>
>  
>  #include <asm/io.h>
>  
> @@ -1170,7 +1171,8 @@ static int i8042_pm_suspend(struct devic
>  {
>  	int i;
>  
> -	i8042_controller_reset(true);
> +	if (pm_suspend_via_firmware())
> +		i8042_controller_reset(true);
>  
>  	/* Set up serio interrupts for system wakeup. */
>  	for (i = 0; i < I8042_NUM_PORTS; i++) {
> @@ -1183,6 +1185,14 @@ static int i8042_pm_suspend(struct devic
>  	return 0;
>  }
>  
> +static int i8042_pm_resume_noirq(struct device *dev)
> +{
> +	if (!pm_resume_via_firmware())
> +		i8042_interrupt(0, NULL);
> +
> +	return 0;
> +}
> +
>  static int i8042_pm_resume(struct device *dev)
>  {
>  	int i;
> @@ -1199,7 +1209,7 @@ static int i8042_pm_resume(struct device
>  	 * to bring it in a sane state. (In case of S2D we expect
>  	 * BIOS to reset the controller for us.)
>  	 */
> -	return i8042_controller_resume(true);
> +	return pm_resume_via_firmware() ? i8042_controller_resume(true) : 0;

What happens if we were going to suspend via firmware so we reset the
controller but then we got wakeup condition and we actually did not
suspend. What pm_resume_via_firmware() will return in this case?

Thanks.

-- 
Dmitry
