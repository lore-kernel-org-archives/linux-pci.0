Return-Path: <SRS0=pSR+=5Z=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC1BCC2BA2B
	for <linux-pci@archiver.kernel.org>; Thu,  9 Apr 2020 11:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD2E820771
	for <linux-pci@archiver.kernel.org>; Thu,  9 Apr 2020 11:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbgDILld (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 9 Apr 2020 07:41:33 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48265 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbgDILld (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Apr 2020 07:41:33 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jMVYc-0004rk-7i; Thu, 09 Apr 2020 11:41:18 +0000
From:   Colin King <colin.king@canonical.com>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        xen-devel@lists.xenproject.org, linux-pci@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] xen/pci: remove redundant assignment to variable irq
Date:   Thu,  9 Apr 2020 12:41:18 +0100
Message-Id: <20200409114118.249461-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable irq is being initialized with a value that is never read
and it is being updated later with a new value.  The initialization is
redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 arch/x86/pci/xen.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
index 91220cc25854..80272eb49230 100644
--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -63,7 +63,7 @@ static int xen_pcifront_enable_irq(struct pci_dev *dev)
 static int xen_register_pirq(u32 gsi, int gsi_override, int triggering,
 			     bool set_pirq)
 {
-	int rc, pirq = -1, irq = -1;
+	int rc, pirq = -1, irq;
 	struct physdev_map_pirq map_irq;
 	int shareable = 0;
 	char *name;
-- 
2.25.1

