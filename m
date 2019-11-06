Return-Path: <SRS0=bI25=Y6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D198AC43331
	for <linux-pci@archiver.kernel.org>; Wed,  6 Nov 2019 22:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EF00217D7
	for <linux-pci@archiver.kernel.org>; Wed,  6 Nov 2019 22:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573079108;
	bh=NqKgcoRD8Fxe8s22bkEne22XCbz650EvgtZNN84wf1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fLt24rGBVZKGv8Fs09mPdEEAcgr4kgiXVp9XeHaR7DB/yrIF35gIfulDFAJS6KWjR
	 PHApRan8GXGjxmY52jeG+y2Pdt5ac06yO7UqOKA3q21cTmVTpCU777FU+QF9el7htu
	 uHIMlaG5VekUW/ET3wTAgSdbmPSSjMR1pEOEqya4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbfKFWZI (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 6 Nov 2019 17:25:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:42168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726817AbfKFWZI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Nov 2019 17:25:08 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2972A2166E;
        Wed,  6 Nov 2019 22:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573079107;
        bh=NqKgcoRD8Fxe8s22bkEne22XCbz650EvgtZNN84wf1s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t2rPKzYg/B+OV76/WYnG0MRvkziYkHm5CPodrKxpNJgojzdHlV2rbqzbJk1y2IUQe
         8h/ROGJ6THAAe/a0tqtQ9KnaXNodC4Cbrds+mBhcLv+69Z+3t1gxsRXRrdjTeji4dn
         8tQm1/McPwnbpucjLmrSSb/Azwaj/2aJ3KtNFMSU=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 1/5] PCI/PTM: Remove spurious "d" from granularity message
Date:   Wed,  6 Nov 2019 16:24:17 -0600
Message-Id: <20191106222420.10216-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
In-Reply-To: <20191106222420.10216-1-helgaas@kernel.org>
References: <20191106222420.10216-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

The granularity message has an extra "d":

  pci 0000:02:00.0: PTM enabled, 4dns granularity

Remove the "d" so the message is simply "PTM enabled, 4ns granularity".

Fixes: 8b2ec318eece ("PCI: Add PTM clock granularity information")
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jonathan Yong <jonathan.yong@intel.com
---
 drivers/pci/pcie/ptm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
index 98cfa30f3fae..9361f3aa26ab 100644
--- a/drivers/pci/pcie/ptm.c
+++ b/drivers/pci/pcie/ptm.c
@@ -21,7 +21,7 @@ static void pci_ptm_info(struct pci_dev *dev)
 		snprintf(clock_desc, sizeof(clock_desc), ">254ns");
 		break;
 	default:
-		snprintf(clock_desc, sizeof(clock_desc), "%udns",
+		snprintf(clock_desc, sizeof(clock_desc), "%uns",
 			 dev->ptm_granularity);
 		break;
 	}
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

