MIME-Version: 1.0
In-Reply-To: <1331018040-30725-19-git-send-email-yinghai@kernel.org>
References: <1331018040-30725-1-git-send-email-yinghai@kernel.org>
	<1331018040-30725-19-git-send-email-yinghai@kernel.org>
Date: Tue, 6 Mar 2012 21:40:32 -0700
Message-ID: <CABhMZUWvsZ2fSp2nGqiFuP8QoZ0A0uEUY9LfcAB-HemiLaqbwA@mail.gmail.com>
Subject: Re: [PATCH 18/23] PCI, ACPI: add acpi_pci_root_rescan()
From: Bjorn Helgaas <bjorn.helgaas@gmail.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, x86 <x86@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
	mjg@redhat.com
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 6, 2012 at 12:13 AM, Yinghai Lu <yinghai@kernel.org> wrote:
> it will rescan all acpi pci root if related pci root bus get removed befo=
re.
>
> Signed-off-by: Yinghai <yinghai@kernel.org>
> Cc: Len Brown <lenb@kernel.org>
> Cc: linux-acpi@vger.kernel.org
> ---
> =A0drivers/acpi/pci_root.c | =A0 52 +++++++++++++++++++++++++++++++++++++=
++++++++++
> =A01 files changed, 52 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index b38e347..e1814e0 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -679,3 +679,55 @@ static int __init acpi_pci_root_init(void)
> =A0}
>
> =A0subsys_initcall(acpi_pci_root_init);
> +
> +static acpi_status
> +rescan_root_bridge(acpi_handle handle, u32 lvl, void *context, void **rv=
)
> +{
> + =A0 =A0 =A0 struct acpi_device *device, *pdevice;
> + =A0 =A0 =A0 struct acpi_pci_root *root;
> + =A0 =A0 =A0 acpi_handle phandle;
> + =A0 =A0 =A0 int ret_val;
> +
> + =A0 =A0 =A0 if (!acpi_is_root_bridge(handle))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return AE_OK;
> +
> + =A0 =A0 =A0 acpi_get_parent(handle, &phandle);
> + =A0 =A0 =A0 if (acpi_bus_get_device(phandle, &pdevice)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_DEBUG "no parent device, assumi=
ng NULL\n");

This printk (and the others below) does not have enough context.  A
user or developer will have no clue what it relates to.  Ideally they
would at least be dev_printk().

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdevice =3D NULL;

Is a host bridge without a parent possible?  Seems dubious to me.

> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (!acpi_bus_get_device(handle, &device)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* check if =A0pci root_bus is removed */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 root =3D acpi_driver_data(device);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pci_find_bus(root->segment, root->secon=
dary.start))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return AE_OK;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_DEBUG "bus exists... trim\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* this shouldn't be in here, so remove
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* the bus then re-add it...
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret_val =3D acpi_bus_trim(device, 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_DEBUG "acpi_bus_trim return %x\=
n", ret_val);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 ret_val =3D acpi_bus_add(&device, pdevice, handle, ACPI_BUS=
_TYPE_DEVICE);
> + =A0 =A0 =A0 if (ret_val) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "error adding bus, %x\n", -=
ret_val);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 root =3D acpi_driver_data(device);
> + =A0 =A0 =A0 pci_assign_unassigned_bus_resources(root->bus);
> +
> + =A0 =A0 =A0 ret_val =3D acpi_bus_start(device);
> +
> +out:
> + =A0 =A0 =A0 return ret_val;
> +}
> +
> +void acpi_pci_root_rescan(void)
> +{
> + =A0 =A0 =A0 acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ACPI_UINT32_MAX, rescan_root_bridge, NULL, =
NULL, NULL);
> +}

Walking the ACPI namespace is rarely the right thing to do.  Why do we
need it here?

Is this because we don't handle hotplug of ACPI devices in general?
The ACPI core *should* be noticing device removal and addition and
calling the driver .remove() and .add() methods directly.  I don't
think that's completely implemented, but I wish somebody would put
some effort into that rather than adding more hacky workarounds.

+cc Matthew Garrett, because I think he cares about this area too.
