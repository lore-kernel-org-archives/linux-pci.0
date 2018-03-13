Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751255AbeCMW0Y (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Mar 2018 18:26:24 -0400
Subject: [PATCH v1 0/4] PCI/VPD: Encapsulate VPD stuff in vpd.c
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Date: Tue, 13 Mar 2018 17:26:14 -0500
Message-ID: <152097990638.37832.15000151673990461303.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is strictly cleanup, not intended to change or fix anything.

Move all the VPD-related code and structures to drivers/pci/vpd.c.

---

Bjorn Helgaas (4):
      PCI/VPD: Move VPD access code to vpd.c
      PCI/VPD: Move VPD sysfs code to vpd.c
      PCI/VPD: Move VPD quirks to vpd.c
      PCI/VPD: Move VPD structures to vpd.c


 drivers/pci/access.c    |  368 ------------------------------
 drivers/pci/pci-sysfs.c |   67 -----
 drivers/pci/pci.h       |   19 --
 drivers/pci/quirks.c    |  121 ----------
 drivers/pci/vpd.c       |  573 +++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 578 insertions(+), 570 deletions(-)
