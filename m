Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33800 "EHLO
	mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752894AbcDZVE5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 Apr 2016 17:04:57 -0400
MIME-Version: 1.0
In-Reply-To: <1461578004-129094-3-git-send-email-mika.westerberg@linux.intel.com>
References: <1461578004-129094-1-git-send-email-mika.westerberg@linux.intel.com>
	<1461578004-129094-3-git-send-email-mika.westerberg@linux.intel.com>
Date: Tue, 26 Apr 2016 23:04:55 +0200
Message-ID: <CAJZ5v0itrp_=KUo9kFHh8rSN5RYfPk0+iEgeAWZR5rrnFq-jDA@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] PCI: Move PCIe ports to D3 during suspend
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Qipeng Zha <qipeng.zha@intel.com>,
	Qi Zheng <qi.zheng@intel.com>, Dave Airlie <airlied@gmail.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lukas Wunner <lukas@wunner.de>,
	Andreas Noever <andreas.noever@gmail.com>,
	Linux PCI <linux-pci@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 25, 2016 at 11:53 AM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> Currently the Linux PCI core does not touch power state of PCI bridges and
> PCIe ports when system suspend is entered. Leaving them in D0 consumes
> power which is not good thing in portable devices such as laptops. This may
> also prevent the CPU from entering deeper C-states.
>
> With recent PCIe hardware we can power down the ports to save power given
> that we take into account few restrictions:
>
>   - The PCIe port hardware is recent enough, starting from 2015.
>
>   - Devices connected to PCIe ports are effectively in D3cold once the port
>     is moved to D3 (the config space is not accessible anymore and the link
>     may be powered down).
>
>   - Devices behind the PCIe port need to be allowed to transition to D3cold
>     and back. There is a way both drivers and userspace can forbid this.
>
>   - If the device behind the PCIe port is capable of waking the system it
>     needs to be able to do so from D3cold.
>
> This patch adds a new flag to struct pci_device called 'bridge_d3'. This
> flag is set and cleared by the PCI core whenever there is a change in power
> management state of any of the devices behind the PCIe port (we provide
> helper functions that should be used to change state of the device, like
> pci_d3cold_disable()). When system later on is suspended we only need to
> check this flag and if it is true transition the port to D3 otherwise we
> leave it in D0.
>
> Also provide override mechanism via command line parameter
> "pcie_port_pm=[off|force]" that can be used to disable or enable the
> feature regardless of the BIOS manufacturing date.
>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  Documentation/kernel-parameters.txt |   4 +
>  drivers/pci/bus.c                   |   1 +
>  drivers/pci/pci-driver.c            |  10 +-
>  drivers/pci/pci-sysfs.c             |   5 +
>  drivers/pci/pci.c                   | 176 ++++++++++++++++++++++++++++++++++++
>  drivers/pci/pci.h                   |   2 +
>  drivers/pci/remove.c                |   2 +
>  drivers/usb/host/xhci-pci.c         |   2 +-
>  include/linux/pci.h                 |   3 +
>  9 files changed, 200 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
> index 0b3de80ec8f6..90e1f43760be 100644
> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -3008,6 +3008,10 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
>                 compat  Treat PCIe ports as PCI-to-PCI bridges, disable the PCIe
>                         ports driver.
>
> +       pcie_port_pm=   [PCIE] PCIe port power management handling:
> +               off     Disable power management of all PCIe ports
> +               force   Forcibly enable power management of all PCIe ports
> +
>         pcie_pme=       [PCIE,PM] Native PCIe PME signaling options:
>                 nomsi   Do not use MSI for native PCIe PME signaling (this makes
>                         all PCIe root ports use INTx for all services).
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index 6c9f5467bc5f..b1738162d69a 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -291,6 +291,7 @@ void pci_bus_add_device(struct pci_dev *dev)
>         pci_fixup_device(pci_fixup_final, dev);
>         pci_create_sysfs_dev_files(dev);
>         pci_proc_attach_device(dev);
> +       pci_bridge_d3_device_changed(dev);
>
>         dev->match_driver = true;
>         retval = device_attach(&dev->dev);
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index d7ffd66814bb..e3ece0e25fa3 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -777,7 +777,12 @@ static int pci_pm_suspend_noirq(struct device *dev)
>
>         if (!pci_dev->state_saved) {
>                 pci_save_state(pci_dev);
> -               if (!pci_has_subordinate(pci_dev))
> +               /*
> +                * Check if given device can go to low power state. Currently
> +                * we allow normal PCI devices and PCI bridges if their
> +                * bridge_d3 is set.
> +                */
> +               if (!pci_has_subordinate(pci_dev) || pci_dev->bridge_d3)

I'd add a helper for this, say pci_power_manageable() or similar.

>                         pci_prepare_to_sleep(pci_dev);
>         }
>
> @@ -1144,7 +1149,6 @@ static int pci_pm_runtime_suspend(struct device *dev)
>                 return -ENOSYS;
>
>         pci_dev->state_saved = false;
> -       pci_dev->no_d3cold = false;
>         error = pm->runtime_suspend(dev);
>         if (error) {
>                 /*
> @@ -1161,8 +1165,6 @@ static int pci_pm_runtime_suspend(struct device *dev)
>
>                 return error;
>         }
> -       if (!pci_dev->d3cold_allowed)
> -               pci_dev->no_d3cold = true;
>
>         pci_fixup_device(pci_fixup_suspend, pci_dev);
>
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 342b6918bbde..1a0854be5b18 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -406,6 +406,11 @@ static ssize_t d3cold_allowed_store(struct device *dev,
>                 return -EINVAL;
>
>         pdev->d3cold_allowed = !!val;
> +       if (pdev->d3cold_allowed)
> +               pci_d3cold_enable(pdev);
> +       else
> +               pci_d3cold_disable(pdev);
> +
>         pm_runtime_resume(dev);
>
>         return count;
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 25e0327d4429..69878d5e2c2f 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -9,6 +9,7 @@
>
>  #include <linux/kernel.h>
>  #include <linux/delay.h>
> +#include <linux/dmi.h>
>  #include <linux/init.h>
>  #include <linux/of.h>
>  #include <linux/of_pci.h>
> @@ -101,6 +102,21 @@ unsigned int pcibios_max_latency = 255;
>  /* If set, the PCIe ARI capability will not be used. */
>  static bool pcie_ari_disabled;
>
> +/* Disable bridge_d3 for all PCIe ports */
> +static bool pci_bridge_d3_disable;
> +/* Force bridge_d3 for all PCIe ports */
> +static bool pci_bridge_d3_force;
> +
> +static int __init pcie_port_pm_setup(char *str)
> +{
> +       if (!strcmp(str, "off"))
> +               pci_bridge_d3_disable = true;
> +       else if (!strcmp(str, "force"))
> +               pci_bridge_d3_force = true;
> +       return 1;
> +}
> +__setup("pcie_port_pm=", pcie_port_pm_setup);
> +
>  /**
>   * pci_bus_max_busnr - returns maximum PCI bus number of given bus' children
>   * @bus: pointer to PCI bus structure to search
> @@ -2156,6 +2172,165 @@ void pci_config_pm_runtime_put(struct pci_dev *pdev)
>  }
>
>  /**
> + * pci_bridge_d3_possible - Is it possible to move the bridge to D3

It is better to say "transition" than "move" here IMO.  Or even "put
... into ..".

> + * @bridge: Bridge to check
> + *
> + * This function checks if it is possible to move the bridge to D3.
> + * Currently we only allow D3 for recent enough PCIe ports.
> + */
> +static bool pci_bridge_d3_possible(struct pci_dev *bridge)
> +{
> +       unsigned int year;
> +
> +       if (!pci_is_pcie(bridge))
> +               return false;
> +
> +       switch (pci_pcie_type(bridge)) {
> +       case PCI_EXP_TYPE_ROOT_PORT:
> +       case PCI_EXP_TYPE_UPSTREAM:
> +       case PCI_EXP_TYPE_DOWNSTREAM:
> +               if (pci_bridge_d3_disable)
> +                       return false;
> +               if (pci_bridge_d3_force)
> +                       return true;
> +
> +               /*
> +                * PCIe ports from 2015 and newer should be capable of
> +                * entering D3.

This is more about safety than capability.

I'm sure that older PCIe ports can go to D3 too, but at least some of
them will not work correctly after going back to D0.

So I'd say "It should be safe to put PCIe ports from 2015 or newer into D3".

> +                */
> +               if (dmi_get_date(DMI_BIOS_DATE, &year, NULL, NULL) &&
> +                   year >= 2015) {
> +                       return true;
> +               }
> +               break;
> +       }
> +
> +       return false;
> +}
> +
> +static int pci_dev_check_d3cold(struct pci_dev *dev, void *data)
> +{
> +       bool *d3cold_ok = data;
> +
> +       /*
> +        * The device needs to be allowed to go D3cold and if it is wake
> +        * capable to do so from D3cold. If the device is bridge then it
> +        * needs to have D3 allowed.
> +        */
> +       if (dev->no_d3cold || !dev->d3cold_allowed)
> +               *d3cold_ok = false;
> +       if (device_may_wakeup(&dev->dev) && !pci_pme_capable(dev, PCI_D3cold))
> +               *d3cold_ok = false;
> +       if (pci_has_subordinate(dev) && !dev->bridge_d3)
> +               *d3cold_ok = false;

What about:

bool no_d3cold;

no_d3cold = dev->no_d3cold || !dev->d3cold_allowed ||
         (device_may_wakeup(&dev->dev) && !pci_pme_capable(dev, PCI_D3cold) ||
         !pci_power_manageable(dev);

*d3cold_ok = !no_d3cold;

return no_d3cold;

The rest of the patch looks fine.
