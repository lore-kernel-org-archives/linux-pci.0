Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:47576 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933942AbaEGQIm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 7 May 2014 12:08:42 -0400
From: Will Deacon <will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: arnd@arndb.de, linux-pci@vger.kernel.org, bhelgaas@google.com,
	jgunthorpe@obsidianresearch.com, sthokal@xilinx.com,
	Will Deacon <will.deacon@arm.com>
Subject: [PATCH v6 1/3] ARM: kconfig: allow PCI support to be selected with ARCH_MULTIPLATFORM
Date: Wed,  7 May 2014 17:07:17 +0100
Message-Id: <1399478839-3564-2-git-send-email-will.deacon@arm.com>
In-Reply-To: <1399478839-3564-1-git-send-email-will.deacon@arm.com>
References: <1399478839-3564-1-git-send-email-will.deacon@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When targetting ARCH_MULTIPLATFORM, we may include support for SoCs with
PCI-capable devices (e.g. mach-virt with virtio-pci).

This patch allows PCI support to be selected for these SoCs by selecting
CONFIG_MIGHT_HAVE_PCI when CONFIG_ARCH_MULTIPLATFORM=y.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index db3c5414223e..860bea828ac4 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -314,6 +314,7 @@ config ARCH_MULTIPLATFORM
 	select CLKSRC_OF
 	select COMMON_CLK
 	select GENERIC_CLOCKEVENTS
+	select MIGHT_HAVE_PCI
 	select MULTI_IRQ_HANDLER
 	select SPARSE_IRQ
 	select USE_OF
-- 
1.9.2

