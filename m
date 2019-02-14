Return-Path: <SRS0=m7pK=QV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE2CC43381
	for <linux-pci@archiver.kernel.org>; Thu, 14 Feb 2019 17:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 358D0222DA
	for <linux-pci@archiver.kernel.org>; Thu, 14 Feb 2019 17:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbfBNRAd (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 14 Feb 2019 12:00:33 -0500
Received: from ale.deltatee.com ([207.54.116.67]:36462 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727997AbfBNRAd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 14 Feb 2019 12:00:33 -0500
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1guKNC-0004Pd-Uf; Thu, 14 Feb 2019 10:00:32 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1guKNC-0007G7-Fl; Thu, 14 Feb 2019 10:00:30 -0700
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Kit Chow <kchow@gigaio.com>, Logan Gunthorpe <logang@deltatee.com>,
        Yinghai Lu <yinghai@kernel.org>
Date:   Thu, 14 Feb 2019 10:00:27 -0700
Message-Id: <20190214170028.27862-1-logang@deltatee.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, bhelgaas@google.com, kchow@gigaio.com, logang@deltatee.com, yinghai@kernel.org
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH 1/2] PCI: Prevent 64-bit resources from being counted in 32-bit bridge region
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When using the pci=realloc command line argument, with hpmemsize not
equal to zero, some hierarchies of 32-bit resources can fail to be
assigned in some situations. When this happens, the user will see
some PCI BAR resources being ignored and some PCI Bridge windows
being left unset. In lspci this may look like:

  Memory behind bridge: fff00000-000fffff

or

  Region 0: Memory at <ignored> (32-bit, non-prefetchable) [size=256K]

Ignored BARs mean the underlying device will not be usable.

The possible situations where this can happen will be quite varied and
depend highly on the exact hierarchy and how the realloc code ends up
trying to assign the regions. It's known to at least require a
large 64-bit BAR (>1GB) below a PCI bridge.

The cause of this bug is in __pci_bus_size_bridges() which tries to
calculate the total resource space required for each of the bridge windows
(typically IO, 64-bit, and 32-bit / non-prefetchable). The code, as
written, tries to allocate all the 64-bit prefetchable resources
followed by all the remaining resources. It uses two calls to
pbus_size_mem() for this. If the first call to pbus_size_mem() fails
it tries to fit all resources into the 32-bit bridge window and it
expects the size of the 32-bit bridge window to be multiple GBs which
will never be assignable under the 4GB limit imposed on it.

There are only two reasons for pbus_size_mem() to fail: if there is no
64-bit/prefetchable bridge window, or if that window is already
assigned (in other words, its resource already has a parent set). We know
the former case can't be true because, in __pci_bus_size_bridges(), it's
existence is checked before making the call. So if the pbus_size_mem()
call in question fails, the window must already be assigned, and in this
case, we still do not want 64-bit resources trying to be sized into the
32-bit catch-all resource.

So to fix the bug, we must always set mask, type2 and type3 in cases
where a 64-bit resource exists even if pbus_size_mem() fails.

Reported-by: Kit Chow <kchow@gigaio.com>
Fixes: 5b28541552ef ("PCI: Restrict 64-bit prefetchable bridge windows to 64-bit resources")
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/setup-bus.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index ed960436df5e..56b7077f37ff 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1265,21 +1265,20 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 		prefmask = IORESOURCE_MEM | IORESOURCE_PREFETCH;
 		if (b_res[2].flags & IORESOURCE_MEM_64) {
 			prefmask |= IORESOURCE_MEM_64;
-			ret = pbus_size_mem(bus, prefmask, prefmask,
+			pbus_size_mem(bus, prefmask, prefmask,
 				  prefmask, prefmask,
 				  realloc_head ? 0 : additional_mem_size,
 				  additional_mem_size, realloc_head);
 
 			/*
-			 * If successful, all non-prefetchable resources
-			 * and any 32-bit prefetchable resources will go in
-			 * the non-prefetchable window.
+			 * Given the existence of a 64-bit resource for this
+			 * bus, all non-prefetchable resources and any 32-bit
+			 * prefetchable resources will go in the
+			 * non-prefetchable window.
 			 */
-			if (ret == 0) {
-				mask = prefmask;
-				type2 = prefmask & ~IORESOURCE_MEM_64;
-				type3 = prefmask & ~IORESOURCE_PREFETCH;
-			}
+			mask = prefmask;
+			type2 = prefmask & ~IORESOURCE_MEM_64;
+			type3 = prefmask & ~IORESOURCE_PREFETCH;
 		}
 
 		/*
-- 
2.19.0

