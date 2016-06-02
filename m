Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:32784 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752473AbcFBM07 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 2 Jun 2016 08:26:59 -0400
MIME-Version: 1.0
In-Reply-To: <1464855435-32960-4-git-send-email-mika.westerberg@linux.intel.com>
References: <1464855435-32960-1-git-send-email-mika.westerberg@linux.intel.com>
	<1464855435-32960-4-git-send-email-mika.westerberg@linux.intel.com>
Date: Thu, 2 Jun 2016 14:26:57 +0200
Message-ID: <CAJZ5v0g95d1RFdzKYFhwrYeYC8X5VB-xzr=dpcnkVmY2YcJZ4A@mail.gmail.com>
Subject: Re: [PATCH v6 3/5] PCI: Power on bridges before scanning new devices
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
	Peter Wu <peter@lekensteyn.nl>,
	Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
	Linux PCI <linux-pci@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 2, 2016 at 10:17 AM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> When a PCI device is removed through sysfs interface the upstream bridge
> (PCIe port) can be runtime suspended if it was the last device on that bus.
> Now, if the bridge is in D3 we cannot find devices below the bridge
> anymore.  For example following fails to find the removed device again:
>
>   # echo 1 > /sys/bus/pci/devices/0000:00:01.0/0000:01:00.0/remove
>   # echo 1 > /sys/bus/pci/devices/0000:00:01.0/rescan
>
> Where 0000:00:01.0 is the bridge device.
>
> In order to be able to rescan devices below the bridge add
> pm_runtime_get_sync()/pm_runtime_put() calls to pci_scan_bridge().  This
> should keep bridges powered on while their children devices are being
> scanned.
>
> Reported-by: Peter Wu <peter@lekensteyn.nl>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/pci/probe.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 8e3ef720997d..11a802daf242 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -16,6 +16,7 @@
>  #include <linux/aer.h>
>  #include <linux/acpi.h>
>  #include <linux/irqdomain.h>
> +#include <linux/pm_runtime.h>
>  #include "pci.h"
>
>  #define CARDBUS_LATENCY_TIMER  176     /* secondary latency timer */
> @@ -832,6 +833,12 @@ int pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max, int pass)
>         u8 primary, secondary, subordinate;
>         int broken = 0;
>
> +       /*
> +        * Make sure the bridge is powered on to be able to access config
> +        * space of devices below it.
> +        */
> +       pm_runtime_get_sync(&dev->dev);
> +
>         pci_read_config_dword(dev, PCI_PRIMARY_BUS, &buses);
>         primary = buses & 0xFF;
>         secondary = (buses >> 8) & 0xFF;
> @@ -1012,6 +1019,8 @@ int pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max, int pass)
>  out:
>         pci_write_config_word(dev, PCI_BRIDGE_CONTROL, bctl);
>
> +       pm_runtime_put(&dev->dev);
> +
>         return max;
>  }
>  EXPORT_SYMBOL(pci_scan_bridge);
> --
