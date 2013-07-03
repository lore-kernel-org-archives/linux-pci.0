Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:57643 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752773Ab3GCVqK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 3 Jul 2013 17:46:10 -0400
Received: by mail-ob0-f172.google.com with SMTP id wo10so763622obc.17
        for <linux-pci@vger.kernel.org>; Wed, 03 Jul 2013 14:46:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1372860295-8306-7-git-send-email-mika.westerberg@linux.intel.com>
References: <1372860295-8306-1-git-send-email-mika.westerberg@linux.intel.com> <1372860295-8306-7-git-send-email-mika.westerberg@linux.intel.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 3 Jul 2013 15:45:50 -0600
Message-ID: <CAErSpo5QQym0b828gq9sAjvh0SdbNhXo0mo8_dU1_52dTVO+GA@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] PCI: acpiphp: workaround for Thunderbolt on Acer
 Aspire S5
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Yinghai Lu <yinghai@kernel.org>,
	"Ronciak, John" <john.ronciak@intel.com>,
	"Penner, Miles J" <miles.j.penner@intel.com>,
	Bruce Allan <bruce.w.allan@intel.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 3, 2013 at 8:04 AM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>
> Correct ACPI PCI hotplug imeplementation should have _RMV method in a
> PCI slot (device under pci bridge). In Acer Aspire S5 case we have it
> deeper in hierarchy:
>
> Device (RP05)
> {
>    // ...
>    Device (HRUP)
>    {
>        // ...
>        Device (HRDN)
>        {
>            // ...
>            Device (EPUP)
>            {
>                // ...
>                Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
>                {
>                    Return (One)
>                }
>            }
>        }
>    }
> }
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/pci/hotplug/acpi_pcihp.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/pci/hotplug/acpi_pcihp.c b/drivers/pci/hotplug/acpi_pcihp.c
> index 2a47e82..d92ebfb 100644
> --- a/drivers/pci/hotplug/acpi_pcihp.c
> +++ b/drivers/pci/hotplug/acpi_pcihp.c
> @@ -422,6 +422,19 @@ static int pcihp_is_ejectable(acpi_handle handle)
>         status = acpi_evaluate_integer(handle, "_RMV", NULL, &removable);
>         if (ACPI_SUCCESS(status) && removable)
>                 return 1;
> +
> +       /*
> +        * Workaround for Thunderbolt implementation on Acer Aspire S5.
> +        *
> +        * Correct ACPI PCI hotplug imeplementation has _RMV method in a PCI
> +        * slot (device under pci bridge). In Acer Aspire S5 case we have it
> +        * deeper in hierarchy.

s/imeplementation/implementation/

If you're casting aspersions on Acer for having an incorrect ACPI
implementation, you should probably provide a spec reference.  I think
it's likely that the Acer implementation is actually correct per the
spec, but Linux just isn't smart enough to handle it.

> +        */
> +       status = acpi_evaluate_integer(handle, "HRDN.EPUP._RMV", NULL,
> +                       &removable);
> +       if (ACPI_SUCCESS(status) && removable)
> +               return 1;
> +
>         return 0;
>  }
>
> --
> 1.8.3.2
>
