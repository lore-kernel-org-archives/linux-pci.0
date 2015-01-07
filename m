Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:56818 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752443AbbAGP3t (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 7 Jan 2015 10:29:49 -0500
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Mohit Kumar <mohit.kumar@st.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Rob Herring <robh+dt@kernel.org>
Subject: [RFC PATCH 0/3] drivers: port PCIe designware to new DT parsing API
Date: Wed,  7 Jan 2015 15:29:28 +0000
Message-Id: <1420644571-18928-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The introduction of the DT API:

of_pci_get_host_bridge_resources()

allows to retrieve PCI resources from the device tree in a generic way.

Some PCI host controllers, in addition to standard IO and MEM resources and
corresponding CPU addresses, require to retrieve the addresses that are used
for bus routing of IO/MEM regions as seen at the bus level corresponding
to the bus segment the host controller is sitting on, so that the host
controller can programme its inbound/outbound memory regions correctly to
respond to bus transactions coming from the CPU on the host controller bus
ports.

The DT generic layer provides functions that carry out the PCI
ranges <-> resources translation from PCI addresses to CPU addresses (as
seen at the CPU top level bus, through all required hierarchical bus layers),
but there is no generic API to retrieve the PCI range CPU untranslated
addresses, so PCI host controllers have to do it in a driver specific way
through the DT property parsing methods.

This patchset converts the PCIe designware host controller driver to
use the API:

of_pci_get_host_bridge_resources()

in order to retrieve the PCI regions resources. To achieve generality, it
also augments the parsing API so that a new DT struct is created out of
PCI ranges, that contains the PCI resource and the range parser itself
so that it can be passed back to PCI host controllers drivers that
can, if needed, use it to parse the CPU untranslated addresses
corresponding to the resource in question.

The first patch in the series is a fix/update for the parsing function:

of_pci_get_host_bridge_resources()

It is part of the RFC series since it is a controversial fix to be
discussed before getting merged.

Patch [2-3] augment the parsing API and convert the PCIe designware
driver code.

The current API stays unchanged, so that the existing drivers using it
do not need patching and changes are limited.

Tested on an iMX6 Sabrelite board.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Mohit Kumar <mohit.kumar@st.com>
Cc: Jingoo Han <jg1.han@samsung.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Rob Herring <robh+dt@kernel.org>

Lorenzo Pieralisi (3):
  drivers: of: fix resources freeing in
    of_pci_get_host_bridge_resources()
  drivers: of: of_pci_get_host_bridge_resources() range parsing update
  drivers: pci: host: update the pcie designware driver to new range
    parsing API

 drivers/of/of_pci.c                |  36 +++++++--
 drivers/pci/host/pcie-designware.c | 145 +++++++++++++++++--------------------
 drivers/pci/host/pcie-designware.h |   5 +-
 include/linux/of_address.h         |   5 ++
 4 files changed, 104 insertions(+), 87 deletions(-)

-- 
2.2.1

