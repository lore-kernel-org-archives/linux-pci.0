Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org, timur@codeaurora.org,
        cov@codeaurora.org, alex.williamson@redhat.com,
        vikrams@codeaurora.org
Cc: Lorenzo.Pieralisi@arm.com, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>, linux-kernel@vger.kernel.org
Subject: [PATCH V3 1/2] PCI: add CRS support to error handling path
Date: Mon,  3 Oct 2016 01:36:59 -0400
Message-Id: <1475473021-14251-2-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1475473021-14251-1-git-send-email-okaya@codeaurora.org>
References: <1475473021-14251-1-git-send-email-okaya@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The PCIE spec allows an endpoint device to extend the initialization time
beyond 1 second by issuing Configuration Request Retry Status (CRS) for a
vendor ID read request.

This basically means "I'm busy now, please call me back later".

There are two moving parts to CRS support from the SW perspective. One part
is to determine if CRS is supported or not. The second part is to set the
CRS visibility register.

As part of the probe, the Linux kernel sets the above two conditions in
pci_enable_crs function. The kernel is also honoring the returned CRS in
pci_bus_read_dev_vendor_id function if supported. The function will poll up
to specified amount of time while endpoint is returning CRS response.

The PCIe spec also allows CRS to be issued during cold, warm, hot and FLR
resets.

The hot reset is initiated by starting a secondary bus reset. A bus/device
restore follows the reset.  This patch is adding vendor ID read into dev
restore function to validate that the device is accessible before writing
the register contents. If the device issues CRS, the code might poll up
to 60 seconds.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/pci.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index aab9d51..c8749b9 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4020,6 +4020,12 @@ static void pci_dev_save_and_disable(struct pci_dev *dev)
 
 static void pci_dev_restore(struct pci_dev *dev)
 {
+	u32 l;
+
+	/* see if the device is accessible first */
+	if (!pci_bus_read_dev_vendor_id(dev->bus, dev->devfn, &l, 60 * 1000))
+		return;
+
 	pci_restore_state(dev);
 	pci_reset_notify(dev, false);
 }
-- 
1.9.1
