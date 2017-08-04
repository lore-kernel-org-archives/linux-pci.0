Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:35731 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752604AbdHDPsa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Aug 2017 11:48:30 -0400
Received: by mail-wm0-f43.google.com with SMTP id m85so23090883wma.0
        for <linux-pci@vger.kernel.org>; Fri, 04 Aug 2017 08:48:29 -0700 (PDT)
From: Oza Pawandeep <oza.oza@broadcom.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Oza Pawandeep <oza.oza@broadcom.com>,
        Andy Gospodarek <gospo@broadcom.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Oza Pawandeep <oza.pawandeep@gmail.com>
Subject: [PATCH v6 0/2] PCI: iproc: SOC specific fixes
Date: Fri,  4 Aug 2017 21:18:14 +0530
Message-Id: <1501861696-25767-1-git-send-email-oza.oza@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI: iproc: Retry request when CRS returned from EP
Above patch adds support for CRS in PCI RC driver, otherwise if not
handled at lower level, the user space PMD (poll mode drivers) can
timeout.

PCI: iproc: add device shutdown for PCI RC
This fixes the issue where certian PCI endpoints are not getting
detected on Stingray SOC after reboot.

Changes Since v6:
Bjorn's comments addressed.
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
 drivers/pci/host/pcie-iproc.c          | 139 +++++++++++++++++++++++++++++----
 drivers/pci/host/pcie-iproc.h          |   1 +
 3 files changed, 132 insertions(+), 16 deletions(-)

-- 
1.9.1
