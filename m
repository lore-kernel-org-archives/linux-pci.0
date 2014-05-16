Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:31663 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750927AbaEPAsh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 15 May 2014 20:48:37 -0400
From: Jingoo Han <jg1.han@samsung.com>
To: 'Murali Karicheri' <m-karicheri2@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	'Santosh Shilimkar' <santosh.shilimkar@ti.com>,
	'Russell King' <linux@arm.linux.org.uk>,
	'Grant Likely' <grant.likely@linaro.org>,
	'Rob Herring' <robh+dt@kernel.org>,
	'Mohit Kumar' <mohit.kumar@st.com>,
	'Bjorn Helgaas' <bhelgaas@google.com>,
	'Jingoo Han' <jg1.han@samsung.com>,
	'Pratyush Anand' <pratyush.anand@st.com>,
	'Richard Zhu' <r65037@freescale.com>,
	'Kishon Vijay Abraham I' <kishon@ti.com>,
	'Marek Vasut' <marex@denx.de>
References: <1400169692-9677-1-git-send-email-m-karicheri2@ti.com>
In-reply-to: <1400169692-9677-1-git-send-email-m-karicheri2@ti.com>
Subject: Re: [PATCH v1 0/5] Add Keystone PCIe controller driver
Date: Fri, 16 May 2014 09:48:34 +0900
Message-id: <004f01cf70a0$90d7e520$b287af60$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, May 16, 2014 1:01 AM, Murali Karicheri wrote:
> 
> This patch adds a PCIe controller driver for Keystone SoCs. This
> is based on the origin RFC patch that I had sent earlier. I have
> incorporated following comments:-
> 
>  - Add a interrupt controller node for Legacy irq chip and use
>    interrupt map/map-mask property to map legacy IRQs A/B/C/D
>  - Add a Phy driver to replace the original serdes driver
>  - Move common applicaiton register handling code to a separate
>    file to allow re-use across other platforms that use older
>    DW PCIe h/w
>  - PCI quirk for maximum read request size. Check and override only
>    if the maximum is higher than what controller can handle.
>  - Converted to a module platform driver.
> 
> CC: Santosh Shilimkar <santosh.shilimkar@ti.com>
> CC: Russell King <linux@arm.linux.org.uk>
> CC: Grant Likely <grant.likely@linaro.org>
> CC: Rob Herring <robh+dt@kernel.org>
> CC: Mohit Kumar <mohit.kumar@st.com>
> CC: Jingoo Han <jg1.han@samsung.com>
> CC: Bjorn Helgaas <bhelgaas@google.com>
> 

Your patches modify 'pcie-designware.c', and affects other PCIe
drivers using designware PCIe Core IP. Please add the following
people to CC list. They are also related to the designware PCIe.

  Pratyush Anand <pratyush.anand@st.com>
  Richard Zhu <r65037@freescale.com>
  Kishon Vijay Abraham I <kishon@ti.com>
  Marek Vasut <marex@denx.de>

Best regards,
Jingoo Han

> 
> Murali Karicheri (5):
>   ARM: keystone: add pcie related options
>   pci: designware: enhancements to support keystone pcie
>   phy: pci serdes phy driver for keystone
>   pci: dw: add common functions to support old hw based pci driver
>   pci: keystone: add pcie driver based on designware core driver
> 
>  .../devicetree/bindings/pci/pcie-keystone.txt      |   68 ++++
>  arch/arm/mach-keystone/Kconfig                     |    2 +
>  drivers/pci/host/Kconfig                           |   12 +
>  drivers/pci/host/Makefile                          |    2 +
>  drivers/pci/host/pci-dw-old-msi.c                  |  150 ++++++++
>  drivers/pci/host/pci-dw-old.c                      |  371 ++++++++++++++++++
>  drivers/pci/host/pci-dw-old.h                      |   30 ++
>  drivers/pci/host/pci-keystone.c                    |  400 ++++++++++++++++++++
>  drivers/pci/host/pcie-designware.c                 |  101 +++--
>  drivers/pci/host/pcie-designware.h                 |   42 +-
>  drivers/pci/quirks.c                               |   13 +
>  drivers/phy/Kconfig                                |    6 +
>  drivers/phy/Makefile                               |    1 +
>  drivers/phy/phy-keystone.c                         |  230 +++++++++++
>  14 files changed, 1388 insertions(+), 40 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/pcie-keystone.txt
>  create mode 100644 drivers/pci/host/pci-dw-old-msi.c
>  create mode 100644 drivers/pci/host/pci-dw-old.c
>  create mode 100644 drivers/pci/host/pci-dw-old.h
>  create mode 100644 drivers/pci/host/pci-keystone.c
>  create mode 100644 drivers/phy/phy-keystone.c
> 
> --
> 1.7.9.5

