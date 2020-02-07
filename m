Return-Path: <SRS0=3oUy=34=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15AAAC2BA83
	for <linux-pci@archiver.kernel.org>; Sat,  8 Feb 2020 00:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB95422314
	for <linux-pci@archiver.kernel.org>; Sat,  8 Feb 2020 00:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbgBHAAO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 7 Feb 2020 19:00:14 -0500
Received: from mga03.intel.com ([134.134.136.65]:58200 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727032AbgBHAAO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Feb 2020 19:00:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Feb 2020 16:00:13 -0800
X-IronPort-AV: E=Sophos;i="5.70,415,1574150400"; 
   d="scan'208";a="225545673"
Received: from nsgsw-rhel7p6.lm.intel.com ([10.232.116.83])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Feb 2020 16:00:12 -0800
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Pawel Baldysiak <pawel.baldysiak@intel.com>,
        Sinan Kaya <okaya@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Keith Busch <kbusch@kernel.org>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [RFC 0/9] PCIe Hotplug Slot Emulation driver
Date:   Fri,  7 Feb 2020 16:59:58 -0700
Message-Id: <1581120007-5280-1-git-send-email-jonathan.derrick@intel.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This set adds an emulation driver for PCIe Hotplug. There may be platforms with
specific configurations that can support hotplug but don't provide the logical
slot hotplug hardware. For instance, the platform may use an
electrically-tolerant interposer between the slot and the device.

This driver utilizes the pci-bridge-emul architecture to manage register reads
and writes. The underlying functionality of the hotplug emulation driver uses
the Data Link Layer Link Active Reporting mechanism in a polling loop, but can
tolerate other event sources such as AER or DPC.

When enabled and a slot is managed by the driver, all port services are managed
by the kernel. This is done to ensure that firmware hotplug and error
architecture does not (correctly) halt/machine check the system when hotplug is
performed on a non-hotplug slot.

The driver offers two active mode: Auto and Force.
auto: The driver will bind to non-hotplug slots
force: The driver will bind to all slots and overrides the slot's services

There are three kernel params:
pciehp.pciehp_emul_mode={off, auto, force}
pciehp.pciehp_emul_time=<msecs polling time> (def 1000, min 100, max 60000)
pciehp.pciehp_emul_ports=<PCI [S]BDF/ID format string>

The pciehp_emul_ports kernel parameter takes a semi-colon tokenized string
representing PCI [S]BDFs and IDs. The pciehp_emul_mode will then be applied to
only those slots, leaving other slots unmanaged by pciehp_emul.

The string follows the pci_dev_str_match() format:

  [<domain>:]<bus>:<device>.<func>[/<device>.<func>]*
  pci:<vendor>:<device>[:<subvendor>:<subdevice>]

When using the path format, the path for the device can be obtained
using 'lspci -t' and further specified using the upstream bridge and the
downstream port's device-function to be more robust against bus
renumbering.

When using the vendor-device format, a value of '0' in any field acts as
a wildcard for that field, matching all values.

The driver is enabled with CONFIG_HOTPLUG_PCI_PCIE_EMUL=y.

The driver should be considered 'use at own risk' unless the platform/hardware
vendor recommends this mode.

Jon Derrick (9):
  PCI: pci-bridge-emul: Update PCIe register behaviors
  PCI: pci-bridge-emul: Eliminate reserved member
  PCI: pci-bridge-emul: Provide a helper to set behavior
  PCI: pciehp: Indirect slot register operations
  PCI: Add pcie_port_slot_emulated stub
  PCI: pciehp: Expose the poll loop to other drivers
  PCI: Move pci_dev_str_match to search.c
  PCI: pciehp: Add hotplug slot emulation driver
  PCI: pciehp: Wire up pcie_port_emulate_slot and pciehp_emul

 drivers/pci/hotplug/Makefile      |   4 +
 drivers/pci/hotplug/pciehp.h      |  28 +++
 drivers/pci/hotplug/pciehp_emul.c | 378 ++++++++++++++++++++++++++++++++++++++
 drivers/pci/hotplug/pciehp_hpc.c  | 136 ++++++++++----
 drivers/pci/pci-acpi.c            |   3 +
 drivers/pci/pci-bridge-emul.c     |  95 +++++-----
 drivers/pci/pci-bridge-emul.h     |  10 +
 drivers/pci/pci.c                 | 163 ----------------
 drivers/pci/pcie/Kconfig          |  14 ++
 drivers/pci/pcie/portdrv_core.c   |  14 +-
 drivers/pci/probe.c               |   2 +-
 drivers/pci/search.c              | 162 ++++++++++++++++
 include/linux/pci.h               |   8 +
 13 files changed, 775 insertions(+), 242 deletions(-)
 create mode 100644 drivers/pci/hotplug/pciehp_emul.c

-- 
1.8.3.1

