Return-Path: <SRS0=4zPb=NS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C2AC0044C
	for <linux-pci@archiver.kernel.org>; Wed,  7 Nov 2018 20:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C639B20896
	for <linux-pci@archiver.kernel.org>; Wed,  7 Nov 2018 20:45:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C639B20896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727396AbeKHGRl (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 8 Nov 2018 01:17:41 -0500
Received: from terminus.zytor.com ([198.137.202.136]:51753 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbeKHGRj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Nov 2018 01:17:39 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wA7KibZg1607948
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 7 Nov 2018 12:44:37 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wA7Kib6S1607945;
        Wed, 7 Nov 2018 12:44:37 -0800
Date:   Wed, 7 Nov 2018 12:44:37 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Woods, Brian" <tipbot@zytor.com>
Message-ID: <tip-210ba1201ff950b3d05bfd8fa5d47540cea393c0@git.kernel.org>
Cc:     bhelgaas@google.com, mingo@redhat.com, bp@suse.de,
        linux-kernel@vger.kernel.org, hpa@zytor.com, x86@kernel.org,
        linux@roeck-us.net, puwen@hygon.cn, tglx@linutronix.de,
        linux-pci@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Brian.Woods@amd.com, mingo@kernel.org, brian.woods@amd.com,
        qianyue.zj@alibaba-inc.com, jdelvare@suse.com, clemens@ladisch.de
Reply-To: tglx@linutronix.de, linux-hwmon@vger.kernel.org,
          linux-pci@vger.kernel.org, mingo@kernel.org, brian.woods@amd.com,
          Brian.Woods@amd.com, clemens@ladisch.de, jdelvare@suse.com,
          qianyue.zj@alibaba-inc.com, bhelgaas@google.com,
          mingo@redhat.com, hpa@zytor.com, x86@kernel.org, bp@suse.de,
          linux-kernel@vger.kernel.org, puwen@hygon.cn, linux@roeck-us.net
In-Reply-To: <20181106200754.60722-5-brian.woods@amd.com>
References: <20181106200754.60722-5-brian.woods@amd.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/amd-nb] hwmon/k10temp: Add support for AMD family 17h,
 model 30h CPUs
Git-Commit-ID: 210ba1201ff950b3d05bfd8fa5d47540cea393c0
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

Commit-ID:  210ba1201ff950b3d05bfd8fa5d47540cea393c0
Gitweb:     https://git.kernel.org/tip/210ba1201ff950b3d05bfd8fa5d47540cea393c0
Author:     Woods, Brian <Brian.Woods@amd.com>
AuthorDate: Tue, 6 Nov 2018 20:08:21 +0000
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 7 Nov 2018 21:39:13 +0100

hwmon/k10temp: Add support for AMD family 17h, model 30h CPUs

Add support for AMD family 17h model 30h processors for k10temp. Model
30h is functionally the same as model 01h processors (as far as k10temp
is concerned), just the PCI device IDs need to be updated.

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
Link: http://lkml.kernel.org/r/20181106200754.60722-5-brian.woods@amd.com
---
 drivers/hwmon/k10temp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index bc6871c8dd4e..9790f1f5eb98 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -360,6 +360,7 @@ static const struct pci_device_id k10temp_id_table[] = {
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_16H_M30H_NB_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M10H_DF_F3) },
+	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M30H_DF_F3) },
 	{}
 };
 MODULE_DEVICE_TABLE(pci, k10temp_id_table);
