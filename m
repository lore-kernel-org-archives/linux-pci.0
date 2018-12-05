Return-Path: <SRS0=Hio3=OO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B939BC04EB9
	for <linux-pci@archiver.kernel.org>; Wed,  5 Dec 2018 22:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73C3B20879
	for <linux-pci@archiver.kernel.org>; Wed,  5 Dec 2018 22:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544049527;
	bh=76NQXjthtDI4E1TUXTjyPNd4FRjFhT5b4kLtddjRepA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eN5LH0rbVqdB+cpKkcq2V6kE46QqhqmvXJysZYty4zXPELm5W6OioQ+JvTSZy9Jlt
	 35RkWjU3jGt+HjZUkZ7ixIfA0kY481/yCHupNova4BaNMdaXbsgaRAj8CaGnI3KkqG
	 OQMpPmgJSl2h6S87NUDHZXJXVMSJ7FzOEEag86rg=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73C3B20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbeLEWiq (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 5 Dec 2018 17:38:46 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41490 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727620AbeLEWiq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Dec 2018 17:38:46 -0500
Received: by mail-ot1-f67.google.com with SMTP id u16so20255306otk.8;
        Wed, 05 Dec 2018 14:38:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6DfVtxcb7yKOs0ymB/s1S2dtFE6SR0aOXu/Nu1wH+9Y=;
        b=j2cOI8+pnikJ65eet6ZoBfDNXP8Pam/NV4Z+ZIKCCD4Lkm6XBsOLlY+nhMc5ALvVDp
         gLOXAbbc5XcWqL5pea7xFvEH62y6tGg/7mcHYc5+ihqUUndMdYdVe2w9DSlBgzoCa69i
         qliYTRythw+GUUz81CfynvenP6GetflFwOpbr/QrXrbJLADlM6SaBCHtJveMYjGiDlKu
         CPuAU1S9BRW50ZqSHyAz4yogQBab5JiRhg0XFdXt4RjsEeOtPqrpULycIMmeK7LO0y9B
         lfML9NDVHANkOatqnVQ5aNiDaqaFMg1pMWmnLPW1UPO0u4YoBdCas2W+/OoBPJryG3wo
         80oQ==
X-Gm-Message-State: AA+aEWZj4mLazV90jzcKzPn7GwpY+Rt2Avpq1hgQObzwsrR2hKqPd9Kq
        EfoOT5gYy+FqtRBncBmKbw==
X-Google-Smtp-Source: AFSGD/WDDecIb+q9aolSGSwRUAp+lEo6GEW2NXmnTJsp30evnvfZoqJebttDyPzch1QX8gnqwwz0hw==
X-Received: by 2002:a9d:3662:: with SMTP id w89mr17192742otb.55.1544049524558;
        Wed, 05 Dec 2018 14:38:44 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s66sm22074407oia.55.2018.12.05.14.38.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 14:38:43 -0800 (PST)
Date:   Wed, 5 Dec 2018 16:38:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Z.q. Hou" <zhiqiang.hou@nxp.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "l.subrahmanya@mobiveil.co.in" <l.subrahmanya@mobiveil.co.in>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: Re: [PATCHv2 22/25] dt-bindings: pci: Add NXP Layerscape SoCs PCIe
 Gen4 controller
Message-ID: <20181205223843.GA2125@bogus>
References: <20181120092615.11680-1-Zhiqiang.Hou@nxp.com>
 <20181120092615.11680-23-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120092615.11680-23-Zhiqiang.Hou@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 20, 2018 at 09:27:51AM +0000, Z.q. Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> Add PCIe Gen4 controller DT bindings of NXP Layerscape SoCs.
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> V2:
>  - Change to use the layerscape-pci.txt for PCIe Gen4 controller
>    dt-bindings

Sorry someone suggested this, but it seems there's no point in having 
these in the same file. New IP block, do a new file.

> 
>  .../bindings/pci/layerscape-pci.txt           | 57 +++++++++++++++++++
>  MAINTAINERS                                   |  8 +++
>  2 files changed, 65 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/layerscape-pci.txt b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> index 66df1e81e0b8..3ef8836b6e97 100644
> --- a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> +++ b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> @@ -1,4 +1,6 @@
> +====================================
>  Freescale Layerscape PCIe controller
> +====================================
>  
>  This PCIe host controller is based on the Synopsys DesignWare PCIe IP
>  and thus inherits all the common properties defined in designware-pcie.txt.
> @@ -58,3 +60,58 @@ Example:
>  				<0000 0 0 3 &gic GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>,
>  				<0000 0 0 4 &gic GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>;
>  	};
> +
> +===================================
> +NXP Layerscape PCIe Gen4 controller
> +===================================
> +
> +This PCIe controller is based on the Mobiveil PCIe IP and thus inherits all
> +the common properties defined in mobiveil-pcie.txt.
> +
> +Required properties:
> +- compatible: should contain the platform identifier such as:
> +  "fsl,lx2160a-pcie"
> +- reg: base addresses and lengths of the PCIe controller register blocks.
> +  "config_axi_slave": PCIe controller registers
> +  "csr_axi_slave": Bridge config registers

Wouldn't 'config' and 'csr' be sufficient? And these should be listed 
under reg-names.

> +- interrupts: A list of interrupt outputs of the controller. Must contain an
> +  entry for each entry in the interrupt-names property.
> +- interrupt-names: It could include the following entries:
> +  "intr": The interrupt that is asserted for controller interrupts
> +  "aer": Asserted for aer interrupt when chip support the aer interrupt with
> +	 none MSI/MSI-X/INTx mode,but there is interrupt line for aer.
> +  "pme": Asserted for pme interrupt when chip support the pme interrupt with
> +	 none MSI/MSI-X/INTx mode,but there is interrupt line for pme.
> +- dma-coherent: Indicates that the hardware IP block can ensure the coherency
> +  of the data transferred from/to the IP block. This can avoid the software
> +  cache flush/invalid actions, and improve the performance significantly.
> +- msi-parent : See the generic MSI binding described in
> +  Documentation/devicetree/bindings/interrupt-controller/msi.txt.
> +
> +Example:
> +
> +	pcie@3400000 {
> +		compatible = "fsl,lx2160a-pcie";
> +		reg = <0x00 0x03400000 0x0 0x00100000   /* controller registers */
> +		       0x80 0x00000000 0x0 0x00001000>; /* configuration space */
> +		reg-names = "csr_axi_slave", "config_axi_slave";

The order should match what's defined above.

Also, normally the config space would be the bigger region unless config 
accesses are windowed.

> +		interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>, /* AER interrupt */
> +			     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>, /* PME interrupt */
> +			     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
> +		interrupt-names = "aer", "pme", "intr";
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +		device_type = "pci";
> +		apio-wins = <8>;
> +		ppio-wins = <8>;

If these have specific values on your h/w, please specify above.

> +		dma-coherent;
> +		bus-range = <0x0 0xff>;
> +		msi-parent = <&its>;
> +		ranges = <0x82000000 0x0 0x40000000 0x80 0x40000000 0x0 0x40000000>;
> +		#interrupt-cells = <1>;
> +		interrupt-map-mask = <0 0 0 7>;
> +		interrupt-map = <0000 0 0 1 &gic 0 0 GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
> +				<0000 0 0 2 &gic 0 0 GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
> +				<0000 0 0 3 &gic 0 0 GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
> +				<0000 0 0 4 &gic 0 0 GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
> +	};
