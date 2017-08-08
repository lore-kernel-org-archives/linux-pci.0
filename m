Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:35051 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752011AbdHHEoY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Aug 2017 00:44:24 -0400
Received: by mail-qk0-f174.google.com with SMTP id d145so13890845qkc.2
        for <linux-pci@vger.kernel.org>; Mon, 07 Aug 2017 21:44:24 -0700 (PDT)
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
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Oza Pawandeep <oza.pawandeep@gmail.com>
Subject: [PATCH 0/2] PCI hotplug feature
Date: Tue,  8 Aug 2017 10:14:13 +0530
Message-Id: <1502167455-10516-1-git-send-email-oza.oza@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

These patches bring in PCI hotplug support for iproc family chipsets.

It includes DT binding documentation update and, implementation in
iproc pcie RC driver.

These patch set is made on top of following patches.
[PATCH v6 2/2] PCI: iproc: add device shutdown for PCI RC
[PATCH v6 1/2] PCI: iproc: Retry request when CRS returned from EP

Oza Pawandeep (2):
  PCI: iproc: Implement PCI hotplug support
  PCI: iproc: Add optional brcm,pci-hotplug

 .../devicetree/bindings/pci/brcm,iproc-pcie.txt    |  23 ++++
 drivers/pci/host/pcie-iproc-platform.c             |   3 +
 drivers/pci/host/pcie-iproc.c                      | 130 ++++++++++++++++++++-
 drivers/pci/host/pcie-iproc.h                      |   7 ++
 4 files changed, 157 insertions(+), 6 deletions(-)

-- 
1.9.1
