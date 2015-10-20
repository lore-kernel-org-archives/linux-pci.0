Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 20 Oct 2015 09:59:19 +0100
From: Liviu Dudau <Liviu.Dudau@arm.com>
To: Alex Shi <lkml.alex@gmail.com>
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
Subject: Re: [PATCH v4 2/3] arm64: Juno: Add support for the PCIe host bridge
 on Juno R1
Message-ID: <20151020085919.GZ3394@e106497-lin.cambridge.arm.com>
References: <1445008929-32267-1-git-send-email-Liviu.Dudau@arm.com>
 <1445008929-32267-3-git-send-email-Liviu.Dudau@arm.com>
 <CAGjg+kGhTPXxYS84DTgwhHwqct2Enz_L1Cxsx+QR+tvyU6JzLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CAGjg+kGhTPXxYS84DTgwhHwqct2Enz_L1Cxsx+QR+tvyU6JzLQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 20, 2015 at 11:33:13AM +0800, Alex Shi wrote:
>    Is there any concern to merge the juno r1 pcie DT part into upstream?

Not that I've heard of. I've asked Catalin and Will if they need a pull request to get
the patch into the arm64 tree but I haven't got an answer yet.

Catalin, Will, are you OK with pulling this patch into arm64 and if so do you want
me to send a different pull request or are you happy to fetch it from the git tree

git://linux-arm.org/linux-ld.git for-upstream/juno-pcie.

Best regards,
Liviu

>    On Fri, Oct 16, 2015 at 11:22 PM, Liviu Dudau <[1]Liviu.Dudau@arm.com> wrote:
> 
>      Juno R1 board sports a functional PCIe host bridge that is
>      compliant with the SBSA standard found [1] here. With the right
>      firmware that initialises the XpressRICH3 controller one can
>      use the generic Host Bridge driver to use the PCIe hardware.
> 
>      Signed-off-by: Liviu Dudau <[2]Liviu.Dudau@arm.com>
>      Acked-by: Mark Rutland <[3]mark.rutland@arm.com>
> 
>      [1] [4]http://infocenter.arm.com/help/topic/com.arm.doc.den0029a/
>      ---
>       arch/arm64/boot/dts/arm/juno-r1.dts | 20 ++++++++++++++++++++
>       1 file changed, 20 insertions(+)
> 
>      diff --git a/arch/arm64/boot/dts/arm/juno-r1.dts b/arch/arm64/boot/dts/arm/juno-r1.dts
>      index c627511..a25964d 100644
>      --- a/arch/arm64/boot/dts/arm/juno-r1.dts
>      +++ b/arch/arm64/boot/dts/arm/juno-r1.dts
>      @@ -109,6 +109,26 @@
> 
>              #include "juno-base.dtsi"
> 
>      +       pcie-controller@40000000 {
>      +               compatible = "arm,juno-r1-pcie", "plda,xpressrich3-axi", "pci-host-ecam-generic";
>      +               device_type = "pci";
>      +               reg = <0 0x40000000 0 0x10000000>;      /* ECAM config space */
>      +               bus-range = <0 255>;
>      +               linux,pci-domain = <0>;
>      +               #address-cells = <3>;
>      +               #size-cells = <2>;
>      +               dma-coherent;
>      +               ranges = <0x01000000 0x00 0x5f800000 0x00 0x5f800000 0x0 0x00800000>,
>      +                        <0x02000000 0x00 0x50000000 0x00 0x50000000 0x0 0x08000000>,
>      +                        <0x42000000 0x40 0x00000000 0x40 0x00000000 0x1 0x00000000>;
>      +               #interrupt-cells = <1>;
>      +               interrupt-map-mask = <0 0 0 7>;
>      +               interrupt-map = <0 0 0 1 &gic 0 0 0 136 4>,
>      +                               <0 0 0 2 &gic 0 0 0 137 4>,
>      +                               <0 0 0 3 &gic 0 0 0 138 4>,
>      +                               <0 0 0 4 &gic 0 0 0 139 4>;
>      +               msi-parent = <&v2m_0>;
>      +       };
>       };
> 
>       &memtimer {
>      --
>      2.6.0
> 
>      --
>      To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>      the body of a message to [5]majordomo@vger.kernel.org
>      More majordomo info at  [6]http://vger.kernel.org/majordomo-info.html
>      Please read the FAQ at  [7]http://www.tux.org/lkml/
> 
>    --
>    Thanks
>        Alex
> 
> References
> 
>    Visible links
>    1. mailto:Liviu.Dudau@arm.com
>    2. mailto:Liviu.Dudau@arm.com
>    3. mailto:mark.rutland@arm.com
>    4. http://infocenter.arm.com/help/topic/com.arm.doc.den0029a/
>    5. mailto:majordomo@vger.kernel.org
>    6. http://vger.kernel.org/majordomo-info.html
>    7. http://www.tux.org/lkml/

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
