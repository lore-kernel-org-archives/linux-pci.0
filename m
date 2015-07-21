Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:35003 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757247AbbGUAOZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 20 Jul 2015 20:14:25 -0400
Received: by iecri3 with SMTP id ri3so34685455iec.2
        for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2015 17:14:25 -0700 (PDT)
Subject: [PATCH v2 04/11] PCI: Reduce size of ATS structure elements
To: linux-pci@vger.kernel.org, Joerg Roedel <jroedel@suse.de>,
	David Woodhouse <dwmw2@infradead.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: iommu@lists.linux-foundation.org,
	Gregor Dick <gdick@solarflare.com>
Date: Mon, 20 Jul 2015 19:14:21 -0500
Message-ID: <20150721001421.28145.58270.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150721001243.28145.81610.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150721001243.28145.81610.stgit@bhelgaas-glaptop2.roam.corp.google.com>
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

