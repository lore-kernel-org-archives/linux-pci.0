Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53280 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933861AbcIUMPc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Sep 2016 08:15:32 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id u8LCEQdQ004595
        for <linux-pci@vger.kernel.org>; Wed, 21 Sep 2016 08:15:32 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
        by mx0a-001b2d01.pphosted.com with ESMTP id 25k31bump7-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pci@vger.kernel.org>; Wed, 21 Sep 2016 08:15:31 -0400
Received: from localhost
        by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
        Wed, 21 Sep 2016 22:15:28 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
        by d23dlp01.au.ibm.com (Postfix) with ESMTP id D44952CE8046
        for <linux-pci@vger.kernel.org>; Wed, 21 Sep 2016 22:15:26 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
        by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u8LCFQel721184
        for <linux-pci@vger.kernel.org>; Wed, 21 Sep 2016 22:15:26 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
        by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u8LCFQax012573
        for <linux-pci@vger.kernel.org>; Wed, 21 Sep 2016 22:15:26 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org, linuxppc-dev@ozlabs.org
Cc: bhelgaas@google.com, mpe@ellerman.id.au,
        Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH 1/4] powerpc/eeh: Allow to freeze PE in eeh_pe_set_option()
Date: Wed, 21 Sep 2016 22:15:27 +1000
In-Reply-To: <1474460130-8316-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1474460130-8316-1-git-send-email-gwshan@linux.vnet.ibm.com>
Message-Id: <1474460130-8316-2-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Function eeh_pe_set_option() is used to apply the requested options
(enable, disable, unfreeze) in EEH virtualization path. The semantics
of this function isn't complete until freezing is supported.

This allows to freeze the indicated PE. The new semantics is going to
be used in PCI surprise hot remove path, to freeze removed PCI devices
(PE) to avoid unexpected EEH error reporting.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 7429556..0699f15 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -1502,6 +1502,7 @@ int eeh_pe_set_option(struct eeh_pe *pe, int option)
 		break;
 	case EEH_OPT_THAW_MMIO:
 	case EEH_OPT_THAW_DMA:
+	case EEH_OPT_FREEZE_PE:
 		if (!eeh_ops || !eeh_ops->set_option) {
 			ret = -ENOENT;
 			break;
-- 
2.1.0

