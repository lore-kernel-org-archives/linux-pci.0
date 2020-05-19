Return-Path: <SRS0=17ui=7B=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C6EC433E2
	for <linux-pci@archiver.kernel.org>; Tue, 19 May 2020 18:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E52620878
	for <linux-pci@archiver.kernel.org>; Tue, 19 May 2020 18:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v3uSYjcT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgESSBp (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 19 May 2020 14:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbgESSBo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 May 2020 14:01:44 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3572AC08C5C0
        for <linux-pci@vger.kernel.org>; Tue, 19 May 2020 11:01:44 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id l11so447688wru.0
        for <linux-pci@vger.kernel.org>; Tue, 19 May 2020 11:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GyR/0Ui23R5AHEgwKIBkr1oNL8Gb0ETBbsB9Bvf72kY=;
        b=v3uSYjcTrWI5/qXsAKPtQitwafYDySNKobI2mT1/dgOS6rzcfLNMmKF8Zt+y0lAIG+
         7NlQH+xDT61+aKM9dVrX/ST+T5q9rAVx5upfWAkNFK1yIBfi0CAVIN2p765NEfOSC08U
         sFwBSa6m6vidPtQ10csw1xhsYdtx+Clr66gxG7w/lPymxvLly5LhE7Um5QY8fQhUpWaJ
         xdgGAMGjYoX5ObjkOmVHefDcNQj8HEkXT7/nacUbxTsEOjESUGfhUPoGor1ifWuorzlX
         L6qNerDYVI4QEctFS67Z/P9rCH1XE1xvD8PSxU2aJEL1im0fmYXq7/33gxfnNONbYidw
         T/Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GyR/0Ui23R5AHEgwKIBkr1oNL8Gb0ETBbsB9Bvf72kY=;
        b=V6Xb+X6DYdask+E/ZHUUmVusBI0RJ8W5Lzr5oX7fglzh1H6/OUHLdQOvlHr8mDvmW2
         clT4PIJk/EM/shQWyNfjJOwHqlesh0iO7YgQfpXQI9QdqrNJuK8kCidsuSp1lCjAU/VY
         jOlmUL6YpeWWUCRicqFc8C7dtv6jiDE9zjQ5/OF9riUPjYBEnh/YnedzgMAyGC0BBBZ6
         Bessy8DbkSyaTZ8/ef7zO7PseV7aLfdN8cmP00/QcLhMqRtaGRZSqPlXvBoyeoxakgcT
         HFmj43VSeTCkn3OyxwIZjobdV6MTzb+GSM2SRlqkMaWoL24eQXi31/hFjcRQweLFSop/
         MIiw==
X-Gm-Message-State: AOAM533K2GgmHyMwTy91AS4+I6c3/oNH/EuAc71pQqt5GyvM/hVprQS/
        U+FIKDzrZD+yHPCP6Q0FXEklQw==
X-Google-Smtp-Source: ABdhPJyPXdWabIumTknX9KHGpAfZMDP+D+8kcHDQrtNtnJy5wEFWx5RISo0BU/ne7okq5g9/m6U84w==
X-Received: by 2002:a5d:694d:: with SMTP id r13mr112031wrw.238.1589911302937;
        Tue, 19 May 2020 11:01:42 -0700 (PDT)
Received: from localhost.localdomain ([2001:171b:226e:c200:c43b:ef78:d083:b355])
        by smtp.gmail.com with ESMTPSA id 1sm510496wmz.13.2020.05.19.11.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 11:01:42 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org
Cc:     joro@8bytes.org, catalin.marinas@arm.com, will@kernel.org,
        robin.murphy@arm.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, Jonathan.Cameron@huawei.com,
        jacob.jun.pan@linux.intel.com, christian.koenig@amd.com,
        felix.kuehling@amd.com, zhangfei.gao@linaro.org, jgg@ziepe.ca,
        xuzaibo@huawei.com, fenghua.yu@intel.com, hch@infradead.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v7 01/24] mm: Add a PASID field to mm_struct
Date:   Tue, 19 May 2020 19:54:39 +0200
Message-Id: <20200519175502.2504091-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200519175502.2504091-1-jean-philippe@linaro.org>
References: <20200519175502.2504091-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some devices can tag their DMA requests with a 20-bit Process Address
Space ID (PASID), allowing them to access multiple address spaces. In
combination with recoverable I/O page faults (for example PCIe PRI),
PASID allows the IOMMU to share page tables with the MMU.

To make sure that a single PASID is allocated for each address space, as
required by Intel ENQCMD, store the PASID in the mm_struct. The IOMMU
driver is in charge of serializing modifications to the PASID field.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 include/linux/mm_types.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 4aba6c0c2ba8..8db647275817 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -534,6 +534,10 @@ struct mm_struct {
 		atomic_long_t hugetlb_usage;
 #endif
 		struct work_struct async_put_work;
+#ifdef CONFIG_IOMMU_SUPPORT
+		/* Address space ID used by device DMA */
+		unsigned int pasid;
+#endif
 	} __randomize_layout;
 
 	/*
-- 
2.26.2

