Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:42652 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750786AbdEUGRi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 21 May 2017 02:17:38 -0400
Date: Sun, 21 May 2017 08:17:36 +0200
From: Christoph Hellwig <hch@lst.de>
To: Rakesh Pandit <rakesh@tuxera.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] nvme: pci: Fix NULL dereference when resetting NVMe SSD
Message-ID: <20170521061736.GA12287@lst.de>
References: <20170520175952.GA11258@dhcp-216.srv.tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170520175952.GA11258@dhcp-216.srv.tuxera.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, May 20, 2017 at 08:59:54PM +0300, Rakesh Pandit wrote:
> While doing IO if I reset NVMe SSD (model :Samsung MZVPV512HDGL-00000)
> it doesn't work as expected also results in NULL point dereference and
> system becomes unstable.
> 
> Device's access is successfully disabled and reset attempt does
> successfully complete but restore isn't able to restore NVMe device
> properly.  This patch at least makes the system stable.

Adding linux-pci to the Cc list.  NVMe only clears the driver data
in the ->remove callback, so the trace below looks very odd.  That
being said the issue of PCIe error handling synchronization came
up before and I think we really need to figure out a way to synchronize
the error methods with ->probe / ->remove.  In this case it might have
been the call to device_release_driver from nvme_remove_dead_ctrl_work,
but either way we need something that properly synchronized the
PCIe calls.

Pandit: can you throw a printk into nvme_remove_dead_ctrl_work and
see if it gets called just before you see the NULL pointer dereference?

> [ 1619.130015] BUG: unable to handle kernel NULL pointer dereference at 00000000000001f8
> [ 1619.130059] IP: nvme_reset+0x5/0x60
> [ 1619.130075] PGD 0
> [ 1619.130076] P4D 0
> 
> [ 1619.130103] Oops: 0000 [#1] SMP
> [ 1619.130117] Modules linked in: rfcomm(E) fuse(E) nf_conntrack_netbios_ns(E)......
> [ 1619.130403]  btrtl(E) ath(E) ......
> [ 1619.130701]  usb_storage i2c_hid
> [ 1619.130720] CPU: 0 PID: 31625 Comm: bash Tainted: G        W   E   4.11.0+ #3
> [ 1619.130749] Hardware name: Acer Predator G9-591/Mustang_SLS, BIOS V1.10 03/03/2016
> [ 1619.130780] task: ffff880163e48000 task.stack: ffffc900085c4000
> [ 1619.130807] RIP: 0010:nvme_reset+0x5/0x60
> [ 1619.130825] RSP: 0000:ffffc900085c7d68 EFLAGS: 00010246
> [ 1619.130848] RAX: ffffffff815cc190 RBX: ffff8804aeaa1000 RCX: 0000000000000000
> [ 1619.130877] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> [ 1619.130904] RBP: ffffc900085c7d70 R08: 0000000000000002 R09: ffffc900085c7ca4
> [ 1619.130934] R10: 0000000000000000 R11: 000000000000029e R12: ffff8804aeaa1100
> [ 1619.130962] R13: 0000000000000002 R14: ffffc900085c7f18 R15: fffffffffffffff2
> [ 1619.130994] FS:  00007f692d7cb700(0000) GS:ffff8804c1c00000(0000) knlGS:0000000000000000
> [ 1619.131027] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1619.131052] CR2: 00000000000001f8 CR3: 0000000164483000 CR4: 00000000003406f0
> [ 1619.131083] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 1619.131113] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [ 1619.131144] Call Trace:
> [ 1619.131159]  ? nvme_reset_notify+0x1a/0x30
> [ 1619.131181]  pci_dev_restore+0x38/0x50
> [ 1619.131199]  pci_reset_function+0x65/0x80
> [ 1619.131218]  reset_store+0x54/0x80
> [ 1619.131235]  dev_attr_store+0x18/0x30
> [ 1619.131253]  sysfs_kf_write+0x37/0x40
> [ 1619.131269]  kernfs_fop_write+0x110/0x1a0
> [ 1619.131288]  __vfs_write+0x37/0x140
> [ 1619.131306]  ? selinux_file_permission+0xd7/0x110
> [ 1619.131328]  ? security_file_permission+0x3b/0xc0
> [ 1619.131349]  vfs_write+0xb5/0x1a0
> [ 1619.131366]  SyS_write+0x55/0xc0
> [ 1619.131383]  entry_SYSCALL_64_fastpath+0x1a/0xa5
> [ 1619.131405] RIP: 0033:0x7f692cec1c20
> [ 1619.131421] RSP: 002b:00007ffeea27b938 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> [ 1619.131452] RAX: ffffffffffffffda RBX: 00007f692d18b5e0 RCX: 00007f692cec1c20
> [ 1619.131481] RDX: 0000000000000002 RSI: 000055dcd896ccf0 RDI: 0000000000000001
> [ 1619.131510] RBP: 0000000000000001 R08: 00007f692d18c740 R09: 00007f692d7cb700
> [ 1619.131541] R10: 0000000000000073 R11: 0000000000000246 R12: 000055dcd89a3930
> [ 1619.131571] R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001
> [ 1619.131601] Code: 84 00 00 00 00 00 0f 1f 44 00 00 55 89 f6 48 03
> b7 40 ff ff ff 48 89 e5 48 8b 06 48 89 02 31 c0 5d c3 0f 1f 40 00 0f
> 1f 44 00 00 <48> 8b 87 f8 01 00 00 48 85 c0 74 49 48 8b 80 a0 01 00 00
> a8 20
> [ 1619.131708] RIP: nvme_reset+0x5/0x60 RSP: ffffc900085c7d68
> [ 1619.131732] CR2: 00000000000001f8
> 
> Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
> ---
> 
> This is produce independent of separate issue under discussion
> regarding resetting the device (system hang) and works well with or
> without patch set "nvme: fix hang in path of removing disk".
> 
>  drivers/nvme/host/pci.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 0866f64..fce61eb 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2159,6 +2159,11 @@ static void nvme_reset_notify(struct pci_dev *pdev, bool prepare)
>  {
>  	struct nvme_dev *dev = pci_get_drvdata(pdev);
>  
> +	if (!dev) {
> +		pr_err("reset%s notification to nvme failed",
> +				prepare ? " preparation" : "");
> +		return;
> +	}
>  	if (prepare)
>  		nvme_dev_disable(dev, false);
>  	else
> -- 
> 2.5.5
---end quoted text---
