Return-Path: <SRS0=+3kZ=UK=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F9A8C43218
	for <linux-pci@archiver.kernel.org>; Tue, 11 Jun 2019 14:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57D9320896
	for <linux-pci@archiver.kernel.org>; Tue, 11 Jun 2019 14:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389514AbfFKOOR (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 11 Jun 2019 10:14:17 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:18551 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728264AbfFKOOP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 11 Jun 2019 10:14:15 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 50806A18E011A450749A;
        Tue, 11 Jun 2019 22:14:12 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Tue, 11 Jun 2019 22:14:06 +0800
From:   John Garry <john.garry@huawei.com>
To:     <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>, <arnd@arndb.de>
CC:     <linux-pci@vger.kernel.org>, <rjw@rjwysocki.net>,
        <linux-arm-kernel@lists.infradead.org>, <will.deacon@arm.com>,
        <wangkefeng.wang@huawei.com>, <linuxarm@huawei.com>,
        <andriy.shevchenko@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <catalin.marinas@arm.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v4 0/3] Fix ARM64 crash for accessing unmapped IO port regions
Date:   Tue, 11 Jun 2019 22:12:51 +0800
Message-ID: <1560262374-67875-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

It was reported some time ago that arm64 systems will crash if a driver
attempts to access IO port addresses when the PCI IO port region has not
been mapped [1].

More recently, a similar crash is where the system PCI host probe fails,
and the IPMI driver crashes the system while attempting to do some IO port
accesses [2].

This patchset attempts to keep the kernel alive in such situations by
rejecting logical PIO access to PCI IO regions until PCI IO port regions
have been mapped. Accesses to unmapped regions fail silently, mimicking
x86 behaviour.

The previous versions of this patchset also included a patch to reject IO
port resource requests until PCI IO port regions have been mapped
(in a pci_remap_iospace() call). However I decided to drop it since the
validity of the patch was strongly in doubt - [3].

1. https://lore.kernel.org/linux-pci/56F209A9.4040304@huawei.com
2. https://lore.kernel.org/linux-arm-kernel/e6995b4a-184a-d8d4-f4d4-9ce75d8f47c0@huawei.com/
3. https://lore.kernel.org/linux-pci/20190326224810.GY24180@google.com/

Differences to v3 patchset:
https://lkml.org/lkml/2019/4/4/1294
- Drop patch to reject IO port requests
- Make unmapped IO port accesses silent, mimicking x86

Differences to v2 patchset:
https://lkml.org/lkml/2019/3/20/788
- Add a patch to use logical PIO accessors for !CONFIG_INDIRECT_PIO
- Some tidy-up according to Andy's review

Differences to v1 patchset:
https://lkml.org/lkml/2019/3/14/630
- Drop f71805f fix - it can be done in a separate patchset
- Change implementation in resource.c patch to check if parent of region
  is ioport_resource
- Add patch to fix some logic_pio.c prints

John Garry (3):
  lib: logic_pio: Use logical PIO low-level accessors for
    !CONFIG_INDIRECT_PIO
  lib: logic_pio: Reject accesses to unregistered CPU MMIO regions
  lib: logic_pio: Fix up a print

 include/linux/logic_pio.h |   7 ++-
 lib/logic_pio.c           | 116 ++++++++++++++++++++++++++++----------
 2 files changed, 90 insertions(+), 33 deletions(-)

-- 
2.17.1

