Return-Path: <SRS0=Fxx+=57=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C5FCC2BB1D
	for <linux-pci@archiver.kernel.org>; Wed, 15 Apr 2020 00:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BE4A20774
	for <linux-pci@archiver.kernel.org>; Wed, 15 Apr 2020 00:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586909632;
	bh=E3lqc6yFCVNuZKv0A7m/xGbVOhzCfARPpSX+MtPd388=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=w/RkoKZEU0pKXwh8sS3sKitV17+d2ZG7vHOPIz2LzKkD8ubmn7aiKwDM4Q3j8bzoQ
	 CoZaBDFtF26vVPRVvDcWTqoeV77SqWDSmEaTZ8FgWKQu1RiGtf+XRbK9fVlFcHhn6/
	 TIIPkUdToiyAL65n9CvndWS3/V0mS0BlEHtYrPaY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407862AbgDOANn (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 14 Apr 2020 20:13:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:37228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392316AbgDOANZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Apr 2020 20:13:25 -0400
Received: from localhost (mobile-166-175-184-103.mycingular.net [166.175.184.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C740E20787;
        Wed, 15 Apr 2020 00:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586909605;
        bh=E3lqc6yFCVNuZKv0A7m/xGbVOhzCfARPpSX+MtPd388=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1JOgjLhWE5zpQDqPA8sPGXSHxAKTkOVOze9NtEpQ48DrqT0ckXMwffVj7OpkcqOeq
         tn0TI/1xYQnmw/Gs5pftyNQLbHDtmxYQhdd1bIO+XAALJh/ZOT3sx9Lh2Yzdotk+BK
         hvRLgnGXBdSgc+YVfHw5rf4tFcagTZYtBtD/9IE4=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 4/4] PCI/ASPM: Don't select CONFIG_PCIEASPM by default
Date:   Tue, 14 Apr 2020 19:12:44 -0500
Message-Id: <20200415001244.144623-5-helgaas@kernel.org>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
In-Reply-To: <20200415001244.144623-1-helgaas@kernel.org>
References: <20200415001244.144623-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

PCIe Active State Power Management (ASPM) is optional and there's no need
for it to be selected by default.

Remove the "default y" for CONFIG_PCIEASPM.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/pci/pcie/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
index 9cd31331aee9..5b7b460a8a98 100644
--- a/drivers/pci/pcie/Kconfig
+++ b/drivers/pci/pcie/Kconfig
@@ -62,7 +62,6 @@ config PCIE_ECRC
 #
 config PCIEASPM
 	bool "PCI Express ASPM control" if EXPERT
-	default y
 	help
 	  This enables OS control over PCI Express ASPM (Active State
 	  Power Management) and Clock Power Management. ASPM supports
-- 
2.26.0.110.g2183baf09c-goog

