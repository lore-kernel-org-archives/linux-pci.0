Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Dexuan Cui <decui@microsoft.com>
To: 'Lorenzo Pieralisi' <lorenzo.pieralisi@arm.com>,
        'Bjorn Helgaas' <bhelgaas@google.com>,
        "'linux-pci@vger.kernel.org'" <linux-pci@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "'olaf@aepfle.de'" <olaf@aepfle.de>,
        "'apw@canonical.com'" <apw@canonical.com>,
        "'jasowang@redhat.com'" <jasowang@redhat.com>
CC: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'driverdev-devel@linuxdriverproject.org'"
        <driverdev-devel@linuxdriverproject.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "'vkuznets@redhat.com'" <vkuznets@redhat.com>,
        "'marcelo.cerri@canonical.com'" <marcelo.cerri@canonical.com>
Subject: [PATCH v2] PCI: hv: Disable/enable irq rather than bh in
 hv_compose_msi_msg()
Date: Sun, 1 Jul 2018 18:22:23 +0000
Message-ID: <KL1P15301MB0006BE5DB7C3C45386E4327FBF4C0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Commit de0aa7b2f97d ("PCI: hv: Fix 2 hang issues in hv_compose_msi_msg()")
uses local_bh_disable()/enable(), because hv_pci_onchannelcallback() can
also run in tasklet context as the channel event callback, and here we
want to avoid the race.

With CONFIG_PROVE_LOCKING=3Dy in the recent mainline, or old kernels that
don't have commit f71b74bca637 ("irq/softirqs: Use lockdep to assert IRQs
are disabled/enabled"), when the upper layer irq code calls
hv_compose_msi_msg() with local irq DISABLED, we'll see a warning at the
beginning of __local_bh_enable_ip():

IRQs not enabled as expected
  WARNING: CPU: 0 PID: 408 at kernel/softirq.c:162 __local_bh_enable_ip

The warning exposes an issue in de0aa7b2f97d: local_bh_enable() can
potentially call do_softirq(), which is not supposed to run when local
irq is DISABLED. Let's fix this by using local_irq_save()/restore()
instead.

Note: hv_pci_onchannelcallback() is not a hot path because it's only
called when the PCI device is hot added and removed, which is infrequent.

Fixes: de0aa7b2f97d ("PCI: hv: Fix 2 hang issues in hv_compose_msi_msg()")
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Cc: <stable@vger.kernel.org>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: K. Y. Srinivasan <kys@microsoft.com>
---

A trimmed version of the warning is:

IRQs not enabled as expected
WARNING: CPU: 0 PID: 408 at kernel/softirq.c:162 __local_bh_enable_ip+0xb0/=
0xe0
Call Trace:
 hv_compose_msi_msg+0x209/0x462 [pci_hyperv]
 irq_chip_compose_msi_msg+0x41/0x50
 msi_domain_activate+0x1a/0x40
 __irq_domain_activate_irq+0x59/0x90
 irq_domain_activate_irq+0x25/0x40
 __setup_irq+0x3ec/0x730
request_threaded_irq+0xfa/0x1a0
mlx4_init_eq_table+0x3c3/0x5f0 [mlx4_core]
mlx4_setup_hca+0x1db/0x750 [mlx4_core]
mlx4_load_one+0xad2/0x13b0 [mlx4_core]
mlx4_init_one+0x578/0x710 [mlx4_core]
local_pci_probe+0x1e/0x50
work_for_cpu_fn+0x10/0x20
process_one_work+0x1d4/0x5a0
worker_thread+0x1cb/0x3d0
kthread+0xf5/0x130


Changes since v1:
	Updated the changelog only (fixed typos and some inaccuracy)


 drivers/pci/controller/pci-hyperv.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/p=
ci-hyperv.c
index ba1d4b5..eb20296 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -1073,6 +1073,7 @@ static void hv_compose_msi_msg(struct irq_data *data,=
 struct msi_msg *msg)
 	struct pci_bus *pbus;
 	struct pci_dev *pdev;
 	struct cpumask *dest;
+	unsigned long flags;
 	struct compose_comp_ctxt comp;
 	struct tran_int_desc *int_desc;
 	struct {
@@ -1164,14 +1165,15 @@ static void hv_compose_msi_msg(struct irq_data *dat=
a, struct msi_msg *msg)
 		 * the channel callback directly when channel->target_cpu is
 		 * the current CPU. When the higher level interrupt code
 		 * calls us with interrupt enabled, let's add the
-		 * local_bh_disable()/enable() to avoid race.
+		 * local_irq_save()/restore() to avoid race:
+		 * hv_pci_onchannelcallback() can also run in tasklet.
 		 */
-		local_bh_disable();
+		local_irq_save(flags);
=20
 		if (hbus->hdev->channel->target_cpu =3D=3D smp_processor_id())
 			hv_pci_onchannelcallback(hbus);
=20
-		local_bh_enable();
+		local_irq_restore(flags);
=20
 		if (hpdev->state =3D=3D hv_pcichild_ejecting) {
 			dev_err_once(&hbus->hdev->device,
--=20
2.7.4
