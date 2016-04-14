Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: iommu@lists.linux-foundation.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Tomasz Nowicki <tn@semihalf.com>,
	Will Deacon <will.deacon@arm.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Jon Masters <jcm@redhat.com>,
	Sinan Kaya <okaya@codeaurora.org>, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH 01/11] drivers: acpi: iort: fix struct pci_dev compiler warnings
Date: Thu, 14 Apr 2016 18:25:33 +0100
Message-Id: <1460654743-7896-2-git-send-email-lorenzo.pieralisi@arm.com>
In-Reply-To: <1460654743-7896-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1460654743-7896-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
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
index 7441941..b15fe1a 100644
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

