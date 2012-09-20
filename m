Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20120918152440.117dd1cb.izumi.taku@jp.fujitsu.com>
References: <20120918151215.59ea763b.izumi.taku@jp.fujitsu.com> <20120918152440.117dd1cb.izumi.taku@jp.fujitsu.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 20 Sep 2012 13:32:59 -0600
Message-ID: <CAErSpo6Cdb8MuA1TCv9YnjyddyLjKJzLsVD18apDF6icXewEmA@mail.gmail.com>
Subject: Re: [PATCH v3 6/8] ACPI, PCI: add acpi_pci_roots protection
To: Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	kaneshige.kenji@jp.fujitsu.com, yinghai@kernel.org,
	jiang.liu@huawei.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 18, 2012 at 12:24 AM, Taku Izumi <izumi.taku@jp.fujitsu.com> wrote:
>
> Use mutex to protect acpi_pci_roots list against PCI host bridge
> hotplug operations.
>
> Signed-off-by: Taku Izumi <izumi.taku@jp.fujitsu.com>
> ---
>  drivers/acpi/pci_root.c |   27 ++++++++++++++++++---------
>  1 file changed, 18 insertions(+), 9 deletions(-)
>
> Index: Bjorn-next-0903/drivers/acpi/pci_root.c
> ===================================================================
> --- Bjorn-next-0903.orig/drivers/acpi/pci_root.c
> +++ Bjorn-next-0903/drivers/acpi/pci_root.c
> @@ -112,12 +112,17 @@ EXPORT_SYMBOL(acpi_pci_unregister_driver
>  acpi_handle acpi_get_pci_rootbridge_handle(unsigned int seg, unsigned int bus)
>  {
>         struct acpi_pci_root *root;
> +       struct acpi_handle *handle = NULL;

This should be "acpi_handle handle", not "struct acpi_handle *handle".

> +       mutex_lock(&acpi_pci_root_lock);
>         list_for_each_entry(root, &acpi_pci_roots, node)
>                 if ((root->segment == (u16) seg) &&
> -                   (root->secondary.start == (u16) bus))
> -                       return root->device->handle;
> -       return NULL;
> +                   (root->secondary.start == (u16) bus)) {
> +                       handle = root->device->handle;
> +                       break;
> +               }
> +       mutex_unlock(&acpi_pci_root_lock);
> +       return handle;
>  }
