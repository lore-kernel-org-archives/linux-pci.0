Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: iommu@lists.linux-foundation.org
Subject: [RFC PATCH v2 01/15] drivers: acpi: iort: fix struct pci_dev compiler
 warnings
Date: Tue,  7 Jun 2016 14:30:56 +0100
Message-Id: <1465306270-27076-2-git-send-email-lorenzo.pieralisi@arm.com>
In-Reply-To: <1465306270-27076-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1465306270-27076-1-git-send-email-lorenzo.pieralisi@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Marc Zyngier <marc.zyngier@arm.com>, Tomasz Nowicki <tn@semihalf.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 Sinan Kaya <okaya@codeaurora.org>, linux-acpi@vger.kernel.org,
 Hanjun Guo <hanjun.guo@linaro.org>, Jon Masters <jcm@redhat.com>,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

When the kernel is configured with no IORT support the compilation
issues the following warnings:

In file included from drivers/irqchip/irq-gic-v3-its-pci-msi.c:19:0:
include/linux/iort.h:28:33: warning: 'struct pci_dev' declared inside
parameter list
 u32 iort_pci_get_msi_rid(struct pci_dev *pdev, u32 req_id);
                                 ^
include/linux/iort.h:28:33: warning: its scope is only this definition
or declaration, which is probably not what you want
include/linux/iort.h:29:50: warning: 'struct pci_dev' declared inside
parameter list
 struct fwnode_handle *iort_pci_get_domain(struct pci_dev *pdev, u32
req_id);

This patch fixes the warnings with a struct pci_dev forward declaration
in the IORT header file.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Tomasz Nowicki <tn@semihalf.com>
---
 include/linux/iort.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/iort.h b/include/linux/iort.h
index 490ff4d..6f2fec3 100644
--- a/include/linux/iort.h
+++ b/include/linux/iort.h
@@ -21,6 +21,7 @@
 
 #include <linux/acpi.h>
 
+struct pci_dev;
 struct fwnode_handle;
 int iort_register_domain_token(int trans_id, struct fwnode_handle *fw_node);
 void iort_deregister_domain_token(int trans_id);
-- 
2.6.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
