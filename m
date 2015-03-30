Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:33576 "EHLO
	mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752437AbbC3M2N convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 30 Mar 2015 08:28:13 -0400
Received: by oifl3 with SMTP id l3so126894037oif.0
        for <linux-pci@vger.kernel.org>; Mon, 30 Mar 2015 05:28:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150317114213.GH27081@e106497-lin.cambridge.arm.com>
References: <1426515635-9466-1-git-send-email-gabriel.fernandez@linaro.org>
	<1426515635-9466-3-git-send-email-gabriel.fernandez@linaro.org>
	<20150317114213.GH27081@e106497-lin.cambridge.arm.com>
Date: Mon, 30 Mar 2015 14:28:12 +0200
Message-ID: <CAG374jCm6CREcqKsXYnXHTNCOuaokNA11Sv6_JSW13Vdeo-tHw@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] PCI: st: Add Device Tree bindings for sti pcie
From: Gabriel Fernandez <gabriel.fernandez@linaro.org>
To: Liviu Dudau <Liviu.Dudau@arm.com>
Cc: Gabriel FERNANDEZ <gabriel.fernandez@st.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <Pawel.Moll@arm.com>,
	Mark Rutland <Mark.Rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Srinivas Kandagatla <srinivas.kandagatla@gmail.com>,
	Maxime Coquelin <maxime.coquelin@st.com>,
	Patrice Chotard <patrice.chotard@st.com>,
	Russell King <linux@arm.linux.org.uk>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mohit Kumar <mohit.kumar@st.com>,
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
	"m-karicheri2@ti.com" <m-karicheri2@ti.com>,
	Sachin Kamat <sachin.kamat@samsung.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"kernel@stlinux.com" <kernel@stlinux.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Lee Jones <lee.jones@linaro.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Liviu,

You're right, i removed configuration space from the ranges.

Thanks for reviewing.

Gabriel

On 17 March 2015 at 12:42, Liviu Dudau <Liviu.Dudau@arm.com> wrote:
> Hi Gabriel,
>
> On Mon, Mar 16, 2015 at 02:20:32PM +0000, Gabriel FERNANDEZ wrote:
>> sti pcie is built around a Synopsis Designware PCIe IP.
>>
>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
>> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
>> ---
>>  Documentation/devicetree/bindings/pci/st-pcie.txt | 54 +++++++++++++++++++++++
>>  1 file changed, 54 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/pci/st-pcie.txt
>>
>> diff --git a/Documentation/devicetree/bindings/pci/st-pcie.txt b/Documentation/devicetree/bindings/pci/st-pcie.txt
>> new file mode 100644
>> index 0000000..94aae2d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pci/st-pcie.txt
>> @@ -0,0 +1,54 @@
>> +STMicroelectronics STi PCIe controller
>> +
>> +This PCIe host controller is based on the Synopsis Designware PCIe IP
>> +and thus inherits all the common properties defined in designware-pcie.txt.
>> +
>> +Required properties:
>> + - compatible: "st,stih407-pcie"
>> + - reg: base address and length of the pcie controller, mem-window address
>> +   and length available to the controller.
>> + - interrupts: A list of interrupt outputs of the controller. Must contain an
>> +   entry for each entry in the interrupt-names property.
>> + - interrupt-names: Should be "msi". STi interrupt that is asserted when an
>> +   MSI is received.
>> + - st,syscfg : should be a phandle of the syscfg node. Also contains syscfg
>> +   offset for IP configuration.
>> + - resets, reset-names: the power-down and soft-reset lines of PCIe IP.
>> +   Associated names must be "powerdown" and "softreset".
>> + - phys, phy-names: the phandle for the PHY device.
>> +   Associated name must be "pcie"
>> +
>> +Optional properties:
>> + - reset-gpio: a GPIO spec to define which pin is connected to the bus reset.
>> +
>> +Example:
>> +
>> +pcie0: pcie@9b00000 {
>> +     compatible = "st,stih407-pcie", "snps,dw-pcie";
>> +     device_type = "pci";
>> +     reg = <0x09b00000 0x4000>,      /* dbi cntrl registers */
>> +           <0x2fff0000 0x00010000>,  /* configuration space */
>> +           <0x40000000 0x80000000>;  /* lmi mem window */
>> +     reg-names = "dbi", "config", "mem-window";
>> +     st,syscfg = <&syscfg_core 0xd8 0xe0>;
>> +     #address-cells = <3>;
>> +     #size-cells = <2>;
>> +     ranges = <0x00000800 0 0x2fff0000 0x2fff0000 0 0x00010000   /* configuration space */
>
> Unless you are trying to support some legacy code please remove the configuration space from the ranges.
> There is no resource type associated with config space and the generic parser will give you back an
> invalid resource type. The other reason for that is that if you really claim to be ECAM compliant by
> adding the config space here you need way more than 64K of space.
>
> Best regards,
> Liviu
>
>> +               0x82000000 0 0x20000000 0x20000000 0 0x0FFF0000>; /* non-prefetchable memory */
>> +     num-lanes = <1>;
>> +     interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
>> +     interrupt-names = "msi";
>> +     #interrupt-cells = <1>;
>> +     interrupt-map-mask = <0 0 0 7>;
>> +     interrupt-map = <0 0 0 1 &intc GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>, /* INT A */
>> +                     <0 0 0 2 &intc GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>, /* INT B */
>> +                     <0 0 0 3 &intc GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>, /* INT C */
>> +                     <0 0 0 4 &intc GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>; /* INT D */
>> +
>> +     resets = <&powerdown STIH407_PCIE0_POWERDOWN>,
>> +              <&softreset STIH407_PCIE0_SOFTRESET>;
>> +     reset-names = "powerdown",
>> +                   "softreset";
>> +     phys = <&phy_port0 PHY_TYPE_PCIE>;
>> +     phy-names = "pcie";
>> +};
>> --
>> 1.9.1
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
>
> --
> ====================
> | I would like to |
> | fix the world,  |
> | but they're not |
> | giving me the   |
>  \ source code!  /
>   ---------------
>     ¯\_(ツ)_/¯
>
