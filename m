Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:58788 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752925AbeB0L7O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Feb 2018 06:59:14 -0500
From: Niklas Cassel <niklas.cassel@axis.com>
To: kishon@ti.com, linux-pci@vger.kernel.org
Cc: Niklas Cassel <niklass@axis.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] PCI endpoint 64-bit BAR fixes
Date: Tue, 27 Feb 2018 12:59:04 +0100
Message-Id: <20180227115908.14593-1-niklas.cassel@axis.com>
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

 drivers/misc/pci_endpoint_test.c              | 12 +++++++-----
 drivers/pci/dwc/pcie-designware-ep.c          |  5 +++++
 drivers/pci/endpoint/functions/pci-epf-test.c |  2 ++
 3 files changed, 14 insertions(+), 5 deletions(-)

-- 
2.14.2
