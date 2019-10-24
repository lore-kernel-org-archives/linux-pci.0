Return-Path: <SRS0=OYe3=YR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A075AC47E49
	for <linux-pci@archiver.kernel.org>; Thu, 24 Oct 2019 17:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CC4C21925
	for <linux-pci@archiver.kernel.org>; Thu, 24 Oct 2019 17:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="GFjFLadH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfJXRWH (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 24 Oct 2019 13:22:07 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:49472 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2440024AbfJXRWH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Oct 2019 13:22:07 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 6B68A439EC;
        Thu, 24 Oct 2019 17:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1571937725; x=1573752126; bh=eiuIF3swzyI/gaAxYQfEqUHWZiQl/0a1ZPt
        gHsoEv/8=; b=GFjFLadH7cC2VK/trP2LxgzV7p7yZsMe6GYxez3Na4DhBt3x/ET
        kfD0EqHWvSAqgIFHcVI3YOmoBYYP8A15JbOf1tPEdnjHV1WhcVhYkqkJ996nFpNN
        hbeEa3cqkjZL6wGaHRR2nvohT/TvNetX3bO0uin3d0WFxfYbiyzkAv0E=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Ar0yOIUOOS5b; Thu, 24 Oct 2019 20:22:05 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id BB25243130;
        Thu, 24 Oct 2019 20:22:04 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.136) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Thu, 24
 Oct 2019 20:22:04 +0300
From:   Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, <linux@yadro.com>,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH RFC 02/11] PCI: proc: Nullify a freed pointer
Date:   Thu, 24 Oct 2019 20:21:48 +0300
Message-ID: <20191024172157.878735-3-s.miroshnichenko@yadro.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191024172157.878735-1-s.miroshnichenko@yadro.com>
References: <20191024172157.878735-1-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.15.136]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

A PCI device may be detached from /proc/bus/pci/devices not only when it is
removed, but also when its bus had changed the number - in this case the
proc entry must be recreated to reflect the new PCI topology.

Nullify freed pointers to mark them as valid for allocating again.

Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/proc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
index 5495537c60c2..c85654dd315b 100644
--- a/drivers/pci/proc.c
+++ b/drivers/pci/proc.c
@@ -443,6 +443,7 @@ int pci_proc_detach_device(struct pci_dev *dev)
 int pci_proc_detach_bus(struct pci_bus *bus)
 {
 	proc_remove(bus->procdir);
+	bus->procdir = NULL;
 	return 0;
 }
 
-- 
2.23.0

