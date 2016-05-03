Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Jake Oshins <jakeo@microsoft.com>
Subject: [PATCH [RFC]] PCI: hv: add explicit fencing to config space access
Date: Tue,  3 May 2016 14:22:00 +0200
Message-Id: <1462278120-7859-1-git-send-email-vkuznets@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I'm trying to pass-through Broadcom BCM5720 NIC (Dell Device 1f5b) on Dell
R720 server. Everything works fine when target VM has only one CPU, but
SMP guests reboot when NIC driver is trying to access PCI config space
(with  hv_pcifront_read_config/hv_pcifront_write_config). The reboot
appears to be induced by the hypervisor and no crash is observed. Windows
event logs are not helpful at all ('Virtual machine ... has quit
unexpectedly'). The particular access point is always different and
putting debug between them (printk/mdelay/...) moves the issue further
away. The server model affects the issue as well: on Dell R420 I'm able to
pass-through BCM5720 NIC to SMP guests without issues.

While I'm obviously failing to reveal the essence of the issue I was able
to come up with a (possible) solution: if explicit fencing is put to
hv_pcifront_read_config/hv_pcifront_write_config the issue goes away. The
essential minimum is rmb() at the end on _hv_pcifront_read_config() and
wmb() at the end of _hv_pcifront_write_config() but I'm not confident it
will be sufficient for all hardware. I suggest the following fencing:
1) wmb()/mb() between choosing the function and writing to its space.
2) mb() before releasing the spinlock in both _hv_pcifront_read_config()/
   _hv_pcifront_write_config to ensure that consecutive reads/writes to
  the space won't get re-ordered as drivers may count on that.
Config space access is not supposed to be performance-critical so this
explicit fencing is not supposed to bring any slowdown.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 drivers/pci/host/pci-hyperv.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
index c17e792..7e9b2de 100644
--- a/drivers/pci/host/pci-hyperv.c
+++ b/drivers/pci/host/pci-hyperv.c
@@ -553,6 +553,8 @@ static void _hv_pcifront_read_config(struct hv_pci_dev *hpdev, int where,
 		spin_lock_irqsave(&hpdev->hbus->config_lock, flags);
 		/* Choose the function to be read. (See comment above) */
 		writel(hpdev->desc.win_slot.slot, hpdev->hbus->cfg_addr);
+		/* Make sure the function was chosen before we start reading. */
+		mb();
 		/* Read from that function's config space. */
 		switch (size) {
 		case 1:
@@ -565,6 +567,11 @@ static void _hv_pcifront_read_config(struct hv_pci_dev *hpdev, int where,
 			*val = readl(addr);
 			break;
 		}
+		/*
+		 * Make sure the write was done before we release the spinlock
+		 * allowing consecutive reads/writes.
+		 */
+		mb();
 		spin_unlock_irqrestore(&hpdev->hbus->config_lock, flags);
 	} else {
 		dev_err(&hpdev->hbus->hdev->device,
@@ -592,6 +599,8 @@ static void _hv_pcifront_write_config(struct hv_pci_dev *hpdev, int where,
 		spin_lock_irqsave(&hpdev->hbus->config_lock, flags);
 		/* Choose the function to be written. (See comment above) */
 		writel(hpdev->desc.win_slot.slot, hpdev->hbus->cfg_addr);
+		/* Make sure the function was chosen before we start writing. */
+		wmb();
 		/* Write to that function's config space. */
 		switch (size) {
 		case 1:
@@ -604,6 +613,11 @@ static void _hv_pcifront_write_config(struct hv_pci_dev *hpdev, int where,
 			writel(val, addr);
 			break;
 		}
+		/*
+		 * Make sure the write was done before we release the spinlock
+		 * allowing consecutive reads/writes.
+		 */
+		mb();
 		spin_unlock_irqrestore(&hpdev->hbus->config_lock, flags);
 	} else {
 		dev_err(&hpdev->hbus->hdev->device,
-- 
2.5.5
