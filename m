Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFC1C433DB
	for <linux-pci@archiver.kernel.org>; Fri, 26 Feb 2021 20:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3934464EFA
	for <linux-pci@archiver.kernel.org>; Fri, 26 Feb 2021 20:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbhBZUNk (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 26 Feb 2021 15:13:40 -0500
Received: from mga17.intel.com ([192.55.52.151]:35678 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230260AbhBZUM3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 26 Feb 2021 15:12:29 -0500
IronPort-SDR: YxRkBkRDTArFCioc32kKUAUcGXZYE0SnSSTw0giS+I+82H/b0aLAj2OumLreeSpcoCulplPFTK
 iVR2y6n75ZuQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9907"; a="165846880"
X-IronPort-AV: E=Sophos;i="5.81,209,1610438400"; 
   d="scan'208";a="165846880"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2021 12:11:11 -0800
IronPort-SDR: bv3dIM+IbW13OExEYSXo0hhvv1rA5nhUWMSWlIzU/auQPUWDKDSD5QG824i1vJGPgpNSm87Anc
 802IjYYcsKGQ==
X-IronPort-AV: E=Sophos;i="5.81,209,1610438400"; 
   d="scan'208";a="405109416"
Received: from megha-z97x-ud7-th.sc.intel.com ([143.183.85.154])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 26 Feb 2021 12:11:10 -0800
From:   Megha Dey <megha.dey@intel.com>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, dave.jiang@intel.com,
        ashok.raj@intel.com, kevin.tian@intel.com, dwmw@amazon.co.uk,
        x86@kernel.org, tony.luck@intel.com, dan.j.williams@intel.com,
        megha.dey@intel.com, jgg@mellanox.com, kvm@vger.kernel.org,
        iommu@lists.linux-foundation.org, alex.williamson@redhat.com,
        bhelgaas@google.com, maz@kernel.org, linux-pci@vger.kernel.org,
        baolu.lu@linux.intel.com, ravi.v.shankar@intel.com
Subject: [Patch V2 01/13] x86/irq: Add DEV_MSI allocation type
Date:   Fri, 26 Feb 2021 12:11:05 -0800
Message-Id: <1614370277-23235-2-git-send-email-megha.dey@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1614370277-23235-1-git-send-email-megha.dey@intel.com>
References: <1614370277-23235-1-git-send-email-megha.dey@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

For the upcoming device MSI support a new allocation type is
required.

Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Megha Dey <megha.dey@intel.com>
---
 arch/x86/include/asm/hw_irq.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/hw_irq.h b/arch/x86/include/asm/hw_irq.h
index d465ece..0531b9c 100644
--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -41,6 +41,7 @@ enum irq_alloc_type {
 	X86_IRQ_ALLOC_TYPE_DMAR,
 	X86_IRQ_ALLOC_TYPE_AMDVI,
 	X86_IRQ_ALLOC_TYPE_UV,
+	X86_IRQ_ALLOC_TYPE_DEV_MSI,
 };
 
 struct ioapic_alloc_info {
-- 
2.7.4

