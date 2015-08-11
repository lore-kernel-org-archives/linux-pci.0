Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f173.google.com ([209.85.223.173]:33931 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965045AbbHKPvf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 11 Aug 2015 11:51:35 -0400
Received: by iodb91 with SMTP id b91so146687657iod.1
        for <linux-pci@vger.kernel.org>; Tue, 11 Aug 2015 08:51:34 -0700 (PDT)
Subject: [PATCH v3 04/11] PCI: Reduce size of ATS structure elements
To: linux-pci@vger.kernel.org, Joerg Roedel <jroedel@suse.de>,
	David Woodhouse <dwmw2@infradead.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Gregor Dick <gdick@solarflare.com>,
	iommu@lists.linux-foundation.org, Yinghai Lu <yinghai@kernel.org>
Date: Tue, 11 Aug 2015 10:51:30 -0500
Message-ID: <20150811155130.21078.57080.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150811154525.21078.85310.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150811154525.21078.85310.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The extended capabilities list is linked with 12-bit pointers, and the ATS
Smallest Translation Unit and Invalidate Queue Depth fields are both 5
bits.

Use u16 and u8 to hold the extended capability address and the stu and qdep
values.  No functional change.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Joerg Roedel <jroedel@suse.de>
---
 include/linux/pci.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 8bc16b5..238b77e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -376,9 +376,9 @@ struct pci_dev {
 		struct pci_sriov *sriov;	/* SR-IOV capability related */
 		struct pci_dev *physfn;	/* the PF this VF is associated with */
 	};
-	int		ats_cap;	/* ATS Capability offset */
-	int		ats_stu;	/* ATS Smallest Translation Unit */
-	int		ats_qdep;	/* ATS Invalidate Queue Depth */
+	u16		ats_cap;	/* ATS Capability offset */
+	u8		ats_stu;	/* ATS Smallest Translation Unit */
+	u8		ats_qdep;	/* ATS Invalidate Queue Depth */
 	atomic_t	ats_ref_cnt;	/* number of VFs with ATS enabled */
 #endif
 	phys_addr_t rom; /* Physical address of ROM if it's not from the BAR */

