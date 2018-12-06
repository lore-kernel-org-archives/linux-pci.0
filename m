Return-Path: <SRS0=KO/x=OP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C015C04EBF
	for <linux-pci@archiver.kernel.org>; Thu,  6 Dec 2018 04:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5C512146D
	for <linux-pci@archiver.kernel.org>; Thu,  6 Dec 2018 04:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="TZ96w9Mt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5C512146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbeLFEUB (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 5 Dec 2018 23:20:01 -0500
Received: from ozlabs.org ([203.11.71.1]:43561 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727695AbeLFEUA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Dec 2018 23:20:00 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
        id 439Mnn2xg6z9s7h; Thu,  6 Dec 2018 15:19:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=gibson.dropbear.id.au; s=201602; t=1544069997;
        bh=QfCDKFem+tJn9rNn8MYnoPCP4PC1UJhmRYJ4KBb7coM=;
        h=From:To:Cc:Subject:Date:From;
        b=TZ96w9MtVoS99ghXZApZhoWNx8WuX/FMIGjPUAoBNaRVseslpSluwbzk0ZeaEaLvM
         WM8SteRDD3oiMugu2haF5ucU+AtLrO3SZfuYHiwBmz2rRhsIe6nE70EiJZaGj0gG9+
         zqjCZhQHXJlYkEXivu/LhE4VuTrQ1+ckaXa0SfS0=
From:   David Gibson <david@gibson.dropbear.id.au>
To:     davem@davemloft.net, saeedm@mellanox.com, ogerlitz@mellanox.com,
        tariqt@mellanox.com, bhelgaas@google.com, leon@kernel.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        netdev@vger.kernel.org, alex.williamson@redhat.com,
        linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org,
        sbest@redhat.com, paulus@samba.org, benh@kernel.crashing.org,
        David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH] PCI: Add no-D3 quirk for Mellanox ConnectX-[45]
Date:   Thu,  6 Dec 2018 15:19:51 +1100
Message-Id: <20181206041951.22413-1-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Mellanox ConnectX-5 IB cards (MT27800) seem to cause a call trace when
unbound from their regular driver and attached to vfio-pci in order to pass
them through to a guest.

This goes away if the disable_idle_d3 option is used, so it looks like a
problem with the hardware handling D3 state.  To fix that more permanently,
use a device quirk to disable D3 state for these devices.

We do this by renaming the existing quirk_no_ata_d3() more generally and
attaching it to the ConnectX-[45] devices (0x15b3:0x1013).

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 drivers/pci/quirks.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 4700d24e5d55..add3f516ca12 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1315,23 +1315,24 @@ static void quirk_ide_samemode(struct pci_dev *pdev)
 }
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_10, quirk_ide_samemode);
 
-/* Some ATA devices break if put into D3 */
-static void quirk_no_ata_d3(struct pci_dev *pdev)
+/* Some devices (including a number of ATA cards) break if put into D3 */
+static void quirk_no_d3(struct pci_dev *pdev)
 {
 	pdev->dev_flags |= PCI_DEV_FLAGS_NO_D3;
 }
+
 /* Quirk the legacy ATA devices only. The AHCI ones are ok */
 DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_SERVERWORKS, PCI_ANY_ID,
-				PCI_CLASS_STORAGE_IDE, 8, quirk_no_ata_d3);
+				PCI_CLASS_STORAGE_IDE, 8, quirk_no_d3);
 DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_ATI, PCI_ANY_ID,
-				PCI_CLASS_STORAGE_IDE, 8, quirk_no_ata_d3);
+				PCI_CLASS_STORAGE_IDE, 8, quirk_no_d3);
 /* ALi loses some register settings that we cannot then restore */
 DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_AL, PCI_ANY_ID,
-				PCI_CLASS_STORAGE_IDE, 8, quirk_no_ata_d3);
+				PCI_CLASS_STORAGE_IDE, 8, quirk_no_d3);
 /* VIA comes back fine but we need to keep it alive or ACPI GTM failures
    occur when mode detecting */
 DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_VIA, PCI_ANY_ID,
-				PCI_CLASS_STORAGE_IDE, 8, quirk_no_ata_d3);
+				PCI_CLASS_STORAGE_IDE, 8, quirk_no_d3);
 
 /*
  * This was originally an Alpha-specific thing, but it really fits here.
@@ -3367,6 +3368,10 @@ static void mellanox_check_broken_intx_masking(struct pci_dev *pdev)
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MELLANOX, PCI_ANY_ID,
 			mellanox_check_broken_intx_masking);
 
+/* Mellanox MT27800 (ConnectX-5) IB card seems to break with D3
+ * In particular this shows up when the device is bound to the vfio-pci driver */
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_MELLANOX, PCI_DEVICE_ID_MELLANOX_CONNECTX4, quirk_no_d3)
+
 static void quirk_no_bus_reset(struct pci_dev *dev)
 {
 	dev->dev_flags |= PCI_DEV_FLAGS_NO_BUS_RESET;
-- 
2.19.2

