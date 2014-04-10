Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 10 Apr 2014 17:17:04 -0500
From: scameron@beardog.cce.hp.com
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Davidlohr Bueso <davidlohr@hp.com>,
	Baoquan He <bhe@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-scsi <linux-scsi@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	"open list:INTEL IOMMU (VT-d)" <iommu@lists.linux-foundation.org>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	scameron@beardog.cce.hp.com
Subject: [PATCH] hpsa: fix uninitialized trans_support in hpsa_put_ctlr_into_performant_mode()
Message-ID: <20140410221704.GA22465@beardog.cce.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Without this, you'll see a null pointer dereference in
hpsa_enter_performant_mode().

Signed-off-by: Stephen M. Cameron <scameron@beardog.cce.hp.com>
---
 drivers/scsi/hpsa.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index 8cf4a0c..ef4dfdd 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -7463,6 +7463,10 @@ static void hpsa_put_ctlr_into_performant_mode(struct ctlr_info *h)
 	if (hpsa_simple_mode)
 		return;
 
+	trans_support = readl(&(h->cfgtable->TransportSupport));
+	if (!(trans_support & PERFORMANT_MODE))
+		return;
+
 	/* Check for I/O accelerator mode support */
 	if (trans_support & CFGTBL_Trans_io_accel1) {
 		transMethod |= CFGTBL_Trans_io_accel1 |
-- 
1.7.1

