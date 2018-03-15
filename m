Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pu1apc01on0125.outbound.protection.outlook.com ([104.47.126.125]:29120
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752253AbeCOOVX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Mar 2018 10:21:23 -0400
From: Dexuan Cui <decui@microsoft.com>
To: "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "driverdev-devel@linuxdriverproject.org"
        <driverdev-devel@linuxdriverproject.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
Subject: [PATCH v4 2/2] PCI: hv: Fix 2 hang issues in hv_compose_msi_msg()
Date: Thu, 15 Mar 2018 14:21:08 +0000
Message-ID: <KL1P15301MB00066707A5CC8A328CF2429CBFD00@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

1. With the patch "x86/vector/msi: Switch to global reservation mode",
the recent v4.15 and newer kernels always hang for 1-vCPU Hyper-V VM
with SR-IOV. This is because when we reach hv_compose_msi_msg() by
request_irq() -> request_threaded_irq() ->__setup_irq()->irq_startup()
-> __irq_startup() -> irq_domain_activate_irq() -> ... ->
msi_domain_activate() -> ... -> hv_compose_msi_msg(), local irq is
disabled in __setup_irq().

Note: when we reach hv_compose_msi_msg() by another code path:
pci_enable_msix_range() -> ... -> irq_domain_activate_irq() -> ... ->
hv_compose_msi_msg(), local irq is not disabled.

hv_compose_msi_msg() depends on an interrupt from the host.
With interrupts disabled, a UP VM always hangs in the busy loop in
the function, because the interrupt callback hv_pci_onchannelcallback()
can not be called.

We can do nothing but work it around by polling the channel. This
is ugly, but we don't have any other choice.

2. If the host is ejecting the VF device before we reach
hv_compose_msi_msg(), in a UP VM, we can hang in hv_compose_msi_msg()
forever, because at this time the host doesn't respond to the
CREATE_INTERRUPT request. This issue exists the first day the
pci-hyperv driver appears in the kernel.

Luckily, this can also by worked around by polling the channel
for the PCI_EJECT message and hpdev->state, and by checking the
PCI vendor ID.

Note: actually the above 2 issues also happen to a SMP VM, if
"hbus->hdev->channel->target_cpu =3D=3D smp_processor_id()" is true.

Fixes: 4900be83602b ("x86/vector/msi: Switch to global reservation mode")
Tested-by: Adrian Suhov <v-adsuho@microsoft.com>
Tested-by: Chris Valean <v-chvale@microsoft.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Acked-by: Haiyang Zhang <haiyangz@microsoft.com>
Cc: stable@vger.kernel.org
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: K. Y. Srinivasan <kys@microsoft.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Jack Morgenstein <jackm@mellanox.com>
---
 drivers/pci/host/pci-hyperv.c | 58 +++++++++++++++++++++++++++++++++++++++=
+++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
index 5e67dff779a7..acb1941423a9 100644
--- a/drivers/pci/host/pci-hyperv.c
+++ b/drivers/pci/host/pci-hyperv.c
@@ -522,6 +522,8 @@ struct hv_pci_compl {
 	s32 completion_status;
 };
=20
+static void hv_pci_onchannelcallback(void *context);
+
 /**
  * hv_pci_generic_compl() - Invoked for a completion packet
  * @context:		Set up by the sender of the packet.
@@ -666,6 +668,31 @@ static void _hv_pcifront_read_config(struct hv_pci_dev=
 *hpdev, int where,
 	}
 }
=20
+static u16 hv_pcifront_get_vendor_id(struct hv_pci_dev *hpdev)
+{
+	u16 ret;
+	unsigned long flags;
+	void __iomem *addr =3D hpdev->hbus->cfg_addr + CFG_PAGE_OFFSET +
+			     PCI_VENDOR_ID;
+
+	spin_lock_irqsave(&hpdev->hbus->config_lock, flags);
+
+	/* Choose the function to be read. (See comment above) */
+	writel(hpdev->desc.win_slot.slot, hpdev->hbus->cfg_addr);
+	/* Make sure the function was chosen before we start reading. */
+	mb();
+	/* Read from that function's config space. */
+	ret =3D readw(addr);
+	/*
+	 * mb() is not required here, because the spin_unlock_irqrestore()
+	 * is a barrier.
+	 */
+
+	spin_unlock_irqrestore(&hpdev->hbus->config_lock, flags);
+
+	return ret;
+}
+
 /**
  * _hv_pcifront_write_config() - Internal PCI config write
  * @hpdev:	The PCI driver's representation of the device
@@ -1108,8 +1135,37 @@ static void hv_compose_msi_msg(struct irq_data *data=
, struct msi_msg *msg)
 	 * Since this function is called with IRQ locks held, can't
 	 * do normal wait for completion; instead poll.
 	 */
-	while (!try_wait_for_completion(&comp.comp_pkt.host_event))
+	while (!try_wait_for_completion(&comp.comp_pkt.host_event)) {
+		/* 0xFFFF means an invalid PCI VENDOR ID. */
+		if (hv_pcifront_get_vendor_id(hpdev) =3D=3D 0xFFFF) {
+			dev_err_once(&hbus->hdev->device,
+				     "the device has gone\n");
+			goto free_int_desc;
+		}
+
+		/*
+		 * When the higher level interrupt code calls us with
+		 * interrupt disabled, we must poll the channel by calling
+		 * the channel callback directly when channel->target_cpu is
+		 * the current CPU. When the higher level interrupt code
+		 * calls us with interrupt enabled, let's add the
+		 * local_bh_disable()/enable() to avoid race.
+		 */
+		local_bh_disable();
+
+		if (hbus->hdev->channel->target_cpu =3D=3D smp_processor_id())
+			hv_pci_onchannelcallback(hbus);
+
+		local_bh_enable();
+
+		if (hpdev->state =3D=3D hv_pcichild_ejecting) {
+			dev_err_once(&hbus->hdev->device,
+				     "the device is being ejected\n");
+			goto free_int_desc;
+		}
+
 		udelay(100);
+	}
=20
 	if (comp.comp_pkt.completion_status < 0) {
 		dev_err(&hbus->hdev->device,
--=20
2.7.4
