Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795456448;
	b=H8vtdiC4bDoucobGg0Uth6nZ/B0guYNOfXciSE/5RO1Rzvn+hf01+cMxOCbIeE3RglRg
	 Tl+4U5kulDPAKRTrjtTGi24wVaklNOn3+LRpnagLD9sMlSfxcSA5GnprkHqMiRvy3dyEf
	 Iym5AcChGhOgtpSFnVtt61pCJDJoQ3u4cOqBNJ2OHcqEBOa9iERcp3R54ZVWxpkhfvBtZ
	 t871+8RwnDMy/qKi1MQKj1nYKD3rAMxKFZeNz0cPsvrEsyTHx+z7hECj2vqbHWBmx/d4m
	 /qtFjIjxfufA/w7hSpkNDH7LF7kPh+XD0V7hIWMxh3aNRN4wgtG20THjUuiDhqi9qhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795456448;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=QguODtbBfbYIOaHST7nmcCeE5a3zLdp+DRs/3g3p/90=;
	b=cQmTfgr7M055+w8KNAgZ+b5qPwaeSz6XI3wNkxVRK4b6D69ksXh4f3Z3cxABnz72UMNx
	 ebCfzUOzwAAxzYoclWs3jwplRABZgWxTxbXvmL0JQWiWNOMVaA+5z6DEbNC0fqUpJnYFG
	 1YHieJhtmckK1umxewhlBvKIze6IQy9xhDLszETf6NQluRWIfZy+D9gBXb3K6s12gH4HQ
	 65ck3s7om2dHzSUm9uJLztI5uY3DM8cZAy0ucrI74mIUjUsV9NEfmV74abhrPcbcd7d+W
	 oFWzp0AE2fGXMB8eYVH8swZPmEaB3EsLiYplOWs45iVKLrXd/gQ2mX58+/XqX7I9BgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jFC2A8og;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359FB606A32C;
	Mon, 23 Nov 2026 17:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jFC2A8og
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84FCF1F000D4;
	Mon, 23 Nov 2026 17:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795456448;
	bh=QguODtbBfbYIOaHST7nmcCeE5a3zLdp+DRs/3g3p/90=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jFC2A8ogexFHV7NgJFfFecbR3hYuSJTwaIOihvq5yvDdPkodr9/lJSlbnC34+K8zD
	 CPZpXHay9z3Ri0w2J9T4b4fij+IVNOzmQUtQameLGSYsTq8GOox+p+bGoK3vVZ2GGS
	 23Q+1/9Wz4UYP/XLIwlXOaOJcfSZnL2M0Xqy18FE3/4keXj4p5UtYZIw17BGolIZaK
	 d/qHQx3xGlBjPgFf0IyGCuHHtlNv+Hf5tLgh1MfzAUlyvuRruZwqtxTTqaP5KoMzOA
	 Ow+mETWBBH+GoMBp66RDvQP+C5Fu7NRI4njfUQzvvaHqf49rpYqPoH8DWC/NDzjMfc
	 iLhTQMdGt6/8g==
Date: Mon, 23 Nov 2026 11:54:06 -0600
From: Rob Herring <robh@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Abel Vesa <abelvesa@kernel.org>, alchark@flipper.net,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: connector: Add PCIe M.2 Mechanical
 Key B connector
Message-ID: <20261123175406.GB55094-robh@kernel.org>
References: <20261122-pcie6_fix-v2-0-2e0fe615d90b@oss.qualcomm.com>
 <20261122-pcie6_fix-v2-1-2e0fe615d90b@oss.qualcomm.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261122-pcie6_fix-v2-1-2e0fe615d90b@oss.qualcomm.com>

