Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:35457 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752605AbbGQVcL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 17 Jul 2015 17:32:11 -0400
Received: by oihq81 with SMTP id q81so78523974oih.2
        for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2015 14:32:11 -0700 (PDT)
Subject: [PATCH 3/8] PCI: Reduce size of ATS structure elements
To: linux-pci@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Gregor Dick <gdick@solarflare.com>
Date: Fri, 17 Jul 2015 16:32:08 -0500
Message-ID: <20150717213208.18379.24197.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150717212759.18379.44858.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150717212759.18379.44858.stgit@bhelgaas-glaptop2.roam.corp.google.com>
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
---
 include/linux/pci.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index ba4a23b..1997853 100644
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
 #endif
 	phys_addr_t rom; /* Physical address of ROM if it's not from the BAR */
 	size_t romlen; /* Length of ROM if it's not from the BAR */

