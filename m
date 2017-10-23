Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <4017204.UeppN1BopX@aspire.rjw.lan>
References: <3806130.B2KCK0tvef@aspire.rjw.lan> <4017204.UeppN1BopX@aspire.rjw.lan>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 23 Oct 2017 18:57:42 +0200
Message-ID: <CAPDyKFpB-+8kECDkGQ+-xPvSE308wyE7Qn7WLYu6xjvDq0y6QQ@mail.gmail.com>
Subject: Re: [PATCH 03/12] PM: i2c-designware-platdrv: Use DPM_FLAG_SMART_PREPARE
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
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kevin Hilman <khilman@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 16 October 2017 at 03:29, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Modify i2c-designware-platdrv to set DPM_FLAG_SMART_PREPARE for its
> devices and return 0 from the system suspend ->prepare callback
> if the device has an ACPI companion object in order to tell the PM
> core and middle layers to avoid skipping system suspend/resume
> callbacks for the device in that case (which may be problematic,
> because the device may be accessed during suspend and resume of
> other devices via I2C operation regions then).
>
> Also the pm_runtime_suspended() check in dw_i2c_plat_prepare()
> is not necessary any more, because the core does it when setting
> power.direct_complete for the device, so drop it.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/i2c/busses/i2c-designware-platdrv.c |   10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> Index: linux-pm/drivers/i2c/busses/i2c-designware-platdrv.c
> ===================================================================
> --- linux-pm.orig/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ linux-pm/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -370,6 +370,8 @@ static int dw_i2c_plat_probe(struct plat
>         ACPI_COMPANION_SET(&adap->dev, ACPI_COMPANION(&pdev->dev));
>         adap->dev.of_node = pdev->dev.of_node;
>
> +       dev_pm_set_driver_flags(&pdev->dev, DPM_FLAG_SMART_PREPARE);
> +
>         /* The code below assumes runtime PM to be disabled. */
>         WARN_ON(pm_runtime_enabled(&pdev->dev));
>
> @@ -433,7 +435,13 @@ MODULE_DEVICE_TABLE(of, dw_i2c_of_match)
>  #ifdef CONFIG_PM_SLEEP
>  static int dw_i2c_plat_prepare(struct device *dev)
>  {
> -       return pm_runtime_suspended(dev);
> +       /*
> +        * If the ACPI companion device object is present for this device, it
> +        * may be accessed during suspend and resume of other devices via I2C
> +        * operation regions, so tell the PM core and middle layers to avoid
> +        * skipping system suspend/resume callbacks for it in that case.
> +        */

The above scenario can also happens for non-acpi companion devices.
That makes this comment a bit confusing to me.

> +       return !has_acpi_companion(dev);

I understand it still works by always returning 1 for the non-acpi
case, because the PM core deals with it for the direct_complete path.
However it looks rather odd, especially due to the comment above.

Perhaps returning pm_runtime_suspended() in the other case make this
more clear? Or perhaps clarifying the comment somehow? :-)

>  }
>
>  static void dw_i2c_plat_complete(struct device *dev)
>
>

Kind regards
Uffe
