Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1105CC4338F
	for <linux-pci@archiver.kernel.org>; Fri, 23 Jul 2021 03:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB24A60EBD
	for <linux-pci@archiver.kernel.org>; Fri, 23 Jul 2021 03:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233625AbhGWCzy (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 22 Jul 2021 22:55:54 -0400
Received: from mx21.baidu.com ([220.181.3.85]:37624 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233612AbhGWCzx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Jul 2021 22:55:53 -0400
Received: from BJHW-Mail-Ex03.internal.baidu.com (unknown [10.127.64.13])
        by Forcepoint Email with ESMTPS id 54C61CC6DD851F5524AF;
        Fri, 23 Jul 2021 11:36:26 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BJHW-Mail-Ex03.internal.baidu.com (10.127.64.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Fri, 23 Jul 2021 11:36:26 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Fri, 23 Jul 2021 11:36:25 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <kw@linux.com>, <bhelgaas@google.com>,
        <jonathan.derrick@intel.com>, <lorenzo.pieralisi@arm.com>,
        <robh@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Cai Huoqing <caihuoqing@baidu.com>
Subject: [PATCH v3 0/2] PCI: Make use of PCI_DEVICE_XXX() helper macro
Date:   Fri, 23 Jul 2021 11:36:16 +0800
Message-ID: <20210723033618.1025-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BJHW-Mail-Ex03.internal.baidu.com (10.127.64.13) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Could make use of PCI_DEVICE_XXX() helper macro

v1->v2: *fix extra indent for git-apply failure

v2->v3: *update the subject line from "function" to "macro"
	*add changelog to commit message

commit date: 7-23-2021 11:00

Cai Huoqing (2):
  PCI: Make use of PCI_DEVICE_SUB/_CLASS() helper macro
  PCI: vmd: Make use of PCI_DEVICE_DATA() helper macro

 drivers/pci/controller/vmd.c      | 38 +++++++++++++++----------------
 drivers/pci/hotplug/cpqphp_core.c | 13 ++---------
 drivers/pci/search.c              | 14 ++----------
 include/linux/pci_ids.h           |  2 ++
 4 files changed, 25 insertions(+), 42 deletions(-)

-- 
2.25.1

