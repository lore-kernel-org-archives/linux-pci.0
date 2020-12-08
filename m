Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAEFAC4361B
	for <linux-pci@archiver.kernel.org>; Tue,  8 Dec 2020 08:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9549923A60
	for <linux-pci@archiver.kernel.org>; Tue,  8 Dec 2020 08:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbgLHI0g (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 8 Dec 2020 03:26:36 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:34653 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbgLHI0g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Dec 2020 03:26:36 -0500
Received: from 36-229-231-79.dynamic-ip.hinet.net ([36.229.231.79] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kmYJg-0007bw-Pq; Tue, 08 Dec 2020 08:25:49 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     bhelgaas@google.com
Cc:     hkallweit1@gmail.com, Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] PCI/ASPM: Use capability to override ASPM via sysfs
Date:   Tue,  8 Dec 2020 16:25:34 +0800
Message-Id: <20201208082534.2460215-2-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201208082534.2460215-1-kai.heng.feng@canonical.com>
References: <20201208082534.2460215-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If we are to use sysfs to change ASPM settings, we may want to override
the default ASPM policy.

So use ASPM capability, instead of default policy, to be able to use all
possible ASPM states.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/pci/pcie/aspm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 2ea9fddadfad..326da7bbc84d 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1239,8 +1239,7 @@ static ssize_t aspm_attr_store_common(struct device *dev,
 
 		link->aspm_disable |= state;
 	}
-
-	pcie_config_aspm_link(link, policy_to_aspm_state(link));
+	pcie_config_aspm_link(link, link->aspm_capable);
 
 	mutex_unlock(&aspm_lock);
 	up_read(&pci_bus_sem);
-- 
2.29.2

