Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:50188 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752656AbdC2XEf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Mar 2017 19:04:35 -0400
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org, timur@codeaurora.org
Cc: mayurkumar.patel@intel.com, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>
Subject: [PATCH V6 0/5] PCI/ASPM: reconfigure ASPM following hotplug for POLICY_DEFAULT
Date: Wed, 29 Mar 2017 19:04:22 -0400
Message-Id: <1490828667-30973-1-git-send-email-okaya@codeaurora.org>
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
Changes from v5 (https://www.spinics.net/lists/arm-kernel/msg571758.html)
------------------------
- rebase to 4.11-rc3
- Split pci_aspm_init() body into pci_aspm_init_upstream()
  and pci_aspm_init_downstream() for bridge and endpoint
  specific code behavior.
- Get rid of function0 function.
  Detect downstream link in pci_aspm_init_upstream() instead

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
