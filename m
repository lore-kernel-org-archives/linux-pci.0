Return-Path: <SRS0=J3VU=CH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58BB7C433E6
	for <linux-pci@archiver.kernel.org>; Sat, 29 Aug 2020 11:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DFFE20776
	for <linux-pci@archiver.kernel.org>; Sat, 29 Aug 2020 11:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbgH2LoY (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 29 Aug 2020 07:44:24 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10347 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727930AbgH2Li5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 29 Aug 2020 07:38:57 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 48A1753D649A8990E617;
        Sat, 29 Aug 2020 19:22:31 +0800 (CST)
Received: from linux-ioko.site (10.78.228.23) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Sat, 29 Aug 2020 19:22:20 +0800
From:   Dongdong Liu <liudongdong3@huawei.com>
To:     <mj@ucw.cz>
CC:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH V2 0/2] lspci: Decode 10-Bit Tag Requester Enable
Date:   Sat, 29 Aug 2020 18:58:40 +0800
Message-ID: <1598698722-126013-1-git-send-email-liudongdong3@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.78.228.23]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patchset is to:
1. Adjust PCI_EXP_DEV2_* to PCI_EXP_DEVCTL2_* macro definition to keep the
same style between the Linux kernel source [1] and lspci.
[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/uapi/linux/pci_regs.h#n651

2. Decode 10-Bit Tag Requester Enable bit in Device Control 2 Register.

Dongdong Liu (2):
  lspci: Adjust PCI_EXP_DEV2_* to PCI_EXP_DEVCTL2_* macro definition
  lspci: Decode 10-Bit Tag Requester Enable

 lib/header.h | 27 +++++++++++++++------------
 ls-caps.c    | 23 ++++++++++++-----------
 2 files changed, 27 insertions(+), 23 deletions(-)

--
1.9.1

