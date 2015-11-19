Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <a89313359d813d955da7235d9193aab01a1c05f9.1447949171.git.luto@kernel.org>
References: <cover.1447949171.git.luto@kernel.org> <a89313359d813d955da7235d9193aab01a1c05f9.1447949171.git.luto@kernel.org>
From: Andy Lutomirski <luto@amacapital.net>
Date: Thu, 19 Nov 2015 14:00:21 -0800
Message-ID: <CALCETrXzkW3x+LWbn2Da9swHO=y5GjE23F4CzcLjztmMGnvnXA@mail.gmail.com>
Subject: Re: [PATCH 2/2] acpi: Show _OSC UUID when _OSC fails
To: Andy Lutomirski <luto@kernel.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yijing Wang <wangyijing@huawei.com>,
	Linux ACPI <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Forwarding to linux-acpi.

On Thu, Nov 19, 2015 at 8:08 AM, Andy Lutomirski <luto@kernel.org> wrote:
> When _OSC fails and especially when it fails due to an invalid UUID,
> it's helpful to show the UUID that we tried.
>
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> ---
>  drivers/acpi/bus.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 2177ef0b16e4..be2b164f8f2d 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -180,9 +180,9 @@ static void acpi_print_osc_error(acpi_handle handle,
>         int i;
>
>         if (ACPI_FAILURE(acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer)))
> -               printk(KERN_DEBUG "%s\n", error);
> +               printk(KERN_DEBUG "%s: %s\n", context->uuid_str, error);
>         else {
> -               printk(KERN_DEBUG "%s: %s\n", (char *)buffer.pointer, error);
> +               printk(KERN_DEBUG "%s (%s): %s\n", (char *)buffer.pointer, context->uuid_str, error);
>                 kfree(buffer.pointer);
>         }
>         printk(KERN_DEBUG "_OSC request data:");
> --
> 2.5.0
>



-- 
Andy Lutomirski
AMA Capital Management, LLC
