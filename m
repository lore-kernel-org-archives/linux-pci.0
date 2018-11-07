Return-Path: <SRS0=4zPb=NS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 026C9C0044C
	for <linux-pci@archiver.kernel.org>; Wed,  7 Nov 2018 20:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B96AA20818
	for <linux-pci@archiver.kernel.org>; Wed,  7 Nov 2018 20:44:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B96AA20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbeKHGQO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 8 Nov 2018 01:16:14 -0500
Received: from terminus.zytor.com ([198.137.202.136]:43379 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbeKHGQO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Nov 2018 01:16:14 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wA7Kgurb1606004
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 7 Nov 2018 12:42:56 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wA7KgrGp1605994;
        Wed, 7 Nov 2018 12:42:53 -0800
Date:   Wed, 7 Nov 2018 12:42:53 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Woods, Brian" <tipbot@zytor.com>
Message-ID: <tip-dedf7dce4cec5c0abe69f4fa6938d5100398220b@git.kernel.org>
Cc:     bp@suse.de, puwen@hygon.cn, linux@roeck-us.net,
        bhelgaas@google.com, clemens@ladisch.de, x86@kernel.org,
        linux-hwmon@vger.kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, qianyue.zj@alibaba-inc.com,
        jdelvare@suse.com, linux-pci@vger.kernel.org, brian.woods@amd.com,
        tglx@linutronix.de, hpa@zytor.com, Brian.Woods@amd.com,
        mingo@redhat.com
Reply-To: linux@roeck-us.net, bhelgaas@google.com, bp@suse.de,
          puwen@hygon.cn, clemens@ladisch.de, mingo@kernel.org,
          linux-hwmon@vger.kernel.org, x86@kernel.org,
          qianyue.zj@alibaba-inc.com, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, brian.woods@amd.com,
          linux-pci@vger.kernel.org, jdelvare@suse.com, hpa@zytor.com,
          mingo@redhat.com, Brian.Woods@amd.com
In-Reply-To: <20181106200754.60722-2-brian.woods@amd.com>
References: <20181106200754.60722-2-brian.woods@amd.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/amd-nb] hwmon/k10temp, x86/amd_nb: Consolidate shared
 device IDs
Git-Commit-ID: dedf7dce4cec5c0abe69f4fa6938d5100398220b
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

Commit-ID:  dedf7dce4cec5c0abe69f4fa6938d5100398220b
Gitweb:     https://git.kernel.org/tip/dedf7dce4cec5c0abe69f4fa6938d5100398220b
Author:     Woods, Brian <Brian.Woods@amd.com>
AuthorDate: Tue, 6 Nov 2018 20:08:14 +0000
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 7 Nov 2018 21:28:04 +0100

hwmon/k10temp, x86/amd_nb: Consolidate shared device IDs

Consolidate shared PCI_DEVICE_IDs that were scattered through k10temp
and amd_nb, and move them into pci_ids.

Signed-off-by: Brian Woods <brian.woods@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Guenter Roeck <linux@roeck-us.net>
CC: Bjorn Helgaas <bhelgaas@google.com>
CC: Clemens Ladisch <clemens@ladisch.de>
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: Ingo Molnar <mingo@redhat.com>
CC: Jean Delvare <jdelvare@suse.com>
CC: Jia Zhang <qianyue.zj@alibaba-inc.com>
CC: <linux-hwmon@vger.kernel.org>
CC: <linux-pci@vger.kernel.org>
CC: Pu Wen <puwen@hygon.cn>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: x86-ml <x86@kernel.org>
Link: http://lkml.kernel.org/r/20181106200754.60722-2-brian.woods@amd.com
---
 arch/x86/kernel/amd_nb.c | 3 +--
 drivers/hwmon/k10temp.c  | 9 +--------
 include/linux/pci_ids.h  | 2 ++
 3 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index a6eca647bc76..19d489ee2b1e 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -11,13 +11,12 @@
 #include <linux/errno.h>
 #include <linux/export.h>
 #include <linux/spinlock.h>
+#include <linux/pci_ids.h>
 #include <asm/amd_nb.h>
 
 #define PCI_DEVICE_ID_AMD_17H_ROOT	0x1450
 #define PCI_DEVICE_ID_AMD_17H_M10H_ROOT	0x15d0
-#define PCI_DEVICE_ID_AMD_17H_DF_F3	0x1463
 #define PCI_DEVICE_ID_AMD_17H_DF_F4	0x1464
-#define PCI_DEVICE_ID_AMD_17H_M10H_DF_F3 0x15eb
 #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F4 0x15ec
 
 /* Protect the PCI config register pairs used for SMN and DF indirect access. */
diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 2cef0c37ff6f..bc6871c8dd4e 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -23,6 +23,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/pci_ids.h>
 #include <asm/amd_nb.h>
 #include <asm/processor.h>
 
@@ -41,14 +42,6 @@ static DEFINE_MUTEX(nb_smu_ind_mutex);
 #define PCI_DEVICE_ID_AMD_15H_M70H_NB_F3	0x15b3
 #endif
 
-#ifndef PCI_DEVICE_ID_AMD_17H_DF_F3
-#define PCI_DEVICE_ID_AMD_17H_DF_F3	0x1463
-#endif
-
-#ifndef PCI_DEVICE_ID_AMD_17H_M10H_DF_F3
-#define PCI_DEVICE_ID_AMD_17H_M10H_DF_F3	0x15eb
-#endif
-
 /* CPUID function 0x80000001, ebx */
 #define CPUID_PKGTYPE_MASK	0xf0000000
 #define CPUID_PKGTYPE_F		0x00000000
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 69f0abe1ba1a..78d5cd29778a 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -545,6 +545,8 @@
 #define PCI_DEVICE_ID_AMD_16H_NB_F4	0x1534
 #define PCI_DEVICE_ID_AMD_16H_M30H_NB_F3 0x1583
 #define PCI_DEVICE_ID_AMD_16H_M30H_NB_F4 0x1584
+#define PCI_DEVICE_ID_AMD_17H_DF_F3	0x1463
+#define PCI_DEVICE_ID_AMD_17H_M10H_DF_F3 0x15eb
 #define PCI_DEVICE_ID_AMD_CNB17H_F3	0x1703
 #define PCI_DEVICE_ID_AMD_LANCE		0x2000
 #define PCI_DEVICE_ID_AMD_LANCE_HOME	0x2001
