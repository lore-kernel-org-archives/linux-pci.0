Return-Path: <SRS0=Ivhv=RX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2614CC43381
	for <linux-pci@archiver.kernel.org>; Wed, 20 Mar 2019 18:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02C05218D4
	for <linux-pci@archiver.kernel.org>; Wed, 20 Mar 2019 18:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfCTSOZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 20 Mar 2019 14:14:25 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5722 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726611AbfCTSOZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 Mar 2019 14:14:25 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9F14E2DAE325F106F641;
        Thu, 21 Mar 2019 02:14:22 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.408.0; Thu, 21 Mar 2019 02:14:13 +0800
From:   John Garry <john.garry@huawei.com>
To:     <bhelgaas@google.com>, <rafael@kernel.org>, <arnd@arndb.de>,
        <lorenzo.pieralisi@arm.com>, <bp@suse.de>
CC:     <linux@roeck-us.net>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <wangkefeng.wang@huawei.com>,
        <linuxarm@huawei.com>, <agraf@suse.de>,
        <andy.shevchenko@gmail.com>, "John Garry" <john.garry@huawei.com>
Subject: [PATCH v2 0/3] Fix system crash for accessing unmapped IO port regions
Date:   Thu, 21 Mar 2019 02:14:07 +0800
Message-ID: <1553105650-28012-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

It was reported some time ago that systems will crash if a driver attempts
to access IO port addresses when the PCI IO port region has not been
mapped [1].

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

Patch 1/3 looks to remedy this issue by ensuring IO port requests are
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

I marked the patch as RFC, as the solution is not ideal, i.e. calling
__release_region() if the region is not suitable. In addition,
regressions may be seen, so I would like input first.

About 2:
Some drivers - like f71805f hwmon driver - do not call
request_{muxed_}region() prior to accessing IO port regions, as they
should do.

So patch 2/3 adds a safeguard against this, in that unwarranted PIO IO
accesses will be discarded in the low-level accessors.

About the issue of f71805f driver not requesting the IO port region -
many drivers do this, and need to be fixed up separately.

1. https://www.spinics.net/lists/linux-pci/msg49821.html
2. https://www.spinics.net/lists/arm-kernel/msg694702.html

Differences to v1 patchset:
https://lkml.org/lkml/2019/3/14/630
- Drop f71805f fix - it can be done in a separate patchset
- Change implementation in resource.c patch to check if parent of region
  is ioport_resource
- Add patch to fix some logic_pio.c prints

John Garry (3):
  resource: Request IO port regions from children of ioport_resource
  lib: logic_pio: Reject access to unregistered CPU MMIO regions
  lib: logic_pio: Make some prints explicitly hex

 include/linux/ioport.h | 12 +++++--
 kernel/resource.c      | 28 ++++++++++++++++
 lib/logic_pio.c        | 74 ++++++++++++++++++++++++------------------
 3 files changed, 79 insertions(+), 35 deletions(-)

-- 
2.17.1

