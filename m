Return-Path: <SRS0=R25p=2Y=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F82C2D0CE
	for <linux-pci@archiver.kernel.org>; Fri,  3 Jan 2020 17:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4000620866
	for <linux-pci@archiver.kernel.org>; Fri,  3 Jan 2020 17:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578071593;
	bh=GFeQ4Ri8+GF3+VI6hu+nKsN9aRFo/bhLlTlTOvAwCUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BxgWGdIKQ2wpVO5H4Q9i5JOIG6K91D3TVi9A9AR5hFWRgQYPhBtM3LQnoaI9eGjQY
	 ta5SXsjCh+qoXWrrFV7bFkQFHY8IM8AbQCHxUkoV17ndF+OxpjllvnpO3cC0m4s2tY
	 Y9Tx3nilKTZB64KdU8UyrNc02VGp66j7WB3eaXyE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbgACRM6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 3 Jan 2020 12:12:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:48434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728357AbgACRMy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 3 Jan 2020 12:12:54 -0500
Received: from localhost.localdomain (unknown [194.230.155.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EFF320866;
        Fri,  3 Jan 2020 17:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578071574;
        bh=GFeQ4Ri8+GF3+VI6hu+nKsN9aRFo/bhLlTlTOvAwCUM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vSTh4L0R82Cu1vyMMGt+dnxoyvsufDU/7T1VKVPbNIR5Rg3G025nqsYJdtrfLp0n3
         c4YHDqgKimRx/8grqhqNt5u1s1OeJDPA3sn9SqcXWWNv7t44XXqly8vT7EI4QFkJdN
         a/zO7L7xYrTvWAi9QB6ZLCOy/RVPHvgOl1rTgV64=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kukjin Kim <kgene@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 15/19] pci: exynos: Rename Exynos to lowercase
Date:   Fri,  3 Jan 2020 18:11:27 +0100
Message-Id: <20200103171131.9900-16-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200103171131.9900-1-krzk@kernel.org>
References: <20200103171131.9900-1-krzk@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix up inconsistent usage of upper and lowercase letters in "Exynos"
name.

"EXYNOS" is not an abbreviation but a regular trademarked name.
Therefore it should be written with lowercase letters starting with
capital letter.

The lowercase "Exynos" name is promoted by its manufacturer Samsung
Electronics Co., Ltd., in advertisement materials and on website.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/pci/controller/dwc/pci-exynos.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
index 14a6ba4067fb..c5043d951e80 100644
--- a/drivers/pci/controller/dwc/pci-exynos.c
+++ b/drivers/pci/controller/dwc/pci-exynos.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * PCIe host controller driver for Samsung EXYNOS SoCs
+ * PCIe host controller driver for Samsung Exynos SoCs
  *
  * Copyright (C) 2013 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
-- 
2.17.1

