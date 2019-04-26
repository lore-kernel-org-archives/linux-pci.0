Return-Path: <SRS0=ROz5=S4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12020C43218
	for <linux-pci@archiver.kernel.org>; Fri, 26 Apr 2019 09:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D693720679
	for <linux-pci@archiver.kernel.org>; Fri, 26 Apr 2019 09:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Hur+nkXI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbfDZJU3 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 26 Apr 2019 05:20:29 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38544 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfDZJU2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Apr 2019 05:20:28 -0400
Received: by mail-ed1-f65.google.com with SMTP id c1so2564883edk.5
        for <linux-pci@vger.kernel.org>; Fri, 26 Apr 2019 02:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=iOChsIoVZwQ6wbP1aoL1H3vmoIYH+SqIfEtaHUVB5Zs=;
        b=Hur+nkXIiAnfpFrFXwZJjM+pTeGDpKeorzUOu1Jsd7GTcRfPpBNCI0YZMecTSj/62N
         UB1pE8i3IalTUWPIbXwTeP/BgEp02Buw+HCEX1kRkSnpZgUW4OgPpFuBLcDoFt7/Vhvm
         RMJXFOPJMvpKLfFTSdYUkktvY2Se8CKpDUffw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iOChsIoVZwQ6wbP1aoL1H3vmoIYH+SqIfEtaHUVB5Zs=;
        b=aAKIt72ErWd+rcbZrhtEHH4uFDBRtip57sCl1mz7MZLxcsOkQk5rgTxwEcOw0wXWXE
         kIcJO7zib5O6DNNZUdDFnoe+x/KnXbwbg1RRFNKGLL8y8plfwgIss1PK8vOiMMI2YPMt
         t+0VhstfmWRPB+xwgEUv8da1H+La1i5IrTvTDviwEjjfygwWmcRckG/lnnoaGmHP8Ysu
         txWh5J9Yv4HoUkikaI6kwgFl3J3EebHcQAw8M7aSWZcchDNsVj5elYG21FMetDjV1xJ0
         cCWduwEe8kccTK+RifdfvF+1+sh5+HnrAsH0jGRVlDp7BFzNw9gzzpBMq+8atAvv9lt2
         J/Jw==
X-Gm-Message-State: APjAAAWjG/Wol0uZ0QRO5CJ8tI9miJqi3pPjgaoh7AyMu7GXhReZzZNe
        2rFQyNVQwbqXOKIMAP9wtwDPzA==
X-Google-Smtp-Source: APXvYqxOH6WsYMbGtuBl3y4UHtVCwaBTSvgCoREz7K0RmoRnvC83oOHpmYaCpuqrDlbQ90Llu6PMqA==
X-Received: by 2002:a17:906:515a:: with SMTP id s26mr3270533ejl.34.1556270424179;
        Fri, 26 Apr 2019 02:20:24 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d59sm2403694edc.34.2019.04.26.02.20.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Apr 2019 02:20:23 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH] PCI: iproc: Enable iProc config read for PAXBv2
Date:   Fri, 26 Apr 2019 14:50:04 +0530
Message-Id: <1556270404-27058-1-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

iProc config read flag has to enable for PAXBv2 instead of PAXB.

Fixes: f78e60a29d4ff ("PCI: iproc: Reject unconfigured physical functions from PAXC")
Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
---
 drivers/pci/controller/pcie-iproc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
index c20fd6b..9d5cbc7 100644
--- a/drivers/pci/controller/pcie-iproc.c
+++ b/drivers/pci/controller/pcie-iproc.c
@@ -1347,7 +1347,6 @@ static int iproc_pcie_rev_init(struct iproc_pcie *pcie)
 		break;
 	case IPROC_PCIE_PAXB:
 		regs = iproc_pcie_reg_paxb;
-		pcie->iproc_cfg_read = true;
 		pcie->has_apb_err_disable = true;
 		if (pcie->need_ob_cfg) {
 			pcie->ob_map = paxb_ob_map;
@@ -1356,6 +1355,7 @@ static int iproc_pcie_rev_init(struct iproc_pcie *pcie)
 		break;
 	case IPROC_PCIE_PAXB_V2:
 		regs = iproc_pcie_reg_paxb_v2;
+		pcie->iproc_cfg_read = true;
 		pcie->has_apb_err_disable = true;
 		if (pcie->need_ob_cfg) {
 			pcie->ob_map = paxb_v2_ob_map;
-- 
2.7.4

