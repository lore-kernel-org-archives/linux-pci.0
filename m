Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-sg2apc01on0106.outbound.protection.outlook.com ([104.47.125.106]:49948
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935421AbeCCAU5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 2 Mar 2018 19:20:57 -0500
From: Dexuan Cui <decui@microsoft.com>
To: "bhelgaas@google.com" <bhelgaas@google.com>,
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
        Dexuan Cui <decui@microsoft.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Jack Morgenstein <jackm@mellanox.com>
Subject: [PATCH 3/3] PCI: hv: fix 2 hang issues in hv_compose_msi_msg()
Date: Sat, 3 Mar 2018 00:20:47 +0000
Message-ID: <20180303001947.20564-3-decui@microsoft.com>
References: <20180303001947.20564-1-decui@microsoft.com>
In-Reply-To: <20180303001947.20564-1-decui@microsoft.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

1. With the patch "x86/vector/msi: Switch to global reservation mode"
(4900be8360), the recent v4.15 and newer kernels always hang for 1-vCPU
Hyper-V VM with SR-IOV. This is because when we reach hv_compose_msi_msg()
by request_irq()  -> request_threaded_irq() -> __setup_irq()->irq_startup()
 -> __irq_startup() -> irq_domain_activate_irq() -> ... ->
msi_domain_activate() -> ... -> hv_compose_msi_msg(), local irq is
disabled in __setup_irq().

Fix this by polling the channel.

2. If the host is ejecting the VF device before we reach
hv_compose_msi_msg(), in a UP VM, we can hang in hv_compose_msi_msg()
forever, because at this time the host doesn't respond to the
CREATE_INTERRUPT request. This issue also happens to old kernels like
v4.14, v4.13, etc.

Fix this by polling the channel for the PCI_EJECT message and
hpdev->state, and by checking the PCI vendor ID.

Note: actually the above issues also happen to a SMP VM, if
"hbus->hdev->channel->target_cpu =3D=3D smp_processor_id()" is true.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Tested-by: Adrian Suhov <v-adsuho@microsoft.com>
Tested-by: Chris Valean <v-chvale@microsoft.com>
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
index 57b1fb3ebdb9..32d6b03cdd40 100644
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
