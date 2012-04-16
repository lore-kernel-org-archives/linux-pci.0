Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:48010 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753179Ab2DPVdz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 16 Apr 2012 17:33:55 -0400
Received: by pbcun15 with SMTP id un15so6833289pbc.19
        for <linux-pci@vger.kernel.org>; Mon, 16 Apr 2012 14:33:55 -0700 (PDT)
Date: Mon, 16 Apr 2012 14:33:51 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Jiang Liu <liuj97@gmail.com>
Cc: Yinghai Lu <yinghai@kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Dely Sy <dely.l.sy@intel.com>,
	Scott Murray <scott@spiteful.org>,
	Jiang Liu <jiang.liu@huawei.com>,
	Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH RFC 00/17] Introduce a global lock to serialize all PCI
 hotplug
Message-ID: <20120416213351.GA22887@kroah.com>
References: <1334593751-5916-1-git-send-email-jiang.liu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1334593751-5916-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 17, 2012 at 12:28:54AM +0800, Jiang Liu wrote:
> There are multiple ways to trigger PCI hotplug requests concurrently,
> such as:
> 1. Sysfs interfaces exported by the PCI core subsystem

Which ones?

> 2. Sysfs interfaces exported by the PCI hotplug subsystem

Which ones?

> 3. PCI hotplug events triggered by PCI Hotplug Controllers
> 4. ACPI hotplug events for PCI host bridges

Those are both the same.

> 5. Driver binding/unbinding events

Not really a "hotplug" event, that's something that all drivers in the
kernel support.

And in the end, they all propagate down to the driver core to be the
same thing that the PCI driver sees.

> The PCI core subsystem doesn't support concurrent hotplug operations yet,
> so all PCI hotplug requests should be globally serialized.

Why do you think they are not?  These should all be serialized today,
with the bus lock down in the driver core.  How is this failing?

> This patchset
> introduces a global recursive rwsem to serialize all PCI hotplug operations.

Ick, why?  What's wrong with the lock we are already taking?  And why
would you need a rwsem anyway?

> Following PCI hotplug drivers/interfaces have been enhanced with this
> 1. Sysfs interfaces exported by the PCI core subsystem
> 2. Sysfs interfaces exported by the PCI hotplug subsystem
> 3. pciehp
> 4. shpchp
> 5. cpcihp_generic and cpcihp_zt5550
> 6. fakephp

You are doing something wrong if you require this to be fixed up in each
individual pci hotplug driver.  Fix this in the PCI core, if needed.
But again, I don't see why it is needed.

> But there are still several TODOs:
> 1) all other PCI hotplug driver in drivers/pci/hotplug directory
> 2) SR-IOV
> 3) acpiphp (plan to do this based on Yinghai's PCI root bus hotplug gate)
> 4) pci_root (plan to do this based on Yinghai's PCI root bus hotplug gate)
> 
> Basic test has been done as below, will find more hardwares to do more tests.
> Start three scripts on an Intel Atom system to currently execute:
> 1) remove/rescan PCI devices by sysfs interfaces exported by PCI core subsystem
> 2) remove/rescan PCI devices by sysfs interfaces exported by fakephp driver
> 3) load/unload fakephp driver
> The test has run about four hours without failure.

And it fails without this?  How does it?

And really, fakephp?  Come on, what happens in the "real world" with
real pci hotplug systems/devices that this patch set is trying to solve?

thanks,

greg k-h
