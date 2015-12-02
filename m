Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:28365 "EHLO
	mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754437AbbLBWD7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 2 Dec 2015 17:03:59 -0500
From: Jayachandran C <jchandra@broadcom.com>
To: <linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: Jayachandran C <jchandra@broadcom.com>
Subject: [RFC PATCH 0/3] ACPI PCI support for arm64
Date: Thu, 3 Dec 2015 03:54:43 +0530
Message-ID: <1449095086-5138-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is a very simple and generic implementation of a PCI host controller
based on ACPI. This approach does not pull in the MMCONFIG and ECAM code
from x86.

It is important for us to have a working ACPI based PCI host controller
implementation for arm64, so I thought I would post this as a simple
and less disruptive alternative.

This is tested with arm64 QEMU and OVMF. Comments are very welcome.

Thanks,
JC.

Jayachandran C (3):
  arm64: pci: Add ACPI support
  pci: Handle NULL parent in pci_bus_assign_domain_nr
  pci/host : Add a generic ACPI based host controller

 arch/arm64/kernel/pci.c          |  47 ++++++++-
 drivers/pci/host/Kconfig         |   7 ++
 drivers/pci/host/Makefile        |   1 +
 drivers/pci/host/pci-host-acpi.c | 211 +++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.c                |   7 +-
 5 files changed, 270 insertions(+), 3 deletions(-)
 create mode 100644 drivers/pci/host/pci-host-acpi.c

-- 
1.9.1

