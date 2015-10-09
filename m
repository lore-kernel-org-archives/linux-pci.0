Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1444398323-17354-4-git-send-email-Liviu.Dudau@arm.com>
References: <1444398323-17354-1-git-send-email-Liviu.Dudau@arm.com> <1444398323-17354-4-git-send-email-Liviu.Dudau@arm.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 9 Oct 2015 08:54:33 -0500
Message-ID: <CAL_JsqJsb53VXiUfjGBXK37dBEi1r-PXVohg-c-7_x63R04VMA@mail.gmail.com>
Subject: Re: [PATCH 3/4] arm64: Juno: Add support for the PCIe host bridge on
 Juno R1
To: Liviu Dudau <Liviu.Dudau@arm.com>
Cc: Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Arnd Bergmann <arnd@arndb.de>, Jon Medhurst <tixy@linaro.org>,
	linux-pci <linux-pci@vger.kernel.org>,
	device-tree <devicetree@vger.kernel.org>,
	LAKML <linux-arm-kernel@lists.infradead.org>,
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 9, 2015 at 8:45 AM, Liviu Dudau <Liviu.Dudau@arm.com> wrote:
> Juno R1 board sports a functional PCIe host bridge that is
> compliant with the SBSA standard found here[1]. With the right
> firmware that initialises the XpressRICH3 controller one can
> use the generic Host Bridge driver to use the PCIe hardware.
>
> Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
>
> [1] http://infocenter.arm.com/help/topic/com.arm.doc.den0029a/
> ---
>  arch/arm64/boot/dts/arm/juno-r1.dts | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/arm/juno-r1.dts b/arch/arm64/boot/dts/arm/juno-r1.dts
> index c627511..a702a6b 100644
> --- a/arch/arm64/boot/dts/arm/juno-r1.dts
> +++ b/arch/arm64/boot/dts/arm/juno-r1.dts
> @@ -109,6 +109,26 @@
>
>         #include "juno-base.dtsi"
>
> +       pcie-controller@40000000 {
> +               compatible = "pci-host-ecam-generic";

I think this is the first case of real h/w using this. We should have
a specific compatible here additionally. Perhaps the firmware did not
setup something correctly.

> +               device_type = "pci";
> +               reg = <0 0x40000000 0 0x10000000>;      /* ECAM config space */
> +               bus-range = <0 255>;
> +               linux,pci-domain = <0>;
> +               #address-cells = <3>;
> +               #size-cells = <2>;
> +               dma-coherent;
> +               ranges = <0x01000000 0x00 0x5f800000 0x00 0x5f800000 0x0 0x00800000
> +                         0x02000000 0x00 0x50000000 0x00 0x50000000 0x0 0x08000000
> +                         0x42000000 0x40 0x00000000 0x40 0x00000000 0x1 0x00000000>;
> +               #interrupt-cells = <1>;
> +               interrupt-map-mask = <0 0 0 7>;
> +               interrupt-map = <0 0 0 1 &gic 0 0 0 136 4
> +                                0 0 0 2 &gic 0 0 0 137 4
> +                                0 0 0 3 &gic 0 0 0 138 4
> +                                0 0 0 4 &gic 0 0 0 139 4>;
> +               msi-parent = <&v2m_0>;
> +       };
>  };
>
>  &memtimer {
> --
> 2.6.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
