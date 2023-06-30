Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74E7EB64DD
	for <linux-pci@archiver.kernel.org>; Fri, 30 Jun 2023 10:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjF3KXe (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 30 Jun 2023 06:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232492AbjF3KXd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Jun 2023 06:23:33 -0400
Received: from out-27.mta0.migadu.com (out-27.mta0.migadu.com [IPv6:2001:41d0:1004:224b::1b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3653596
        for <linux-pci@vger.kernel.org>; Fri, 30 Jun 2023 03:23:31 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1688120263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=238fDL+qYWlIygY8L+jiZcs0vm4Z6TsIfIVyCvmsMuE=;
        b=WIbZHN1Af9cTX2vBC2L4s1RTsoGG8MUC/jXIYnkc+8EEw9kzXVTqtZLrpS2hnA0b+na8xR
        Syexya3onHZPwUjMJ8ZcIbx/lipGGEl1S9rl+KVKGlGa7pW7jcHC/kJQqES8YonoT65EXy
        w7QdeJ0p5+248Z3AqK0yzef6m1/cB2U=
From:   Sui Jingfeng <sui.jingfeng@linux.dev>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Sui Jingfeng <suijingfeng@loongson.cn>,
        Andi Shyti <andi.shyti@linux.intel.com>
Subject: [PATCH 1/4] PCI/VGA: Use unsigned type for the io_state variable
Date:   Fri, 30 Jun 2023 18:17:28 +0800
Message-Id: <20230630101731.134375-1-sui.jingfeng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Sui Jingfeng <suijingfeng@loongson.cn>

The io_state variable in the vga_arb_write() function is declared with
unsigned int type, while the vga_str_to_iostate() function takes int *
type. To keep them consistent, replace the third argument of
vga_str_to_iostate() function with the unsigned int * type.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
---
 drivers/pci/vgaarb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
index 5a696078b382..c1bc6c983932 100644
--- a/drivers/pci/vgaarb.c
+++ b/drivers/pci/vgaarb.c
@@ -77,7 +77,7 @@ static const char *vga_iostate_to_str(unsigned int iostate)
 	return "none";
 }
 
-static int vga_str_to_iostate(char *buf, int str_size, int *io_state)
+static int vga_str_to_iostate(char *buf, int str_size, unsigned int *io_state)
 {
 	/* we could in theory hand out locks on IO and mem
 	 * separately to userspace but it can cause deadlocks */
-- 
2.25.1

