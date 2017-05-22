Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 22 May 2017 18:38:29 +0300
From: Rakesh Pandit <rakesh@tuxera.com>
To: Christoph Hellwig <hch@lst.de>
CC: <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] nvme: pci: Fix NULL dereference when resetting NVMe SSD
Message-ID: <20170522153829.GA17980@dhcp-216.srv.tuxera.com>
References: <20170520175952.GA11258@dhcp-216.srv.tuxera.com>
 <20170521061736.GA12287@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20170521061736.GA12287@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, May 21, 2017 at 08:17:36AM +0200, Christoph Hellwig wrote:
> On Sat, May 20, 2017 at 08:59:54PM +0300, Rakesh Pandit wrote:
> > While doing IO if I reset NVMe SSD (model :Samsung MZVPV512HDGL-00000)
> > it doesn't work as expected also results in NULL point dereference and
> > system becomes unstable.
> > 
> > Device's access is successfully disabled and reset attempt does
> > successfully complete but restore isn't able to restore NVMe device
> > properly.  This patch at least makes the system stable.
> 
> Adding linux-pci to the Cc list.  NVMe only clears the driver data
> in the ->remove callback, so the trace below looks very odd.  That
> being said the issue of PCIe error handling synchronization came
> up before and I think we really need to figure out a way to synchronize
> the error methods with ->probe / ->remove.  In this case it might have
> been the call to device_release_driver from nvme_remove_dead_ctrl_work,
> but either way we need something that properly synchronized the
> PCIe calls.
> 
> Pandit: can you throw a printk into nvme_remove_dead_ctrl_work and
> see if it gets called just before you see the NULL pointer dereference?
> 

.....

Just got to use the using the test box again and you are right that
nvme_remove_dead_ctrl_work is getting called just before the NULL
pointer dereference.

Here call trace to nvme_timeout which results in eventually call to
nvme_reset when it wants to reset the controller (which races with
->reset_notify from PCI layer):

[  392.923177] Call Trace:
[  392.923187]  dump_stack+0x63/0x82
[  392.923192]  nvme_timeout+0xb4/0x220
[  392.923199]  ? update_load_avg+0x429/0x5a0
[  392.923205]  blk_mq_rq_timed_out+0x2f/0x70
[  392.923208]  blk_mq_check_expired+0x50/0x60
[  392.923211]  bt_iter+0x48/0x50
[  392.923215]  blk_mq_queue_tag_busy_iter+0xe2/0x1f0
[  392.923220]  ? blk_mq_rq_timed_out+0x70/0x70
[  392.923225]  ? blk_mq_rq_timed_out+0x70/0x70
[  392.923231]  blk_mq_timeout_work+0xb6/0x170
[  392.923235]  process_one_work+0x18c/0x3a0
[  392.923239]  worker_thread+0x4e/0x3b0
[  392.923244]  kthread+0x109/0x140
[  392.923247]  ? process_one_work+0x3a0/0x3a0
[  392.923252]  ? kthread_park+0x60/0x60
[  392.923256]  ret_from_fork+0x2c/0x40
[  392.923264] nvme nvme0: I/O 125 QID 0 timeout, reset controller


> > [ 1619.130015] BUG: unable to handle kernel NULL pointer dereference at 00000000000001f8
...
> > [ 1619.131144] Call Trace:
> > [ 1619.131159]  ? nvme_reset_notify+0x1a/0x30
> > [ 1619.131181]  pci_dev_restore+0x38/0x50
> > [ 1619.131199]  pci_reset_function+0x65/0x80
> > [ 1619.131218]  reset_store+0x54/0x80
> > [ 1619.131235]  dev_attr_store+0x18/0x30
> > [ 1619.131253]  sysfs_kf_write+0x37/0x40
> > [ 1619.131269]  kernfs_fop_write+0x110/0x1a0
> > [ 1619.131288]  __vfs_write+0x37/0x140
> > [ 1619.131306]  ? selinux_file_permission+0xd7/0x110
> > [ 1619.131328]  ? security_file_permission+0x3b/0xc0
> > [ 1619.131349]  vfs_write+0xb5/0x1a0
> > [ 1619.131366]  SyS_write+0x55/0xc0
> > [ 1619.131383]  entry_SYSCALL_64_fastpath+0x1a/0xa5
...
> > [ 1619.131708] RIP: nvme_reset+0x5/0x60 RSP: ffffc900085c7d68
> > [ 1619.131732] CR2: 00000000000001f8
> > 
> > Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
> > ---
> > 
> > This is produce independent of separate issue under discussion
> > regarding resetting the device (system hang) and works well with or
> > without patch set "nvme: fix hang in path of removing disk".
> > 
> >  drivers/nvme/host/pci.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > index 0866f64..fce61eb 100644
> > --- a/drivers/nvme/host/pci.c
> > +++ b/drivers/nvme/host/pci.c
> > @@ -2159,6 +2159,11 @@ static void nvme_reset_notify(struct pci_dev *pdev, bool prepare)
> >  {
> >  	struct nvme_dev *dev = pci_get_drvdata(pdev);
> >  
> > +	if (!dev) {
> > +		pr_err("reset%s notification to nvme failed",
> > +				prepare ? " preparation" : "");
> > +		return;
> > +	}
> >  	if (prepare)
> >  		nvme_dev_disable(dev, false);
> >  	else
> > -- 
> > 2.5.5
> ---end quoted text---
