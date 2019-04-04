Return-Path: <SRS0=GqAx=SG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3102C4360F
	for <linux-pci@archiver.kernel.org>; Thu,  4 Apr 2019 16:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 910F421741
	for <linux-pci@archiver.kernel.org>; Thu,  4 Apr 2019 16:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbfDDQA1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 4 Apr 2019 12:00:27 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:42716 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728159AbfDDQA1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Apr 2019 12:00:27 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D3E89F261A06665AAF7B;
        Fri,  5 Apr 2019 00:00:23 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.408.0; Fri, 5 Apr 2019 00:00:17 +0800
From:   John Garry <john.garry@huawei.com>
To:     <bhelgaas@google.com>, <rafael@kernel.org>, <arnd@arndb.de>,
        <lorenzo.pieralisi@arm.com>
CC:     <linux@roeck-us.net>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <bp@suse.de>,
        <wangkefeng.wang@huawei.com>, <linuxarm@huawei.com>,
        <andy.shevchenko@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>, <catalin.marinas@arm.com>,
        <will.deacon@arm.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH v3 0/4]  Fix system crash for accessing unmapped IO port regions
Date:   Thu, 4 Apr 2019 23:59:58 +0800
Message-ID: <1554393602-152448-1-git-send-email-john.garry@huawei.com>
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

This patchset attempts to keep the kernel alive in such situations by 2
complementary methods:
1. Rejecting IO port resource requests until PCI IO port regions have been
mapped (in a pci_remap_iospace() call).
2. Rejecting logic PIO access to PCI IO regions until, again, PCI IO port
regions have been mapped

About 1:
Currently the PCI IO port region is initialized to the full range,
{0, IO_SPACE_LIMIT}. As such, any IO port region requests would not fail
because of PCI IO port regions not being mapped.

Patch 1/4 looks to remedy this issue by ensuring IO port requests are
made to direct children of ioport_resource (PCI host IO port regions),
similar to Arnd's solution, mentioned in [1]:

"I see that ioport_resource gets initialized to the {0, IO_SPACE_LIMIT}
range. If we could change it so that pci_remap_iospace() hooks up
to ioport_resource and extends it whenever something gets mapped
there up to IO_SPACE_LIMIT, we can change the default range to
{0,0}, which would fail for any request_region call before the
first pci_remap_iospace."

I didn't use this solution, as logical PIO space is sparse in
{0, IO_SPACE_LIMIT}, so we cannot simply grow the region.

*As discussed with Bjorn in v2 series, we doubt that this approach is
sound, as legacy ISA devices do not necessarily reply on PCI.*

However I will keep the patch in the series as a reference and as a topic
of debate.

It's also an RFC as the implementation solution is not idea.

About 2:
Some drivers - like f71805f hwmon driver - do not call
request_{muxed_}region() prior to accessing IO port regions, as they
should do.

So patches 2-3/4 adds a safeguard against this, in that unwarranted PIO IO
accesses will be discarded in the low-level accessors.

About the issue of f71805f driver not requesting the IO port region -
many drivers do this, and need to be fixed up separately.

1. https://lore.kernel.org/linux-pci/56F209A9.4040304@huawei.com
2. https://lore.kernel.org/linux-arm-kernel/e6995b4a-184a-d8d4-f4d4-9ce75d8f47c0@huawei.com/

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

John Garry (4):
  resource: Request IO port regions from children of ioport_resource
  lib: logic_pio: Use logical PIO low-level accessors for
    !CONFIG_INDIRECT_PIO
  lib: logic_pio: Reject accesses to unregistered CPU MMIO regions
  lib: logic_pio: Fix up some prints

 include/linux/ioport.h    |  11 ++-
 include/linux/logic_pio.h |   7 +-
 kernel/resource.c         |  28 +++++++
 lib/logic_pio.c           | 157 +++++++++++++++++++++++++++++---------
 4 files changed, 159 insertions(+), 44 deletions(-)

-- 
2.17.1

