Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:33309 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754600Ab2IYQZP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 25 Sep 2012 12:25:15 -0400
Received: by eaac11 with SMTP id c11so2355619eaa.19
        for <linux-pci@vger.kernel.org>; Tue, 25 Sep 2012 09:25:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1348588579-16970-1-git-send-email-jiang.liu@huawei.com>
References: <1348561590-28067-13-git-send-email-yinghai@kernel.org>
	<1348588579-16970-1-git-send-email-jiang.liu@huawei.com>
Date: Tue, 25 Sep 2012 09:25:13 -0700
Message-ID: <CAE9FiQU_da8Kz5bpRSeLagHsZWOQEvJCfGJ_EyCrG4m6iH+Osw@mail.gmail.com>
Subject: Re: [PATCH] PCI: Add for_each_pci_host_bridge() and pci_get_next_host_bridge
From: Yinghai Lu <yinghai@kernel.org>
To: Jiang Liu <liuj97@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>,
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 25, 2012 at 8:56 AM, Jiang Liu <liuj97@gmail.com> wrote:
> From: Yinghai Lu <yinghai@kernel.org>
>
> use bus_find_device to loop host_bridges.
>
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> ---
>  drivers/pci/search.c |   22 ++++++++++++++++++++++
>  include/linux/pci.h  |    3 +++
>  2 files changed, 25 insertions(+)
>
> diff --git a/drivers/pci/search.c b/drivers/pci/search.c
> index bf969ba..5e82905 100644
> --- a/drivers/pci/search.c
> +++ b/drivers/pci/search.c
> @@ -178,6 +178,28 @@ struct pci_dev *pci_get_domain_bus_and_slot(int domain, unsigned int bus,
>  }
>  EXPORT_SYMBOL(pci_get_domain_bus_and_slot);
>
> +static int match_pci_host_bridge(struct device *dev, void *data)
> +{
> +       return 1;
> +}
> +
> +struct pci_bus *pci_get_next_root_bus(struct pci_bus *bus)
> +{
> +       struct device *dev;
> +
> +       WARN_ON(in_interrupt());
> +       dev = bus_find_device(&pci_host_bridge_bus_type,
> +                             bus ? bus->bridge : NULL,
> +                             NULL,
> +                             match_pci_host_bridge);
> +       if (bus)
> +               put_device(bus->bridge);
> +       if (dev)
> +               return to_pci_host_bridge(dev)->bus;
> +
> +       return NULL;
> +}

that interface is not good, bus could be not root bus.

Also now we still have chance to have root bridge is there, but root
bus already get removed ?

Actually some root member should be in pci host bridge instead.
So don't need to go deep to bus anymore.

hope we should get rid of pci_bus.

-Yinghai
