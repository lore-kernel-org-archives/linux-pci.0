Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20120921160358.e6509b8c.izumi.taku@jp.fujitsu.com>
References: <20120918151215.59ea763b.izumi.taku@jp.fujitsu.com>
 <20120918152235.fedf80b5.izumi.taku@jp.fujitsu.com> <CAErSpo7MUNae9Aez8VMhj+z7bedrOVxSHKadFv7tgGYcZwLk_g@mail.gmail.com>
 <20120920191523.72cb21c3.izumi.taku@jp.fujitsu.com> <20120921160358.e6509b8c.izumi.taku@jp.fujitsu.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 21 Sep 2012 07:24:32 -0600
Message-ID: <CAErSpo67fOjM7FV4Jq8rU1TTx6eqZpxWSO0b88opLFgPg8e=Jg@mail.gmail.com>
Subject: Re: [PATCH] change signature of walk_root_bridge() function
To: Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	kaneshige.kenji@jp.fujitsu.com, yinghai@kernel.org,
	jiang.liu@huawei.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 21, 2012 at 1:03 AM, Taku Izumi <izumi.taku@jp.fujitsu.com> wrote:
>
> This patch changes the function signature of walk_root_bridge().
>
> We can omit _STA, _SEG, and _BBN evaluation by passing not acpi_handle
> but acpi_pci_root. Now that acpi_pci_slot_add() which is the only
> caller of walk_root_bridge() gets acpi_pci_root structure, changing
> signature of walk_root_bridge() is reasonable.
>
>
> Signed-off-by: Taku Izumi <izumi.taku@jp.fujitsu.com>
> ---
>  drivers/acpi/pci_slot.c |   35 +++++------------------------------
>  1 file changed, 5 insertions(+), 30 deletions(-)

This is beautiful!

> Index: Bjorn-next-0903/drivers/acpi/pci_slot.c
> ===================================================================
> --- Bjorn-next-0903.orig/drivers/acpi/pci_slot.c
> +++ Bjorn-next-0903/drivers/acpi/pci_slot.c
> @@ -233,45 +233,20 @@ out:
>
>  /*
>   * walk_root_bridge - generic root bridge walker
> - * @handle: points to an acpi_pci_root
> + * @root: poiner of an acpi_pci_root
>   * @user_function: user callback for slot objects
>   *
>   * Call user_function for all objects underneath this root bridge.
>   * Walk p2p bridges underneath us and call user_function on those too.
>   */
>  static int
> -walk_root_bridge(acpi_handle handle, acpi_walk_callback user_function)
> +walk_root_bridge(struct acpi_pci_root *root, acpi_walk_callback user_function)
>  {
> -       int seg, bus;
> -       unsigned long long tmp;
>         acpi_status status;
> -       acpi_handle dummy_handle;
> -       struct pci_bus *pci_bus;
> +       acpi_handle handle = root->device->handle;
> +       struct pci_bus *pci_bus = root->bus;
>         struct callback_args context;
>
> -       /* If the bridge doesn't have _STA, we assume it is always there */
> -       status = acpi_get_handle(handle, "_STA", &dummy_handle);
> -       if (ACPI_SUCCESS(status)) {
> -               status = acpi_evaluate_integer(handle, "_STA", NULL, &tmp);
> -               if (ACPI_FAILURE(status)) {
> -                       info("%s: _STA evaluation failure\n", __func__);
> -                       return 0;
> -               }
> -               if ((tmp & ACPI_STA_DEVICE_FUNCTIONING) == 0)
> -                       /* don't register this object */
> -                       return 0;
> -       }
> -
> -       status = acpi_evaluate_integer(handle, "_SEG", NULL, &tmp);
> -       seg = ACPI_SUCCESS(status) ? tmp : 0;
> -
> -       status = acpi_evaluate_integer(handle, "_BBN", NULL, &tmp);
> -       bus = ACPI_SUCCESS(status) ? tmp : 0;
> -
> -       pci_bus = pci_find_bus(seg, bus);
> -       if (!pci_bus)
> -               return 0;
> -
>         context.pci_bus = pci_bus;
>         context.user_function = user_function;
>         context.root_handle = handle;
> @@ -299,7 +274,7 @@ acpi_pci_slot_add(struct acpi_pci_root *
>  {
>         acpi_status status;
>
> -       status = walk_root_bridge(root->device->handle, register_slot);
> +       status = walk_root_bridge(root, register_slot);
>         if (ACPI_FAILURE(status))
>                 err("%s: register_slot failure - %d\n", __func__, status);
>
>
