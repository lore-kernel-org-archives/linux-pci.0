Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:50925 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755359Ab2LMBAt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 12 Dec 2012 20:00:49 -0500
Received: by mail-vb0-f46.google.com with SMTP id b13so1471288vby.19
        for <linux-pci@vger.kernel.org>; Wed, 12 Dec 2012 17:00:48 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <2268672.Pe9OEEVsRc@vostro.rjw.lan>
References: <8498184.VilrUmatxI@vostro.rjw.lan> <2268672.Pe9OEEVsRc@vostro.rjw.lan>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 12 Dec 2012 18:00:28 -0700
Message-ID: <CAErSpo6jnjfJUadZKutpn4CXz0YMKccwSuG7idionFPjF-5VCw@mail.gmail.com>
Subject: Re: [PATCH 6/6] ACPI: Change the ordering of acpi_bus_check_add()
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
	Toshi Kani <toshi.kani@hp.com>,
	Myron Stowe <myron.stowe@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Dec 9, 2012 at 4:04 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> If acpi_bus_check_add() is called for a handle already having an
> existing struct acpi_device object attached, it is not necessary to
> check the type and status of the device correspondig to it, so
> change the ordering of acpi_bus_check_add() to avoid that.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/scan.c |   18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> Index: linux/drivers/acpi/scan.c
> ===================================================================
> --- linux.orig/drivers/acpi/scan.c
> +++ linux/drivers/acpi/scan.c
> @@ -1582,6 +1582,10 @@ static acpi_status acpi_bus_check_add(ac
>         acpi_status status;
>         int result;
>
> +       acpi_bus_get_device(handle, &device);
> +       if (device)
> +               goto out;
> +
>         result = acpi_bus_type_and_status(handle, &type, &sta);
>         if (result)
>                 return AE_OK;
> @@ -1602,17 +1606,13 @@ static acpi_status acpi_bus_check_add(ac
>          * We may already have an acpi_device from a previous enumeration.  If
>          * so, we needn't add it again, but we may still have to start it.

It looks like this comment might need updating, since we no longer
even get here if we already have an acpi_device.  Presumably you take
care of the "start" it mentions elsewhere now.

>          */
> -       acpi_bus_get_device(handle, &device);
> -       if (!device) {
> -               acpi_add_single_object(&device, handle, type, sta,
> -                                      ACPI_BUS_ADD_BASIC);
> -               if (!device)
> -                       return AE_CTRL_DEPTH;
> +       acpi_add_single_object(&device, handle, type, sta, ACPI_BUS_ADD_BASIC);
> +       if (!device)
> +               return AE_CTRL_DEPTH;
>
> -               device->add_type = context ?
> -                                       ACPI_BUS_ADD_START : ACPI_BUS_ADD_MATCH;
> -       }
> +       device->add_type = context ? ACPI_BUS_ADD_START : ACPI_BUS_ADD_MATCH;
>
> + out:
>         if (!*return_value)
>                 *return_value = device;

I think all (both) callers of acpi_bus_check_add() supply a
return_value pointer, so you could just remove the test.
