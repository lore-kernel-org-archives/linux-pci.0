Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751969AbdFQNjf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 17 Jun 2017 09:39:35 -0400
Date: Sat, 17 Jun 2017 08:39:31 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: songxiaowei <songxiaowei@hisilicon.com>
Cc: Guodong Xu <guodong.xu@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
        kbuild test robot <lkp@intel.com>,
        "kbuild-all@01.org" <kbuild-all@01.org>,
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
        Will Deacon <will.deacon@arm.com>,
        "chenyao (F)" <chenyao11@huawei.com>,
        "Chenfeng (puck)" <puck.chen@hisilicon.com>,
        Wangbinghui <wangbinghui@hisilicon.com>,
        Suzhuangluan <suzhuangluan@hisilicon.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?562U5aSN?= =?utf-8?Q?=3A?= [PATCH v9 2/4] arm64: dts:
 hisi: add kirin pcie node
Message-ID: <20170617133931.GJ11129@bhelgaas-glaptop.roam.corp.google.com>
References: <20170531070109.81569-3-songxiaowei@hisilicon.com>
 <201706040735.pu1PIspV%fengguang.wu@intel.com>
 <CAK8P3a0K2jwiSQUVQWwebBEwXPVa04egcS_7q7gLgs-qt+J-sw@mail.gmail.com>
 <CAFGCpxxuboZJJS=zExmhDBLbb86zyN7me=dfnGKaf+LAPvCRGg@mail.gmail.com>
 <20170616211106.GF11129@bhelgaas-glaptop.roam.corp.google.com>
 <99B4C6BADD9E3241B25E52B02BA737C5411788ED@DGGEMA505-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <99B4C6BADD9E3241B25E52B02BA737C5411788ED@DGGEMA505-MBX.china.huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jun 17, 2017 at 08:33:08AM +0000, songxiaowei wrote:
> Hi Bjorn,
> 
> There are serval comments I can not understand, please help me to give more details.

Sure.  BTW, for some reason your response is all double-spaced, which
makes it a little hard to read.  Also, it includes HTML and an image,
which means the mailing list probably rejected it:
http://vger.kernel.org/majordomo-info.html#taboo

