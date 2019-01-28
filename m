Return-Path: <SRS0=Vy8e=QE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A92AC282CD
	for <linux-pci@archiver.kernel.org>; Mon, 28 Jan 2019 11:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A99E21738
	for <linux-pci@archiver.kernel.org>; Mon, 28 Jan 2019 11:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfA1L5c (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 28 Jan 2019 06:57:32 -0500
Received: from mga14.intel.com ([192.55.52.115]:5439 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726661AbfA1L5b (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 28 Jan 2019 06:57:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jan 2019 03:57:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,534,1539673200"; 
   d="scan'208";a="138457351"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 28 Jan 2019 03:57:29 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id DCFB122D; Mon, 28 Jan 2019 13:57:28 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Russell Currey <ruscur@russell.cc>,
        Sam Bobroff <sbobroff@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] PCI/AER: use match_string() helper to simplify the code
Date:   Mon, 28 Jan 2019 13:57:28 +0200
Message-Id: <20190128115728.68240-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

match_string() returns the index of an array for a matching string,
which can be used intead of open coded implementation.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pci/pcie/aer.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index fed29de783e0..f8fc2114ad39 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -117,7 +117,7 @@ bool pci_aer_available(void)
 
 static int ecrc_policy = ECRC_POLICY_DEFAULT;
 
-static const char *ecrc_policy_str[] = {
+static const char * const ecrc_policy_str[] = {
 	[ECRC_POLICY_DEFAULT] = "bios",
 	[ECRC_POLICY_OFF] = "off",
 	[ECRC_POLICY_ON] = "on"
@@ -203,11 +203,8 @@ void pcie_ecrc_get_policy(char *str)
 {
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(ecrc_policy_str); i++)
-		if (!strncmp(str, ecrc_policy_str[i],
-			     strlen(ecrc_policy_str[i])))
-			break;
-	if (i >= ARRAY_SIZE(ecrc_policy_str))
+	i = match_string(ecrc_policy_str, ARRAY_SIZE(ecrc_policy_str), str);
+	if (i < 0)
 		return;
 
 	ecrc_policy = i;
-- 
2.20.1

