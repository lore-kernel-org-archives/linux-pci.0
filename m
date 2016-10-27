Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 27 Oct 2016 18:35:13 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Bjorn Helgaas <helgaas@kernel.org>
cc: Yinghai Lu <yinghai@kernel.org>,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
Subject: Re: 4.3-rc3 BAR allocation problems on multiple machines
In-Reply-To: <20161026215047.GA28097@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <alpine.LRH.2.20.1610271756330.32157@math.ut.ee>
References: <alpine.LRH.2.20.1510071147520.8345@math.ut.ee> <20161026215047.GA28097@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 26 Oct 2016, Bjorn Helgaas wrote:

> Hi Meelis,
> 
> On Wed, Oct 07, 2015 at 12:25:19PM +0300, Meelis Roos wrote:
> > First I noticed that on Sun Netra t1-150 (sparc64 CPU), PCI allocation 
> > was failing for qla1280 scsi driver. Reading dmesg uncovered "can't 
> > claim BAR" errors. Looking for this in my other test machines I see more 
> > of them - on many sparc64 machines and some on x86.
> > 
> > In another thread for "Resource allocation cleanup for v4.4", Yinghai Lu 
> > asked for full dmesg to solve another similar case. So to help 
> > understanding this one, here are the dmesgs of my machines:

