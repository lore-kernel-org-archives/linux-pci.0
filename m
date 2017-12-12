Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:56124 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750853AbdLLOQt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Dec 2017 09:16:49 -0500
From: Niklas Cassel <niklas.cassel@axis.com>
To: linux-pci@vger.kernel.org
Cc: kishon@ti.com, Niklas Cassel <niklass@axis.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] Fix find_first_zero_bit() usage
Date: Tue, 12 Dec 2017 15:16:31 +0100
Message-Id: <20171212141634.5985-1-niklas.cassel@axis.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

find_first_zero_bit()'s parameter 'size' is defined in bits,
not in bytes.

Calling find_first_zero_bit() with the wrong size unit
will lead to insidious bugs.

Fix all uses of find_first_zero_bit() called with
sizeof() as size argument in drivers/pci.

Also had to fix broken error handling in pci_epc_epf_link()
in order to do proper error handling for find_first_zero_bit().

Niklas Cassel (3):
  PCI: designware-ep: Fix find_first_zero_bit() usage
  PCI: endpoint: Fix error handling in pci_epc_epf_link()
  PCI: endpoint: Fix find_first_zero_bit() usage

 drivers/pci/dwc/pcie-designware-ep.c | 34 ++++++++++++++++++++++++++--------
 drivers/pci/dwc/pcie-designware.h    |  8 ++++++--
 drivers/pci/endpoint/pci-ep-cfs.c    | 13 ++++++++-----
 3 files changed, 40 insertions(+), 15 deletions(-)

-- 
2.14.2
