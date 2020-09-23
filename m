Return-Path: <SRS0=O37L=DB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFBBC4363D
	for <linux-pci@archiver.kernel.org>; Thu, 24 Sep 2020 00:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA10E20936
	for <linux-pci@archiver.kernel.org>; Thu, 24 Sep 2020 00:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NlG93Op1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbgIXAOu (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 23 Sep 2020 20:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgIXAOu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Sep 2020 20:14:50 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53CCC0613CE
        for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2020 17:14:49 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id gx22so2032389ejb.5
        for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2020 17:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=S1JE3ON349gMfW1O1D0bWp9cd3ZJMi75PEMqkEJbBZY=;
        b=NlG93Op1H3IbCCyX9wu838F8w7dNmD0WCP5EKiZse9+6t5udVHnSdQuy1roy+N+XFB
         5/fISpVYunYjQGxPO7fGlBa5zxwo/3nldjIiyqRo1GOq2/tOOTSbbUb7Osd2+B9g74wu
         e9m9ZTXP2Y+HCMF3hPGZlqxbUV4KpQRvkJxHlz88+IbIBwP5VkGNWoEBBxJnFoeCICTV
         y203fPCkl9wnjVslOR/l24aZbCF2p5nSjzHVgKkNsVwaGcRGYR3hAnKE22Rw6SwjfdVh
         0N/sap4Y+b3YbwyaKuNgSn+eiioxAWH/HL5jUaZj4lejaUCYHIPgm8VnNtFgdyZiZMWZ
         F9iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=S1JE3ON349gMfW1O1D0bWp9cd3ZJMi75PEMqkEJbBZY=;
        b=Fc0ByM6aN8YdxyOmbSF3O4OMPFedI3oRlEpPDNiZfyT1tp7nBmGgHSuNLOiN9vgcjH
         NkaMeMNBDajj2yMyUwYGSI/2G0UCtReDNpk8aQLqZZ6qDXmXIDLUsAHNq8tJqR0L9Bjc
         eEdEiuT8EiFp/EOtzTOTUOz7O5gYKal36tgoKzuLldGBgv0ClD2L34YLCUYJZySmKobT
         5CbE+c1gelXLJZudPeDW209v7oFjIGIf5o5u7dlKw3U5CyP8jbIrZsvC1FJuXF7MCRw6
         lPS4CkwW28YOJotnmEtEhX84Vyf1EdJaQeZaYbPr1DUHOJvszRvjsLaUxVmtRpMyHbMH
         58uw==
X-Gm-Message-State: AOAM533asrDPHThGwKZfhew3rvDsnQSZTueTEz+ZXFo8be0I27mGV2WR
        GjDO7atrox/9N0BjA1HuZBwsj60FLm1ZxA==
X-Google-Smtp-Source: ABdhPJyBx4gzcRg9eDtwGFatWbDH5Fk24oi7HmJouj1j9aq5dOcL5jcMhZ+Mt87IFJVSLITMsNj7Eg==
X-Received: by 2002:a17:906:54e:: with SMTP id k14mr2047527eja.59.1600906488489;
        Wed, 23 Sep 2020 17:14:48 -0700 (PDT)
Received: from net.saheed (5402C65D.dsl.pool.telekom.hu. [84.2.198.93])
        by smtp.gmail.com with ESMTPSA id r9sm1026559ejc.102.2020.09.23.17.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 17:14:47 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH 0/8] PCI: Move some ASPM info to struct pci_dev
Date:   Thu, 24 Sep 2020 01:15:09 +0200
Message-Id: <20200923231517.221310-1-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.4
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

These series migrates some ASPM information into struct pci_dev.
struct pcie_link_state.l1ss and struct aspm_register_info were
removed.


Saheed O. Bolarinwa (8):
  PCI/ASPM: Cache device's ASPM link capability in struct pci_dev
  PCI/ASPM: Rework calc_l*_latency() to take a struct pci_dev
  PCI/ASPM: Compute the value of aspm_register_info.support directly
  PCI/ASPM: Replace aspm_register_info.l1ss_cap* with pci_dev.l1ss_cap*
  PCI/ASPM: Remove aspm_register_info.l1ss_ctl*
  PCI/ASPM: Remove aspm_register_info.enable
  PCI/ASPM: Remove pcie_get_aspm_reg() and struct aspm_register_info
  PCI/ASPM: Remove struct pcie_link_state.l1ss

 drivers/pci/pcie/aspm.c | 203 +++++++++++++++-------------------------
 drivers/pci/probe.c     |   7 ++
 include/linux/pci.h     |   3 +
 3 files changed, 84 insertions(+), 129 deletions(-)

-- 
2.18.4

