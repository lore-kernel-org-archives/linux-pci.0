Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180213163200.8787-6-mika.westerberg@linux.intel.com>
References: <20180213163200.8787-1-mika.westerberg@linux.intel.com> <20180213163200.8787-6-mika.westerberg@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 13 Feb 2018 18:51:45 +0100
Message-ID: <CAJZ5v0hpKEY74fXaW4sbTMaXdP7FwSiR7EseA5w9CGUP-kUBdQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] ACPI / hotplug / PCI: Mark stale PCI devices disconnected
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <yehezkel.bernat@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 13, 2018 at 5:32 PM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> Following PCIehp mark the unplugged PCI devices disconnected. This makes
> sure PCI core code leaves the now missing hardware registers alone.
>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/pci/hotplug/acpiphp_glue.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
> index 5efa21cdddc9..0aef35ee665a 100644
> --- a/drivers/pci/hotplug/acpiphp_glue.c
> +++ b/drivers/pci/hotplug/acpiphp_glue.c
> @@ -651,6 +651,11 @@ static void trim_stale_devices(struct pci_dev *dev)
>                 alive = pci_device_is_present(dev);
>
>         if (!alive) {
> +               pci_dev_set_disconnected(dev, NULL);
> +               if (pci_has_subordinate(dev))
> +                       pci_walk_bus(dev->subordinate, pci_dev_set_disconnected,
> +                                    NULL);
> +
>                 pci_stop_and_remove_bus_device(dev);
>                 if (adev)
>                         acpi_bus_trim(adev);
> --
> 2.15.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
