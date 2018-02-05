Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:39377 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752265AbeBEBZm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 4 Feb 2018 20:25:42 -0500
From: Ulf Magnusson <ulfalizer@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org, tfiga@chromium.org,
        paul.burton@mips.com, m.szyprowski@samsung.com,
        egtvedt@samfundet.no, linus.walleij@linaro.org,
        vgupta@synopsys.com, mgorman@techsingularity.net, hch@lst.de,
        mina86@mina86.com, robh@kernel.org, sboyd@codeaurora.org,
        paulus@ozlabs.org, will.deacon@arm.com, tony@atomide.com,
        npiggin@gmail.com, yamada.masahiro@socionext.com,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: [PATCH 20/20] x86/PCI: VMD: Fix malformed default
Date: Mon,  5 Feb 2018 02:21:32 +0100
Message-Id: <20180205012146.23981-21-ulfalizer@gmail.com>
In-Reply-To: <20180205012146.23981-1-ulfalizer@gmail.com>
References: <20180205012146.23981-1-ulfalizer@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

'default N' should be 'default n', though they happen to have the same
effect here, due to undefined symbols (N in this case) evaluating to n
in a tristate sense.

Remove the default from VMD instead of changing it. bool and tristate
symbols implicitly default to n.

Discovered with the
https://github.com/ulfalizer/Kconfiglib/blob/master/examples/list_undefined.py
script.

Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
---
 drivers/pci/host/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index a4ed7484d127..dc8a2a175f19 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -215,7 +215,6 @@ config PCIE_TANGO_SMP8759
 config VMD
 	depends on PCI_MSI && X86_64 && SRCU
 	tristate "Intel Volume Management Device Driver"
-	default N
 	---help---
 	  Adds support for the Intel Volume Management Device (VMD). VMD is a
 	  secondary PCI host bridge that allows PCI Express root ports,
-- 
2.14.1
