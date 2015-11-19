Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:36032 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758041AbbKSWAJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 19 Nov 2015 17:00:09 -0500
Received: by obdgf3 with SMTP id gf3so72712509obd.3
        for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2015 14:00:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <cd180d52de6dc9e217bd0a0aed32efa68d0c73f8.1447949171.git.luto@kernel.org>
References: <cover.1447949171.git.luto@kernel.org> <cd180d52de6dc9e217bd0a0aed32efa68d0c73f8.1447949171.git.luto@kernel.org>
From: Andy Lutomirski <luto@amacapital.net>
Date: Thu, 19 Nov 2015 13:59:47 -0800
Message-ID: <CALCETrUV9qbwYT4wSWGHgZ+5uteRMJTeVsJB14FqssbwZqv+nw@mail.gmail.com>
Subject: Re: [PATCH 1/2] acpi: Tidy up _OSC error spacing
To: Andy Lutomirski <luto@kernel.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yijing Wang <wangyijing@huawei.com>,
	Linux ACPI <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Forwarding to linux-acpi.

On Thu, Nov 19, 2015 at 8:08 AM, Andy Lutomirski <luto@kernel.org> wrote:
> The whitespace in _OSC error reports is weird.  Improve it.
>
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> ---
>  drivers/acpi/bus.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index a212cefae524..2177ef0b16e4 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -182,12 +182,12 @@ static void acpi_print_osc_error(acpi_handle handle,
>         if (ACPI_FAILURE(acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer)))
>                 printk(KERN_DEBUG "%s\n", error);
>         else {
> -               printk(KERN_DEBUG "%s:%s\n", (char *)buffer.pointer, error);
> +               printk(KERN_DEBUG "%s: %s\n", (char *)buffer.pointer, error);
>                 kfree(buffer.pointer);
>         }
> -       printk(KERN_DEBUG"_OSC request data:");
> +       printk(KERN_DEBUG "_OSC request data:");
>         for (i = 0; i < context->cap.length; i += sizeof(u32))
> -               printk("%x ", *((u32 *)(context->cap.pointer + i)));
> +               printk(" %x", *((u32 *)(context->cap.pointer + i)));
>         printk("\n");
>  }
>
> --
> 2.5.0
>



-- 
Andy Lutomirski
AMA Capital Management, LLC
