Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Arnd Bergmann <arnd@arndb.de>
To: Rob Herring <robh@kernel.org>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PCI: versatile: include pci.h
Date: Mon, 28 May 2018 17:48:39 +0200
Message-Id: <20180528154850.2647019-1-arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Arnd Bergmann <arnd@arndb.de>, Jingoo Han <jingoohan1@gmail.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, linux-kernel@vger.kernel.org,
 Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Two patches for PCI host drivers clashed recently, leading to a broken
build for versatile-pci:

drivers/pci/host/pci-versatile.c: In function 'versatile_pci_parse_request_of_pci_ranges':
drivers/pci/host/pci-versatile.c:70:8: error: implicit declaration of function 'devm_of_pci_get_host_bridge_resources'; did you mean 'pci_get_host_bridge_device'? [-Werror=implicit-function-declaration]

This adds the missing header inclusion that became necessary now.

Fixes: 9e2aee80c78d ("PCI: Move private DT related functions into private header")
Fixes: 64720fd1f630 ("PCI: Rework of_pci_get_host_bridge_resources() to devm_of_pci_get_host_bridge_resources()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pci/host/pci-versatile.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/host/pci-versatile.c b/drivers/pci/host/pci-versatile.c
index ff2cd12b3978..994f32061b32 100644
--- a/drivers/pci/host/pci-versatile.c
+++ b/drivers/pci/host/pci-versatile.c
@@ -15,6 +15,8 @@
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 
+#include "../pci.h"
+
 static void __iomem *versatile_pci_base;
 static void __iomem *versatile_cfg_base[2];
 
-- 
2.9.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
