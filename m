Return-Path: <SRS0=iXN5=2Z=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD2C9C2D0C2
	for <linux-pci@archiver.kernel.org>; Sat,  4 Jan 2020 15:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89FC32464E
	for <linux-pci@archiver.kernel.org>; Sat,  4 Jan 2020 15:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578151398;
	bh=GFeQ4Ri8+GF3+VI6hu+nKsN9aRFo/bhLlTlTOvAwCUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AbcHuvEFDOZ7W4jP/1EGgvazBCljguX2xburBeURprkVs6cYJxvE1v0s+33xkaAZZ
	 LkgYL6mX7H3BNKxqss4RCWATCxqGB84DaEPip/GaAfK/CRU5EdQNtx4mWrb96G5DDu
	 SbEM7lCr8e0quER3SRnkmzzUhgf5gBAzZBPlekX8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbgADPWz (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 4 Jan 2020 10:22:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:32902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727253AbgADPWz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 4 Jan 2020 10:22:55 -0500
Received: from localhost.localdomain (unknown [194.230.155.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A35424653;
        Sat,  4 Jan 2020 15:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578151374;
        bh=GFeQ4Ri8+GF3+VI6hu+nKsN9aRFo/bhLlTlTOvAwCUM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O2KqfkxzAe9CnfY9psQIo1bcMQp0YPR8sx8io/45shLhV6aoq3Q/ELpTpyn0SaGOB
         oAffrA8+Z4hnON5+1AEuGmPiuhJBBVwYriHdQc54PQxQilsaEIX4BaB6xkefNuDeK2
         UMxoJ4FDxTub9m1H1mPEElsHVnfzP93GPv42hFfQ=
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
Subject: [PATCH v2 16/20] pci: exynos: Rename Exynos to lowercase
Date:   Sat,  4 Jan 2020 16:21:03 +0100
Message-Id: <20200104152107.11407-17-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200104152107.11407-1-krzk@kernel.org>
References: <20200104152107.11407-1-krzk@kernel.org>
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

