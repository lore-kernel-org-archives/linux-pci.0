Return-Path: <SRS0=seBN=3Z=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87E4C33CA1
	for <linux-pci@archiver.kernel.org>; Wed,  5 Feb 2020 09:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95BD6217F4
	for <linux-pci@archiver.kernel.org>; Wed,  5 Feb 2020 09:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbgBEJWL (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 5 Feb 2020 04:22:11 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:45114 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728034AbgBEJWK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Feb 2020 04:22:10 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B1E5596657E9C05335B7;
        Wed,  5 Feb 2020 17:21:58 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Wed, 5 Feb 2020 17:21:50 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>
CC:     <f.fangjian@huawei.com>, <huangdaode@huawei.com>
Subject: [PATCH 0/2] PCI: Fix potential deadlock problems
Date:   Wed, 5 Feb 2020 17:17:57 +0800
Message-ID: <1580894277-20671-1-git-send-email-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently we use several locks to avoid racing conditions in pci
framework. When involving more than one lock, the inconsistent
lock order will lead to deadlock problems. This patchset aims to
solve the problem by keeping the same lock order in different
processes.

Patch_1: fix the potential deadlock caused by pci_dev_lock() and
VF enable routine.
Patch_2: fix the deadlock caused by AER and sriov enable routine
as reported.

Yicong Yang (2):
  PCI: Change lock order in pci_dev_lock()
  PCI/AER: Fix deadlock triggered by AER and sriov enable routine

 drivers/pci/bus.c      |  8 ++++++++
 drivers/pci/pci.c      | 15 ++++++++-------
 drivers/pci/pci.h      |  4 ++++
 drivers/pci/pcie/err.c | 18 +++++-------------
 4 files changed, 25 insertions(+), 20 deletions(-)

--
2.8.1

