Return-Path: <SRS0=O37L=DB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97EB6C4346E
	for <linux-pci@archiver.kernel.org>; Thu, 24 Sep 2020 08:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45F282376F
	for <linux-pci@archiver.kernel.org>; Thu, 24 Sep 2020 08:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600937191;
	bh=ecsj6lH3Ts3LcLamN9E6ndiUHOHtod9v0zk5bSVqHq0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=EClLdUkSimD8ulMsj3LDvThMFTL9Q1AeNSAbW/i2ZGRKtQ2K9RVzwdsNVTbTjnCJo
	 k4sr1S9TkH5ih61u2kHsuaIwHi/DGgtEXphtLPo5uMYaYiQ15qj7/dZfQH6UeVf8o7
	 TGxkIJcRwBde++/6GlfBVpqSfPdVr/MRY+I9F5ME=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgIXIqa (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 24 Sep 2020 04:46:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:53354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726387AbgIXIqa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Sep 2020 04:46:30 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CCEA23600;
        Thu, 24 Sep 2020 08:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600937190;
        bh=ecsj6lH3Ts3LcLamN9E6ndiUHOHtod9v0zk5bSVqHq0=;
        h=From:To:Cc:Subject:Date:From;
        b=hMlx3apBD1Gu5WVoY/Bwik8j7xQwRFFxV5rBMnLWkhdG2lwKF8sD/H6lff3Bj2v5k
         bku+rQJ3Y0dkDkzX98EzRXL3Lenz+FKXionGGpmdCAOcY9qV/zQaUiBKEcQwt3es8c
         3VWss38chUq4bqzhKxKXUqoZ7tfdZEsdrtkfBuG0=
Received: by pali.im (Postfix)
        id 80DC68A3; Thu, 24 Sep 2020 10:46:27 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: aardvark: Update comment about disabling link training
Date:   Thu, 24 Sep 2020 10:46:18 +0200
Message-Id: <20200924084618.12442-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

It is not HW bug or workaround for some cards but it is requirement by PCI
Express spec. After fundamental reset is needed 100ms delay prior enabling
link training. So update comment in code to reflect this requirement.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 50ab6d7519ae..19b9b79226e5 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -259,7 +259,12 @@ static void advk_pcie_issue_perst(struct advk_pcie *pcie)
 	if (!pcie->reset_gpio)
 		return;
 
-	/* PERST does not work for some cards when link training is enabled */
+	/*
+	 * As required by PCI Express spec a delay for at least 100ms after
+	 * de-asserting PERST# signal is needed before link training is enabled.
+	 * So ensure that link training is disabled prior de-asserting PERST#
+	 * signal to fulfill that PCI Express spec requirement.
+	 */
 	reg = advk_readl(pcie, PCIE_CORE_CTRL0_REG);
 	reg &= ~LINK_TRAINING_EN;
 	advk_writel(pcie, reg, PCIE_CORE_CTRL0_REG);
-- 
2.20.1

