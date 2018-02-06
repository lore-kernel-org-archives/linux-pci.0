Return-Path: <SRS0=8nNQ=FA=gmail.com=ulfalizer@kernel.org>
Return-Path: <SRS0=8nNQ=FA=gmail.com=ulfalizer@kernel.org>
From: Ulf Magnusson <ulfalizer@gmail.com>
To: helgaas@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	tfiga@chromium.org,
	paul.burton@mips.com,
	m.szyprowski@samsung.com,
	egtvedt@samfundet.no,
	linus.walleij@linaro.org,
	vgupta@synopsys.com,
	mgorman@techsingularity.net,
	hch@lst.de,
	mina86@mina86.com,
	robh@kernel.org,
	sboyd@codeaurora.org,
	paulus@ozlabs.org,
	will.deacon@arm.com,
	tony@atomide.com,
	npiggin@gmail.com,
	yamada.masahiro@socionext.com,
	lorenzo.pieralisi@arm.com,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	Ulf Magnusson <ulfalizer@gmail.com>
Subject: [PATCH v2 20/20] x86/PCI: VMD: Fix malformed Kconfig default
Date: Tue,  6 Feb 2018 23:11:06 +0100
Message-Id: <20180206221106.16620-1-ulfalizer@gmail.com>
In-Reply-To: <0180206191126.GB98765@bhelgaas-glaptop.roam.corp.google.com>
References: <0180206191126.GB98765@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

'default N' should be 'default n', though they happen to have the same
effect here, due to undefined symbols (N in this case) evaluating to n
in a tristate sense.

Remove the default instead of changing it. bool and tristate symbols
implicitly default to n.

Discovered with the
https://github.com/ulfalizer/Kconfiglib/blob/master/examples/list_undefined.py
script.

Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
---
Changes in v2:
Make it clear that Kconfig is involved.

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
