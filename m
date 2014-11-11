Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2on0123.outbound.protection.outlook.com ([65.55.169.123]:21047
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751086AbaKKTRt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 11 Nov 2014 14:17:49 -0500
From: <suravee.suthikulpanit@amd.com>
To: <bhelgaas@google.com>
CC: <liviu.dudau@arm.com>, <lorenzo.pieralisi@arm.com>,
	<will.deacon@arm.com>, <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Subject: [PATCH V2 0/2] PCI: generic: Assiging msi-controller to PCI hostbridge
Date: Tue, 11 Nov 2014 13:17:32 -0600
Message-ID: <1415733454-24322-1-git-send-email-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

This patch set introduces a new callback function to allow PCI host drivers
to specify MSI controller to be used for the child buses / devices.

This is reabased from:
    git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/host-generic

Changes from V1:
    - Adding "msi-parent" device tree binding in documentation.
    - Rebase the patch to get rid of artifacts from other precursor patch
      accidently applied to the developement tree. This should now apply cleanly
      to the pci/host-generic branch.

Suravee Suthikulpanit (2):
  PCI: Add new pci_ops for setting MSI parent for PCI bus
  PCI: generic: Add set_msi_parent callback

 Documentation/devicetree/bindings/pci/host-generic-pci.txt |  3 +++
 drivers/pci/host/pci-host-generic.c                        | 13 +++++++++++++
 drivers/pci/probe.c                                        |  3 +++
 include/linux/pci.h                                        |  1 +
 4 files changed, 20 insertions(+)

-- 
1.9.3

