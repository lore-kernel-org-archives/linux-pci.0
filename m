Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:34301 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932608AbcCPWM6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 16 Mar 2016 18:12:58 -0400
Received: by mail-io0-f176.google.com with SMTP id m184so77012027iof.1
        for <linux-pci@vger.kernel.org>; Wed, 16 Mar 2016 15:12:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAJ+vNU1TxqEfjH6jPLnStDuYTjHvt6TxFbe+QN2O5aVqwr1-Tg@mail.gmail.com>
References: <56D5E3DF.9030906@tekno-soft.it>
	<56D71F27.7070708@tekno-soft.it>
	<20160302195634.GA19223@localhost>
	<DBXPR04MB2706C7C2FD2348D205331998CBD0@DBXPR04MB270.eurprd04.prod.outlook.com>
	<56D80435.90408@tekno-soft.it>
	<DBXPR04MB2702F4BC78FA28DC82DCA218CBD0@DBXPR04MB270.eurprd04.prod.outlook.com>
	<56D8180A.1050708@tekno-soft.it>
	<56D84B6D.1050800@tekno-soft.it>
	<56D883AD.5060601@tekno-soft.it>
	<56DEE426.8030902@tekno-soft.it>
	<1457448829.3207.22.camel@pengutronix.de>
	<56E1B04A.9010206@tekno-soft.it>
	<56E679FE.20409@tekno-soft.it>
	<56E7ED1E.3070506@tekno-soft.it>
	<CAOMZO5C9H92mMqTPiOwMYhywBCyQuXQen3Vw==ELE-ppTtogqg@mail.gmail.com>
	<56E81C56.8060404@tekno-soft.it>
	<CAOMZO5C0rvszTg0bPoSnT5zzL8EC2Vk1PVDJgB1m1FREy9ncaQ@mail.gmail.com>
	<CAJ+vNU1TxqEfjH6jPLnStDuYTjHvt6TxFbe+QN2O5aVqwr1-Tg@mail.gmail.com>
Date: Wed, 16 Mar 2016 19:12:57 -0300
Message-ID: <CAOMZO5AV9Njwv2iVPLoZZfJg5rSiu4qGDf4P3w8grVNqk6RCrA@mail.gmail.com>
Subject: Re: iMX6q PCIe phy link never came up on kernel v4.4.x
From: Fabio Estevam <festevam@gmail.com>
To: Tim Harvey <tharvey@gateworks.com>
Cc: Roberto Fichera <kernel@tekno-soft.it>,
	Lucas Stach <l.stach@pengutronix.de>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Richard Zhu <Richard.Zhu@freescale.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 16, 2016 at 6:33 PM, Tim Harvey <tharvey@gateworks.com> wrote:

> Fabio,
>
> The board combination I have where an XIO2001 is connected directly to
> an IMX6 is a bit different from Roberto's setup. In our configuration
> the XIO2001 is on an 'expansion' board that its own local PCI clock
> generation. So, in my case the XIO2001 always has a valid clock
> before/during/after its reset. This is different from Roberto's
> scenario. I do recall running into an issue with the XIO2001 on
> another product with a different host controller that had to do with
> noise on the clk prior to its reset being asserted so I am not too
> surprised at what Roberto has found.
>
> I don't specifically see an issue with a change that asserts PCI_RST#
> before the CLK gets enabled then de-asserts it after at least 100ms
> has expired from clock enable - I think that actually follows the
> specs wording closer than what we currently do (turning o the clock
> prior to assert/de-assert reset). However I get very nervous at any
> change to the IMX6 PCIe init. We have found it to be very finicky
> because of the lack of a proper reset.

Would this be the minimal change to get Roberto's setup working with 4.5?

--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -232,6 +232,15 @@ static int imx6_pcie_assert_core_reset(struct
pcie_port *pp)
        u32 val, gpr1, gpr12;

        /*
+        * Some PCI bridges such as TI XIO2001 require PERST to be
+        * asserted before enabling the PCIe ref_clk, otherwise it will
+        * get "confused" and the PCIe link state will stuck in POLL_STATE
+        */
+
+       if (gpio_is_valid(imx6_pcie->reset_gpio))
+               gpiod_set_value_cansleep(imx6_pcie->reset_gpio, 0);
+
+       /*
         * If the bootloader already enabled the link we need some special
         * handling to get the core back into a state where it is safe to
         * touch it for configuration.  As there is no dedicated reset signal
@@ -305,7 +314,6 @@ static int imx6_pcie_deassert_core_reset(struct
pcie_port *pp)

        /* Some boards don't have PCIe reset GPIO. */
        if (imx6_pcie->reset_gpio) {
-               gpiod_set_value_cansleep(imx6_pcie->reset_gpio, 0);
                msleep(100);
                gpiod_set_value_cansleep(imx6_pcie->reset_gpio, 1);
        }

> Roberto,
>
> Did you require the changes regarding Gen2 negotiation? My
> IMX6+XIO2001 links reliably at Gen1 which makes sense for that chip.

Yes, it would be nice if Roberto could clarify if the Gen2 changes are
needed or not.

Also, is this change also really required?

     regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
             IMX6Q_GPR1_PCIE_TEST_PD, 1 << 18);
+    udelay(10);
     regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
             IMX6Q_GPR1_PCIE_REF_CLK_EN, 0 << 16);
