Return-Path: <SRS0=0+aG=3F=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42A3C33CB6
	for <linux-pci@archiver.kernel.org>; Thu, 16 Jan 2020 16:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA8952081E
	for <linux-pci@archiver.kernel.org>; Thu, 16 Jan 2020 16:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579193185;
	bh=BJzPVDELKmAeSl2nUn/TE5Mx45SNrNP52CsMOLfrdvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gzlRMfiVJaHdRvxucst4RGWCydVetJJMBydrU+qVPWXLQjEOEXOREkzBNiMzUCYwY
	 sNvd5mGMLZ+qtpGSxC5Cj04c6DlGVq+aZRbsCgpwQs1y7ap2IlUWZZsHn4QpkwfZxD
	 TirhWxEMWIny5vk+yDTUcQEAvILWkeUYuU4BA+S4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgAPQqX (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:46:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:55524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729417AbgAPQqW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 16 Jan 2020 11:46:22 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6525C20663;
        Thu, 16 Jan 2020 16:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579193181;
        bh=BJzPVDELKmAeSl2nUn/TE5Mx45SNrNP52CsMOLfrdvI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cavs+k8sGvRxb+cKjzBJKciAL1v8pnDxGdhKpZ8xsMEIS5KknHAmnG7fiS20VTFCG
         5riteHvgmww5iW1aWbF5aiF8S0WYGANT2sjBZRDLt4XaffnaFeIhycP8/n+aZkCDCu
         2IVwDC+4jCv8Hr22nqNqFTzPRjQJM8k7F2lI8qqs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Sasha Levin <sashal@kernel.org>, linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 041/205] PCI: Fix missing bridge dma_ranges resource list cleanup
Date:   Thu, 16 Jan 2020 11:40:16 -0500
Message-Id: <20200116164300.6705-41-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116164300.6705-1-sashal@kernel.org>
References: <20200116164300.6705-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Rob Herring <robh@kernel.org>

[ Upstream commit 7608158df3ed87a5c938c4a0b91f5b11101a9be1 ]

Commit e80a91ad302b ("PCI: Add dma_ranges window list") added a
dma_ranges resource list, but failed to correctly free the list when
devm_pci_alloc_host_bridge() is used.

Only the iproc host bridge driver is using the dma_ranges list.

Fixes: e80a91ad302b ("PCI: Add dma_ranges window list")
Link: https://lore.kernel.org/r/20191008012325.25700-1-robh@kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Srinath Mannam <srinath.mannam@broadcom.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/probe.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 64ebe3e5e611..d3033873395d 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -572,6 +572,7 @@ static void devm_pci_release_host_bridge_dev(struct device *dev)
 		bridge->release_fn(bridge);
 
 	pci_free_resource_list(&bridge->windows);
+	pci_free_resource_list(&bridge->dma_ranges);
 }
 
 static void pci_release_host_bridge_dev(struct device *dev)
-- 
2.20.1

