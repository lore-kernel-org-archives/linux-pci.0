Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:23905 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755589AbbLQA6l (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 16 Dec 2015 19:58:41 -0500
Date: Wed, 16 Dec 2015 16:55:18 -0800
From: "Sean O. Stalley" <sean.stalley@intel.com>
To: David Daney <ddaney.cavm@gmail.com>
Cc: Martin Mares <mj@ucw.cz>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: Re: [PATCH v3] Add lspci support for Enhanced Allocation Capability.
Message-ID: <20151217005517.GA3765@sean.stalley.intel.com>
References: <1450217759-22063-1-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1450217759-22063-1-git-send-email-ddaney.cavm@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>From 484344fef7e5c96c54576586ce81e6209a48b92c Mon Sep 17 00:00:00 2001
From: "Sean O. Stalley" <sean.stalley@intel.com>
Date: Wed, 16 Dec 2015 10:31:51 -0800
Subject: [PATCH 1/1] Support region sizes that are not power-of-2

Enhanced Allocation allows PCI devices to reserve regions with DWORD
granularity. Make sure lspci doesn't tuncate least significant bits
of the region size.

ex: a 2000 byte region should display [size=2000] instead of [size=1K]
Signed-off-by: Sean O. Stalley <sean.stalley@intel.com>
---

Hi David,

Here are some additional changes I think we should make to lspci in order to support EA.

The truncation problem was a simple fix.

Regions described by EA are being mislabeled as [virtual].
I spent some time today trying to write a patch that fixes this issue.
I couldn't come up with a clean solution, so I just added a comment.

Let me know if you have any questions.

Thanks,
Sean

 lspci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lspci.c b/lspci.c
index fe7b7fe..d483f3a 100644
--- a/lspci.c
+++ b/lspci.c
@@ -336,7 +336,7 @@ show_size(pciaddr_t x)
   if (!x)
     return;
   for (i = 0; i < (sizeof(suffix) / sizeof(*suffix) - 1); i++) {
-    if (x < 1024)
+    if (x % 1024)
       break;
     x /= 1024;
   }
@@ -366,7 +366,7 @@ show_bases(struct device *d, int cnt)
 	putchar('\t');
       if (pos && !flg)			/* Reported by the OS, but not by the device */
 	{
-	  printf("[virtual] ");
+	  printf("[virtual] ");		/* could also be enhanced */
 	  flg = pos;
 	  virtual = 1;
 	}
-- 
1.9.1

