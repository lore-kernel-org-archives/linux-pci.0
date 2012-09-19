Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20120918152235.fedf80b5.izumi.taku@jp.fujitsu.com>
References: <20120918151215.59ea763b.izumi.taku@jp.fujitsu.com> <20120918152235.fedf80b5.izumi.taku@jp.fujitsu.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 19 Sep 2012 16:46:57 -0600
Message-ID: <CAErSpo7MUNae9Aez8VMhj+z7bedrOVxSHKadFv7tgGYcZwLk_g@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] ACPI, PCI: change acpi_pci_drivers' add/remove interface
To: Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	kaneshige.kenji@jp.fujitsu.com, yinghai@kernel.org,
	jiang.liu@huawei.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 18, 2012 at 12:22 AM, Taku Izumi <izumi.taku@jp.fujitsu.com> wrote:
>
> This patch changes .add/.remove interfaces of acpi_pci_driver.
> In the current implementation acpi_handle is passed as a parameter
> of .add/.remove interface. However acpi_pci_root structure other
> than acpi_handle is more usefull. This enables us to avoid useless
> procedure in each acpi_pci_driver.

Now that .add() gets the struct acpi_pci_root, would you like to clean
up walk_root_bridge()?  I think we could remove the _SEG and _BBN
evaluations as well as the pci_find_bus(), since that information is
all in the struct acpi_pci_root.

This should be a separate patch, if you choose to do it :)

