Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53571 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750993AbeC0JeA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Mar 2018 05:34:00 -0400
Date: Tue, 27 Mar 2018 11:33:56 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Jean Delvare <jdelvare@suse.de>, Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v4 1/2] firmware: dmi_scan: Uninline dmi_get_bios_year()
 helper
Message-ID: <20180327093356.hxk5p4qt456nwejf@gmail.com>
References: <20180320180800.63179-1-andriy.shevchenko@linux.intel.com>
 <20180320180800.63179-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180320180800.63179-2-andriy.shevchenko@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


* Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Uninline dmi_get_bios_year() which, in particular, allows us
> to optimize it in the future.
> 
> While doing this, convert the function to return an error code
> when BIOS date is not present or not parsable, or CONFIG_DMI=n.
> 
> Additionally, during the move, add a bit of documentation.
> 
> Fixes: 492a1abd61e4 ("dmi: Introduce the dmi_get_bios_year() helper function")
> Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
> Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
> Reviewed-by: Jean Delvare <jdelvare@suse.de>
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/firmware/dmi_scan.c | 20 ++++++++++++++++++++
>  include/linux/dmi.h         | 11 ++---------
>  2 files changed, 22 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/firmware/dmi_scan.c b/drivers/firmware/dmi_scan.c
> index ae4f1b181c23..bfb6ce6abc83 100644
> --- a/drivers/firmware/dmi_scan.c
> +++ b/drivers/firmware/dmi_scan.c
> @@ -1040,6 +1040,26 @@ bool dmi_get_date(int field, int *yearp, int *monthp, int *dayp)
>  }
>  EXPORT_SYMBOL(dmi_get_date);
>  
> +/**
> + *	dmi_get_bios_year - get a year out of DMI_BIOS_DATE field
> + *
> + *	Returns year on success, -ENXIO if DMI is not selected,
> + *	or a different negative error code if DMI field is not present
> + *	or not parsable.

s/parsable/parseable

I have fixed this in the version I've applied - which I'll push out if it passes 
testing.

Thanks,

	Ingo
