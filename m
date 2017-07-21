Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <3408475.MC8krXn0zk@aspire.rjw.lan>
References: <3116391.JNS1F4DjTg@aspire.rjw.lan> <3408475.MC8krXn0zk@aspire.rjw.lan>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 21 Jul 2017 18:27:39 +0300
Message-ID: <CAHp75VdJqyNBC=iy_FGVsxeskHko=P9=SJqrN8Hq1GtXZEyoRA@mail.gmail.com>
Subject: Re: [PATCH 2/3] ACPI / PM: Split acpi_device_wakeup()
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 21, 2017 at 3:40 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> To prepare for a subsequent change and make the code somewhat easier
> to follow, do the following in the ACPI device wakeup handling code:
>
>  * Replace wakeup.flags.enabled under struct acpi_device with
>    wakeup.enable_count as that will be necessary going forward.
>
>    For now, wakeup.enable_count is not allowed to grow beyond 1,
>    so the current behavior is retained.
>
>  * Split acpi_device_wakeup() into acpi_device_wakeup_enable()
>    and acpi_device_wakeup_disable() and modify the callers of
>    it accordingly.
>
>  * Introduce a new acpi_wakeup_lock mutex to protect the wakeup
>    enabling/disabling code from races in case it is executed
>    more than once in parallel for the same device (which may
>    happen for bridges theoretically).

I prefer more self-explaining labels, though it's minor here

To be constructive:
out -> err_unlock
out -> out_unlock or err_unlock (depends on context)


> +out:
> +       mutex_unlock(&acpi_wakeup_lock);
> +       return error;

> +out:
> +       mutex_unlock(&acpi_wakeup_lock);

-- 
With Best Regards,
Andy Shevchenko
