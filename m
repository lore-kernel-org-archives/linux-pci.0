Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B9EC83F1C
	for <linux-pci@archiver.kernel.org>; Wed, 30 Aug 2023 18:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236805AbjH3SjH (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 30 Aug 2023 14:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243667AbjH3LYh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Aug 2023 07:24:37 -0400
Received: from out-251.mta0.migadu.com (out-251.mta0.migadu.com [91.218.175.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42AC4CDB
        for <linux-pci@vger.kernel.org>; Wed, 30 Aug 2023 04:24:32 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1693394151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pgG068lwbSrL85NgvUHE0qbc19Xz9h3Wp1jv9CrKb5c=;
        b=BKbMYeKuNn9w8yBXx4KLlXqnPUTn8v0BW6xul9d3yqsah7BbL6O/ml1fXOw1/5XOVj3U3O
        qWMzRKfVm8NU8K/LEsd0wKIobhbEriwxUla5mUczR2uSAalvqYFba+ZXVu7C8kfPwBF4co
        kiTbzT5nv73FUV61tfctQ3srW3fnE6c=
From:   Sui Jingfeng <sui.jingfeng@linux.dev>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Sui Jingfeng <suijingfeng@loongson.cn>,
        David Airlie <airlied@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [-next 4/5] drm/virgpu: Switch to pci_is_vga()
Date:   Wed, 30 Aug 2023 19:15:31 +0800
Message-Id: <20230830111532.444535-5-sui.jingfeng@linux.dev>
In-Reply-To: <20230830111532.444535-1-sui.jingfeng@linux.dev>
References: <20230830111532.444535-1-sui.jingfeng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Sui Jingfeng <suijingfeng@loongson.cn>

Should be no functional change, just for cleanup purpose.

Cc: David Airlie <airlied@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Gurchetan Singh <gurchetansingh@chromium.org>
Cc: Chia-I Wu <olvaffe@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
---
 drivers/gpu/drm/virtio/virtgpu_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
index add075681e18..3a368304475a 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.c
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
@@ -51,7 +51,7 @@ static int virtio_gpu_pci_quirk(struct drm_device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 	const char *pname = dev_name(&pdev->dev);
-	bool vga = (pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA;
+	bool vga = pci_is_vga(pdev);
 	int ret;
 
 	DRM_INFO("pci: %s detected at %s\n",
-- 
2.34.1

