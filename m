Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wr0-f174.google.com ([209.85.128.174]:35978 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751914AbdGFDJx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Jul 2017 23:09:53 -0400
Received: by mail-wr0-f174.google.com with SMTP id c11so9574331wrc.3
        for <linux-pci@vger.kernel.org>; Wed, 05 Jul 2017 20:09:53 -0700 (PDT)
From: Oza Pawandeep <oza.oza@broadcom.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Oza Pawandeep <oza.oza@broadcom.com>,
        Andy Gospodarek <gospo@broadcom.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Oza Pawandeep <oza.pawandeep@gmail.com>
Subject: [PATCH v5 0/2] PCI: iproc: SOC specific fixes
Date: Thu,  6 Jul 2017 08:39:40 +0530
Message-Id: <1499310582-21193-1-git-send-email-oza.oza@broadcom.com>
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

 drivers/pci/host/pcie-iproc-platform.c |   8 +++
 drivers/pci/host/pcie-iproc.c          | 128 ++++++++++++++++++++++++++++-----
 drivers/pci/host/pcie-iproc.h          |   1 +
 3 files changed, 121 insertions(+), 16 deletions(-)

-- 
1.9.1
