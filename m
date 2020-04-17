Return-Path: <SRS0=f1uR=6B=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB7F0C2BB1D
	for <linux-pci@archiver.kernel.org>; Fri, 17 Apr 2020 07:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C67162083E
	for <linux-pci@archiver.kernel.org>; Fri, 17 Apr 2020 07:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbgDQHJi (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 17 Apr 2020 03:09:38 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:42486 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728159AbgDQHJi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 17 Apr 2020 03:09:38 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 28D6622F2F9E658195FE;
        Fri, 17 Apr 2020 15:09:35 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Fri, 17 Apr 2020
 15:09:27 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <konrad.wilk@oracle.com>, <bhelgaas@google.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <x86@kernel.org>, <hpa@zytor.com>,
        <xen-devel@lists.xenproject.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] xen/pci: make xen_msi_init() static
Date:   Fri, 17 Apr 2020 15:35:53 +0800
Message-ID: <20200417073553.42873-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix the following sparse warning:

arch/x86/pci/xen.c:426:13: warning: symbol 'xen_msi_init' was not
declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 arch/x86/pci/xen.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
index 91220cc25854..0d06f12ccd74 100644
--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -423,7 +423,7 @@ int __init pci_xen_init(void)
 }
 
 #ifdef CONFIG_PCI_MSI
-void __init xen_msi_init(void)
+static void __init xen_msi_init(void)
 {
 	if (!disable_apic) {
 		/*
-- 
2.21.1

