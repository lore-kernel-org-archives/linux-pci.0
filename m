Return-Path: <SRS0=/dOL=PT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 139D6C43613
	for <linux-pci@archiver.kernel.org>; Fri, 11 Jan 2019 15:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCAE72183F
	for <linux-pci@archiver.kernel.org>; Fri, 11 Jan 2019 15:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="VVE75gvy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731890AbfAKPnz (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 11 Jan 2019 10:43:55 -0500
Received: from mta-01.yadro.com ([89.207.88.251]:40082 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728632AbfAKPnz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 11 Jan 2019 10:43:55 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id A2CDC41998
        for <linux-pci@vger.kernel.org>; Fri, 11 Jan 2019 15:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1547221041; x=1549035442; bh=/YNOeYvN//0sDrgfxAmyZR3l8GZSRW78skv
        94n8Swe0=; b=VVE75gvyH6k3rTGTawFhQihD2AxMfWzCqv91yYEsZbzYF/pjHU4
        rol9qr04tLIS5RHVboxKm9HzpAgNMuuTutxwhnF06NlJcKCiCVThGrstrv1K/DBP
        cpYvo6X7s5JIsFShSDCA5v17rpReUyxIhI0ENqvwPlvYq/XVbAL0URHU=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id AGBiW2CBahRR for <linux-pci@vger.kernel.org>;
        Fri, 11 Jan 2019 18:37:21 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id C0ECF4196E
        for <linux-pci@vger.kernel.org>; Fri, 11 Jan 2019 18:37:21 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.60) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Fri, 11
 Jan 2019 18:37:21 +0300
From:   Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>
CC:     <linux@yadro.com>,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH RFC v2 01/21] PCI: Fix writing invalid BARs during pci_restore_state()
Date:   Fri, 11 Jan 2019 18:36:47 +0300
Message-ID: <20190111153707.10140-2-s.miroshnichenko@yadro.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111153707.10140-1-s.miroshnichenko@yadro.com>
References: <20190111153707.10140-1-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.15.60]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If BAR movement has happened (due to PCIe hotplug) after pci_save_state(),
the saved addresses will become outdated. Restore them the most recently
calculated values, not the ones stored in an parbitrary moment.

Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index c9d8e3c837de..5580ddc5b9b1 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1337,7 +1337,7 @@ static void pci_restore_config_space(struct pci_dev *pdev)
 	if (pdev->hdr_type == PCI_HEADER_TYPE_NORMAL) {
 		pci_restore_config_space_range(pdev, 10, 15, 0, false);
 		/* Restore BARs before the command register. */
-		pci_restore_config_space_range(pdev, 4, 9, 10, false);
+		pci_restore_bars(pdev);
 		pci_restore_config_space_range(pdev, 0, 3, 0, false);
 	} else if (pdev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
 		pci_restore_config_space_range(pdev, 12, 15, 0, false);
-- 
2.20.1

