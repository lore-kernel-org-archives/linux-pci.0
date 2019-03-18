Return-Path: <SRS0=G860=RV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BBABC43381
	for <linux-pci@archiver.kernel.org>; Mon, 18 Mar 2019 14:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4968A2087E
	for <linux-pci@archiver.kernel.org>; Mon, 18 Mar 2019 14:31:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="Jef+DARF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbfCRObp (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 18 Mar 2019 10:31:45 -0400
Received: from mta-01.yadro.com ([89.207.88.251]:59320 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727810AbfCRObp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 Mar 2019 10:31:45 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id D56EC41185;
        Mon, 18 Mar 2019 14:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :x-mailer:message-id:date:date:subject:subject:from:from
        :received:received:received; s=mta-01; t=1552919501; x=
        1554733902; bh=NuSJI1GKE+z3r0/LbDXutju1u8vJ6/xlKaTHDjjJyNc=; b=J
        ef+DARFL5NQdkSoRvMVa+/80tatOFVdQFmOmLNPaKP01FR7rHEhhACLnFo19HZyV
        eumKQoSxbR01y91TCpGhandV+iRistvgUbhMcNuzMXsQECJp0ESSjrTEoJ9wkdEo
        qdMXXhBqj/eRuZh5mxyLPiJXUzeeopf5jbD4ckuDHc=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GHOYb4hkiln8; Mon, 18 Mar 2019 17:31:41 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id AAD994194E;
        Mon, 18 Mar 2019 17:31:41 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.60) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Mon, 18
 Mar 2019 17:31:41 +0300
From:   Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>
CC:     <linux@yadro.com>,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>,
        Lukas Wunner <lukas@wunner.de>
Subject: [PATCH] PCI: pciehp: Don't wait for Command Completed if this interrupt is disabled
Date:   Mon, 18 Mar 2019 17:31:29 +0300
Message-ID: <20190318143129.6640-1-s.miroshnichenko@yadro.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.15.60]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pcie_init() invokes pcie_disable_notification() for empty slots, which in
turn disables the Command Complete interrupt (unset PCI_EXP_SLTCTL_CCIE)
and right after that waits for Command Complete event (PCI_EXP_SLTSTA_CC).

This results in longer boot time - 4 seconds of delay for each empty slot:

[    4.200325] pciehp 0042:04:08.0:pcie204: Slot #40 AttnBtn+ PwrCtrl+ MRL- AttnInd+ PwrInd+ HotPlug+ Surprise- Interlock- NoCompl- LLActRep+
[    4.200607] pciehp 0042:04:08.0:pcie204: pciehp_get_power_status: SLOTCTRL 80 value read 1c0
[    6.217938] pciehp 0042:04:08.0:pcie204: Timeout on hotplug command 0x01c0 (issued 2020 msec ago)
[    6.217966] pciehp 0042:04:08.0:pcie204: pcie_disable_notification: SLOTCTRL 80 write cmd 0
[    6.237938] pciehp 0042:04:08.0:pcie204: Timeout on hotplug command 0x01c0 (issued 2040 msec ago)
[    8.257939] pciehp 0042:04:08.0:pcie204: Timeout on hotplug command 0x05c0 (issued 2020 msec ago)
[    8.257974] pciehp 0042:04:08.0:pcie204: pciehp_power_off_slot: SLOTCTRL 80 write cmd 400
[    8.258034] pci_bus 0042:07: dev 00, created physical slot 40
[    8.277941] pciehp 0042:04:08.0:pcie204: Timeout on hotplug command 0x05c0 (issued 2040 msec ago)
[    8.277967] pciehp 0042:04:08.0:pcie204: pcie_enable_notification: SLOTCTRL 80 write cmd 1031

Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Cc: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/hotplug/pciehp_hpc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 6a2365cd794e..eec5d6107360 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -118,8 +118,10 @@ static void pcie_wait_cmd(struct controller *ctrl)
 	if (ctrl->slot_ctrl & PCI_EXP_SLTCTL_HPIE &&
 	    ctrl->slot_ctrl & PCI_EXP_SLTCTL_CCIE)
 		rc = wait_event_timeout(ctrl->queue, !ctrl->cmd_busy, timeout);
-	else
+	else if (ctrl->slot_ctrl & PCI_EXP_SLTCTL_CCIE)
 		rc = pcie_poll_cmd(ctrl, jiffies_to_msecs(timeout));
+	else
+		return;
 
 	if (!rc)
 		ctrl_info(ctrl, "Timeout on hotplug command %#06x (issued %u msec ago)\n",
-- 
2.20.1

