Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:35828 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752459AbbETOwI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 20 May 2015 10:52:08 -0400
Received: by igbyr2 with SMTP id yr2so104514004igb.0
        for <linux-pci@vger.kernel.org>; Wed, 20 May 2015 07:52:07 -0700 (PDT)
Date: Wed, 20 May 2015 09:52:04 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: rjui@broadcom.com, arnd@arndb.de, linux-pci@vger.kernel.org,
	sbranden@broadcom.com, linux-arm-kernel@lists.infradead.org,
	bcm-kernel-feedback-list@broadcom.com, zajec5@gmail.com
Subject: Re: [PATCH 0/2] PCI: iproc: add bcma PCIe 2.0 controller
Message-ID: <20150520145204.GA30184@google.com>
References: <1431465781-10753-1-git-send-email-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1431465781-10753-1-git-send-email-hauke@hauke-m.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 12, 2015 at 11:22:59PM +0200, Hauke Mehrtens wrote:
> After Ray submitted the PCIe controller for the iProc devices using 
> pure device tree this adds support for the devices using bcma to scan 
> the bus. This should replaces the driver I initially send for inclusion.
> 
> @Ray The driver found in the Broadcom SDK does some more stuff:
> * setting up some DMA memory areas
> * chaining MPS and MRRS to 512
> * PHY changes:
>  * "improving" the PCIe jitter 
>  * some special initializations for the 3rd PCIe port
> 
> For me it works without these additions, but I haven't tested for 
> performance or stability or 3rd port. Can you check if this is needed 
> at all for the devices found on the market?
> 
> Hauke Mehrtens (2):
>   PCI: iproc: make of_irq_parse_and_map_pci() configurable
>   PCI: iproc: add bcma pcie driver
> 
>  drivers/pci/host/Kconfig               |  11 ++++
>  drivers/pci/host/Makefile              |   1 +
>  drivers/pci/host/pcie-iproc-bcma.c     | 112 +++++++++++++++++++++++++++++++++
>  drivers/pci/host/pcie-iproc-platform.c |   2 +
>  drivers/pci/host/pcie-iproc.c          |   2 +-
>  drivers/pci/host/pcie-iproc.h          |   1 +
>  6 files changed, 128 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/pci/host/pcie-iproc-bcma.c

Applied to pci/host-iproc for v4.2 with acks from Ray and Rafał, thanks!

I corrected some typos, the most important being MODULE_LICENSE, where I
changed "GPLv2" to "GPL v2".  See license_is_gpl_compatible() and
eed6542dd53f ("PCI: generic: Fix GPL v2 license string typo").

Bjorn
