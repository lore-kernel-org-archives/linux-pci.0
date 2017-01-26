Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:32866 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752626AbdAZTIV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 26 Jan 2017 14:08:21 -0500
From: Prarit Bhargava <prarit@redhat.com>
To: linux-pci@vger.kernel.org
Cc: Prarit Bhargava <prarit@redhat.com>, alex.williamson@redhat.com,
        darcari@redhat.com, mstowe@redhat.com, bhelgaas@google.com,
        lukas@wunner.de, keith.busch@intel.com,
        mika.westerberg@linux.intel.com
Subject: [PATCH] pci: Only disable MSI/X and enable INTx if shutdown function has been called
Date: Thu, 26 Jan 2017 14:07:47 -0500
Message-Id: <1485457667-791-1-git-send-email-prarit@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Bjorn, I read your comment on the earlier patch and decided to answer it
with this explanation.  I hope this explains the behavior, why the code
was introduced, what the problem is, and why it no longer is an issue for
kdump.

The following unhandled IRQ warning is seen during shutdown:

    irq 16: nobody cared (try booting with the "irqpoll" option)
    CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.8.2-1.el7_UNSUPPORTED.x86_64 #1
    Hardware name: Hewlett-Packard HP Z820 Workstation/158B, BIOS J63 v03.90 06/
     0000000000000000 ffff88041f803e70 ffffffff81333bd5 ffff88041cb78200
     ffff88041cb7829c ffff88041f803e98 ffffffff810d9465 ffff88041cb78200
     0000000000000000 0000000000000028 ffff88041f803ed0 ffffffff810d97bf
    Call Trace:
     <IRQ>  [<ffffffff81333bd5>] dump_stack+0x63/0x8e
     [<ffffffff810d9465>] __report_bad_irq+0x35/0xd0
     [<ffffffff810d97bf>] note_interrupt+0x20f/0x260
     [<ffffffff810d6b35>] handle_irq_event_percpu+0x45/0x60
     [<ffffffff810d6b7c>] handle_irq_event+0x2c/0x50
     [<ffffffff810da31a>] handle_fasteoi_irq+0x8a/0x150
     [<ffffffff8102edfb>] handle_irq+0xab/0x130
     [<ffffffff81082391>] ? _local_bh_enable+0x21/0x50
     [<ffffffff817064ad>] do_IRQ+0x4d/0xd0
     [<ffffffff81704502>] common_interrupt+0x82/0x82
     <EOI>  [<ffffffff815d0181>] ? cpuidle_enter_state+0xc1/0x280
     [<ffffffff815d0174>] ? cpuidle_enter_state+0xb4/0x280
     [<ffffffff815d0377>] cpuidle_enter+0x17/0x20
     [<ffffffff810bf660>] cpu_startup_entry+0x220/0x3a0
     [<ffffffff816f6da7>] rest_init+0x77/0x80
     [<ffffffff81d8e147>] start_kernel+0x495/0x4a2
     [<ffffffff81d8daa0>] ? set_init_arg+0x55/0x55
     [<ffffffff81d8d120>] ? early_idt_handler_array+0x120/0x120
     [<ffffffff81d8d5d6>] x86_64_start_reservations+0x2a/0x2c
     [<ffffffff81d8d715>] x86_64_start_kernel+0x13d/0x14c

When a system boots the Linux PCI devices are initialized by BIOS in
legacy interrupt mode.  In the Linux PCI model, as part of the driver
initialization of a device, the driver decides the type of interrupt handler to
register.  If the device supports MSI/X then an MSI/X handler will be
registered for all MSI/X interrupts through a call to pci_enable_msix_range()
which will also put the PCI device into MSI/X mode; if the device doesn't
support MSI/X then the legacy handler will be registered for the legacy
interrupt and the device will remain in legacy mode.  A good example of a
driver doing this is e1000e_set_interrupt_capability().

