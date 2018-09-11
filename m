Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:35249 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbeIKM60 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Sep 2018 08:58:26 -0400
MIME-Version: 1.0
References: <20180906155020.51700-1-mika.westerberg@linux.intel.com> <20180906155020.51700-6-mika.westerberg@linux.intel.com>
In-Reply-To: <20180906155020.51700-6-mika.westerberg@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 11 Sep 2018 10:00:07 +0200
Message-ID: <CAJZ5v0imJOe25MxUiutOg+55xX4+ZwY5VULk8WKP3G8Diz+=8w@mail.gmail.com>
Subject: Re: [PATCH 05/10] PCI: portdrv: Resume upon exit from system suspend
 if left runtime suspended
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        anthony.wong@canonical.com, djb@cr.yp.to,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Sep 6, 2018 at 5:50 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Currently we try to keep PCIe ports runtime suspended over system
> suspend if possible. This mostly happens when entering suspend-to-idle
> because there is no need to re-configure wake settings.
>
> This causes problems if the parent port goes into D3cold and it gets
> resumed upon exit from system suspend. This may happen for example if
> the port is part of PCIe switch and the same switch is connected to a
> PCIe endpoint that needs to be resumed. The way exit from D3cold works
> according PCIe 4.0 spec 5.3.1.4.2 is that power is restored and cold
> reset is signaled. After this the device is in D0unitialized state
> keeping PME context if it supports wake from D3cold.
>
> The problem occurs when a PCIe hotplug port is left suspended and the
> parent port goes into D3cold and back to D0, the port keeps its PME
> context but since everything else is reset back to defaults
> (D0unitialized) it is not set to detect hotplug events anymore.
>
> For this reason change the PCIe portdrv power management logic so that
> it is fine to keep the port runtime suspended over system suspend but it
> needs to be resumed upon exit to make sure it gets properly re-initialized.
> The custom ->prepare() hook with DPM_FLAG_SMART_PREPARE is needed
> because otherwise pci_pm_prepare() instructs the PM core to go directly
> to pci_pm_complete() on resume and this skips resuming the port.

Thanks for the detailed explanation, it helps quite a bit!

> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/pci/pcie/portdrv_pci.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
> index eef22dc29140..74761f660a30 100644
> --- a/drivers/pci/pcie/portdrv_pci.c
> +++ b/drivers/pci/pcie/portdrv_pci.c
> @@ -43,6 +43,21 @@ __setup("pcie_ports=", pcie_port_setup);
>  /* global data */
>
>  #ifdef CONFIG_PM
> +int pcie_port_prepare(struct device *dev)
> +{
> +       /*
> +        * Return 0 here to indicate PCI core that:
> +        *   - Direct complete path should be avoided
> +        *   - It is OK to leave the port runtime suspended over system
> +        *     suspend
> +        *
> +        * However, the port needs to be resumed afterwards because it may
> +        * have been in D3cold in which case we need to re-initialize the
> +        * hardware as it is in D0uninitialized in that case.
> +        */
> +       return 0;
> +}

You wouldn't need this if you passed DPM_FLAG_NEVER_SKIP to
dev_pm_set_driver_flags() (instead of DPM_FLAG_SMART_SUSPEND), would
you?

> +
>  static int pcie_port_runtime_suspend(struct device *dev)
>  {
>         return to_pci_dev(dev)->bridge_d3 ? 0 : -EBUSY;
> @@ -64,6 +79,7 @@ static int pcie_port_runtime_idle(struct device *dev)
>  }
>
>  static const struct dev_pm_ops pcie_portdrv_pm_ops = {
> +       .prepare        = pcie_port_prepare,
>         .suspend        = pcie_port_device_suspend,
>         .resume_noirq   = pcie_port_device_resume_noirq,
>         .resume         = pcie_port_device_resume,
> @@ -109,8 +125,8 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
>
>         pci_save_state(dev);
>
> -       dev_pm_set_driver_flags(&dev->dev, DPM_FLAG_SMART_SUSPEND |
> -                                          DPM_FLAG_LEAVE_SUSPENDED);
> +       dev_pm_set_driver_flags(&dev->dev, DPM_FLAG_SMART_PREPARE |
> +                                          DPM_FLAG_SMART_SUSPEND);
>
>         if (pci_bridge_d3_possible(dev)) {
>                 /*
> --
> 2.18.0
>
