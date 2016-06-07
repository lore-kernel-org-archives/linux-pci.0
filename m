Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: iommu@lists.linux-foundation.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Tomasz Nowicki <tn@semihalf.com>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Jon Masters <jcm@redhat.com>,
	Sinan Kaya <okaya@codeaurora.org>, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH v2 03/15] arm64: mm: change IOMMU notifier action to attach DMA ops
Date: Tue,  7 Jun 2016 14:30:58 +0100
Message-Id: <1465306270-27076-4-git-send-email-lorenzo.pieralisi@arm.com>
In-Reply-To: <1465306270-27076-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1465306270-27076-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Current bus notifier in ARM64 (__iommu_attach_notifier)
attempts to attach dma_ops to a device on BUS_NOTIFY_ADD_DEVICE
action notification.

This causes issues on ACPI based systems, where PCI devices
can be added before the IOMMUs the devices are attached to
had a chance to be probed, causing failures on attempts to
attach dma_ops in that the domain for the respective IOMMU
may not be set-up yet by the time the bus notifier is run.

Devices dma_ops do not require to be set-up till the matching
device drivers are probed. This means that instead of running
the notifier attaching dma_ops to devices (__iommu_attach_notifier)
on BUS_NOTIFY_ADD_DEVICE action, it can be run just before the
device driver is bound to the device in question (on action
BUS_NOTIFY_BIND_DRIVER) so that it is certain that its IOMMU
group and domain are set-up accordingly at the time the
notifier is triggered.

This patch changes the notifier action upon which dma_ops
are attached to devices and defer it to driver binding time,
so that IOMMU devices have a chance to be probed and to register
their bus notifiers before the dma_ops attach sequence for a
device is actually carried out.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
---
 arch/arm64/mm/dma-mapping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index c566ec8..79b0882 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -848,7 +848,7 @@ static int __iommu_attach_notifier(struct notifier_block *nb,
 {
 	struct iommu_dma_notifier_data *master, *tmp;
 
-	if (action != BUS_NOTIFY_ADD_DEVICE)
+	if (action != BUS_NOTIFY_BIND_DRIVER)
 		return 0;
 
 	mutex_lock(&iommu_dma_notifier_lock);
-- 
2.6.4
