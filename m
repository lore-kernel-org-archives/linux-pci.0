Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34071 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753088AbeEVW2O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 May 2018 18:28:14 -0400
Received: by mail-pf0-f196.google.com with SMTP id a14-v6so9448614pfi.1
        for <linux-pci@vger.kernel.org>; Tue, 22 May 2018 15:28:14 -0700 (PDT)
From: Rajat Jain <rajatja@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rajat Jain <rajatja@google.com>,
        Frederick Lawler <fred@fredlawl.com>,
        Oza Pawandeep <poza@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Thomas Tai <thomas.tai@oracle.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jes Sorensen <jsorensen@fb.com>,
        Kyle McMartin <jkkm@fb.com>
Cc: rajatxjain@gmail.com
Subject: [PATCH 0/5] Expose PCIe AER stats via sysfs
Date: Tue, 22 May 2018 15:28:00 -0700
Message-Id: <20180522222805.80314-1-rajatja@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patchset exposes the AER stats via the sysfs attributes.

Rajat Jain (5):
  PCI/AER: Define and allocate aer_stats structure for AER capable
    devices
  PCI/AER: Add sysfs stats for AER capable devices
  PCP/AER: Add sysfs attributes to provide breakdown of AERs
  PCI/AER: Add sysfs attributes for rootport cumulative stats
  Documentation/PCI: Add details of PCI AER statistics

 Documentation/PCI/pcieaer-howto.txt    |  35 +++++
 drivers/pci/pci-sysfs.c                |   3 +
 drivers/pci/pci.h                      |   4 +-
 drivers/pci/pcie/aer/Makefile          |   2 +-
 drivers/pci/pcie/aer/aerdrv.h          |  15 ++
 drivers/pci/pcie/aer/aerdrv_core.c     |  11 ++
 drivers/pci/pcie/aer/aerdrv_errprint.c |   7 +-
 drivers/pci/pcie/aer/aerdrv_stats.c    | 192 +++++++++++++++++++++++++
 drivers/pci/probe.c                    |   1 +
 include/linux/pci.h                    |   3 +
 10 files changed, 269 insertions(+), 4 deletions(-)
 create mode 100644 drivers/pci/pcie/aer/aerdrv_stats.c

-- 
2.17.0.441.gb46fe60e1d-goog
