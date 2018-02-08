Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:49047 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751834AbeBHMdv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Feb 2018 07:33:51 -0500
From: Niklas Cassel <niklas.cassel@axis.com>
To: kishon@ti.com, linux-pci@vger.kernel.org
Cc: Niklas Cassel <niklass@axis.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] PCI endpoint 64-bit BAR fixes
Date: Thu,  8 Feb 2018 13:33:43 +0100
Message-Id: <20180208123346.20784-1-niklas.cassel@axis.com>
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

Niklas Cassel (3):
  PCI: endpoint: Handle 64-bit BARs properly
  misc: pci_endpoint_test: Handle 64-bit BARs properly
  PCI: designware-ep: Return an error when requesting a too large BAR
    size

 drivers/misc/pci_endpoint_test.c              | 2 ++
 drivers/pci/dwc/pcie-designware-ep.c          | 5 +++++
 drivers/pci/endpoint/functions/pci-epf-test.c | 2 ++
 3 files changed, 9 insertions(+)

-- 
2.14.2
