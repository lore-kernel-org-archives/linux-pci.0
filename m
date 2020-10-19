Return-Path: <SRS0=4e9O=D2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFE0C433E7
	for <linux-pci@archiver.kernel.org>; Mon, 19 Oct 2020 10:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0EF42225A
	for <linux-pci@archiver.kernel.org>; Mon, 19 Oct 2020 10:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603103302;
	bh=CZ50XZARC4pljT1/VfU/YiZKMP2cTHsXT6MJHCyUma0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kNaQMAs2nFtOtc4tn1IEcTGtLhdpnBaNOloSdeH/mAw2g1i5dEM+RGX0t8uSW88HE
	 Zk8F7YxWMaXlJSiX0KGDlAVm3hR6m2tAQSwIByVf40C5avuXRmNy8UOToiW2BDYNU7
	 qg1Mqz2VGT8T2YC02k92ulZhLyBhgixmuWXsB67o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbgJSK2S (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 19 Oct 2020 06:28:18 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35815 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbgJSK2S (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Oct 2020 06:28:18 -0400
Received: by mail-wr1-f65.google.com with SMTP id n15so10801179wrq.2;
        Mon, 19 Oct 2020 03:28:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GJ7xdh1UkuBKCYMFZrDdJc9zpbUSCEKuhyxUCpSPt7Q=;
        b=giWELrGUFeWzRnzO3tm7gK2/2RZE3PoJp5/9rJd+lXbyo8k+gRlMUWTdF8DsjVLlgu
         zuQrEtdLLY37xVwn8fGuHzHe10wEgsLc2Bl5dkOgPsEHxSmC9ubB3QYPg7k0Wm9uTKUv
         PGu6eZJjohryJ499/idjmidmySpjeYWYXUPSXbl50kH8k02a78EfQY/cBHSWpxyLoUMz
         TdFDSSMRNQAXK0mIUHbkVB4L4MHoPtIzkhyfFc9xx7gfS4X9+6pNhcxPzET3lRA7q4wV
         0tLWd/ywnVuiJbVnB/C0dqFcceZte6N9Jpj3zEb8IUTISmDbNkPQ08MERcn25usJjb31
         7ITA==
X-Gm-Message-State: AOAM533brIZXzqYTPu5uthR3FULM8dr44WR1sO7D9xm4txhlhgCfFoqd
        ekR/x4Hlpia7WfePY2j97/o=
X-Google-Smtp-Source: ABdhPJzt5yjQuHzvbu6ndtufe9IMR8CSsSKhDrNcWHcoL7b5kYYisTl9DVdQvbG2rV21EqZc2L5sFQ==
X-Received: by 2002:adf:e6c4:: with SMTP id y4mr19722539wrm.423.1603103295735;
        Mon, 19 Oct 2020 03:28:15 -0700 (PDT)
Received: from kozik-lap ([194.230.155.171])
        by smtp.googlemail.com with ESMTPSA id d20sm18720877wra.38.2020.10.19.03.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 03:28:14 -0700 (PDT)
Date:   Mon, 19 Oct 2020 12:28:12 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-samsung-soc@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 2/6] Documetation: dt-bindings: add the
 samsung,exynos-pcie binding
Message-ID: <20201019102812.GA71871@kozik-lap>
References: <20201019094715.15343-1-m.szyprowski@samsung.com>
 <CGME20201019094739eucas1p18cd4c7e5a0197393d2e7c5c6fcc2777d@eucas1p1.samsung.com>
 <20201019094715.15343-3-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201019094715.15343-3-m.szyprowski@samsung.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 19, 2020 at 11:47:11AM +0200, Marek Szyprowski wrote:
> From: Jaehoon Chung <jh80.chung@samsung.com>
> 
> Add dt-bindings for the Samsung Exynos PCIe controller (Exynos5433
> variant).
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> [mszyprow: updated the binding to latest driver changes, rewrote it in yaml,
> 	   rewrote commit message]
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  .../bindings/pci/samsung,exynos-pcie.yaml     | 106 ++++++++++++++++++
>  1 file changed, 106 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml b/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml
> new file mode 100644
> index 000000000000..48fb569c238c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml
> @@ -0,0 +1,104 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/samsung,exynos-pcie.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Samsung SoC series PCIe Host Controller Device Tree Bindings
> +
> +maintainers:
> +  - Jaehoon Chung <jh80.chung@samsung.com>
> +
> +description: |+
> +  Exynos5433 SoC PCIe host controller is based on the Synopsys DesignWare
> +  PCIe IP and thus inherits all the common properties defined in
> +  designware-pcie.txt.
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-bus.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - samsung,exynos5433-pcie
> +
> +  reg:
> +    items:
> +      - description: External Local Bus interface (ELBI) registers.
> +      - description: Data Bus Interface (DBI) registers.
> +      - description: PCIe configuration space region.
> +
> +  reg-names:
> +    items:
> +      - const: elbi
> +      - const: bdi
> +      - const: config
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: PCIe bridge clock
> +      - description: PCIe bus clock
> +
> +  clock-names:
> +    items:
> +      - const: pcie
> +      - const: pcie_bus
> +
> +  phys:
> +    maxItems: 1
> +
> +  phy-names:
> +    const: pcie-phy
> +
> +  vdd10-supply:
> +    description:
> +      Phandle to a regulator that provides 1.0V power to the PCIe block.
> +
> +  vdd18-supply:
> +    description:
> +      Phandle to a regulator that provides 1.8V power to the PCIe block.
> +
> +required:
> +  - reg
> +  - reg-names
> +  - interrupts
> +  - interrupt-names
> +  - clocks
> +  - clock-names
> +  - phys
> +  - phy-names
> +  - vdd10-supply
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/exynos5433.h>
> +
> +    pcie: pcie@15700000 {
> +        compatible = "samsung,exynos5433-pcie";
> +        reg = <0x156b0000 0x1000>, <0x15700000 0x1000>, <0x0c000000 0x1000>;
> +        reg-names = "elbi", "dbi", "config";

You have a typo here. This does not pass dt_binbind_check.

> +        #address-cells = <3>;
> +        #size-cells = <2>;
> +        #interrupt-cells = <1>;
> +        device_type = "pci";
> +        interrupts = <GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&cmu_fsys CLK_PCIE>, <&cmu_fsys CLK_PCLK_PCIE_PHY>;
> +        clock-names = "pcie", "pcie_bus";
> +        phys = <&pcie_phy>;
> +        phy-names = "pcie-phy";
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&pcie_bus &pcie_wlanen>;
> +        num-lanes = <1>;
> +        bus-range = <0x00 0xff>;
> +        ranges = <0x81000000 0 0	  0x0c001000 0 0x00010000>,
> +                 <0x82000000 0 0x0c011000 0x0c011000 0 0x03feefff>;
> +        vdd10-supply = <&ldo6_reg>;
> +        vdd18-supply = <&ldo7_reg>;
> +        iterrupt-map-mask = <0 0 0 0>;
> +        interrupt-map = <0 0 0 0 &gic GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH>;

This does not pass dt_binbind_check - your own bindings. You require
interrupt-names.

Best regards,
Krzysztof
