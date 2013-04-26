Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:33534 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754354Ab3DZVlM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 26 Apr 2013 17:41:12 -0400
Received: by mail-ie0-f173.google.com with SMTP id k5so5498695iea.32
        for <linux-pci@vger.kernel.org>; Fri, 26 Apr 2013 14:41:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo5_4HfGP_-4jzQCBHok6tFvAmCg+6G4_b9fYX=vuA00hg@mail.gmail.com>
References: <CAErSpo5_4HfGP_-4jzQCBHok6tFvAmCg+6G4_b9fYX=vuA00hg@mail.gmail.com>
Date: Fri, 26 Apr 2013 14:41:11 -0700
Message-ID: <CAE9FiQVKkfGMAy3vVALjaSTXK-n1ZiaLwPm7GEgNQXiOhe9bMA@mail.gmail.com>
Subject: Re: device_unregister() for PCI host bridge removal
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Jiang Liu <jiang.liu@huawei.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 26, 2013 at 2:25 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> I'm trying to figure out where we call device_unregister() when
> removing a PCI host bridge.  I see the device_register() in the
> following path:
>
>     acpi_pci_root_add
>       pci_acpi_scan_root
>         pci_create_root_bus
>           bridge = pci_alloc_host_bridge
>           bridge->dev.release = pci_release_bus_bridge_dev
>           device_register(&bridge->dev)
>         pci_set_host_bridge_release(..., release_pci_root_info, ...)
>
> But I don't see any device_unregister() in the remove path:
>
>     acpi_pci_root_remove
>       pci_remove_root_bus
>         put_device(&host_bridge->dev)
>
>     pci_release_bus_bridge_dev
>       bridge->release_fn        # e.g., release_pci_root_info
>         release_pci_root_info
>           __release_pci_root_info
>             release_resource
>             free_pci_root_info_res
>             teardown_mcfg_map
>
> What am I missing?

pci_stop_root_bus
         /* stop the host bridge */
        device_del(&host_bridge->dev);
