Return-Path: <SRS0=4zPb=NS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_SBL,
	URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C0FC0044C
	for <linux-pci@archiver.kernel.org>; Wed,  7 Nov 2018 20:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E4FF20818
	for <linux-pci@archiver.kernel.org>; Wed,  7 Nov 2018 20:44:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E4FF20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbeKHGQd (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 8 Nov 2018 01:16:33 -0500
Received: from terminus.zytor.com ([198.137.202.136]:33125 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbeKHGQc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Nov 2018 01:16:32 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wA7KhTPA1606141
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 7 Nov 2018 12:43:29 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wA7KhTMr1606137;
        Wed, 7 Nov 2018 12:43:29 -0800
Date:   Wed, 7 Nov 2018 12:43:29 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Woods, Brian" <tipbot@zytor.com>
Message-ID: <tip-556e4c62baffa71e2045a298379db7e57dd47f3d@git.kernel.org>
Cc:     tglx@linutronix.de, hpa@zytor.com, linux-pci@vger.kernel.org,
        bhelgaas@google.com, linux-hwmon@vger.kernel.org,
        qianyue.zj@alibaba-inc.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, x86@kernel.org, clemens@ladisch.de,
        jdelvare@suse.com, mingo@redhat.com, linux@roeck-us.net,
        brian.woods@amd.com, puwen@hygon.cn, Brian.Woods@amd.com,
        bp@suse.de
Reply-To: bp@suse.de, Brian.Woods@amd.com, puwen@hygon.cn,
          brian.woods@amd.com, linux@roeck-us.net, mingo@redhat.com,
          jdelvare@suse.com, clemens@ladisch.de, x86@kernel.org,
          mingo@kernel.org, linux-kernel@vger.kernel.org,
          qianyue.zj@alibaba-inc.com, linux-hwmon@vger.kernel.org,
          bhelgaas@google.com, hpa@zytor.com, linux-pci@vger.kernel.org,
          tglx@linutronix.de
In-Reply-To: <20181106200754.60722-3-brian.woods@amd.com>
References: <20181106200754.60722-3-brian.woods@amd.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/amd-nb] x86/amd_nb: Add support for newer PCI topologies
Git-Commit-ID: 556e4c62baffa71e2045a298379db7e57dd47f3d
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Commit-ID:  556e4c62baffa71e2045a298379db7e57dd47f3d
Gitweb:     https://git.kernel.org/tip/556e4c62baffa71e2045a298379db7e57dd47f3d
Author:     Woods, Brian <Brian.Woods@amd.com>
AuthorDate: Tue, 6 Nov 2018 20:08:16 +0000
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 7 Nov 2018 21:28:29 +0100

x86/amd_nb: Add support for newer PCI topologies

Add support for new processors which have multiple PCI root complexes
per data fabric/system management network interface.  If there are (N)
multiple PCI roots per DF/SMN interface, then the PCI roots are
redundant (as far as SMN/DF access goes).  For each DF/SMN interface:
map to the first available PCI root and skip the next N-1 PCI roots so
the following DF/SMN interface get mapped to a correct PCI root.

Ex:
DF/SMN 0 -> 60
	    40
	    20
	    00
DF/SMN 1 -> e0
	    c0
	    a0
	    80

Signed-off-by: Brian Woods <brian.woods@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
CC: Bjorn Helgaas <bhelgaas@google.com>
CC: Clemens Ladisch <clemens@ladisch.de>
CC: Guenter Roeck <linux@roeck-us.net>
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: Ingo Molnar <mingo@redhat.com>
CC: Jean Delvare <jdelvare@suse.com>
CC: Jia Zhang <qianyue.zj@alibaba-inc.com>
CC: <linux-hwmon@vger.kernel.org>
CC: <linux-pci@vger.kernel.org>
CC: Pu Wen <puwen@hygon.cn>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: x86-ml <x86@kernel.org>
Link: http://lkml.kernel.org/r/20181106200754.60722-3-brian.woods@amd.com
---
 arch/x86/kernel/amd_nb.c | 44 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 38 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 19d489ee2b1e..cc34266e3c62 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -213,7 +213,10 @@ int amd_cache_northbridges(void)
 	const struct pci_device_id *root_ids = amd_root_ids;
 	struct pci_dev *root, *misc, *link;
 	struct amd_northbridge *nb;
-	u16 i = 0;
+	u16 roots_per_misc = 0;
+	u16 misc_count = 0;
+	u16 root_count = 0;
+	u16 i, j;
 
 	if (amd_northbridges.num)
 		return 0;
@@ -226,26 +229,55 @@ int amd_cache_northbridges(void)
 
 	misc = NULL;
 	while ((misc = next_northbridge(misc, misc_ids)) != NULL)
-		i++;
+		misc_count++;
 
-	if (!i)
+	if (!misc_count)
 		return -ENODEV;
 
-	nb = kcalloc(i, sizeof(struct amd_northbridge), GFP_KERNEL);
+	root = NULL;
+	while ((root = next_northbridge(root, root_ids)) != NULL)
+		root_count++;
+
+	if (root_count) {
+		roots_per_misc = root_count / misc_count;
+
+		/*
+		 * There should be _exactly_ N roots for each DF/SMN
+		 * interface.
+		 */
+		if (!roots_per_misc || (root_count % roots_per_misc)) {
+			pr_info("Unsupported AMD DF/PCI configuration found\n");
+			return -ENODEV;
+		}
+	}
+
+	nb = kcalloc(misc_count, sizeof(struct amd_northbridge), GFP_KERNEL);
 	if (!nb)
 		return -ENOMEM;
 
 	amd_northbridges.nb = nb;
-	amd_northbridges.num = i;
+	amd_northbridges.num = misc_count;
 
 	link = misc = root = NULL;
-	for (i = 0; i != amd_northbridges.num; i++) {
+	for (i = 0; i < amd_northbridges.num; i++) {
 		node_to_amd_nb(i)->root = root =
 			next_northbridge(root, root_ids);
 		node_to_amd_nb(i)->misc = misc =
 			next_northbridge(misc, misc_ids);
 		node_to_amd_nb(i)->link = link =
 			next_northbridge(link, link_ids);
+
+		/*
+		 * If there are more PCI root devices than data fabric/
+		 * system management network interfaces, then the (N)
+		 * PCI roots per DF/SMN interface are functionally the
+		 * same (for DF/SMN access) and N-1 are redundant.  N-1
+		 * PCI roots should be skipped per DF/SMN interface so
+		 * the following DF/SMN interfaces get mapped to
+		 * correct PCI roots.
+		 */
+		for (j = 1; j < roots_per_misc; j++)
+			root = next_northbridge(root, root_ids);
 	}
 
 	if (amd_gart_present())
