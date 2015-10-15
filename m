Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1444919145-30845-2-git-send-email-w-kwok2@ti.com>
References: <1444919145-30845-1-git-send-email-w-kwok2@ti.com> <1444919145-30845-2-git-send-email-w-kwok2@ti.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Thu, 15 Oct 2015 11:14:31 -0500
Message-ID: <CAL_JsqL+T7nCtBo9YA=tX1gi=YbvMSswbSj5Fj94uQwB9XStvA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] phy: keystone: serdes driver for gbe 10gbe and pcie
To: WingMan Kwok <w-kwok2@ti.com>
Cc: Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Roger Quadros <rogerq@ti.com>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 15, 2015 at 9:25 AM, WingMan Kwok <w-kwok2@ti.com> wrote:
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
>         - see cover letter for review comments addressed.
>
> Signed-off-by: WingMan Kwok <w-kwok2@ti.com>
> ---
>  Documentation/devicetree/bindings/phy/ti-phy.txt |  278 +++
>  drivers/phy/Kconfig                              |    8 +
>  drivers/phy/Makefile                             |    1 +
>  drivers/phy/phy-keystone-serdes.c                | 2373 ++++++++++++++++++++++
>  4 files changed, 2660 insertions(+)
>  create mode 100644 drivers/phy/phy-keystone-serdes.c
>
> diff --git a/Documentation/devicetree/bindings/phy/ti-phy.txt b/Documentation/devicetree/bindings/phy/ti-phy.txt
> index 9cf9446..4dca271 100644
> --- a/Documentation/devicetree/bindings/phy/ti-phy.txt
> +++ b/Documentation/devicetree/bindings/phy/ti-phy.txt
> @@ -115,4 +115,282 @@ sata_phy: phy@4A096000 {
>         clock-names = "sysclk", "refclk";
>         syscon-pllreset = <&scm_conf 0x3fc>;
>         #phy-cells = <0>;
> +
> +TI Keystone SerDes PHY
> +======================
> +
> +Required properties:
> + - compatible: should be one of
> +       * "ti,keystone-serdes-gbe"
> +       * "ti,keystone-serdes-xgbe"
> +       * "ti,keystone-serdes-pcie"

These are different blocks or different modes of the same block? It's
fine if the former. If the latter, then you should have a single
compatible and then have a mode property. Perhaps phy-connection-type
from ePAPR ethernet binding can be extended.


> + - reg:
> +       * base address and length of the SerDes register set
> + - reg-names:
> +       * "serdes"
> +               - name of the reg SerDes register set

reg-names is kind of pointless with only 1.

> + - #phy-cells:
> +       * From the generic phy bindings, must be 0;
> + - num-lanes:
> +       * Number of lanes in SerDes.
> +
> +Optional properties:
> + - syscon-peripheral:
> +       * Handle to the subsystem register region of the peripheral
> +         inside which the SerDes exists.
> + - syscon-link:
> +       * Handle to the Link register region of the peripheral inside
> +         which the SerDes exists.  Example: it is the PCSR register
> +         region in the case of 10gbe.
> + - rx-force-enable:
> +       * Include this property if receiver attenuation and boost are
> +         to be configured with specific values defined in rx-force.
> + - link-rate-kbps:
> +       * SerDes link rate to be configured, in kbps.
> +
> +
> +For gbe and 10gbe SerDes, it is optional to represent each lane as
> +a sub-node, which can be enabled or disabled individually using
> +the "status" property.
> +
> +Required properties (lane sub-node):
> + - reg:
> +       * lane number
> +
> +Optional properties (lane sub-node):
> + - control-rate:
> +       * Lane control rate
> +               0: full rate
> +               1: half rate
> +               2: quarter rate
> + - rx-start:
> +       * Initial lane rx equalizer attenuation and boost configurations.
> +       * Must be array of 2 integers.
> + - rx-force:
> +       * Forced lane rx equalizer attenuation and boost configurations.
> +       * Must be array of 2 integers.
> + - tx-coeff:
> +       * Lane c1, c2, cm, attenuation and regulator output voltage
> +         configurations.
> +       * Must be array of 5 integers.
> + - loopback:
> +       * Include this property to enable loopback at the SerDes
> +         lane level.

This seems overly complicated. Do you really expect these to be
different per lane?

> +
> +Example for Keystone K2E GBE:
> +-----------------------------
> +
> +gbe_serdes0: gbe_serdes@232a000 {
> +       #phy-cells              = <0>;
> +       compatible              = "ti,keystone-serdes-gbe";
> +       reg                     = <0x0232a000 0x2000>;
> +       reg-names               = "serdes";
> +       link-rate-kbps          = <1250000>;
> +       num-lanes               = <4>;
> +       lanes {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               lane@0 {
> +                       /*loopback;*/
> +                       reg             = <0>;
> +                       control-rate    = <2>; /* quart */
> +                       rx-start        = <7 5>;
> +                       rx-force        = <1 1>;
> +                       tx-coeff        = <0 0 0 12 4>;
> +                              /* c1 c2 cm att vreg */
> +               };
> +               lane@1 {
> +                       /*loopback;*/
> +                       reg             = <1>;
> +                       control-rate    = <2>; /* quart */
> +                       rx-start        = <7 5>;
> +                       rx-force        = <1 1>;
> +                       tx-coeff        = <0 0 0 12 4>;
> +                              /* c1 c2 cm att vreg */
> +               };
> +       };
> +};
> +
> +gbe_serdes1: gbe_serdes@2324000 {
> +       #phy-cells              = <0>;
> +       compatible              = "ti,keystone-serdes-gbe";
> +       reg                     = <0x02324000 0x2000>;
> +       reg-names               = "serdes";
> +       link-rate-kbps          = <1250000>;
> +       num-lanes               = <4>;

4 lanes, but only 2 child nodes?

> +       lanes {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               lane@0 {
> +                       /*loopback;*/
> +                       reg             = <0>;
> +                       control-rate    = <2>; /* quart */
> +                       rx-start        = <7 5>;
> +                       rx-force        = <1 1>;
> +                       tx-coeff        = <0 0 0 12 4>;
> +                              /* c1 c2 cm att vreg */
> +               };
> +               lane@1 {
> +                       /*loopback;*/
> +                       reg             = <1>;
> +                       control-rate    = <2>; /* quart */
> +                       rx-start        = <7 5>;
> +                       rx-force        = <1 1>;
> +                       tx-coeff        = <0 0 0 12 4>;
> +                              /* c1 c2 cm att vreg */
> +               };
> +       };
> +};
> +
> +netcp: netcp@24000000 {
> +       ...
> +
> +       netcp-devices {
> +               ...
> +
> +               gbe@200000 { /* ETHSS */
> +                       ...
> +                       serdeses {
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +                               serdes@0 {
> +                                       reg = <0>;
> +                                       phys = <&gbe_serdes0>;
> +                                       status = "ok";
> +                               };
> +                               serdes@1 {
> +                                       reg = <1>;
> +                                       phys = <&gbe_serdes1>;
> +                                       status = "ok";

This is way too complex. Just do:

phys = <&gbe_serdes0, &gbe_serdes1>;

in the gbe node.

Rob
