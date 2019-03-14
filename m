Return-Path: <SRS0=NdPK=RR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 339DEC43381
	for <linux-pci@archiver.kernel.org>; Thu, 14 Mar 2019 05:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0560E217F5
	for <linux-pci@archiver.kernel.org>; Thu, 14 Mar 2019 05:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="d999WUb/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfCNF4Q (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 14 Mar 2019 01:56:16 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:37974 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbfCNF4Q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Mar 2019 01:56:16 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 2B8FDB30
        for <linux-pci@vger.kernel.org>; Thu, 14 Mar 2019 05:56:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id DgrM_kR26oRZ for <linux-pci@vger.kernel.org>;
        Thu, 14 Mar 2019 00:56:15 -0500 (CDT)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id EED4DC3C
        for <linux-pci@vger.kernel.org>; Thu, 14 Mar 2019 00:56:14 -0500 (CDT)
Received: by mail-io1-f72.google.com with SMTP id k24so3425514ioa.18
        for <linux-pci@vger.kernel.org>; Wed, 13 Mar 2019 22:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Vj7JUBFBQJgDkJLGGi30nUL/l9PLQpcWCHPhW8ZQBEY=;
        b=d999WUb/V0XB5zh5a3Np2+6r7LculZvCpvxiJY/tbfY+Eba4LUZQfwMUBWhQeBZ+Ij
         wRpS+cLHZLbqD+Fgk+WGgRf4rbKbi/aA2jjLJirgpjHCq4zC335tJgEoCf44IPyK9Kcy
         JmYtvgKxhcd4JtTTy+VJ0logWXDQnuFMgBywFL0H3IOvA87m19eLa+OfKTbmfnOnmoS3
         SkW339vWxhH5Qg4gWj8wliqu+D9wb0MGtFxGryjBDu+JzHfMniRjd39HTXsEhVngMI8Y
         NxS2lEteOJLXngoQk3o0aI1neAjsi2j3MKZD+2LMxxnuAOwa5+MQQPpy2Eh8EQw5OPSg
         5mDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Vj7JUBFBQJgDkJLGGi30nUL/l9PLQpcWCHPhW8ZQBEY=;
        b=EmfEt+9CwahGGVPHIIxuMLwwH3Ov5NbzocjBZ2yhAXopoJ+5wEACzWag7n/xvY6IEu
         yg/joz44mvNUYoMZjr4NoMQMtcrNtqZaBZixvefW8HerAncVpdu4mVnxE9FvzKDgKnLJ
         wDj2gdG6dNzo+oZuiyDwlLamgY3Xu9m1neTU93nl0kka3fYXHKE7+v3WWvs2i+8c99sJ
         YgqHrt+/khIccsL4GT+vZVdmaCR81n8fQ1hNW1zxBaSHJfRJDdZQj4s3aFJkq0wLJP2G
         jIpvjnsHgylTcFq7TE6+HEeWjEBVqKU5U0J+i4dgBbDHeR5MuSZgAQ2L2un1rM6d3jO5
         pAsA==
X-Gm-Message-State: APjAAAXa6At45tf6kRvh8vFWYuda8jOSX8FvaE1yJw0kgMxumMPgTbKK
        qYTEnNXPIaE6xfy3BjXpeMD90FF0vd/mlH1hG2NYcnOr8m9SIyG5roK2lNSRuT3/BXDu5VuIjDw
        k8hka2Z8gm7LO3vbJi4Tehcz1
X-Received: by 2002:a24:628a:: with SMTP id d132mr1039444itc.164.1552542974437;
        Wed, 13 Mar 2019 22:56:14 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyI6LP0WmHGXNNL6qF5qKSj7HeXQPuB4r6XVhFKQl27ETgR9IhzBPiKJsn713IJ1uqklrY1bg==
X-Received: by 2002:a24:628a:: with SMTP id d132mr1039433itc.164.1552542974229;
        Wed, 13 Mar 2019 22:56:14 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id s142sm645936itb.37.2019.03.13.22.56.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 22:56:13 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Simon Horman <horms@verge.net.au>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pci: pcie-rcar: fix a potential NULL pointer dereference
Date:   Thu, 14 Mar 2019 00:56:08 -0500
Message-Id: <20190314055608.5209-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In case __get_free_pages fails and returns NULL, the fix returns
-ENOMEM and releases resources to avoid NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/pci/controller/pcie-rcar.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
index c8febb009454..0ba26c31d928 100644
--- a/drivers/pci/controller/pcie-rcar.c
+++ b/drivers/pci/controller/pcie-rcar.c
@@ -929,6 +929,12 @@ static int rcar_pcie_enable_msi(struct rcar_pcie *pcie)
 
 	/* setup MSI data target */
 	msi->pages = __get_free_pages(GFP_KERNEL, 0);
+	if (!msi->pages) {
+		dev_err(dev, "failed to get free pages\n");
+		err = -ENOMEM;
+		goto err;
+	}
+
 	base = virt_to_phys((void *)msi->pages);
 
 	rcar_pci_write_reg(pcie, base | MSIFE, PCIEMSIALR);
-- 
2.17.1

