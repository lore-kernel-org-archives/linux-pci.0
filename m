Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:64312 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751894Ab3LLSQU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 12 Dec 2013 13:16:20 -0500
Received: by mail-wi0-f181.google.com with SMTP id hq4so2917516wib.14
        for <linux-pci@vger.kernel.org>; Thu, 12 Dec 2013 10:16:18 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <201312121122.33746.marex@denx.de>
References: <1386757818-5154-1-git-send-email-marex@denx.de>
	<CAJ+vNU38oofeUjJ2s1J-2JNC+UM0MsET3EaGvDaGF9URS_efTA@mail.gmail.com>
	<201312121122.33746.marex@denx.de>
Date: Thu, 12 Dec 2013 10:16:18 -0800
Message-ID: <CAJ+vNU0aoOtZEdq6GDPpwZAgu+EN3FjHnr8JAdXCxOiDfJ5m6A@mail.gmail.com>
Subject: Re: [PATCH 1/7] PCI: imx6: Make reset-gpio optional
From: Tim Harvey <tharvey@gateworks.com>
To: Marek Vasut <marex@denx.de>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <lznuaa@gmail.com>, Harro Haan <hrhaan@gmail.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Mohit KUMAR <Mohit.KUMAR@st.com>,
	Pratyush Anand <pratyush.anand@st.com>,
	Richard Zhu <r65037@freescale.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Sean Cross <xobs@kosagi.com>, Shawn Guo <shawn.guo@linaro.org>,
	Siva Reddy Kallam <siva.kallam@samsung.com>,
	Srikanth T Shivanand <ts.srikanth@samsung.com>,
	Troy Kisky <troy.kisky@boundarydevices.com>,
	Yinghai Lu <yinghai@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 12, 2013 at 2:22 AM, Marek Vasut <marex@denx.de> wrote:
>
> On Thursday, December 12, 2013 at 06:10:31 AM, Tim Harvey wrote:
> > On Wed, Dec 11, 2013 at 2:30 AM, Marek Vasut <marex@denx.de> wrote:
> > > Some boards do not have a PCIe reset GPIO. To avoid probe
> > > failure on these boards, make the reset GPIO optional as
> > > well.
> > >
> > > Signed-off-by: Marek Vasut <marex@denx.de>
> > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > Cc: Frank Li <lznuaa@gmail.com>
> > > Cc: Harro Haan <hrhaan@gmail.com>
> > > Cc: Jingoo Han <jg1.han@samsung.com>
> > > Cc: Mohit KUMAR <Mohit.KUMAR@st.com>
> > > Cc: Pratyush Anand <pratyush.anand@st.com>
> > > Cc: Richard Zhu <r65037@freescale.com>
> > > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > > Cc: Sean Cross <xobs@kosagi.com>
> > > Cc: Shawn Guo <shawn.guo@linaro.org>
> > > Cc: Siva Reddy Kallam <siva.kallam@samsung.com>
> > > Cc: Srikanth T Shivanand <ts.srikanth@samsung.com>
> > > Cc: Tim Harvey <tharvey@gateworks.com>
> > > Cc: Troy Kisky <troy.kisky@boundarydevices.com>
> > > Cc: Yinghai Lu <yinghai@kernel.org>
> > > ---
> > >
> > >  .../devicetree/bindings/pci/designware-pcie.txt    |  2 +-
> > >  drivers/pci/host/pci-imx6.c                        | 29
> > >  +++++++++++----------- 2 files changed, 16 insertions(+), 15
> > >  deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/pci/designware-pcie.txt
> > > b/Documentation/devicetree/bindings/pci/designware-pcie.txt index
> > > d5d26d4..b7a2279 100644
> > > --- a/Documentation/devicetree/bindings/pci/designware-pcie.txt
> > > +++ b/Documentation/devicetree/bindings/pci/designware-pcie.txt
> > >
> > > @@ -19,9 +19,9 @@ Required properties:
> > >         to define the mapping of the PCIe interface to interrupt
> > >         numbers.
> > >
> > >  - num-lanes: number of lanes to use
> > >
> > > -- reset-gpio: gpio pin number of power good signal
> > >
> > >  Optional properties for fsl,imx6q-pcie
> > >
> > > +- reset-gpio: gpio pin number of power good signal
> > >
> > >  - power-on-gpio: gpio pin number of power-enable signal
> > >  - wake-up-gpio: gpio pin number of incoming wakeup signal
> > >  - disable-gpio: gpio pin number of outgoing rfkill/endpoint disable
> > >  signal
> > >
> > > diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> > > index bd70af8..52027ad 100644
> > > --- a/drivers/pci/host/pci-imx6.c
> > > +++ b/drivers/pci/host/pci-imx6.c
> > > @@ -214,9 +214,12 @@ static int imx6_pcie_assert_core_reset(struct
> > > pcie_port *pp)
> > >
> > >         regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> > >
> > >                         IMX6Q_GPR1_PCIE_REF_CLK_EN, 0 << 16);
> > >
> > > -       gpio_set_value(imx6_pcie->reset_gpio, 0);
> > > -       msleep(100);
> > > -       gpio_set_value(imx6_pcie->reset_gpio, 1);
> > > +       /* Some boards don't have PCIe reset GPIO. */
> > > +       if (gpio_is_valid(imx6_pcie->reset_gpio)) {
> > > +               gpio_set_value(imx6_pcie->reset_gpio, 0);
> > > +               msleep(100);
> > > +               gpio_set_value(imx6_pcie->reset_gpio, 1);
> > > +       }
> > >
> > >         return 0;
> > >
> > >  }
> >
> > Marek,
> >
> > Though not the fault of your patch, I noticed while looking at this
> > that the PCI Express specification is not being properly met with
> > regards to PERST# and the reference clock.  The spec states that
> > PERST# must be kept asserted until after the reference clock is stable
> > (I'm not entirely clear how long of a delay is needed for the clock to
> > become stable but I think the value is typically the 100ms).  I see in
> > the current pci-imx6.c code that imx6_pcie_host_init calls
> > imx6_pcie_assert_core_reset first, then imx6_pcie_init_phy, followed
> > by imx6_pcie_deassert_core_reset.  Despite the function names,
> > imx6_pcie_assert_core_reset as shown above asserts then de-asserts
> > PERST# before the clock is enabled in imx6_pcie_deassert_core_reset.
> > This seems to me to be a violation of the spec and I believe the
> > msleep(100) and de-assertion of the option reset_gpio should be done
> > in imx6_pcie_deassert_core reset after the clock is brought up.
> >
> > If you agree with my assessment, would you mind resolving this issue
> > at the same time?  If not, I'm happy to follow-up with a patch to
> > resolve it after your patch is accepted.
>
> Is this not resolved by patch 0006 in this series please?

Marek,

Yes it is addressed there.  Sorry - I missed that.

Tim
