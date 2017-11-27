Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:40315 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752550AbdK0PuH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Nov 2017 10:50:07 -0500
From: Niklas Cassel <niklas.cassel@axis.com>
To: linux-pci@vger.kernel.org
Cc: kishon@ti.com, Niklas Cassel <niklass@axis.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] Fix find_first_zero_bit() usage
Date: Mon, 27 Nov 2017 16:49:52 +0100
Message-Id: <20171127154955.22214-1-niklas.cassel@axis.com>
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

 drivers/pci/dwc/pcie-designware-ep.c | 22 ++++++++++++++--------
 drivers/pci/dwc/pcie-designware.h    |  7 +++++--
 drivers/pci/endpoint/pci-ep-cfs.c    | 14 +++++++++-----
 3 files changed, 28 insertions(+), 15 deletions(-)

-- 
2.14.2
