Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64777C433ED
	for <linux-pci@archiver.kernel.org>; Tue, 11 May 2021 14:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27F5561628
	for <linux-pci@archiver.kernel.org>; Tue, 11 May 2021 14:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbhEKOFr (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 11 May 2021 10:05:47 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2487 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbhEKOFr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 May 2021 10:05:47 -0400
Received: from dggeme758-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FffkC3KCjzYjg0;
        Tue, 11 May 2021 22:02:11 +0800 (CST)
Received: from SZX1000464847.huawei.com (10.21.59.169) by
 dggeme758-chm.china.huawei.com (10.3.19.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 11 May 2021 22:04:38 +0800
From:   Dongdong Liu <liudongdong3@huawei.com>
To:     <helgaas@kernel.org>, <hch@infradead.org>,
        <linux-pci@vger.kernel.org>
CC:     Dongdong Liu <liudongdong3@huawei.com>
Subject: [PATCH V2 0/5] PCI: Enable 10-Bit tag support for PCIe devices
Date:   Tue, 11 May 2021 21:59:40 +0800
Message-ID: <1620741585-53304-1-git-send-email-liudongdong3@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.21.59.169]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggeme758-chm.china.huawei.com (10.3.19.104)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

10-Bit Tag capability, introduced in PCIe-4.0 increases the total Tag
field size from 8 bits to 10 bits.

This patchset is to enable 10-Bit tag for PCIe EP devices (include VF) and
RP devices.

V1->V2: Fix some comments by Christoph.
- Store the devcap2 value in the pci_dev instead of reading it multiple
  times.
- Change pci_info to pci_dbg to avoid the noisy log.
- Rename ext_10bit_tag_comp_path to ext_10bit_tag.
- Fix the compile error.
- Rebased on v5.13-rc1.

Dongdong Liu (5):
  PCI: Use cached Device Capabilities 2 Register
  PCI: Add 10-Bit Tag register definitions
  PCI: Enable 10-Bit tag support for PCIe Endpoint devices
  PCI/IOV: Enable 10-Bit tag support for PCIe VF devices
  PCI: Enable 10-Bit tag support for PCIe RP devices

 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c |  4 +-
 drivers/pci/iov.c                               |  8 +++
 drivers/pci/pci.c                               |  8 +--
 drivers/pci/pcie/portdrv_pci.c                  | 76 +++++++++++++++++++++++++
 drivers/pci/probe.c                             | 54 ++++++++++++++++--
 include/linux/pci.h                             |  3 +
 include/uapi/linux/pci_regs.h                   |  5 ++
 7 files changed, 144 insertions(+), 14 deletions(-)

--
2.7.4

