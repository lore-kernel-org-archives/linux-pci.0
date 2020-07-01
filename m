Return-Path: <SRS0=AC+G=AM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A6BC433E1
	for <linux-pci@archiver.kernel.org>; Wed,  1 Jul 2020 21:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D58DD20870
	for <linux-pci@archiver.kernel.org>; Wed,  1 Jul 2020 21:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MWYnl2OJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgGAVXA (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 1 Jul 2020 17:23:00 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:43152 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727076AbgGAVWJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Jul 2020 17:22:09 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.242.48])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id AAC8F30C0D1;
        Wed,  1 Jul 2020 14:22:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com AAC8F30C0D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1593638528;
        bh=3OXvA8PCBEsIpA3nCB4c0nzrfCkD8JiWghv65L3ox8A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MWYnl2OJWQhzFAECOyWBhMwac9Kea4CnXL8IoUijJT04IR9td8aU2wE5+yh5sku7w
         L5GkDpUyKxntcuWqEj+jLEmiIRyvPN5/e18fHM4hrKkOfSEGSSTwsLg8tKTdHoORAS
         FIzJQQ1lkRCxt3EfWgdgEcIGS+ws6kQi2MFYN268=
Received: from stbsrv-and-01.and.broadcom.net (stbsrv-and-01.and.broadcom.net [10.28.16.211])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id B04BE14008B;
        Wed,  1 Jul 2020 14:22:06 -0700 (PDT)
From:   Jim Quinlan <james.quinlan@broadcom.com>
To:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com
Cc:     Jim Quinlan <james.quinlan@broadcom.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 01/12] PCI: brcmstb: PCIE_BRCMSTB depends on ARCH_BRCMSTB
Date:   Wed,  1 Jul 2020 17:21:31 -0400
Message-Id: <20200701212155.37830-2-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200701212155.37830-1-james.quinlan@broadcom.com>
References: <20200701212155.37830-1-james.quinlan@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Jim Quinlan <jquinlan@broadcom.com>

Have PCIE_BRCMSTB depend on ARCH_BRCMSTB.  Also set the default value to
ARCH_BRCMSTB.

Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index adddf21fa381..c165328d5fbb 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -262,9 +262,10 @@ config VMD
 
 config PCIE_BRCMSTB
 	tristate "Broadcom Brcmstb PCIe host controller"
-	depends on ARCH_BCM2835 || COMPILE_TEST
+	depends on ARCH_BRCMSTB || ARCH_BCM2835 || COMPILE_TEST
 	depends on OF
 	depends on PCI_MSI_IRQ_DOMAIN
+	default ARCH_BRCMSTB
 	help
 	  Say Y here to enable PCIe host controller support for
 	  Broadcom STB based SoCs, like the Raspberry Pi 4.
-- 
2.17.1