> I'm looking through the PCI bugs in bugzilla.kernel.org and came
> across one that I opened for this issue
> (https://bugzilla.kernel.org/show_bug.cgi?id=117191)
> 
> Is this still an issue?  I've applied some patches from Yinghai, but I
> know there are a bunch more in the queue, so I'm trying to figure out
> what's fixed and what's still broken.

All of these issues seem to be still present:

> > 
> > sparc64 machines:
> > 
> > http://kodu.ut.ee/~mroos/dm/dm.t1-105

Still present in 4.8.0-09031-g95107b3:

[   21.143842] pci 0000:00:01.0: can't claim BAR 8 [mem 0x1ff00000000-0x1ffbfffffff]: address conflict with Video RAM area [??? 0x1ff000a0000-0x1ff000bffff flags 0x80000000]
[   21.143947] pci 0000:02:01.0: can't claim BAR 8 [mem 0x1ff00100000-0x1ff028fffff]: no compatible bridge window
[   21.144020] pci 0000:03:0f.0: can't claim BAR 8 [mem 0x1ff00100000-0x1ff028fffff]: no compatible bridge window
[   21.144087] pci 0000:04:00.0: can't claim BAR 0 [mem 0x1ff01000000-0x1ff01ffffff]: no compatible bridge window
[   21.144153] pci 0000:04:00.0: can't claim BAR 1 [mem 0x1ff02000000-0x1ff027fffff]: no compatible bridge window
[   21.144220] pci 0000:04:00.1: can't claim BAR 0 [mem 0x1ff02800000-0x1ff0280702f]: no compatible bridge window
[   21.144288] pci 0000:04:04.0: can't claim BAR 1 [mem 0x1ff02808000-0x1ff02808fff]: no compatible bridge window
[   21.144355] pci 0000:04:04.0: can't claim BAR 6 [mem 0x1ff02810000-0x1ff0281ffff]: no compatible bridge window
...
[   50.775038] qla1280 0000:04:04.0: can't ioremap BAR 1: [mem size 0x00001000]
[   50.883435] qla1280: Unable to map I/O memory

> > http://kodu.ut.ee/~mroos/dm/dm.t1-200

Still present in 4.8.0-09031-g95107b3:

[   51.138280] pci 0000:00:01.0: can't claim BAR 8 [mem 0x1ff00000000-0x1ffbfffffff]: address conflict with Video RAM area [??? 0x1ff000a0000-0x1ff000bffff flags 0x80000000]
[   51.138399] pci 0000:02:08.0: can't claim BAR 1 [mem 0x1ff00002000-0x1ff00003fff 64bit]: no compatible bridge window
[   51.138461] pci 0000:02:08.0: can't claim BAR 3 [mem 0x1ff00004000-0x1ff00005fff 64bit]: no compatible bridge window
[   51.138522] pci 0000:02:08.1: can't claim BAR 1 [mem 0x1ff00006000-0x1ff00007fff 64bit]: no compatible bridge window
[   51.138580] pci 0000:02:08.1: can't claim BAR 3 [mem 0x1ff00008000-0x1ff00009fff 64bit]: no compatible bridge window
[   51.138639] pci 0000:02:05.0: can't claim BAR 1 [mem 0x1ff0000a000-0x1ff0000bfff]: no compatible bridge window
[   51.138695] pci 0000:02:05.0: can't claim BAR 6 [mem 0x1ff00020000-0x1ff0003ffff]: no compatible bridge window

> > http://kodu.ut.ee/~mroos/dm/dm.v120

Still present in 4.8.0-09031-g95107b3:

[   51.025122] pci 0000:00:01.0: can't claim BAR 8 [mem 0x1ff00000000-0x1ffbfffffff]: address conflict with Video RAM area [??? 0x1ff000a0000-0x1ff000bffff flags 0x80000000]
[   51.025240] pci 0000:02:08.0: can't claim BAR 1 [mem 0x1ff00002000-0x1ff00003fff 64bit]: no compatible bridge window
[   51.025302] pci 0000:02:08.0: can't claim BAR 3 [mem 0x1ff00004000-0x1ff00005fff 64bit]: no compatible bridge window
[   51.025363] pci 0000:02:08.1: can't claim BAR 1 [mem 0x1ff00006000-0x1ff00007fff 64bit]: no compatible bridge window
[   51.025423] pci 0000:02:08.1: can't claim BAR 3 [mem 0x1ff00008000-0x1ff00009fff 64bit]: no compatible bridge window

> > http://kodu.ut.ee/~mroos/dm/dm.v210

Still present in 4.8.0:

Oct  5 13:56:52 v210 kernel: [   39.003270] PCI: Claiming 0001:00:07.0: Resource 0: 000007fe01000000..000007fe0100ffff [101]
Oct  5 13:56:52 v210 kernel: [   39.003309] pci 0001:00:07.0: can't claim BAR 0 [io  0x7fe01000000-0x7fe0100ffff]: address conflict with 0001:00:06.0 [io  0x7fe01000600-0x7fe0100061f]Oct  5 13:56:52 v210 kernel: [   39.003350] PCI: Claiming 0001:00:07.0: Resource 1: 000007ff00000000..000007ff000fffff [200]
Oct  5 13:56:52 v210 kernel: [   39.003389] pci 0001:00:07.0: can't claim BAR 1 [mem 0x7ff00000000-0x7ff000fffff]: address conflict with Video RAM area [??? 0x7ff000a0000-0x7ff000bffff flags 0x80000000]
Oct  5 13:56:52 v210 kernel: [   39.003437] PCI: Claiming 0001:00:07.0: Resource 2: 000007ff00000000..000007ff000fffff [200]
Oct  5 13:56:52 v210 kernel: [   39.003474] pci 0001:00:07.0: can't claim BAR 2 [mem 0x7ff00000000-0x7ff000fffff]: address conflict with Video RAM area [??? 0x7ff000a0000-0x7ff000bffff flags 0x80000000]


> > http://kodu.ut.ee/~mroos/dm/dm.v240

Still present in 4.8.0-09031-g95107b3:

[   41.120991] pci 0001:00:07.0: can't claim BAR 0 [io  0x7fe01000000-0x7fe0100ffff]: address conflict with 0001:00:06.0 [io  0x7fe01000600-0x7fe0100061f]
[   41.121054] pci 0001:00:07.0: can't claim BAR 1 [mem 0x7ff00000000-0x7ff000fffff]: address conflict with Video RAM area [??? 0x7ff000a0000-0x7ff000bffff flags 0x80000000]
[   41.121122] pci 0001:00:07.0: can't claim BAR 2 [mem 0x7ff00000000-0x7ff000fffff]: address conflict with Video RAM area [??? 0x7ff000a0000-0x7ff000bffff flags 0x80000000]

> > http://kodu.ut.ee/~mroos/dm/dm.sb100

Still present in 4.9.0-rc1-00067-g1a1891d:

[   41.280647] pci 0000:00:07.0: can't claim BAR 0 [io  0x1fe02000000-0x1fe0200ffff]: address conflict with 0000:00:03.0 [io  0x1fe02000600-0x1fe0200061f]
[   41.282521] pci 0000:00:07.0: can't claim BAR 1 [mem 0x1ff00000000-0x1ff000fffff]: address conflict with Video RAM area [??? 0x1ff000a0000-0x1ff000bffff flags 0x80000000]

> > amd64 machine:
> > 
> > http://kodu.ut.ee/~mroos/dm/dm.x2100

Still present in 4.8.0:

[    0.242410] pci 0000:00:01.1: can't claim BAR 4 [io  0x1c00-0x1c3f]: no compatible bridge window
[    0.242609] pci 0000:00:01.1: can't claim BAR 5 [io  0x1c40-0x1c7f]: no compatible bridge window

-- 
Meelis Roos (mroos@linux.ee)
