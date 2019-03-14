Return-Path: <SRS0=NdPK=RR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6348FC10F06
	for <linux-pci@archiver.kernel.org>; Thu, 14 Mar 2019 16:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F60A21874
	for <linux-pci@archiver.kernel.org>; Thu, 14 Mar 2019 16:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbfCNQz0 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 14 Mar 2019 12:55:26 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5248 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727131AbfCNQz0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 14 Mar 2019 12:55:26 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B170D95E339E8C2C5FCE;
        Fri, 15 Mar 2019 00:55:22 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.408.0; Fri, 15 Mar 2019 00:55:14 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jdelvare@suse.com>, <linux@roeck-us.net>, <bhelgaas@google.com>,
        <rafael@kernel.org>, <arnd@arndb.de>, <lorenzo.pieralisi@arm.com>,
        <bp@suse.de>
CC:     <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <wangkefeng.wang@huawei.com>,
        <linuxarm@huawei.com>, John Garry <john.garry@huawei.com>
Subject: [RFC PATCH 0/2] Fix system crash for accessing unmapped IO port regions
Date:   Fri, 15 Mar 2019 00:55:14 +0800
Message-ID: <1552582516-70855-1-git-send-email-john.garry@huawei.com>
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

More recently, a similar crash was seen where the system PCI host probe
fails, and the IPMI driver crashes the system while attempting to do some
IO port accesses [2].

This (incomplete) patchset attempts to keep the kernel alive in such
situations, by rejecting IO port resource requests until PCI IO port
regions have been mapped (in a pci_remap_iospace() call).

Currently the PCI IO port region is initialized to the full range,
{0, IO_SPACE_LIMIT}. As such, any IO port region requests would not fail
because of PCI IO port regions not being mapped.

This patchset looks to remedy this issue by ensuring IO port requests are
made to direct children of ioport_resource (PCI host IO port regions),
similar to Arnd's solution, in [1]:

"I see that ioport_resource gets initialized to the {0, IO_SPACE_LIMIT}
range. If we could change it so that pci_remap_iospace() hooks up
to ioport_resource and extends it whenever something gets mapped
there up to IO_SPACE_LIMIT, we can change the default range to
{0,0}, which would fail for any request_region call before the
first pci_remap_iospace."

I didn't use this solution exactly, as I thought that it may cause
problems if we later wanted to remove PCI host IO port regions.

There is another separate issue that many drivers fail to request IO port
region, prior to access. This patchset fixes the f71805f driver as an
example.

There are others drivers which need to be fixed up to do the same.

1. https://www.spinics.net/lists/linux-pci/msg49821.html
2. https://www.spinics.net/lists/arm-kernel/msg694702.html

John Garry (2):
  resource: Request IO port regions from children of ioport_resource
  hwmon: (f71805f): Use request_region() in f71805f_init()

 drivers/hwmon/f71805f.c | 13 ++++++++++++-
 include/linux/ioport.h  |  6 +++++-
 kernel/resource.c       | 19 +++++++++++++++++++
 3 files changed, 36 insertions(+), 2 deletions(-)

-- 
2.17.1

