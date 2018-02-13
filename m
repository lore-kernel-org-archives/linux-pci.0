Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180213163200.8787-4-mika.westerberg@linux.intel.com>
References: <20180213163200.8787-1-mika.westerberg@linux.intel.com> <20180213163200.8787-4-mika.westerberg@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 13 Feb 2018 18:46:16 +0100
Message-ID: <CAJZ5v0jKjzUJ8fBJ6cN6RUUm_nfk_a8Bt1CVCZGD=L39sPT5fw@mail.gmail.com>
Subject: Re: [PATCH 3/5] PCI: pciehp: Clear Presence Detect and Data Link
 Layer Status Changed on resume
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

On Tue, Feb 13, 2018 at 5:31 PM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> After suspend/resume cycle the Presence Detect or Data Link Layer Status
> Changed bits might be set and if we don't clear them those events will
> not fire anymore and nothing happens for instance when a device is now
> hot-unplugged.
>
> Fix this by clearing those bits in a newly introduced function
> pcie_reenable_notification(). This should be fine because immediately
> after we check if the adapter is still present by reading directly from
> the status register.
>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: stable@vger.kernel.org

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/pci/hotplug/pciehp.h      |  2 +-
>  drivers/pci/hotplug/pciehp_core.c |  2 +-
>  drivers/pci/hotplug/pciehp_hpc.c  | 13 ++++++++++++-
>  3 files changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
> index 636ed8f4b869..5abf864eae35 100644
> --- a/drivers/pci/hotplug/pciehp.h
> +++ b/drivers/pci/hotplug/pciehp.h
> @@ -120,7 +120,7 @@ struct controller *pcie_init(struct pcie_device *dev);
>  int pcie_init_notification(struct controller *ctrl);
>  int pciehp_enable_slot(struct slot *p_slot);
>  int pciehp_disable_slot(struct slot *p_slot);
> -void pcie_enable_notification(struct controller *ctrl);
> +void pcie_reenable_notification(struct controller *ctrl);
>  int pciehp_power_on_slot(struct slot *slot);
>  void pciehp_power_off_slot(struct slot *slot);
>  void pciehp_get_power_status(struct slot *slot, u8 *status);
> diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
> index 332b723ff9e6..44a6a63802d5 100644
> --- a/drivers/pci/hotplug/pciehp_core.c
> +++ b/drivers/pci/hotplug/pciehp_core.c
> @@ -283,7 +283,7 @@ static int pciehp_resume(struct pcie_device *dev)
>         ctrl = get_service_data(dev);
>
>         /* reinitialize the chipset's event detection logic */
> -       pcie_enable_notification(ctrl);
> +       pcie_reenable_notification(ctrl);
>
>         slot = ctrl->slot;
>
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index 18a42f8f5dc5..98ea75aa32c7 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -659,7 +659,7 @@ static irqreturn_t pcie_isr(int irq, void *dev_id)
>         return handled;
>  }
>
> -void pcie_enable_notification(struct controller *ctrl)
> +static void pcie_enable_notification(struct controller *ctrl)
>  {
>         u16 cmd, mask;
>
> @@ -697,6 +697,17 @@ void pcie_enable_notification(struct controller *ctrl)
>                  pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, cmd);
>  }
>
> +void pcie_reenable_notification(struct controller *ctrl)
> +{
> +       /*
> +        * Clear both Presence and Data Link Layer Changed to make sure
> +        * those events still fire after we have re-enabled them.
> +        */
> +       pcie_capability_write_word(ctrl->pcie->port, PCI_EXP_SLTSTA,
> +                                  PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_DLLSC);
> +       pcie_enable_notification(ctrl);
> +}
> +
>  static void pcie_disable_notification(struct controller *ctrl)
>  {
>         u16 mask;
> --
> 2.15.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
