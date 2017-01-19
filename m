Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:36918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753297AbdASOld (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 19 Jan 2017 09:41:33 -0500
Date: Thu, 19 Jan 2017 08:27:11 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Blake Moore <blake.moore@men.de>,
        Martin Burnicki <martin.burnicki@meinberg.de>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Joao Pinto <jpinto@synopsys.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [GIT PULL] PCI fixes for v4.10
Message-ID: <20170119142711.GA11328@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI fixes:

  - recognize that a PCI-to-PCIe bridge originates a PCIe hierarchy, so we
    enumerate that hierarchy correctly

  - X-Gene: fix a change merged for v4.10 that broke MSI

  - Keystone: avoid reading undefined registers, which can cause
    asynchronous external aborts

  - Supermicro X8DTH-i/6/iF/6F: ignore broken _CRS that caused us to change
    (and break) existing I/O port assignments

The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:

  Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.10-fixes-1

for you to fetch changes up to 4d191b1b63c209e37bf27938ef365244d3c41084:

  PCI/MSI: pci-xgene-msi: Fix CPU hotplug registration handling (2017-01-17 08:41:51 -0600)

----------------------------------------------------------------
pci-v4.10-fixes-1

----------------------------------------------------------------
Bjorn Helgaas (2):
      x86/PCI: Ignore _CRS on Supermicro X8DTH-i/6/iF/6F
      PCI: Enumerate switches below PCI-to-PCIe bridges

Marc Zyngier (1):
      PCI/MSI: pci-xgene-msi: Fix CPU hotplug registration handling

Murali Karicheri (1):
      PCI: designware: Check for iATU unroll only on platforms that use ATU

 arch/x86/pci/acpi.c                | 10 ++++++++++
 drivers/pci/host/pci-xgene-msi.c   |  2 +-
 drivers/pci/host/pcie-designware.c | 10 +++++-----
 drivers/pci/probe.c                | 12 +++++++-----
 4 files changed, 23 insertions(+), 11 deletions(-)
