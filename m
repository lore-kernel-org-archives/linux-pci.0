Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:48486 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751096AbdK0GUg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Nov 2017 01:20:36 -0500
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org, timur@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>
Subject: [PATCH V2 0/7] PCI: handle CRS response following Hot Reset and D3hot->D0
Date: Mon, 27 Nov 2017 01:20:21 -0500
Message-Id: <1511763628-11856-1-git-send-email-okaya@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Rev 3.1 Sec 2.3.1 Request Handling Rules:
Valid reset conditions after which a device is permitted to return CRS
are:
* Cold, Warm, and Hot Resets,
* FLR
* A reset initiated in response to a D3hot to D0 uninitialized

Try to reuse FLR implementation towards other reset types.

Changes from v1:
* PCI: add a return type for pci_reset_bridge_secondary_bus()
* set waittime as a global variable and have a kernel command line to
* override.
* get rid of initial sleep parameter

Sinan Kaya (7):
  PCI: protect restore with device lock to be consistent
  PCI: handle FLR failure and allow other reset types
  PCI: make pci_flr_wait() generic and rename to pci_dev_wait()
  PCI: wait device ready after pci_pm_reset()
  PCI: add a return type for pci_reset_bridge_secondary_bus()
  PCI: add device wait after slot and bus reset
  PCI: make reset poll time adjustable

 Documentation/admin-guide/kernel-parameters.txt |  2 +
 drivers/pci/pci.c                               | 72 ++++++++++++++++---------
 include/linux/pci.h                             |  4 +-
 3 files changed, 51 insertions(+), 27 deletions(-)

-- 
1.9.1
