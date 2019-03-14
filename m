Return-Path: <SRS0=NdPK=RR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE1FFC43381
	for <linux-pci@archiver.kernel.org>; Thu, 14 Mar 2019 05:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FCE2217F5
	for <linux-pci@archiver.kernel.org>; Thu, 14 Mar 2019 05:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="hqsk+Qyr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfCNFx5 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 14 Mar 2019 01:53:57 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:39228 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbfCNFx5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Mar 2019 01:53:57 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 0AF58C57
        for <linux-pci@vger.kernel.org>; Thu, 14 Mar 2019 05:53:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tPu140GU_uDG for <linux-pci@vger.kernel.org>;
        Thu, 14 Mar 2019 00:53:55 -0500 (CDT)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id D689A924
        for <linux-pci@vger.kernel.org>; Thu, 14 Mar 2019 00:53:55 -0500 (CDT)
Received: by mail-io1-f69.google.com with SMTP id y13so3461304iol.1
        for <linux-pci@vger.kernel.org>; Wed, 13 Mar 2019 22:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=U5xe+ZNIoomORM44VhJ6h/t+96Zp9y2ll4mNH/I7bNM=;
        b=hqsk+Qyri/w0znrxhTycWtcryqKrGafoZlaMdJTsZkS7m3fS1dy8hhYw1CoTK3LuNH
         bVa8L0InYqqtH/cCZEZV0CzNDqqFRdBCvcgONBqvnxTh7DpNQEbGIs4sjJLMG80YqgZR
         xzxUNVbIPmGemQ6IyGXmqbz5rxD4rlLc0l0oK7Y+2t6KsNW0zj4bvOEAsIP0nkvv26/U
         lF24eMF4RiuNd/MzcV++nWbOfNFmAaYbdjjnB+MDYsfcM+XeqBD1MWaccw6yyWarjUzC
         cOwe6oeaVobrCjxP8QvJSCcyOfyeHRj8qh4NMb43BlMCZGRmkoR4fbz25OuPgY9N9Fqe
         BiWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=U5xe+ZNIoomORM44VhJ6h/t+96Zp9y2ll4mNH/I7bNM=;
        b=JOjf/xoaAlwJKpTUNxcNpOze0PRhBXfU3jkmgL+EVFIdtiIOZzlx4uLjXx29JdJBOU
         kxDC3nuA7+g9BMCjAJHw3lk/WFADRAxnlY9SqDpR665OICcEY7ejiBZgzt3gkdn1GwVb
         AdAHZDRBgMZk+LTnP8kdTXvhy9JDdAeOWMfWDhkJL6+dwBh07/wsY4SLGwDzrR9Rm2rX
         VweWf4SzGv9zCvuvl7bdZAWa0A5gXcVCMVOgWCykHVkQqOz8Ge13uWF078CKqy0luTc9
         MoPrASpWjDZA2rr8izVkXfdqhzsu16GLzsAU1hpSrMll+NyRekZpor3ixAiyr29L6zWW
         VVqw==
X-Gm-Message-State: APjAAAXSY0riKcA4iqNpOvHCN2IMvgVYqxYqRIBdFDhRQ7dIY7hbOsFC
        BTbJCCVzNapuR1Ou+GeC5rRc9dbCWvsaTDXAb76zbQBsT/Zhv5P2MHSptWN5iXtt6y4M0QgGs24
        d0tkUSrErkZP46x40+IodXN4L
X-Received: by 2002:a5d:85d9:: with SMTP id e25mr27941321ios.31.1552542834726;
        Wed, 13 Mar 2019 22:53:54 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzbLe0k3h9XwmTY3VTxCLfT6cz8tFtTA2VufmXaUn3c6ZwXH8hDJbvXMUwaO7Ma7TBayKBhHA==
X-Received: by 2002:a5d:85d9:: with SMTP id e25mr27941306ios.31.1552542834490;
        Wed, 13 Mar 2019 22:53:54 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id z132sm671474itb.1.2019.03.13.22.53.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 22:53:53 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Thierry Reding <thierry.reding@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] pci: pci-tegra: fix a potential NULL pointer dereference
Date:   Thu, 14 Mar 2019 00:53:47 -0500
Message-Id: <20190314055347.3519-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In case __get_free_pages fails and returns NULL, the fix returns
-ENOMEM and releases resources to avoid NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/pci/controller/pci-tegra.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index f4f53d092e00..0bdc6ee904f3 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -1550,6 +1550,12 @@ static int tegra_pcie_msi_setup(struct tegra_pcie *pcie)
 
 	/* setup AFI/FPCI range */
 	msi->pages = __get_free_pages(GFP_KERNEL, 0);
+	if (!msi->pages) {
+		dev_err(dev, "failed to get free pages\n");
+		err = -ENOMEM;
+		goto err;
+	}
+
 	msi->phys = virt_to_phys((void *)msi->pages);
 	host->msi = &msi->chip;
 
-- 
2.17.1