> Signed-off-by: Taku Izumi <izumi.taku@jp.fujitsu.com>
> ---
>  drivers/acpi/pci_root.c            |    8 ++++----
>  drivers/acpi/pci_slot.c            |   11 ++++++-----
>  drivers/pci/hotplug/acpiphp_glue.c |   12 +++++++-----
>  include/linux/acpi.h               |    4 ++--
>  4 files changed, 19 insertions(+), 16 deletions(-)
>
> Index: Bjorn-next-0903/include/linux/acpi.h
> ===================================================================
> --- Bjorn-next-0903.orig/include/linux/acpi.h
> +++ Bjorn-next-0903/include/linux/acpi.h
> @@ -139,8 +139,8 @@ void acpi_pci_irq_disable (struct pci_de
>
>  struct acpi_pci_driver {
>         struct list_head node;
> -       int (*add)(acpi_handle handle);
> -       void (*remove)(acpi_handle handle);
> +       int (*add)(struct acpi_pci_root *root);
> +       void (*remove)(struct acpi_pci_root *root);
>  };
>
>  int acpi_pci_register_driver(struct acpi_pci_driver *driver);
> Index: Bjorn-next-0903/drivers/pci/hotplug/acpiphp_glue.c
> ===================================================================
> --- Bjorn-next-0903.orig/drivers/pci/hotplug/acpiphp_glue.c
> +++ Bjorn-next-0903/drivers/pci/hotplug/acpiphp_glue.c
> @@ -382,10 +382,10 @@ static inline void config_p2p_bridge_fla
>
>
>  /* allocate and initialize host bridge data structure */
> -static void add_host_bridge(acpi_handle *handle)
> +static void add_host_bridge(struct acpi_pci_root *root)
>  {
>         struct acpiphp_bridge *bridge;
> -       struct acpi_pci_root *root = acpi_pci_find_root(handle);
> +       acpi_handle handle = root->device->handle;
>
>         bridge = kzalloc(sizeof(struct acpiphp_bridge), GFP_KERNEL);
>         if (bridge == NULL)
> @@ -468,11 +468,12 @@ find_p2p_bridge(acpi_handle handle, u32
>
>
>  /* find hot-pluggable slots, and then find P2P bridge */
> -static int add_bridge(acpi_handle handle)
> +static int add_bridge(struct acpi_pci_root *root)
>  {
>         acpi_status status;
>         unsigned long long tmp;
>         acpi_handle dummy_handle;
> +       acpi_handle handle = root->device->handle;
>
>         /* if the bridge doesn't have _STA, we assume it is always there */
>         status = acpi_get_handle(handle, "_STA", &dummy_handle);
> @@ -490,7 +491,7 @@ static int add_bridge(acpi_handle handle
>         /* check if this bridge has ejectable slots */
>         if (detect_ejectable_slots(handle) > 0) {
>                 dbg("found PCI host-bus bridge with hot-pluggable slots\n");
> -               add_host_bridge(handle);
> +               add_host_bridge(root);
>         }
>
>         /* search P2P bridges under this host bridge */
> @@ -588,9 +589,10 @@ cleanup_p2p_bridge(acpi_handle handle, u
>         return AE_OK;
>  }
>
> -static void remove_bridge(acpi_handle handle)
> +static void remove_bridge(struct acpi_pci_root *root)
>  {
>         struct acpiphp_bridge *bridge;
> +       acpi_handle handle = root->device->handle;
>
>         /* cleanup p2p bridges under this host bridge
>            in a depth-first manner */
> Index: Bjorn-next-0903/drivers/acpi/pci_slot.c
> ===================================================================
> --- Bjorn-next-0903.orig/drivers/acpi/pci_slot.c
> +++ Bjorn-next-0903/drivers/acpi/pci_slot.c
> @@ -67,8 +67,8 @@ struct acpi_pci_slot {
>         struct list_head list;          /* node in the list of slots */
>  };
>
> -static int acpi_pci_slot_add(acpi_handle handle);
> -static void acpi_pci_slot_remove(acpi_handle handle);
> +static int acpi_pci_slot_add(struct acpi_pci_root *root);
> +static void acpi_pci_slot_remove(struct acpi_pci_root *root);
>
>  static LIST_HEAD(slot_list);
>  static DEFINE_MUTEX(slot_list_lock);
> @@ -295,11 +295,11 @@ walk_root_bridge(acpi_handle handle, acp
>   * @handle: points to an acpi_pci_root
>   */
>  static int
> -acpi_pci_slot_add(acpi_handle handle)
> +acpi_pci_slot_add(struct acpi_pci_root *root)
>  {
>         acpi_status status;
>
> -       status = walk_root_bridge(handle, register_slot);
> +       status = walk_root_bridge(root->device->handle, register_slot);
>         if (ACPI_FAILURE(status))
>                 err("%s: register_slot failure - %d\n", __func__, status);
>
> @@ -311,10 +311,11 @@ acpi_pci_slot_add(acpi_handle handle)
>   * @handle: points to an acpi_pci_root
>   */
>  static void
> -acpi_pci_slot_remove(acpi_handle handle)
> +acpi_pci_slot_remove(struct acpi_pci_root *root)
>  {
>         struct acpi_pci_slot *slot, *tmp;
>         struct pci_bus *pbus;
> +       acpi_handle handle = root->device->handle;
>
>         mutex_lock(&slot_list_lock);
>         list_for_each_entry_safe(slot, tmp, &slot_list, list) {
> Index: Bjorn-next-0903/drivers/acpi/pci_root.c
> ===================================================================
> --- Bjorn-next-0903.orig/drivers/acpi/pci_root.c
> +++ Bjorn-next-0903/drivers/acpi/pci_root.c
> @@ -87,7 +87,7 @@ int acpi_pci_register_driver(struct acpi
>         list_add_tail(&driver->node, &acpi_pci_drivers);
>         if (driver->add)
>                 list_for_each_entry(root, &acpi_pci_roots, node) {
> -                       driver->add(root->device->handle);
> +                       driver->add(root);
>                         n++;
>                 }
>         mutex_unlock(&acpi_pci_root_lock);
> @@ -104,7 +104,7 @@ void acpi_pci_unregister_driver(struct a
>         list_del(&driver->node);
>         if (driver->remove)
>                 list_for_each_entry(root, &acpi_pci_roots, node)
> -                       driver->remove(root->device->handle);
> +                       driver->remove(root);
>         mutex_unlock(&acpi_pci_root_lock);
>  }
>  EXPORT_SYMBOL(acpi_pci_unregister_driver);
> @@ -629,7 +629,7 @@ static int acpi_pci_root_start(struct ac
>         mutex_lock(&acpi_pci_root_lock);
>         list_for_each_entry(driver, &acpi_pci_drivers, node)
>                 if (driver->add)
> -                       driver->add(device->handle);
> +                       driver->add(root);
>         mutex_unlock(&acpi_pci_root_lock);
>
>         pci_bus_add_devices(root->bus);
> @@ -645,7 +645,7 @@ static int acpi_pci_root_remove(struct a
>         mutex_lock(&acpi_pci_root_lock);
>         list_for_each_entry(driver, &acpi_pci_drivers, node)
>                 if (driver->remove)
> -                       driver->remove(root->device->handle);
> +                       driver->remove(root);
>         mutex_unlock(&acpi_pci_root_lock);
>
>         device_set_run_wake(root->bus->bridge, false);
>
