Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH bisected regression in 4.14] PCI: fix race while enabling
 upstream bridges concurrently
From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Srinath Mannam <srinath.mannam@broadcom.com>
Date: Fri, 15 Sep 2017 15:48:30 +0300
Message-ID: <150547971091.977464.16294045866179907260.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In pci_enable_bridge() pci_enable_device() is called before calling
pci_set_master(), thus check pci_is_enabled() becomes true in the
middle of this sequence. As a result in pci_enable_device_flags()
concurrent enable of device on same bridge could think that this
bridge is completely enabled, but actually it's not yet.

For me this race broke ethernet devices after booting kernel via
kexec, normal reboot was fine.

This patch removes racy fast-path: pci_enable_bridge() will take
pci_bridge_mutex and do nothing if bridge is already enabled.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Fixes: 40f11adc7cd9 ("PCI: Avoid race while enabling upstream bridges")
---
 drivers/pci/pci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b0002daa50f3..ffbe11dbdd61 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1394,7 +1394,7 @@ static int pci_enable_device_flags(struct pci_dev *dev, unsigned long flags)
 		return 0;		/* already enabled */
 
 	bridge = pci_upstream_bridge(dev);
-	if (bridge && !pci_is_enabled(bridge))
+	if (bridge)
 		pci_enable_bridge(bridge);
 
 	/* only skip sriov related */
