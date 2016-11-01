Return-Path: <ray.jui@broadcom.com>
Return-Path: <ray.jui@broadcom.com>
From: Ray Jui <ray.jui@broadcom.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	linux-pci@vger.kernel.org,
	Alex Barba <alex.barba@broadcom.com>,
	Oza Oza <oza.oza@broadcom.com>,
	Ray Jui <ray.jui@broadcom.com>,
	Ray Jui <raj.jui@broadcom.com>
Subject: [PATCH v2 02/12] PCI: iproc: Do not reset PAXC when initializing the driver
Date: Mon, 31 Oct 2016 17:38:31 -0700
Message-Id: <1477960721-17649-3-git-send-email-ray.jui@broadcom.com>
In-Reply-To: <1477960721-17649-1-git-send-email-ray.jui@broadcom.com>
References: <1477960721-17649-1-git-send-email-ray.jui@broadcom.com>
List-ID: <linux-pci.vger.kernel.org>

During initialization, the current iProc PCIe host driver resets PAXC
and the downstream internal endpoint device that PAXC connects to. If
the endpoint device is already loaded with firmware and has started
running from the bootloader stage, this downstream reset causes the
endpoint device to stop working

Signed-off-by: Ray Jui <raj.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
---
 drivers/pci/host/pcie-iproc.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
index a9b9cd8..3f4884a 100644
--- a/drivers/pci/host/pcie-iproc.c
+++ b/drivers/pci/host/pcie-iproc.c
@@ -243,16 +243,13 @@ static void iproc_pcie_reset(struct iproc_pcie *pcie)
 {
 	u32 val;
 
-	if (pcie->ep_is_internal) {
-		val = iproc_pcie_read_reg(pcie, IPROC_PCIE_CLK_CTRL);
-		val &= ~PAXC_RESET_MASK;
-		iproc_pcie_write_reg(pcie, IPROC_PCIE_CLK_CTRL, val);
-		udelay(100);
-		val |= PAXC_RESET_MASK;
-		iproc_pcie_write_reg(pcie, IPROC_PCIE_CLK_CTRL, val);
-		udelay(100);
+	/*
+	 * PAXC and the internal emulated endpoint device downstream should not
+	 * be reset. If firmware has been loaded on the endpoint device at an
+	 * earlier boot stage, reset here causes issues
+	 */
+	if (pcie->ep_is_internal)
 		return;
-	}
 
 	/*
 	 * Select perst_b signal as reset source. Put the device into reset,
-- 
2.1.4
