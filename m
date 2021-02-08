Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4225C433DB
	for <linux-pci@archiver.kernel.org>; Mon,  8 Feb 2021 11:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66A4864E3F
	for <linux-pci@archiver.kernel.org>; Mon,  8 Feb 2021 11:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232867AbhBHLGc (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 8 Feb 2021 06:06:32 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:12868 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232830AbhBHLAK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Feb 2021 06:00:10 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DZ30122gDz7hqt;
        Mon,  8 Feb 2021 18:57:53 +0800 (CST)
Received: from huawei.com (10.69.192.56) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.498.0; Mon, 8 Feb 2021
 18:59:10 +0800
From:   Luo Jiaxing <luojiaxing@huawei.com>
To:     <maz@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: [PATCH v1 0/2] irqchip/gic-v3-its: don't set bitmap for LPI which user didn't allocate
Date:   Mon, 8 Feb 2021 18:58:44 +0800
Message-ID: <1612781926-56206-1-git-send-email-luojiaxing@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When the number of online CPUs is less than 16, we found that it will fail
to allocate 32 MSI interrupts (including 16 affinity interrupts) after the
hisi_sas module is unloaded and then reloaded.

After analysis, it is found that a bug exists when the ITS releases
interrupt resources, and this patch set contains a bugfix patch and a patch
for appending debugging information.

Luo Jiaxing (2):
  irqchip/gic-v3-its: don't set bitmap for LPI which user didn't
    allocate
  genirq/msi: add an error print when __irq_domain_alloc_irqs() failed

 drivers/irqchip/irq-gic-v3-its.c | 4 ++++
 kernel/irq/msi.c                 | 1 +
 2 files changed, 5 insertions(+)

-- 
2.7.4

