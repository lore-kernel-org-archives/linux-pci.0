Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33311 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751537AbcKGJWh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Nov 2016 04:22:37 -0500
From: "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        tom_tsai@fintek.com.tw, peter_hong@fintek.com.tw,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Subject: [PATCH 0/2] PCI: Add quirk for Fintek F81504/508/512 on Skylake
Date: Mon,  7 Nov 2016 17:22:30 +0800
Message-Id: <1478510552-4883-1-git-send-email-hpeter+linux_kernel@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We had tested Fintek F81504/508/512 PCIe-to-UART/GPIO on Intel Skylake
platform. It's maybe flood AER correctable error interrupt and slow down
the system boot. It's the same issue about below link:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1521173

and this IC will malfunctional after suspend/resume (S3, D0->D3->D0) on
Skylake platform. 

The first patch will use parent AER interrupt mask to prevent generating
correctable error interrupt, the  and second will prevent the IC malfunctional
after D3.

Ji-Ze Hong (Peter Hong) (2):
  PCI: Add quirk for Fintek F81504/508/512 AER issue
  PCI: Add quirk for Fintek F81504/508/512 D3 issue

 drivers/pci/quirks.c    | 50 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci_ids.h |  5 +++++
 2 files changed, 55 insertions(+)

-- 
1.9.1

