Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180122085135.16732-2-hdegoede@redhat.com>
References: <20180122085135.16732-1-hdegoede@redhat.com> <20180122085135.16732-2-hdegoede@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 23 Jan 2018 00:55:33 +0100
Message-ID: <CAJZ5v0g7KppXpk_jRWjKz8-ncdJQHg-QU7oGrgPiBtczgf+gfQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] ACPI: export acpi_bus_get_status_handle()
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Robert Moore <robert.moore@intel.com>,
        Lv Zheng <lv.zheng@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>, devel@acpica.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 22, 2018 at 9:51 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> Some modular drivers need this, export it.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -This is a new patch in v2 of this patch-set
> ---
>  drivers/acpi/bus.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 4d0979e02a28..db0c05997cc2 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -108,6 +108,7 @@ acpi_status acpi_bus_get_status_handle(acpi_handle handle,
>         }
>         return status;
>  }
> +EXPORT_SYMBOL(acpi_bus_get_status_handle);

EXPORT_SYMBOL_GPL(), please.

>
>  int acpi_bus_get_status(struct acpi_device *device)
>  {
> --
