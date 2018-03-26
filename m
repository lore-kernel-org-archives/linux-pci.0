Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <1522084449.21176.16.camel@linux.intel.com>
Subject: Re: [PATCH v4 0/2] x86, dmi: Uninline dmi_get_bios_year()
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Jean Delvare <jdelvare@suse.de>, Lukas Wunner <lukas@wunner.de>
Date: Mon, 26 Mar 2018 20:14:09 +0300
In-Reply-To: <20180320180800.63179-1-andriy.shevchenko@linux.intel.com>
References: <20180320180800.63179-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2018-03-20 at 20:07 +0200, Andy Shevchenko wrote:
> Introduce a new helper to extract a year from DMI BIOS date since
> there
> are most existing users do and newcomers would utilize as well.
> 
> This is a fix up series on top what had been applied already.
> 

Ingo, this is a fix up series like should be as you and Rafael pointed
out.

Can we get it into next release, so, we will have no regression in
between?

> Since v3:
> - address more comments from Jean
> - add tags
> - reverse the order of the patches in the series
> - due to above add a Fixes tag to both of them
> 
> Since v2:
> - resend as fix up series
> - address comments from Bjorn, Jean, Lukas, Rafael
> 
> Since v1:
> - move the helper to be regular function (Bjorn, Rafael)
> - fix a potential regression introduced in pci_acpi_crs_quirks()
> (Jean)
> - adjust subject lines and commit message bodies (Bjorn)
> - add tags (Bjorn, Jean)
> 
> Andy Shevchenko (2):
>   firmware: dmi_scan: Uninline dmi_get_bios_year() helper
>   x86/PCI: Fix a potential regression when use dmi_get_bios_year()
> 
>  arch/x86/pci/acpi.c         |  4 +++-
>  drivers/firmware/dmi_scan.c | 20 ++++++++++++++++++++
>  include/linux/dmi.h         | 11 ++---------
>  3 files changed, 25 insertions(+), 10 deletions(-)
> 

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
