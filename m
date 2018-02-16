Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750800AbeBPWuH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Feb 2018 17:50:07 -0500
Subject: [PATCH v1 0/2] PCI: Probe for reset support earlier
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Jayachandran Nair <Jayachandran.Nair@cavium.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>,
        Robert Richter <Robert.Richter@cavium.com>,
        Tom Vaden <tom.vaden@hpe.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        George Cherian <george.cherian@cavium.com>
Date: Fri, 16 Feb 2018 16:50:03 -0600
Message-ID: <20180216224213.67295.2251.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The PCI core currently uses a late_initcall to probe each device for
whether it supports reset.  This is dangerous because a driver may have
already claimed the device by this point, and the PCI core should not
interfere with the driver by touching the device on its own.

These patches move the probe to be earlier, during enumeration, before a
driver has a chance to claim the device.

---

Bjorn Helgaas (2):
      PCI: Probe for device reset support before driver claim
      PCI: Remove redundant probes for device reset support


 drivers/pci/pci-sysfs.c |    3 +--
 drivers/pci/pci.c       |   15 ++++++---------
 drivers/pci/probe.c     |    3 +++
 3 files changed, 10 insertions(+), 11 deletions(-)
