Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1on0088.outbound.protection.outlook.com ([157.56.110.88]:7758
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750995AbbJNC6N (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 13 Oct 2015 22:58:13 -0400
From: Ley Foon Tan <lftan@altera.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Russell King <linux@arm.linux.org.uk>,
	Marc Zyngier <marc.zyngier@arm.com>
CC: Arnd Bergmann <arnd@arndb.de>,
	Dinh Nguyen <dinguyen@opensource.altera.com>,
	<linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Ley Foon Tan <lftan@altera.com>, <lftan.linux@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	"Kumar Gala" <galak@codeaurora.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH v9 1/6] arm: add msi.h to Kbuild
Date: Wed, 14 Oct 2015 10:41:27 +0800
Message-ID: <1444790492-4051-2-git-send-email-lftan@altera.com>
In-Reply-To: <1444790492-4051-1-git-send-email-lftan@altera.com>
References: <1444790492-4051-1-git-send-email-lftan@altera.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Include asm-generic/msi.h to support CONFIG_GENERIC_MSI_IRQ_DOMAIN.
This to fix compilation error:
"include/linux/msi.h:123:21: fatal error: asm/msi.h:
No such file or directory"

Signed-off-by: Ley Foon Tan <lftan@altera.com>
---
 arch/arm/include/asm/Kbuild | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/include/asm/Kbuild b/arch/arm/include/asm/Kbuild
index be648eb..bd42530 100644
--- a/arch/arm/include/asm/Kbuild
+++ b/arch/arm/include/asm/Kbuild
@@ -14,6 +14,7 @@ generic-y += local.h
 generic-y += local64.h
 generic-y += mm-arch-hooks.h
 generic-y += msgbuf.h
+generic-y += msi.h
 generic-y += param.h
 generic-y += parport.h
 generic-y += poll.h
-- 
1.8.2.1

