Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:61001 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751631AbbAZRMF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 26 Jan 2015 12:12:05 -0500
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc: Bradley Grove <linuxdrivers@attotech.com>,
	linux-scsi@vger.kernel.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH 4/5] [SCSI] esas2r: use PCI define for max read request size
Date: Mon, 26 Jan 2015 18:06:24 +0100
Message-Id: <1422291984-12488-1-git-send-email-zajec5@gmail.com>
In-Reply-To: <1422291922-12324-1-git-send-email-zajec5@gmail.com>
References: <1422291922-12324-1-git-send-email-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
---
 drivers/scsi/esas2r/esas2r_init.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/esas2r/esas2r_init.c b/drivers/scsi/esas2r/esas2r_init.c
index 6776931..c0b37a5 100644
--- a/drivers/scsi/esas2r/esas2r_init.c
+++ b/drivers/scsi/esas2r/esas2r_init.c
@@ -813,12 +813,13 @@ static void esas2r_init_pci_cfg_space(struct esas2r_adapter *a)
 		pci_read_config_word(a->pcid, pcie_cap_reg + PCI_EXP_DEVCTL,
 				     &devcontrol);
 
-		if ((devcontrol & PCI_EXP_DEVCTL_READRQ) > 0x2000) {
+		if (devcontrol & PCI_EXP_DEVCTL_READRQ >
+		    PCI_EXP_DEVCTL_READRQ_512B) {
 			esas2r_log(ESAS2R_LOG_INFO,
 				   "max read request size > 512B");
 
 			devcontrol &= ~PCI_EXP_DEVCTL_READRQ;
-			devcontrol |= 0x2000;
+			devcontrol |= PCI_EXP_DEVCTL_READRQ_512B;
 			pci_write_config_word(a->pcid,
 					      pcie_cap_reg + PCI_EXP_DEVCTL,
 					      devcontrol);
-- 
1.8.4.5

