Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A99CBC433B4
	for <linux-pci@archiver.kernel.org>; Thu,  6 May 2021 15:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C0FC610C8
	for <linux-pci@archiver.kernel.org>; Thu,  6 May 2021 15:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235757AbhEFPeK (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 6 May 2021 11:34:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:45974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235569AbhEFPdt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 May 2021 11:33:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E5B4C61492;
        Thu,  6 May 2021 15:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620315171;
        bh=aFz0PFRzNP3wjEbTBW+rHPZjGLu0vSW7VtIiwAyNHNc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OxYRibS40Y+CZI4MoUELH9lWQ8j2mwyO/xAYa5r57x9HG7QjwBnWqqgF571Cj2Qh3
         pO73bc6cDOzKIfndLOMgGZLgyXOHNDDGbsh6qod1XC1kgAouWp+b6kr4Qz52QMXO+o
         EOWfiBlZriNhtdAHZYOEMyCZdrP0nk0SHT3cCskKdv7xSeEUOy13iMNND+vJQN3P3X
         xrEzr93HeKB/krSkh3etvcp/xvgyhf8S+DmRHDhsenNWMsQ5pJoM4uYYMc4OEKE/No
         RcNqBH11zYEfdzz0dqTSatu4eBcLTS0RFw2Zdoc88+LulQSS0LFXEXY6GDY415sxei
         UAzv7yVZ9CfPA==
Received: by pali.im (Postfix)
        id 9F939732; Thu,  6 May 2021 17:32:50 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Russell King <rmk+kernel@armlinux.org.uk>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Remi Pommarel <repk@triplefau.lt>, Xogium <contact@xogium.me>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 22/42] PCI: aardvark: Enable MSI-X support
Date:   Thu,  6 May 2021 17:31:33 +0200
Message-Id: <20210506153153.30454-23-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210506153153.30454-1-pali@kernel.org>
References: <20210506153153.30454-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

According to PCI 3.0 specification, sending both MSI and MSI-X interrupts
is done by DWORD memory write operation to doorbell message address. The
write operation for MSI has zero upper 16 bits and the MSI interrupt number
in the lower 16 bits. The write operation for MSI-X contains a 32-bit value
from MSI-X table.

This means that when MSI-X uses only a 16-bit value, the MSI-X message can
be captured by aardvark MSI doorbell address processing. Therefore aardvark
HW should also support MSI-X interrupts, despite Armada 3700 Functional
Specification not mentioning anything about how to configure PCIe for MSI-X
interrupts. (Note that the specification says that MSI-X is supported, it
just does not say explicitly how to enable it.)

Since pci-aardvark.c driver now supports receiving MSI interrupt with any
16-bit number, enable also MSI-X support.

Testing proved that kernel can correctly receive MSI-X interrupts from PCIe
cards which supports both MSI and MSI-X interrupts.

Signed-off-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Marek Behún <kabel@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 376f0666becc..8a5133226e41 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -1082,7 +1082,7 @@ static int advk_pcie_init_msi_irq_domain(struct advk_pcie *pcie)
 
 	msi_di = &pcie->msi_domain_info;
 	msi_di->flags = MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		MSI_FLAG_MULTI_PCI_MSI;
+			MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX;
 	msi_di->chip = msi_ic;
 
 	/*
-- 
2.20.1