On Sun, Nov 22, 2026 at 12:15:51PM +0530, Krishna Chaitanya Chundru wrote:
> Add the devicetree binding for PCIe M.2 Mechanical Key B connector
> defined in the PCI Express M.2 Specification, r4.2, sec 3.2.19.1. This
> connector is used to attach WWAN Adapters to the host machine over
> interfaces such as PCIe, USB3.1 Gen1, SSIC, or USB 2.0. The slot also
> accepts SATA and PCIe SSD Adapters, which use the same pins.
> 
> Interfaces that share connector pins are described as one graph port
> per pin group, with the endpoint number selecting between the mutually
> exclusive interfaces.
> 
> The connector provides a primary power supply of 3.3V/VBAT, along with
> optional GPIO signals: FULL_CARD_POWER_OFF#, RESET#, W_DISABLE1# and DPR
> for WWAN Adapters, and DEVSLP, PLN# and SMBus ALERT# for SSD Adapters,
> plus an I2C parent for the SSD SMBus.
> 
> The function of the GPIO_0..GPIO_11 pins depends on the Port
> Configuration, so they are described by gpioN-gpios properties with the
> function of each pin per configuration documented in the binding. The
> Adapter configuration is either sensed through config-gpios
> (CONFIG_0..3) or fixed with config-state, which defaults to WWAN PCIe.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  .../bindings/connector/pcie-m2-b-connector.yaml    | 332 +++++++++++++++++++++
>  MAINTAINERS                                        |   1 +
>  2 files changed, 333 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/connector/pcie-m2-b-connector.yaml b/Documentation/devicetree/bindings/connector/pcie-m2-b-connector.yaml
> new file mode 100644
> index 000000000000..4760863ff4f7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/connector/pcie-m2-b-connector.yaml
> @@ -0,0 +1,332 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/connector/pcie-m2-b-connector.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: PCIe M.2 Mechanical Key B Connector
> +
> +maintainers:
> +  - Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> +
> +description:
> +  A PCIe M.2 B connector node represents a physical PCIe M.2 Mechanical Key B
> +  connector. Mechanical Key B connectors are used to connect WWAN devices to
> +  the host machine over interfaces like PCIe, USB3.1 Gen1, SSIC, or USB 2.0,
> +  selected by the Adapter's configuration pins. The slot also accepts SATA and
> +  PCIe SSD Adapters, which use the same pins as the WWAN interfaces.
> +
> +properties:
> +  compatible:
> +    const: pcie-m2-b-connector
> +
> +  vpcie3v3-supply:
> +    description: A phandle to the regulator for the 3.3v/VBAT supply.
> +
> +  full-card-power-off-gpios:
> +    description: GPIO output to FULL_CARD_POWER_OFF# signal. This signal is
> +      used by the host system to turn off the entire Adapter. Refer, PCI
> +      Express M.2 Specification r4.0, sec 3.2.13.1 for more details.
> +    maxItems: 1
> +
> +  reset-gpios:
> +    description: GPIO output to RESET# signal. This signal is used by the
> +      host system to place the WWAN Adapter into a power-on reset condition.
> +      Refer, PCI Express M.2 Specification r4.0, sec 3.2.13.2 for more
> +      details.
> +    maxItems: 1
> +
> +  w-disable1-gpios:
> +    description: GPIO output to W_DISABLE1# signal. This signal is used by
> +      the host system to disable the WWAN radio on the Adapter. Refer, PCI
> +      Express M.2 Specification r4.0, sec 3.1.12.3 for more details.
> +    maxItems: 1
> +
> +  dpr-gpios:
> +    description: GPIO output to the Dynamic Power Reduction (DPR) signal.
> +      This signal is provided by a host system proximity sensor to the
> +      Adapter to trigger a reduction in the radio transmit output power to
> +      meet regulatory SAR requirements. Refer, PCI Express M.2 Specification
> +      r4.0, sec 3.2.13.4 for more details.
> +    maxItems: 1
> +
> +  alert-gpios:
> +    description: GPIO input to the SMBus ALERT# signal (pin 44, shared with
> +      GPIO_2). SSD Adapters assert this signal to indicate to the host that
> +      the SMBus device requires attention. It is not present on WWAN
> +      Adapters. Refer, PCI Express M.2 Specification r4.2, sec 3.2.14.2.1
> +      for more details.
> +    maxItems: 1
> +
> +  i2c-parent:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: Phandle to the host I2C controller connected to the SMBus
> +      pins SMB_CLK and SMB_DATA (pins 40 and 42, shared with GPIO_0 and
> +      GPIO_1). The SMBus is only present on SSD Adapters. Refer, PCI Express
> +      M.2 Specification r4.2, sec 3.2.14.2 for more details.
> +
> +  devslp-gpios:
> +    description: GPIO output to the DEVSLP signal (pin 38). The host asserts
> +      this signal to tell a SATA SSD to enter the Device Sleep power state.
> +      It is only present on SATA SSD Adapters. Refer, PCI Express M.2
> +      Specification r4.2, sec 3.2.10.1 for more details.
> +    maxItems: 1
> +
> +  pln-gpios:
> +    description: GPIO output to the Power Loss Notification (PLN#) signal
> +      (pin 8, shared with W_DISABLE1#). The host asserts this signal to
> +      notify a PCIe SSD that a power loss event is about to occur. WWAN
> +      boards use w-disable1-gpios for this pin instead. Refer, PCI Express
> +      M.2 Specification r4.2, sec 3.2.18.1 for more details.
> +    maxItems: 1
> +
> +  config-gpios:
> +    description: |
> +      GPIO inputs sensing the four CONFIG_0..3 pins (pins 21, 69, 75 and 1
> +      respectively, listed in that order in this property). The Adapter
> +      grounds or leaves unconnected (NC) each of these pins to tell the host
> +      the Adapter type, the host interface in use and, for WWAN Adapters, the
> +      active GPIO_0..11 Port Configuration. Boards that only ever use one
> +      Adapter type should use config-state instead. If both properties are
> +      present, config-gpios takes precedence. Refer, PCI Express M.2
> +      Specification r4.2, sec 3.2.15 and Table 3-18 for more details.
> +
> +      Table 3-18. Socket 2 Add-in Card Configuration:
> +
> +        CONFIG_0 CONFIG_1 CONFIG_2 CONFIG_3  Adapter Type / Host Interface   Port Config
> +        GND      GND      GND      GND       SSD - SATA                       N/A
> +        GND      NC       GND      GND       SSD - PCIe                       N/A
> +        GND      GND      NC       GND       WWAN - PCIe                      0
> +        GND      NC       NC       GND       WWAN - PCIe                      1
> +        GND      GND      GND      NC        WWAN - PCIe, USB3.1 Gen1         0
> +        GND      NC       GND      NC        WWAN - PCIe, USB3.1 Gen1         1
> +        GND      GND      NC       NC        WWAN - PCIe, USB3.1 Gen1         2
> +        GND      NC       NC       NC        WWAN - PCIe, USB3.1 Gen1         3
> +        NC       GND      GND      GND       WWAN - SSIC                      0
> +        NC       NC       GND      GND       WWAN - SSIC                      1
> +        NC       GND      NC       GND       WWAN - SSIC                      2
> +        NC       NC       NC       GND       WWAN - SSIC                      3
> +        NC       GND      GND      NC        WWAN - PCIe                      2
> +        NC       NC       GND      NC        WWAN - PCIe                      3
> +        NC       GND      NC       NC        WWAN - PCIe, USB3.1 Gen1         vendor-defined
> +        NC       NC       NC       NC        No Add-in Card present           N/A
> +    minItems: 4
> +    maxItems: 4
> +
> +  config-state:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Fixed Adapter configuration for boards that do not sense the CONFIG_0..3
> +      pins, given as the state number (0-14) of Table 3-18 of the PCI Express
> +      M.2 Specification r4.2. It selects the Adapter type, the host interface
> +      and, for WWAN Adapters, the Port Configuration used to interpret the
> +      gpioN-gpios properties. Ignored if config-gpios is present. If neither
> +      property is present, state 2 (WWAN - PCIe, Port Config_0) is assumed.
> +    minimum: 0
> +    maximum: 14
> +    default: 2
> +
> +  clocks:
> +    description: 32.768 KHz Suspend Clock (SUSCLK) input from the host system to
> +      the M.2 card. Refer, PCI Express M.2 Specification r4.0, sec 3.1.12.1 for
> +      more details.
> +    maxItems: 1
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +    description: OF graph bindings modeling the interfaces exposed on the
> +      connector. Several interfaces share the same connector pins and are
> +      selected by the CONFIG_0..3 pins, so each port describes one group of
> +      pins and its endpoints describe the mutually exclusive interfaces that
> +      can be present on that group.
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: |
> +          Pins 41, 43, 47 and 49. The endpoint number selects the interface:
> +            0 - PCIe lane 0
> +            1 - SATA
> +        patternProperties:
> +          '^endpoint(@[0-9a-f]+)?$':
> +            type: object
> +            properties:
> +              reg:
> +                enum: [0, 1]
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: |
> +          Pins 29, 31, 35 and 37. The endpoint number selects the interface:
> +            0 - USB3.1 Gen1
> +            1 - SSIC
> +            2 - PCIe lane 1
> +        patternProperties:
> +          '^endpoint(@[0-9a-f]+)?$':
> +            type: object
> +            properties:
> +              reg:
> +                enum: [0, 1, 2]
> +
> +      port@2:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: USB 2.0 interface (pins 7 and 9)
> +
> +    anyOf:
> +      - required:
> +          - port@0
> +      - required:
> +          - port@1
> +
> +patternProperties:
> +  '^gpio([0-9]|1[01])-gpios$':
> +    description: |
> +      GPIO connected to the GPIO_<N> pin of the connector, where N is the
> +      number in the property name. The function of these pins depends on the
> +      Port Configuration selected by config-gpios or config-state (Table 3-15
> +      of the PCI Express M.2 Specification r4.2, sec 3.2.13.3):
> +
> +        GPIO  Pin  Config_0     Config_1     Config_2     Config_3
> +        0     40   GNSS_SCL     GNSS_SCL     SIM_DETECT2  IPC_0
> +        1     42   GNSS_SDA     GNSS_SDA     UIM_DATA2    IPC_1
> +        2     44   GNSS_IRQ     GNSS_IRQ     UIM_CLK2     IPC_2
> +        3     46   SYSCLK       GNSS_0       UIM_RESET2   IPC_3
> +        4     48   TX_BLANKING  GNSS_1       UIM_PWR2     IPC_4
> +        5     20   AUDIO_0      AUDIO_0      RFU          AUDIO_0
> +        6     22   AUDIO_1      AUDIO_1      RFU          AUDIO_1
> +        7     24   AUDIO_2      AUDIO_2      RFU          IPC_5/AUDIO_2
> +        8     28   AUDIO_3      AUDIO_3      PLA_S2#      IPC_6/AUDIO_3
> +        9     10   LED_1#       LED_1#       LED_1#       DAS/DSS/IPC_7
> +        10    26   W_DISABLE2#  W_DISABLE2#  W_DISABLE2#  HSIC_STROBE
> +        11    23   WoWWAN#      WoWWAN#      WoWWAN#      HSIC_DATA
> +
> +      The IPC_0..7 functions of Port Config_3 are vendor defined, as are all
> +      functions in CONFIG state 14.
> +
> +      On SSD Adapters (CONFIG states 0 and 1) the same pins are SMB_CLK
> +      (GPIO_0), SMB_DATA (GPIO_1), ALERT# (GPIO_2), PLA_S2# (GPIO_8), and
> +      LED_1# or, on SATA, DAS/DSS (GPIO_9).
> +
> +      Only list the pins that are wired to a host GPIO. Pins used as a bus
> +      signal in the selected Port Configuration (I2C, I2S/SLIMbus, HSIC) are
> +      not GPIOs and are not described by these properties.
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - vpcie3v3-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  # PCI M.2 Key B connector for WWAN with PCIe interface
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    connector {
> +        compatible = "pcie-m2-b-connector";
> +        vpcie3v3-supply = <&vreg_wwan>;
> +        full-card-power-off-gpios = <&tlmm 121 GPIO_ACTIVE_LOW>;
> +        w-disable1-gpios = <&tlmm 122 GPIO_ACTIVE_LOW>;
> +        gpio10-gpios = <&tlmm 123 GPIO_ACTIVE_LOW>;
> +        gpio11-gpios = <&tlmm 128 GPIO_ACTIVE_LOW>;
> +        /* A zero phandle marks a CONFIG pin that is not wired to a host GPIO */

How would that work exactly?

In any case, that is not supported in examples as the report gave.

> +        config-gpios = <&tlmm 124 GPIO_ACTIVE_HIGH>,
> +                       <&tlmm 125 GPIO_ACTIVE_HIGH>,
> +                       <0>,
> +                       <&tlmm 127 GPIO_ACTIVE_HIGH>;
