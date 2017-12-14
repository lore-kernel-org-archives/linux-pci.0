Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Niklas Cassel <niklas.cassel@axis.com>
To: linux-pci@vger.kernel.org
Cc: kishon@ti.com, Niklas Cassel <niklass@axis.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/3] Fix find_first_zero_bit() usage
Date: Thu, 14 Dec 2017 14:01:43 +0100
Message-Id: <20171214130147.1790-1-niklas.cassel@axis.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

find_first_zero_bit()'s parameter 'size' is defined in bits,
not in bytes.

Calling find_first_zero_bit() with the wrong size unit
will lead to insidious bugs.

Fix all uses of find_first_zero_bit() called with
sizeof() as size argument in drivers/pci.

Niklas Cassel (3):
  PCI: designware-ep: Fix find_first_zero_bit() usage
  PCI: endpoint: Populate func_no before calling pci_epc_add_epf()
  PCI: endpoint: Fix find_first_zero_bit() usage

 drivers/pci/dwc/pcie-designware-ep.c | 34 ++++++++++++++++++++++++++--------
 drivers/pci/dwc/pcie-designware.h    |  8 ++++++--
 drivers/pci/endpoint/pci-ep-cfs.c    | 19 ++++++++++---------
 3 files changed, 42 insertions(+), 19 deletions(-)

-- 
2.14.2
