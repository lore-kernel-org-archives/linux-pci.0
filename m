Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Arnd Bergmann <arnd@arndb.de>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 1/4] ARM/PCI: iop13xx: address uninitialized variable warning
Date: Wed, 21 Jun 2017 23:52:59 +0200
Message-Id: <20170621215323.3921382-1-arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

The last rework returned a variable that the compiler cannot prove
to be initialized:

arch/arm/mach-iop13xx/pci.c: In function 'iop13xx_scan_bus':
arch/arm/mach-iop13xx/pci.c:509:17: error: 'ret' may be used uninitialized in this function [-Werror=maybe-uninitialized]

In the switch statement that sets the return value, this adds
a default returning an error.

Fixes: ace27646da8e ("ARM/PCI: Convert PCI scan API to pci_scan_root_bus_bridge()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-iop13xx/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-iop13xx/pci.c b/arch/arm/mach-iop13xx/pci.c
index b97879bfb81a..3c51a9bb9b49 100644
--- a/arch/arm/mach-iop13xx/pci.c
+++ b/arch/arm/mach-iop13xx/pci.c
@@ -553,6 +553,8 @@ int iop13xx_scan_bus(int nr, struct pci_host_bridge *bridge)
 		if (!ret)
 			pci_bus_atue = bridge->bus;
 		break;
+	default:
+		ret = -EINVAL;
 	}
 
 	return ret;
-- 
2.9.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
