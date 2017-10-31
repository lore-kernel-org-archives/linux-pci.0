Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:6036 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751119AbdJaEZX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Oct 2017 00:25:23 -0400
From: Vidya Sagar <vidyas@nvidia.com>
To: <treding@nvidia.com>, <bhelgaas@google.com>, <rajatja@google.com>,
        <yinghai@kernel.org>, <david.daney@cavium.com>,
        <Julia.Lawall@lip6.fr>
CC: <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>
Subject: [PATCH V2 0/4] Add ASPM-L1 Substates support for Tegra
Date: Tue, 31 Oct 2017 09:52:45 +0530
Message-ID: <1509423769-10522-1-git-send-email-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Tegra chips T210 and T186 support ASPM-L1 Substates (i.e. L1.1 and L1.2)
This patch series
- adds a generic API for root port controller drivers to
  override the default value of LTR L1.2 Threhold which otherwise comes from
  the same APIs weak implementation in aspm.c file
- applies fixups to reflect correct capability values for
  T_cmrt (Common Mode Restore Time) and
  T_pwr_on (Power On)
  and adjusts counter values for 19.2 MHz of clk_m
- applies fixup specific to T210 to avoid unnecessary wake ups from L1.2 state

PCIe - ASPM L1 Sub States spec
https://pcisig.com/sites/default/files/specification_documents/ECN_L1_PM_Substates_with_CLKREQ_31_May_2013_Rev10a.pdf

Testing Done on T210 and T186
- ASPM-L1:
  Verified ASPM-L1 enablement by selecting PCIEASPM_POWERSAVE config
  With the help of Tegra rootport's internal counter registers, confirmed
  link entry in and out of ASPM-L1 state using USB3.0 add-on card, NVMe and NIC
  cards
- ASPM-L1 SubStates:
  Verified ASPM-L1 Substates enablement by selecting PCIEASPM_POWER_SUPERSAVE config
  Confirmed link's entry into L1SS using Westren Digital NVMe card (with Sandisk
  Controller) using Tegra rootport's internal counter registers

Vidya Sagar (4):
  PCI/ASPM: Add API to supply LTR L1.2 threshold
  PCI: tegra: Enable ASPM-L1 capability advertisement
  PCI: tegra: Apply sw fixups to support ASPM-L1 Sub-States
  PCI: tegra: fixups to avoid unnecessary wakeup from ASPM-L1.2

 drivers/pci/host/pci-tegra.c | 99 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pcie/aspm.c      | 11 +++--
 include/linux/pci-aspm.h     |  1 +
 3 files changed, 108 insertions(+), 3 deletions(-)

-- 
2.7.4
