Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:60554 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755824AbeCHNdh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Mar 2018 08:33:37 -0500
From: Niklas Cassel <niklas.cassel@axis.com>
To: kishon@ti.com, linux-pci@vger.kernel.org
Cc: Niklas Cassel <niklass@axis.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/5] PCI endpoint 64-bit BAR fixes
Date: Thu,  8 Mar 2018 14:33:25 +0100
Message-Id: <20180308133331.19464-1-niklas.cassel@axis.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI endpoint fixes to improve the way 64-bit BARs are handled.


There are still future improvements that could be made:

pci-epf-test.c always allocates space for
6 BARs, even when using 64-bit BARs (which
really only requires us to allocate 3 BARs).

pcitest.sh will print "NOT OKAY" for BAR1,
BAR3, and BAR5 when using 64-bit BARs.
This could probably be improved to say
something like "N/A (64-bit BAR)".

Niklas Cassel (5):
  PCI: endpoint: BAR width should not depend on sizeof dma_addr_t
  PCI: designware-ep: Make dw_pcie_ep_set_bar() handle 64-bit BARs
    properly
  PCI: designware-ep: Make dw_pcie_ep_reset_bar() handle 64-bit BARs
    properly
  PCI: endpoint: Make pci_epc_set_bar() return the BAR width that was
    set-up
  misc: pci_endpoint_test: Handle 64-bit BARs properly

 drivers/misc/pci_endpoint_test.c              | 12 +++++++-----
 drivers/pci/cadence/pcie-cadence-ep.c         |  2 +-
 drivers/pci/dwc/pcie-designware-ep.c          | 22 ++++++++++++++++++----
 drivers/pci/endpoint/functions/pci-epf-test.c | 22 +++++++++++++++-------
 4 files changed, 41 insertions(+), 17 deletions(-)

-- 
2.14.2
