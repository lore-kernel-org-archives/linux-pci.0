Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Ray Jui <rjui@broadcom.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Hauke Mehrtens <hauke@hauke-m.de>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	"Jon Mason" <jonmason@broadcom.com>
Subject: [PATCH 8/8] PCI: iproc: Fix compile warnings
Date: Tue, 15 Sep 2015 17:39:22 -0700
Message-ID: <1442363962-29805-9-git-send-email-rjui@broadcom.com>
In-Reply-To: <1442363962-29805-1-git-send-email-rjui@broadcom.com>
References: <1442363962-29805-1-git-send-email-rjui@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

There are several compile warnings in pcie-iproc.c related to the
printing of a size_t value.  This is a 32bit value on arm, and 64bit on
arm64.  However, the printks are for 64bit values (thus the warning).
Using the %pap printk for these values (per
Documentation/printk-formats.txt) corrects the issue.

Signed-off-by: Jon Mason <jonmason@broadcom.com>
---
 drivers/pci/host/pcie-iproc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
index 2ba3c4b..f3481dd 100644
--- a/drivers/pci/host/pcie-iproc.c
+++ b/drivers/pci/host/pcie-iproc.c
@@ -244,15 +244,15 @@ static int iproc_pcie_setup_ob(struct iproc_pcie *pcie, u64 axi_addr,
 
 	if (size > max_size) {
 		dev_err(pcie->dev,
-			"res size 0x%llx exceeds max supported size 0x%llx\n",
-			(u64)size, max_size);
+			"res size 0x%pap exceeds max supported size 0x%llx\n",
+			&size, max_size);
 		return -EINVAL;
 	}
 
 	if (size % ob->window_size) {
 		dev_err(pcie->dev,
-			"res size 0x%llx needs to be multiple of "
-			"window size 0x%llx\n", (u64)size, ob->window_size);
+			"res size %pap needs to be multiple of window size %pap\n",
+			&size, &ob->window_size);
 		return -EINVAL;
 	}
 
-- 
1.9.1

