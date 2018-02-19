Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932169AbeBSXNz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 19 Feb 2018 18:13:55 -0500
Subject: [PATCH v1 0/2] PCI/PM: Add comments,
 allow PM of conventional & hotplug bridges
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-pm@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Peter Wu <peter@lekensteyn.nl>,
        Qipeng Zha <qipeng.zha@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        Dave Airlie <airlied@gmail.com>, Qi Zheng <qi.zheng@intel.com>
Date: Mon, 19 Feb 2018 17:13:53 -0600
Message-ID: <151908155159.37696.9710083237704994886.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add comments to help explain why the code in pci_bridge_d3_possible()
doesn't match the spec (we disallow D3 for conventional PCI bridges and for
hotplug bridges, and the spec seems to suggest that D3 could work in both
of those situations).

Make "pcie_port_pm=force" and "pcie_port_pm=off" apply to all PCI bridges
including conventional PCI bridges and hotplug bridges.  This is a little
speculative.  Those parameters are risky to begin with (otherwise
"pcie_port_pm=force" would be the default); this would make them more
general-purpose but obviously also even more risky.

---

Bjorn Helgaas (2):
      PCI: Add PCIe port runtime suspend details
      PCI: Allow user to request power management of conventional and hotplug bridges


 Documentation/admin-guide/kernel-parameters.txt |    8 ++---
 drivers/pci/pci.c                               |   40 +++++++++++++++++------
 2 files changed, 34 insertions(+), 14 deletions(-)
