Return-Path: <SRS0=lIFx=RP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA07CC43381
	for <linux-pci@archiver.kernel.org>; Tue, 12 Mar 2019 12:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 880E520883
	for <linux-pci@archiver.kernel.org>; Tue, 12 Mar 2019 12:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="RU3h3YIZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbfCLMGJ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 12 Mar 2019 08:06:09 -0400
Received: from mta-01.yadro.com ([89.207.88.251]:53126 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbfCLMGJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Mar 2019 08:06:09 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 86E7641970;
        Tue, 12 Mar 2019 12:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :x-mailer:message-id:date:date:subject:subject:from:from
        :received:received:received; s=mta-01; t=1552392366; x=
        1554206767; bh=gDBZ6j539JVCaajAnl+5hGzOvB+eK6VecJl21AYPHqg=; b=R
        U3h3YIZB4RYQ8xt42G+NnGspVuVAb/eEaFOQfbI5wAaVmclCkN2NLUOfN1uAIS6U
        BuRnxyCoZLBdWFOzWpKhAh2g+wOBkaTHMv9asGOknprW+urZAO09qdkRtrf6ykUF
        MvkaSqgf7TCUVeRFQLG9bLJyTM7SZtJyygvkQNPgpc=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id il7u5DTFgWLM; Tue, 12 Mar 2019 15:06:06 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 9277341953;
        Tue, 12 Mar 2019 15:06:06 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.60) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Tue, 12
 Mar 2019 15:06:06 +0300
From:   Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>
CC:     <linux@yadro.com>,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>,
        Lukas Wunner <lukas@wunner.de>
Subject: [PATCH v2] PCI: pciehp: Fix re-enabling the slot marked for safe removal
Date:   Tue, 12 Mar 2019 15:05:48 +0300
Message-ID: <20190312120548.31875-1-s.miroshnichenko@yadro.com>
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

Clear out the Presence Detect Changed and Data Link Layer State Changed
events when the disabled slot has settled down.

It is still possible to re-enable the device if it remains in the slot
after pressing the Attention Button by pressing it again.

Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Cc: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/hotplug/pciehp_ctrl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index 3f3df4c29f6e..905282a8ddaa 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -115,6 +115,10 @@ static void remove_board(struct controller *ctrl, bool safe_removal)
 		 * removed from the slot/adapter.
 		 */
 		msleep(1000);
+
+		/* Ignore link or presence changes caused by power off */
+		atomic_and(~(PCI_EXP_SLTSTA_DLLSC | PCI_EXP_SLTSTA_PDC),
+			   &ctrl->pending_events);
 	}
 
 	/* turn off Green LED */
-- 
2.20.1

