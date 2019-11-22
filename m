Return-Path: <SRS0=vAAV=ZO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E1CFC432C0
	for <linux-pci@archiver.kernel.org>; Fri, 22 Nov 2019 16:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 501042071F
	for <linux-pci@archiver.kernel.org>; Fri, 22 Nov 2019 16:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574439916;
	bh=Mwvobb8jj+Y/YJ9eBDoQh1X1BfQrrJKtJEyY7F6v5as=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Rn1BoV6BjGEOdiKtkWYQkWPqcSEWHz3zjYvWNyrqEicNZ1sD7TO0iVcT3QIF6nvSg
	 f550BIxFsMC7cPvB93CeLPtuTw2QrYEzfyXzHIGX1eoyv8NgZeypbvKSOGQrFWR1sl
	 vT54qmZJVYVeyKFPGkWNbcVpIPsCp/dCIvyX4zsI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfKVQZP (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 22 Nov 2019 11:25:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:48888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726638AbfKVQZP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 Nov 2019 11:25:15 -0500
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82AE520714;
        Fri, 22 Nov 2019 16:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574439915;
        bh=Mwvobb8jj+Y/YJ9eBDoQh1X1BfQrrJKtJEyY7F6v5as=;
        h=From:To:Cc:Subject:Date:From;
        b=0lNQ3/h4m7uOMkuWf5PXNrQNHccixXgpaMIugpxVghp/eObUEe4ADZYIBaEIUT1mi
         RG6xYGPBDa+RPcO5wa3D7lsSlWkWvW9Ao0J1on8qEwrKM6Mq2sVOxt6fw80pAr71uJ
         XsS9a/mbDP/ki5cTqyIvkeOByELOrLcvtem28MYU=
From:   Keith Busch <kbusch@kernel.org>
To:     linux-pci@vger.kernel.org,
        Jonathan Derrick <jonathan.derrick@intel.com>
Cc:     Keith Busch <kbusch@kernel.org>
Subject: [PATCH] MAINTAINERS: Remove Keith from VMD maintainer
Date:   Sat, 23 Nov 2019 01:25:01 +0900
Message-Id: <20191122162501.27018-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I no longer work in this capacity on the VMD driver.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e4f170d8bc29..064333607feb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12453,7 +12453,6 @@ F:	Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
 F:	drivers/pci/controller/dwc/*imx6*
 
 PCI DRIVER FOR INTEL VOLUME MANAGEMENT DEVICE (VMD)
-M:	Keith Busch <keith.busch@intel.com>
 M:	Jonathan Derrick <jonathan.derrick@intel.com>
 L:	linux-pci@vger.kernel.org
 S:	Supported
-- 
2.21.0

