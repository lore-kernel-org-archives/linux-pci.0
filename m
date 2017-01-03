Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f46.google.com ([74.125.83.46]:33179 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934517AbdACGe3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Jan 2017 01:34:29 -0500
Received: by mail-pg0-f46.google.com with SMTP id g1so172295615pgn.0
        for <linux-pci@vger.kernel.org>; Mon, 02 Jan 2017 22:34:28 -0800 (PST)
From: Rajat Jain <rajatja@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Keith Busch <keith.busch@intel.com>,
        Andreas Ziegler <andreas.ziegler@fau.de>,
        Jonathan Yong <jonathan.yong@intel.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        David Daney <david.daney@cavium.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Ram Amrani <Ram.Amrani@cavium.com>,
        Doug Ledford <dledford@redhat.com>,
        Wang Sheng-Hui <shhuiw@foxmail.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Rajat Jain <rajatja@google.com>, Rajat Jain <rajatxjain@gmail.com>,
        Brian Norris <briannorris@google.com>
Subject: [PATCH 0/6] PCI/ASPM: Add PCIe L1 PM substate support
Date: Mon,  2 Jan 2017 22:34:09 -0800
Message-Id: <1483425255-101923-1-git-send-email-rajatja@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patchset adds the PCIe L1 PM substate support to the kernel.
The feature is described at:
https://pcisig.com/sites/default/files/specification_documents/ECN_L1_PM_Substates_with_CLKREQ_31_May_2013_Rev10a.pdf

Its all logically one patch (and may be some of them should be
squashed later) , but I've broken down into smaller patches for
ease of review. 

This is currently rebased on top of Bjorn's master branch.

Rajat Jain (6):
  PCI: Add L1 substate capability structure register definitions
  PCI/ASPM: Introduce L1 substates and a Kconfig for it
  PCI/ASPM: Read and setup L1 substate capabilities
  PCI/ASPM: Calculate and save the L1.2 timing parameters
  PCI/ASPM: Actually configure the L1 substate settings to the device
  PCI/ASPM: Add comment about L1 substate latency

 drivers/pci/pcie/Kconfig      |   8 ++
 drivers/pci/pcie/aspm.c       | 291 ++++++++++++++++++++++++++++++++++++++++--
 include/uapi/linux/pci_regs.h |  16 +++
 3 files changed, 302 insertions(+), 13 deletions(-)

-- 
2.8.0.rc3.226.g39d4020

