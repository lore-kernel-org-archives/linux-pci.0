Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FA4C433E6
	for <linux-pci@archiver.kernel.org>; Thu, 25 Mar 2021 07:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0B4461A25
	for <linux-pci@archiver.kernel.org>; Thu, 25 Mar 2021 07:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbhCYHu2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 25 Mar 2021 03:50:28 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14586 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbhCYHuU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Mar 2021 03:50:20 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F5cfT47bBz19J9x;
        Thu, 25 Mar 2021 15:48:17 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Thu, 25 Mar 2021 15:50:06 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <bhelgaas@google.com>, <rjw@rjwysocki.net>, <ruscur@russell.cc>
CC:     <linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <wangxiongfeng2@huawei.com>
Subject: [PATCH 0/4] PCI: Correct function names in the header
Date:   Thu, 25 Mar 2021 15:51:40 +0800
Message-ID: <20210325075144.180030-1-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


Xiongfeng Wang (4):
  PCI: acpi_pcihp: Correct acpi_pci_check_ejectable() function name in
    the header
  PCI/AER: Correct function names in the header
  PCI/PME: Correct pcie_pme_init() function name in the header
  PCI/ATS: Correct pci_max_pasids() function name in header

 drivers/pci/ats.c                | 2 +-
 drivers/pci/hotplug/acpi_pcihp.c | 2 +-
 drivers/pci/pcie/aer.c           | 6 +++---
 drivers/pci/pcie/pme.c           | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.20.1

