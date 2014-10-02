Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56718 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752171AbaJBOnL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 2 Oct 2014 10:43:11 -0400
Message-ID: <1412260987.7360.258.camel@ul30vt.home>
Subject: Re: [Bug 85441] New: [vfio] [lockdep] Deadlock when attempting to
 unbind device from a running VM
From: Alex Williamson <alex.williamson@redhat.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, marti@juffo.org
Date: Thu, 02 Oct 2014 08:43:07 -0600
In-Reply-To: <CAErSpo7FGmkti2sRPtroouLkyt20-YwPukfxh87=cdhaGtVeNw@mail.gmail.com>
References: <bug-85441-41252@https.bugzilla.kernel.org/>
	 <CAErSpo7FGmkti2sRPtroouLkyt20-YwPukfxh87=cdhaGtVeNw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2014-10-02 at 08:26 -0600, Bjorn Helgaas wrote:
> [+ Alex, linux-pci, kvm]
> 
> On Thu, Oct 2, 2014 at 4:11 AM,  <bugzilla-daemon@bugzilla.kernel.org> wrote:
> > https://bugzilla.kernel.org/show_bug.cgi?id=85441
> >
> > I retried the same using kernel 3.17-rc7; the Python process messing with /sys
> > fs still hangs. I have not been able to reproduce the QEMU hang, but when I
> > tried, got the LOCKDEP error report below:


I replied in the bz, but for any spectators, the 3.17 deadlock is new to
3.17 and fixed by this, which will hopefully be included in 3.17.1:

https://lkml.org/lkml/2014/9/29/745

I believe the locking issues in older kernels are already fixed in newer
kernels.  Thanks,

Alex

