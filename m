Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f54.google.com ([209.85.218.54]:63883 "EHLO
	mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755370AbbA2Bpq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 28 Jan 2015 20:45:46 -0500
Received: by mail-oi0-f54.google.com with SMTP id v63so22158114oia.13
        for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2015 17:45:45 -0800 (PST)
Date: Wed, 28 Jan 2015 17:53:51 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Rob Herring <robh@kernel.org>
Cc: linux-pci@vger.kernel.org, Russell King <linux@arm.linux.org.uk>,
	Linus Walleij <linus.walleij@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 0/3] Versatile PCI host DT support
Message-ID: <20150128235351.GH17623@google.com>
References: <1422461778-6769-1-git-send-email-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1422461778-6769-1-git-send-email-robh@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 28, 2015 at 10:16:15AM -0600, Rob Herring wrote:
> I'm not going to get the rest of the Versatile series wrapped up for
> 3.20, but I think the PCI support is ready and would like to get it in.
> 
> I have not fixed the resource registration for /proc/iomem and irq
> fixup as those issues are being worked on for a common fix.
> 
> Bjorn, Can you please take the whole series unless you prefer arm-soc
> to.

Applied to pci/host-versatile for v3.20, thanks!

> v2:
> - Added MAINTAINERS entry
> - Based on generic PCI config accessors
> - Module license fix
> - Comment whitespace fix
> 
> Rob
> 
> Rob Herring (3):
>   dt/bindings: add versatile PCI binding
>   dts: versatile: add PCI controller binding
>   PCI: add DT based ARM Versatile PCI host driver
> 
>  .../devicetree/bindings/pci/versatile.txt          |  59 +++++
>  MAINTAINERS                                        |   8 +
>  arch/arm/boot/dts/versatile-pb.dts                 |  37 ++++
>  drivers/pci/host/Kconfig                           |   4 +
>  drivers/pci/host/Makefile                          |   1 +
>  drivers/pci/host/pci-versatile.c                   | 237 +++++++++++++++++++++
>  6 files changed, 346 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/versatile.txt
>  create mode 100644 drivers/pci/host/pci-versatile.c
> 
> -- 
> 2.1.0
> 
