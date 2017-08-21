Return-Path: <SRS0=GmMG=7X=broadcom.com=oza.oza@kernel.org>
Return-Path: <SRS0=GmMG=7X=broadcom.com=oza.oza@kernel.org>
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
	linux-kernel@vger.kernel.org,
	Oza Pawandeep <oza.pawandeep@gmail.com>
Subject: [PATCH v7 0/2]  PCI: iproc: SOC specific fixes
Date: Mon, 21 Aug 2017 21:28:42 +0530
Message-Id: <1503331124-25029-1-git-send-email-oza.oza@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

PCI: iproc: Retry request when CRS returned from EP
Above patch adds support for CRS in PCI RC driver, otherwise if not
handled at lower level, the user space PMD (poll mode drivers) can
timeout.

PCI: iproc: add device shutdown for PCI RC
This fixes the issue where certian PCI endpoints are not getting
detected on Stingray SOC after reboot.

Changes Since v6:
Rebased patches on top of Lorenzo's patches.
Bjorn's comments addressed.
now the confg retry returns 0xffffffff as data.
Added reference to PCIe spec and iproc Controller spec in Changelog.

Changes Since v5:
Ray's comments addressed.

Changes Since v4:
Bjorn's comments addressed.

Changes Since v3:
[re-send]

Changes Since v2:
Fix compilation errors for pcie-iproc-platform.ko which was caught by
kbuild.

Oza Pawandeep (2):
  PCI: iproc: Retry request when CRS returned from EP
  PCI: iproc: add device shutdown for PCI RC

 drivers/pci/host/pcie-iproc-platform.c |   8 ++
 drivers/pci/host/pcie-iproc.c          | 142 ++++++++++++++++++++++++++-------
 drivers/pci/host/pcie-iproc.h          |   1 +
 3 files changed, 123 insertions(+), 28 deletions(-)

-- 
1.9.1
