Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org
Subject: [PATCH] PCI: Fix legacy IRQ assignment execution stage
Date: Thu, 28 Sep 2017 12:37:07 +0100
Message-Id: <1506598627-8985-1-git-send-email-lorenzo.pieralisi@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-kernel@vger.kernel.org,
 linux-ide@vger.kernel.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Guenter Roeck <linux@roeck-us.net>, Bjorn Helgaas <bhelgaas@google.com>,
 Matt Turner <mattst88@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 linux-arm-kernel@lists.infradead.org, Richard Henderson <rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Through struct pci_host_bridge->{map/swizzle}_irq() hooks is now
possible to define IRQ mapping functions on a per PCI host bridge basis.

Actual IRQ allocation is carried out by the pci_assign_irq() function in
pci_device_probe() - to make sure a device is assigned an IRQ only if it
is probed (ie match a driver); it retrieves a struct pci_host_bridge*
for a given PCI device and through {map/swizzle}_irq() hooks it carries
out the PCI IRQ allocation.

As it turned out, some legacy drivers (eg IDE layer) require that a
device allocates IRQ as soon as it is added so that its actual IRQ
settings are available early in the boot process. With current code
calling pci_assign_irq() in pci_device_probe() IDE IRQ probing fails
for some drivers:

ide0: disabled, no IRQ
ide0: failed to initialize IDE interface
ide0: disabling port
cmd64x 0000:00:02.0: IDE controller (0x1095:0x0646 rev 0x07)
CMD64x_IDE 0000:00:02.0: BAR 0: can't reserve [io  0x8050-0x8057]
cmd64x 0000:00:02.0: can't reserve resources
CMD64x_IDE: probe of 0000:00:02.0 failed with error -16
ide_generic: please use "probe_mask=0x3f" module parameter for probing
all legacy ISA IDE ports
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1 at fs/sysfs/dir.c:31 sysfs_warn_dup+0x94/0xd0
sysfs: cannot create duplicate filename '/class/ide_port/ide0'
...

Trace:
[<fffffc00003308a0>] __warn+0x160/0x190
[<fffffc000048c9f4>] sysfs_warn_dup+0x94/0xd0
[<fffffc0000330928>] warn_slowpath_fmt+0x58/0x70
[<fffffc000048c9f4>] sysfs_warn_dup+0x94/0xd0
[<fffffc0000486d40>] kernfs_path_from_node+0x30/0x60
[<fffffc00004874ac>] kernfs_put+0x16c/0x2c0
[<fffffc00004874ac>] kernfs_put+0x16c/0x2c0
[<fffffc000048d010>] sysfs_do_create_link_sd.isra.2+0x100/0x120
[<fffffc00005b9d64>] device_add+0x2a4/0x7c0
[<fffffc00005ba5cc>] device_create_groups_vargs+0x14c/0x170
[<fffffc00005ba518>] device_create_groups_vargs+0x98/0x170
[<fffffc00005ba690>] device_create+0x50/0x70
[<fffffc00005df36c>] ide_host_register+0x48c/0xa00
[<fffffc00005df330>] ide_host_register+0x450/0xa00
[<fffffc00005ba2a0>] device_register+0x20/0x50
[<fffffc00005df330>] ide_host_register+0x450/0xa00
[<fffffc00005df944>] ide_host_add+0x64/0xe0
[<fffffc000079b41c>] kobject_uevent_env+0x16c/0x710
[<fffffc0000310288>] do_one_initcall+0x68/0x260
[<fffffc00007b13bc>] kernel_init+0x1c/0x1a0
[<fffffc00007b13a0>] kernel_init+0x0/0x1a0
[<fffffc0000311868>] ret_from_kernel_thread+0x18/0x20
[<fffffc00007b13a0>] kernel_init+0x0/0x1a0

---[ end trace 24a70433c3e4d374 ]---
ide0: disabling port

Fix the IRQ allocation issue by moving the pci_assign_irq() call from
pci_device_probe() to pci_device_add(), so that IRQs for a given PCI
device are allocated as soon as it is scanned by the PCI enumeration.

This has the drawback of allocating an IRQ even for PCI devices that
do not have a matching kernel driver but it should be safe to carry
out in all configurations.

Fixes: 30fdfb929e82 ("PCI: Add a call to pci_assign_irq() in
pci_device_probe()")
Link: http://lkml.kernel.org/r/32ec730f-c1b0-5584-cd35-f8a809122b96@roeck-us.net
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reported-by: Guenter Roeck <linux@roeck-us.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: David S. Miller <davem@davemloft.net>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Matt Turner <mattst88@gmail.com>
---
 drivers/pci/pci-driver.c | 2 --
 drivers/pci/probe.c      | 3 +++
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 11bd267..750d688 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -415,8 +415,6 @@ static int pci_device_probe(struct device *dev)
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	struct pci_driver *drv = to_pci_driver(dev->driver);
 
-	pci_assign_irq(pci_dev);
-
 	error = pcibios_alloc_irq(pci_dev);
 	if (error < 0)
 		return error;
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ff94b69..ba4e466 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2103,6 +2103,9 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
 	/* Initialize various capabilities */
 	pci_init_capabilities(dev);
 
+	/* Assign device IRQ number */
+	pci_assign_irq(dev);
+
 	/*
 	 * Add the device to our list of discovered devices
 	 * and the bus list for fixup functions, etc.
-- 
2.4.12


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
