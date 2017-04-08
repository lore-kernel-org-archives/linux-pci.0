Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org,
	timur@codeaurora.org
Subject: [PATCH V8 0/5] PCI/ASPM: reconfigure ASPM following hotplug for
 POLICY_DEFAULT
Date: Sat,  8 Apr 2017 00:55:46 -0400
Message-Id: <1491627351-1111-1-git-send-email-okaya@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Sinan Kaya <okaya@codeaurora.org>, linux-arm-msm@vger.kernel.org,
 mayurkumar.patel@intel.com, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
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
Changes from v7 (https://www.spinics.net/lists/arm-kernel/msg573034.html)
------------------------
- enable LTSSM as a best effort if the endpoint is not connected during
  boot


Sinan Kaya (5):
  PCI/ASPM: introduce pci_aspm_init() and add to pci_init_capabilities()
  PCI/ASPM: split pci_aspm_init() into two
  PCI/ASPM: add init hook to device_add
  PCI/ASPM: save power on values during bridge init
  PCI/ASPM: move link_state cleanup to bridge remove

 drivers/pci/pcie/aspm.c | 149 +++++++++++++++++++++++++++++++++---------------
 drivers/pci/probe.c     |   3 +
 drivers/pci/remove.c    |   3 +-
 include/linux/pci.h     |   2 +
 4 files changed, 110 insertions(+), 47 deletions(-)

-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
