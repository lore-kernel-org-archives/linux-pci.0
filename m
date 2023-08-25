Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C907FC7EE2C
	for <linux-pci@archiver.kernel.org>; Fri, 25 Aug 2023 06:28:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241754AbjHYG1y (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 25 Aug 2023 02:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242122AbjHYG1i (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Aug 2023 02:27:38 -0400
Received: from out-28.mta1.migadu.com (out-28.mta1.migadu.com [95.215.58.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686EA1FD5
        for <linux-pci@vger.kernel.org>; Thu, 24 Aug 2023 23:27:36 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692944854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HvMwAdaM/5LwVLuwlRIstn4bDRGDsqcLFd+SgLGHveo=;
        b=J9557CESZD0jU1gCVKUTQTMhgPsStpHY4kD4mKKub+s8jAS6W/GwAlQNVLhdXsTlKgbIwP
        nGtqCj8han5cBytFhcvOlFt/sFPnp09Xx8kaVT4m9VTtL6o8FFya8yCHODM9rXrlRHcr1v
        jrvUtaJzRL22rSHGrA5R7eJ7HIsgmug=
From:   Sui Jingfeng <sui.jingfeng@linux.dev>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org,
        linux-pci@vger.kernel.org, alsa-devel@alsa-project.org,
        Sui Jingfeng <suijingfeng@loongson.cn>,
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH 3/5] drm/nouveau: Use pci_get_base_class() to reduce duplicated code
Date:   Fri, 25 Aug 2023 14:27:12 +0800
Message-Id: <20230825062714.6325-4-sui.jingfeng@linux.dev>
In-Reply-To: <20230825062714.6325-1-sui.jingfeng@linux.dev>
References: <20230825062714.6325-1-sui.jingfeng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Sui Jingfeng <suijingfeng@loongson.cn>

Should be no functional change.

Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: Karol Herbst <kherbst@redhat.com>
Cc: Lyude Paul <lyude@redhat.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
---
 drivers/gpu/drm/nouveau/nouveau_acpi.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_acpi.c b/drivers/gpu/drm/nouveau/nouveau_acpi.c
index a2ae8c21e4dc..8f0c69aad248 100644
--- a/drivers/gpu/drm/nouveau/nouveau_acpi.c
+++ b/drivers/gpu/drm/nouveau/nouveau_acpi.c
@@ -284,14 +284,11 @@ static bool nouveau_dsm_detect(void)
 		printk("MXM: GUID detected in BIOS\n");
 
 	/* now do DSM detection */
-	while ((pdev = pci_get_class(PCI_CLASS_DISPLAY_VGA << 8, pdev)) != NULL) {
-		vga_count++;
-
-		nouveau_dsm_pci_probe(pdev, &dhandle, &has_mux, &has_optimus,
-				      &has_optimus_flags, &has_power_resources);
-	}
+	while ((pdev = pci_get_base_class(PCI_BASE_CLASS_DISPLAY, pdev))) {
+		if ((pdev->class != PCI_CLASS_DISPLAY_VGA << 8) &&
+		    (pdev->class != PCI_CLASS_DISPLAY_3D << 8))
+			continue;
 
-	while ((pdev = pci_get_class(PCI_CLASS_DISPLAY_3D << 8, pdev)) != NULL) {
 		vga_count++;
 
 		nouveau_dsm_pci_probe(pdev, &dhandle, &has_mux, &has_optimus,
-- 
2.34.1

