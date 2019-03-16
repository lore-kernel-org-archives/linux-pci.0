Return-Path: <SRS0=C1I9=RT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07556C43381
	for <linux-pci@archiver.kernel.org>; Sat, 16 Mar 2019 21:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC123218D0
	for <linux-pci@archiver.kernel.org>; Sat, 16 Mar 2019 21:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbfCPVkd (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 16 Mar 2019 17:40:33 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39336 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbfCPVkc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Mar 2019 17:40:32 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1h5H2O-0004lx-Lx; Sat, 16 Mar 2019 21:40:16 +0000
From:   Colin King <colin.king@canonical.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hotplug/drc-info: ininitialize fndit to zero
Date:   Sat, 16 Mar 2019 21:40:16 +0000
Message-Id: <20190316214016.6612-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently variable fndit is not initialized and contains a
garbage value, later it is set to 1 if a drc entry is found.
Ensure fndit is not containing garbage by initializing it to
zero. Also remove an extraneous space at the end of an
sprintf call.

Detected by static analysis with cppcheck.

Fixes: 2fcf3ae508c2 ("hotplug/drc-info: Add code to search ibm,drc-info property")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/pci/hotplug/rpaphp_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/rpaphp_core.c b/drivers/pci/hotplug/rpaphp_core.c
index bcd5d357ca23..28213f44f64a 100644
--- a/drivers/pci/hotplug/rpaphp_core.c
+++ b/drivers/pci/hotplug/rpaphp_core.c
@@ -230,7 +230,7 @@ static int rpaphp_check_drc_props_v2(struct device_node *dn, char *drc_name,
 	struct of_drc_info drc;
 	const __be32 *value;
 	char cell_drc_name[MAX_DRC_NAME_LEN];
-	int j, fndit;
+	int j, fndit = 0;
 
 	info = of_find_property(dn->parent, "ibm,drc-info", NULL);
 	if (info == NULL)
@@ -254,7 +254,7 @@ static int rpaphp_check_drc_props_v2(struct device_node *dn, char *drc_name,
 	/* Found it */
 
 	if (fndit)
-		sprintf(cell_drc_name, "%s%d", drc.drc_name_prefix, 
+		sprintf(cell_drc_name, "%s%d", drc.drc_name_prefix,
 			my_index);
 
 	if (((drc_name == NULL) ||
-- 
2.20.1

