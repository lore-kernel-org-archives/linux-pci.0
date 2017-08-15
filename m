Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wr0-f182.google.com ([209.85.128.182]:38887 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752797AbdHOFz4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Aug 2017 01:55:56 -0400
Received: by mail-wr0-f182.google.com with SMTP id m57so91862wrm.5
        for <linux-pci@vger.kernel.org>; Mon, 14 Aug 2017 22:55:56 -0700 (PDT)
From: Oza Pawandeep <oza.oza@broadcom.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Oza Pawandeep <oza.oza@broadcom.com>,
        Andy Gospodarek <gospo@broadcom.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Oza Pawandeep <oza.pawandeep@gmail.com>
Subject: [PATCH v2 0/3] PCI hotplug feature
Date: Tue, 15 Aug 2017 11:25:44 +0530
Message-Id: <1502776547-30542-1-git-send-email-oza.oza@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

These patches bring in PCI hotplug support for iproc family chipsets.

It includes DT binding documentation update and, implementation in
iproc pcie RC driver.

These patch set is made on top of following patches.
[PATCH v6 2/2] PCI: iproc: add device shutdown for PCI RC
[PATCH v6 1/2] PCI: iproc: Retry request when CRS returned from EP

Changes since v2:
Addressed Rob Herring's comments.
Made generic PCI hotplug properties 'slot-pluggable' and 'prsnt-gpios'

Oza Pawandeep (3):
  PCI: iproc: Implement PCI hotplug support
  Documentation/devicetree: Add PCIe hotplug property
  PCI: iproc: Implement optional property prsnt-gpios

 .../devicetree/bindings/pci/brcm,iproc-pcie.txt    |  14 +++
 Documentation/devicetree/bindings/pci/pci.txt      |  15 +++
 drivers/pci/host/pcie-iproc-platform.c             |   3 +
 drivers/pci/host/pcie-iproc.c                      | 130 ++++++++++++++++++++-
 drivers/pci/host/pcie-iproc.h                      |   7 ++
 5 files changed, 163 insertions(+), 6 deletions(-)

-- 
1.9.1
