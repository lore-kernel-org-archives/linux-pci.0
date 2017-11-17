Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Niklas Cassel <niklas.cassel@axis.com>
To: linux-pci@vger.kernel.org
Cc: Niklas Cassel <niklass@axis.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Fix find_first_zero_bit() usage
Date: Fri, 17 Nov 2017 16:00:39 +0100
Message-Id: <20171117150041.30509-1-niklas.cassel@axis.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Niklas Cassel <niklass@axis.com>

find_first_zero_bit()'s parameter 'size' is defined in bits,
not in bytes.

Calling find_first_zero_bit() with the wrong size unit
will lead to insidious bugs.

Fix all uses of find_first_zero_bit() called with
sizeof() as size argument in drivers/pci.

Niklas Cassel (2):
  PCI: designware-ep: Fix find_first_zero_bit() usage
  PCI: endpoint: Fix find_first_zero_bit() usage

 drivers/pci/dwc/pcie-designware-ep.c | 6 ++----
 drivers/pci/endpoint/pci-ep-cfs.c    | 3 +--
 2 files changed, 3 insertions(+), 6 deletions(-)

-- 
2.14.2
