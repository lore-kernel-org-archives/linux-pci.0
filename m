Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4176DC433B4
	for <linux-pci@archiver.kernel.org>; Thu,  6 May 2021 15:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 056046140F
	for <linux-pci@archiver.kernel.org>; Thu,  6 May 2021 15:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235331AbhEFPdq (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 6 May 2021 11:33:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:45838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235179AbhEFPdp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 May 2021 11:33:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2DA3A611AE;
        Thu,  6 May 2021 15:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620315167;
        bh=IdVDiP6+1WGD69KpQ4ecO/tfD5bBRFQpZYGTE4VGzkg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FFXKmiEySlP/tZydvoImG/r31EU1UBJOR46SWzqYuKF8d6dwqLioVT282SYuBon16
         ZRsbVcR4jXWpUzObLhzWQlTxIRTpuABm6P1jZUKpalx6JkBewu7iPI+OlWWvQjUAUy
         iTRvMZWwTZz4+yoPs4sr80K+rdlkqMVNnzB1/V9W2ndn/NZOkKf26pSL0JzpzOJE/g
         aIrhLIf3SU5yM/BkX38DhYt7jHN3IARbpN9tQy/3fYWZZVHn6r9Sm2CfXK0W8a4lax
         7WbduU0lKwoswL0nKcjbWNALDQsn9zmiT+jQpUdoNV+AzNSe/KDVWApIczPlRyTctW
         BG7PP6ZanlpHA==
Received: by pali.im (Postfix)
        id 1E226E79; Thu,  6 May 2021 17:32:45 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Russell King <rmk+kernel@armlinux.org.uk>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Remi Pommarel <repk@triplefau.lt>, Xogium <contact@xogium.me>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/42] PCI: aardvark: Increase polling delay to 1.5s while waiting for PIO response
Date:   Thu,  6 May 2021 17:31:15 +0200
Message-Id: <20210506153153.30454-5-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210506153153.30454-1-pali@kernel.org>
References: <20210506153153.30454-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Measurements in different conditions showed that aardvark hardware PIO
response can take up to 1.44s. Increase wait timeout from 1ms to 1.5s to
ensure that we do not miss responses from hardware. After 1.44s hardware
returns errors (e.g. Completer abort).

The previous two patches fixed checking for PIO status, so now we can use
it to also catch errors which are reported by hardware after 1.44s.

After applying this patch, kernel can detect and print PIO errors to dmesg:

    [    6.879999] advk-pcie d0070000.pcie: Non-posted PIO Response Status: CA, 0xe00 @ 0x100004
    [    6.896436] advk-pcie d0070000.pcie: Posted PIO Response Status: COMP_ERR, 0x804 @ 0x100004
    [    6.913049] advk-pcie d0070000.pcie: Posted PIO Response Status: COMP_ERR, 0x804 @ 0x100010
    [    6.929663] advk-pcie d0070000.pcie: Non-posted PIO Response Status: CA, 0xe00 @ 0x100010
    [    6.953558] advk-pcie d0070000.pcie: Posted PIO Response Status: COMP_ERR, 0x804 @ 0x100014
    [    6.970170] advk-pcie d0070000.pcie: Non-posted PIO Response Status: CA, 0xe00 @ 0x100014
    [    6.994328] advk-pcie d0070000.pcie: Posted PIO Response Status: COMP_ERR, 0x804 @ 0x100004

Without this patch kernel prints only a generic error to dmesg:

    [    5.246847] advk-pcie d0070000.pcie: config read/write timed out

Signed-off-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Marek Behún <kabel@kernel.org>
Cc: stable@vger.kernel.org # 7fbcb5da811b ("PCI: aardvark: Don't rely on jiffies while holding spinlock")
---
 drivers/pci/controller/pci-aardvark.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index a37ba86f1b2d..3f3c72927afb 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -166,7 +166,7 @@
 #define PCIE_CONFIG_WR_TYPE0			0xa
 #define PCIE_CONFIG_WR_TYPE1			0xb
 
-#define PIO_RETRY_CNT			500
+#define PIO_RETRY_CNT			750000 /* 1.5 s */
 #define PIO_RETRY_DELAY			2 /* 2 us*/
 
 #define LINK_WAIT_MAX_RETRIES		10
-- 
2.20.1

