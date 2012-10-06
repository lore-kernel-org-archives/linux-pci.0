Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:37751 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751408Ab2JFC5z (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 5 Oct 2012 22:57:55 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so2428239pad.19
        for <linux-pci@vger.kernel.org>; Fri, 05 Oct 2012 19:57:54 -0700 (PDT)
Message-ID: <506F9E0F.9010705@gmail.com>
Date: Sat, 06 Oct 2012 10:57:19 +0800
From: Jiang Liu <liuj97@gmail.com>
MIME-Version: 1.0
To: Yinghai Lu <yinghai@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 00/10] PCI, ACPI: Use bus type notifier for root bus hotplug
References: <1349159588-15029-1-git-send-email-yinghai@kernel.org>
In-Reply-To: <1349159588-15029-1-git-send-email-yinghai@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Yinghai,
	I like your idea to get rid of acpi_device_ops->start() method, actually
that's on my TODO list too.
	I think the ACPI based system device hotplug framework we are working on
may help to solve this issue. We define CPU, memory, PCI host bridge, IOAPIC,
and CONTAINER as system devices. We have added some callbacks into acpi_device_ops
to support system device hotplug. With the new ACPI system device hotplug framework,
the sequence is:
1) Walk hot-added ACPI subtree, creates acpi devices and binds acpi drivers. Now
acpi_device_ops->add() method only setup basic data structure to manage the ACPI
device but without actually starting the system device.
2) Classify hot-added ACPI devices into classes, such CPU, MEM, PCI HOST BRIGE, IOAPIC,
CONTAINER.
3) Add all hot-added system device into running system in following order:
CONTAINER -> MEM -> CPU -> IOAPIC -> PCI_HOST_BRIDGE.

With above sequence, we could scan and start PCI devices in step 3 above.

We have refined ACPI container and processor driver to support the new framework, and
we have a prototype for pci_root and mem_hotplug drivers too. I will try to post them
as soon as possible.

Thanks
Gerry

1) scan and bind 
On 10/02/2012 02:32 PM, Yinghai Lu wrote:
> Add device drivers_autoprobe to make hotplug path more like booting path:
> create all acpi device and add them to device tree at first
>  then attach acpi drivers.
> create all pci devices and add them to device tree at first
>  then attach pci drivers.
> 
> 1. kill acpi_pci_root_start.
> 2. register pci devices to device tree as soon as possible after pci devices
>    and bus get created.
>    After pci_scan_child_bus, all bus and devices get into devices already.
>    pci_bus_add_devices will only attach driver to pci devices.
> 
> could get from
>         git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git for-pci-next
> 
> Yinghai Lu (10):
>   device: add drivers_autoprobe in struct device
>   ACPI: use device drivers_autoprobe to delay loading acpi drivers
>   PCI: prepare to use device drivers_autoprobe to delay attach drivers
>   PCI: Use device_add for device and bus early
>   PCI, ACPI: Separate out acpi_pci_root_osc_contorl_set
>   PCI, ACPI: Move hot add root bus conf code to acpi_pci_root_add
>   PCI, ACPI: Remove not used acpi_pci_root_start()
>   PCI: Add dev_is_pci_host_bridge() helper
>   PCI, ACPI: using acpi/pci bind path for pci_host_bridge
>   PCI, ACPI: use bus_type notifier for acpi_pci_bind_notify
> 
>  drivers/acpi/glue.c         |    4 -
>  drivers/acpi/pci_bind.c     |   99 +++++++++++++++----
>  drivers/acpi/pci_root.c     |  223 +++++++++++++++++++++++--------------------
>  drivers/acpi/scan.c         |   48 +++++++++-
>  drivers/base/bus.c          |    2 +-
>  drivers/base/core.c         |    1 +
>  drivers/pci/bus.c           |   45 +++------
>  drivers/pci/hotplug.c       |   25 +++++
>  drivers/pci/iov.c           |    7 --
>  drivers/pci/probe.c         |   25 ++++--
>  include/acpi/acpi_drivers.h |    2 +
>  include/linux/device.h      |    1 +
>  include/linux/pci.h         |    1 +
>  13 files changed, 310 insertions(+), 173 deletions(-)
> 

