Return-Path: <SRS0=IRj4=B7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FF1C433E3
	for <linux-pci@archiver.kernel.org>; Fri, 21 Aug 2020 13:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 467CA207DA
	for <linux-pci@archiver.kernel.org>; Fri, 21 Aug 2020 13:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pY2YbYHS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbgHUNQ2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Aug 2020 09:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728756AbgHUNQR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Aug 2020 09:16:17 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952C4C061342
        for <linux-pci@vger.kernel.org>; Fri, 21 Aug 2020 06:16:15 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id m22so2209082eje.10
        for <linux-pci@vger.kernel.org>; Fri, 21 Aug 2020 06:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZnnZtMxmP4b7OMlDsIV6bQJbOj4fdGL8aaL1hhmjLLA=;
        b=pY2YbYHS5mikDdweoT7I0A6q9uT3ometn8FGbkCmiALLLRBZ7T5CUUIzOPSzePumsr
         5nVU/Of+D1O09VPiw+V19VBWqEeiR+ed6F2FuDNqj5OXZVpR1r7CKaXoH8BU2TGA//Mk
         REi4qfELDk/LPFv51pecAc0wLz0sjnbltg48c2UZ6oEGqEddU0eeHvEiktKMfM8CrXAR
         24BjGg9QPwJCXtKW16GNd3wBjTWgXDlouU7YYfmHXPSVH2UUgSKlFi6UCokoDcksLjeF
         CK67SeJGYmClge7RphPcpwaKaSeXvKeSAqpLlgFvQ5ACoV5W0wlnksDr2TVEpp4Owz1b
         j69Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZnnZtMxmP4b7OMlDsIV6bQJbOj4fdGL8aaL1hhmjLLA=;
        b=Co9qGe6xx768mBmH4mzUNjW4T059FMWIxrVJnfgNY1IgWIHXr6/z8ZCcQojQlx99+T
         ktt00KlwmGoBgYnJrlf2O/WnTdrQkus+epHEwck3AfkQ0xW5GerxppZ8V8ikuyL7/sW0
         wndciND7iTDZtEs1Nj/FmL+tIzDmDcCOZImXs4wVImyDFf6nJv7a9cl6qBDArhcjmgra
         aCBi0N3VOjOINkViqFOT9SMf79wXRyjekPlmmK9JjSItN3gYyVNTry1GwB9mbwhrwLOg
         prQBWa1edmAu9bQCAoW5lYI2MYNmjvjZpvDfIDIO6CHCjSVLPghpZJOQabswvP/xdP7r
         c5EQ==
X-Gm-Message-State: AOAM530BSfUpffUBu0HPJ8xQYWyjsABSN2y2x/uhvyEoQCzUDW2A1LIe
        GGIBQRDXb4LjM97HF4D4K9JXHA==
X-Google-Smtp-Source: ABdhPJzPzKZv0XqkxFhftdpeIsh87fWGpOtYot+rgSUcL/9LlvBX6pXEuFdZEBC/z0H9ehxzTOYJaw==
X-Received: by 2002:a17:906:e17:: with SMTP id l23mr2725404eji.13.1598015774044;
        Fri, 21 Aug 2020 06:16:14 -0700 (PDT)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id v4sm1299748eje.39.2020.08.21.06.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 06:16:13 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, linux-pci@vger.kernel.org
Cc:     joro@8bytes.org, bhelgaas@google.com, mst@redhat.com,
        jasowang@redhat.com, kevin.tian@intel.com,
        sebastien.boeuf@intel.com, eric.auger@redhat.com,
        lorenzo.pieralisi@arm.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v3 6/6] iommu/virtio: Enable x86 support
Date:   Fri, 21 Aug 2020 15:15:40 +0200
Message-Id: <20200821131540.2801801-7-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200821131540.2801801-1-jean-philippe@linaro.org>
References: <20200821131540.2801801-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

With the built-in topology description in place, x86 platforms can now
use the virtio-iommu.

Architectures that use the generic iommu_dma_ops should normally select
CONFIG_IOMMU_DMA themselves (from arch/*/Kconfig). Since not all x86
drivers have been converted yet, it's currently up to the IOMMU Kconfig
to select it.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 98d28fdbc19a..d7cf158745eb 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -383,8 +383,9 @@ config HYPERV_IOMMU
 config VIRTIO_IOMMU
 	tristate "Virtio IOMMU driver"
 	depends on VIRTIO
-	depends on ARM64
+	depends on (ARM64 || X86)
 	select IOMMU_API
+	select IOMMU_DMA if X86
 	select INTERVAL_TREE
 	help
 	  Para-virtualised IOMMU driver with virtio.
-- 
2.28.0

