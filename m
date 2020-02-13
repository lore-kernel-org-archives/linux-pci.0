Return-Path: <SRS0=VRgs=4B=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9717BC2BA83
	for <linux-pci@archiver.kernel.org>; Thu, 13 Feb 2020 11:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66F65217F4
	for <linux-pci@archiver.kernel.org>; Thu, 13 Feb 2020 11:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729511AbgBMLkj (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 13 Feb 2020 06:40:39 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:41788 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729532AbgBMLkj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Feb 2020 06:40:39 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 692C3ADB03D569C0B965;
        Thu, 13 Feb 2020 19:40:37 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Thu, 13 Feb 2020 19:40:31 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>
CC:     <f.fangjian@huawei.com>, <huangdaode@huawei.com>
Subject: [PATCH v3 0/9] Improve link speed presentation process
Date:   Thu, 13 Feb 2020 19:36:24 +0800
Message-ID: <1581593793-23589-1-git-send-email-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In this series:
1. Add 32 GT/s decoding in some macros as a complementary
2. Remove redundancy in speed presentation process and improve the codes.

Currently We use switch-case statements to acquire the speed
string according to the pci bus speed in current_link_speed_show()
and pcie_get_speed_cap(). It leads to redundant and when new
standard comes, we have to add cases in the related functions,
which is easy to omit at somewhere.

Abstract the judge statements out. Use macros and pci speed
arrays instead. Then only the macros and arrays need to be
extended when next generation comes.

Link:
https://lore.kernel.org/linux-pci/20200113211728.GA113776@google.com/
https://lore.kernel.org/linux-pci/20200114224909.GA19633@google.com/

change since v2:
1. revert split "PCI: Make pci_bus_speed_strings[] public" from the series
   and split into two patches. And modify the description as suggested.
2. split "PCI: Refactor bus_speed_read() with PCI_SPEED2STR macro" to
   two patches.
Link: https://lore.kernel.org/linux-pci/20200212223133.GA177061@google.com/

change since v1:
1. split "PCI: Make pci_bus_speed_strings[] public" from the series
2. split v1 PATCH 4 to two patches as suggested
3. modify some description in commit as suggested

Yicong Yang (9):
  PCI: add 32 GT/s decoding in some macros
  PCI: Make pci_bus_speed_strings[] public
  PCI: Remove PCIe suffix in pci_bus_speed_strings[]
  PCI: Add comments for link speed info arrays
  PCI: Refactor and rename PCIE_SPEED2STR macro
  PCI: Refactor bus_speed_read() with PCI_SPEED2STR macro
  PCI: Add PCIe suffix when display PCIe slot bus speed
  PCI: Add PCIE_LNKCAP2_SLS2SPEED macro
  PCI: Reduce redundancy in current_link_speed_show()

 drivers/pci/pci-sysfs.c | 26 ++++----------------------
 drivers/pci/pci.c       | 23 +++++++----------------
 drivers/pci/pci.h       | 23 ++++++++++++++++-------
 drivers/pci/probe.c     | 38 ++++++++++++++++++++++++++++++++++++++
 drivers/pci/slot.c      | 39 +++------------------------------------
 5 files changed, 68 insertions(+), 81 deletions(-)

--
2.8.1

