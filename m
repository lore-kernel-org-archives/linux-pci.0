Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1444118168-13086-3-git-send-email-gabriel.fernandez@linaro.org>
References: <1444118168-13086-1-git-send-email-gabriel.fernandez@linaro.org> <1444118168-13086-3-git-send-email-gabriel.fernandez@linaro.org>
From: Rob Herring <robh@kernel.org>
Date: Tue, 6 Oct 2015 09:45:18 -0500
Message-ID: <CAL_JsqKRby4ZWb6iU7d+yN5Cj0qM+m+sQPsFVM0SgAHGK===uA@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] PCI: st: Add Device Tree bindings for sti pcie
To: Gabriel Fernandez <gabriel.fernandez@linaro.org>
Cc: Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Srinivas Kandagatla <srinivas.kandagatla@gmail.com>,
	Maxime Coquelin <maxime.coquelin@st.com>,
	Patrice Chotard <patrice.chotard@st.com>,
	Russell King <linux@arm.linux.org.uk>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Fabrice Gasnier <fabrice.gasnier@st.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Greg KH <gregkh@linuxfoundation.org>,
	Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
	Joe Perches <joe@perches.com>, Tejun Heo <tj@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Thierry Reding <treding@nvidia.com>,
	Phil Edworthy <phil.edworthy@renesas.com>,
	Minghuan Lian <Minghuan.Lian@freescale.com>,
	Tanmay Inamdar <tinamdar@apm.com>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Sachin Kamat <sachin.kamat@samsung.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Zhou Wang <wangzhou1@hisilicon.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, kernel@stlinux.com,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 6, 2015 at 2:56 AM, Gabriel Fernandez
<gabriel.fernandez@linaro.org> wrote:
> sti pcie is built around a Synopsis Designware PCIe IP.
>
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>

Acked-by: Rob Herring <robh@kernel.org>

> ---
>  Documentation/devicetree/bindings/pci/st-pcie.txt | 56 +++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/st-pcie.txt
>
> diff --git a/Documentation/devicetree/bindings/pci/st-pcie.txt b/Documentation/devicetree/bindings/pci/st-pcie.txt
> new file mode 100644
> index 0000000..32e76d0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/st-pcie.txt
> @@ -0,0 +1,56 @@
> +STMicroelectronics STi PCIe controller
> +
> +This PCIe host controller is based on the Synopsis Designware PCIe IP
> +and thus inherits all the common properties defined in designware-pcie.txt.
> +
> +Required properties:
> + - compatible: Should be "st,pcie", "snps,dw-pcie"
> +
> + - reg: base address and length of the pcie controller, mem-window address
> +   and length available to the controller.
> +
> + - interrupts: one GIC interrupt line connected to PCI MSI interrupt line
> +
> + - st,syscfg : should be a phandle of the syscfg node. Also contains syscfg
> +   offset for IP configuration.
> +
> + - resets: phandle to the powerdown and reset controller for the PCIe IP.
> +   See ../reset/reset.txt for details.
> + - reset-names: should be "powerdown" and "softreset".
> +
> + - phys: the phandle for the PHY device (used by generic PHY framework).
> + - phys-names: must be "pcie".
> +
> +Optional properties:
> + - reset-gpio: a GPIO spec to define which pin is connected to the bus reset.
> +
> +Example:
> +
> +pcie0: pcie@9b00000 {
> +       compatible = "st,pcie", "snps,dw-pcie";
> +       device_type = "pci";
> +       reg = <0x09b00000 0x4000>,      /* dbi cntrl registers */
> +             <0x2fff0000 0x00010000>,  /* configuration space */
> +             <0x40000000 0x80000000>;  /* lmi mem window */
> +       reg-names = "dbi", "config", "mem-window";
> +       st,syscfg = <&syscfg_core 0xd8 0xe0>;
> +       #address-cells = <3>;
> +       #size-cells = <2>;
> +       ranges = <0x82000000 0 0x20000000 0x20000000 0 0x0FFF0000>; /* non-prefetchable memory */
> +       num-lanes = <1>;
> +       interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
> +       interrupt-names = "msi";
> +       #interrupt-cells = <1>;
> +       interrupt-map-mask = <0 0 0 7>;
> +       interrupt-map = <0 0 0 1 &intc GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>, /* INT A */
> +                       <0 0 0 2 &intc GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>, /* INT B */
> +                       <0 0 0 3 &intc GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>, /* INT C */
> +                       <0 0 0 4 &intc GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>; /* INT D */
> +
> +       resets = <&powerdown STIH407_PCIE0_POWERDOWN>,
> +                <&softreset STIH407_PCIE0_SOFTRESET>;
> +       reset-names = "powerdown",
> +                     "softreset";
> +       phys = <&phy_port0 PHY_TYPE_PCIE>;
> +       phy-names = "pcie";
> +};
> --
> 1.9.1
>
