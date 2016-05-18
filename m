Return-Path: <mika.westerberg@linux.intel.com>
Return-Path: <mika.westerberg@linux.intel.com>
Date: Wed, 18 May 2016 11:54:59 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: next-20160517 - lockdep splat in pcie code
Message-ID: <20160518085459.GD1994@lahna>
References: <4249.1463510162@turing-police.cc.vt.edu>
 <20160517193742.GA10755@localhost>
 <20160517221248.GA3068@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160517221248.GA3068@wunner.de>
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 18, 2016 at 12:12:48AM +0200, Lukas Wunner wrote:
> Hi,
> 
> On Tue, May 17, 2016 at 02:37:42PM -0500, Bjorn Helgaas wrote:
> > [+cc Lukas, Mika]
> > On Tue, May 17, 2016 at 02:36:02PM -0400, Valdis Kletnieks wrote:
> > > Seen during boot on next-20160517. This apparently sneaked into the tree
> > > sometime after -0502 (probably after -0512 but I can't prove it at the moment)
> > > 
> > > [    1.806765] INFO: trying to register non-static key.
> > > [    1.806772] the code is fine but needs lockdep annotation.
> > > [    1.806777] turning off the locking correctness validator.
> > > [    1.806786] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.6.0-next-20160517-00001-gede618fce89c-dirty #276
> > > [    1.806794] Hardware name: Dell Inc. Latitude E6530/07Y85M, BIOS A17 08/19/2015
> > > [    1.806802]  0000000000000086 000000009200d6c8 ffff88022ca23a90 ffffffffa83f99f3
> > > [    1.806815]  0000000000000000 ffff880223727d40 ffff88022ca23b00 ffffffffa80c1de1
> > > [    1.806826]  0000000000000246 0000000000000000 ffffffffffffffff ffff88022ca23ad8
> > > [    1.806834] Call Trace:
> > > [    1.806845]  [<ffffffffa83f99f3>] dump_stack+0x68/0x95
> > > [    1.806855]  [<ffffffffa80c1de1>] register_lock_class+0x541/0x550
> > > [    1.806861]  [<ffffffffa8404b6c>] ? widen_string+0x3c/0xf0
> > > [    1.806870]  [<ffffffffa80c4108>] __lock_acquire+0x88/0x1260
> > > [    1.806876]  [<ffffffffa840751a>] ? vsnprintf+0x36a/0x520
> > > [    1.806886]  [<ffffffffa81bdfc1>] ? kfree_const+0x21/0x30
> > > [    1.806893]  [<ffffffffa80c56d1>] lock_acquire+0xb1/0x200
> > > [    1.806904]  [<ffffffffa852874e>] ? pm_runtime_no_callbacks+0x1e/0x40
> > > [    1.806915]  [<ffffffffa8a07831>] _raw_spin_lock_irq+0x41/0x50
> > > [    1.806923]  [<ffffffffa852874e>] ? pm_runtime_no_callbacks+0x1e/0x40
> > > [    1.806932]  [<ffffffffa852874e>] pm_runtime_no_callbacks+0x1e/0x40
> > > [    1.806942]  [<ffffffffa844fe36>] pcie_port_device_register+0x226/0x560
> > > [    1.806950]  [<ffffffffa8450542>] pcie_portdrv_probe+0x32/0xa0
> > 
> > Probably introduced by this:
> > 
> > http://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?id=0195d2813547
> > 
> > I dropped the pci/pm branch for now.

For some reason I did not have lock debugging enabled in my .config so I
have not seen this in my testing. Sorry about that.

> Okay this is caused by pm_runtime_no_callbacks() acquiring dev->power.lock
> before spin_lock_init() has been called. The spinlock is initialized in
> device_pm_init_common(), which is called from device_pm_init(), which is
> called from device_initialize(), which is the first half of
> device_register().
> 
> The solution is to either
> (1) move the call to pm_runtime_no_callbacks() after the call to
>     device_register() or

This sounds like the right thing to do.

> (2) replace the call to device_register() with calls to device_initialize()
>     and device_add(), then move the call to pm_runtime_no_callbacks()
>     in-between.
> 
> I can barely keep my eyes open right now, I'll look at this with a fresh
> pair of eyeballs tomorrow and cook up, test and submit a fixup patch
> unless Mika or someone else has already done it until then.

The patch following your suggestion is below. Thanks for looking at the
issue.

Valdis,

Can you check if the patch fixes the issue?

-----8<-----8<-----8<-----8<-----8<-----8<-----8<------8<-----8<------

From: Mika Westerberg <mika.westerberg@linux.intel.com>
Date: Wed, 18 May 2016 11:35:09 +0300
Subject: [PATCH] PCI: pcie: Call pm_runtime_no_callbacks() after device is registered

Commit 0195d2813547 ("PCI: Add runtime PM support for PCIe ports") added
call to pm_runtime_no_callbacks() for each port service device to prevent
them exposing unnecessary runtime PM sysfs files. However, that function
tries to acquire dev->power.lock which is not yet initialized.

This triggers following splat:

 BUG: spinlock bad magic on CPU#0, swapper/0/1
  lock: 0xffff8801be2aa8e8, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
 CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.6.0+ #820
  0000000000000000 ffff8801beb97be0 ffffffff812cf42d 0000000000000000
  ffff8801be2aa8e8 ffff8801beb97c00 ffffffff8109ee58 ffff8801be2aa8e8
  ffff8801be2aa8e8 ffff8801beb97c30 ffffffff8109efd9 ffff8801be2aa8e8
 Call Trace:
  [<ffffffff812cf42d>] dump_stack+0x4f/0x72
  [<ffffffff8109ee58>] spin_dump+0x78/0xc0
  [<ffffffff8109efd9>] do_raw_spin_lock+0xf9/0x150
  [<ffffffff81674e10>] _raw_spin_lock_irq+0x20/0x30
  [<ffffffff813d738e>] pm_runtime_no_callbacks+0x1e/0x40
  [<ffffffff81322cad>] pcie_port_device_register+0x1fd/0x4e0
  [<ffffffff813232f8>] pcie_portdrv_probe+0x38/0xa0
  [<ffffffff81314fb5>] local_pci_probe+0x45/0xa0
  [<ffffffff81315fe0>] ? pci_match_device+0xe0/0x110
  [<ffffffff813163ab>] pci_device_probe+0xdb/0x130
  [<ffffffff813ccefc>] driver_probe_device+0x22c/0x440
  [<ffffffff813cd1e1>] __driver_attach+0xd1/0xf0
  [<ffffffff813cd110>] ? driver_probe_device+0x440/0x440
  [<ffffffff813caab4>] bus_for_each_dev+0x64/0xa0
  [<ffffffff813cc60e>] driver_attach+0x1e/0x20
  [<ffffffff813cc0cb>] bus_add_driver+0x1eb/0x280
  [<ffffffff81d36cdc>] ? pcie_port_setup+0x7c/0x7c
  [<ffffffff813cdb90>] driver_register+0x60/0xe0
  [<ffffffff813148e0>] __pci_register_driver+0x60/0x70
  [<ffffffff81d36d3f>] pcie_portdrv_init+0x63/0x75
  [<ffffffff810003db>] do_one_initcall+0xab/0x1c0
  [<ffffffff81cff083>] kernel_init_freeable+0x153/0x1d9
  [<ffffffff8166dfce>] kernel_init+0xe/0x100
  [<ffffffff81675612>] ret_from_fork+0x22/0x40
  [<ffffffff8166dfc0>] ? rest_init+0x90/0x90

Fix this by calling pm_runtime_no_callbacks() after device_register() just
like other buses, like I2C is doing already.

Reported-by: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
Suggested-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/pcie/portdrv_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 65b1a624826b..97927dfbbf5f 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -344,7 +344,6 @@ static int pcie_device_init(struct pci_dev *pdev, int service, int irq)
 		     get_descriptor_id(pci_pcie_type(pdev), service));
 	device->parent = &pdev->dev;
 	device_enable_async_suspend(device);
-	pm_runtime_no_callbacks(device);
 
 	retval = device_register(device);
 	if (retval) {
@@ -352,6 +351,8 @@ static int pcie_device_init(struct pci_dev *pdev, int service, int irq)
 		return retval;
 	}
 
+	pm_runtime_no_callbacks(device);
+
 	return 0;
 }
 
-- 
2.8.1
