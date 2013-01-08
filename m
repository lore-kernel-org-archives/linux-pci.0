Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:61254 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756485Ab3AHRpF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 8 Jan 2013 12:45:05 -0500
Received: by mail-vc0-f174.google.com with SMTP id d16so670619vcd.33
        for <linux-pci@vger.kernel.org>; Tue, 08 Jan 2013 09:45:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1350371420-7888-3-git-send-email-wangyijing@huawei.com>
References: <1350371420-7888-1-git-send-email-wangyijing@huawei.com> <1350371420-7888-3-git-send-email-wangyijing@huawei.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 8 Jan 2013 10:44:44 -0700
Message-ID: <CAErSpo6to+9fpiQU2q59MGg0r8OQm7okLnaDAEaeFYAL5xZEUA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] PCI, pciehp: ARI device hotplug support
To: Yijing Wang <wangyijing@huawei.com>
Cc: Yu Zhao <yu.zhao@intel.com>, kernel.openeuler@huawei.com,
	linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>, jiang.liu@huawei.com,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Kenji]

On Tue, Oct 16, 2012 at 1:10 AM, Yijing Wang <wangyijing@huawei.com> wrote:
> ARI device supports up to 256 Functions, pciehp now only scan and configure
> Functions from 0 to 7, this patch fix this problem for ARI device hotplug.
>
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> ---
>  drivers/pci/hotplug/pciehp_pci.c |   40 ++++++++++++++++++++++++++-----------
>  1 files changed, 28 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
> index 09cecaf..b37e8a0 100644
> --- a/drivers/pci/hotplug/pciehp_pci.c
> +++ b/drivers/pci/hotplug/pciehp_pci.c
> @@ -39,7 +39,7 @@ int pciehp_configure_device(struct slot *p_slot)
>         struct pci_dev *dev;
>         struct pci_dev *bridge = p_slot->ctrl->pcie->port;
>         struct pci_bus *parent = bridge->subordinate;
> -       int num, fn;
> +       int num, fn = 0;
>         struct controller *ctrl = p_slot->ctrl;
>
>         dev = pci_get_slot(parent, PCI_DEVFN(0, 0));
> @@ -56,21 +56,31 @@ int pciehp_configure_device(struct slot *p_slot)
>                 ctrl_err(ctrl, "No new device found\n");
>                 return -ENODEV;
>         }
> -
> -       for (fn = 0; fn < 8; fn++) {
> -               dev = pci_get_slot(parent, PCI_DEVFN(0, fn));
> +
> +       do {
> +               if (pci_ari_enabled(parent))
> +                       dev = pci_get_slot(parent, fn);
> +               else
> +                       dev = pci_get_slot(parent, PCI_DEVFN(0, fn));
> +
> +               fn = pci_next_fn(parent, PCI_DEVFN(0, fn));

This doesn't make sense to me.  We just called pci_scan_slot(), which
already  used pci_next_fn() to find all the functions.  We shouldn't
have to have the ARI knowledge and pci_next_fn() looping here again
(and yet again after pci_assign_unassigned_bridge_resources()).

According to the pci_scan_slot() function comment, all the
newly-discovered devices should be on the bus->devices list.  And in
fact, the similar code in acpiphp (enable_device()) *does* use the
bus->devices list.

I think cpci_configure_slot(), pciehp_configure_device(),
enable_slot() in sgi_hotplug.c, and shpchp_configure_device() should
be changed to use the bus->devices list.  In addition, I think the
refcount management (pci_get_slot()/pci_dev_put()) should be removed.

>                 if (!dev)
>                         continue;
>                 if ((dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) ||
>                                 (dev->hdr_type == PCI_HEADER_TYPE_CARDBUS))
>                         pci_hp_add_bridge(dev);
>                 pci_dev_put(dev);
> -       }
> +       } while (fn);
>
>         pci_assign_unassigned_bridge_resources(bridge);
>
> -       for (fn = 0; fn < 8; fn++) {
> -               dev = pci_get_slot(parent, PCI_DEVFN(0, fn));
> +       do {
> +               if (pci_ari_enabled(parent))
> +                       dev = pci_get_slot(parent, fn);
> +               else
> +                       dev = pci_get_slot(parent, PCI_DEVFN(0, fn));
> +
> +               fn = pci_next_fn(parent, PCI_DEVFN(0, fn));
>                 if (!dev)
>                         continue;
>                 if ((dev->class >> 16) == PCI_BASE_CLASS_DISPLAY) {
> @@ -79,7 +89,7 @@ int pciehp_configure_device(struct slot *p_slot)
>                 }
>                 pci_configure_slot(dev);
>                 pci_dev_put(dev);
> -       }
> +       } while (fn);
>
>         pci_bus_add_devices(parent);
>
> @@ -89,21 +99,27 @@ int pciehp_configure_device(struct slot *p_slot)
>  int pciehp_unconfigure_device(struct slot *p_slot)
>  {
>         int ret, rc = 0;
> -       int j;
> +       int fn = 0;
>         u8 bctl = 0;
>         u8 presence = 0;
>         struct pci_bus *parent = p_slot->ctrl->pcie->port->subordinate;
>         u16 command;
>         struct controller *ctrl = p_slot->ctrl;
> +       struct pci_dev *temp;
>
>         ctrl_dbg(ctrl, "%s: domain:bus:dev = %04x:%02x:00\n",
>                  __func__, pci_domain_nr(parent), parent->number);
>         ret = pciehp_get_adapter_status(p_slot, &presence);
>         if (ret)
>                 presence = 0;
> +
> +       do {
> +               if (pci_ari_enabled(parent))
> +                       temp = pci_get_slot(parent, fn);
> +               else
> +                       temp = pci_get_slot(parent, PCI_DEVFN(0, fn));
>
> -       for (j = 0; j < 8; j++) {
> -               struct pci_dev *temp = pci_get_slot(parent, PCI_DEVFN(0, j));
> +               fn = pci_next_fn(parent, PCI_DEVFN(0, fn));
>                 if (!temp)
>                         continue;
>                 if (temp->hdr_type == PCI_HEADER_TYPE_BRIDGE && presence) {
> @@ -129,7 +145,7 @@ int pciehp_unconfigure_device(struct slot *p_slot)
>                         pci_write_config_word(temp, PCI_COMMAND, command);
>                 }
>                 pci_dev_put(temp);
> -       }
> +       } while (fn);
>
>         return rc;
>  }
> --
> 1.7.1
>
>
