Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp2120.oracle.com ([156.151.31.85]:53960 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752887AbeDSRgQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Apr 2018 13:36:16 -0400
To: Alex Williamson <alex.williamson@redhat.com>,
        Sinan Kaya <okaya@codeaurora.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
From: James Puthukattukaran <james.puthukattukaran@oracle.com>
Subject: [PATCH 0/2] PCI: Support to workaround bus level HW issues
Message-ID: <b6439e86-2284-5b3c-3656-a0c3c2568317@oracle.com>
Date: Thu, 19 Apr 2018 13:36:00 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

There are bugs in certain PCIe switches that cause access violations
 when an endpoint device is hotplugged. In particular, there's an issue
with
certain IDT switches that trigger a ACS violation when bringing up a newly
plugged PCIe endpoint device. This is a major issue for platforms
designed to
issue a fatal reset in the case of this event.

The first patch provides a framework for intercepting and working around
issues with parent devices to the endpoint being brought up.

The second patch provides the actual patch for the IDT switch issue using
that framework. The ACS feature is disabled in the IDT switch prior to
endpoint
device detection and then re-enabled subsequent to that.

James

---

James Puthukattukaran (2):
  PCI: Add pci_bus_specific_read_dev_vendor_id() to workaround PCI
    switch     specific issues prior to accessing newly added endpoint
  PCI: Implement workaround for the ACS bug in the IDT switch

 drivers/pci/pci.h    |   4 ++
 drivers/pci/probe.c  |  19 +++++++-
 drivers/pci/quirks.c | 130
+++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 152 insertions(+), 1 deletion(-)
