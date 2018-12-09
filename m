Return-Path: <SRS0=iymf=OS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2536C07E85
	for <linux-pci@archiver.kernel.org>; Sun,  9 Dec 2018 22:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9983B20837
	for <linux-pci@archiver.kernel.org>; Sun,  9 Dec 2018 22:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fredlawl-com.20150623.gappssmtp.com header.i=@fredlawl-com.20150623.gappssmtp.com header.b="xxShai0K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9983B20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fredlawl.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbeLIWqj (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:46:39 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34057 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbeLIWqj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 9 Dec 2018 17:46:39 -0500
Received: by mail-oi1-f196.google.com with SMTP id h25so7583770oig.1
        for <linux-pci@vger.kernel.org>; Sun, 09 Dec 2018 14:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fredlawl-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=guAieEX3tnWHuuM1l8KzNMGuDYrTMkG1L3tUfFzs1SM=;
        b=xxShai0KajxFgh0/VSCAlsn3fDuzfhHfpfoD40ifgx/381jEBgNQBcpK/t6kViJTcQ
         TP4gKm2asshj+a97qW77hB9To4ksVun+et79b4r6DBGl768mqN+fz3sMlBGT2c67f4o6
         0NEjCNZ/t+KuZek23xwHl4XgmH26fIQnaAZIzZT6rPwprQp8+rf+bNpYaf7Xm0ZwMdbQ
         TMtQeYJ73U0P1rCENmo6mnZP8QojmHR6KsfjdkgDSlj/Lg/boklpNo4hvLhPdMhPxW7z
         V5eDNMb+K9l9Odt/rPzsyhnlDDghT+w+cuqB0m1eFfLa6d9J6I0VTxDhnzauBr5H+A8g
         wksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=guAieEX3tnWHuuM1l8KzNMGuDYrTMkG1L3tUfFzs1SM=;
        b=Xvs7qaOqZytHUy+Doj+qfDpRxXHOTNZgDSgnbBKZzb5scy7oz6hglhbIQbPmGgzUG9
         sH9WZIi8WJY/7p1D1B4DngFHXmNN9HOzmwPkOg7gRCgD6O0W82+jF+59FEr5OTHRNmzq
         lBDRD0+grKDaWUOQlLGLOW6eFbOtLdd8PbgYD0QFGp3zpWbvVaW3U6AHZ/LWKvbGTmAe
         0Y0aZwCaz5ykUoKjQ6BHtzqo1ZuLjHjlNjJAlcVwda2aiQgwVpiYO3bpcVqqtWGD1Sph
         G9VYUlHJ8XHBCo6/uz1icBCpjUf6fhkDT5vNjbLkGEp7zfG5VcuEuEMptdCfzQZyJA9Q
         yDmQ==
X-Gm-Message-State: AA+aEWbwxRcyMzoro/GUA0wE4GQuAjYJ3U0uc/xLgM4W0DQcUTNaE7VU
        kTyw7RyXg1wKYVM2y81HkNYH7w==
X-Google-Smtp-Source: AFSGD/WubISG1uQFa6RUJfFbxT0euSoeTyWtixN6znufigZydWaf0gAyZCVkz7cMa8Rs2wwxSTSUpA==
X-Received: by 2002:aca:d64d:: with SMTP id n74mr5931462oig.199.1544395598444;
        Sun, 09 Dec 2018 14:46:38 -0800 (PST)
Received: from ubuntu-fredlawl.attlocal.net ([2600:1702:3be0:4340:e5c0:b776:5e38:6371])
        by smtp.gmail.com with ESMTPSA id c23sm4339179otn.21.2018.12.09.14.46.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 14:46:37 -0800 (PST)
From:   Frederick Lawler <fred@fredlawl.com>
To:     helgaas@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        ptalbert@redhat.com, Frederick Lawler <fred@fredlawl.com>
Subject: [PATCH] PCI/ASPM: Remove unused lists from struct pcie_link_state
Date:   Sun,  9 Dec 2018 16:45:50 -0600
Message-Id: <20181209224550.18931-1-fred@fredlawl.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

ASPM does not make use of the children or link LIST_HEADs declared in
struct pcie_link_state and defined in alloc_pcie_link_state(). Therefore,
remove these lists.

No functional change intended.

Signed-off-by: Frederick Lawler <fred@fredlawl.com>
---
 drivers/pci/pcie/aspm.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index dcb29cb76dc6..2330ebf6df72 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -53,8 +53,6 @@ struct pcie_link_state {
 	struct pcie_link_state *root;	/* pointer to the root port link */
 	struct pcie_link_state *parent;	/* pointer to the parent Link state */
 	struct list_head sibling;	/* node in link_list */
-	struct list_head children;	/* list of child link states */
-	struct list_head link;		/* node in parent's children list */
 
 	/* ASPM state */
 	u32 aspm_support:7;		/* Supported ASPM state */
@@ -850,8 +848,6 @@ static struct pcie_link_state *alloc_pcie_link_state(struct pci_dev *pdev)
 		return NULL;
 
 	INIT_LIST_HEAD(&link->sibling);
-	INIT_LIST_HEAD(&link->children);
-	INIT_LIST_HEAD(&link->link);
 	link->pdev = pdev;
 	link->downstream = pci_function_0(pdev->subordinate);
 
@@ -877,7 +873,6 @@ static struct pcie_link_state *alloc_pcie_link_state(struct pci_dev *pdev)
 
 		link->parent = parent;
 		link->root = link->parent->root;
-		list_add(&link->link, &parent->children);
 	}
 
 	list_add(&link->sibling, &link_list);
@@ -1001,7 +996,6 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
 	/* All functions are removed, so just disable ASPM for the link */
 	pcie_config_aspm_link(link, 0);
 	list_del(&link->sibling);
-	list_del(&link->link);
 	/* Clock PM is for endpoint device */
 	free_link_state(link);
 
-- 
2.17.1

