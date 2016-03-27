Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:34880 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751911AbcC0OoS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 27 Mar 2016 10:44:18 -0400
MIME-Version: 1.0
In-Reply-To: <m3h9fuk7ik.fsf@t19.piap.pl>
References: <m3h9fuk7ik.fsf@t19.piap.pl>
Date: Sun, 27 Mar 2016 11:44:17 -0300
Message-ID: <CAOMZO5DcZCxoLPeGRWSGkstm7F3eN-Q-yJyf6ktMTda2zLviag@mail.gmail.com>
Subject: Re: [PATCH] i.MX6 PCIe: Fix imx6_pcie_deassert_core_reset() polarity
From: Fabio Estevam <festevam@gmail.com>
To: =?UTF-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
Cc: =?UTF-8?Q?Petr_=C5=A0tetiar?= <ynezz@true.cz>,
	Richard Zhu <Richard.Zhu@freescale.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 25, 2016 at 10:32 AM, Krzysztof Hałasa <khalasa@piap.pl> wrote:
> A recent commit 5c5fb40de8f14391a1238db05cef88754faf9229 stated:
> Follows: linus/v4.4-rc2
> Precedes: linus/v4.5-rc1
>
>     PCI: imx6: Add support for active-low reset GPIO
>
>     We previously used of_get_named_gpio(), which ignores the OF flags cell, so
>     the reset GPIO defaulted to "active high." This doesn't work on the Toradex
>     Apalis SoM with Ixora base board, which has an active-low reset GPIO.
>
>     Use devm_gpiod_get_optional() instead so we pay attention to the active
>     high/low flag.  This also adds support for GPIOs described via ACPI.
>
> The (now replaced) code doesn't support the above:
> @@ -287,10 +287,10 @@ static int imx6_pcie_deassert_core_reset(struct pcie_port *pp)
>      usleep_range(200, 500);
>
>      /* Some boards don't have PCIe reset GPIO. */
> -    if (gpio_is_valid(imx6_pcie->reset_gpio)) {
> -        gpio_set_value_cansleep(imx6_pcie->reset_gpio, 0);
> +    if (imx6_pcie->reset_gpio) {
> +        gpiod_set_value_cansleep(imx6_pcie->reset_gpio, 0);
>          msleep(100);
> -        gpio_set_value_cansleep(imx6_pcie->reset_gpio, 1);
> +        gpiod_set_value_cansleep(imx6_pcie->reset_gpio, 1);
>      }
>      return 0;
>
> If the reset_gpio setup code had ignored the flags (haven't checked
> that), then clearly the resets were active-low (most reset lines are,
> because they can be then driven with open-drain/collector output).
> The gpiod_set_value*(0) activates reset, gpiod_set_value(1) -
> deactivates.
>
> Now we're told the setup code is now level-aware, but the above sequence
> thus _deactivates_ reset for 100 ms, then _activates_ it again. It has
> no chance to work, unless a board has a broken DTS file. A quick grep
> shows that about half the IMX6 boards specify an active-low PCIe reset,
> 4 ask for active-high, and another 4 don't bother.
>
>
> I wonder if all boards (except maybe that Toradex set) use an active-low
> PCIe reset and are now broken. Perhaps Toradex uses active-high and thus
> works.
>
> I'm not fixing individual DTS files because I don't really know, though
> perhaps we should change them all to "active-low", since it would work
> the same as before the 5c5fb40de8f14391a1238db05cef88754faf9229 change.
>
> Confirmed to fix Gateworks Laguna GW54xx.
> Without the patch, the following happens (as expected):
>
> PCI host bridge /soc/pcie@0x01000000 ranges:
>   No bus range found for /soc/pcie@0x01000000, using [bus 00-ff]
>    IO 0x01f80000..0x01f8ffff -> 0x00000000
>   MEM 0x01000000..0x01efffff -> 0x01000000
> imx6q-pcie 1ffc000.pcie: phy link never came up
>
> Signed-off-by: Krzysztof Hałasa <khalasa@piap.pl>

Good catch!

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>

I will fix imx6q-sabresd.dtsi when this patch gets applied.
