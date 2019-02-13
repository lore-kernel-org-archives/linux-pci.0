Return-Path: <SRS0=kgfr=QU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F76C282C2
	for <linux-pci@archiver.kernel.org>; Wed, 13 Feb 2019 14:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9232222C1
	for <linux-pci@archiver.kernel.org>; Wed, 13 Feb 2019 14:50:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbfBMOuR (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 13 Feb 2019 09:50:17 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55588 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726056AbfBMOuR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Feb 2019 09:50:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 55B9780D;
        Wed, 13 Feb 2019 06:50:17 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D3C23F589;
        Wed, 13 Feb 2019 06:50:16 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     linux-pci@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] MAINTAINERS: Mark PCI Cadence entry as Orphan
Date:   Wed, 13 Feb 2019 14:50:09 +0000
Message-Id: <20190213145009.32220-1-lorenzo.pieralisi@arm.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Current PCI Cadence controller maintainer email address
bounces which does not bode well for its maintainership
status.

Remove the email address from the MAINTAINERS entry and mark
its status as Orphan.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 32d444476a90..6b5f5fe78527 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11581,9 +11581,8 @@ F:	Documentation/devicetree/bindings/pci/pci-armada8k.txt
 F:	drivers/pci/controller/dwc/pcie-armada8k.c
 
 PCI DRIVER FOR CADENCE PCIE IP
-M:	Alan Douglas <adouglas@cadence.com>
 L:	linux-pci@vger.kernel.org
-S:	Maintained
+S:	Orphan
 F:	Documentation/devicetree/bindings/pci/cdns,*.txt
 F:	drivers/pci/controller/pcie-cadence*
 
-- 
2.19.2

