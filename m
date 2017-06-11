Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wr0-f180.google.com ([209.85.128.180]:34190 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750715AbdFKEF4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 11 Jun 2017 00:05:56 -0400
Received: by mail-wr0-f180.google.com with SMTP id g76so65262320wrd.1
        for <linux-pci@vger.kernel.org>; Sat, 10 Jun 2017 21:05:56 -0700 (PDT)
From: Oza Pawandeep <oza.oza@broadcom.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Oza Pawandeep <oza.oza@broadcom.com>,
        Andy Gospodarek <gospo@broadcom.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Oza Pawandeep <oza.pawandeep@gmail.com>
Subject: [PATCH v3 0/2] PCI: iproc: SOC specific fixes
Date: Sun, 11 Jun 2017 09:35:36 +0530
Message-Id: <1497153938-26074-1-git-send-email-oza.oza@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI: iproc: Retry request when CRS returned from EP

Above patch adds support for CRS in PCI RC driver,
otherwise if not handled at lower level, the user
space PMD (poll mode drivers) can timeout.

PCI: iproc: add device shutdown for PCI RC

This fixes the issue where certian PCI endpoints are
not getting detected on Stingray SOC after reboot.

Changes Since v3:
[re-send] 
Changes Since v2:
Fix compilation errors for pcie-iproc-platform.ko
which was caught by kbuild.

Oza Pawandeep (2):
  PCI: iproc: Retry request when CRS returned from EP
  PCI: iproc: add device shutdown for PCI RC

 drivers/pci/host/pcie-iproc-platform.c |   8 +++
 drivers/pci/host/pcie-iproc.c          | 126 ++++++++++++++++++++++++++++-----
 drivers/pci/host/pcie-iproc.h          |   1 +
 3 files changed, 116 insertions(+), 19 deletions(-)

-- 
1.9.1
