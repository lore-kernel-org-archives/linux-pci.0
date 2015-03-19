Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:35445 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799AbbCSVFb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 19 Mar 2015 17:05:31 -0400
Received: by obcjt1 with SMTP id jt1so44114935obc.2
        for <linux-pci@vger.kernel.org>; Thu, 19 Mar 2015 14:05:31 -0700 (PDT)
Date: Thu, 19 Mar 2015 16:05:27 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Ray Jui <rjui@broadcom.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Hauke Mehrtens <hauke@hauke-m.de>,
	Paul Bolle <pebolle@tiscali.nl>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Dmitry Torokhov <dtor@google.com>,
	Anatol Pomazau <anatol@google.com>,
	Scott Branden <sbranden@broadcom.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org
Subject: Re: [PATCH v7 0/4] pci: iproc: Add Broadcom iProc PCIe support
Message-ID: <20150319210527.GI26935@google.com>
References: <1426207732-31625-1-git-send-email-rjui@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1426207732-31625-1-git-send-email-rjui@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Florian]

On Thu, Mar 12, 2015 at 05:48:48PM -0700, Ray Jui wrote:
> This patch series adds the support for Broadcom iProc PCIe controller
> 
> pcie-iproc.c servers as the common core driver, and front-end bus
> interface needs to be added to support different bus interfaces
> 
> pcie-iproc-pltfm.c contains the support for the platform bus interface
> 
> Changes from v6:
>  - Fix print formatting
>  - Fix section mismatch warning by removing __init from the probe function
>  - Fix Kconfig to force it only compiling for ARM based platforms
> 
> Changes from v5:
>  - Sync code base to v4.0-rc2
>  - Change export symbols of common PCI functions to GPL only
>  - Add comment to describe how configuration register access are protected
>    at the higher layer through 'pci_lock'
>  - Use generic PCI functions for configuration register access and implement
>    'map_bus' callback to support it
>  - Move 'pci_fixup_irqs' to before devices are added to the bus
>  - Remove 'extern' from function prototype declared in the header
> 
> Changes from v4:
>  - iProc PCIe driver module support was not included in patch series v4.
>    This patch series (v5) fixes it
> 
> Changes from v3:
>  - Export symbols of several PCI functions so they can be used by drivers
>    compiled as kernel module
>  - Add additional support to the Broadcom iProc PCIe driver so it can be
>    installed/uninstalled as kernel loadable module
> 
> Changes from v2:
>  - Major rework of the PCIe driver to factor out common generic code from
>    front-end bus interface. Support for generic platform bus interface is
>    also added
>  - Adapt to several new PCI APIs that have been introduced lately
> 
> Changes from v1:
>  - Add standard PCI interrupt DT properties "#interrupt-cells",
>    "interrupt-map-mask" and "interrupt-map" so legacy INTx interrupts can be
>    supported by using standard PCI OF IRQ parsing function
>  - Get rid of custom IRQ mapping function in the driver. Use
>    of_irq_parse_and_map_pci instead
> 
> Ray Jui (4):
>   PCI: Export symbols of PCI functions
>   pci: iProc: define iProc PCIe platform bus binding
>   pci: iproc: Add Broadcom iProc PCIe support
>   ARM: dts: enable PCIe support for Cygnus

I applied patches 1-3 to pci/host-iproc for v4.1, thanks!  I didn't apply
patch 4 because Florian said he'd already applied it to devicetree/next.

I normally look for a MAINTAINERS entry, but your existing entry for
"BROADCOM CYGNUS/IPROC ARM ARCHITECTURE" has wildcards that already include
these new files.

>  .../devicetree/bindings/pci/brcm,iproc-pcie.txt    |   63 +++++
>  arch/arm/boot/dts/bcm-cygnus.dtsi                  |   42 +++
>  arch/arm/boot/dts/bcm958300k.dts                   |    8 +
>  drivers/pci/host/Kconfig                           |   17 ++
>  drivers/pci/host/Makefile                          |    2 +
>  drivers/pci/host/pcie-iproc-pltfm.c                |  108 ++++++++
>  drivers/pci/host/pcie-iproc.c                      |  268 ++++++++++++++++++++
>  drivers/pci/host/pcie-iproc.h                      |   42 +++
>  drivers/pci/pci.c                                  |    1 +
>  drivers/pci/probe.c                                |    1 +
>  drivers/pci/remove.c                               |    2 +
>  drivers/pci/setup-bus.c                            |    1 +
>  drivers/pci/setup-irq.c                            |    1 +
>  13 files changed, 556 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
>  create mode 100644 drivers/pci/host/pcie-iproc-pltfm.c
>  create mode 100644 drivers/pci/host/pcie-iproc.c
>  create mode 100644 drivers/pci/host/pcie-iproc.h
> 
> -- 
> 1.7.9.5
> 
