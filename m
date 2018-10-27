Return-Path: <SRS0=ddhW=NH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 053BEC46475
	for <linux-pci@archiver.kernel.org>; Sat, 27 Oct 2018 19:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB4C22085B
	for <linux-pci@archiver.kernel.org>; Sat, 27 Oct 2018 19:06:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB4C22085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728845AbeJ1Dsb (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 27 Oct 2018 23:48:31 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:6204 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728472AbeJ1Dsb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 27 Oct 2018 23:48:31 -0400
X-IronPort-AV: E=Sophos;i="5.54,433,1534802400"; 
   d="scan'208";a="353101584"
Received: from palace.lip6.fr ([132.227.105.202])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/AES128-SHA256; 27 Oct 2018 21:06:34 +0200
From:   Julia Lawall <Julia.Lawall@lip6.fr>
To:     Jianguo Sun <sunjianguo1@huawei.com>
Cc:     kernel-janitors@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: histb: constify dw_pcie_host_ops structure
Date:   Sat, 27 Oct 2018 20:31:19 +0200
Message-Id: <1540665079-27788-1-git-send-email-Julia.Lawall@lip6.fr>
X-Mailer: git-send-email 1.9.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The dw_pcie_host_ops structure is only stored in the ops field
of a pcie_port structure, and this field is const, so make the
dw_pcie_host_ops structure const as well.

Done with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/pci/controller/dwc/pcie-histb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -u -p a/drivers/pci/controller/dwc/pcie-histb.c b/drivers/pci/controller/dwc/pcie-histb.c
--- a/drivers/pci/controller/dwc/pcie-histb.c
+++ b/drivers/pci/controller/dwc/pcie-histb.c
@@ -202,7 +202,7 @@ static int histb_pcie_host_init(struct p
 	return 0;
 }
 
-static struct dw_pcie_host_ops histb_pcie_host_ops = {
+static const struct dw_pcie_host_ops histb_pcie_host_ops = {
 	.rd_own_conf = histb_pcie_rd_own_conf,
 	.wr_own_conf = histb_pcie_wr_own_conf,
 	.host_init = histb_pcie_host_init,

