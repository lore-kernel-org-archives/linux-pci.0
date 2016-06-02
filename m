Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34940 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753229AbcFBM1e (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 2 Jun 2016 08:27:34 -0400
MIME-Version: 1.0
In-Reply-To: <1464855435-32960-5-git-send-email-mika.westerberg@linux.intel.com>
References: <1464855435-32960-1-git-send-email-mika.westerberg@linux.intel.com>
	<1464855435-32960-5-git-send-email-mika.westerberg@linux.intel.com>
Date: Thu, 2 Jun 2016 14:27:32 +0200
Message-ID: <CAJZ5v0ipjr-DJZrsg2RU=xAqnSV2qyub7-4hY2XeTHcSJj-ULA@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] ACPI / hotplug / PCI: Runtime resume bridge before rescan
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
> If a PCI bridge (or PCIe port) that is runtime suspended gets an ACPI
> hotplug event, such as BUS_CHECK we need to make sure it is resumed before
> devices below the bridge are re-scanned. Otherwise the devices behind the
> port are not accessible and will be treated as hot-unplugged.
>
> To fix this, resume PCI bridges from runtime suspend while rescanning.
>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/pci/hotplug/acpiphp_glue.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
> index fa49f9143b80..6a33ddcfa20b 100644
> --- a/drivers/pci/hotplug/acpiphp_glue.c
> +++ b/drivers/pci/hotplug/acpiphp_glue.c
> @@ -675,6 +675,8 @@ static void acpiphp_check_bridge(struct acpiphp_bridge *bridge)
>         if (bridge->is_going_away)
>                 return;
>
> +       pm_runtime_get_sync(&bridge->pci_dev->dev);
> +
>         list_for_each_entry(slot, &bridge->slots, node) {
>                 struct pci_bus *bus = slot->bus;
>                 struct pci_dev *dev, *tmp;
> @@ -694,6 +696,8 @@ static void acpiphp_check_bridge(struct acpiphp_bridge *bridge)
>                         disable_slot(slot);
>                 }
>         }
> +
> +       pm_runtime_put(&bridge->pci_dev->dev);
>  }
>
>  /*
> --
