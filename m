Return-Path: <SRS0=YZnm=6L=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2830CC81AC4
	for <linux-pci@archiver.kernel.org>; Mon, 27 Apr 2020 18:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00F81214AF
	for <linux-pci@archiver.kernel.org>; Mon, 27 Apr 2020 18:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="P2chGHTL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbgD0SY1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 27 Apr 2020 14:24:27 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:53238 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726362AbgD0SY0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Apr 2020 14:24:26 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id AA2594C866;
        Mon, 27 Apr 2020 18:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1588011862; x=1589826263; bh=XCerxuP4kI3gs46RMMe56g/f4erT/fS2u3T
        lS2n0Bww=; b=P2chGHTLWR7ORtD4MI31GahOJfZ5rnHPL4BWFLMnvAFT8n/TgPG
        oQfYNZkq7EJGExxHLgZ2IzfJAr2N0I5m8K3AE42w/NuGHaRTOmDAxxcaKaGU6fIO
        4eJkUCGo6IKZRl91+R+X0o70we9byr0IJ4XEfXbFt2lB22jMOn5d4BI8=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id q20rnpg5tt8e; Mon, 27 Apr 2020 21:24:22 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 6CF994C849;
        Mon, 27 Apr 2020 21:24:12 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.136) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Mon, 27
 Apr 2020 21:24:13 +0300
From:   Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Stefan Roese <sr@denx.de>, Andy Lavr <andy.lavr@gmail.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Rajat Jain <rajatja@google.com>, <linux@yadro.com>,
        Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH v8 17/24] PCI: hotplug: Configure MPS after manual bus rescan
Date:   Mon, 27 Apr 2020 21:23:51 +0300
Message-ID: <20200427182358.2067702-18-s.miroshnichenko@yadro.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200427182358.2067702-1-s.miroshnichenko@yadro.com>
References: <20200427182358.2067702-1-s.miroshnichenko@yadro.com>
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

Assure that MPS settings are set up for bridges which are discovered during
manually triggered rescan via sysfs. This sequence of bridge init (using
pci_rescan_bus()) later will be used for pciehp hot-add events when BAR
movement is enabled.

Signed-off-by: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/probe.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 765b2883755a..d01d93c6bfa2 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3554,7 +3554,7 @@ static void pci_reassign_root_bus_resources(struct pci_bus *root)
 unsigned int pci_rescan_bus(struct pci_bus *bus)
 {
 	unsigned int max;
-	struct pci_bus *root = bus;
+	struct pci_bus *root = bus, *child;
 
 	while (!pci_is_root_bus(root))
 		root = root->parent;
@@ -3575,6 +3575,9 @@ unsigned int pci_rescan_bus(struct pci_bus *bus)
 		pci_assign_unassigned_bus_resources(bus);
 	}
 
+	list_for_each_entry(child, &root->children, node)
+		pcie_bus_configure_settings(child);
+
 	pci_bus_add_devices(bus);
 
 	return max;
-- 
2.24.1

