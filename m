Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE0BC4338F
	for <linux-pci@archiver.kernel.org>; Fri, 20 Aug 2021 10:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B43A60F4A
	for <linux-pci@archiver.kernel.org>; Fri, 20 Aug 2021 10:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237085AbhHTKMW (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 20 Aug 2021 06:12:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:56970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232572AbhHTKMV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Aug 2021 06:12:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F21396103A;
        Fri, 20 Aug 2021 10:11:41 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V3 6/9] PCI/VGA: Prefer vga_default_device()
Date:   Fri, 20 Aug 2021 18:08:29 +0800
Message-Id: <20210820100832.663931-7-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210820100832.663931-1-chenhuacai@loongson.cn>
References: <20210820100832.663931-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use the vga_default_device() interface consistently instead of directly
testing vga_default.  No functional change intended.

[bhelgaas: split to separate patch and extended]
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/vgaarb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
index 1f8fb37be5fa..a6a5864ff538 100644
--- a/drivers/pci/vgaarb.c
+++ b/drivers/pci/vgaarb.c
@@ -173,7 +173,7 @@ int vga_remove_vgacon(struct pci_dev *pdev)
 {
 	int ret = 0;
 
-	if (pdev != vga_default)
+	if (pdev != vga_default_device())
 		return 0;
 	vgaarb_info(&pdev->dev, "deactivate vga console\n");
 
@@ -707,7 +707,7 @@ static bool vga_arbiter_add_pci_device(struct pci_dev *pdev)
 	/* Deal with VGA default device. Use first enabled one
 	 * by default if arch doesn't have it's own hook
 	 */
-	if (vga_default == NULL &&
+	if (!vga_default_device() &&
 	    ((vgadev->owns & VGA_RSRC_LEGACY_MASK) == VGA_RSRC_LEGACY_MASK)) {
 		vgaarb_info(&pdev->dev, "setting as boot VGA device\n");
 		vga_set_default_device(pdev);
@@ -744,7 +744,7 @@ static bool vga_arbiter_del_pci_device(struct pci_dev *pdev)
 		goto bail;
 	}
 
-	if (vga_default == pdev)
+	if (vga_default_device() == pdev)
 		vga_set_default_device(NULL);
 
 	if (vgadev->decodes & (VGA_RSRC_LEGACY_IO | VGA_RSRC_LEGACY_MEM))
-- 
2.27.0

