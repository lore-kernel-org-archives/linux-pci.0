Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cpsmtpb-ews01.kpnxchange.com ([213.75.39.4]:52423 "EHLO
	cpsmtpb-ews01.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933598AbbCPPLj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 16 Mar 2015 11:11:39 -0400
Message-ID: <1426518695.26437.55.camel@x220>
Subject: Re: [PATCH v2 3/5] PCI: st: Provide support for the sti PCIe
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
	Mohit Kumar <mohit.kumar@st.com>,
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
Date: Mon, 16 Mar 2015 16:11:35 +0100
In-Reply-To: <1426515635-9466-4-git-send-email-gabriel.fernandez@linaro.org>
References: <1426515635-9466-1-git-send-email-gabriel.fernandez@linaro.org>
	 <1426515635-9466-4-git-send-email-gabriel.fernandez@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 2015-03-16 at 15:20 +0100, Gabriel FERNANDEZ wrote:
> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
 
> +config PCI_ST
> +	bool "ST PCIe controller"

You add a bool Kconfig symbol. A week or two ago I saw some patches fly
by that - I think - allowed PCIe controllers to be built modular.

> +	depends on ARCH_STI || (ARM && COMPILE_TEST)
> +	select PCIE_DW
> +	help
> +	  Enable PCIe controller support on ST Socs. This controller is based
> +	  on Designware hardware and therefore the driver re-uses the
> +	  Designware core functions to implement the driver.

> --- a/drivers/pci/host/Makefile
> +++ b/drivers/pci/host/Makefile

> +obj-$(CONFIG_PCI_ST) += pci-st.o

If you keep that symbol bool this objectfile will never be part of a
module.

> diff --git a/drivers/pci/host/pci-st.c b/drivers/pci/host/pci-st.c
> new file mode 100644
> index 0000000..470000d
> --- /dev/null
> +++ b/drivers/pci/host/pci-st.c

> +#include <linux/module.h>

For built-in code this include is, probably, not needed.

> +MODULE_DEVICE_TABLE(of, st_pcie_of_match);

For built-in code that macro will always be preprocessed away.

> +/* ST PCIe driver does not allow module unload */
> +static int __init pcie_init(void)
> +{
> +	return platform_driver_probe(&st_pcie_driver, st_pcie_probe);
> +}
> +device_initcall(pcie_init);

I think the module unload comment is a bit odd for built-in only code.

> +MODULE_AUTHOR("Fabrice Gasnier <fabrice.gasnier@st.com>");
> +MODULE_DESCRIPTION("PCI express Driver for ST SoCs");
> +MODULE_LICENSE("GPL v2");

These three macros will be, basically, always preprocessed away as long
as this code can't be built to be modular.


Paul Bolle

