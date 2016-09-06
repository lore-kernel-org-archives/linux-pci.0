Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934928AbcIFWTi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Sep 2016 18:19:38 -0400
Subject: [PATCH 0/2] PCI/AER: Remove module parameters
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lance Ortiz <lance.ortiz@hpe.com>, Betty Dall <betty.dall@hpe.com>,
        Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
        Chen Gong <gong.chen@linux.intel.com>,
        KeithBuschkeith.busch@intel.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, Shuah Khan <shuahkh@osg.samsung.com>,
        Huang Ying <ying.huang@intel.com>,
        Vijay Mohan Pandarathil <vijaymohan.pandarathil@hpe.com>,
        Jon Derrick <jonathan.derrick@intel.com>
Date: Tue, 06 Sep 2016 17:19:22 -0500
Message-ID: <20160906221522.23655.66321.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I'd like to remove the aerdriver.nosourceid and aerdriver.forceload kernel
parameters.  They seem like basically debugging things that are not really
supportable upstream.

"nosourceid" may have some legitimate uses, but I'd rather it were done via
quirks with the flag Jon Derrick recently added so it happens
automatically, without users having to specify the parameter.

I don't *know* of any actual users of either of these, but obviously that
doesn't mean there are none.  Comments welcome.

---

Bjorn Helgaas (2):
      PCI/AER: Remove aerdriver.nosourceid kernel parameter
      PCI/AER: Remove aerdriver.forceload kernel parameter


 Documentation/PCI/pcieaer-howto.txt |   26 +++++++++-----------------
 drivers/pci/pcie/aer/aerdrv.c       |    7 +------
 drivers/pci/pcie/aer/aerdrv.h       |    8 --------
 drivers/pci/pcie/aer/aerdrv_core.c  |   31 ++++---------------------------
 4 files changed, 14 insertions(+), 58 deletions(-)
