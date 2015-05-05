Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 5 May 2015 17:16:46 -0500
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
Subject: Re: [PATCH v3 3/5] PCI: st: Provide support for the sti PCIe
 controller
Message-ID: <20150505221646.GE24643@google.com>
References: <1428657168-12495-1-git-send-email-gabriel.fernandez@linaro.org>
 <1428657168-12495-4-git-send-email-gabriel.fernandez@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1428657168-12495-4-git-send-email-gabriel.fernandez@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 10, 2015 at 11:12:46AM +0200, Gabriel FERNANDEZ wrote:
> sti pcie is built around a Synopsis Designware PCIe IP.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>

> +/* ST PCIe driver does not allow module unload */

Is there something that prevents module unload, or is it just untested?

> +static int __init pcie_init(void)
> +{
> +	return platform_driver_probe(&st_pcie_driver, st_pcie_probe);
> +}
> +device_initcall(pcie_init);

Can you use module_platform_driver_probe() or module_init() here?

> +MODULE_AUTHOR("Fabrice Gasnier <fabrice.gasnier@st.com>");
> +MODULE_DESCRIPTION("PCI express Driver for ST SoCs");
> +MODULE_LICENSE("GPL v2");
> -- 
> 1.9.1
> 
