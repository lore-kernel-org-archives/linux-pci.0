Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jingoo Han <jg1.han@samsung.com>
To: 'Sachin Kamat' <sachin.kamat@linaro.org>
Cc: 'Bjorn Helgaas' <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	'Kukjin Kim' <kgene.kim@samsung.com>,
	'Pratyush Anand' <pratyush.anand@st.com>,
	'Mohit KUMAR' <Mohit.KUMAR@st.com>,
	'Siva Reddy Kallam' <siva.kallam@samsung.com>,
	'SRIKANTH TUMKUR SHIVANAND' <ts.srikanth@samsung.com>,
	'Arnd Bergmann' <arnd@arndb.de>,
	'Sean Cross' <xobs@kosagi.com>,
	'Kishon Vijay Abraham I' <kishon@ti.com>,
	'Thierry Reding' <thierry.reding@gmail.com>,
	'Thomas Petazzoni' <thomas.petazzoni@free-electrons.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	'Jingoo Han' <jg1.han@samsung.com>
References: <000401ce9739$e0a65410$a1f2fc30$@samsung.com>
 <CAK9yfHwEPEfhMCWGbDWK2NQE2zAgmsQc6_Dn498pRP4UX6sYmQ@mail.gmail.com>
In-reply-to: <CAK9yfHwEPEfhMCWGbDWK2NQE2zAgmsQc6_Dn498pRP4UX6sYmQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: exynos: add support for MSI
Date: Thu, 22 Aug 2013 14:25:26 +0900
Message-id: <000101ce9ef8$024f1be0$06ed53a0$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday, August 12, 2013 6:13 PM, Sachin Kamat wrote:
> On 12 August 2013 14:26, Jingoo Han <jg1.han@samsung.com> wrote:
> > This patch adds support for Message Signaled Interrupt in the
> > Exynops PCIe diver using Synopsys designware PCIe core IP.
> 
> s/Exynops PCIe diver/Exynos PCIe driver

OK, I will fix this typo.

> > Signed-off-by: Siva Reddy Kallam <siva.kallam@samsung.com>
> > Signed-off-by: Srikanth T Shivanand <ts.srikanth@samsung.com>
> > Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> > Cc: Pratyush Anand <pratyush.anand@st.com>
> > Cc: Mohit KUMAR <Mohit.KUMAR@st.com>
> > ---
> >  arch/arm/boot/dts/exynos5440.dtsi  |    2 +
> >  arch/arm/mach-exynos/Kconfig       |    1 +
> >  drivers/pci/host/pci-exynos.c      |   60 ++++++++++
> >  drivers/pci/host/pcie-designware.c |  213 ++++++++++++++++++++++++++++++++++++
> >  drivers/pci/host/pcie-designware.h |    8 ++
> >  5 files changed, 284 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/exynos5440.dtsi b/arch/arm/boot/dts/exynos5440.dtsi
> > index 586134e..3746835 100644
> > --- a/arch/arm/boot/dts/exynos5440.dtsi
> > +++ b/arch/arm/boot/dts/exynos5440.dtsi
> > @@ -249,6 +249,7 @@
> >                 interrupt-map-mask = <0 0 0 0>;
> >                 interrupt-map = <0x0 0 &gic 53>;
> >                 num-lanes = <4>;
> > +               msi-base = <200>;
> 
> Please update the bindings documentation too.

OK, I will updated the bindings documentation.

[.....]

> > +#ifdef CONFIG_PCI_MSI
> > +static void exynos_pcie_clear_irq_level(struct pcie_port *pp)
> > +{
> > +       u32 val;
> > +       struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
> > +       void __iomem *elbi_base = exynos_pcie->elbi_base;
> > +
> > +       val = readl(elbi_base + PCIE_IRQ_LEVEL);
> > +       writel(val, elbi_base + PCIE_IRQ_LEVEL);
> 
> Sorry, I did not get this. Writing the value read from the same
> register without any operation.

It was intended to clear the bits by writing 1 of each bit.
But I will remove this function.

My coworker, Srikanth T Shivanand found that this function is
unnecessary. This is because PCIE_IRQ_LEVEL register is read-only
register. Also, PCIE_IRQ_LEVEL register is already cleared before
this function is called.

Thank you for your comment.

Best regards,
Jingoo Han