> > ======================================================
> > [ INFO: possible circular locking dependency detected ]
> > 3.17.0-rc7+ #2 Tainted: G            E
> > -------------------------------------------------------
> > python3/2563 is trying to acquire lock:
> >  (&group->device_lock){+.+.+.}, at: [<ffffffffa0196ef4>]
> > vfio_group_get_device+0x24/0xb0 [vfio]
> >
> > but task is already holding lock:
> >  (driver_lock){+.+.+.}, at: [<ffffffffa01d01cd>] vfio_pci_remove+0x1d/0x60
> > [vfio_pci]
> >
> > which lock already depends on the new lock.
> >
> >
> > the existing dependency chain (in reverse order) is:
> >
> > -> #1 (driver_lock){+.+.+.}:
> >        [<ffffffff810bc650>] lock_acquire+0xb0/0x140
> >        [<ffffffff817602e0>] mutex_lock_nested+0x50/0x4c0
> >        [<ffffffffa01d0618>] vfio_pci_open+0x38/0x270 [vfio_pci]
> >        [<ffffffffa0197c35>] vfio_group_fops_unl_ioctl+0x265/0x490 [vfio]
> >        [<ffffffff811fc160>] do_vfs_ioctl+0x300/0x520
> >        [<ffffffff811fc401>] SyS_ioctl+0x81/0xa0
> >        [<ffffffff817633ad>] system_call_fastpath+0x1a/0x1f
> >
> > -> #0 (&group->device_lock){+.+.+.}:
> >        [<ffffffff810bc532>] __lock_acquire+0x1c22/0x1c90
> >        [<ffffffff810bc650>] lock_acquire+0xb0/0x140
> >        [<ffffffff817602e0>] mutex_lock_nested+0x50/0x4c0
> >        [<ffffffffa0196ef4>] vfio_group_get_device+0x24/0xb0 [vfio]
> >        [<ffffffffa019737f>] vfio_del_group_dev+0x4f/0x140 [vfio]
> >        [<ffffffffa01d01d9>] vfio_pci_remove+0x29/0x60 [vfio_pci]
> >        [<ffffffff813d838b>] pci_device_remove+0x3b/0xb0
> >        [<ffffffff814c874f>] __device_release_driver+0x7f/0xf0
> >        [<ffffffff814c87e5>] device_release_driver+0x25/0x40
> >        [<ffffffff814c755f>] unbind_store+0xbf/0xe0
> >        [<ffffffff814c6924>] drv_attr_store+0x24/0x40
> >        [<ffffffff81263a44>] sysfs_kf_write+0x44/0x60
> >        [<ffffffff81263347>] kernfs_fop_write+0xe7/0x170
> >        [<ffffffff811e84c7>] vfs_write+0xb7/0x1f0
> >        [<ffffffff811e9079>] SyS_write+0x49/0xb0
> >        [<ffffffff817633ad>] system_call_fastpath+0x1a/0x1f
> >
> > other info that might help us debug this:
> >
> >  Possible unsafe locking scenario:
> >
> >        CPU0                    CPU1
> >        ----                    ----
> >   lock(driver_lock);
> >                                lock(&group->device_lock);
> >                                lock(driver_lock);
> >   lock(&group->device_lock);
> >
> >  *** DEADLOCK ***
> >
> > 6 locks held by python3/2563:
> >  #0:  (sb_writers#5){.+.+.+}, at: [<ffffffff811e85c3>] vfs_write+0x1b3/0x1f0
> >  #1:  (&of->mutex){+.+.+.}, at: [<ffffffff8126331b>]
> > kernfs_fop_write+0xbb/0x170
> >  #2:  (s_active#3){++++.+}, at: [<ffffffff81263323>]
> > kernfs_fop_write+0xc3/0x170
> >  #3:  (&dev->mutex){......}, at: [<ffffffff814c754f>] unbind_store+0xaf/0xe0
> >  #4:  (&dev->mutex){......}, at: [<ffffffff814c87dd>]
> > device_release_driver+0x1d/0x40
> >  #5:  (driver_lock){+.+.+.}, at: [<ffffffffa01d01cd>] vfio_pci_remove+0x1d/0x60
> > [vfio_pci]
> >
> > stack backtrace:
> > CPU: 1 PID: 2563 Comm: python3 Tainted: G            E  3.17.0-rc7+ #2
> > Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./FM2A88X Extreme6+,
> > BIOS P3.30 07/31/2014
> >  ffffffff826c0870 ffff88038fcdbb60 ffffffff8175971d ffffffff826c0870
> >  ffff88038fcdbba0 ffffffff817550e5 ffff88038fcdbbf0 ffff88040bdc4dc0
> >  0000000000000005 ffff88040bdc4d98 ffff88040bdc4dc0 ffff88040bdc4440
> > Call Trace:
> >  [<ffffffff8175971d>] dump_stack+0x45/0x56
> >  [<ffffffff817550e5>] print_circular_bug+0x1f9/0x207
> >  [<ffffffff810bc532>] __lock_acquire+0x1c22/0x1c90
> >  [<ffffffff810b73ba>] ? __bfs+0x10a/0x220
> >  [<ffffffff810bc650>] lock_acquire+0xb0/0x140
> >  [<ffffffffa0196ef4>] ? vfio_group_get_device+0x24/0xb0 [vfio]
> >  [<ffffffff817602e0>] mutex_lock_nested+0x50/0x4c0
> >  [<ffffffffa0196ef4>] ? vfio_group_get_device+0x24/0xb0 [vfio]
> >  [<ffffffff810b96fa>] ? mark_held_locks+0x6a/0x90
> >  [<ffffffffa0196ef4>] vfio_group_get_device+0x24/0xb0 [vfio]
> >  [<ffffffffa019737f>] vfio_del_group_dev+0x4f/0x140 [vfio]
> >  [<ffffffff810b993d>] ? trace_hardirqs_on+0xd/0x10
> >  [<ffffffffa01d01d9>] vfio_pci_remove+0x29/0x60 [vfio_pci]
> >  [<ffffffff813d838b>] pci_device_remove+0x3b/0xb0
> >  [<ffffffff814c874f>] __device_release_driver+0x7f/0xf0
> >  [<ffffffff814c87e5>] device_release_driver+0x25/0x40
> >  [<ffffffff814c755f>] unbind_store+0xbf/0xe0
> >  [<ffffffff814c6924>] drv_attr_store+0x24/0x40
> >  [<ffffffff81263a44>] sysfs_kf_write+0x44/0x60
> >  [<ffffffff81263347>] kernfs_fop_write+0xe7/0x170
> >  [<ffffffff811e84c7>] vfs_write+0xb7/0x1f0
> >  [<ffffffff811e9079>] SyS_write+0x49/0xb0
> >  [<ffffffff817633ad>] system_call_fastpath+0x1a/0x1f
> > ======================================================
> >