The stack trace occurs on a system that has a MSI/X capable device with a MSI/X
capable driver, but the driver does not have a pci shutdown function.  The PCI
subsystem (not the driver!!) calls pci_device_shutdown() which disables MSI/X
on the device during system shutdown by calling pci_msi_shutdown() and
pci_msix_shutdown() asynchronously of the driver.  Disabling MSI/X will result
in the active device being switched into legacy mode with a driver that is
configured for MSI/X.  If the PCI device generates an interrupt during
shutdown, the resulting legacy interrupt will not be handled by any driver and
will be reported as being unhandled.

[Aside: This does not mean that there is a problem with the driver.  If the
driver had a proper shutdown function and this happened, then yes, there's a
problem with the driver because the shutdown should have stopped HW interrupts
being generated.  However, that isn't the case here because there isn't a
shutdown function for this device.  (There is no requirement for a shutdown
function.)  We want some drivers to remain active, for example the serial
driver and on those devices the problem really lies with the PCI shutdown
disabling MSI/X and switching to legacy mode when the HW and driver haven't
stopped.]

The pci_device_shutdown() MSI disable code was introduced in commit
d52877c7b1af ("pci/irq: let pci_device_shutdown to call pci_msi_shutdown v2").
This commit was for a kdump failure with the mptscsih storage driver on 2.6.18.
The change should have been made directly to that driver's shutdown function,
not for every PCI driver [1].  Additionally, pci_device_shutdown() is no
longer called during the panic path so this code does not reset devices
for kdump.

I have tested this patch in kdump with both nr_cpus=1 and nr_cpus=4 on various
systems.  In cases where bugs have been reported on shutdown
(https://bugzilla.kernel.org/show_bug.cgi?id=187351#c1) test kernels have
resolved the unhandled IRQ stack trace.  In order to test for driver
regressions (ie, "whack-a-mole" bugs) I have tested this patch on ~200 systems
with different cpu counts (many drivers that support MSI/X initialize IRQs for
each cpu) and various network and storage devices and drivers, without any
issues. [2]

This patch also has a positive effect with the PCI-based serial devices.
On many systems during reboot/shutdown the the serial driver stops
outputting messages.  I have tracked this to PCI serial devices that are
as described above asynchronously switched from MSI/X to legacy.  After
applying this patch serial console messages are output for the entire
reboot/shutdown.

[1] I cannot reproduce the mptscsih failure on a recent kernel on older or
newer hardware.  Again, I think the patch has no effect on kdump because
pci_device_shutdown() is not called during the panic path.

[2] I have also tested a kernel that completely removes pci_msix_shutdown() and
pci_msi_shutdown() without any issues.

P.
---------8<---------

On some systems an unhandled IRQ stack trace is output during shutdown.

This occurs because pci_device_shutdown() disables MSI/X on all devices
during shutdown by calling pci_msi_shutdown() and pci_msix_shutdown()
asynchronously of the devices' drivers.  If a driver does not have a
shutdown method and is configured for MSI/X interrupts, disabling MSI/X
will result in the device being configured for legacy interrupts with a
driver that is configured for MSI/X.  If the hardware generates an
interrupt during shutdown, the interrupt will be a legacy interrupt and
will be reported as being unhandled by any driver.

Do not disable MSI/X interrupts during shutdown.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Cc: alex.williamson@redhat.com
Cc: darcari@redhat.com
Cc: mstowe@redhat.com
Cc: bhelgaas@google.com
Cc: lukas@wunner.de
Cc: keith.busch@intel.com
Cc: mika.westerberg@linux.intel.com
---
 drivers/pci/pci-driver.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 1ccce1cd6aca..87c35db5a564 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -461,10 +461,11 @@ static void pci_device_shutdown(struct device *dev)
 
 	pm_runtime_resume(dev);
 
-	if (drv && drv->shutdown)
+	if (drv && drv->shutdown) {
 		drv->shutdown(pci_dev);
-	pci_msi_shutdown(pci_dev);
-	pci_msix_shutdown(pci_dev);
+		pci_msi_shutdown(pci_dev);
+		pci_msix_shutdown(pci_dev);
+	}
 
 	/*
 	 * If this is a kexec reboot, turn off Bus Master bit on the
-- 
1.7.9.3

