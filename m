Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org,
	timur@codeaurora.org
Subject: [PATCH 2/2] iommu: add warning when sharing groups
Date: Tue, 14 Feb 2017 16:25:22 -0500
Message-Id: <1487107522-8695-2-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1487107522-8695-1-git-send-email-okaya@codeaurora.org>
References: <1487107522-8695-1-git-send-email-okaya@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
 open list <linux-kernel@vger.kernel.org>, Sinan Kaya <okaya@codeaurora.org>,
 alex.williamson@redhat.com, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

The ACS requirement has been obscured in the current code and is only
known by certain individuals who happen to read the code. Print out a
warning with ACS path failure when ACS requirement is not met.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/iommu/iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index dbe7f65..049ee0a 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -811,6 +811,9 @@ struct iommu_group *pci_device_group(struct device *dev)
 	if (IS_ERR(group))
 		return NULL;
 
+	if (pci_is_root_bus(bus))
+		dev_warn_once(&pdev->dev, "using shared group due to ACS path failure\n");
+
 	return group;
 }
 
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
