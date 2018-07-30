Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:39570 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726562AbeG3PS1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Jul 2018 11:18:27 -0400
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 0/3] PCI: mobiveil: Misc fixes
Date: Mon, 30 Jul 2018 14:43:13 +0100
Message-Id: <20180730134316.11719-1-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Subrahmanya,

I put together this series so that the Mobiveil controller driver
can compile (successfully). Please review and ack as soon as possible
since the current situation is a bit embarassing to be honest, we
should be sending these patches as fixes this week so that they
can make it for v4.18, currently the driver is in the kernel for
nothing.

Thank you
Lorenzo

Cc: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Cc: Bjorn Helgaas <bhelgaas@google.com>

Lorenzo Pieralisi (3):
  PCI: mobiveil: Fix struct mobiveil_pcie.pcie_reg_base address type
  PCI: mobiveil: Add missing ../pci.h include
  PCI: mobiveil: Add Kconfig/Makefile entries

 drivers/pci/controller/Kconfig         | 10 ++++++++++
 drivers/pci/controller/Makefile        |  1 +
 drivers/pci/controller/pcie-mobiveil.c |  4 +++-
 3 files changed, 14 insertions(+), 1 deletion(-)

-- 
2.15.0
