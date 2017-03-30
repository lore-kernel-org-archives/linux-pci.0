Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:49700 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933551AbdC3Nan (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Mar 2017 09:30:43 -0400
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org, timur@codeaurora.org
Cc: mayurkumar.patel@intel.com, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>
Subject: [PATCH V7 0/5] PCI/ASPM: reconfigure ASPM following hotplug for POLICY_DEFAULT
Date: Thu, 30 Mar 2017 09:30:31 -0400
Message-Id: <1490880636-30542-1-git-send-email-okaya@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When the operating system is booted with the default ASPM policy
(POLICY_DEFAULT), current code is querying the enable/disable
states from ASPM registers to determine the policy.

For example, a BIOS could set the power saving state to performance
and clear all ASPM control registers. A balanced ASPM policy could
enable L0s and disable L1. A power conscious BIOS could enable both
L0s and L1 to trade off latency and performance vs. power.

After hotplug removal, pcie_aspm_exit_link_state() function clears
the ASPM registers. An insertion following hotplug removal reads
incorrect policy as ASPM disabled even though ASPM was enabled
during boot.

This is caused by the fact that same function is used for reconfiguring
ASPM regardless of the power on state.

------------------------
Changes from v6 (https://www.spinics.net/lists/arm-kernel/msg572876.html)
------------------------
- revert the accidental parent check in bridge remove

Sinan Kaya (5):
  PCI/ASPM: introduce pci_aspm_init() and add to pci_init_capabilities()
  PCI/ASPM: split pci_aspm_init() into two
  PCI/ASPM: add init hook to device_add
  PCI/ASPM: save power on values during bridge init
  PCI/ASPM: move link_state cleanup to bridge remove

 drivers/pci/pcie/aspm.c | 137 ++++++++++++++++++++++++++++++++----------------
 drivers/pci/probe.c     |   3 ++
 drivers/pci/remove.c    |   3 +-
 include/linux/pci.h     |   2 +
 4 files changed, 98 insertions(+), 47 deletions(-)

-- 
1.9.1
