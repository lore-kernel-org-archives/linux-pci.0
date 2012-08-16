Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20120810151227.cc02c783.izumi.taku@jp.fujitsu.com>
References: <20120810150955.e4ab3c7f.izumi.taku@jp.fujitsu.com> <20120810151227.cc02c783.izumi.taku@jp.fujitsu.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 16 Aug 2012 10:11:08 -0700
Message-ID: <CAErSpo6ukOVgCNgrYJ7nZFH_4dwQKwqZhS1w6oSiR9LtNy8Maw@mail.gmail.com>
Subject: Re: [PATCH 2/7][RESEND] PCI: Correctly clean up pci root buses in
 function pci_remove_bus()
To: Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	kaneshige.kenji@jp.fujitsu.com, yinghai@kernel.org,
	jiang.liu@huawei.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 9, 2012 at 11:12 PM, Taku Izumi <izumi.taku@jp.fujitsu.com> wrote:
> From: Jiang Liu <jiang.liu@huawei.com>
>
>     Correctly clean up pci root buses in function pci_remove_bus()
>
>     The function pci_create_root_bus() allocates the pci bus structure,
>     registers the bus device and creates the legacy files for a pci root
>     bus, but returns without setting the is_added flag. The is_added flag
>     for a pci root bus will be set by function pci_scan_child_bus().
>     If a pci root bus is destroyed before calling pci_scan_child_bus(),
>     the is_added flag will not be set.

What's the scenario where this happens?  Most of the
pci_scan_child_bus() calls look like this:

    bus = pci_create_root_bus();
    pci_scan_child_bus(bus);

In those cases, there's no opportunity to destroy the root bus before
calling pci_scan_child_bus().

I don't like to add additional tests as you're doing here because it's
telling us that we have more special cases to think about.  Apparently
bus->is_added is telling us that we've created legacy files and
registered the bus device.  EXCEPT for root buses.  Why is it
different for root buses?  Why don't we set root_bus->is_added at the
same time we create the legacy files and register the root bus's
device?

>     So teach function pci_remove_bus()
>     to detect such a case and correctly clean up pci root buses.
>
>     Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
>     Signed-off-by: Yinghai Lu <yinghai@kernel.org>
>     Signed-off-by: Taku Izumi <izumi.taku@jp.fujitsu.com>
> ---
>  drivers/pci/remove.c |    9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> Index: Bjorn-next-0808/drivers/pci/remove.c
> ===================================================================
> --- Bjorn-next-0808.orig/drivers/pci/remove.c
> +++ Bjorn-next-0808/drivers/pci/remove.c
> @@ -70,11 +70,10 @@ void pci_remove_bus(struct pci_bus *pci_
>         list_del(&pci_bus->node);
>         pci_bus_release_busn_res(pci_bus);
>         up_write(&pci_bus_sem);
> -       if (!pci_bus->is_added)
> -               return;
> -
> -       pci_remove_legacy_files(pci_bus);
> -       device_unregister(&pci_bus->dev);
> +       if (pci_bus->is_added || pci_is_root_bus(pci_bus)) {
> +               pci_remove_legacy_files(pci_bus);
> +               device_unregister(&pci_bus->dev);
> +       }
>  }
>  EXPORT_SYMBOL(pci_remove_bus);
>
>
