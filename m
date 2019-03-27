Return-Path: <SRS0=cd0N=R6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C62C10F00
	for <linux-pci@archiver.kernel.org>; Wed, 27 Mar 2019 19:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEE602082F
	for <linux-pci@archiver.kernel.org>; Wed, 27 Mar 2019 19:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553714077;
	bh=0EvPsyrNauFBBGi4MV+gCnThKAevGLzPCtVz+KmzyNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iMYeaw48GZWSHch+1oKhIe6CwcX+FgT0AwDVhPBGog6mmQrc9OUUb/91L9lRNWPbJ
	 DMG1K0L4H2ryblfPegDV2acXOeZidYS45NXh1PY8bgTwY6tEVPoun4GEPyamzKIJ3l
	 oB8wWeyeRQAtyPeFESeTYd6sgUEkcn0UY85zeDFI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388619AbfC0SJm (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:09:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:51532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388618AbfC0SJl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 27 Mar 2019 14:09:41 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1D312054F;
        Wed, 27 Mar 2019 18:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710180;
        bh=0EvPsyrNauFBBGi4MV+gCnThKAevGLzPCtVz+KmzyNM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c7JIS9J22+I8pzLkc3LxRtRfOPx0v3f6kItOtEXZldlDwxpcfTM/KGndAhcRHS1T2
         AwTWu18y6HmT4V5laIApMvU44GNshKLCHoaVLoe04qr5ewWz9AfZzmAV/MaO4csdJS
         gb5hQcOfhEHlBLtYluMwwz41H6+wZJL8f984NoSo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <sashal@kernel.org>, linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 237/262] PCI: pciehp: Assign ctrl->slot_ctrl before writing it to hardware
Date:   Wed, 27 Mar 2019 14:01:32 -0400
Message-Id: <20190327180158.10245-237-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Mika Westerberg <mika.westerberg@linux.intel.com>

[ Upstream commit 25bd879ec16ad3b83a5b1c3f16faa55e696bfccb ]

Shameerali reported that running v4.20-rc1 as QEMU guest, the PCIe hotplug
port times out during boot:

  pciehp 0000:00:01.0:pcie004: Timeout on hotplug command 0x03f1 (issued 1016 msec ago)
  pciehp 0000:00:01.0:pcie004: Timeout on hotplug command 0x03f1 (issued 1024 msec ago)
  pciehp 0000:00:01.0:pcie004: Failed to check link status
  pciehp 0000:00:01.0:pcie004: Timeout on hotplug command 0x02f1 (issued 2520 msec ago)

The issue was bisected down to commit 720d6a671a6e ("PCI: pciehp: Do not
handle events if interrupts are masked") and was further analyzed by the
reporter to be caused by the fact that pciehp first updates the hardware
and only then cache the ctrl->slot_ctrl in pcie_do_write_cmd().  If the
interrupt happens before we cache the value, pciehp_isr() reads value 0 and
decides that the interrupt was not meant for it causing the above timeout
to trigger.

Fix by moving ctrl->slot_ctrl assignment to happen before it is written to
the hardware.

Fixes: 720d6a671a6e ("PCI: pciehp: Do not handle events if interrupts are masked")
Link: https://lore.kernel.org/linux-pci/5FC3163CFD30C246ABAA99954A238FA8387DD344@FRAEML521-MBX.china.huawei.com
Reported-by: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/hotplug/pciehp_hpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index c0fb64ace05a..8bfcb8cd0900 100644
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
2.19.1

