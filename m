Return-Path: <SRS0=ZQO4=QM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B33C282CB
	for <linux-pci@archiver.kernel.org>; Tue,  5 Feb 2019 21:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D814217F9
	for <linux-pci@archiver.kernel.org>; Tue,  5 Feb 2019 21:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="IpFUpMot"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbfBEVWj (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 5 Feb 2019 16:22:39 -0500
Received: from smtprelay.synopsys.com ([198.182.60.111]:40226 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfBEVWj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Feb 2019 16:22:39 -0500
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 3DD0F10C1DC5;
        Tue,  5 Feb 2019 13:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1549401759; bh=HEFnF4VIVx1Mvu5L4XVuG1IlRmmJOsDYaaYCa8Ia8E4=;
        h=Date:From:Subject:To:CC:From;
        b=IpFUpMotd1fn7z4F8MhH295dUC/Z6eWO1MalpzmdAyLhf//bHe4UlZLJLyzErv1TM
         59O0qXlgR+KDyFGcq5qVtISEYQcDwe+XTWKvooMPgQpG41Mx6KjBv6SkiLauFY4dKL
         uOO+u9Rs7JAyXrZwdGpwDZyx3Vc9Tt9p1V7ZkuDHI2LCqgLDCtldmI5U7iq3W3kbk4
         d1tr/sbVYvjIDDssyIyryX4cGblLi2+9Ai8g9KZhiVmgyYd6kVfriI6DqFMVRPUL4v
         K80Va95/LKnQqdO0RyAqulC1O+EAGZck5xUUaRB4PTKXju4XO+6pcYsq2ywmLhSANQ
         av2BHr1Agtaew==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 2AA1EA00C4;
        Tue,  5 Feb 2019 21:22:39 +0000 (UTC)
Received: from US01WEHTC1.internal.synopsys.com (10.12.239.236) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 5 Feb 2019 13:22:39 -0800
Received: from te-lab16 (10.13.184.20) by us01wehtc1.internal.synopsys.com
 (10.12.239.236) with Microsoft SMTP Server (TLS) id 14.3.408.0; Tue, 5 Feb
 2019 13:22:37 -0800
Received: by te-lab16 (sSMTP sendmail emulation); Tue, 05 Feb 2019 13:22:37
 -0800
Date:   Tue, 5 Feb 2019 13:22:37 -0800
Message-ID: <a28cfcee61f0842efe114c97b566bb3d967ba3d3.1549326366.git.thinhn@synopsys.com>
From:   Thinh Nguyen <thinh.nguyen@synopsys.com>
Subject: [PATCH RESEND] PCI: Check for USB xHCI class for HAPS platform
To:     Bjorn Helgaas <helgaas@kernel.org>, <linux-pci@vger.kernel.org>
CC:     John Youn <john.youn@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.13.184.20]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The Synopsys HAPS USB controller has a VID PID (16c3,abcd) that matches
to an existing PCIe controller. This quirk is intended for USB HAPS
devices only. To fix this, check for the PCI class USB xHCI to prevent
matching the PCIe controllers.

Fixes: 03e6742584af ("PCI: Override Synopsys USB 3.x HAPS device class")
Signed-off-by: Thinh Nguyen <thinhn@synopsys.com>
---
 drivers/pci/quirks.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index b0a413f3f7ca..e2a879e93d86 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -639,8 +639,9 @@ static void quirk_synopsys_haps(struct pci_dev *pdev)
 		break;
 	}
 }
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SYNOPSYS, PCI_ANY_ID,
-			 quirk_synopsys_haps);
+DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_VENDOR_ID_SYNOPSYS, PCI_ANY_ID,
+			       PCI_CLASS_SERIAL_USB_XHCI, 0,
+			       quirk_synopsys_haps);
 
 /*
  * Let's make the southbridge information explicit instead of having to
-- 
2.11.0

