Return-Path: <SRS0=sVnv=Q2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCFC1C10F00
	for <linux-pci@archiver.kernel.org>; Tue, 19 Feb 2019 17:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9801F2077B
	for <linux-pci@archiver.kernel.org>; Tue, 19 Feb 2019 17:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbfBSRmI (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 19 Feb 2019 12:42:08 -0500
Received: from foss.arm.com ([217.140.101.70]:47992 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbfBSRmI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Feb 2019 12:42:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 221A8A78;
        Tue, 19 Feb 2019 09:42:08 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B0BDC3F720;
        Tue, 19 Feb 2019 09:42:06 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Tom Joseph <tjoseph@cadence.com>
Subject: [PATCH v2] MAINTAINERS: Update PCI Cadence maintainer entry
Date:   Tue, 19 Feb 2019 17:42:01 +0000
Message-Id: <20190219174201.28089-1-lorenzo.pieralisi@arm.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Replace Alan Douglas with Tom Joseph as the current PCI
Cadence host/endpoint controller maintainer.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Tom Joseph <tjoseph@cadence.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 32d444476a90..0403a2869a42 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11581,7 +11581,7 @@ F:	Documentation/devicetree/bindings/pci/pci-armada8k.txt
 F:	drivers/pci/controller/dwc/pcie-armada8k.c
 
 PCI DRIVER FOR CADENCE PCIE IP
-M:	Alan Douglas <adouglas@cadence.com>
+M:	Tom Joseph <tjoseph@cadence.com>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/pci/cdns,*.txt
-- 
2.19.2

