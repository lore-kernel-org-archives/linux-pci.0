Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C62C10F0E
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 09:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 407ED20656
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 09:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uxxjd5Ka"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725851AbfDOJZs (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Apr 2019 05:25:48 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53073 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbfDOJZs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Apr 2019 05:25:48 -0400
Received: by mail-wm1-f68.google.com with SMTP id a184so19689276wma.2;
        Mon, 15 Apr 2019 02:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iJNeMsMDBbX3/V0CyypZ63i7Xih83/cjpEtyiKLsn0s=;
        b=uxxjd5KalPEc0jRb+r9Uspiws00MT29JZ4vOY3mXX2NR7ChjwPsiAUcF7coOORxjvE
         IiO7VW0f8DbU08stn/kcUxTl2YpTLuqn0/VCgygQEIcZfP3cl22rzyBL/XtWzcfrUfRt
         vGcy6mUCEJ5g54xLHe5zHHaPYNy2KwMjJ6xq+Alenkq9WKqU9BII6l2+xdNfBcfQs0Y0
         4EtyPdaR9IurLE2otSWozzwZc8LreinhKJNd/5dbUANza9mrRJdgpvKhtmEo9gCyhqTr
         gDsN6/8vDf4wY8ZJSlJ+eVwFxIaFmALmS3Z3s/XQZIyVzi38jEY4QYAG95CMfSBKwWc2
         zQgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iJNeMsMDBbX3/V0CyypZ63i7Xih83/cjpEtyiKLsn0s=;
        b=GFIJcKSS+MCH2ypQpP8wBDRyJnp58I7J+xfyE+UOSCtOCCvxxLRjJUJ7QhFWvwAP98
         pLshWiaStd65fpnS2RYkjFZBa9v+ZzQBxzCNt4kuhou5DFO33iQWiVxDCX37aoyiC4ix
         lY4ReBiIDsIP4NMbSPGBlUWNX7ZSuETc6FwlgFdhTGKmz+daczbiRU32ogGwfZrJxZ1w
         bgN9/b4Z/0LWRJc/TKk1xveuECxoXeqIj01F5qUPx6/MeA0KCIT6ZVGDoNNAdg5LKf0c
         yNG96sfwEfR1pOfkPihmEVaostVbMa82cW3BZ+uuOX7ym+P3COlNLmYnQSN43EWaWZwf
         J5Hg==
X-Gm-Message-State: APjAAAWoaFraphcPPe91anl3pdesBi9LuFUi2r+sIV9IVkhpeGM2CJRr
        /9ZDorO3419UPzdJFwBTBmk=
X-Google-Smtp-Source: APXvYqxvE/CjmENodfShqF/GX3jKBRqiBHRliqp6tBeVHmv/TBBwSn5nzKRE2JiS3JZ4BgtIYOjIaQ==
X-Received: by 2002:a1c:9dc8:: with SMTP id g191mr21936266wme.132.1555320346539;
        Mon, 15 Apr 2019 02:25:46 -0700 (PDT)
Received: from arrakis.kwizart.net (lfbn-1-6949-109.w90-116.abo.wanadoo.fr. [90.116.130.109])
        by smtp.gmail.com with ESMTPSA id u189sm18045148wme.25.2019.04.15.02.25.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 02:25:45 -0700 (PDT)
From:   Nicolas Chauvet <kwizart@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        Nicolas Chauvet <kwizart@gmail.com>
Subject: [PATCH] PCI: disable nv_msi_ht_cap_quirk_leaf quirk on arm/arm64
Date:   Mon, 15 Apr 2019 11:25:37 +0200
Message-Id: <20190415092537.14305-1-kwizart@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20180730094213.11973-1-kwizart@gmail.com>
References: <20180730094213.11973-1-kwizart@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch disable the use of nv_msi_ht_cap_quirk_leaf quirk on arm and
arm64 NVIDIA devices such as Tegra

This fixes the following output:
"pci 0000:00:01.0: nv_msi_ht_cap_quirk didn't locate host bridge"
as experienced on a Trimslice device with PCI host bridge enabled

v3: exclude the quirk for arm and arm64 instead of only for x86

v2: use __maybe_unused to avoid a warning on nv_msi_ht_cap_quirk_leaf

Signed-off-by: Nicolas Chauvet <kwizart@gmail.com>
Reviewed-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
 drivers/pci/quirks.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index a59ad09ce911..1ac65f09d7ee 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2811,12 +2811,15 @@ static void nv_msi_ht_cap_quirk_all(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AL, PCI_ANY_ID, nv_msi_ht_cap_quirk_all);
 DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_AL, PCI_ANY_ID, nv_msi_ht_cap_quirk_all);
 
-static void nv_msi_ht_cap_quirk_leaf(struct pci_dev *dev)
+static void __maybe_unused nv_msi_ht_cap_quirk_leaf(struct pci_dev *dev)
 {
 	return __nv_msi_ht_cap_quirk(dev, 0);
 }
+/* HyperTransport is not relevant on theses arches */
+#if !IS_ENABLED(CONFIG_ARM) && !IS_ENABLED(CONFIG_ARM64)
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID, nv_msi_ht_cap_quirk_leaf);
 DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID, nv_msi_ht_cap_quirk_leaf);
+#endif
 
 static void quirk_msi_intx_disable_bug(struct pci_dev *dev)
 {
-- 
2.17.2

