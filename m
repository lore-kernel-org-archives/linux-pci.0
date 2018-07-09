Return-Path: <SRS0=qQet=JZ=oracle.com=james.puthukattukaran@kernel.org>
Return-Path: <SRS0=qQet=JZ=oracle.com=james.puthukattukaran@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
From: James Puthukattukaran <james.puthukattukaran@oracle.com>
Subject: [PATCH v14 0/1] PCI: Support to workaround bus level HW issues in IDT
 switch
Message-ID: <4117c119-c754-bf4e-544c-19cb6e239f38@oracle.com>
Date: Mon, 9 Jul 2018 11:28:54 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

There are bugs in certain PCIe switches that cause access violations when an
endpoint device is hotplugged. In particular, there's an issue with
certain IDT switches that trigger a ACS violation when bringing up a newly
plugged PCIe endpoint device. This is a major issue for platforms
designed to issue a fatal reset in the case of this event.

This patch checks if the endpoint device lies behind this errant IDT switch
and if so, implements the suggested workaround

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
-v14: Remove the general quirk framework as per Bjorn; it was deemed an
      overkill. Simplified the code requiring just one patch

James Puthukattukaran(1):
  Workaround for ACS related bug in certain IDT switches

 drivers/pci/pci.h    |  5 ++++
 drivers/pci/probe.c  | 17 +++++++++++++-
 drivers/pci/quirks.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 86 insertions(+), 1 deletion(-)

-- 
1.8.3.1
