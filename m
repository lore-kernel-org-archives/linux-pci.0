Return-Path: <SRS0=4zPb=NS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5961C0044C
	for <linux-pci@archiver.kernel.org>; Wed,  7 Nov 2018 20:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8348920818
	for <linux-pci@archiver.kernel.org>; Wed,  7 Nov 2018 20:45:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8348920818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbeKHGRM (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 8 Nov 2018 01:17:12 -0500
Received: from terminus.zytor.com ([198.137.202.136]:46581 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbeKHGRM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Nov 2018 01:17:12 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wA7Ki3Gx1606366
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 7 Nov 2018 12:44:03 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wA7Ki37i1606360;
        Wed, 7 Nov 2018 12:44:03 -0800
Date:   Wed, 7 Nov 2018 12:44:03 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Woods, Brian" <tipbot@zytor.com>
Message-ID: <tip-be3518a16ef270e3b030a6ae96055f83f51bd3dd@git.kernel.org>
Cc:     mingo@kernel.org, x86@kernel.org, tglx@linutronix.de,
        linux-pci@vger.kernel.org, mingo@redhat.com, puwen@hygon.cn,
        bp@suse.de, linux-hwmon@vger.kernel.org, jdelvare@suse.com,
        brian.woods@amd.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
        clemens@ladisch.de, linux@roeck-us.net, bhelgaas@google.com,
        qianyue.zj@alibaba-inc.com, Brian.Woods@amd.com
Reply-To: puwen@hygon.cn, tglx@linutronix.de, mingo@redhat.com,
          linux-pci@vger.kernel.org, mingo@kernel.org, x86@kernel.org,
          jdelvare@suse.com, linux-hwmon@vger.kernel.org, bp@suse.de,
          brian.woods@amd.com, hpa@zytor.com, bhelgaas@google.com,
          linux@roeck-us.net, linux-kernel@vger.kernel.org,
          clemens@ladisch.de, qianyue.zj@alibaba-inc.com,
          Brian.Woods@amd.com
In-Reply-To: <20181106200754.60722-4-brian.woods@amd.com>
References: <20181106200754.60722-4-brian.woods@amd.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/amd-nb] x86/amd_nb: Add PCI device IDs for family 17h,
 model 30h
Git-Commit-ID: be3518a16ef270e3b030a6ae96055f83f51bd3dd
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

Commit-ID:  be3518a16ef270e3b030a6ae96055f83f51bd3dd
Gitweb:     https://git.kernel.org/tip/be3518a16ef270e3b030a6ae96055f83f51bd3dd
Author:     Woods, Brian <Brian.Woods@amd.com>
AuthorDate: Tue, 6 Nov 2018 20:08:18 +0000
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 7 Nov 2018 21:36:09 +0100

x86/amd_nb: Add PCI device IDs for family 17h, model 30h

Add the PCI device IDs for family 17h model 30h, since they are needed
for accessing various registers via the data fabric/SMN interface.

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
Link: http://lkml.kernel.org/r/20181106200754.60722-4-brian.woods@amd.com
---
 arch/x86/kernel/amd_nb.c | 6 ++++++
 include/linux/pci_ids.h  | 1 +
 2 files changed, 7 insertions(+)

diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index cc34266e3c62..cc51275c8759 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -16,8 +16,10 @@
 
 #define PCI_DEVICE_ID_AMD_17H_ROOT	0x1450
 #define PCI_DEVICE_ID_AMD_17H_M10H_ROOT	0x15d0
+#define PCI_DEVICE_ID_AMD_17H_M30H_ROOT	0x1480
 #define PCI_DEVICE_ID_AMD_17H_DF_F4	0x1464
 #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F4 0x15ec
+#define PCI_DEVICE_ID_AMD_17H_M30H_DF_F4 0x1494
 
 /* Protect the PCI config register pairs used for SMN and DF indirect access. */
 static DEFINE_MUTEX(smn_mutex);
@@ -27,9 +29,11 @@ static u32 *flush_words;
 static const struct pci_device_id amd_root_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_ROOT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M10H_ROOT) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M30H_ROOT) },
 	{}
 };
 
+
 #define PCI_DEVICE_ID_AMD_CNB17H_F4     0x1704
 
 const struct pci_device_id amd_nb_misc_ids[] = {
@@ -43,6 +47,7 @@ const struct pci_device_id amd_nb_misc_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_16H_M30H_NB_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M10H_DF_F3) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M30H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F3) },
 	{}
 };
@@ -56,6 +61,7 @@ static const struct pci_device_id amd_nb_link_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_16H_M30H_NB_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M10H_DF_F4) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M30H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F4) },
 	{}
 };
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 78d5cd29778a..349276fbd269 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -547,6 +547,7 @@
 #define PCI_DEVICE_ID_AMD_16H_M30H_NB_F4 0x1584
 #define PCI_DEVICE_ID_AMD_17H_DF_F3	0x1463
 #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F3 0x15eb
+#define PCI_DEVICE_ID_AMD_17H_M30H_DF_F3 0x1493
 #define PCI_DEVICE_ID_AMD_CNB17H_F3	0x1703
 #define PCI_DEVICE_ID_AMD_LANCE		0x2000
 #define PCI_DEVICE_ID_AMD_LANCE_HOME	0x2001
