Return-Path: <SRS0=/7fE=SK=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5695EC10F13
	for <linux-pci@archiver.kernel.org>; Mon,  8 Apr 2019 10:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2695020883
	for <linux-pci@archiver.kernel.org>; Mon,  8 Apr 2019 10:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfDHKn7 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 8 Apr 2019 06:43:59 -0400
Received: from 176.12.98.74.MAXnet.ru ([176.12.98.74]:40096 "EHLO
        shell.ipa.basealt.ru" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbfDHKn7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Apr 2019 06:43:59 -0400
X-Greylist: delayed 359 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Apr 2019 06:43:58 EDT
Received: by shell.ipa.basealt.ru (Postfix, from userid 709000081)
        id 19C9327C6C; Mon,  8 Apr 2019 13:38:01 +0300 (MSK)
From:   Nikolai Kostrigin <nickel@altlinux.org>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jroedel@suse.de, Nikolai Kostrigin <nickel@altlinux.org>
Subject: [PATCH RESEND 1/1] PCI: Add ATS-disable quirk for AMD Radeon R7 GPUs
Date:   Mon,  8 Apr 2019 13:37:25 +0300
Message-Id: <20190408103725.30426-2-nickel@altlinux.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190408103725.30426-1-nickel@altlinux.org>
References: <20190408103725.30426-1-nickel@altlinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

ATS is broken on this hardware (at least for Stoney Ridge
based laptop) and causes IOMMU stalls and
system failure. Disable ATS on these devices to make them
usable again with IOMMU enabled
Thanks to Joerg Roedel <jroedel@suse.de> for help.

https://bugzilla.kernel.org/show_bug.cgi?id=194521

Signed-off-by: Nikolai Kostrigin <nickel@altlinux.org>
---
 drivers/pci/quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 4700d24e5d55..abb2532e16bf 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4876,6 +4876,7 @@ static void quirk_no_ats(struct pci_dev *pdev)
 
 /* AMD Stoney platform GPU */
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x98e4, quirk_no_ats);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x6900, quirk_no_ats);
 #endif /* CONFIG_PCI_ATS */
 
 /* Freescale PCIe doesn't support MSI in RC mode */
-- 
2.21.0

