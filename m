Return-Path: <SRS0=isgL=56=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C7BDC55186
	for <linux-pci@archiver.kernel.org>; Tue, 14 Apr 2020 17:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED05C20678
	for <linux-pci@archiver.kernel.org>; Tue, 14 Apr 2020 17:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KSZ3slzL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391619AbgDNRE6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 14 Apr 2020 13:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391603AbgDNREv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Apr 2020 13:04:51 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9422BC061A10
        for <linux-pci@vger.kernel.org>; Tue, 14 Apr 2020 10:04:51 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id h26so3845030wrb.7
        for <linux-pci@vger.kernel.org>; Tue, 14 Apr 2020 10:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dxDAAgL2UYsehlg428ECGLr43fDkT+szEz8iWolntSk=;
        b=KSZ3slzLde6NozRQYn2Ai7oqpucgG9X78qXMfbMZBdcER7nRY1kUNT7Qt/IDN4MDjl
         vb8Pwa0ulpEZSn0BBnH4dvqEPTE7RcoGq9Z0W234cFc+SVbRftS1kIvCyI853alAlB+Y
         rEPDG1qUaGZ8aDnk0qSGGOfVXMDaGzZE9CbxCxqT/oC+CO1OIwkFRvN+6kDc104C4vkE
         8G9SDBWgw+ffbm6VeWoWzvyoCQ+PUbDkthqAws5ZdzYv2p4NNty/Nv1AQXZJv7O+3rA/
         yHUo655cjGXVw0ER+P3ankuAQ6Jt9og6eLbHOvkwVehp8uN30C+g/z+zrhkAnk1Cf6Kl
         OqWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dxDAAgL2UYsehlg428ECGLr43fDkT+szEz8iWolntSk=;
        b=LxhU4iRyXq6c/JgrVi+4YGbcG3YTJcMPxsSqbCGjE1Hqxr413ZrzRs04l4sGWpY2B6
         wvq9RnSoN34kpHAT3KO6Y25uxpiTaIstFtglNA0gfEGFMX6CKpJeksyieERklISInJk8
         /db+yzNIwczzT/hMhjbQk4wD8ZbALEJ3GgzteTNIl9smFPLqAv+3HaBrxrQDuPi4h0bR
         sAJXhMDkltcblnlwBhgGfr/mGokW/o8Fj24sH4nt62Cz6yZk+3d2j5IV/dp1d6fohd99
         T0qZO7PNoevtGZbPNfSwPXELxwj+knaVVF1UnsyJdea5GsG29RdUoDOGXm9hGAILjS+7
         3auA==
X-Gm-Message-State: AGi0Pua8sJVJAtRIsjJ6IsjBed7m8w7m2HOBslQKCwjQ6HKGd4w0zAQZ
        IvZJ1+DJOvnv1olsSPsMevBDsw==
X-Google-Smtp-Source: APiQypLvU1DM9P6089K9k3mSfMy8oJyq3WdIaLTthIKtphu5RdduiyeU/R3KBAD03tQZ8c5tQnffKg==
X-Received: by 2002:a5d:4447:: with SMTP id x7mr2258833wrr.299.1586883890363;
        Tue, 14 Apr 2020 10:04:50 -0700 (PDT)
Received: from localhost.localdomain ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id x18sm19549147wrs.11.2020.04.14.10.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 10:04:49 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org
Cc:     joro@8bytes.org, catalin.marinas@arm.com, will@kernel.org,
        robin.murphy@arm.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, Jonathan.Cameron@huawei.com,
        jacob.jun.pan@linux.intel.com, christian.koenig@amd.com,
        zhangfei.gao@linaro.org, jgg@ziepe.ca, xuzaibo@huawei.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v5 23/25] PCI/ATS: Add PRI stubs
Date:   Tue, 14 Apr 2020 19:02:51 +0200
Message-Id: <20200414170252.714402-24-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200414170252.714402-1-jean-philippe@linaro.org>
References: <20200414170252.714402-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The SMMUv3 driver, which can be built without CONFIG_PCI, will soon gain
support for PRI.  Partially revert commit c6e9aefbf9db ("PCI/ATS: Remove
unused PRI and PASID stubs") to re-introduce the PRI stubs, and avoid
adding more #ifdefs to the SMMU driver.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 include/linux/pci-ats.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
index f75c307f346de..e9e266df9b37c 100644
--- a/include/linux/pci-ats.h
+++ b/include/linux/pci-ats.h
@@ -28,6 +28,14 @@ int pci_enable_pri(struct pci_dev *pdev, u32 reqs);
 void pci_disable_pri(struct pci_dev *pdev);
 int pci_reset_pri(struct pci_dev *pdev);
 int pci_prg_resp_pasid_required(struct pci_dev *pdev);
+#else /* CONFIG_PCI_PRI */
+static inline int pci_enable_pri(struct pci_dev *pdev, u32 reqs)
+{ return -ENODEV; }
+static inline void pci_disable_pri(struct pci_dev *pdev) { }
+static inline int pci_reset_pri(struct pci_dev *pdev)
+{ return -ENODEV; }
+static inline int pci_prg_resp_pasid_required(struct pci_dev *pdev)
+{ return 0; }
 #endif /* CONFIG_PCI_PRI */
 
 #ifdef CONFIG_PCI_PASID
-- 
2.26.0

