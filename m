Return-Path: <SRS0=70A0=PP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3392C43612
	for <linux-pci@archiver.kernel.org>; Mon,  7 Jan 2019 13:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 845F02147C
	for <linux-pci@archiver.kernel.org>; Mon,  7 Jan 2019 13:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731181AbfAGNJp (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:09:45 -0500
Received: from mga17.intel.com ([192.55.52.151]:36962 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727700AbfAGNJo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Jan 2019 08:09:44 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jan 2019 05:09:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,451,1539673200"; 
   d="scan'208";a="309629132"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 07 Jan 2019 05:09:41 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 10B2B141; Mon,  7 Jan 2019 15:09:40 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
        Lukas Wunner <lukas@wunner.de>,
        Sinan Kaya <okaya@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>,
        Oza Pawandeep <poza@codeaurora.org>, wangzhou1@hisilicon.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] PCI: pciehp: Assign ctrl->slot_ctrl before writing it to hardware
Date:   Mon,  7 Jan 2019 16:09:40 +0300
Message-Id: <20190107130940.83680-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Shameerali reported that running v4.20-rc1 as QEMU guest, the PCIe
hotplug port times out during boot:

  pciehp 0000:00:01.0:pcie004: Timeout on hotplug command 0x03f1 (issued 1016 msec ago)
  pciehp 0000:00:01.0:pcie004: Timeout on hotplug command 0x03f1 (issued 1024 msec ago)
  pciehp 0000:00:01.0:pcie004: Failed to check link status
  pciehp 0000:00:01.0:pcie004: Timeout on hotplug command 0x02f1 (issued 2520 msec ago)

The issue was bisected down to commit 720d6a671a6e ("PCI: pciehp: Do not
handle events if interrupts are masked") and was further analyzed by the
reporter to be caused by the fact that pciehp first updates the hardware
and only then cache the ctrl->slot_ctrl in pcie_do_write_cmd(). If the
interrupt happens before we cache the value, pciehp_isr() reads value 0
and decides that the interrupt was not meant for it causing the above
timeout to trigger.

Fix by moving ctrl->slot_ctrl assignment to happen before it is written
to the hardware.

Fixes: 720d6a671a6e ("PCI: pciehp: Do not handle events if interrupts are masked")
Reported-by: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
The original patch was sent 14 Nov 2018 but was never applied so resending.

  https://patchwork.kernel.org/patch/10682715/

 drivers/pci/hotplug/pciehp_hpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 7dd443aea5a5..cd9eae650aa5 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -156,9 +156,9 @@ static void pcie_do_write_cmd(struct controller *ctrl, u16 cmd,
 	slot_ctrl |= (cmd & mask);
 	ctrl->cmd_busy = 1;
 	smp_mb();
+	ctrl->slot_ctrl = slot_ctrl;
 	pcie_capability_write_word(pdev, PCI_EXP_SLTCTL, slot_ctrl);
 	ctrl->cmd_started = jiffies;
-	ctrl->slot_ctrl = slot_ctrl;
 
 	/*
 	 * Controllers with the Intel CF118 and similar errata advertise
-- 
2.19.2

