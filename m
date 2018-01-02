Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ot0-f172.google.com ([74.125.82.172]:41517 "EHLO
        mail-ot0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750726AbeABWAo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Jan 2018 17:00:44 -0500
Received: by mail-ot0-f172.google.com with SMTP id q39so38210622otb.8
        for <linux-pci@vger.kernel.org>; Tue, 02 Jan 2018 14:00:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <6707e532-7a5e-261c-4d5b-950d0ccc8f66@broadcom.com>
References: <CACna6rxOBUfVhqrMZ2=-6NLrey7193Dtgf-DniSw8Y+qCD6kKA@mail.gmail.com>
 <6707e532-7a5e-261c-4d5b-950d0ccc8f66@broadcom.com>
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Date: Tue, 2 Jan 2018 23:00:43 +0100
Message-ID: <CACna6rygToq7xL0U4-qD5dftYq4=PRhcrpKqAafvuB3mw6Dcsw@mail.gmail.com>
Subject: Re: Regression: NULL pointer dereference caused by iproc_pcie_map_dma_ranges
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

On 2 January 2018 at 19:44, Ray Jui <ray.jui@broadcom.com> wrote:
> Can you please give the following patch a try to see if that fixes the
> issue? Thanks.

It does, thank you!


> From f91de124bc8fb5645d7dbbfd68a9a68617955749 Mon Sep 17 00:00:00 2001
> From: Ray Jui <ray.jui@broadcom.com>
> Date: Tue, 2 Jan 2018 10:36:03 -0800
> Subject: [PATCH] PCI: iproc: Fix NULL pointer dereference for BCMA
>
> With the inbound DMA mapping supported added, the iProc PCIe driver
> parses DT property "dma-ranges" through call to
> "of_pci_dma_range_parser_init". In the case of BCMA, this results in a
> NULL pointer deference due to a missing of_node.
>
> Fix this by adding a guard in pcie-iproc-platform.c to only enable the
> inbound DMA mapping logic when DT property "dma-ranges" is present
>
> fixes: dd9d4e7498de3 ("PCI: iproc: Add inbound DMA mapping support")
> Signed-off-by: Ray Jui <ray.jui@broadcom.com>

Please add:
Tested-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
Cc: stable@vger.kernel.org # 4.10+
