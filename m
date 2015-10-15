Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:52591 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752056AbbJOOvS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 15 Oct 2015 10:51:18 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: WingMan Kwok <w-kwok2@ti.com>, robh+dt@kernel.org,
	pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org, kishon@ti.com,
	rogerq@ti.com, m-karicheri2@ti.com, bhelgaas@google.com,
	ssantosh@kernel.org, linux@arm.linux.org.uk,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v1 1/2] phy: keystone: serdes driver for gbe 10gbe and pcie
Date: Thu, 15 Oct 2015 16:51:02 +0200
Message-ID: <5192855.p6QLDWTiVi@wuerfel>
In-Reply-To: <1444919145-30845-2-git-send-email-w-kwok2@ti.com>
References: <1444919145-30845-1-git-send-email-w-kwok2@ti.com> <1444919145-30845-2-git-send-email-w-kwok2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 15 October 2015 10:25:44 WingMan Kwok wrote:
> On TI's Keystone platforms, several peripherals such as the
> gbe ethernet switch, 10gbe ethernet switch and PCIe controller
> require the use of a SerDes for converting SoC parallel data into
> serialized data that can be output over a high-speed electrical
> interface, and also converting high-speed serial input data
> into parallel data that can be processed by the SoC.  The
> SerDeses used by those peripherals, though they may be different,
> are largely similar in functionality and setup.
> 
> This patch provides a SerDes phy driver implementation that can be
> used by the above mentioned peripheral drivers to configure their
> respective SerDeses.
> 
> v1:
> 	- see cover letter for review comments addressed.
> 
> Signed-off-by: WingMan Kwok <w-kwok2@ti.com>
> ---
>  Documentation/devicetree/bindings/phy/ti-phy.txt |  278 +++
>  drivers/phy/Kconfig                              |    8 +
>  drivers/phy/Makefile                             |    1 +
>  drivers/phy/phy-keystone-serdes.c                | 2373 ++++++++++++++++++++++
>  4 files changed, 2660 insertions(+)
>  create mode 100644 drivers/phy/phy-keystone-serdes.c

This is quite a bit of code. Are you very sure that this PHY is
not used on any other SoC family, and that it is not licensed
from a third party? I would hate to see multiple copies of
this getting merged into the kernel over time, so thename should
be chosen carefully to let the next person know when they have
related hardware.

> +
> +gbe_serdes0: gbe_serdes@232a000 {


make that phy@232a000, the name should be one of the usual identifiers,
not specific to the instance.

> +config PHY_TI_KEYSTONE_SERDES
> +	tristate "TI Keystone SerDes PHY support"
> +	depends on OF && ARCH_KEYSTONE
> +	select GENERIC_PHY
> +	help
> +	  This option enables support for TI Keystone SerDes PHY found
> +	  in peripherals GBE, 10GBE and PCIe.
> +

(ARCH_KEYSTONE || COMPILE_TEST) ?

> + * Redistributions in binary form must reproduce the above copyright
> + * notice, this list of conditions and the following disclaimer in the
> + * documentation and/or other materials provided with the
> + * distribution.

The current code does not do this when compiled, which might be a
problem for distributors. Can you clarify the license?

> +#define reg_rmw(addr, value, mask) \
> +	__raw_writel(((__raw_readl(addr) & (~(mask))) | \
> +			(value & (mask))), (addr))

not endian safe, and potentially racy.

> +static inline void _kserdes_reset_cdr(void __iomem *sregs, int lane)
> +{
> +	/* toggle signal detect */
> +	_kserdes_force_signal_detect_low(sregs, lane);
> +	mdelay(1);
> +	_kserdes_force_signal_detect_high(sregs, lane);
> +}

Can you change the code so you can use msleep(1) here?

> +
> +	do {
> +		mdelay(10);
> +		memset(lane_down, 0, sizeof(lane_down));
> +
> +		link_up = _kserdes_check_link_status(dev, sregs,
> +						     pcsr_regmap, lanes,
> +						     lanes_enable,
> +						     current_state, lane_down);
> +
> +		/* if we did not get link up then wait 100ms
> +		 * before calling it again
> +		 */
> +		if (link_up)
> +			break;
> +
> +		for (i = 0; i < lanes; i++) {
> +			if ((lanes_enable & (1 << i)) && lane_down[i])
> +				dev_dbg(dev,
> +					"XGE: detected lane down on lane %d\n",
> +					i);
> +		}
> +
> +		if (++retries > 100)
> +			return -ETIMEDOUT;
> +
> +	} while (!link_up);

an more importantly here. Blocking the CPU for over one second is not good.

Any use of mdelay() should have a comment explaining why you cannot use
msleep() in that instance.

> +
> +static int __init keystone_serdes_phy_init(void)
> +{
> +	return platform_driver_register(&kserdes_driver);
> +}
> +module_init(keystone_serdes_phy_init);
> +
> +static void __exit keystone_serdes_phy_exit(void)
> +{
> +	platform_driver_unregister(&kserdes_driver);
> +}
> +module_exit(keystone_serdes_phy_exit);

module_platform_driver()

	Arnd
