Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp2120.oracle.com ([156.151.31.85]:44138 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753522AbeD3RZ0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Apr 2018 13:25:26 -0400
To: Alex Williamson <alex.williamson@redhat.com>,
        Sinan Kaya <okaya@codeaurora.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
From: James Puthukattukaran <james.puthukattukaran@oracle.com>
Subject: [PATCH v2 0/2] PCI: Support to workaround bus level HW issues
Message-ID: <4bd28931-8e8d-6bfe-a98c-49f8e2778c6e@oracle.com>
Date: Mon, 30 Apr 2018 13:25:22 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

There are bugs in certain PCIe switches that cause access violations when an
endpoint device is hotplugged. In particular, there's an issue with
certain IDT switches that trigger a ACS violation when bringing up a newly
plugged PCIe endpoint device. This is a major issue for platforms
designed to issue a fatal reset in the case of this event.

The first patch provides a framework for intercepting and working around
issues with parent devices to the endpoint being brought up.

The second patch provides the actual patch for the IDT switch issue using
that framework. The ACS feature is disabled in the IDT switch prior to endpoint
device detection and then re-enabled subsequent to that.

James

-v2: move workaround to pci_bus_read_dev_vendor_id() from pci_bus_check_dev()
     and move enable_acs_sv to drivers/pci/pci.c -- by Yinghai
-v3: add bus->self check for root bus and virtual bus for sriov vfs.
-v4: only do workaround for IDT switches
-v5: tweak pci_std_enable_acs_sv to deal with unimplemented SV
-v6: Added errata verbiage verbatim and resolved patch format issues
-v7: changed int to bool for found and idt_workaround declarations. Also
     added bugzilla https://bugzilla.kernel.org/show_bug.cgi?id=196979
-v8: Rewrote the patch by adding a new acs quirk to keep the workaround
     out of the main code path
-v9: changed function name from pci_dev_specific_fixup_acs_quirk to
     pci_bus_acs_quirk. Also, tested for FLR and hot reset scenarios and did
     not see issues where workaround was required. The issue seems to be
     related only to cold reset/power on situation.
-v10: Moved the contents of pci_bus_read_vendor_id into an internal function
      __pci_bus_read_vendor_id
-v11: Split the patch into two patches. The first a general quirk framework.
-v12: Add pci_bus_generic_read_dev_vendor_id() to carry out default behavior
      when detecting endpoint and pci_bus_specific_read_dev_vendor_id for
      bus quirk behavior
-v13: Fixed build errors found for non-x86 platforms via cross compiles when
      CONFIG_QUIRKS is not defined


James Puthukattukaran (2):
  PCI: Add pci_bus_specific_read_dev_vendor_id() to workaround PCI
    switch     specific issues prior to accessing newly added endpoint
  PCI: Implement workaround for the ACS bug in the IDT switch

 drivers/pci/pci.h    |  13 +++++
 drivers/pci/probe.c  |  20 +++++++-
 drivers/pci/quirks.c | 142 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 174 insertions(+), 1 deletion(-)

-- 
1.8.3.1
