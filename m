Return-Path: <SRS0=qPnv=IV=gmail.com=rjwysocki@kernel.org>
Return-Path: <SRS0=qPnv=IV=gmail.com=rjwysocki@kernel.org>
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <152791813206.257724.14863139556803168986.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152791788214.257724.13044360353832574147.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <152791813206.257724.14863139556803168986.stgit@bhelgaas-glaptop.roam.corp.google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sun, 3 Jun 2018 09:59:18 +0200
Message-ID: <CAJZ5v0hHHR_559P1vF+9g_vmKkPSWjm9pv5zmjBq9qQ7vDhjOg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] PCI: shpchp: Fix AMD POGO identification
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Len Brown <lenb@kernel.org>, Mario Limonciello <Mario.Limonciello@dell.com>,
	Michael Jamet <michael.jamet@intel.com>, Yehezkel Bernat <YehezkelShB@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Lukas Wunner <lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jun 2, 2018 at 7:42 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> The fix for an AMD POGO erratum related to SHPC incorrectly identified the
> device.  The workaround should be applied only for AMD POGO devices, but it
> was instead applied to:
>
>   - all AMD bridges, and
>   - all devices from any vendor with device ID 0x7458
>
> Fixes: 53044f357448 ("[PATCH] PCI Hotplug: shpchp: AMD POGO errata fix")
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/pci/hotplug/shpchp_ctrl.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pci/hotplug/shpchp_ctrl.c b/drivers/pci/hotplug/shpchp_ctrl.c
> index bedda5bda910..1047b56e5730 100644
> --- a/drivers/pci/hotplug/shpchp_ctrl.c
> +++ b/drivers/pci/hotplug/shpchp_ctrl.c
> @@ -585,13 +585,13 @@ static int shpchp_enable_slot (struct slot *p_slot)
>         ctrl_dbg(ctrl, "%s: p_slot->pwr_save %x\n", __func__, p_slot->pwr_save);
>         p_slot->hpc_ops->get_latch_status(p_slot, &getstatus);
>
> -       if (((p_slot->ctrl->pci_dev->vendor == PCI_VENDOR_ID_AMD) ||
> -           (p_slot->ctrl->pci_dev->device == PCI_DEVICE_ID_AMD_POGO_7458))
> +       if ((p_slot->ctrl->pci_dev->vendor == PCI_VENDOR_ID_AMD &&
> +            p_slot->ctrl->pci_dev->device == PCI_DEVICE_ID_AMD_POGO_7458)
>              && p_slot->ctrl->num_slots == 1) {
> -               /* handle amd pogo errata; this must be done before enable  */
> +               /* handle AMD POGO errata; this must be done before enable  */
>                 amd_pogo_errata_save_misc_reg(p_slot);
>                 retval = board_added(p_slot);
> -               /* handle amd pogo errata; this must be done after enable  */
> +               /* handle AMD POGO errata; this must be done after enable  */
>                 amd_pogo_errata_restore_misc_reg(p_slot);
>         } else
>                 retval = board_added(p_slot);
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
