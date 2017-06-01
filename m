Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f176.google.com ([209.85.216.176]:34909 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751001AbdFAF2D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Jun 2017 01:28:03 -0400
Received: by mail-qt0-f176.google.com with SMTP id w1so1390864qtg.2
        for <linux-pci@vger.kernel.org>; Wed, 31 May 2017 22:28:03 -0700 (PDT)
From: Oza Pawandeep <oza.oza@broadcom.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Oza Pawandeep <oza.oza@broadcom.com>,
        Andy Gospodarek <gospo@broadcom.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Oza Pawandeep <oza.pawandeep@gmail.com>
Subject: [PATCH 0/2] PCI: iproc: SOC specific fixes.
Date: Thu,  1 Jun 2017 10:57:49 +0530
Message-Id: <1496294871-5836-1-git-send-email-oza.oza@broadcom.com>
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

Oza Pawandeep (2):
  PCI: iproc: Retry request when CRS returned from EP
  PCI: iproc: add device shutdown for PCI RC

 drivers/pci/host/pcie-iproc-platform.c |   8 +++
 drivers/pci/host/pcie-iproc.c          | 125 ++++++++++++++++++++++++++++-----
 drivers/pci/host/pcie-iproc.h          |   1 +
 3 files changed, 115 insertions(+), 19 deletions(-)

-- 
1.9.1
