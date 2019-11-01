Return-Path: <SRS0=mg7z=YZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14969CA9ECF
	for <linux-pci@archiver.kernel.org>; Fri,  1 Nov 2019 20:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D001021855
	for <linux-pci@archiver.kernel.org>; Fri,  1 Nov 2019 20:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572641214;
	bh=k7uCsAAUnxZ80bJgOazN3gY0TaSbWkotrbmrix3LrZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f/HX65shOFwDIv0TsOyr/eelr94mkSfk09SchTBcWFPI0eMFFgKsLgcsSbYtKBlhS
	 odC4FJgmA9b+ZgUQdYWpjm+1zNyNVndr+rUVyqTP+q6DVHNrxHXHENZ3kuHVMp1tuw
	 PGe8mrwH1rWacxred3c6wg4Klgh3Fwp/UAxf5QDE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbfKAUqy (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 1 Nov 2019 16:46:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:55742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727517AbfKAUqy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 Nov 2019 16:46:54 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FC64217D9;
        Fri,  1 Nov 2019 20:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572641213;
        bh=k7uCsAAUnxZ80bJgOazN3gY0TaSbWkotrbmrix3LrZ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MQwnuCXbx0NlLtjWD9KPezsAVDSxkvv84gdXz4Ncz1guqwmzSK/+wHVua4XoqdUHc
         tRQZrUMg2MYnhIbs5N/XQM9w22+2Qu7Zbjfrfsl+8yoE6OFwNS8P3IZsqMXhech3Lv
         KdQCL65NrM+6brGLhI6ADlR1OElJBbdLgv9ozp68=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        KarimAllah Ahmed <karahmed@amazon.de>
Subject: [PATCH 4/6] xen-platform: Convert to generic power management
Date:   Fri,  1 Nov 2019 15:45:56 -0500
Message-Id: <20191101204558.210235-5-helgaas@kernel.org>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
In-Reply-To: <20191101204558.210235-1-helgaas@kernel.org>
References: <20191101204558.210235-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Convert xen-platform from the legacy PCI power management callbacks to the
generic operations.  This is one step towards removing support for the
legacy PCI callbacks.

The generic .resume_noirq() operation is called by pci_pm_resume_noirq() at
the same point the legacy PCI .resume_early() callback was, so this patch
should not change the xen-platform behavior.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: KarimAllah Ahmed <karahmed@amazon.de>
---
 drivers/xen/platform-pci.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/xen/platform-pci.c b/drivers/xen/platform-pci.c
index 5e30602fdbad..e06e8769eb84 100644
--- a/drivers/xen/platform-pci.c
+++ b/drivers/xen/platform-pci.c
@@ -168,13 +168,17 @@ static const struct pci_device_id platform_pci_tbl[] = {
 	{0,}
 };
 
+static struct dev_pm_ops platform_pm_ops = {
+	.resume_noirq =   platform_pci_resume,
+};
+
 static struct pci_driver platform_driver = {
 	.name =           DRV_NAME,
 	.probe =          platform_pci_probe,
 	.id_table =       platform_pci_tbl,
-#ifdef CONFIG_PM
-	.resume_early =   platform_pci_resume,
-#endif
+	.driver = {
+		.pm =     &platform_pm_ops,
+	},
 };
 
 builtin_pci_driver(platform_driver);
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

