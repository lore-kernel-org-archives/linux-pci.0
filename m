Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:34147 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754683AbbHNOxP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 14 Aug 2015 10:53:15 -0400
Received: by igui7 with SMTP id i7so14071411igu.1
        for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2015 07:53:15 -0700 (PDT)
Date: Fri, 14 Aug 2015 09:53:10 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Gabriel FERNANDEZ <gabriel.fernandez@st.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Srinivas Kandagatla <srinivas.kandagatla@gmail.com>,
	Maxime Coquelin <maxime.coquelin@st.com>,
	Patrice Chotard <patrice.chotard@st.com>,
	Russell King <linux@arm.linux.org.uk>,
	Jingoo Han <jg1.han@samsung.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Fabrice Gasnier <fabrice.gasnier@st.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	" David S. Miller" <davem@davemloft.net>,
	Greg KH <gregkh@linuxfoundation.org>,
	Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
	Joe Perches <joe@perches.com>, Tejun Heo <tj@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Thierry Reding <treding@nvidia.com>,
	Phil Edworthy <phil.edworthy@renesas.com>,
	Minghuan Lian <Minghuan.Lian@freescale.com>,
	Tanmay Inamdar <tinamdar@apm.com>, m-karicheri2@ti.com,
	Sachin Kamat <sachin.kamat@samsung.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Liviu Dudau <liviu.dudau@arm.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	kernel@stlinux.com, linux-pci@vger.kernel.org,
	Lee Jones <lee.jones@linaro.org>,
	Gabriel Fernandez <gabriel.fernandez@linaro.org>
Subject: Re: [PATCH v3 0/5] PCI: st: provide support for dw pcie
Message-ID: <20150814145310.GD26431@google.com>
References: <1428657168-12495-1-git-send-email-gabriel.fernandez@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1428657168-12495-1-git-send-email-gabriel.fernandez@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 10, 2015 at 11:12:43AM +0200, Gabriel FERNANDEZ wrote:
> Changes in v3:
>  - Remove power management functions (was not fully tested)
>  - Remove configuration space range from dt binding
>  - Remove pci_common_init_dev() call in pcie-designware.c to avoid 
>    default IO space declaration. 
> 
> Changes in v2:
>  - comestic corrections in device tree binding
>  - add pci-st.c into MAINTAINERS
>  - remove st_pcie_ops structure to avoid another level of indirection
>  - remove nasty busy-loop
>  - remove useless test using virt_to_phys()
>  - move disable io support into dw-pcie driver
> 
> I don't change the st_pcie_abort_handler() function because abort handling
> is masked during boot.
> 
> 
> This patch-set introduces a STMicroelectronics PCIe controller.
> It's based on designware PCIe driver.
> 
> Gabriel Fernandez (5):
>   ARM: STi: Kconfig update for PCIe support
>   PCI: st: Add Device Tree bindings for sti pcie
>   PCI: st: Provide support for the sti PCIe controller
>   pci: designware: remove pci_common_init_dev()
>   MAINTAINERS: Add pci-st.c to ARCH/STI architecture

Hi Gabriel,

I lost track of where we are with this.  I *think* I'm waiting for a v4
posting, but I haven't seen it yet.  Let me know if I've missed something.

Bjorn
