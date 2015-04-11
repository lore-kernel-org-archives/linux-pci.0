Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lb1-smtp-cloud3.xs4all.net ([194.109.24.22]:50352 "EHLO
	lb1-smtp-cloud3.xs4all.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752702AbbDKKSJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 11 Apr 2015 06:18:09 -0400
Message-ID: <1428747477.17822.90.camel@x220>
Subject: Re: [PATCH v3 3/5] PCI: st: Provide support for the sti PCIe
 controller
From: Paul Bolle <pebolle@tiscali.nl>
To: Gabriel FERNANDEZ <gabriel.fernandez@st.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Srinivas Kandagatla <srinivas.kandagatla@gmail.com>,
	Maxime Coquelin <maxime.coquelin@st.com>,
	Patrice Chotard <patrice.chotard@st.com>,
	Russell King <linux@arm.linux.org.uk>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Fabrice Gasnier <fabrice.gasnier@st.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
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
Date: Sat, 11 Apr 2015 12:17:57 +0200
In-Reply-To: <1428657168-12495-4-git-send-email-gabriel.fernandez@linaro.org>
References: <1428657168-12495-1-git-send-email-gabriel.fernandez@linaro.org>
	 <1428657168-12495-4-git-send-email-gabriel.fernandez@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Something I didn't spot in my first look at this patch.

On Fri, 2015-04-10 at 11:12 +0200, Gabriel FERNANDEZ wrote:
> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
>  
> +config PCI_ST
> +	bool "ST PCIe controller"
> +	depends on ARCH_STI || (ARM && COMPILE_TEST)
> +	select PCIE_DW
> +	help
> +	  Enable PCIe controller support on ST Socs. This controller is based
> +	  on Designware hardware and therefore the driver re-uses the
> +	  Designware core functions to implement the driver.

You can't have ARCH_STI without ARM, so ARM will always be set if this
driver is enabled. Correct?

> --- /dev/null
> +++ b/drivers/pci/host/pci-st.c

> +	if (IS_ENABLED(CONFIG_ARM)) {
> +		/*
> +		 * We have to hook the abort handler so that we can intercept
> +		 * bus errors when doing config read/write that return UR,
> +		 * which is flagged up as a bus error
> +		 */
> +		hook_fault_code(16+6, st_pcie_abort_handler, SIGBUS, 0,
> +				"imprecise external abort");
> +	}

So, unless I'm missing something obvious here, IS_ENABLED(CONFIG_ARM)
will always evaluate to 1. Can't that test be dropped?


Paul Bolle

