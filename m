Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:36063 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751700AbbIQWlm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 17 Sep 2015 18:41:42 -0400
From: David Daney <ddaney.cavm@gmail.com>
To: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	Marc Zyngier <marc.zyngier@arm.com>
Cc: David Daney <david.daney@cavium.com>
Subject: [PATCH 0/3] PCI: Add support for Cavium ThunderX RC and on-SoC devices.
Date: Thu, 17 Sep 2015 15:41:31 -0700
Message-Id: <1442529694-1792-1-git-send-email-ddaney.cavm@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: David Daney <david.daney@cavium.com>

The Cavium ThunderX arm64 based SoC needs a little bit of special
handling for both its PCIe Root Complexes as well as on-SoC devices
(which all appear as PCIe devices).

1/3 - Small change to allow SRIOV BARs to be given fixed addresses in
      the header fixup.

2/3 - Add quirks to support fixed BAR addresses for all on-SoC devices,
      including SRIOV BARs in the NIC.

3/3 - Add config spaces accessors to pci-host-generic driver for ThunderX RC.

This patch set depends on:

https://lkml.org/lkml/2015/9/17/799

David Daney (3):
  PCI: Allow quirks to override SRIOV BARs.
  PCI: Add quirks for devices found on Cavium ThunderX SoCs.
  PCI: generic: Add support for Cavium ThunderX PCIe root complexes.

 .../devicetree/bindings/pci/host-generic-pci.txt   |  8 +-
 drivers/pci/host/Kconfig                           |  6 ++
 drivers/pci/host/Makefile                          |  1 +
 drivers/pci/host/pci-host-generic.c                | 29 +++++++
 drivers/pci/host/quirks-thunder.c                  | 95 ++++++++++++++++++++++
 drivers/pci/iov.c                                  |  9 +-
 6 files changed, 143 insertions(+), 5 deletions(-)
 create mode 100644 drivers/pci/host/quirks-thunder.c

-- 
1.9.1

