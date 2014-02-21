Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 21 Feb 2014 17:58:09 +0100
From: Alexander Gordeev <agordeev@redhat.com>
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-kernel@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>,
	linux-pci@vger.kernel.org
Subject: [PATCH v2] timberdale: Use pci_enable_msix_exact() instead of
 pci_enable_msix()
Message-ID: <20140221165809.GI17353@dhcp-26-207.brq.redhat.com>
References: <1392804931-30671-3-git-send-email-agordeev@redhat.com>
 <20140219114424.GD10504@lee--X1>
 <20140221165606.GH17353@dhcp-26-207.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140221165606.GH17353@dhcp-26-207.brq.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

As result of deprecation of MSI-X/MSI enablement functions
pci_enable_msix() and pci_enable_msi_block() all drivers
using these two interfaces need to be updated to use the
new pci_enable_msi_range()  or pci_enable_msi_exact()
and pci_enable_msix_range() or pci_enable_msix_exact()
interfaces.

Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: linux-pci@vger.kernel.org
---
 drivers/mfd/timberdale.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mfd/timberdale.c b/drivers/mfd/timberdale.c
index 2bc5cfb..6ce36d6 100644
--- a/drivers/mfd/timberdale.c
+++ b/drivers/mfd/timberdale.c
@@ -715,7 +715,7 @@ static int timb_probe(struct pci_dev *dev,
 	for (i = 0; i < TIMBERDALE_NR_IRQS; i++)
 		msix_entries[i].entry = i;
 
-	err = pci_enable_msix(dev, msix_entries, TIMBERDALE_NR_IRQS);
+	err = pci_enable_msix_exact(dev, msix_entries, TIMBERDALE_NR_IRQS);
 	if (err) {
 		dev_err(&dev->dev,
 			"MSI-X init failed: %d, expected entries: %d\n",
-- 
1.7.7.6

-- 
Regards,
Alexander Gordeev
agordeev@redhat.com
