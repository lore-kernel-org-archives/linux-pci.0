Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A511C4338F
	for <linux-pci@archiver.kernel.org>; Tue, 27 Jul 2021 23:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3305260F9B
	for <linux-pci@archiver.kernel.org>; Tue, 27 Jul 2021 23:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233654AbhG0Xpu (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 27 Jul 2021 19:45:50 -0400
Received: from mx.socionext.com ([202.248.49.38]:27900 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233081AbhG0Xpu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Jul 2021 19:45:50 -0400
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 28 Jul 2021 08:45:49 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 11FC42083C46;
        Wed, 28 Jul 2021 08:45:49 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 28 Jul 2021 08:45:49 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 6643DB633F;
        Wed, 28 Jul 2021 08:45:48 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Vidya Sagar <vidyas@nvidia.com>, Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 0/2] PCI: endpoint: Fix core_init_notifier feature
Date:   Wed, 28 Jul 2021 08:45:35 +0900
Message-Id: <1627429537-4554-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series has two fixes for core_init_notifier feature.

Fix the bug that the driver can't register its notifier function
if core_init_notifier == true and linkup_notifier == false.

If enabling the controller is delayed due to core_init_notifier, 
accesses to the controller register should be avoided rather than
enabling the controller.

Kunihiko Hayashi (2):
  PCI: endpoint: pci-epf-test: register notifier if only
    core_init_notifier is enabled
  PCI: designware-ep: Fix the access to DBI/iATU registers before
    enabling controller

 drivers/pci/controller/dwc/pcie-designware-ep.c | 81 +++++++++++++------------
 drivers/pci/endpoint/functions/pci-epf-test.c   |  2 +-
 2 files changed, 42 insertions(+), 41 deletions(-)

-- 
2.7.4

