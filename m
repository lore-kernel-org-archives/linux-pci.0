Return-Path: <SRS0=x16U=4C=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C1AC2BA83
	for <linux-pci@archiver.kernel.org>; Fri, 14 Feb 2020 17:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF1A72187F
	for <linux-pci@archiver.kernel.org>; Fri, 14 Feb 2020 17:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581702287;
	bh=cdBuiAVRy0pOtOROH6mccpHZwIddggqEXbohsQkh8WM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eomuU46vjHYt3RzVIfeFS/fqwB+xXpLVmFHwHSh8i0o1gOkjiRmdMJe4CuXcZ4HPe
	 Bzk6WRX7nJuHs9T9Be6gsm+C2bSMsXUB3w8jJOJBWEMQG1RUV1wvKl6HEBO5uN1wsI
	 zsJ4SeRhK3krP6sTgCZTrp40CkCGzkhMxXes4nG0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389520AbgBNQDB (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:03:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:49790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389076AbgBNQDA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Feb 2020 11:03:00 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 272642082F;
        Fri, 14 Feb 2020 16:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696179;
        bh=cdBuiAVRy0pOtOROH6mccpHZwIddggqEXbohsQkh8WM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AYHf22tJr/xf2eDzhnO0WaBjpnW17bQa3hjG9B70FXT4/lAZQpEuvUECO2zAcTdWT
         +J7BYF1OLJwXAfnvGU2ZKXALWV9s3KIa2dr4hevsQ1mV+XiG5Z03X2T0WOQ4Dpm636
         kI9YfnyY+RPk1S0unEsx7Wk917MRog4l595GTol0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Doug Meyer <dmeyer@gigaio.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <sashal@kernel.org>, linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 051/459] PCI/switchtec: Fix vep_vector_number ioread width
Date:   Fri, 14 Feb 2020 10:55:01 -0500
Message-Id: <20200214160149.11681-51-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214160149.11681-1-sashal@kernel.org>
References: <20200214160149.11681-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Logan Gunthorpe <logang@deltatee.com>

[ Upstream commit 9375646b4cf03aee81bc6c305aa18cc80b682796 ]

vep_vector_number is actually a 16 bit register which should be read with
ioread16() instead of ioread32().

Fixes: 080b47def5e5 ("MicroSemi Switchtec management interface driver")
Link: https://lore.kernel.org/r/20200106190337.2428-3-logang@deltatee.com
Reported-by: Doug Meyer <dmeyer@gigaio.com>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/switch/switchtec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index 465d6afd826e8..efa6abc86995f 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -1276,7 +1276,7 @@ static int switchtec_init_isr(struct switchtec_dev *stdev)
 	if (nvecs < 0)
 		return nvecs;
 
-	event_irq = ioread32(&stdev->mmio_part_cfg->vep_vector_number);
+	event_irq = ioread16(&stdev->mmio_part_cfg->vep_vector_number);
 	if (event_irq < 0 || event_irq >= nvecs)
 		return -EFAULT;
 
-- 
2.20.1

