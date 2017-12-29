Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:44725 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750744AbdL2Wep (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Dec 2017 17:34:45 -0500
Received: by mail-oi0-f65.google.com with SMTP id g6so13505665oib.11
        for <linux-pci@vger.kernel.org>; Fri, 29 Dec 2017 14:34:45 -0800 (PST)
MIME-Version: 1.0
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Date: Fri, 29 Dec 2017 23:34:44 +0100
Message-ID: <CACna6rxOBUfVhqrMZ2=-6NLrey7193Dtgf-DniSw8Y+qCD6kKA@mail.gmail.com>
Subject: Regression: NULL pointer dereference caused by iproc_pcie_map_dma_ranges
To: Ray Jui <ray.jui@broadcom.com>
Cc: Oza Oza <oza.oza@broadcom.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        Hauke Mehrtens <hauke@hauke-m.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi, I just updated from kernel 4.9 to 4.14 and found a NULL pointer
dereference caused by the iproc driver.

1) For bcma case pcie->dev->of_node can be NULL
2) iproc_pcie_map_dma_ranges calls pci_dma_range_parser_init
3) pci_dma_range_parser_init calls of_n_addr_cells(node) (node is NULL)

This is caused by a commit dd9d4e7498de3 ("PCI: iproc: Add inbound DMA
mapping support").

I believe that new DMA mapping code should be optional.

Would you find a moment to fix that, please?

--=20
Rafa=C5=82
