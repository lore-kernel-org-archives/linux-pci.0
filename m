Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pl0-f67.google.com ([209.85.160.67]:39204 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933801AbeEWR6l (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 May 2018 13:58:41 -0400
Received: by mail-pl0-f67.google.com with SMTP id c19-v6so13481709pls.6
        for <linux-pci@vger.kernel.org>; Wed, 23 May 2018 10:58:41 -0700 (PDT)
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
Subject: [PATCH v2 0/5] Expose PCIe AER stats via sysfs
Date: Wed, 23 May 2018 10:58:03 -0700
Message-Id: <20180523175808.28030-1-rajatja@google.com>
In-Reply-To: <20180522222805.80314-1-rajatja@google.com>
References: <20180522222805.80314-1-rajatja@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patchset exposes the AER stats via the sysfs attributes.

Patchset v2 has minor changes to v1 based on the review comments,
no functional change.
Primarily:
 * Fix license header
 * Use tabs instead of spaces
 * Remove use on unlikely() etc
 * Move documentation to Documentation/ABI/

Rajat Jain (5):
  PCI/AER: Define and allocate aer_stats structure for AER capable
    devices
  PCI/AER: Add sysfs stats for AER capable devices
  PCI/AER: Add sysfs attributes to provide breakdown of AERs
  PCI/AER: Add sysfs attributes for rootport cumulative stats
  Documentation/ABI: Add details of PCI AER statistics

 .../testing/sysfs-bus-pci-devices-aer_stats   | 103 ++++++++++
 Documentation/PCI/pcieaer-howto.txt           |   5 +
 drivers/pci/pci-sysfs.c                       |   3 +
 drivers/pci/pci.h                             |   4 +-
 drivers/pci/pcie/aer/Makefile                 |   2 +-
 drivers/pci/pcie/aer/aerdrv.h                 |  15 ++
 drivers/pci/pcie/aer/aerdrv_core.c            |  11 +
 drivers/pci/pcie/aer/aerdrv_errprint.c        |   7 +-
 drivers/pci/pcie/aer/aerdrv_stats.c           | 192 ++++++++++++++++++
 drivers/pci/probe.c                           |   1 +
 include/linux/pci.h                           |   3 +
 11 files changed, 342 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
 create mode 100644 drivers/pci/pcie/aer/aerdrv_stats.c

-- 
2.17.0.441.gb46fe60e1d-goog
