Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 8/8] PCI: Enable PCI_DOMAINS along with generic PCI host
 controller
Date: Tue, 15 May 2018 07:58:16 +0200
Message-Id: <f46a0a3d87de60fec7bca1348464fbe3eb418f70.1526363896.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1526363896.git.jan.kiszka@siemens.com>
References: <cover.1526363896.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1526363896.git.jan.kiszka@siemens.com>
References: <cover.1526363896.git.jan.kiszka@siemens.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

This controller is often instantiated by hypervisors, and they may add
multiple of them or add them in addition to a physical host controller
like the Jailhouse hypervisor is doing. Therefore allow for multiple
domains so that we can handle them all.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/pci/host/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index 0d0177ce436c..3d25b35bb5ab 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -68,6 +68,7 @@ config PCI_HOST_GENERIC
 	depends on (ARM || ARM64) && OF
 	select PCI_HOST_COMMON
 	select IRQ_DOMAIN
+	select PCI_DOMAINS
 	help
 	  Say Y here if you want to support a simple generic PCI host
 	  controller, such as the one emulated by kvmtool.
-- 
2.13.6


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
