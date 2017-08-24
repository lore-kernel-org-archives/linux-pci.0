Return-Path: <SRS0=+FHt=72=broadcom.com=oza.oza@kernel.org>
Return-Path: <SRS0=+FHt=72=broadcom.com=oza.oza@kernel.org>
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
Subject: [PATCH v4 0/3] PCI hotplug feature
Date: Thu, 24 Aug 2017 14:19:05 +0530
Message-Id: <1503564548-1834-1-git-send-email-oza.oza@broadcom.com>
List-ID: <linux-pci.vger.kernel.org>

These patches bring in PCI hotplug support for iproc family chipsets.

It includes DT binding documentation update and, implementation in
iproc pcie RC driver.

These patch set is made on top of following patches.
[PATCH v8 2/2] PCI: iproc: add device shutdown for PCI RC
[PATCH v8 1/2] PCI: iproc: Retry request when CRS returned from EP

Changes since v3:
Resend. just to be in sync previous in-flight patches.

Changes since v2:
Addressed Rob Herring's comments.
Changed subject to "dt-bindings: PCI:..."
Made generic PCI hotplug properties 'slot-pluggable' and 'prsnt-gpios'
Rebased the patches on top of Lorenzo's patches.

Oza Pawandeep (3):
  PCI: iproc: implement PCI hotplug support
  dt-bindings: PCI: add PCIe hotplug property
  dt-bindings: PCI iproc: add optional property prsnt-gpios

 .../devicetree/bindings/pci/brcm,iproc-pcie.txt    |  14 ++
 Documentation/devicetree/bindings/pci/pci.txt      |  15 ++
 drivers/pci/host/pcie-iproc-platform.c             |   3 +
 drivers/pci/host/pcie-iproc.c                      | 166 ++++++++++++++++++---
 drivers/pci/host/pcie-iproc.h                      |   7 +
 5 files changed, 187 insertions(+), 18 deletions(-)

-- 
1.9.1
