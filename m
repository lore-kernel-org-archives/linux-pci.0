Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35916 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750775AbdHQIPD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Aug 2017 04:15:03 -0400
From: Jan Glauber <jglauber@cavium.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>
Cc: linux-kernel@vger.kernel.org, david.daney@cavium.com,
        Jon Masters <jcm@redhat.com>,
        Robert Richter <robert.richter@cavium.com>,
        linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
        Jan Glauber <jglauber@cavium.com>
Subject: [PATCH v2 0/3] Workaround for bus reset on Cavium cn8xxx root ports
Date: Thu, 17 Aug 2017 10:14:20 +0200
Message-Id: <1502957663-5527-1-git-send-email-jglauber@cavium.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I've picked this up from David, keeping his patches but preventing to
probe vfio-pci devices that can't be reset. 

Without this series starting qemu with a vfio-pci enabled device
can lead to a kernel panic on Cavium systems, depending on the used
hardware.

Changes to v1 (https://lkml.org/lkml/2017/5/15/934):
- Prevent probing by vfio-pci

David Daney (2):
  PCI: Allow PCI_DEV_FLAGS_NO_BUS_RESET to be used on bus device
  PCI: Avoid bus reset for Cavium cn8xxx root ports

Jan Glauber (1):
  vfio/pci: Don't probe devices that can't be reset

 drivers/pci/pci.c           | 4 ++++
 drivers/pci/quirks.c        | 8 ++++++++
 drivers/vfio/pci/vfio_pci.c | 6 ++++++
 3 files changed, 18 insertions(+)

-- 
2.9.0.rc0.21.g7777322
