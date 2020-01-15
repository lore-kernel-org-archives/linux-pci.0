Return-Path: <SRS0=Q3uD=3E=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F01EDC33CB8
	for <linux-pci@archiver.kernel.org>; Wed, 15 Jan 2020 09:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D135C24655
	for <linux-pci@archiver.kernel.org>; Wed, 15 Jan 2020 09:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729276AbgAOJIY (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 15 Jan 2020 04:08:24 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9616 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729347AbgAOJIY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 15 Jan 2020 04:08:24 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5B2EEA74A5278F501139;
        Wed, 15 Jan 2020 17:08:19 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Wed, 15 Jan 2020 17:08:09 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>
CC:     <f.fangjian@huawei.com>
Subject: [PATCH 0/6] Improve link speed presentation process
Date:   Wed, 15 Jan 2020 17:04:17 +0800
Message-ID: <1579079063-5668-1-git-send-email-yangyicong@hisilicon.com>
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


Yicong Yang (6):
  PCI: add 32 GT/s decoding in some macros
  PCI: Make pci_bus_speed_strings[] public
  PCI: Add comments for link speed info arrays
  PCI: Improve and rename PCIE_SPEED2STR macro
  PCI: Add PCIE_LNKCAP2_SLS2SPEED macro
  PCI: Reduce redundancy in current_link_speed_show()

 drivers/pci/pci-sysfs.c | 26 ++++----------------------
 drivers/pci/pci.c       | 23 +++++++----------------
 drivers/pci/pci.h       | 22 +++++++++++++++-------
 drivers/pci/probe.c     | 37 +++++++++++++++++++++++++++++++++++++
 drivers/pci/slot.c      | 39 +++------------------------------------
 5 files changed, 66 insertions(+), 81 deletions(-)

--
2.8.1

