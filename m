Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f47.google.com ([209.85.219.47]:49572 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754426AbaBADof (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 31 Jan 2014 22:44:35 -0500
Received: by mail-oa0-f47.google.com with SMTP id m1so6140789oag.34
        for <linux-pci@vger.kernel.org>; Fri, 31 Jan 2014 19:44:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20140131134925.GI18029@intel.com>
References: <20140130131236.GW18029@intel.com>
	<1418039.AWHqDGWMFa@vostro.rjw.lan>
	<20140131123606.GF18029@intel.com>
	<1426729.BFFFkbZrqa@vostro.rjw.lan>
	<20140131134925.GI18029@intel.com>
Date: Fri, 31 Jan 2014 19:44:34 -0800
Message-ID: <CAE9FiQU8+RRiTdsCm0v8Z46UyQ5xLSGWResVzEyHNCoWvWZjEw@mail.gmail.com>
Subject: Re: Commit ef83b0781a73f (PCI: Remove from bus_list and release
 resources in pci_release_dev()) broke TBT hotplug
From: Yinghai Lu <yinghai@kernel.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 31, 2014 at 5:49 AM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> On Fri, Jan 31, 2014 at 02:49:21PM +0100, Rafael J. Wysocki wrote:
>> > Jan 31 20:05:57 buildroot kern.debug kernel: [  439.672933] pci_bus 0000:03: busn_res: [bus 03-3a] is released
>>
>> OK, so my guess wasn't right.  We seem to call pci_release_dev for all of the
>> devices that go away after unplug.
>>
>> Do I think correctly that the below doesn't happen with the Yinghai's commit
>> reverted?
>
> Yes, with that commit reverted everything works fine.

can you make it clear ?

after my commit is reverted, the warning does not happen any more?

Jan 31 20:06:11 buildroot kern.warn kernel: [  453.616434]
------------[ cut here ]------------
Jan 31 20:06:11 buildroot kern.warn kernel: [  453.618102] WARNING:
CPU: 1 PID: 956 at lib/kobject.c:244 kobject_add_internal+0x12d/
0x400()
Jan 31 20:06:11 buildroot kern.warn kernel: [  453.619797]
kobject_add_internal failed for pci_bus (error: -2 parent:
0000:02:00.0)
Jan 31 20:06:11 buildroot kern.warn kernel: [  453.621491] Modules linked in:
Jan 31 20:06:11 buildroot kern.warn kernel: [  453.623191] CPU: 1 PID:
956 Comm: kworker/u8:5 Not tainted 3.13.0+ #156
Jan 31 20:06:11 buildroot kern.warn kernel: [  453.624912] Hardware
name:                  /D33217CK, BIOS
GKPPT10H.86A.0042.2013.0422.1439 04/22/2013
Jan 31 20:06:11 buildroot kern.warn kernel: [  453.626649] Workqueue:
kacpi_hotplug acpi_hotplug_work_fn
Jan 31 20:06:11 buildroot kern.warn kernel: [  453.628395]
0000000000000009 ffff88006de4d9f8 ffffffff818129e3 ffff88006de4da40
Jan 31 20:06:11 buildroot kern.warn kernel: [  453.630164]
ffff88006de4da30 ffffffff81047228 ffff88006dfd1000 00000000fffffffe
Jan 31 20:06:11 buildroot kern.warn kernel: [  453.631933]
ffff88006de140a8 ffff88006d582918 ffff88006d582918 ffff88006de4da90
Jan 31 20:06:11 buildroot kern.warn kernel: [  453.633691] Call Trace:
Jan 31 20:06:11 buildroot kern.warn kernel: [  453.635428]
[<ffffffff818129e3>] dump_stack+0x45/0x56
Jan 31 20:06:11 buildroot kern.warn kernel: [  453.637138]
[<ffffffff81047228>] warn_slowpath_common+0x78/0xa0
Jan 31 20:06:11 buildroot kern.warn kernel: [  453.638879]
[<ffffffff81047297>] warn_slowpath_fmt+0x47/0x50
Jan 31 20:06:11 buildroot kern.warn kernel: [  453.640579]
[<ffffffff812d81ad>] kobject_add_internal+0x12d/0x400
Jan 31 20:06:11 buildroot kern.warn kernel: [  453.642297]
[<ffffffff812d88b5>] kobject_add+0x65/0xb0
