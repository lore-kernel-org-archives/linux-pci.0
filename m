Return-Path: <SRS0=NyCf=44=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B18FCC10F29
	for <linux-pci@archiver.kernel.org>; Wed, 11 Mar 2020 07:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94679222C3
	for <linux-pci@archiver.kernel.org>; Wed, 11 Mar 2020 07:10:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgCKHKK (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 11 Mar 2020 03:10:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:33430 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbgCKHKK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Mar 2020 03:10:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4070FABDC;
        Wed, 11 Mar 2020 07:10:08 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     linux-pci@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH] PCI/ACPI: Use scnprintf() for avoiding potential buffer overflow
Date:   Wed, 11 Mar 2020 08:09:58 +0100
Message-Id: <20200311070958.3791-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since snprintf() returns the would-be-output size instead of the
actual output size, the succeeding calls may go beyond the given
buffer limit.  Fix it by replacing with scnprintf().

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/acpi/pci_root.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index d1e666ef3fcc..f92df2533e7e 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -153,7 +153,7 @@ static void decode_osc_bits(struct acpi_pci_root *root, char *msg, u32 word,
 	buf[0] = '\0';
 	for (i = 0, entry = table; i < size; i++, entry++)
 		if (word & entry->bit)
-			len += snprintf(buf + len, sizeof(buf) - len, "%s%s",
+			len += scnprintf(buf + len, sizeof(buf) - len, "%s%s",
 					len ? " " : "", entry->desc);
 
 	dev_info(&root->device->dev, "_OSC: %s [%s]\n", msg, buf);
-- 
2.16.4

