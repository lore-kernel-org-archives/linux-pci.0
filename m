Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1699EC4742C
	for <linux-pci@archiver.kernel.org>; Tue, 10 Nov 2020 22:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C414320825
	for <linux-pci@archiver.kernel.org>; Tue, 10 Nov 2020 22:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AdmKB44k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgKJWFY (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 10 Nov 2020 17:05:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:60442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732013AbgKJWFX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 10 Nov 2020 17:05:23 -0500
Received: from localhost (230.sub-72-107-127.myvzw.com [72.107.127.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E45F2207D3;
        Tue, 10 Nov 2020 22:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605045923;
        bh=OK56oFWwVkcKE+6AzGee/yxbtlQFhNgROhdz63iRE14=;
        h=From:To:Cc:Subject:Date:From;
        b=AdmKB44kjvL8C9A6l/M+SLE9CZQHJT4YiOe2uEevlDsHwM0Bgyex9VROLzpDoDALF
         QWRm9X1vCxHy1NKeF9i6LpTD0Qj71h7hpQM7rDT613fTjc+aLMRnp2VkKHOctYFhH7
         OErqm38iktt0OQ73+Dkgn1cob9E5z1atOOH7DU04=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     John Smith <LK7S2ED64JHGLKj75shg9klejHWG49h5hk@protonmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PCI: Add function 1 DMA alias quirk for Marvell 9215 SATA controller
Date:   Tue, 10 Nov 2020 16:05:16 -0600
Message-Id: <20201110220516.697934-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Add function 1 DMA alias quirk for Marvell 88SS9215 PCIe SSD Controller.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=42679#c135
Reported-by: John Smith <LK7S2ED64JHGLKj75shg9klejHWG49h5hk@protonmail.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/quirks.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index f70692ac79c5..4d683a28b29f 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3998,6 +3998,9 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9183,
 /* https://bugzilla.kernel.org/show_bug.cgi?id=42679#c46 */
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x91a0,
 			 quirk_dma_func1_alias);
+/* https://bugzilla.kernel.org/show_bug.cgi?id=42679#c135 */
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9215,
+			 quirk_dma_func1_alias);
 /* https://bugzilla.kernel.org/show_bug.cgi?id=42679#c127 */
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9220,
 			 quirk_dma_func1_alias);
-- 
2.25.1

