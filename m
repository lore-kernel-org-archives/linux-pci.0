Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qa0-f44.google.com ([209.85.216.44]:63841 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752420AbaJBO0c (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 2 Oct 2014 10:26:32 -0400
Received: by mail-qa0-f44.google.com with SMTP id x12so1729414qac.3
        for <linux-pci@vger.kernel.org>; Thu, 02 Oct 2014 07:26:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <bug-85441-41252@https.bugzilla.kernel.org/>
References: <bug-85441-41252@https.bugzilla.kernel.org/>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 2 Oct 2014 08:26:11 -0600
Message-ID: <CAErSpo7FGmkti2sRPtroouLkyt20-YwPukfxh87=cdhaGtVeNw@mail.gmail.com>
Subject: Re: [Bug 85441] New: [vfio] [lockdep] Deadlock when attempting to
 unbind device from a running VM
To: "alex.williamson@redhat.com" <alex.williamson@redhat.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, marti@juffo.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+ Alex, linux-pci, kvm]

On Thu, Oct 2, 2014 at 4:11 AM,  <bugzilla-daemon@bugzilla.kernel.org> wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=85441
>
>             Bug ID: 85441
>            Summary: [vfio] [lockdep] Deadlock when attempting to unbind
>                     device from a running VM
>            Product: Drivers
>            Version: 2.5
>     Kernel Version: 3.17.0-rc7  and  Ubuntu 3.13.0-36-generic
>           Hardware: x86-64
>                 OS: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: PCI
>           Assignee: drivers_pci@kernel-bugs.osdl.org
>           Reporter: marti@juffo.org
>         Regression: No
>
> In order to assign a PCI device to a guest VM (using QEMU), we have a Python
> script that unbinds all devices in the same IOMMU group and binds them to
> pci-stub.
>
> When I run this script while the VM is running, it will hang forever, waiting
> for this lock to be freed (causing a "task python3:xxxx blocked for more than
> 120 seconds" error). Instead, it should probably fail immediately if the device
> cannot be freed.
>
> Then, when I restart the Windows VM using this PCI device, while Python is
> hanging, it causes the QEMU process to lock up as well -- this is in the 3.13
> kernel.
>
> I rebuilt the 3.13 Ubuntu kernel using LOCKDEP, but relevant locks appear to be
> using __lockdep_no_validate__. Here are the hung task reports:
>
> ======================================================
> INFO: task qemu-system-x86:2828 blocked for more than 120 seconds.
>       Tainted: G            X 3.13.11.7 #1
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> qemu-system-x86 D ffffffff81c154c0     0  2828      1 0x00000000
>  ffff88039aa81d50 0000000000000046 ffff880411194240 ffff88039aa81fd8
>  00000000000150c0 00000000000150c0 ffff880411194240 ffff880429100000
>  ffff8804291000f8 ffff880429100100 0000000000000246 ffff880411194240
> Call Trace:
>  [<ffffffff81734439>] schedule_preempt_disabled+0x29/0x70
>  [<ffffffff8173715d>] mutex_lock_nested+0x16d/0x4b0
>  [<ffffffff813c4c41>] ? pci_reset_function+0x51/0xa0
>  [<ffffffff813c4c41>] pci_reset_function+0x51/0xa0
>  [<ffffffffa0140c70>] vfio_pci_ioctl+0xf0/0xa40 [vfio_pci]
>  [<ffffffff810b53ef>] ? up_read+0x1f/0x40
>  [<ffffffff8173dd04>] ? __do_page_fault+0x214/0x580
>  [<ffffffff817393ac>] ? _raw_spin_unlock_irq+0x2c/0x40
>  [<ffffffffa01291a3>] vfio_device_fops_unl_ioctl+0x23/0x30 [vfio]
>  [<ffffffff811e3b00>] do_vfs_ioctl+0x300/0x520
>  [<ffffffff811eee9a>] ? fget_light+0xca/0x140
>  [<ffffffff811e3da1>] SyS_ioctl+0x81/0xa0
>  [<ffffffff8174282d>] system_call_fastpath+0x1a/0x1f
> 1 lock held by qemu-system-x86/2828:
>  #0:  (&__lockdep_no_validate__){......}, at: [<ffffffff813c4c41>]
> pci_reset_function+0x51/0xa0
> INFO: task python3:3206 blocked for more than 120 seconds.
>       Tainted: G            X 3.13.11.7 #1
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> python3         D ffff880429552120     0  3206   3205 0x00000000
>  ffff88038d425d68 0000000000000046 ffff88038d69c240 ffff88038d425fd8
>  00000000000150c0 00000000000150c0 ffff88038d69c240 ffff88042961f400
>  ffff880429100098 ffff88042370cc00 ffff8804285ff400 ffffffffffffffed
> Call Trace:
>  [<ffffffff81733eb9>] schedule+0x29/0x70
>  [<ffffffffa012a37a>] vfio_del_group_dev+0xaa/0x140 [vfio]
>  [<ffffffff810af3f0>] ? prepare_to_wait_event+0x100/0x100
>  [<ffffffffa014010b>] vfio_pci_remove+0x1b/0x40 [vfio_pci]
>  [<ffffffff813c7a3b>] pci_device_remove+0x3b/0xb0
>  [<ffffffff814b441f>] __device_release_driver+0x7f/0xf0
>  [<ffffffff814b44b5>] device_release_driver+0x25/0x40
>  [<ffffffff814b318f>] unbind_store+0xbf/0xe0
>  [<ffffffff814b2584>] drv_attr_store+0x24/0x40
>  [<ffffffff8124c3e9>] sysfs_write_file+0x179/0x1c0
>  [<ffffffff811cfb54>] vfs_write+0xb4/0x1f0
>  [<ffffffff811d0589>] SyS_write+0x49/0xa0
>  [<ffffffff8174282d>] system_call_fastpath+0x1a/0x1f
> 5 locks held by python3/3206:
>  #0:  (sb_writers#5){.+.+.+}, at: [<ffffffff811cfc13>] vfs_write+0x173/0x1f0
>  #1:  (&of->mutex){+.+.+.}, at: [<ffffffff8124c36a>]
> sysfs_write_file+0xfa/0x1c0
>  #2:  (s_active#3){++++.+}, at: [<ffffffff8124c372>]
> sysfs_write_file+0x102/0x1c0
>  #3:  (&__lockdep_no_validate__){......}, at: [<ffffffff814b317f>]
> unbind_store+0xaf/0xe0
>  #4:  (&__lockdep_no_validate__){......}, at: [<ffffffff814b44ad>]
> device_release_driver+0x1d/0x40
> ======================================================
>
>
> I retried the same using kernel 3.17-rc7; the Python process messing with /sys
> fs still hangs. I have not been able to reproduce the QEMU hang, but when I
> tried, got the LOCKDEP error report below:
>
> ======================================================
> [ INFO: possible circular locking dependency detected ]
> 3.17.0-rc7+ #2 Tainted: G            E
> -------------------------------------------------------
> python3/2563 is trying to acquire lock:
>  (&group->device_lock){+.+.+.}, at: [<ffffffffa0196ef4>]
> vfio_group_get_device+0x24/0xb0 [vfio]
>
> but task is already holding lock:
>  (driver_lock){+.+.+.}, at: [<ffffffffa01d01cd>] vfio_pci_remove+0x1d/0x60
> [vfio_pci]
>
> which lock already depends on the new lock.
>
>
> the existing dependency chain (in reverse order) is:
>
> -> #1 (driver_lock){+.+.+.}:
>        [<ffffffff810bc650>] lock_acquire+0xb0/0x140
>        [<ffffffff817602e0>] mutex_lock_nested+0x50/0x4c0
>        [<ffffffffa01d0618>] vfio_pci_open+0x38/0x270 [vfio_pci]
>        [<ffffffffa0197c35>] vfio_group_fops_unl_ioctl+0x265/0x490 [vfio]
>        [<ffffffff811fc160>] do_vfs_ioctl+0x300/0x520
>        [<ffffffff811fc401>] SyS_ioctl+0x81/0xa0
>        [<ffffffff817633ad>] system_call_fastpath+0x1a/0x1f
>
> -> #0 (&group->device_lock){+.+.+.}:
>        [<ffffffff810bc532>] __lock_acquire+0x1c22/0x1c90
>        [<ffffffff810bc650>] lock_acquire+0xb0/0x140
>        [<ffffffff817602e0>] mutex_lock_nested+0x50/0x4c0
>        [<ffffffffa0196ef4>] vfio_group_get_device+0x24/0xb0 [vfio]
>        [<ffffffffa019737f>] vfio_del_group_dev+0x4f/0x140 [vfio]
>        [<ffffffffa01d01d9>] vfio_pci_remove+0x29/0x60 [vfio_pci]
>        [<ffffffff813d838b>] pci_device_remove+0x3b/0xb0
>        [<ffffffff814c874f>] __device_release_driver+0x7f/0xf0
>        [<ffffffff814c87e5>] device_release_driver+0x25/0x40
>        [<ffffffff814c755f>] unbind_store+0xbf/0xe0
>        [<ffffffff814c6924>] drv_attr_store+0x24/0x40
>        [<ffffffff81263a44>] sysfs_kf_write+0x44/0x60
>        [<ffffffff81263347>] kernfs_fop_write+0xe7/0x170
>        [<ffffffff811e84c7>] vfs_write+0xb7/0x1f0
>        [<ffffffff811e9079>] SyS_write+0x49/0xb0
>        [<ffffffff817633ad>] system_call_fastpath+0x1a/0x1f
>
> other info that might help us debug this:
>
>  Possible unsafe locking scenario:
>
>        CPU0                    CPU1
>        ----                    ----
>   lock(driver_lock);
>                                lock(&group->device_lock);
>                                lock(driver_lock);
>   lock(&group->device_lock);
>
>  *** DEADLOCK ***
>
> 6 locks held by python3/2563:
>  #0:  (sb_writers#5){.+.+.+}, at: [<ffffffff811e85c3>] vfs_write+0x1b3/0x1f0
>  #1:  (&of->mutex){+.+.+.}, at: [<ffffffff8126331b>]
> kernfs_fop_write+0xbb/0x170
>  #2:  (s_active#3){++++.+}, at: [<ffffffff81263323>]
> kernfs_fop_write+0xc3/0x170
>  #3:  (&dev->mutex){......}, at: [<ffffffff814c754f>] unbind_store+0xaf/0xe0
>  #4:  (&dev->mutex){......}, at: [<ffffffff814c87dd>]
> device_release_driver+0x1d/0x40
>  #5:  (driver_lock){+.+.+.}, at: [<ffffffffa01d01cd>] vfio_pci_remove+0x1d/0x60
> [vfio_pci]
>
> stack backtrace:
> CPU: 1 PID: 2563 Comm: python3 Tainted: G            E  3.17.0-rc7+ #2
> Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./FM2A88X Extreme6+,
> BIOS P3.30 07/31/2014
>  ffffffff826c0870 ffff88038fcdbb60 ffffffff8175971d ffffffff826c0870
>  ffff88038fcdbba0 ffffffff817550e5 ffff88038fcdbbf0 ffff88040bdc4dc0
>  0000000000000005 ffff88040bdc4d98 ffff88040bdc4dc0 ffff88040bdc4440
> Call Trace:
>  [<ffffffff8175971d>] dump_stack+0x45/0x56
>  [<ffffffff817550e5>] print_circular_bug+0x1f9/0x207
>  [<ffffffff810bc532>] __lock_acquire+0x1c22/0x1c90
>  [<ffffffff810b73ba>] ? __bfs+0x10a/0x220
>  [<ffffffff810bc650>] lock_acquire+0xb0/0x140
>  [<ffffffffa0196ef4>] ? vfio_group_get_device+0x24/0xb0 [vfio]
>  [<ffffffff817602e0>] mutex_lock_nested+0x50/0x4c0
>  [<ffffffffa0196ef4>] ? vfio_group_get_device+0x24/0xb0 [vfio]
>  [<ffffffff810b96fa>] ? mark_held_locks+0x6a/0x90
>  [<ffffffffa0196ef4>] vfio_group_get_device+0x24/0xb0 [vfio]
>  [<ffffffffa019737f>] vfio_del_group_dev+0x4f/0x140 [vfio]
>  [<ffffffff810b993d>] ? trace_hardirqs_on+0xd/0x10
>  [<ffffffffa01d01d9>] vfio_pci_remove+0x29/0x60 [vfio_pci]
>  [<ffffffff813d838b>] pci_device_remove+0x3b/0xb0
>  [<ffffffff814c874f>] __device_release_driver+0x7f/0xf0
>  [<ffffffff814c87e5>] device_release_driver+0x25/0x40
>  [<ffffffff814c755f>] unbind_store+0xbf/0xe0
>  [<ffffffff814c6924>] drv_attr_store+0x24/0x40
>  [<ffffffff81263a44>] sysfs_kf_write+0x44/0x60
>  [<ffffffff81263347>] kernfs_fop_write+0xe7/0x170
>  [<ffffffff811e84c7>] vfs_write+0xb7/0x1f0
>  [<ffffffff811e9079>] SyS_write+0x49/0xb0
>  [<ffffffff817633ad>] system_call_fastpath+0x1a/0x1f
> ======================================================
>
> --
> You are receiving this mail because:
> You are watching the assignee of the bug.
