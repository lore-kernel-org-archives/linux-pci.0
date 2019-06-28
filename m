Return-Path: <SRS0=A/dU=U3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E4FC4321A
	for <linux-pci@archiver.kernel.org>; Fri, 28 Jun 2019 13:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 159442083B
	for <linux-pci@archiver.kernel.org>; Fri, 28 Jun 2019 13:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfF1NMW (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 28 Jun 2019 09:12:22 -0400
Received: from mga11.intel.com ([192.55.52.93]:24434 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726587AbfF1NMW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 28 Jun 2019 09:12:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jun 2019 06:12:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,427,1557212400"; 
   d="scan'208";a="314131362"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 28 Jun 2019 06:12:19 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 13F551A3; Fri, 28 Jun 2019 16:12:19 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-pci@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jean-Jacques Hiblot <jjhiblot@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v1 1/2] tools: PCI: Fix compilation error
Date:   Fri, 28 Jun 2019 16:12:17 +0300
Message-Id: <20190628131218.10244-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The commit

  b71f0a0b1e3f ("tools: PCI: Exit with error code when test fails")

forgot to update function prototype and thus brought a regression:

pcitest.c:221:9: error: void value not ignored as it ought to be
 return run_test(test);
        ^~~~~~~~~~~~~~

Fix it by changing prototype from void to int.

While here, initialize ret with 0 to avoid compiler warning:

pcitest.c:132:25: warning: ‘ret’ may be used uninitialized in this function [-Wmaybe-uninitialized]

Fixes: b71f0a0b1e3f ("tools: PCI: Exit with error code when test fails")
Cc: Jean-Jacques Hiblot <jjhiblot@ti.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 tools/pci/pcitest.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/pci/pcitest.c b/tools/pci/pcitest.c
index cb7a47dfd8b6..81b89260e80f 100644
--- a/tools/pci/pcitest.c
+++ b/tools/pci/pcitest.c
@@ -36,15 +36,15 @@ struct pci_test {
 	unsigned long	size;
 };
 
-static void run_test(struct pci_test *test)
+static int run_test(struct pci_test *test)
 {
-	long ret;
+	long ret = 0;
 	int fd;
 
 	fd = open(test->device, O_RDWR);
 	if (fd < 0) {
 		perror("can't open PCI Endpoint Test device");
-		return;
+		return fd;
 	}
 
 	if (test->barnum >= 0 && test->barnum <= 5) {
@@ -129,7 +129,7 @@ static void run_test(struct pci_test *test)
 	}
 
 	fflush(stdout);
-	return (ret < 0) ? ret : 1 - ret; /* return 0 if test succeeded */
+	return (ret < 0) ? ret : 0; /* return 0 if test succeeded */
 }
 
 int main(int argc, char **argv)
-- 
2.20.1

