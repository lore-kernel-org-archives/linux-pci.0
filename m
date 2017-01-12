Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
 Joao Pinto <Joao.Pinto@synopsys.com>, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 35/37] MAINTAINERS: add PCI EP maintainer
Date: Thu, 12 Jan 2017 15:56:24 +0530
Message-ID: <1484216786-17292-36-git-send-email-kishon@ti.com>
In-Reply-To: <1484216786-17292-1-git-send-email-kishon@ti.com>
References: <1484216786-17292-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-pci@vger.kernel.org, nsekhar@ti.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@axis.com, kishon@ti.com,
 linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Add maintainer for the newly introduced PCI EP framework.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 MAINTAINERS |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8672f18..021f676 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9407,6 +9407,15 @@ F:	include/linux/pci*
 F:	arch/x86/pci/
 F:	arch/x86/kernel/quirks.c
 
+PCI EP SUBSYSTEM
+M:	Kishon Vijay Abraham I <kishon@ti.com>
+L:	linux-pci@vger.kernel.org
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
+S:	Supported
+F:	drivers/pci/endpoint/
+F:	drivers/misc/pci_endpoint_test.c
+F:	tools/pci/
+
 PCI DRIVER FOR ALTERA PCIE IP
 M:	Ley Foon Tan <lftan@altera.com>
 L:	rfi@lists.rocketboards.org (moderated for non-subscribers)
-- 
1.7.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
