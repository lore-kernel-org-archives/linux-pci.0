Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 6 Oct 2015 20:01:21 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Gabriel Fernandez <gabriel.fernandez@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Srinivas Kandagatla <srinivas.kandagatla@gmail.com>,
	Maxime Coquelin <maxime.coquelin@st.com>,
	Patrice Chotard <patrice.chotard@st.com>,
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
	Arnd Bergmann <arnd@arndb.de>,
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
Subject: Re: [PATCH v5 1/3] ARM: STi: Kconfig update for PCIe support
Message-ID: <20151006190121.GV21513@n2100.arm.linux.org.uk>
References: <1444118168-13086-1-git-send-email-gabriel.fernandez@linaro.org>
 <1444118168-13086-2-git-send-email-gabriel.fernandez@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1444118168-13086-2-git-send-email-gabriel.fernandez@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 06, 2015 at 09:56:06AM +0200, Gabriel Fernandez wrote:
> Update Kconfig:
> - MIGHT_HAVE_PCI
> - PCI_DOMAINS
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>  arch/arm/mach-sti/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/mach-sti/Kconfig b/arch/arm/mach-sti/Kconfig
> index 125865d..5f99e93 100644
> --- a/arch/arm/mach-sti/Kconfig
> +++ b/arch/arm/mach-sti/Kconfig
> @@ -9,6 +9,8 @@ menuconfig ARCH_STI
>  	select ARCH_HAS_RESET_CONTROLLER
>  	select HAVE_ARM_SCU if SMP
>  	select ARCH_REQUIRE_GPIOLIB
> +	select PCI_DOMAINS if PCI
> +	select MIGHT_HAVE_PCI
>  	select ARM_ERRATA_754322
>  	select ARM_ERRATA_764369 if SMP
>  	select ARM_ERRATA_775420

Please, alphabetical ordering for select statements.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
