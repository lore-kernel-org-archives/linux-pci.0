Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67449C0015E
	for <linux-pci@archiver.kernel.org>; Mon,  7 Aug 2023 03:06:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjHGDGj (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 6 Aug 2023 23:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjHGDGh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 6 Aug 2023 23:06:37 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C00170B
        for <linux-pci@vger.kernel.org>; Sun,  6 Aug 2023 20:06:36 -0700 (PDT)
Received: from dggpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RK1Qq4Pr4zrSFF;
        Mon,  7 Aug 2023 11:05:23 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 11:06:31 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <bhelgaas@google.com>, <fbarrat@linux.ibm.com>,
        <ajd@linux.ibm.com>, <mpe@ellerman.id.au>, <npiggin@gmail.com>,
        <christophe.leroy@csgroup.eu>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>, <ben.widawsky@intel.com>,
        <wangxiongfeng2@huawei.com>
CC:     <jonathan.cameron@huawei.com>, <linux-pci@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>, <yangyingliang@huawei.com>
Subject: [PATCH 0/2] introduce pci_find_next_dvsec_capability() to simplify the code
Date:   Mon, 7 Aug 2023 11:18:44 +0800
Message-ID: <20230807031846.77348-1-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some devices may have several DVSEC(Designated Vendor-Specific Extended
Capability) entries with the same DVSEC ID. Introduce
pci_find_next_dvsec_capability() to simplify the code.

Xiongfeng Wang (2):
  PCI: Add pci_find_next_dvsec_capability to find next designated VSEC
  ocxl: use pci_find_next_dvsec_capability() to simplify the code

 arch/powerpc/platforms/powernv/ocxl.c | 20 ++-------------
 drivers/misc/ocxl/config.c            | 21 +++++----------
 drivers/pci/pci.c                     | 37 ++++++++++++++++++---------
 include/linux/pci.h                   |  2 ++
 include/misc/ocxl-config.h            |  4 ---
 5 files changed, 35 insertions(+), 49 deletions(-)

-- 
2.20.1

