Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:36364 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751760AbdGUPpF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jul 2017 11:45:05 -0400
MIME-Version: 1.0
In-Reply-To: <4853865.5aRGCM4CdQ@aspire.rjw.lan>
References: <3116391.JNS1F4DjTg@aspire.rjw.lan> <4853865.5aRGCM4CdQ@aspire.rjw.lan>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 21 Jul 2017 18:45:03 +0300
Message-ID: <CAHp75VeQpmf5z1p9an2bvJDkAGeOxFyXz+VWk7OibNt+-9VMDw@mail.gmail.com>
Subject: Re: [PATCH 3/3] ACPI / PCI / PM: Rework acpi_pci_propagate_wakeup()
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 21, 2017 at 3:42 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:

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

> -       if (wakeup->enable_count > 0)
> -               goto out;
> +       if (wakeup->enable_count > 0) {
> +               if (wakeup->enable_count < max_count)
> +                       goto inc;
> +               else
> +                       goto out;
> +       }

Wouldn't be simpler

    if (wakeup->enable_count >= max_count)
      goto out;

    if (wakeup->enable_count > 0)
      goto inc;

If max_count can be <= 0,

    if (max_count > 0 && wakeup->enable_count >= max_count)
      goto out;


> +inc:
>         wakeup->enable_count++;
>
>  out:



-- 
With Best Regards,
Andy Shevchenko
