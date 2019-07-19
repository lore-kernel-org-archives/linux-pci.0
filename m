Return-Path: <SRS0=+Ydv=VQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C3FC76195
	for <linux-pci@archiver.kernel.org>; Fri, 19 Jul 2019 04:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66B0F2077C
	for <linux-pci@archiver.kernel.org>; Fri, 19 Jul 2019 04:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563511171;
	bh=R3UxDjgTbacNgKcJvMdnsgwwpj7qgbnHxLcI0sBnYsw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=18OX4IAy72uns3YxBustZZSTWWMf9igMu5x4G8jCihu2cQuVfOupd48pRCH0xs2cw
	 T5+VYZPRYox7v2mFV3E8GqCQDP2lJ6jxCwP7m4PLERlHkZqaCXVZHlKDcC4TzuheJO
	 UhNeLwFxeLKBPIRXL24uG+jbgH1rEzKrSsbneT7M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfGSD6m (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 18 Jul 2019 23:58:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:58036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728206AbfGSD6j (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Jul 2019 23:58:39 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E03D21851;
        Fri, 19 Jul 2019 03:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563508718;
        bh=R3UxDjgTbacNgKcJvMdnsgwwpj7qgbnHxLcI0sBnYsw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CrOBPF4hHcblIC7sFQ8nOU6D6vcoSc/uKhMk6R8CO5/fG/zSkPpoNgJaOFXb8IUP3
         hg4ysYyoyMXyDm15GpiKvTkfzrJ75x7Ew/Z7P4KjkJPJ7PVFeAM2BuMdhqBCE1+a89
         mfKvcBMTvkErVR7qL+CUV2F8uNrTBslrMscO/Xvk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alan Mikhak <alan.mikhak@sifive.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sasha Levin <sashal@kernel.org>, linux-pci@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH AUTOSEL 5.2 051/171] PCI: endpoint: Allocate enough space for fixed size BAR
Date:   Thu, 18 Jul 2019 23:54:42 -0400
Message-Id: <20190719035643.14300-51-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190719035643.14300-1-sashal@kernel.org>
References: <20190719035643.14300-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Alan Mikhak <alan.mikhak@sifive.com>

[ Upstream commit f16fb16ed16c7f561e9c41c9ae4107c7f6aa553c ]

PCI endpoint test function code should honor the .bar_fixed_size parameter
from underlying endpoint controller drivers or results may be unexpected.

In pci_epf_test_alloc_space(), check if BAR being used for test
register space is a fixed size BAR. If so, allocate the required fixed
size.

Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 27806987e93b..7d41e6684b87 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -434,10 +434,16 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 	int bar;
 	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
 	const struct pci_epc_features *epc_features;
+	size_t test_reg_size;
 
 	epc_features = epf_test->epc_features;
 
-	base = pci_epf_alloc_space(epf, sizeof(struct pci_epf_test_reg),
+	if (epc_features->bar_fixed_size[test_reg_bar])
+		test_reg_size = bar_size[test_reg_bar];
+	else
+		test_reg_size = sizeof(struct pci_epf_test_reg);
+
+	base = pci_epf_alloc_space(epf, test_reg_size,
 				   test_reg_bar, epc_features->align);
 	if (!base) {
 		dev_err(dev, "Failed to allocated register space\n");
-- 
2.20.1

