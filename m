Return-Path: <SRS0=yUVM=RE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7B8C43381
	for <linux-pci@archiver.kernel.org>; Fri,  1 Mar 2019 16:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A40B2083D
	for <linux-pci@archiver.kernel.org>; Fri,  1 Mar 2019 16:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="ft3xK4pp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388879AbfCAQND (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 1 Mar 2019 11:13:03 -0500
Received: from mta-01.yadro.com ([89.207.88.251]:35650 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387940AbfCAQND (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 Mar 2019 11:13:03 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 922DA4198A;
        Fri,  1 Mar 2019 16:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :x-mailer:message-id:date:date:subject:subject:from:from
        :received:received:received; s=mta-01; t=1551456780; x=
        1553271181; bh=Ew+NvM5YpqeWK6n2hIIQvzHcHCPz9CIq8PNP0lNS7gQ=; b=f
        t3xK4ppF1pQICG6DYuviweYHJXDTHmmcvAXNwak7sRkQLxxwJBZpii+vH98aOH8k
        lIC7irrXkPnhXBMpoAMekJ2XQV4wajlHeV9HdXER1MGRH0wK2podvvbvQYX+RVVO
        N92woM1VyXKGARYUraiwliRczOQU2raY/KMqNNR22U=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id aSHsHRMzshPL; Fri,  1 Mar 2019 19:13:00 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 686A94196B;
        Fri,  1 Mar 2019 19:13:00 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.60) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Fri, 1 Mar
 2019 19:13:00 +0300
From:   Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>
CC:     <linux@yadro.com>,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>,
        Lukas Wunner <lukas@wunner.de>
Subject: [PATCH] PCI: pciehp: Fix re-enabling the slot marked for safe removal
Date:   Fri, 1 Mar 2019 19:12:51 +0300
Message-ID: <20190301161251.26774-1-s.miroshnichenko@yadro.com>
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

During the safe removal procedure, a Data Link Layer State Changed event
may occur after pciehp_power_off_slot(), and it is handled when the slot is
already set to OFF_STATE. This results in re-enabling the device and makes
it impossible to actually safely remove it.

Add a check for a Presence Detect Changed bit to filter out this interrupt.

It is still possible to re-enable the device if it remains in the slot
after pressing the Attention Button by pressing it again.

Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Cc: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/hotplug/pciehp_ctrl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index 3f3df4c29f6e..941f77b71df4 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -251,6 +251,14 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
 		return;
 	}
 
+	/* Handle the DLLSC from the slot which just has been turned off */
+	if ((events & PCI_EXP_SLTSTA_DLLSC) &&
+	    !(events & PCI_EXP_SLTSTA_PDC) &&
+	    present && !link_active) {
+		mutex_unlock(&ctrl->state_lock);
+		return;
+	}
+
 	switch (ctrl->state) {
 	case BLINKINGON_STATE:
 		cancel_delayed_work(&ctrl->button_work);
-- 
2.20.1

