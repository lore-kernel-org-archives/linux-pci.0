Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750927AbdFPXBS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Jun 2017 19:01:18 -0400
Date: Fri, 16 Jun 2017 18:01:15 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Guodong Xu <guodong.xu@linaro.org>
Cc: "xuwei (O)" <xuwei5@hisilicon.com>, Arnd Bergmann <arnd@arndb.de>,
        kbuild test robot <lkp@intel.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>, kbuild-all@01.org,
        Bjorn Helgaas <bhelgaas@google.com>, Kishon <kishon@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Tomasz Nowicki <tn@semihalf.com>,
        Keith Busch <keith.busch@intel.com>,
        Niklas Cassel <niklas.cassel@axis.com>,
        Duc Dang <dhdang@apm.com>,
        "liudongdong (C)" <liudongdong3@huawei.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, chenyao11@huawei.com,
        Chen Feng <puck.chen@hisilicon.com>,
        Wangbinghui <wangbinghui@hisilicon.com>,
        Suzhuangluan <suzhuangluan@hisilicon.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 2/4] arm64: dts: hisi: add kirin pcie node
Message-ID: <20170616230115.GH11129@bhelgaas-glaptop.roam.corp.google.com>
References: <20170531070109.81569-3-songxiaowei@hisilicon.com>
 <201706040735.pu1PIspV%fengguang.wu@intel.com>
 <CAK8P3a0K2jwiSQUVQWwebBEwXPVa04egcS_7q7gLgs-qt+J-sw@mail.gmail.com>
 <CAFGCpxxuboZJJS=zExmhDBLbb86zyN7me=dfnGKaf+LAPvCRGg@mail.gmail.com>
 <20170616211106.GF11129@bhelgaas-glaptop.roam.corp.google.com>
 <CAFGCpxyY7qgiviK7zSEomL-bZRG=MXMC=04WphTWfx1L82=wpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAFGCpxyY7qgiviK7zSEomL-bZRG=MXMC=04WphTWfx1L82=wpA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jun 17, 2017 at 06:31:59AM +0800, Guodong Xu wrote:
> Hi, Bjorn
> 
> On Sat, Jun 17, 2017 at 5:11 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Tue, Jun 06, 2017 at 07:19:53PM +0800, Guodong Xu wrote:
> >> Hi, Arnd
> >>
> >> On Tue, Jun 6, 2017 at 5:23 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> >> > On Sun, Jun 4, 2017 at 2:03 AM, kbuild test robot <lkp@intel.com> wrote:
> >> >> Hi Xiaowei,
> >> >>
> >> >> [auto build test ERROR on pci/next]
> >> >> [also build test ERROR on v4.12-rc3 next-20170602]
> >> >> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> >> >>
> >> >> url:    https://github.com/0day-ci/linux/commits/Xiaowei-Song/add-PCIe-driver-for-Kirin-PCIe/20170531-182118
> >> >> base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
> >> >> config: arm64-allnoconfig (attached as .config)
> >> >> compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
> >> >> reproduce:
> >> >>         wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >> >>         chmod +x ~/bin/make.cross
> >> >>         # save the attached .config to linux build tree
> >> >>         make.cross ARCH=arm64
> >> >>
> >> >> All errors (new ones prefixed by >>):
> >> >>
> >> >>>> Error: arch/arm64/boot/dts/hisilicon/hi3660.dtsi:180.24-25 syntax error
> >> >>>> FATAL ERROR: Unable to parse input tree
> >> >
> >> > We keep getting the build errors for patch submissions. Obviously the patch is
> >> > still broken and can't be merged as-is. What is the plan for merging the series?
> >> >
> >>
> >> This dts patch can be applied to dts series [1]. For upstream review
> >> purpose, hi3660-hikey960 dts patches, which don't have a related
> >> driver changes, are sent in [1]. Other patches, which need driver
> >> changes, like this one, are sent together with driver.
> >>
> >> Patchset [1] is now at its v2 review. Rob Herring already gave his ACK
> >> for some of them in v1. Hopefully I can get more ACK for remaining
> >> ones, and make them ready for v4.13 merging window.
> >>
> >> [1], http://www.spinics.net/lists/devicetree/msg178303.html
> >
> > I don't know how you want to deal with the DTS build failure.
> 
> DTS part of this is also included in a broader Hi3660 dts patchset [1], and
> was ACK'ed [2] today by HiSilicon SoC maintainer Xu Wei. Hopefully
> they can land in next merge window.
> 
> [1] https://www.spinics.net/lists/arm-kernel/msg588232.html
> [2] https://www.spinics.net/lists/arm-kernel/msg588686.html

