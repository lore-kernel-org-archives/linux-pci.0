Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH v2 5/5] iommu/exynos: Remove unnecessary "&" from function
 pointers
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-doc@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Joerg Roedel <joro@8bytes.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	linux-kernel@vger.kernel.org,
	James Bottomley <jbottomley@parallels.com>,
	linux-pci@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>
Date: Tue, 06 May 2014 16:48:46 -0600
Message-ID: <20140506224846.17968.21521.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20140506223250.17968.27054.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20140506223250.17968.27054.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Remove the unnecessary "&" from the function pointers in exynos_iommu_ops.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/iommu/exynos-iommu.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 573247097715..7f5ffd737960 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -1011,13 +1011,13 @@ static phys_addr_t exynos_iommu_iova_to_phys(struct iommu_domain *domain,
 }
 
 static struct iommu_ops exynos_iommu_ops = {
-	.domain_init = &exynos_iommu_domain_init,
-	.domain_destroy = &exynos_iommu_domain_destroy,
-	.attach_dev = &exynos_iommu_attach_device,
-	.detach_dev = &exynos_iommu_detach_device,
-	.map = &exynos_iommu_map,
-	.unmap = &exynos_iommu_unmap,
-	.iova_to_phys = &exynos_iommu_iova_to_phys,
+	.domain_init = exynos_iommu_domain_init,
+	.domain_destroy = exynos_iommu_domain_destroy,
+	.attach_dev = exynos_iommu_attach_device,
+	.detach_dev = exynos_iommu_detach_device,
+	.map = exynos_iommu_map,
+	.unmap = exynos_iommu_unmap,
+	.iova_to_phys = exynos_iommu_iova_to_phys,
 	.pgsize_bitmap = SECT_SIZE | LPAGE_SIZE | SPAGE_SIZE,
 };
 

