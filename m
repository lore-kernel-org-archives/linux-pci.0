Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752232AbdLBVpm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 2 Dec 2017 16:45:42 -0500
Subject: [PATCH v1 0/2] PCI/ASPM: Refine L1 PM Substates support
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Kenji Chen <kenji.chen@intel.com>,
        Thierry Reding <treding@nvidia.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        David Daney <david.daney@cavium.com>,
        Krishna Kishore <kthota@nvidia.com>,
        linux-kernel@vger.kernel.org, Vidya Sagar <vidyas@nvidia.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        linux-tegra@vger.kernel.org, Patrick Georgi <pgeorgi@chromium.org>,
        Rajat Jain <rajatja@google.com>,
        Yinghai Lu <yinghai@kernel.org>,
        Stefan Reinauer <stefan.reinauer@coreboot.org>,
        Duncan Laurie <dlaurie@chromium.org>
Date: Sat, 02 Dec 2017 15:45:38 -0600
Message-ID: <20171202211833.23146.5744.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The PCIe active link power state is L0.  ASPM defines two low-power
states: L0s and L1.  The L1 PM Substates feature defines two
additional low-power states: L1.1 and L2.2.

The L1.2 state may have substantial entry/exit latency.  Downstream
devices can use the Latency Tolerance Reporting (LTR) feature to
report how much latency they can tolerate.  The L1 PM Substates
capability includes a programmable L1.2 threshold register.  If the
downstream devices can tolerate the latency indicated by the
threshold, L1.2 may be used.

If LTR is not enabled, the L1.2 threshold is ignored and L1.2 can be
used whenever it is enabled and CLKREQ# is de-asserted.  Linux
currently never enables LTR, but firmware may have done so.

The current L1 PM substates support in Linux sets the L1.2 threshold
to a fixed value (163.84us) copied from coreboot [1].  I don't know
where that value came from, and it is incorrect for some platforms,
e.g., Tegra [2].

These patches change that so we calculate the L1.2 threshold based on
values reported by the hardware, and we enable LTR whenever possible.

This is all just my understanding from reading the spec.  I'd be glad
to be corrected if I'm going wrong.

I'm particularly puzzled about the coreboot code in
pciexp_L1_substate_commit() that sets LTR_L1.2_THRESHOLD:

+	pcie_update_cfg(root, root_cap + 0x08, ~0xe3ff0000,
+		(1 << 21) | (1 << 23) | (1 << 30));

This is writing the L1 PM Substates Control 1 register, but the shifts
don't match up with any of the fields in the register, so this is an
awfully funny way to write the threshold.

[1] https://mail.coreboot.org/pipermail/coreboot-gerrit/2015-March/021134.html
[2] https://lkml.kernel.org/r/1510492674-12786-1-git-send-email-vidyas@nvidia.com

---

Bjorn Helgaas (2):
      PCI/ASPM: Calculate LTR_L1.2_THRESHOLD from device characteristics
      PCI/ASPM: Enable Latency Tolerance Reporting when supported


 drivers/pci/pcie/aspm.c |   71 +++++++++++++++++++++++++++++++----------------
 drivers/pci/probe.c     |   33 ++++++++++++++++++++++
 include/linux/pci.h     |    2 +
 3 files changed, 82 insertions(+), 24 deletions(-)
