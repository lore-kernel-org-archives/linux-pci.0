Return-Path: <SRS0=Fxx+=57=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8281BC352BE
	for <linux-pci@archiver.kernel.org>; Wed, 15 Apr 2020 00:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5803A2076B
	for <linux-pci@archiver.kernel.org>; Wed, 15 Apr 2020 00:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586909224;
	bh=kX9vypy+m7pQaRNUL9aqUl2TFQjXB7+7PTmQ2YV4/2M=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=zJg5VY8c1XzbN/T4S4o8O5QrrkD0Iin9IAoKcX9TW5JHXhqHnUQtxld/U0RZgBCaq
	 5qOXHs1wUcGahm61Zexhq/2TlgWhMVNf4QM973D9aSgftHDq2vd9SnHzn2Z0E/9KZ6
	 1YoKKMPgwq6MHnVBFNkq8vMwOS3SWKrXU918JWR8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392239AbgDOAHA (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 14 Apr 2020 20:07:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:35366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392240AbgDOAG6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Apr 2020 20:06:58 -0400
Received: from localhost (mobile-166-175-184-103.mycingular.net [166.175.184.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84C722076B;
        Wed, 15 Apr 2020 00:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586909217;
        bh=kX9vypy+m7pQaRNUL9aqUl2TFQjXB7+7PTmQ2YV4/2M=;
        h=From:To:Cc:Subject:Date:From;
        b=gRO4dsLDyAqo+weACE5eZSSEfg08RLogdh6jLKlPDCPCEsVQztae7cK0OiGuUcwv9
         ILh5pd8J1DFcWTdS4dxehzOA12fPjdELHxJpTzYVyI9DIFZp0ad1zhEo2RRgc9YIbA
         7zRX6Jzi4WqRVzoNGL4Fyrd59AcE/GheFpD+Micc=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH] PCI/PM: Call .bridge_d3() hook only if non-NULL
Date:   Tue, 14 Apr 2020 19:06:35 -0500
Message-Id: <20200415000635.144283-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

26ad34d510a8 ("PCI / ACPI: Whitelist D3 for more PCIe hotplug ports") added
the struct pci_platform_pm_ops.bridge_d3() function pointer and
platform_pci_bridge_d3() to use it.

The .bridge_d3() op is implemented by acpi_pci_platform_pm, but not by
mid_pci_platform_pm.  We don't expect platform_pci_bridge_d3() to be called
on Intel MID platforms, but nothing in the code itself would prevent that.

Check the .bridge_d3() pointer for NULL before calling it.

Fixes: 26ad34d510a8 ("PCI / ACPI: Whitelist D3 for more PCIe hotplug ports")
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 595fcf59843f..dfa7ec008963 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -868,7 +868,9 @@ static inline bool platform_pci_need_resume(struct pci_dev *dev)
 
 static inline bool platform_pci_bridge_d3(struct pci_dev *dev)
 {
-	return pci_platform_pm ? pci_platform_pm->bridge_d3(dev) : false;
+	if (pci_platform_pm && pci_platform_pm->bridge_d3)
+		return pci_platform_pm->bridge_d3(dev);
+	return false;
 }
 
 /**
-- 
2.26.0.110.g2183baf09c-goog

