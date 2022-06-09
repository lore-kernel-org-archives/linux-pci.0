Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C266CC43334
	for <linux-pci@archiver.kernel.org>; Thu,  9 Jun 2022 21:10:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236582AbiFIVKj (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 9 Jun 2022 17:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiFIVKj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Jun 2022 17:10:39 -0400
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE71F551D;
        Thu,  9 Jun 2022 14:10:38 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id e80so1973843iof.3;
        Thu, 09 Jun 2022 14:10:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Nez22ajx5qqa59qA0FZvetZN/llMkTNvMAMBf06vCn4=;
        b=TMVN4OXOXO0JpeVHDbAqSqgMCP561JqgOQfrP+xbF89uK8PHukSe28MZE6wTb0Zi8f
         FQsvGaO6nPo1NWXTlPAiUsuOGM8MaFDAby768KCpkUWY+Az9hzpF8nBp6MU/9BY3aF1t
         9662x/fRwvW7j9D1ZTCnn/DbUNcABMSv7IFkQIfcua7i3wtLxQvyARAUggZRf+inDcRu
         Wf8k11aldy+bEEjW99JstPI3StCPFncUqRYnHOGnAFBJC13NO6lL5BBXpYjL1DCnfd3G
         v2A9WfdE7J2YBPb5NWq0y+d0l5XKcN0h6z+kJHEa+clBvikChLVyCrJeOMuRVSEEl+Yv
         cb6w==
X-Gm-Message-State: AOAM531k4na0MXGLRexUm5e/DEyKraWyVWwemtlOaE+wgB3jydLflBVD
        wrwbj9EmP5pjENZyDidatzypiEhf2w==
X-Google-Smtp-Source: ABdhPJyxRVYSz0vnb8vWJAaNAZG2/ozUMqSoEzZaEx7bzrxfwcRMf2suBqWT61vRteYWWl1I1pH7mQ==
X-Received: by 2002:a02:2346:0:b0:332:130b:732e with SMTP id u67-20020a022346000000b00332130b732emr157915jau.305.1654809037336;
        Thu, 09 Jun 2022 14:10:37 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id j5-20020a02cb05000000b00331743a983asm8585452jap.179.2022.06.09.14.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 14:10:36 -0700 (PDT)
Received: (nullmailer pid 104915 invoked by uid 1000);
        Thu, 09 Jun 2022 21:10:35 -0000
Date:   Thu, 9 Jun 2022 15:10:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, michals@xilinx.com
Subject: Re: [PATCH v4 1/2] dt-bindings: PCI: xilinx-cpm: Add Versal CPM5
 Root Port
Message-ID: <20220609211035.GA102003-robh@kernel.org>
References: <20220608164046.3474-1-bharat.kumar.gogada@xilinx.com>
 <20220608164046.3474-2-bharat.kumar.gogada@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608164046.3474-2-bharat.kumar.gogada@xilinx.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 08, 2022 at 10:10:45PM +0530, Bharat Kumar Gogada wrote:
> Xilinx Versal Premium series has CPM5 block which supports Root Port
> functionality at Gen5 speed.
> 
> Add support for YAML schemas documentation for Versal CPM5 Root Port driver.
> 
> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> ---
>  .../bindings/pci/xilinx-versal-cpm.yaml       | 48 +++++++++++++++++--
>  1 file changed, 44 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> index cca395317a4c..80597f2974e5 100644
> --- a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> +++ b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> @@ -14,17 +14,27 @@ allOf:
>  
>  properties:
>    compatible:
> -    const: xlnx,versal-cpm-host-1.00
> +    contains:

Drop 'contains'.

> +      enum:
> +        - xlnx,versal-cpm-host-1.00
> +        - xlnx,versal-cpm5-host
>  
>    reg:
>      items:
>        - description: CPM system level control and status registers.
>        - description: Configuration space region and bridge registers.
> +      - description: CPM5 control and status registers.
> +    minItems: 2
>  
>    reg-names:
> -    items:
> -      - const: cpm_slcr
> -      - const: cfg
> +    oneOf:

You don't need oneOf.

> +      - items:
> +          - const: cpm_slcr
> +          - const: cfg

> +      - items:
> +          - const: cpm_slcr
> +          - const: cfg
> +          - const: cpm_csr

Just add 'minItems: 2'

>  
>    interrupts:
>      maxItems: 1
> @@ -95,4 +105,34 @@ examples:
>                                 interrupt-controller;
>                         };
>                 };
> +
> +               cpm5_pcie: pcie@fcdd0000 {
> +                       compatible = "xlnx,versal-cpm5-host";
> +                       device_type = "pci";
> +                       #address-cells = <3>;
> +                       #interrupt-cells = <1>;
> +                       #size-cells = <2>;
> +                       interrupts = <0 72 4>;
> +                       interrupt-parent = <&gic>;
> +                       interrupt-map-mask = <0 0 0 7>;
> +                       interrupt-map = <0 0 0 1 &pcie_intc_1 0>,
> +                                       <0 0 0 2 &pcie_intc_1 1>,
> +                                       <0 0 0 3 &pcie_intc_1 2>,
> +                                       <0 0 0 4 &pcie_intc_1 3>;
> +                       bus-range = <0x00 0xff>;
> +                       ranges = <0x02000000 0x0 0xe0000000 0x0 0xe0000000 0x0 0x10000000>,
> +                                <0x43000000 0x80 0x00000000 0x80 0x00000000 0x0 0x80000000>;
> +                       msi-map = <0x0 &its_gic 0x0 0x10000>;
> +                       reg = <0x00 0xfcdd0000 0x00 0x1000>,
> +                             <0x06 0x00000000 0x00 0x1000000>,
> +                             <0x00 0xfce20000 0x00 0x1000000>;
> +                       reg-names = "cpm_slcr", "cfg", "cpm_csr";
> +
> +                       pcie_intc_1: interrupt-controller {
> +                               #address-cells = <0>;
> +                               #interrupt-cells = <1>;
> +                               interrupt-controller;
> +                       };
> +               };
> +
>      };
> -- 
> 2.17.1
> 
> 
