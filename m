Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f170.google.com ([209.85.220.170]:33266 "EHLO
	mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713AbcGDQPH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 4 Jul 2016 12:15:07 -0400
Received: by mail-qk0-f170.google.com with SMTP id e3so67300426qkd.0
        for <linux-pci@vger.kernel.org>; Mon, 04 Jul 2016 09:15:07 -0700 (PDT)
From: Pratyush Anand <panand@redhat.com>
To: dongbo4@huawei.com, bhelgaas@google.com, jingoohan1@gmail.com
Cc: linux-pci@vger.kernel.org, Pratyush Anand <panand@redhat.com>
Subject: [PATCH 0/2] pcie/designware: Viewport assignment update
Date: Mon,  4 Jul 2016 21:44:41 +0530
Message-Id: <cover.1467647958.git.panand@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Most of the designware PCIe platforms have more than 2 viewports. So, patch
1/2 allows to fix viewport-2 for IO transaction for such cases.
When we have only two viewports, then patch 2/2 exchange viewport
assignment of memory and cfg transaction. It helps to fix a possibility of
corruption for memory transaction. However, there still exist possibility
of an IO transaction to be corrupted. We can not do much for <=2 viewports.
See, patch log for detail.

Dong Bo (1):
  pcie/designware: Exchange viewport of `MEMORYs' and `CFGs/IOs'

Pratyush Anand (1):
  pcie/designware: Keep viewport fixed for IO transaction if
    num_viewport > 2

 .../devicetree/bindings/pci/designware-pcie.txt    |  3 ++
 drivers/pci/host/pcie-designware.c                 | 32 +++++++++++++++-------
 drivers/pci/host/pcie-designware.h                 |  1 +
 3 files changed, 26 insertions(+), 10 deletions(-)

-- 
2.5.5

