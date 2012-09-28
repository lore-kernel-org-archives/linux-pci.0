Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:55229 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965112Ab2I1Xqi (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 28 Sep 2012 19:46:38 -0400
Received: by mail-lb0-f174.google.com with SMTP id n3so2517605lbo.19
        for <linux-pci@vger.kernel.org>; Fri, 28 Sep 2012 16:46:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1348733519-24684-6-git-send-email-yinghai@kernel.org>
References: <1348733519-24684-1-git-send-email-yinghai@kernel.org> <1348733519-24684-6-git-send-email-yinghai@kernel.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 28 Sep 2012 17:46:17 -0600
Message-ID: <CAErSpo5_gBQwPYSm3oMeQmqTxqRPB_r0-HVv88LD2mR72QafDQ@mail.gmail.com>
Subject: Re: [PATCH 5/8] PCI: Add pci_stop_and_remove_root_bus()
To: Yinghai Lu <yinghai@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Jiang Liu <jiang.liu@huawei.com>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Sep 27, 2012 at 2:11 AM, Yinghai Lu <yinghai@kernel.org> wrote:
> It supports both pci root bus and pci bus under pci bridge.
>
> -v2: clear pci_bridge's subordinate.
> -v3: only handle root bus. and also put Jiang's get/put pair in
> -v4: fold pci_stop/remove_bus_devices in... reducing confusing.
> -v5: split device_register/unregister to avoid extra get...
>      also remove extra blank line.
>
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> ---
>  drivers/pci/remove.c |   36 ++++++++++++++++++++++++++++++++++++
>  include/linux/pci.h  |    2 ++
>  2 files changed, 38 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
> index 513972f..7c0fd92 100644
> --- a/drivers/pci/remove.c
> +++ b/drivers/pci/remove.c
> @@ -111,3 +111,39 @@ void pci_stop_and_remove_bus_device(struct pci_dev *dev)
>         pci_remove_bus_device(dev);
>  }
>  EXPORT_SYMBOL(pci_stop_and_remove_bus_device);
> +
> +void pci_stop_root_bus(struct pci_bus *bus)
> +{
> +       struct pci_dev *child, *tmp;
> +       struct pci_host_bridge *host_bridge;
> +
> +       if (!pci_is_root_bus(bus))
> +               return;
> +
> +       host_bridge = to_pci_host_bridge(bus->bridge);

What if we made these functions just take a "struct pci_host_bridge *"
directly instead of a "struct pci_bus *"?  Then the caller
(acpi_pci_root_remove()) could just look up the pci_host_bridge
pointer itself, or even keep that pointer in struct acpi_pci_root
instead of keeping the pci_bus pointer.

> +       list_for_each_entry_safe_reverse(child, tmp,
> +                                        &bus->devices, bus_list)
> +               pci_stop_bus_device(child);
> +
> +       /* stop the host bridge */
> +       device_del(&host_bridge->dev);
> +}
> +
> +void pci_remove_root_bus(struct pci_bus *bus)
> +{
> +       struct pci_dev *child, *tmp;
> +       struct pci_host_bridge *host_bridge;
> +
> +       if (!pci_is_root_bus(bus))
> +               return;
> +
> +       host_bridge = to_pci_host_bridge(bus->bridge);
> +       list_for_each_entry_safe(child, tmp,
> +                                &bus->devices, bus_list)
> +               pci_remove_bus_device(child);
> +       pci_remove_bus(bus);
> +       host_bridge->bus = NULL;
> +
> +       /* remove the host bridge */
> +       put_device(&host_bridge->dev);
> +}
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 505c05a..a5cd03b 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -734,6 +734,8 @@ extern struct pci_dev *pci_dev_get(struct pci_dev *dev);
>  extern void pci_dev_put(struct pci_dev *dev);
>  extern void pci_remove_bus(struct pci_bus *b);
>  extern void pci_stop_and_remove_bus_device(struct pci_dev *dev);
> +void pci_stop_root_bus(struct pci_bus *bus);
> +void pci_remove_root_bus(struct pci_bus *bus);
>  void pci_setup_cardbus(struct pci_bus *bus);
>  extern void pci_sort_breadthfirst(void);
>  #define dev_is_pci(d) ((d)->bus == &pci_bus_type)
> --
> 1.7.7
>
