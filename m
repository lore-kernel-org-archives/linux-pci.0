Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66528C43460
	for <linux-pci@archiver.kernel.org>; Tue,  4 May 2021 17:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DAF5613C6
	for <linux-pci@archiver.kernel.org>; Tue,  4 May 2021 17:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbhEDRSz (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 4 May 2021 13:18:55 -0400
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:24942 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbhEDRSx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 May 2021 13:18:53 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d41 with ME
        id 0hHw2500D21Fzsu03hHwtL; Tue, 04 May 2021 19:17:57 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 04 May 2021 19:17:57 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     thierry.reding@gmail.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, bhelgaas@google.com, jonathanh@nvidia.com
Cc:     linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 2/3] PCI: tegra: Use 'seq_puts' instead of 'seq_printf'
Date:   Tue,  4 May 2021 19:17:54 +0200
Message-Id: <7bdedb342b9221169ab085540cf25d1992e8b97a.1620148539.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <55b11e9a7fa2987fbc0869d68ae59888954d65e2.1620148539.git.christophe.jaillet@wanadoo.fr>
References: <55b11e9a7fa2987fbc0869d68ae59888954d65e2.1620148539.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

As spotted by checkpatch, use 'seq_puts' instead of 'seq_printf' when
possible.
It is slightly more efficient.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/pci/controller/pci-tegra.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 006bf0346dec..fe8e21ce3e3d 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -2550,7 +2550,7 @@ static void *tegra_pcie_ports_seq_start(struct seq_file *s, loff_t *pos)
 	if (list_empty(&pcie->ports))
 		return NULL;
 
-	seq_printf(s, "Index  Status\n");
+	seq_puts(s, "Index  Status\n");
 
 	return seq_list_start(&pcie->ports, *pos);
 }
@@ -2587,16 +2587,16 @@ static int tegra_pcie_ports_seq_show(struct seq_file *s, void *v)
 	seq_printf(s, "%2u     ", port->index);
 
 	if (up)
-		seq_printf(s, "up");
+		seq_puts(s, "up");
 
 	if (active) {
 		if (up)
-			seq_printf(s, ", ");
+			seq_puts(s, ", ");
 
-		seq_printf(s, "active");
+		seq_puts(s, "active");
 	}
 
-	seq_printf(s, "\n");
+	seq_puts(s, "\n");
 	return 0;
 }
 
-- 
2.30.2

