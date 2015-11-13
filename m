Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:64520 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932933AbbKMRRr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 13 Nov 2015 12:17:47 -0500
From: Keith Busch <keith.busch@intel.com>
To: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
	linux-pci@vger.kernel.org
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bryan Veal <bryan.e.veal@intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Martin Mares <mj@ucw.cz>,
	Jon Derrick <jonathan.derrick@intel.com>,
	Keith Busch <keith.busch@intel.com>
Subject: [PATCHv5 6/6] pciutils: Allow 32-bit domains
Date: Fri, 13 Nov 2015 10:17:37 -0700
Message-Id: <1447435057-5212-7-git-send-email-keith.busch@intel.com>
In-Reply-To: <1447435057-5212-1-git-send-email-keith.busch@intel.com>
References: <1447435057-5212-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI-e segments will continue to use the lower 16 bits as required by
ACPI. Special domains may use the full 32-bits.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 lib/filter.c |    2 +-
 lib/pci.h    |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/filter.c b/lib/filter.c
index d4254a0..075dc2f 100644
--- a/lib/filter.c
+++ b/lib/filter.c
@@ -45,7 +45,7 @@ pci_filter_parse_slot_v33(struct pci_filter *f, char *str)
 	  if (str[0] && strcmp(str, "*"))
 	    {
 	      long int x = strtol(str, &e, 16);
-	      if ((e && *e) || (x < 0 || x > 0xffff))
+	      if ((e && *e) || (x < 0))
 		return "Invalid domain number";
 	      f->domain = x;
 	    }
diff --git a/lib/pci.h b/lib/pci.h
index 10ba831..7e42765 100644
--- a/lib/pci.h
+++ b/lib/pci.h
@@ -119,7 +119,7 @@ struct pci_param *pci_walk_params(struct pci_access *acc, struct pci_param *prev
 
 struct pci_dev {
   struct pci_dev *next;			/* Next device in the chain */
-  u16 domain;				/* PCI domain (host bridge) */
+  int32_t domain;			/* PCI domain (host bridge) */
   u8 bus, dev, func;			/* Bus inside domain, device and function */
 
   /* These fields are set by pci_fill_info() */
-- 
1.7.10.4

