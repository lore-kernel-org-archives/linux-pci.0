Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B19FEC433ED
	for <linux-pci@archiver.kernel.org>; Tue, 11 May 2021 15:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E46C613C1
	for <linux-pci@archiver.kernel.org>; Tue, 11 May 2021 15:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbhEKPBT (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 11 May 2021 11:01:19 -0400
Received: from foss.arm.com ([217.140.110.172]:49524 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231461AbhEKPBS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 11 May 2021 11:01:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E60A1D6E;
        Tue, 11 May 2021 08:00:11 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.60.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F4D73F718;
        Tue, 11 May 2021 08:00:10 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Subject: [PATCH] MAINTAINERS: Add Krzysztof as PCI host/endpoint controllers reviewer
Date:   Tue, 11 May 2021 16:00:03 +0100
Message-Id: <20210511150003.1592-1-lorenzo.pieralisi@arm.com>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Krzysztof has been carrying out PCI patches review for a long time and
he has been instrumental in driving PCI host/endpoint controller drivers
improvements.

Make his role official.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC: Bjorn Helgaas <bhelgaas@google.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Krzysztof Wilczyński <kw@linux.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index bd7aff0c120f..9755bf97658d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14110,6 +14110,7 @@ F:	drivers/pci/controller/pci-v3-semi.c
 PCI ENDPOINT SUBSYSTEM
 M:	Kishon Vijay Abraham I <kishon@ti.com>
 M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
+R:	Krzysztof Wilczyński <kw@linux.com>
 L:	linux-pci@vger.kernel.org
 S:	Supported
 F:	Documentation/PCI/endpoint/*
@@ -14158,6 +14159,7 @@ F:	drivers/pci/controller/pci-xgene-msi.c
 PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS
 M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
 R:	Rob Herring <robh@kernel.org>
+R:	Krzysztof Wilczyński <kw@linux.com>
 L:	linux-pci@vger.kernel.org
 S:	Supported
 Q:	http://patchwork.ozlabs.org/project/linux-pci/list/
-- 
2.26.1

