Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56676 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755262AbdBOXXo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Feb 2017 18:23:44 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v1FNIta2017874
        for <linux-pci@vger.kernel.org>; Wed, 15 Feb 2017 18:23:38 -0500
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
        by mx0b-001b2d01.pphosted.com with ESMTP id 28mswt8n3q-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pci@vger.kernel.org>; Wed, 15 Feb 2017 18:23:37 -0500
Received: from localhost
        by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
        Thu, 16 Feb 2017 09:23:35 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
        by d23dlp01.au.ibm.com (Postfix) with ESMTP id A2EAF2CE805E
        for <linux-pci@vger.kernel.org>; Thu, 16 Feb 2017 10:23:32 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
        by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id v1FNNOEv19005576
        for <linux-pci@vger.kernel.org>; Thu, 16 Feb 2017 10:23:32 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
        by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id v1FNN0ZJ027378
        for <linux-pci@vger.kernel.org>; Thu, 16 Feb 2017 10:23:00 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, mpe@ellerman.id.au, bhelgaas@google.com,
        Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH 0/3] pci/hotplug/pnv-php: More bug fixes
Date: Thu, 16 Feb 2017 10:22:31 +1100
Message-Id: <1487200954-14681-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This series bases on the series: https://patchwork.ozlabs.org/patch/713513.
This series fixes couple of issues:

   * Remove WARN_ON() in pnv_php_put_slot(). The parent slot's refcount
     is decreased when releasing PCI slot. The parent slot can be NULL
     and no need to give a warning.
   * The MSI (or MSIx) could be enabled prior to load pnv-php.ko. A
     backtrace is thrown when phv-php.ko attempts to enable MSI again.
     PATCH[2/3] skips enabling surprise hotplug if MSI has been enabled
     by other driver.
   * PATCH[3/3] doesn't disable MSI that was enabled by other dirver.
     Also, the upstream port of the PCI slot is disabled when it's
     destroyed.

Gavin Shan (3):
  pci/hotplug/pnv-php: Remove WARN_ON() in pnv_php_put_slot()
  pci/hotplug/pnv-php: Disable surprise hotplug capability on conflicts
  pci/hotplug/pnv-php: Disable MSI and PCI device properly

 drivers/pci/hotplug/pnv_php.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

-- 
2.7.4
