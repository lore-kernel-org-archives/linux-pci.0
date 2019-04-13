Return-Path: <SRS0=v2Vw=SP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C777C10F11
	for <linux-pci@archiver.kernel.org>; Sat, 13 Apr 2019 09:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58F672084E
	for <linux-pci@archiver.kernel.org>; Sat, 13 Apr 2019 09:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6pw8Dkj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfDMJNA (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 13 Apr 2019 05:13:00 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50208 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbfDMJNA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 13 Apr 2019 05:13:00 -0400
Received: by mail-wm1-f66.google.com with SMTP id z11so14145463wmi.0
        for <linux-pci@vger.kernel.org>; Sat, 13 Apr 2019 02:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Kzu+IErrOKTjkX/at7kkRf5eNsPGEAisB7hOvORvAyU=;
        b=G6pw8DkjdCPtUSYACZ74gGF+IEf8PhO+QbcUyc21rqTY0sKlEze106w3phMYiXO9hb
         rPvLLgFsT89heUTD/CfZqoqtHJnMe9Q/CpN41bsMIyOnRNLL44e8MvPbEJUgzTfX8aGf
         DP+P4Kb5TZDNusl/xHMvEfPdsoyKnjWHpjNo4HBPeYmH0FNH9lbMb+r4CpiU+2KK4srE
         TS12VgrCj806ZwCZ0UD7sSdAvYZOHj8mDApyPEt8tiLcXv1/BxXKxdvnadsvfKAKJRYZ
         +x1yJzF6R6qyEcVt7Vk7XIvHFyaQsXYgnzjezWHdjMegzQIjDBAwxWrYG1m0EPiaaTej
         ULyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Kzu+IErrOKTjkX/at7kkRf5eNsPGEAisB7hOvORvAyU=;
        b=G5BeXcCagnyKJgUTROIIcJyrEEE8iYdTsthcVeh6RBOM5HFPOU/v7o1H/knjhueVVq
         f+PJh181IMGC/bhiJ7P2wCNo12sqPERh5gkKVD9ep0IOYsas5kqLHQIrYQnSN01flV8X
         gqzF9UKpyjMgWZG5MWEvZzfeCBGZbXGZ73cG8zjLRcNi2M9KkUan79kftvHa1YQLlaAR
         VZHjznaIKSoIkrmnTODVnCbf2bQwthK+fTjOU9dNXO3z+2RkPQmrpEaAOQPn8mFQXA/f
         h9SAaVAKhzdFLLpPqsqCkWHdwFoNCfrIX5JAdfR6RZQQLG6ZQ8zMs+dZBqle+VmqFNlS
         UjEg==
X-Gm-Message-State: APjAAAWPVkkV2bIjow0j/catrsLSYkiK8S7OAcuIWmYwG0loPu62O3Rn
        QgF17vcBrWippuTUriVZr2i8qGcW
X-Google-Smtp-Source: APXvYqx5v3Li4tbnSipjN2K5bUquaUi5Q7AwCZdCfOBPFynul/TXpDNCGs7rp+YeQtyKAiBGxozlQA==
X-Received: by 2002:a1c:480b:: with SMTP id v11mr14098202wma.25.1555146777621;
        Sat, 13 Apr 2019 02:12:57 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:5700:6509:80dd:f4f:5628? (p200300EA8BD45700650980DD0F4F5628.dip0.t-ipconnect.de. [2003:ea:8bd4:5700:6509:80dd:f4f:5628])
        by smtp.googlemail.com with ESMTPSA id t17sm37173665wrr.26.2019.04.13.02.12.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Apr 2019 02:12:56 -0700 (PDT)
Subject: [PATCH RFC 1/3] PCI/ASPM: add L1 sub-state support to
 pci_disable_link_state
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Frederick Lawler <fred@fredlawl.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <e63cec92-cfb1-d0c4-f21e-350b4b289849@gmail.com>
Message-ID: <da8987d8-edf7-195d-6493-32bcac6b9a8c@gmail.com>
Date:   Sat, 13 Apr 2019 11:11:24 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <e63cec92-cfb1-d0c4-f21e-350b4b289849@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support for disabling states L1.1 and L1.2 to pci_disable_link_state.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/pci/pcie/aspm.c  | 13 ++++++++++---
 include/linux/pci-aspm.h |  8 +++++---
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index fd4cb7508..511f3e018 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -35,9 +35,9 @@
 #define ASPM_STATE_L1_1_PCIPM	(0x20)	/* PCI PM L1.1 state */
 #define ASPM_STATE_L1_2_PCIPM	(0x40)	/* PCI PM L1.2 state */
 #define ASPM_STATE_L1_SS_PCIPM	(ASPM_STATE_L1_1_PCIPM | ASPM_STATE_L1_2_PCIPM)
+#define ASPM_STATE_L1_1_MASK	(ASPM_STATE_L1_1 | ASPM_STATE_L1_1_PCIPM)
 #define ASPM_STATE_L1_2_MASK	(ASPM_STATE_L1_2 | ASPM_STATE_L1_2_PCIPM)
-#define ASPM_STATE_L1SS		(ASPM_STATE_L1_1 | ASPM_STATE_L1_1_PCIPM |\
-				 ASPM_STATE_L1_2_MASK)
+#define ASPM_STATE_L1SS		(ASPM_STATE_L1_1_MASK | ASPM_STATE_L1_2_MASK)
 #define ASPM_STATE_L0S		(ASPM_STATE_L0S_UP | ASPM_STATE_L0S_DW)
 #define ASPM_STATE_ALL		(ASPM_STATE_L0S | ASPM_STATE_L1 |	\
 				 ASPM_STATE_L1SS)
@@ -1094,8 +1094,15 @@ static void __pci_disable_link_state(struct pci_dev *pdev, int state, bool sem)
 	link = parent->link_state;
 	if (state & PCIE_LINK_STATE_L0S)
 		link->aspm_disable |= ASPM_STATE_L0S;
-	if (state & PCIE_LINK_STATE_L1)
+	if (state & PCIE_LINK_STATE_L1) {
 		link->aspm_disable |= ASPM_STATE_L1;
+		/* sub-states require L1 */
+		link->aspm_disable |= ASPM_STATE_L1SS;
+	}
+	if (state & PCIE_LINK_STATE_L1_1)
+		link->aspm_disable |= ASPM_STATE_L1_1_MASK;
+	if (state & PCIE_LINK_STATE_L1_2)
+		link->aspm_disable |= ASPM_STATE_L1_2_MASK;
 	pcie_config_aspm_link(link, policy_to_aspm_state(link));
 
 	if (state & PCIE_LINK_STATE_CLKPM) {
diff --git a/include/linux/pci-aspm.h b/include/linux/pci-aspm.h
index df28af5ce..e66c3e3d8 100644
--- a/include/linux/pci-aspm.h
+++ b/include/linux/pci-aspm.h
@@ -19,9 +19,11 @@
 
 #include <linux/pci.h>
 
-#define PCIE_LINK_STATE_L0S	1
-#define PCIE_LINK_STATE_L1	2
-#define PCIE_LINK_STATE_CLKPM	4
+#define PCIE_LINK_STATE_L0S	BIT(0)
+#define PCIE_LINK_STATE_L1	BIT(1)
+#define PCIE_LINK_STATE_CLKPM	BIT(2)
+#define PCIE_LINK_STATE_L1_1	BIT(3)
+#define PCIE_LINK_STATE_L1_2	BIT(4)
 
 #ifdef CONFIG_PCIEASPM
 void pci_disable_link_state(struct pci_dev *pdev, int state);
-- 
2.21.0


