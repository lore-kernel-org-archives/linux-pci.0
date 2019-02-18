Return-Path: <SRS0=piPB=QZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BAE3C43381
	for <linux-pci@archiver.kernel.org>; Mon, 18 Feb 2019 18:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF96E2184A
	for <linux-pci@archiver.kernel.org>; Mon, 18 Feb 2019 18:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550515367;
	bh=6DeNK8x/5FcZsPRFnBcPCOC4TCbfx3jnLL1DoptyLY8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DQa1ln4w344yZX43KrDhQ2ehRzVCvxdnVskA4lb4DtNm1IAVWOFG2Vf4K9nF6Y/xY
	 SozU6+8a49doQFK8c/WUE2mIvjbnCAiu/3e1Q3kMoyVf2x3UqeU+oAuXUHBZMxk32M
	 rfCiyTKPTc8tsooGSQWJAi8WT/R+esRJQtM9grGs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725379AbfBRSmr (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 18 Feb 2019 13:42:47 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35964 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbfBRSmq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Feb 2019 13:42:46 -0500
Received: by mail-ot1-f67.google.com with SMTP id v62so21108796otb.3;
        Mon, 18 Feb 2019 10:42:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bFVJj06pwZGv8/wiI6kMTyUOygAdLiuywkb8LjrkIxU=;
        b=QMbQ4O9QslIWhhQmr4G28/1idjDYNYXArH/widjS5BzPmnlwiRwuMihMwp8WYW1SGt
         +rEw0hWxdutx+29JgcEEN++4uRsPV6vZs51a20hZ4iXZfkbGjxxw2R5hcEWWvgZsIzKH
         cFLeJVydUTGNTJXzqZf80u5+Pk5rhKuzWr8i/WqK3r3cifWfdaP/ugN36ORdtDS2Q7Ub
         9ScwjjXMnqB6ToAKwk66wD5WLvI5leascSfBLwRZ+szLliK0scrz+jCnM1+rPK9lVgD6
         zsTR8FFIehtDgQSFkGYzkFRuH+3qjXPFYPxQHpWmA72cf/dkVh3fWhJofWjlspp9DkiO
         e1EA==
X-Gm-Message-State: AHQUAuZLC3ORMgnwxFzAhZOx90kBGc4/1DOMYlyKekw2LdtVrwGYTJlC
        swkjfnMkDLrcjVh00C9k1k2KvfE=
X-Google-Smtp-Source: AHgI3IZjScR25VIaZZUdhfTLZsoBnYOVoS+A/MbXIy0HUAtTmOBP3vE4ldMZnnqHEsW0ry8b+U8+hw==
X-Received: by 2002:a9d:61d3:: with SMTP id h19mr9911777otk.370.1550515365431;
        Mon, 18 Feb 2019 10:42:45 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v62sm3298903oie.21.2019.02.18.10.42.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 10:42:44 -0800 (PST)
Date:   Mon, 18 Feb 2019 12:42:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Daire McNamara <daire.mcnamara@microchip.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: PCI: microsemi: Add DT Bindings for
 Microsemi PCIe host controller
Message-ID: <20190218184243.GA20289@bogus>
References: <20190215162424.564-1-daire.mcnamara@microchip.com>
 <20190215162424.564-3-daire.mcnamara@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190215162424.564-3-daire.mcnamara@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 15, 2019 at 04:24:23PM +0000, Daire McNamara wrote:
> This patch adds documentation for the DT bindings for Microsemi/Microchip
> PolarFire PCIe controller when configured in host (Root Complex) mode.
> 
> Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
> ---
>  .../bindings/pci/microsemi-pcie.txt           | 65 +++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/microsemi-pcie.txt
> 
> diff --git a/Documentation/devicetree/bindings/pci/microsemi-pcie.txt b/Documentation/devicetree/bindings/pci/microsemi-pcie.txt
> new file mode 100644
> index 000000000000..a16e48806edc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/microsemi-pcie.txt
> @@ -0,0 +1,65 @@
> +* Microsemi AXI PCIe Root Port Bridge DT description
> +
> +Required properties:
> +- #address-cells: Address representation for root ports, set to <3>
> +- #size-cells: Size representation for root ports, set to <2>
> +- #interrupt-cells: specifies the number of cells needed to encode an
> +	interrupt source. The value must be 1.
> +- compatible: Should contain "microsemi,ms-pf-axi-pcie-host"

Only 1 version?

'ms' is short for Microsemi? Which you already have once.

> +- reg: Should contain AXI PCIe registers location and length

Need to say how many regions, what each one is, and the order.

> +- device_type: must be "pci"
> +- interrupts: Should contain AXI PCIe interrupt
> +- interrupt-map-mask,
> +  interrupt-map: standard PCI properties to define the mapping of the
> +	PCI interface to interrupt numbers.
> +- ranges: ranges for the PCI memory regions (I/O space region is not
> +	supported by hardware)
> +	Please refer to the standard PCI bus binding document for a more
> +	detailed explanation
> +
> +Optional properties for PolarFire:
> +- bus-range: PCI bus numbers covered
> +
> +Interrupt controller child node
> ++++++++++++++++++++++++++++++++
> +Required properties:
> +- interrupt-controller: identifies the node as an interrupt controller
> +- #address-cells: specifies the number of cells needed to encode an
> +	address. The value must be 0.
> +- #interrupt-cells: specifies the number of cells needed to encode an
> +	interrupt source. The value must be 1.
> +
> +NOTE:
> +The core provides a single interrupt for both INTx/MSI messages. So,
> +create an interrupt controller node to support 'interrupt-map' DT
> +functionality.  The driver will create an IRQ domain for this map, decode
> +the four INTx interrupts in ISR and route them to this domain.

If MSI is supported, don't you need some MSI properties?

> +
> +
> +Example:
> +++++++++
> +AloeVera:
> +
> +	pcie: pcie@2030000000 {
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +		#interrupt-cells = <1>;
> +		compatible = "microsemi,ms-pf-axi-pcie-host";
> +		device_type = "pci";
> +		bus-range = <0x01 0x7f>;
> +		interrupt-map = <0 0 0 1 &pcie_intc 1>,
> +				<0 0 0 2 &pcie_intc 2>,
> +				<0 0 0 3 &pcie_intc 3>,
> +				<0 0 0 4 &pcie_intc 4>;
> +		interrupt-map-mask = <0 0 0 7>;
> +		interrupt-parent = <&L4>;
> +		interrupts = <32>;
> +		ranges = <0x3000000 0 0x40000000 0x0 0x40000000 0x0 0x20000000>;
> +		reg = <0x20 0x30000000 0x0 0x4000000 0x20 0x0 0x0 0x100000>;
> +		reg-names = "control", "apb";
> +		pcie_intc: interrupt-controller {
> +			#address-cells = <0>;
> +			#interrupt-cells = <1>;
> +			interrupt-controller;
> +		};
> +	};
> -- 
> 2.17.0
> 
