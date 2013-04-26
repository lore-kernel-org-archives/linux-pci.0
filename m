Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:59735 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752262Ab3DZWBE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 26 Apr 2013 18:01:04 -0400
Received: by mail-ob0-f173.google.com with SMTP id xn12so3913586obc.4
        for <linux-pci@vger.kernel.org>; Fri, 26 Apr 2013 15:01:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQVKkfGMAy3vVALjaSTXK-n1ZiaLwPm7GEgNQXiOhe9bMA@mail.gmail.com>
References: <CAErSpo5_4HfGP_-4jzQCBHok6tFvAmCg+6G4_b9fYX=vuA00hg@mail.gmail.com>
 <CAE9FiQVKkfGMAy3vVALjaSTXK-n1ZiaLwPm7GEgNQXiOhe9bMA@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 26 Apr 2013 16:00:43 -0600
Message-ID: <CAErSpo4SKVeCYwP6n+ra03=wCUyKeAwK2F1_ZWsU3Anidmf2_A@mail.gmail.com>
Subject: Re: device_unregister() for PCI host bridge removal
To: Yinghai Lu <yinghai@kernel.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Jiang Liu <jiang.liu@huawei.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 26, 2013 at 3:41 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Fri, Apr 26, 2013 at 2:25 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> I'm trying to figure out where we call device_unregister() when
>> removing a PCI host bridge.  I see the device_register() in the
>> following path:
>>
>>     acpi_pci_root_add
>>       pci_acpi_scan_root
>>         pci_create_root_bus
>>           bridge = pci_alloc_host_bridge
>>           bridge->dev.release = pci_release_bus_bridge_dev
>>           device_register(&bridge->dev)
>>         pci_set_host_bridge_release(..., release_pci_root_info, ...)
>>
>> But I don't see any device_unregister() in the remove path:
>>
>>     acpi_pci_root_remove
>>       pci_remove_root_bus
>>         put_device(&host_bridge->dev)
>>
>>     pci_release_bus_bridge_dev
>>       bridge->release_fn        # e.g., release_pci_root_info
>>         release_pci_root_info
>>           __release_pci_root_info
>>             release_resource
>>             free_pci_root_info_res
>>             teardown_mcfg_map
>>
>> What am I missing?
>
> pci_stop_root_bus
>          /* stop the host bridge */
>         device_del(&host_bridge->dev);

Hmm...  OK, thanks for the pointer.  So we don't actually call
device_unregister() itself, but since device_unregister() consists of
nothing more than "device_del(dev); put_device(dev);" I guess we're
doing the equivalent in two pieces:

    acpi_pci_root_remove
      pci_stop_root_bus
        device_del(&host_bridge->dev)
      pci_remove_root_bus
        put_device(&host_bridge->dev)

This seems unnecessarily difficult to analyze.  It would be better if
we had symmetric device_register()/device_unregister() paths, or if
that can't be done, symmetric device_add()/device_del() paths.

Don't bother to generate a quick patch to just replace
device_register() with explicit calls to device_initialize() and
device_add(), though.  Maybe someday we can clean up that and more.
Anyway, thanks for fixing my confusion.

Bjorn
