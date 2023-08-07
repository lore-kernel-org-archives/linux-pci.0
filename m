Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD1FC41513
	for <linux-pci@archiver.kernel.org>; Mon,  7 Aug 2023 13:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbjHGNhf (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 7 Aug 2023 09:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233155AbjHGNhd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Aug 2023 09:37:33 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8D8125
        for <linux-pci@vger.kernel.org>; Mon,  7 Aug 2023 06:37:31 -0700 (PDT)
Received: from dggpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RKHQr1BLfz1KCNh;
        Mon,  7 Aug 2023 21:36:20 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 21:37:28 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <alyssa@rosenzweig.io>, <maz@kernel.org>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <robh@kernel.org>, <bhelgaas@google.com>,
        <mahesh@linux.ibm.com>, <oohall@gmail.com>
CC:     <lukas@wunner.de>, <linux-pci@vger.kernel.org>,
        <yangyingliang@huawei.com>, <wangxiongfeng2@huawei.com>
Subject: [PATCH 3/3] PCI/IOV: Use pci_dev_id() to simplify the code
Date:   Mon, 7 Aug 2023 21:48:58 +0800
Message-ID: <20230807134858.116051-4-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230807134858.116051-1-wangxiongfeng2@huawei.com>
References: <20230807134858.116051-1-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCI core API pci_dev_id() can be used to get the BDF number for a pci
device. We don't need to compose it mannually. Use pci_dev_id() to
simplify the code a little bit.

Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 drivers/pci/iov.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index b2e8322755c1..25dbe85c4217 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -41,8 +41,7 @@ int pci_iov_vf_id(struct pci_dev *dev)
 		return -EINVAL;
 
 	pf = pci_physfn(dev);
-	return (((dev->bus->number << 8) + dev->devfn) -
-		((pf->bus->number << 8) + pf->devfn + pf->sriov->offset)) /
+	return (pci_dev_id(dev) - (pci_dev_id(pf) + pf->sriov->offset)) /
 	       pf->sriov->stride;
 }
 EXPORT_SYMBOL_GPL(pci_iov_vf_id);
-- 
2.20.1

