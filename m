Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org,
	timur@codeaurora.org
Subject: [PATCH V4 18/26] PCI/syscall: deprecate pci_get_bus_and_slot()
Date: Tue, 19 Dec 2017 00:37:54 -0500
Message-Id: <1513661883-28662-19-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1513661883-28662-1-git-send-email-okaya@codeaurora.org>
References: <1513661883-28662-1-git-send-email-okaya@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Sinan Kaya <okaya@codeaurora.org>, linux-arm-msm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, open list <linux-kernel@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
where a PCI device is present. This restricts the device drivers to be
reused for other domain numbers.

Getting ready to remove pci_get_bus_and_slot() function in favor of
pci_get_domain_bus_and_slot().

Hard-coding the domain value as 0 because the domain information is not
coming from the userspace.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/syscall.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/syscall.c b/drivers/pci/syscall.c
index 83efa00..e725f99 100644
--- a/drivers/pci/syscall.c
+++ b/drivers/pci/syscall.c
@@ -28,7 +28,7 @@
 		return -EPERM;
 
 	err = -ENODEV;
-	dev = pci_get_bus_and_slot(bus, dfn);
+	dev = pci_get_domain_bus_and_slot(0, bus, dfn);
 	if (!dev)
 		goto error;
 
@@ -96,7 +96,7 @@
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-	dev = pci_get_bus_and_slot(bus, dfn);
+	dev = pci_get_domain_bus_and_slot(0, bus, dfn);
 	if (!dev)
 		return -ENODEV;
 
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
