Return-Path: <SRS0=XWMu=Q5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E6DC43381
	for <linux-pci@archiver.kernel.org>; Fri, 22 Feb 2019 19:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72CA32070D
	for <linux-pci@archiver.kernel.org>; Fri, 22 Feb 2019 19:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tgg6WJHV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbfBVTsS (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 22 Feb 2019 14:48:18 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33913 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbfBVTsS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Feb 2019 14:48:18 -0500
Received: by mail-ot1-f66.google.com with SMTP id 98so2903347oty.1;
        Fri, 22 Feb 2019 11:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NmUp2q2izfWlgLnxLGWQSSy/6NAiua1qhzgzGd225p0=;
        b=Tgg6WJHVC0K7MoWrCfBPB/QU25WTm1xDmfX7PWMbGreSXl4jgCDBdbxXJvxKZjk8mS
         +2zqvgfe8Qqwhl1qwPypvpzb4fjs3Yxogw/MIgqwSwQZdEV71tRWODif4gNkmJHai6EE
         6qHRG13/10MCZl1s630Ye4auSUJ5pFCionSb8JrS/bhWG2MjcEtkZaySqP111GnCo37i
         uNy69cK8CA1qMNFUbxX6ZGOKfIfarnfsQfL5BFvigmCPMsLp2TAnKppjt/ABj5h0OouI
         SAdLw9g2JA5c53lPlw5JJV9z6tc/UwuT/yim7oRRVI07Gygf62mTQi4PbqyhNZBb5WRB
         pSAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NmUp2q2izfWlgLnxLGWQSSy/6NAiua1qhzgzGd225p0=;
        b=aqDfvqmctlwq5suojTMhz/cA76WoB1ndypQJh3ihTeDuWUhS3fHt4SvgGrSOsyt41n
         1BLVXrW8vlP2CkhfoiQeD59gjoRRS39Vbf7myU/6TVbS4vcEE8cotuq8h79j1PTTTekN
         Q+0kWcpId4igmLCqhTBMTA0gBLBhV54wHCCJcvW6raumgIMXU6MvSO2ON1KUGOl4P9GN
         fYlAsoVqL+aNq5ywwyDGBse0y0JlQtVOiLHnD2IBLaf6JTzlU2Ns2PBYcksGXC/VA6XB
         s2fcR5MQCxnZY5GMtBkqrpgYHR75zXI/h0bUsceJG4jfaRVGgSiJ3fDWQJHWPuhJbiaX
         PemA==
X-Gm-Message-State: AHQUAubXqwHEQtOOpIZyatx+gwdDbDe4YFHryledClaS+KCMifGjGdE+
        y3avTf2U2hMzcPeRAtn4r8o=
X-Google-Smtp-Source: AHgI3IbM6eyiZwr28cUCoRKW9kxwWSYC9vhXHVYa9KEQNY1V0ZRwQTz0bRaekrYi2+8D2/qMbJ9XBg==
X-Received: by 2002:a9d:2964:: with SMTP id d91mr885903otb.286.1550864897300;
        Fri, 22 Feb 2019 11:48:17 -0800 (PST)
Received: from nuclearis2-1.lan (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id l64sm945001oif.44.2019.02.22.11.48.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 11:48:16 -0800 (PST)
From:   Alexandru Gagniuc <mr.nuke.me@gmail.com>
To:     bhelgaas@google.com
Cc:     austin_bolen@dell.com, alex_gagniuc@dellteam.com,
        keith.busch@intel.com, Shyam_Iyer@Dell.com, lukas@wunner.de,
        okaya@kernel.org, Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] PCI/MSI: Don't touch MSI bits when the PCI device is disconnected
Date:   Fri, 22 Feb 2019 13:48:06 -0600
Message-Id: <20190222194808.15962-1-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

A SURPRISE removal of a hotplug PCIe device, caused by a Link Down
event will execute an orderly removal of the driver, which normally
includes releasing the IRQs with pci_free_irq(_vectors):

 * SURPRISE removal event causes Link Down
 * pciehp_disable_slot()
 * pci_device_remove()
 * driver->remove()
 * pci_free_irq(_vectors)()
 * irq_chip->irq_mask()
 * pci_msi_mask_irq()

Eventually, msi_set_mask_bit() will attempt to do MMIO over the dead
link, usually resulting in an Unsupported Request error. This can
confuse the firmware on FFS machines, and lead to a system crash.

Since the channel will have been marked "pci_channel_io_perm_failure"
by the hotplug thread, we know we should avoid sending blind IO to a
dead link.
When the device is disconnected, bail out of MSI teardown.

If device removal and Link Down are independent events, there exists a
race condition when the Link Down event occurs right after the
pci_dev_is_disconnected() check. This is outside the scope of this patch.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
Changes since v2:
 * Updated commit message

 drivers/pci/msi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 4c0b47867258..6b6541ab264f 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -227,6 +227,9 @@ static void msi_set_mask_bit(struct irq_data *data, u32 flag)
 {
 	struct msi_desc *desc = irq_data_get_msi_desc(data);
 
+	if (pci_dev_is_disconnected(msi_desc_to_pci_dev(desc)))
+		return;
+
 	if (desc->msi_attrib.is_msix) {
 		msix_mask_irq(desc, flag);
 		readl(desc->mask_base);		/* Flush write to device */
-- 
2.19.2

