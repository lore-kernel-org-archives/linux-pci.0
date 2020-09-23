Return-Path: <SRS0=O37L=DB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C547C2D0A8
	for <linux-pci@archiver.kernel.org>; Thu, 24 Sep 2020 00:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D14B2208B8
	for <linux-pci@archiver.kernel.org>; Thu, 24 Sep 2020 00:14:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGN6lnH+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbgIXAO7 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 23 Sep 2020 20:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgIXAO6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Sep 2020 20:14:58 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FA0C0613CE
        for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2020 17:14:58 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id gr14so2069175ejb.1
        for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2020 17:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4Z+X4UnmNs9kD39hWhQQ29DlHXSDN88jSqF5HIVTFMw=;
        b=dGN6lnH+GDPI1sZ2NM5G+LxhJZcvfo+tBNtz9CDTNy53UPEffCa3lBgx6uwHeDIX0c
         Lvj+gGx1xzgZOJkrC2KHz485kUosvFF/f5SgUwkxNRB5MHcfSPThyfxpNCgZ4D5Uc44G
         NLaJLaIRLhWVKwg1E+OZL18Wo5rRmXTEAmVhxFSrKvuPBoMOuUKiZzXkjdVDRkDI1kIZ
         ZbkcBzoXD0UOKw29doACQ+GqSMUoLp2rkZCYwsywzBkgUG9K7InmdJ33VRpjgtmQ2BYC
         h2RdmFjXcOuzi5SO0O0Dn5NntHrwhu2gD7CB2XaIG0thesKkBlDZGHJNDEBjiK4Qvyhw
         +owg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4Z+X4UnmNs9kD39hWhQQ29DlHXSDN88jSqF5HIVTFMw=;
        b=gb9xr1NxN8DAxDB1gK9HtrMTPzchABD3HZ/kksQAlsv81Ft5uG5izg7SbkipoL5KbG
         9+qJhCr7KUG/rg74TZO7bZqgXBr3kzJ+dDAQorIL7CcY+TXmxvaaQOB1UmYmQfKnBpaP
         apMHMfzlqJ1hzxbIta+l4bEYN0bPJXCj8FML0YbqovQmao2cC2BzQp+TlU8tztcB7Sab
         GvPHAAXB2w3Sv7uEsZcwtaVHuEtg3q+5GApnu8sEJCo85tOB6iVBTA8YzW6mrxIBRPgl
         0XTxcpUkCmiDt/9+qkc4LlpDMOVNDheSbh7PHG0yLI02FoPahxebCLxm6GKQvbrMhowQ
         ES7Q==
X-Gm-Message-State: AOAM5336606BPHoQSlhlJhRD4AUTl+PSKCor9L92rjLa/Vhb9TukEPKQ
        nqepFeevCVQ74f756Xwk0k8=
X-Google-Smtp-Source: ABdhPJwlEEipqvI0Ik7ygmIg2WsYBFmyVEweArROoYHWBpY02XQZOJdDs4TuUfcLhBn2AmlfncirXA==
X-Received: by 2002:a17:906:82c1:: with SMTP id a1mr2043821ejy.270.1600906497220;
        Wed, 23 Sep 2020 17:14:57 -0700 (PDT)
Received: from net.saheed (5402C65D.dsl.pool.telekom.hu. [84.2.198.93])
        by smtp.gmail.com with ESMTPSA id r9sm1026559ejc.102.2020.09.23.17.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 17:14:56 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH 7/8] PCI/ASPM: Remove pcie_get_aspm_reg() and struct aspm_register_info
Date:   Thu, 24 Sep 2020 01:15:16 +0200
Message-Id: <20200923231517.221310-8-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20200923231517.221310-1-refactormyself@gmail.com>
References: <20200923231517.221310-1-refactormyself@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Two of aspm_calc_l1ss_info()'s arguments are now redundant. All members
of struct aspm_register_info are now calculated directly, so both the
struct and pcie_get_aspm_reg() are now useless.

 - Remove redundant arguments in aspm_calc_l1ss_info().
 - Refactor callers to also remove redundant parameters
 - Remove any remaining call to pcie_get_aspm_reg()
 - Remove pcie_get_aspm_reg()
 - Remove remaining reference to struct aspm_register_info.
 - Remove struct aspm_register_info

Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
---
 drivers/pci/pcie/aspm.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index e43fdf0cd08c..f4fc2d65240c 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -382,17 +382,6 @@ static void encode_l12_threshold(u32 threshold_us, u32 *scale, u32 *value)
 	}
 }
 
-struct aspm_register_info {
-};
-
-static void pcie_get_aspm_reg(struct pci_dev *pdev,
-			      struct aspm_register_info *info)
-{
-	u16 ctl;
-
-	pcie_capability_read_word(pdev, PCI_EXP_LNKCTL, &ctl);
-}
-
 static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 {
 	u32 latency, l1_switch_latency = 0;
@@ -455,9 +444,7 @@ static struct pci_dev *pci_function_0(struct pci_bus *linkbus)
 }
 
 /* Calculate L1.2 PM substate timing parameters */
-static void aspm_calc_l1ss_info(struct pcie_link_state *link,
-				struct aspm_register_info *upreg,
-				struct aspm_register_info *dwreg)
+static void aspm_calc_l1ss_info(struct pcie_link_state *link)
 {
 	u32 val1, val2, scale1, scale2;
 	u32 t_common_mode, t_power_on, l1_2_threshold, scale, value;
@@ -523,7 +510,6 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 {
 	struct pci_dev *child = link->downstream, *parent = link->pdev;
 	struct pci_bus *linkbus = parent->subordinate;
-	struct aspm_register_info upreg, dwreg;
 	u32 up_l1ss_ctl1, dw_l1ss_ctl1;
 
 	if (blacklist) {
@@ -595,7 +581,7 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 		link->aspm_enabled |= ASPM_STATE_L1_2_PCIPM;
 
 	if (link->aspm_support & ASPM_STATE_L1SS)
-		aspm_calc_l1ss_info(link, &upreg, &dwreg);
+		aspm_calc_l1ss_info(link);
 
 	/* Save default state */
 	link->aspm_default = link->aspm_enabled;
-- 
2.18.4

