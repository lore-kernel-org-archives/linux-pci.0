Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 13 Oct 2015 19:33:27 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: WingMan Kwok <w-kwok2@ti.com>
Cc: robh+dt@kernel.org, pawel.moll@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org, kishon@ti.com,
	rogerq@ti.com, m-karicheri2@ti.com, bhelgaas@google.com,
	ssantosh@kernel.org, linux@arm.linux.org.uk,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] phy: keystone: serdes driver for gbe 10gbe and pcie
Message-ID: <20151013183327.GG24353@leverpostej>
References: <1444759464-32299-1-git-send-email-w-kwok2@ti.com>
 <1444759464-32299-2-git-send-email-w-kwok2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1444759464-32299-2-git-send-email-w-kwok2@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 13, 2015 at 02:04:22PM -0400, WingMan Kwok wrote:
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
> Signed-off-by: WingMan Kwok <w-kwok2@ti.com>
> ---
>  Documentation/devicetree/bindings/phy/ti-phy.txt |  256 +++
>  drivers/phy/Kconfig                              |    8 +
>  drivers/phy/Makefile                             |    1 +
>  drivers/phy/phy-keystone-serdes.c                | 2465 ++++++++++++++++++++++
>  4 files changed, 2730 insertions(+)
>  create mode 100644 drivers/phy/phy-keystone-serdes.c
> 
> diff --git a/Documentation/devicetree/bindings/phy/ti-phy.txt b/Documentation/devicetree/bindings/phy/ti-phy.txt
> index 9cf9446..231716e 100644
> --- a/Documentation/devicetree/bindings/phy/ti-phy.txt
> +++ b/Documentation/devicetree/bindings/phy/ti-phy.txt
> @@ -115,4 +115,260 @@ sata_phy: phy@4A096000 {
>  	clock-names = "sysclk", "refclk";
>  	syscon-pllreset = <&scm_conf 0x3fc>;
>  	#phy-cells = <0>;
> +
> +TI Keystone SerDes PHY
> +======================
> +
> +Required properties:
> + - compatible: should be one of
> +	* "ti,keystone-serdes-gbe"
> +	* "ti,keystone-serdes-xgbe"
> +	* "ti,keystone-serdes-pcie"
> + - reg:
> +	* base address and length of the SerDes register set
> + - reg-names:
> +	* "reg_serdes"
> +		- name of the reg SerDes register set

Just describe reg in terms of reg-names, and don't bother with the
"reg_" prefix, we know this is a reg entry:

- reg: a list of address and length pairs, corresponding to entires in
  reg-names

- reg-names: should contain:
  * "serdes"

> + - #phy-cells:
> +	* From the generic phy bindings, must be 0;
> + - max-lanes:
> +	* Number of lanes in SerDes.

Why is this not "num-lanes"? Why do you even need this?

> + - phy-type: should be one of
> +	* "sgmii"
> +	* "xge"
> +	* "pcie"
> +
> +Optional properties:
> + - syscon-peripheral:
> +	* Handle to the subsystem register region of the peripheral
> +	  inside which the SerDes exists.
> + - syscon-link:
> +	* Handle to the Link register region of the peripheral inside
> +	  which the SerDes exists.  Example: it is the PCSR register
> +	  region in the case of 10gbe.
> + - refclk-khz:
> +	* Reference clock rate of SerDes in kHz.

Surely this should be an actual clock?

> + - link-rate-kbps:
> +	* SerDes link rate to be configured, in kbps.

Why does this need to be in the binding? How does one derive the correct
value?

> + - control-rate:
> +	* Lane control rate
> +		0: full rate
> +		1: half rate
> +		2: quarter rate

Likewise on both points.

> + - rx-start:
> +	* Initial lane rx equalizer attenuation and boost configurations.
> +	* Must be array of 2 integers.
> + - rx-force:
> +	* Forced lane rx equalizer attenuation and boost configurations.
> +	* Must be array of 2 integers.
> + - tx-coeff:
> +	* Lane c1, c2, cm, attenuation and regulator outpust voltage
> +	  configurations.
> +	* Must be array of 5 integers.

s/outpust/output/

> + - debug:
> +	* enable more debug messages.

NAK.

This is a driver option, and belongs on the kernel command line. It does
not describe the hardware, and does not belong in the DT.

> +Example for Keystone K2E GBE:
> +-----------------------------
> +
> +gbe_serdes0: gbe_serdes@232a000 {
> +	#phy-cells		= <0>;
> +	compatible		= "ti,keystone-serdes-gbe";
> +	reg			= <0x0232a000 0x2000>;
> +	reg-names		= "reg_serdes";
> +	refclk-khz		= <156250>;
> +	link-rate-kbps		= <1250000>;
> +	phy-type		= "sgmii";
> +	max-lanes		= <4>;
> +	lane0 {
> +		control-rate	= <2>; /* quart */
> +		rx-start	= <7 5>;
> +		rx-force	= <1 1>;
> +		tx-coeff	= <0 0 0 12 4>;
> +		       /* c1 c2 cm att vreg */
> +	};
> +	lane1 {
> +		control-rate	= <2>; /* quart */
> +		rx-start	= <7 5>;
> +		rx-force	= <1 1>;
> +		tx-coeff	= <0 0 0 12 4>;
> +		       /* c1 c2 cm att vreg */
> +	};

The binding didn't describe the sub-nodes, and which properties belong
to them.

Don't use magic names. Define a new address space, and use reg to
identify lanes.

> +	if (of_find_property(np, "disable", NULL))
> +		lc->enable = 0;
> +	else
> +		lc->enable = 1;

This was not described in the binding, and uses the wrong accessor. What
is this for?

> +	if (of_find_property(np, "loopback", NULL))
> +		lc->loopback = 1;
> +	else
> +		lc->loopback = 0;

Likewise.

> +	if (of_property_read_bool(np, "syscon-peripheral")) {
> +		sc->peripheral_regmap =
> +			syscon_regmap_lookup_by_phandle(np,
> +							"syscon-peripheral");

Can't you always call syscon_regmap_lookup_by_phandle, then check the
return value to see if the property existed?

You clearly know that of_property_read_bool exists, why did you not use
it to read properties which are boolean?

> +	if (of_property_read_bool(np, "syscon-link")) {
> +		sc->pcsr_regmap =
> +			syscon_regmap_lookup_by_phandle(np, "syscon-link");

Likewise.

> +	sc->debug = of_property_read_bool(np, "debug");

As stated above, NAK for this property.

> +
> +	if (of_find_property(np, "rx-force-enable", NULL))
> +		sc->rx_force_enable = 1;
> +	else
> +		sc->rx_force_enable = 0;

Not in the binding, and uses the wrong accessor.

> +
> +	for (i = 0; i < sc->lanes; i++) {
> +		sprintf(&name[4], "%d", i);
> +		lp = of_find_node_by_name(np, name);
> +		if (lp) {
> +			if (kserdes_get_lane_bindings(dev, lp, &sc->lane[i]))
> +				return -EINVAL;
> +		}
> +	}

As above, use reg, not magic names.

Thanks,
Mark.
