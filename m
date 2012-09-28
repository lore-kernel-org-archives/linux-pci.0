Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:55528 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965091Ab2I1XqX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 28 Sep 2012 19:46:23 -0400
Received: by lbon3 with SMTP id n3so2517606lbo.19
        for <linux-pci@vger.kernel.org>; Fri, 28 Sep 2012 16:46:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1348733519-24684-4-git-send-email-yinghai@kernel.org>
References: <1348733519-24684-1-git-send-email-yinghai@kernel.org> <1348733519-24684-4-git-send-email-yinghai@kernel.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 28 Sep 2012 17:46:01 -0600
Message-ID: <CAErSpo63QeF-Wd8nW-K_Qfp5rjMd0mhWADGW-fZiw4Up5-0ezA@mail.gmail.com>
Subject: Re: [PATCH 3/8] PCI: Move out pci_enable_bridges out of assign_unsigned_bus_res
To: Yinghai Lu <yinghai@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Jiang Liu <jiang.liu@huawei.com>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Sep 27, 2012 at 2:11 AM, Yinghai Lu <yinghai@kernel.org> wrote:
> So could use assign_unassigned_bus_res pci root bus add

After your series, acpi_pci_root_start() looks like this:

    pci_assign_unassigned_bus_resources
    list_for_each_entry(driver, &acpi_pci_drivers, node)
        driver->add(root);
    pci_enable_bridges(root->bus);

so apparently it's important that the driver->add() methods be run
*before* the bridges are enabled.  Why?

> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> ---
>  drivers/pci/probe.c     |    1 +
>  drivers/pci/setup-bus.c |    2 --
>  2 files changed, 1 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 65f62e3..59cf1ba 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1905,6 +1905,7 @@ unsigned int __ref pci_rescan_bus(struct pci_bus *bus)
>
>         max = pci_scan_child_bus(bus);
>         pci_assign_unassigned_bus_resources(bus);
> +       pci_enable_bridges(bus);
>         pci_bus_add_devices(bus);
>
>         return max;
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 59e6c55..6d3591d 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1566,6 +1566,4 @@ void pci_assign_unassigned_bus_resources(struct pci_bus *bus)
>         up_read(&pci_bus_sem);
>         __pci_bus_assign_resources(bus, &add_list, NULL);
>         BUG_ON(!list_empty(&add_list));
> -
> -       pci_enable_bridges(bus);
>  }
> --
> 1.7.7
>
