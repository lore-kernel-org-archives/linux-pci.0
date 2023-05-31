Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD32C77B7C
	for <linux-pci@archiver.kernel.org>; Wed, 31 May 2023 10:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235874AbjEaKNs (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 31 May 2023 06:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbjEaKNj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 May 2023 06:13:39 -0400
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC78129
        for <linux-pci@vger.kernel.org>; Wed, 31 May 2023 03:13:31 -0700 (PDT)
Received: from [167.98.27.226] (helo=rainbowdash)
        by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
        id 1q4I1C-0086KL-Jl; Wed, 31 May 2023 10:21:23 +0100
Received: from ben by rainbowdash with local (Exim 4.96)
        (envelope-from <ben@rainbowdash>)
        id 1q4I1C-001DuC-25;
        Wed, 31 May 2023 10:21:22 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        bhelgaas@google.com
Cc:     Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
        Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>,
        Jude Onyenegecha <jude.onyenegecha@codethink.co.uk>,
        Greentime Hu <greentime.hu@sifive.com>,
        Jeegar Lakhani <jeegar.lakhani@sifive.com>,
        Ben Dooks <ben.dooks@sifive.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH 1/2] PCI: of: update max-link-speed for gen5 links
Date:   Wed, 31 May 2023 10:21:20 +0100
Message-Id: <20230531092121.291770-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ben Dooks <ben.dooks@sifive.com>

Update max-link-speed to be up to 6, for newer systems that could have
up to gen6 pci describe in device-tree.

Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/pci/of.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 2c25f4fa0225..da0cc01e923e 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -639,7 +639,7 @@ int of_pci_get_max_link_speed(struct device_node *node)
 	u32 max_link_speed;
 
 	if (of_property_read_u32(node, "max-link-speed", &max_link_speed) ||
-	    max_link_speed == 0 || max_link_speed > 4)
+	    max_link_speed == 0 || max_link_speed > 6)
 		return -EINVAL;
 
 	return max_link_speed;
-- 
2.39.2

