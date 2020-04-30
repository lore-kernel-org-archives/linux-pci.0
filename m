Return-Path: <SRS0=q/mj=6O=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00EEFC83004
	for <linux-pci@archiver.kernel.org>; Thu, 30 Apr 2020 00:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E021B2192A
	for <linux-pci@archiver.kernel.org>; Thu, 30 Apr 2020 00:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbgD3AmK (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 29 Apr 2020 20:42:10 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52092 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbgD3AmK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Apr 2020 20:42:10 -0400
Received: from 1.general.jvosburgh.us.vpn ([10.172.68.206] helo=famine.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <jay.vosburgh@canonical.com>)
        id 1jTxHC-0006r5-O9; Thu, 30 Apr 2020 00:42:06 +0000
Received: by famine.localdomain (Postfix, from userid 1000)
        id E2C17630E4; Wed, 29 Apr 2020 17:42:04 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
        by famine.localdomain (Postfix) with ESMTP id D417EAC1DB;
        Wed, 29 Apr 2020 17:42:04 -0700 (PDT)
From:   Jay Vosburgh <jay.vosburgh@canonical.com>
To:     linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [PATCH] PCI/ERR: Resolve regression in pcie_do_recovery
X-Mailer: MH-E 8.6+git; nmh 1.6; GNU Emacs 27.0.50
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <12114.1588207324.1@famine>
Date:   Wed, 29 Apr 2020 17:42:04 -0700
Message-ID: <12115.1588207324@famine>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

	Commit 6d2c89441571 ("PCI/ERR: Update error status after
reset_link()"), introduced a regression, as pcie_do_recovery will
discard the status result from report_frozen_detected.  This can cause a
failure to recover if _NEED_RESET is returned by report_frozen_detected
and report_slot_reset is not invoked.

	Such an event can be induced for testing purposes by reducing
the Max_Payload_Size of a PCIe bridge to less than that of a device
downstream from the bridge, and then initating I/O through the device,
resulting in oversize transactions.  In the presence of DPC, this
results in a containment event and attempted reset and recovery via
pcie_do_recovery.  After 6d2c89441571 report_slot_reset is not invoked,
and the device does not recover.

	Inspection shows a similar path is plausible for a return of
_CAN_RECOVER and the invocation of report_mmio_enabled.

	Resolve this by preserving the result of report_frozen_detected if
reset_link does not return _DISCONNECT.

Fixes: 6d2c89441571 ("PCI/ERR: Update error status after reset_link()")
Signed-off-by: Jay Vosburgh <jay.vosburgh@canonical.com>

---
 drivers/pci/pcie/err.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 14bb8f54723e..e4274562f3a0 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -164,10 +164,17 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 
 	pci_dbg(dev, "broadcast error_detected message\n");
 	if (state == pci_channel_io_frozen) {
+		pci_ers_result_t status2;
+
 		pci_walk_bus(bus, report_frozen_detected, &status);
-		status = reset_link(dev);
-		if (status != PCI_ERS_RESULT_RECOVERED) {
+		/* preserve status from report_frozen_detected to
+		 * insure report_mmio_enabled or report_slot_reset are
+		 * invoked even if reset_link returns _RECOVERED.
+		 */
+		status2 = reset_link(dev);
+		if (status2 != PCI_ERS_RESULT_RECOVERED) {
 			pci_warn(dev, "link reset failed\n");
+			status = status2;
 			goto failed;
 		}
 	} else {
-- 
2.7.4

