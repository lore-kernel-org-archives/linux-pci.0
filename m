Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51081 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753564AbcKUVJf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2016 16:09:35 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id uALL8OLw090155
        for <linux-pci@vger.kernel.org>; Mon, 21 Nov 2016 16:09:35 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 26v5j4rqns-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pci@vger.kernel.org>; Mon, 21 Nov 2016 16:09:34 -0500
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pci@vger.kernel.org> from <mrochs@linux.vnet.ibm.com>;
        Mon, 21 Nov 2016 16:09:33 -0500
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Ian Munsie <imunsie@au1.ibm.com>,
        Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Cc: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
Subject: [PATCH 0/2] Add device-specific VPD timeout
Date: Mon, 21 Nov 2016 15:03:45 -0600
Message-Id: <1479762225-51440-1-git-send-email-mrochs@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This small patch series introduces support for a driver to increase the
VPD wait timeout for devices with slower interfaces.

The series is based on v4.9-rc6 and is intended for v4.10.

Matthew R. Ochs (2):
  PCI: Add pci_set_vpd_timeout() to set VPD access timeout
  cxl: Set VPD timeout to avoid access failures

 drivers/misc/cxl/pci.c |  7 +++++++
 drivers/pci/access.c   | 45 ++++++++++++++++++++++++++++++++++++++++++++-
 drivers/pci/pci.h      |  2 ++
 include/linux/pci.h    |  1 +
 4 files changed, 54 insertions(+), 1 deletion(-)

-- 
2.1.0

