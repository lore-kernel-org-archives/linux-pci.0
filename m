Return-Path: <SRS0=s+SA=MR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F37CEC65BA7
	for <linux-pci@archiver.kernel.org>; Fri,  5 Oct 2018 15:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD1B72087D
	for <linux-pci@archiver.kernel.org>; Fri,  5 Oct 2018 15:49:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD1B72087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbeJEWtC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 5 Oct 2018 18:49:02 -0400
Received: from ale.deltatee.com ([207.54.116.67]:60428 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727572AbeJEWtC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Oct 2018 18:49:02 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1g8SMK-0007dv-0j; Fri, 05 Oct 2018 09:49:45 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1g8SMJ-0000GH-EJ; Fri, 05 Oct 2018 09:49:43 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Doug Meyer <dmeyer@gigaio.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>
Date:   Fri,  5 Oct 2018 09:49:40 -0600
Message-Id: <20181005154940.964-1-logang@deltatee.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, logang@deltatee.com, dmeyer@gigaio.com, bhelgaas@google.com, kurt.schwemmer@microsemi.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v2] PCI: Fix Switchtec DMA aliasing quirk dmesg noise
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently the Switchtec quirk runs on all endpoints in the Switch
which includes all the upstream and downstream ports. Seeing these
other functions do not contain BARs the quirk fails when trying to
map the BAR and prints the error "Cannot iomap Switchtec device".
The user will see a few of these useless and scary errors, one for
each port in the switch.

At most, the quirk should only run on either a management endpoint
(class=PCI_CLASS_MEMORY_OTHER) or an NTB endpoint
(PCI_CLASS_BRIDGE_OTHER). However, seeing the quirk is useless except
in NTB applications, we will only run it when the class is
PCI_CLASS_BRIDGE_OTHER.

Thus, switch to using DECLARE_PCI_FIXUP_CLASS_FINAL and clean up
the list with a define (so we don't have to change as much code if
we ever have to adjust the list).

Reported-by: Stephen  Bates <sbates@raithlin.com>
Cc: Doug Meyer <dmeyer@gigaio.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Kurt Schwemmer <kurt.schwemmer@microsemi.com>
Fixes: ad281ecf1c7d ("PCI: Add DMA alias quirk for Microsemi Switchtec NTB")
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---

* v2: Changes comment style, per feedback from Christoph

 drivers/pci/quirks.c | 90 +++++++++++++++++---------------------------
 1 file changed, 34 insertions(+), 56 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 6bc27b7fd452..0f072aed30f5 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5057,59 +5057,37 @@ static void quirk_switchtec_ntb_dma_alias(struct pci_dev *pdev)
 	pci_iounmap(pdev, mmio);
 	pci_disable_device(pdev);
 }
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8531,
-			quirk_switchtec_ntb_dma_alias);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8532,
-			quirk_switchtec_ntb_dma_alias);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8533,
-			quirk_switchtec_ntb_dma_alias);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8534,
-			quirk_switchtec_ntb_dma_alias);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8535,
-			quirk_switchtec_ntb_dma_alias);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8536,
-			quirk_switchtec_ntb_dma_alias);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8543,
-			quirk_switchtec_ntb_dma_alias);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8544,
-			quirk_switchtec_ntb_dma_alias);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8545,
-			quirk_switchtec_ntb_dma_alias);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8546,
-			quirk_switchtec_ntb_dma_alias);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8551,
-			quirk_switchtec_ntb_dma_alias);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8552,
-			quirk_switchtec_ntb_dma_alias);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8553,
-			quirk_switchtec_ntb_dma_alias);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8554,
-			quirk_switchtec_ntb_dma_alias);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8555,
-			quirk_switchtec_ntb_dma_alias);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8556,
-			quirk_switchtec_ntb_dma_alias);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8561,
-			quirk_switchtec_ntb_dma_alias);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8562,
-			quirk_switchtec_ntb_dma_alias);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8563,
-			quirk_switchtec_ntb_dma_alias);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8564,
-			quirk_switchtec_ntb_dma_alias);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8565,
-			quirk_switchtec_ntb_dma_alias);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8566,
-			quirk_switchtec_ntb_dma_alias);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8571,
-			quirk_switchtec_ntb_dma_alias);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8572,
-			quirk_switchtec_ntb_dma_alias);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8573,
-			quirk_switchtec_ntb_dma_alias);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8574,
-			quirk_switchtec_ntb_dma_alias);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8575,
-			quirk_switchtec_ntb_dma_alias);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8576,
-			quirk_switchtec_ntb_dma_alias);
+
+#define SWITCHTEC_QUIRK(vid) \
+	DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI, vid, \
+		PCI_CLASS_BRIDGE_OTHER, 8, quirk_switchtec_ntb_dma_alias)
+SWITCHTEC_QUIRK(0x8531);  /* PFX 24xG3 */
+SWITCHTEC_QUIRK(0x8532);  /* PFX 32xG3 */
+SWITCHTEC_QUIRK(0x8533);  /* PFX 48xG3 */
+SWITCHTEC_QUIRK(0x8534);  /* PFX 64xG3 */
+SWITCHTEC_QUIRK(0x8535);  /* PFX 80xG3 */
+SWITCHTEC_QUIRK(0x8536);  /* PFX 96xG3 */
+SWITCHTEC_QUIRK(0x8541);  /* PSX 24xG3 */
+SWITCHTEC_QUIRK(0x8542);  /* PSX 32xG3 */
+SWITCHTEC_QUIRK(0x8543);  /* PSX 48xG3 */
+SWITCHTEC_QUIRK(0x8544);  /* PSX 64xG3 */
+SWITCHTEC_QUIRK(0x8545);  /* PSX 80xG3 */
+SWITCHTEC_QUIRK(0x8546);  /* PSX 96xG3 */
+SWITCHTEC_QUIRK(0x8551);  /* PAX 24XG3 */
+SWITCHTEC_QUIRK(0x8552);  /* PAX 32XG3 */
+SWITCHTEC_QUIRK(0x8553);  /* PAX 48XG3 */
+SWITCHTEC_QUIRK(0x8554);  /* PAX 64XG3 */
+SWITCHTEC_QUIRK(0x8555);  /* PAX 80XG3 */
+SWITCHTEC_QUIRK(0x8556);  /* PAX 96XG3 */
+SWITCHTEC_QUIRK(0x8561);  /* PFXL 24XG3 */
+SWITCHTEC_QUIRK(0x8562);  /* PFXL 32XG3 */
+SWITCHTEC_QUIRK(0x8563);  /* PFXL 48XG3 */
+SWITCHTEC_QUIRK(0x8564);  /* PFXL 64XG3 */
+SWITCHTEC_QUIRK(0x8565);  /* PFXL 80XG3 */
+SWITCHTEC_QUIRK(0x8566);  /* PFXL 96XG3 */
+SWITCHTEC_QUIRK(0x8571);  /* PFXI 24XG3 */
+SWITCHTEC_QUIRK(0x8572);  /* PFXI 32XG3 */
+SWITCHTEC_QUIRK(0x8573);  /* PFXI 48XG3 */
+SWITCHTEC_QUIRK(0x8574);  /* PFXI 64XG3 */
+SWITCHTEC_QUIRK(0x8575);  /* PFXI 80XG3 */
+SWITCHTEC_QUIRK(0x8576);  /* PFXI 96XG3 */
--
2.19.0
