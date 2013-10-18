Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-we0-f177.google.com ([74.125.82.177]:34049 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185Ab3JRFcx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 18 Oct 2013 01:32:53 -0400
Received: by mail-we0-f177.google.com with SMTP id x55so3197385wes.22
        for <linux-pci@vger.kernel.org>; Thu, 17 Oct 2013 22:32:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1379319655-20210-4-git-send-email-xobs@kosagi.com>
References: <1379319655-20210-1-git-send-email-xobs@kosagi.com>
	<1379319655-20210-4-git-send-email-xobs@kosagi.com>
Date: Thu, 17 Oct 2013 22:32:51 -0700
Message-ID: <CAJ+vNU36neHP77dVnqSP=+oMxaU=-6PxWQ8Afni-tTRjNTkM_A@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] PCI: imx6: Add support for i.MX6 PCIe controller
From: Tim Harvey <tharvey@gateworks.com>
To: Sean Cross <xobs@kosagi.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Zhu Richard-R65037 <r65037@freescale.com>,
	Shawn Guo <shawn.guo@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex@denx.de>,
	Jingoo Han <jg1.han@samsung.com>,
	Pratyush Anand <pratyush.anand@st.com>,
	Troy Kisky <troy.kisky@boundarydevices.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 16, 2013 at 1:20 AM, Sean Cross <xobs@kosagi.com> wrote:
> Add support for the PCIe port present on the i.MX6 family of controllers.
> These use the Synopsis Designware core tied to their own PHY.
>
> Signed-off-by: Sean Cross <xobs@kosagi.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  .../devicetree/bindings/pci/designware-pcie.txt    |    7 +-
> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
> index ccd55c2..125202e 100644
> --- a/arch/arm/boot/dts/imx6qdl.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> @@ -116,6 +116,22 @@
>                         arm,data-latency = <4 2 3>;
>                 };
>
> +               pcie: pcie@0x01000000 {
> +                       compatible = "fsl,imx6q-pcie", "snps,dw-pcie";
> +                       reg = <0x01ffc000 0x4000>; /* DBI */
> +                       #address-cells = <3>;
> +                       #size-cells = <2>;
> +                       device_type = "pci";
> +                       ranges = <0x00000800 0 0x01f00000 0x01f00000 0 0x00080000 /* configuration space */
> +                                 0x81000000 0 0          0x01f80000 0 0x00010000 /* downstream I/O */
> +                                 0x82000000 0 0x01000000 0x01000000 0 0x00f00000>; /* non-prefetchable memory */
> +                       num-lanes = <1>;
> +                       interrupts = <0 123 0x04>;
> +                       clocks = <&clks 189>, <&clks 187>, <&clks 205>, <&clks 144>;
> +                       clock-names = "pcie_ref_125m", "sata_ref_100m", "lvds_gate", "pcie_axi";
> +                       status = "disabled";
> +               };
> +

Sean,

The devicetree portion above is now here
https://gitorious.org/thierryreding/linux-next/commit/3a57291fa4ca7f7647d826f5b47082ef306d839f
(which I'm told gets pulled into linux-next) and I wanted to see if
you or any of the other IMX/PCI gurus here can answer a question about
region mapping.

The above ranges look to me to allocate 15MB for mem resources, 64K
for io resources, and 256K for cfg space.

Table 2.1 of the IMX6DQRM.pdf
(http://cache.freescale.com/files/32bit/doc/ref_manual/IMX6DQRM.pdf)
shows:
  01FF_C000 01FF_FFFF 16 KB PCIe registers
  0100_0000 01FF_BFFF 16368 KB PCIe

The driver in the fsl 3.0.35_4.1.0 BSP maps the following (see
http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/tree/arch/arm/mach-mx6/pcie.c?h=imx_3.0.35_4.1.0#n331):

0x0100_0000 --- 0x01DF_FFFF 14MB IORESOURCE_MEM
0x01E0_0000 --- 0x01EF_FFFF 1MB IORESOURCE_IO
0x01F0_0000 --- 0x01FF_FFFF 1MB Cfg + MSI + Registers

and, in a discussion on the IMX Community forum
(https://community.freescale.com/message/334959#334959) points out
that you have more flexibility if you map the MEM resource first
because of its more limited alignment.  So, if you were going to stick
with the fsl mapping I would think we would want something like this
in the dt node:

ranges = <0x00000800 0 0x01f00000 0x01f00000 0 0x00080000 /* 512K
configuration space */
               0x81000000 0 0          0x01e00000 0 0x00100000 /* 1MB
downstream I/O */
               0x82000000 0 0x01000000 0x01000000 0 0x00e00000>; /*
14MB non-prefetchable memory */

Can these regions be moved around however you want depending on what
kind of mem vs io resource configurations you desire?  How about the
cfg space - is 512K really needed?

Are we sure the committed values to linux-next 'wrong' in any way?  I
still am seeing bus-hangs with devices behind a bridge that use
io-space resources and am trying to figure out where the issue is.  I
don't get these bus-hangs when using the fsl driver which is
structured very different so its been difficult for me to determine
the difference.  The mappings and the way iATU mappings are done are
very different.

Thanks,

Tim