This sounds good, but doesn't help me make progress.  I don't want to
apply [PATCH v9 2/4] because it didn't build.  I haven't seen an
updated series that *does* build.  And it probably doesn't make sense
for me to apply the arch/arm64 changes anyway because they aren't
really in the PCI purview.

If you want me to apply something, post patches 1 and 3 by themselves
with the trival updates I included.  Those are really only PCI and
should build without error.

> > From a
> > PCI perspective, I think I could apply patches 1 and 3 pretty easily
> > by themselves.
> >
> > If/when you post these again, please incorporate the following
> > incremental diff to clean up various whitespace and capitalization
> > nits (these are spread across several of your patches).
> >
> >
> > diff --git a/Documentation/devicetree/bindings/pci/kirin-pcie.txt b/Documentation/devicetree/bindings/pci/kirin-pcie.txt
> > index 68ffa0fbcd73..20357d840af1 100644
> > --- a/Documentation/devicetree/bindings/pci/kirin-pcie.txt
> > +++ b/Documentation/devicetree/bindings/pci/kirin-pcie.txt
> > @@ -24,8 +24,8 @@ Example based on kirin960:
> >
> >         pcie@f4000000 {
> >                 compatible = "hisilicon,kirin-pcie";
> > -               reg = <0x0 0xf4000000 0x0 0x1000>, <0x0 0xff3fe000 0x0 0x1000>,
> > -                     <0x0 0xf3f20000 0x0 0x40000>, <0x0 0xF4000000 0 0x2000>;
> > +               reg = <0x0 0xf4000000 0x0  0x1000>, <0x0 0xff3fe000 0x0 0x1000>,
> > +                     <0x0 0xf3f20000 0x0 0x40000>, <0x0 0xf4000000 0x0 0x2000>;
> >                 reg-names = "dbi","apb","phy", "config";
> >                 bus-range = <0x0  0x1>;
> >                 #address-cells = <3>;
> > @@ -46,5 +46,5 @@ Example based on kirin960:
> >                          <&crg_ctrl HI3660_ACLK_GATE_PCIE>;
> >                 clock-names = "pcie_phy_ref", "pcie_aux",
> >                               "pcie_apb_phy", "pcie_apb_sys", "pcie_aclk";
> > -               reset-gpios = <&gpio11 1 0 >;
> > +               reset-gpios = <&gpio11 1 0>;
> >         };
> > diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> > index e8feb2fb4d53..7bc89baa40ba 100644
> > --- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> > +++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> > @@ -159,12 +159,12 @@
> >
> >                 pcie@f4000000 {
> >                         compatible = "hisilicon,kirin960-pcie";
> > -                       reg = <0x0 0xf4000000 0x0 0x1000>,
> > -                             <0x0 0xff3fe000 0x0 0x1000>,
> > +                       reg = <0x0 0xf4000000 0x0  0x1000>,
> > +                             <0x0 0xff3fe000 0x0  0x1000>,
> >                               <0x0 0xf3f20000 0x0 0x40000>,
> > -                             <0x0 0xF5000000 0x0 0x2000>;
> > +                             <0x0 0xf5000000 0x0  0x2000>;
> >                         reg-names = "dbi", "apb", "phy", "config";
> > -                       bus-range = <0x0  0x1>;
> > +                       bus-range = <0x0 0x1>;
> >                         #address-cells = <3>;
> >                         #size-cells = <2>;
> >                         device_type = "pci";
> > @@ -173,7 +173,7 @@
> >                         num-lanes = <1>;
> >                         #interrupt-cells = <1>;
> >                         interrupt-map-mask = <0xf800 0 0 7>;
> > -                       interrupt-map = <0x0 0 0 1 &gic 0 0 0 282 4>,
> > +                       interrupt-map = <0x0 0 0 1 &gic 0 0 0  282 4>,
> >                                         <0x0 0 0 2 &gic 0 0 0  283 4>,
> >                                         <0x0 0 0 3 &gic 0 0 0  284 4>,
> >                                         <0x0 0 0 4 &gic 0 0 0  285 4>;
> > @@ -183,8 +183,9 @@
> >                                  <&crg_ctrl HI3660_PCLK_GATE_PCIE_SYS>,
> >                                  <&crg_ctrl HI3660_ACLK_GATE_PCIE>;
> >                         clock-names = "pcie_phy_ref", "pcie_aux",
> > -                                     "pcie_apb_phy", "pcie_apb_sys", "pcie_aclk";
> > -                       reset-gpios = <&gpio11 1 0 >;
> > +                                     "pcie_apb_phy", "pcie_apb_sys",
> > +                                     "pcie_aclk";
> > +                       reset-gpios = <&gpio11 1 0>;
> >                         status = "ok";
> >                 };
> >         };
> > diff --git a/drivers/pci/dwc/pcie-kirin.c b/drivers/pci/dwc/pcie-kirin.c
> > index f63e6548efae..41520dd1d5e5 100644
> > --- a/drivers/pci/dwc/pcie-kirin.c
> > +++ b/drivers/pci/dwc/pcie-kirin.c
> > @@ -35,8 +35,8 @@
> >  #define REF_CLK_FREQ                   100000000
> >
> >  /* PCIe ELBI registers */
> > -#define SOC_PCIECTRL_CTRL0_ADDR        0x000
> > -#define SOC_PCIECTRL_CTRL1_ADDR        0x004
> > +#define SOC_PCIECTRL_CTRL0_ADDR                0x000
> > +#define SOC_PCIECTRL_CTRL1_ADDR                0x004
> >  #define SOC_PCIEPHY_CTRL2_ADDR         0x008
> >  #define SOC_PCIEPHY_CTRL3_ADDR         0x00c
> >  #define PCIE_ELBI_SLV_DBI_ENABLE       (0x1 << 21)
> > @@ -48,30 +48,30 @@
> >  #define PCIE_APB_PHY_STATUS0           0x400
> >  #define PCIE_LINKUP_ENABLE             (0x8020)
> >  #define PCIE_LTSSM_ENABLE_BIT          (0x1 << 11)
> > -#define PIPE_CLK_STABLE                (0x1 << 19)
> > +#define PIPE_CLK_STABLE                        (0x1 << 19)
> >  #define PIPE_CLK_MAX_TRY_TIMES         10
> > -#define PHY_REF_PAD_BIT                (0x1 << 8)
> > +#define PHY_REF_PAD_BIT                        (0x1 << 8)
> >  #define PHY_PWR_DOWN_BIT               (0x1 << 22)
> > -#define PHY_RST_ACK_BIT                (0x1 << 16)
> > +#define PHY_RST_ACK_BIT                        (0x1 << 16)
> >
> >  /* info located in sysctrl */
> >  #define SCTRL_PCIE_CMOS_OFFSET         0x60
> >  #define SCTRL_PCIE_CMOS_BIT            0x10
> >  #define SCTRL_PCIE_ISO_OFFSET          0x44
> >  #define SCTRL_PCIE_ISO_BIT             0x30
> > -#define SCTRL_PCIE_HPCLK_OFFSET        0x190
> > +#define SCTRL_PCIE_HPCLK_OFFSET                0x190
> >  #define SCTRL_PCIE_HPCLK_BIT           0x184000
> >  #define SCTRL_PCIE_OE_OFFSET           0x14a
> > -#define PCIE_DEBOUNCE_PARAM            0xF0F400
> > +#define PCIE_DEBOUNCE_PARAM            0xf0f400
> >  #define PCIE_OE_BYPASS                 (0x3 << 28)
> >
> >  /* peri_crg ctrl */
> >  #define CRGCTRL_PCIE_ASSERT_OFFSET     0x88
> > -#define CRGCTRL_PCIE_ASSERT_BIT        0x8c000000
> > +#define CRGCTRL_PCIE_ASSERT_BIT                0x8c000000
> >
> >  /* Time for delay */
> > -#define REF_2_PERST_MIN                20000
> > -#define REF_2_PERST_MAX                25000
> > +#define REF_2_PERST_MIN                        20000
> > +#define REF_2_PERST_MAX                        25000
> >  #define PERST_2_ACCESS_MIN             10000
> >  #define PERST_2_ACCESS_MAX             12000
> >  #define LINK_WAIT_MIN                  900
> > @@ -80,22 +80,22 @@
> >  #define PIPE_CLK_WAIT_MAX              600
> >
> >  struct kirin_pcie {
> > -       struct dw_pcie          *pci;
> > -       void __iomem            *apb_base;
> > -       void __iomem            *phy_base;
> > -       struct regmap           *crgctrl;
> > -       struct regmap           *sysctrl;
> > -       struct clk              *apb_sys_clk;
> > -       struct clk              *apb_phy_clk;
> > -       struct clk              *phy_ref_clk;
> > -       struct clk              *pcie_aclk;
> > -       struct clk              *pcie_aux_clk;
> > -       int                     gpio_id_reset;
> > +       struct dw_pcie  *pci;
> > +       void __iomem    *apb_base;
> > +       void __iomem    *phy_base;
> > +       struct regmap   *crgctrl;
> > +       struct regmap   *sysctrl;
> > +       struct clk      *apb_sys_clk;
> > +       struct clk      *apb_phy_clk;
> > +       struct clk      *phy_ref_clk;
> > +       struct clk      *pcie_aclk;
> > +       struct clk      *pcie_aux_clk;
> > +       int             gpio_id_reset;
> >  };
> >
> >  /* Registers in PCIeCTRL */
> >  static inline void kirin_apb_ctrl_writel(struct kirin_pcie *kirin_pcie,
> > -               u32 val, u32 reg)
> > +                                        u32 val, u32 reg)
> >  {
> >         writel(val, kirin_pcie->apb_base + reg);
> >  }
> > @@ -107,7 +107,7 @@ static inline u32 kirin_apb_ctrl_readl(struct kirin_pcie *kirin_pcie, u32 reg)
> >
> >  /* Registers in PCIePHY */
> >  static inline void kirin_apb_phy_writel(struct kirin_pcie *kirin_pcie,
> > -               u32 val, u32 reg)
> > +                                       u32 val, u32 reg)
> >  {
> >         writel(val, kirin_pcie->phy_base + reg);
> >  }
> > @@ -118,7 +118,7 @@ static inline u32 kirin_apb_phy_readl(struct kirin_pcie *kirin_pcie, u32 reg)
> >  }
> >
> >  static long kirin_pcie_get_clk(struct kirin_pcie *kirin_pcie,
> > -               struct platform_device *pdev)
> > +                              struct platform_device *pdev)
> >  {
> >         struct device *dev = &pdev->dev;
> >
> > @@ -146,7 +146,7 @@ static long kirin_pcie_get_clk(struct kirin_pcie *kirin_pcie,
> >  }
> >
> >  static long kirin_pcie_get_resource(struct kirin_pcie *kirin_pcie,
> > -               struct platform_device *pdev)
> > +                                   struct platform_device *pdev)
> >  {
> >         struct resource *apb;
> >         struct resource *phy;
> > @@ -184,7 +184,6 @@ static long kirin_pcie_get_resource(struct kirin_pcie *kirin_pcie,
> >  static int kirin_pcie_phy_init(struct kirin_pcie *kirin_pcie)
> >  {
> >         u32 reg_val;
> > -       u32 time = PIPE_CLK_MAX_TRY_TIMES;
> >
> >         reg_val = kirin_apb_phy_readl(kirin_pcie, PCIE_APB_PHY_CTRL1);
> >         reg_val &= ~PHY_REF_PAD_BIT;
> > @@ -459,7 +458,7 @@ static int kirin_pcie_probe(struct platform_device *pdev)
> >         int ret;
> >
> >         if (!dev->of_node) {
> > -               dev_err(&pdev->dev, "NULL node\n");
> > +               dev_err(dev, "NULL node\n");
> >                 return -EINVAL;
> >         }
> >
