Return-Path: <SRS0=bI25=Y6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1660BC43331
	for <linux-pci@archiver.kernel.org>; Wed,  6 Nov 2019 22:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB65F2187F
	for <linux-pci@archiver.kernel.org>; Wed,  6 Nov 2019 22:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573079143;
	bh=Wr7xMJjYrsbjxLJcHAFZuiwd/4pLB2LiIoF36AQSsZs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1FKjmyc2pURZ8BlT5qQYS0cr2ZMu/AlaM9+NLJutO5m3ei5h7yY1Cvq3ZIqnTX1/K
	 ZqY/m8ONWA8uKmcRYDlTqDiEFzEvIhOSgO1Fy6OlHHQXbMRaoeQDlvNo7OutrEEznk
	 bjcy7HLyShWwviHZSbQJo/bvB4KhiLHAkCt9tpb8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732737AbfKFWZh (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 6 Nov 2019 17:25:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:42568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726779AbfKFWZg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Nov 2019 17:25:36 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0BFE217D7;
        Wed,  6 Nov 2019 22:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573079136;
        bh=Wr7xMJjYrsbjxLJcHAFZuiwd/4pLB2LiIoF36AQSsZs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oTHc5guVQalA+UlzS1Q9sEABtP3HBhq/rFL306xwOCVo7k9f09OohfbxkP1BQgjzi
         +eILlCRhgK9rNtjPy0l/S1fIYjrvR6RHx6R3C8+fxmLxOglS03gEreRpmqdX6dX6S8
         Q5m29YhmyvKcAMMt/P3NLi4NFPp0vQxL8hQW3ScQ=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 3/5] PCI/ASPM: Remove dependency on PCIEPORTBUS
Date:   Wed,  6 Nov 2019 16:24:19 -0600
Message-Id: <20191106222420.10216-4-helgaas@kernel.org>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
In-Reply-To: <20191106222420.10216-1-helgaas@kernel.org>
References: <20191106222420.10216-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

The ASPM support does not depend on the portdrv, so remove the Kconfig
dependency.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
index b0d781d72d1b..b196ad816129 100644
--- a/drivers/pci/pcie/Kconfig
+++ b/drivers/pci/pcie/Kconfig
@@ -63,7 +63,7 @@ config PCIE_ECRC
 #
 config PCIEASPM
 	bool "PCI Express ASPM control" if EXPERT
-	depends on PCI && PCIEPORTBUS
+	depends on PCI
 	default y
 	help
 	  This enables OS control over PCI Express ASPM (Active State
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

