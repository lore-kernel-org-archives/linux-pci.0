Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:63482 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752941Ab3I0U4q (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 27 Sep 2013 16:56:46 -0400
Received: by mail-ie0-f176.google.com with SMTP id as1so5025553iec.7
        for <linux-pci@vger.kernel.org>; Fri, 27 Sep 2013 13:56:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAOJFanV9WewKjCyx6X-+nq4=EKoCwJTM6zg2PJ2BBBC_0aWNWw@mail.gmail.com>
References: <CAOJFanW+QFjeUX40JhGHuaPRW7-7jh21OCijneWgPo=Nnf5Oaw@mail.gmail.com>
 <CAOJFanV9WewKjCyx6X-+nq4=EKoCwJTM6zg2PJ2BBBC_0aWNWw@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 27 Sep 2013 14:56:25 -0600
Message-ID: <CAErSpo6dOq8-vDP1G=pMV8fNrf81GyBtWrR5pkvynSkr834JTA@mail.gmail.com>
Subject: Re: PCI: PCIe rescan resource allocation/re-size failure
To: Sasikanth babu <sasikanth.v19@gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yinghai Lu <yinghai@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Yinghai]

On Wed, Sep 25, 2013 at 7:01 PM, Sasikanth babu <sasikanth.v19@gmail.com> wrote:
> Hello all,
>
> I have been facing an issue with PCIe device rescan, pci subsystem
> could not be able to allocate resource.
> I think the issue is PCIe resource resize.
>
> pci 0000:0a:00.0: reg 10: [mem 0x00000000-0x00003fff 64bit pref]
> pci 0000:0a:00.0: reg 18: [mem 0x00000000-0x03ffffff 64bit pref]
> pcieport 0000:02:08.0: BAR 9: can't assign mem pref (size 0x6000000)
> pci 0000:0a:00.0: BAR 2: can't assign mem pref (size 0x4000000)
> pci 0000:0a:00.0: BAR 0: can't assign mem pref (size 0x4000)
>
> Linux kernel : 2.6.34.10 (It is very old. Have no option so can't use
> latest version)
> Arch : mips
>
> I also applied the following patch series  to 2.6.34.10 kernel but the
> result is same resource resize fails.
>
> http://lkml.indiana.edu/hypermail/linux/kernel/1102.1/02823.html  -
> PCI: refactor io size calculation
> https://groups.google.com/forum/#!topic/linux.kernel/LuQ4xbwwWU4 -
> PCI: honor child buses add_size in hot plug configuration series
> https://lkml.org/lkml/2011/6/20/422  -  PCI: fix cardbus and sriov
> regressions series
> https://lkml.org/lkml/2012/1/21/35  - PCI : bridge resource
> reallocation patchset series
> and resource: ability to resize an allocated resource patch.

Sorry, I really don't have time to work on issues with old kernels
like this.  It's too hard to figure out whether the problem has
already been resolved.  If you can reproduce the problem with a
current kernel, I'd be more than happy to work on it.

Yinghai knows a lot about this area, and maybe this will be obvious to him.

But in general, it's just too hard to work on old kernels unless you
can also demonstrate the problem on a current kernel, fix it there,
and backport the fix.  Or, if the current kernel has already been
fixed, you can figure out what fixed it and backport it.

Bjorn

> Steps I followed
> ===============
>
> 1. Put the PCIe device in reset mode from uboot
> 2. Boot kernel    (lspci will not show the device)
> 3. Bring PCIe device out of reset mode
> 4. To rescan PCI bus do echo 1 > /sys/bus/pci/rescan - (rescan is
> must, kernel's hotplug isn't working).
>
> After rescan I can see device in lspci and also resource allocation
> failure message in dmesg o/p.
>
> In the normal scenario i.e device not in reset mode while booting
> kernel, then the address range allocated is
> 11c00c0000000-11c00efffffff : PCI Bus 0000:02 whereas in failure
> scenario i.e device in reset mode, the range
> is 11c00c0000000-11c00dfffffff : PCI Bus 0000:02.
>
> Attached PCI dmesg output
>
> dmesg.working.txt -  device not in reset mode while booting kernel
> dmesg.rescan.txt  -   device  in reset mode while booting kernel
>
> The attached files also have output of /proc/iomem in both scenarios.
>
>
> Thanks In advance.
