Return-Path: <SRS0=6tVE=7Y=broadcom.com=oza.oza@kernel.org>
Return-Path: <SRS0=6tVE=7Y=broadcom.com=oza.oza@kernel.org>
From: Oza Pawandeep <oza.oza@broadcom.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	<helgaas@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Jon Mason <jonmason@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	Oza Pawandeep <oza.oza@broadcom.com>,
	Andy Gospodarek <gospo@broadcom.com>,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Oza Pawandeep <oza.pawandeep@gmail.com>
Subject: [PATCH v3 0/3] PCI hotplug feature
Date: Tue, 22 Aug 2017 13:40:53 +0530
Message-Id: <1503389456-27373-1-git-send-email-oza.oza@broadcom.com>
List-ID: <linux-pci.vger.kernel.org>

These patches bring in PCI hotplug support for iproc family chipsets.

It includes DT binding documentation update and, implementation in 
iproc pcie RC driver.

These patch set is made on top of following patches.
[PATCH v7 2/2] PCI: iproc: add device shutdown for PCI RC
[PATCH v7 1/2] PCI: iproc: Retry request when CRS returned from EP

Changes since v2:
Addressed Rob Herring's comments.
Changed subject to "dt-bindings: PCI:..."
Made generic PCI hotplug properties 'slot-pluggable' and 'prsnt-gpios'
Rebased the patches on top of Lorenzo's patches.

Oza Pawandeep (3):
  PCI: iproc: Implement PCI hotplug support
  dt-bindings: PCI: Add PCIe hotplug property
  PCI: iproc: Implement optional property prsnt-gpios

 .../devicetree/bindings/pci/brcm,iproc-pcie.txt    |  14 ++
 Documentation/devicetree/bindings/pci/pci.txt      |  15 ++
 drivers/pci/host/pcie-iproc-platform.c             |   3 +
 drivers/pci/host/pcie-iproc.c                      | 166 ++++++++++++++++++---
 drivers/pci/host/pcie-iproc.h                      |   7 +
 5 files changed, 187 insertions(+), 18 deletions(-)

-- 
1.9.1
