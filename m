Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08491C47090
	for <linux-pci@archiver.kernel.org>; Fri,  2 Dec 2022 21:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233977AbiLBVS6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 2 Dec 2022 16:18:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiLBVSw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Dec 2022 16:18:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8776481382;
        Fri,  2 Dec 2022 13:18:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25EA9623D6;
        Fri,  2 Dec 2022 21:18:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EA61C433D6;
        Fri,  2 Dec 2022 21:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670015930;
        bh=98iM6PYlP1DYwAk+kn2Y+b30wbZFzaWkuIMVL5eYs9E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JHW5goLi4gEr/sxsDqMHLD3F5/TDtVgc5DMrBwUgfeIk5J/Sz6gZmeriQGHK0b+Rw
         fjm0AjUwPVDtaCe/N0Y17PHViz0nvNsN+X3/LSfcRRWNslFzP1SaVtVap8XKIZYzPf
         AmCiOVIjCOpzc3XXS9KZjJ/MfBQYF06WcOckJ2xs2gr/iQCdPE54shmflRAI1ueOa2
         AcUjige64Bw1PGcXzqboU1gv4iN7bolYEAhDgsCOMxdVMBc1PxtoTeNnzCxo9nulA1
         c6vC0P6mCcbZqjWwSnuTI3esa2V7pynZUy0qtH+WLKRzs5hBmqYVmEgyR76mANbClo
         OEg/V+ZT/Yp1g==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Florent DELAHAYE <kernelorg@undead.fr>,
        Konrad J Hambrick <kjhambrick@gmail.com>,
        Matt Hansen <2lprbe78@duck.com>,
        =?UTF-8?q?Benoit=20Gr=C3=A9goire?= <benoitg@coeus.ca>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Werner Sembach <wse@tuxedocomputers.com>,
        mumblingdrunkard@protonmail.com, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 3/4] x86/PCI: Tidy E820 removal messages
Date:   Fri,  2 Dec 2022 15:18:37 -0600
Message-Id: <20221202211838.1061278-4-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221202211838.1061278-1-helgaas@kernel.org>
References: <20221202211838.1061278-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

These messages:

  clipped [mem size 0x00000000 64bit] to [mem size 0xfffffffffffa0000 64bit] for e820 entry [mem 0x0009f000-0x000fffff]

aren't as useful as they could be because (a) the resource is often
IORESOURCE_UNSET, so we print the size instead of the start/end and (b) we
print the available resource even if it is empty after removing the E820
entry.

Print the available space by hand to avoid the IORESOURCE_UNSET problem and
only if it's non-empty.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Hans de Goede <hdegoede@redhat.com>
---
 arch/x86/kernel/resource.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/resource.c b/arch/x86/kernel/resource.c
index bba1abd05bfe..f34454f694cb 100644
--- a/arch/x86/kernel/resource.c
+++ b/arch/x86/kernel/resource.c
@@ -42,8 +42,11 @@ static void remove_e820_regions(struct resource *avail)
 
 		resource_clip(avail, e820_start, e820_end);
 		if (orig.start != avail->start || orig.end != avail->end) {
-			pr_info("clipped %pR to %pR for e820 entry [mem %#010Lx-%#010Lx]\n",
-				 &orig, avail, e820_start, e820_end);
+			pr_info("resource: avoiding allocation from e820 entry [mem %#010Lx-%#010Lx]\n",
+				e820_start, e820_end);
+			if (avail->end > avail->start)
+				pr_info("resource: remaining [mem %#010Lx-%#010Lx] available\n",
+					avail->start, avail->end);
 			orig = *avail;
 		}
 	}
-- 
2.25.1