> diff --git a/Documentation/devicetree/bindings/pci/kirin-pcie.txt b/Documentation/devicetree/bindings/pci/kirin-pcie.txt
> 
> index 68ffa0fbcd73..20357d840af1 100644
> 
> --- a/Documentation/devicetree/bindings/pci/kirin-pcie.txt
> 
> +++ b/Documentation/devicetree/bindings/pci/kirin-pcie.txt
> 
> @@ -24,8 +24,8 @@ Example based on kirin960:
> 
>         pcie@f4000000 {
> 
>                 compatible = "hisilicon,kirin-pcie";
> 
> -                 reg = <0x0 0xf4000000 0x0 0x1000>, <0x0 0xff3fe000 0x0 0x1000>,
> 
> -                       <0x0 0xf3f20000 0x0 0x40000>, <0x0 0xF4000000 0 0x2000>;
> 
> +                reg = <0x0 0xf4000000 0x0  0x1000>, <0x0 0xff3fe000 0x0 0x1000>,
> 
> +                      <0x0 0xf3f20000 0x0 0x40000>, <0x0 0xf4000000 0x0 0x2000>;
> 
> [songxiaowei] The difference is add one more space between "0x0" and "0x1000" in the first element.
> 
>              But, I can't get your mind.

It changes from this:

        reg = <0x0 0xf4000000 0x0 0x1000>, <0x0 0xff3fe000 0x0 0x1000>,
              <0x0 0xf3f20000 0x0 0x40000>, <0x0 0xF4000000 0 0x2000>;

to this:

        reg = <0x0 0xf4000000 0x0  0x1000>, <0x0 0xff3fe000 0x0 0x1000>,
              <0x0 0xf3f20000 0x0 0x40000>, <0x0 0xf4000000 0x0 0x2000>;

The extra space makes the elements align vertically.  Columns of
numbers are conventionally right-aligned, which makes it easier to
compare their sizes.

This hunk also changed 0xF4000000 to 0xf4000000 in the second line, so
hex constants use lower-case consistently.

> --- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> 
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> 
> @@ -159,12 +159,12 @@
> 
>                  pcie@f4000000 {
> 
>                           compatible = "hisilicon,kirin960-pcie";
> 
> -                           reg = <0x0 0xf4000000 0x0 0x1000>,
> 
> -                                 <0x0 0xff3fe000 0x0 0x1000>,
> 
> +                          reg = <0x0 0xf4000000 0x0  0x1000>,
> 
> +                                <0x0 0xff3fe000 0x0  0x1000>,
> 
> [songxiaowei] Can your tell why using two spaces? Reg is listed as <addr_hi addr_lo size_hi size_lo>.

Again, just to make the sizes right-aligned so it's easier to compare
the sizes.

You can ignore this one if you want.  There are lots of examples in
the tree that don't align these.  I just think it looks sloppy when
things are almost but not quite aligned.

> -                                 <0x0 0xF5000000 0x0 0x2000>;
> +                                <0x0 0xf5000000 0x0  0x2000>;

Another case of making hex constants consistently lower-case.

> diff --git a/drivers/pci/dwc/pcie-kirin.c b/drivers/pci/dwc/pcie-kirin.c index f63e6548efae..41520dd1d5e5 100644
> 
> --- a/drivers/pci/dwc/pcie-kirin.c
> 
> +++ b/drivers/pci/dwc/pcie-kirin.c
> 
> @@ -35,8 +35,8 @@
> 
> #define REF_CLK_FREQ                    100000000
> 
>  /* PCIe ELBI registers */
> 
> -#define SOC_PCIECTRL_CTRL0_ADDR   0x000
> 
> -#define SOC_PCIECTRL_CTRL1_ADDR   0x004
> 
> +#define SOC_PCIECTRL_CTRL0_ADDR            0x000
> 
> +#define SOC_PCIECTRL_CTRL1_ADDR            0x004
> 
> #define SOC_PCIEPHY_CTRL2_ADDR             0x008
> 
> #define SOC_PCIEPHY_CTRL3_ADDR             0x00c
> ... 
> [songxiaowei] The space of the name of these macro definition and
> 
> the value are really different from 1 to 3 Tab, but it seem likes as bellow opened by vim.
> 
> [cid:image001.png@01D2E786.14883370]

The image shows this:

  +#define REF_CLK_FREQ                   100000000
  +
  +/* PCIe ELBI registers */
  +#define SOC_PCIECTRL_CTRL0_ADDR        0x000
  +#define SOC_PCIECTRL_CTRL1_ADDR        0x004
  +#define SOC_PCIEPHY_CTRL2_ADDR         0x008
  +#define SOC_PCIEPHY_CTRL3_ADDR         0x00c

So things are nicely aligned in the *patch*.  But we don't care about
alignment in the patch.  What we want is alignment in the *file*,
which ends up looking like this with your original patch:

  #define REF_CLK_FREQ                    100000000

  /* PCIe ELBI registers */
  #define SOC_PCIECTRL_CTRL0_ADDR 0x000
  #define SOC_PCIECTRL_CTRL1_ADDR 0x004
  #define SOC_PCIEPHY_CTRL2_ADDR          0x008
  #define SOC_PCIEPHY_CTRL3_ADDR          0x00c

My incremental diff probably makes the patch look ugly, but the
resulting file looks nicer.

>  struct kirin_pcie {
> 
> -        struct dw_pcie                   *pci;
> 
> -        void __iomem           *apb_base;
> ...
> +       struct dw_pcie          *pci;
> 
> +       void __iomem  *apb_base;
> ...
> [songxiaowei] it seems the variables list in the same coloumn with vim.

Yes, these variables were aligned in your original patch; it's just
that they used two or three tabs, when one or two was sufficient.  So
there's extra separation.  Not a big deal.

Bjorn
