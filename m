Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 26 Mar 2015 12:37:48 +0100
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Fam Zheng <famz@redhat.com>,
	Yinghai Lu <yhlu.kernel.send@gmail.com>,
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>
Subject: [PATCH v4 07/10] ntb: drop pci_msi_off call on probe
Message-ID: <1427369811-11721-8-git-send-email-mst@redhat.com>
References: <1427369811-11721-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1427369811-11721-1-git-send-email-mst@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pci core now disables msi on probe automatically,
drop this from device-specific code.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/ntb/ntb_hw.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/ntb/ntb_hw.c b/drivers/ntb/ntb_hw.c
index cd29b10..8225cbc 100644
--- a/drivers/ntb/ntb_hw.c
+++ b/drivers/ntb/ntb_hw.c
@@ -1313,8 +1313,6 @@ static int ntb_setup_intx(struct ntb_device *ndev)
 	struct pci_dev *pdev = ndev->pdev;
 	int rc;
 
-	pci_msi_off(pdev);
-
 	/* Verify intx is enabled */
 	pci_intx(pdev, 1);
 
-- 
MST

