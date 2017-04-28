Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:9878 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2998869AbdD1Pzw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 28 Apr 2017 11:55:52 -0400
From: Keith Busch <keith.busch@intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc: Wesley Yung <wesley.yung@microsemi.com>,
        Sammy Hui <sammy.hui@intel.com>,
        Joseph Gruher <joseph.r.gruher@intel.com>,
        Wei Zhang <wzhang@fb.com>, Krishna Dhulipala <krishnad@fb.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 0/2] pcie/dpc: Fixes
Date: Fri, 28 Apr 2017 12:02:47 -0400
Message-Id: <1493395369-20225-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

Two small patches for bugs found from testing on new platforms and
hardware.

Keith Busch (2):
  pcie/dpc: Skip DPC event if device is not present
  pcie/dpc: Fix control register setting

 drivers/pci/pcie/pcie-dpc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.7.2
