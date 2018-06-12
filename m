Return-Path: <SRS0=GJIr=I6=broadcom.com=ray.jui@kernel.org>
Return-Path: <SRS0=GJIr=I6=broadcom.com=ray.jui@kernel.org>
From: Ray Jui <ray.jui@broadcom.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	linux-kernel@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	linux-pci@vger.kernel.org,
	Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH v2 1/5] PCI: iproc: Activate PAXC bridge quirk for more devices
Date: Mon, 11 Jun 2018 17:21:03 -0700
Message-Id: <1528762867-16823-2-git-send-email-ray.jui@broadcom.com>
In-Reply-To: <1528762867-16823-1-git-send-email-ray.jui@broadcom.com>
References: <1528762867-16823-1-git-send-email-ray.jui@broadcom.com>
List-ID: <linux-pci.vger.kernel.org>

Activate PAXC bridge quirk for more PAXC based PCIe root complex with
the following PCIe device ID:
0xd750, 0xd802, 0xd804

Signed-off-by: Ray Jui <ray.jui@broadcom.com>
---
 drivers/pci/quirks.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 2990ad1..47dfea0 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2195,6 +2195,9 @@ static void quirk_paxc_bridge(struct pci_dev *pdev)
 }
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0x16cd, quirk_paxc_bridge);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0x16f0, quirk_paxc_bridge);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd750, quirk_paxc_bridge);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd802, quirk_paxc_bridge);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd804, quirk_paxc_bridge);
 #endif
 
 /* Originally in EDAC sources for i82875P:
-- 
2.1.4
