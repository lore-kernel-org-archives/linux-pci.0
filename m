Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: Gabriel Fernandez <gabriel.fernandez@linaro.org>
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
	" David S. Miller" <davem@davemloft.net>,
	Greg KH <gregkh@linuxfoundation.org>,
	Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
	Joe Perches <joe@perches.com>, Tejun Heo <tj@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Thierry Reding <treding@nvidia.com>,
	Phil Edworthy <phil.edworthy@renesas.com>,
	Minghuan Lian <Minghuan.Lian@freescale.com>,
	Tanmay Inamdar <tinamdar@apm.com>, m-karicheri2@ti.com,
	Sachin Kamat <sachin.kamat@samsung.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Zhou Wang <wangzhou1@hisilicon.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@stlinux.com,
	linux-pci@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v5 3/3] PCI: st: Provide support for the sti PCIe controller
Date: Tue, 06 Oct 2015 23:01:11 +0200
Message-ID: <5139149.TmJY1YjqAU@wuerfel>
In-Reply-To: <1444118168-13086-4-git-send-email-gabriel.fernandez@linaro.org>
References: <1444118168-13086-1-git-send-email-gabriel.fernandez@linaro.org> <1444118168-13086-4-git-send-email-gabriel.fernandez@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 06 October 2015 09:56:08 Gabriel Fernandez wrote:
> +
> +/*
> + * On ARM platforms, we actually get a bus error returned when the PCIe IP
> + * returns a UR or CRS instead of an OK.
> + */
> +static int st_pcie_abort_handler(unsigned long addr, unsigned int fsr,
> +                                struct pt_regs *regs)
> +{
> +       return 0;
> +}
> 

I'm not sure if we discussed this already for this driver. Usually
you should have a register in the PCI host that you can check to see
what caused the abort.

Try to make this as narrow as possible so you return nonzero for
any abort except the one you actually try to prevent.

	Arnd
