Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 12 May 2015 15:03:32 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Fam Zheng <famz@redhat.com>,
	Yinghai Lu <yhlu.kernel.send@gmail.com>,
	Yijing Wang <wangyijing@huawei.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Ulrich Obergfell <uobergfe@redhat.com>,
	Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH v6 1/2] PCI/MSI: Don't disable MSI/MSI-X at shutdown
Message-ID: <1431431730-25164-2-git-send-email-mst@redhat.com>
References: <1431431730-25164-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1431431730-25164-1-git-send-email-mst@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

d52877c7b1af ("pci/irq: let pci_device_shutdown to call pci_msi_shutdown
v2") disabled MSI/MSI-X at device shutdown to address a kexec problem.

The change made by the above commit is no longer necessary: it was
superceded by commit d5dea7d95c48 ("PCI: msi: Disable msi interrupts
when we initialize a pci device") which makes sure the original kexec
problem is solved in the new kernel, and commit b566a22c23 ("PCI:
disable Bus Master on PCI device shutdown") which makes sure device does
not send MSI interrupts (MSI is a memory write and so is suppressed when
bus master is cleared).

On the contrary, disabling MSI makes it *more* likely that the device
will cause mischief since unlike MSI, INT#x interrupts are not
suppressed by clearing bus mastering.

One example of such mischief is that after we disable MSI, the device
may assert INT#x (remember, cleaning bus mastering does not disable
INT#x interrupts), and if the driver hasn't registered an interrupt
handler for it, the interrupt is never deasserted which causes an "irq
%d: nobody cared" message, with irq being subsequently disabled. This is
actually not hard to observe with virtio devices.  Not a huge problem,
but ugly, and might in theory cause other problems, e.g. if the irq
being disabled is shared with another device that attempts to use it in
its shutdown callback, or if irq debugging was explicitly disabled on
the kernel command line.

Another theoretical problem is that if the driver does not flush MSI
interrupts in the shutdown callback, MSI interrupt handler will run at
the same time as the INT#x handler, which doesn't normally happen
outside the shutdown path; Depending on the driver, the two handlers
might conflict. I did not go looking for such driver bugs but this seems
plausible.

virtio specifically has another issue: register functions change between
msi enabled and disabled modes, so disabling MSI while driver is doing
things (e.g. from a kthread) will make the device confused.

Of course, some of the above specific issues can be solved by
implementing a shutdown callback in the driver: this callback would have
to suppress further activity from both the driver and the device, and
flush outstanding handlers. This is a non-trivial amount of code that
can trigger at any time, so needs careful thought to avoid race
conditions causing bugs, and that's only running on shutdown, so isn't
well tested.

Instead, stop disabling MSIs in PCI core at shutdown: it's simple, safe,
removes code instead of adding more code, and needs no driver support.

Reported-by: Fam Zheng <famz@redhat.com>
Tested-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
CC: Yinghai Lu <yhlu.kernel.send@gmail.com>
CC: Ulrich Obergfell <uobergfe@redhat.com>
CC: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/pci/pci-driver.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 3cb2210..38a602c 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -450,8 +450,6 @@ static void pci_device_shutdown(struct device *dev)
 
 	if (drv && drv->shutdown)
 		drv->shutdown(pci_dev);
-	pci_msi_shutdown(pci_dev);
-	pci_msix_shutdown(pci_dev);
 
 #ifdef CONFIG_KEXEC
 	/*
-- 
MST

