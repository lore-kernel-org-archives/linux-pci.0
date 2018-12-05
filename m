Return-Path: <SRS0=Hio3=OO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B9A8C04EBF
	for <linux-pci@archiver.kernel.org>; Wed,  5 Dec 2018 19:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34103208E7
	for <linux-pci@archiver.kernel.org>; Wed,  5 Dec 2018 19:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544039580;
	bh=dVsfckARte+5kBs5JUUTq9XbbD6TqzjhA4sx7jV+kmo=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=a6vEtEARHw4cN5LNZ+lmCJaKlHe9zulb9hVzIHxv791I7//MHtjFXqaLAIgIHNifJ
	 ZwwK1RukAcuHNf6JnqhTUerXDhnYDUzyZkU/zg1NQyOa5BDL4hJUwt4RjzBADwmYct
	 pt58QcKOEc4ozZq0JlxASvbGRonKC2DFwT3L+mlg=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34103208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbeLETww (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:52:52 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45246 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728761AbeLETvM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Dec 2018 14:51:12 -0500
Received: by mail-oi1-f195.google.com with SMTP id b141so18619286oii.12;
        Wed, 05 Dec 2018 11:51:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9ctNxvuyPF5iqgO7AZYmXgEh7unI6vGdlJZ+SjG9Pu4=;
        b=claS0pWtT54BKqWE0l6k2GF7a3BFEF0AnjkHfp0F31r7txs+8qNQPP5ZG0UFGAEMe4
         RB+y6Vzz/EEXUR/AjzxCr0ccE87zpHjmvQ1TRf1DXhNeyVse/YAOaomA0U9fsS4iwuZn
         aJCkVOxP0TtxOsNvshoyZ1ymts+X6M+0DLeuq8Cdn2zSe4C+DM7oKZj/9ynigAeP4ius
         Du+6Pmjvb4JJoRwHcT6zRhCRGWKiyfhWcRcBH0CuhI6W6v5QeAK/QyDApVlPcvCUUjyW
         UUM8jFkovwHaFu5MDug/rS1LxdL+qCi0A44ijBBMfyXGODeu7b9xbwePnw/tQXM1Dqnh
         9PVA==
X-Gm-Message-State: AA+aEWZl4J4VxQebaDAAVYrcnXfvs7MejfXoFOrNMx0as/KVM3VL6Ldx
        cRyKQS0ZBVV6Bujk8ReGtGkCK78=
X-Google-Smtp-Source: AFSGD/UQFuqODoTBBhlJKDYvPvLymfufJzQnVu/VHssTq1BrKjuv7zqncceA/oBeLnr1nJBE1jjr2g==
X-Received: by 2002:a54:4f1d:: with SMTP id e29mr15009889oiy.310.1544039471399;
        Wed, 05 Dec 2018 11:51:11 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id k13sm25759879otj.19.2018.12.05.11.51.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 11:51:10 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
Subject: [PATCH] PCI: Use of_node_name_eq for node name comparisons
Date:   Wed,  5 Dec 2018 13:50:34 -0600
Message-Id: <20181205195050.4759-18-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Convert string compares of DT node names to use of_node_name_eq helper
instead. This removes direct access to the node name pointer.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/hotplug/rpaphp_core.c | 2 +-
 drivers/pci/of.c                  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/rpaphp_core.c b/drivers/pci/hotplug/rpaphp_core.c
index bcd5d357ca23..7697d9c92b98 100644
--- a/drivers/pci/hotplug/rpaphp_core.c
+++ b/drivers/pci/hotplug/rpaphp_core.c
@@ -354,7 +354,7 @@ int rpaphp_add_slot(struct device_node *dn)
 	const int *indexes, *names, *types, *power_domains;
 	char *name, *type;
 
-	if (!dn->name || strcmp(dn->name, "pci"))
+	if (!of_node_name_eq(dn, "pci"))
 		return 0;
 
 	/* If this is not a hotplug slot, return without doing anything. */
diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 4c4217d0c3f1..3d32da15c215 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -113,7 +113,7 @@ struct device_node *of_pci_find_child_device(struct device_node *parent,
 		 * a fake root for all functions of a multi-function
 		 * device we go down them as well.
 		 */
-		if (!strcmp(node->name, "multifunc-device")) {
+		if (of_node_name_eq(node, "multifunc-device")) {
 			for_each_child_of_node(node, node2) {
 				if (__of_pci_pci_compare(node2, devfn)) {
 					of_node_put(node);
-- 
2.19.1

