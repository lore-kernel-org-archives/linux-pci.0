Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org,
	timur@codeaurora.org
Subject: [PATCH V3 06/29] edd: deprecate pci_get_bus_and_slot()
Date: Mon, 27 Nov 2017 11:57:43 -0500
Message-Id: <1511801886-6753-7-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1511801886-6753-1-git-send-email-okaya@codeaurora.org>
References: <1511801886-6753-1-git-send-email-okaya@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Sinan Kaya <okaya@codeaurora.org>, linux-arm-msm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, open list <linux-kernel@vger.kernel.org>,
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

Domain number is not available in struct edd_info. Hard-coding the domain
number as 0.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/firmware/edd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/edd.c b/drivers/firmware/edd.c
index e229576..60a8f13 100644
--- a/drivers/firmware/edd.c
+++ b/drivers/firmware/edd.c
@@ -669,10 +669,10 @@ static void edd_release(struct kobject * kobj)
 	struct edd_info *info = edd_dev_get_info(edev);
 
 	if (edd_dev_is_type(edev, "PCI") || edd_dev_is_type(edev, "XPRS")) {
-		return pci_get_bus_and_slot(info->params.interface_path.pci.bus,
-				     PCI_DEVFN(info->params.interface_path.pci.slot,
-					       info->params.interface_path.pci.
-					       function));
+		return pci_get_domain_bus_and_slot(0,
+				info->params.interface_path.pci.bus,
+				PCI_DEVFN(info->params.interface_path.pci.slot,
+				info->params.interface_path.pci.function));
 	}
 	return NULL;
 }
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
