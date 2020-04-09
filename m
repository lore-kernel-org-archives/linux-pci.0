Return-Path: <SRS0=pSR+=5Z=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 431B4C2BA2B
	for <linux-pci@archiver.kernel.org>; Thu,  9 Apr 2020 16:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 185C520753
	for <linux-pci@archiver.kernel.org>; Thu,  9 Apr 2020 16:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IX6Agv0U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgDIQQQ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 9 Apr 2020 12:16:16 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50453 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbgDIQQQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Apr 2020 12:16:16 -0400
Received: by mail-wm1-f67.google.com with SMTP id x25so365898wmc.0
        for <linux-pci@vger.kernel.org>; Thu, 09 Apr 2020 09:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=b+mOxU4J72rHc/2vUWqnDVVF3rP/Hnl93uURK+ooxfA=;
        b=IX6Agv0Uy+Tndn6vnCw1Mw+a5A/faJoFJP3zJFzUtD9M7hRqQmfeoGw1csOfXof2vQ
         Mbp7q0q0qQeLFAq5NvT1mQK3GOBH9n99ojgOcgFLtX1aOUF5E31ZlwT1FAbdUtOtsLrv
         jFWAISuQenK+aVxIaC29f8i2rNci/gsioC2SGzl+18ri+8rVTfqmNEt/8g6VC/SrBqxi
         GJkPQjVv8/s8VMszcNd8gDDPi1kSfU73W5PxlvVbEPTwGKKK5aUNhepKXcTVCXuiTScu
         EOD11bjT5x20a89K3AYTpFNqGl70y8GBSpfe+s/Qv3XWOJEBQ74eERHJPTrZ2/O9BiEz
         /phw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=b+mOxU4J72rHc/2vUWqnDVVF3rP/Hnl93uURK+ooxfA=;
        b=LDcHR0bnwLcMex4RK+IijUkJ1ziwcNJu29jb8A451XFSmQXJdLSsl9A5bwJ+Zq972c
         pRCSjyJMC9M39xEtefsdoDpxZDXRXbx248v52SOMaHjHHwB1K70xwPTq38dBoRdvNfY0
         yPH61/iZvGWFbItgZM/KUPpnM/+wfqSGOHwDLKy0yDXZ8gKv98UOh9T7i725Hl3nwPQc
         C8G/ZI9IzuyuW+pINpIInhXYLontgymaegMW61DE+GYOkiAgoxqHSGOaNZ+Z668SF9cS
         qL6I4afky+dpMZJESm4GESYURVybJ+cctfZsrxbK5HbiQbrbAjHHdq8zrMs+rLHK3biy
         pmGw==
X-Gm-Message-State: AGi0Puau0QXRlnfcZ8tFAz3dqUvMxhmBbehDjlwwKaeV+Xis5L/EVnQq
        SfZEbbZAoL7LKlKvU0UQcGA8Vne6/UTGnQ==
X-Google-Smtp-Source: APiQypLH+aj1zHlXs4E0ZqZpASyY9Be79agUhFPZGbJUSTfWulkxHbG25RmTYUMH0J3HlBiLQ5iIgw==
X-Received: by 2002:a05:600c:24cf:: with SMTP id 15mr619235wmu.94.1586448974446;
        Thu, 09 Apr 2020 09:16:14 -0700 (PDT)
Received: from localhost.localdomain (51B786A4.dsl.pool.telekom.hu. [81.183.134.164])
        by smtp.gmail.com with ESMTPSA id h6sm4440436wmf.31.2020.04.09.09.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 09:16:13 -0700 (PDT)
From:   Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     Bolarinwa Olayemi Saheed <refactormyself@gmail.com>,
        bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-pci@vger.kernel.org
Subject: [PATCH] Replace -EINVAL with PCIBIOS_BAD_REGISTER_NUMBER
Date:   Thu,  9 Apr 2020 18:16:09 +0200
Message-Id: <20200409161609.2034-1-refactormyself@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Signed-off-by: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
Suggested-by: Bjorn Helgaas <bjorn@helgaas.com>
---
 drivers/pci/access.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index 79c4a2ef269a..451f2b8b2b3c 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -409,7 +409,7 @@ int pcie_capability_read_word(struct pci_dev *dev, int pos, u16 *val)
 
 	*val = 0;
 	if (pos & 1)
-		return -EINVAL;
+		return PCIBIOS_BAD_REGISTER_NUMBER;
 
 	if (pcie_capability_reg_implemented(dev, pos)) {
 		ret = pci_read_config_word(dev, pci_pcie_cap(dev) + pos, val);
@@ -444,7 +444,7 @@ int pcie_capability_read_dword(struct pci_dev *dev, int pos, u32 *val)
 
 	*val = 0;
 	if (pos & 3)
-		return -EINVAL;
+		return PCIBIOS_BAD_REGISTER_NUMBER;
 
 	if (pcie_capability_reg_implemented(dev, pos)) {
 		ret = pci_read_config_dword(dev, pci_pcie_cap(dev) + pos, val);
-- 
2.17.1

