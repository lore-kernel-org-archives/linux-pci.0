Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Govinda Tatti <Govinda.Tatti@Oracle.COM>
To: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, bhelgaas@google.com,
        boris.ostrovsky@Oracle.COM, jgross@suse.com, JBeulich@suse.com,
        roger.pau@citrix.com
Cc: konrad.wilk@Oracle.COM
Subject: [PATCH V3 0/2] Xen/PCIback: PCI reset using 'reset' SysFS attribute
Date: Thu,  7 Dec 2017 17:21:43 -0500
Message-Id: <20171207222145.9769-1-Govinda.Tatti@Oracle.COM>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch contains Xen pciback driver changes to support PCI reset
(flr/slot/bus) based on SysFS 'reset' attribute. The following Xen
libxl patch depends on these kernel patches.
- Xen/libxl: Perform PCI reset using 'reset' SysFS attribute

Govinda Tatti (2):
  Drivers/PCI: Export pcie_has_flr() interface
  Xen/PCIback: Implement PCI flr/slot/bus reset with 'reset' SysFS
    attribute

 Documentation/ABI/testing/sysfs-driver-pciback |  15 +++
 drivers/pci/pci.c                              |   3 +-
 drivers/xen/xen-pciback/pci_stub.c             | 128 +++++++++++++++++++++++++
 include/linux/pci.h                            |   1 +
 4 files changed, 146 insertions(+), 1 deletion(-)

-- 
2.9.5
