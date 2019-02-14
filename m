Return-Path: <SRS0=m7pK=QV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA91C43381
	for <linux-pci@archiver.kernel.org>; Thu, 14 Feb 2019 17:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08DFB222DE
	for <linux-pci@archiver.kernel.org>; Thu, 14 Feb 2019 17:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394308AbfBNRAe (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 14 Feb 2019 12:00:34 -0500
Received: from ale.deltatee.com ([207.54.116.67]:36466 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394094AbfBNRAd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 14 Feb 2019 12:00:33 -0500
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1guKNC-0004Pe-Uf; Thu, 14 Feb 2019 10:00:33 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1guKNC-0007G9-Iy; Thu, 14 Feb 2019 10:00:30 -0700
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Kit Chow <kchow@gigaio.com>, Logan Gunthorpe <logang@deltatee.com>,
        Yinghai Lu <yinghai@kernel.org>
Date:   Thu, 14 Feb 2019 10:00:28 -0700
Message-Id: <20190214170028.27862-2-logang@deltatee.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20190214170028.27862-1-logang@deltatee.com>
References: <20190214170028.27862-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, bhelgaas@google.com, kchow@gigaio.com, logang@deltatee.com, yinghai@kernel.org
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH 2/2] PCI: Fix disabling of bridge BARs when assigning bus resources
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

One odd quirk of PLX switches is that their upstream bridge port has
256K of space allocated behind its BAR0 (most other bridge
implementations do not report any BAR space). The lspci for such  device
looks like:

  04:00.0 PCI bridge: PLX Technology, Inc. PEX 8724 24-Lane, 6-Port PCI
            Express Gen 3 (8 GT/s) Switch, 19 x 19mm FCBGA (rev ca)
	    (prog-if 00 [Normal decode])
      Physical Slot: 1
      Flags: bus master, fast devsel, latency 0, IRQ 30, NUMA node 0
      Memory at 90a00000 (32-bit, non-prefetchable) [size=256K]
      Bus: primary=04, secondary=05, subordinate=0a, sec-latency=0
      I/O behind bridge: 00002000-00003fff
      Memory behind bridge: 90000000-909fffff
      Prefetchable memory behind bridge: 0000380000800000-0000380000bfffff
      Kernel driver in use: pcieport

It's not clear what the purpose of the memory at 0x90a00000 is, and
currently the kernel never actually uses it for anything. In most cases,
it's safely ignored and does not cause a problem.

However, when the kernel assigns the resource addresses (with the
pci=realloc command line parameter, for example) it can inadvertently
disable the struct resource corresponding to the bar. When this happens,
lspci will report this memory as ignored:

   Region 0: Memory at <ignored> (32-bit, non-prefetchable) [size=256K]

This is because the kernel reports a zero start address and zero flags
in the corresponding sysfs resource file and in /proc/bus/pci/devices.
Investigation with 'lspci -x', however shows the bios-assigned address
will still be programmed in the device's BAR registers.

In many cases, this still isn't a problem. Nothing uses the memory,
so nothing is affected. However, a big problem shows up when an IOMMU
is in use: the IOMMU will not reserve this space in the IOVA because the
kernel no longer thinks the range is valid. (See
dmar_init_reserved_ranges() for the Intel implementation of this.)

Without the proper reserved range, we have a situation where a DMA
mapping may occasionally allocate an IOVA which the PCI bus will actually
route to a BAR in the PLX switch. This will result in some random DMA
writes not actually writing to the RAM they are supposed to, or random
DMA reads returning all FFs from the PLX BAR when it's supposed to have
read from RAM.

The problem is caused in pci_assign_unassigned_root_bus_resources().
When any resource from a bridge device fails to get assigned, the code
sets the resource's flags to zero. This makes sense for bridge resources,
as they will be re-enabled later, but for regular BARs, it disables them
permanently. To fix the problem, we only set the flags to zero for
bridge resources and treat any other resources like non-bridge devices.

Reported-by: Kit Chow <kchow@gigaio.com>
Fixes: da7822e5ad71 ("PCI: update bridge resources to get more big ranges when allocating space (again)")
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/setup-bus.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 56b7077f37ff..3695edd9c256 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1821,11 +1821,16 @@ void pci_assign_unassigned_root_bus_resources(struct pci_bus *bus)
 	/* restore size and flags */
 	list_for_each_entry(fail_res, &fail_head, list) {
 		struct resource *res = fail_res->res;
+		int idx;
 
 		res->start = fail_res->start;
 		res->end = fail_res->end;
 		res->flags = fail_res->flags;
-		if (fail_res->dev->subordinate)
+
+		idx = res - &fail_res->dev->resource[0];
+		if (fail_res->dev->subordinate &&
+		    idx >= PCI_BRIDGE_RESOURCES &&
+		    idx <= PCI_BRIDGE_RESOURCE_END)
 			res->flags = 0;
 	}
 	free_list(&fail_head);
-- 
2.19.0

