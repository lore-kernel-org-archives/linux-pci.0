Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4783C6FA8B
	for <linux-pci@archiver.kernel.org>; Wed, 14 Sep 2022 12:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiINMZW (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 14 Sep 2022 08:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiINMZV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Sep 2022 08:25:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4467C13E9F;
        Wed, 14 Sep 2022 05:25:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B38061CF7;
        Wed, 14 Sep 2022 12:25:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 677B4C433D6;
        Wed, 14 Sep 2022 12:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663158316;
        bh=CySWligcJLvIT83U845d6s8bOxPiRedQwHWpViqgFxY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kd9oYMQBb05sBdBEpgZtgbhZxc3C3AGuOhIl4B4SzmND9tJOkT1q84GE8WqJtu14w
         NHNCYQ6iOSutPkj8Ei8/yNSOI1RQ+e1MpVXnHtCxkOiOep7UhVlos8u8XaqTA/HuE7
         Oc4LfXRdf2fdZCmJCsFwu8R/HD903buIvUftH0txoqyyBIgPTvW6lU5a+aCtw9gE9m
         zCmale60iHXCbKwA2G2W5cAKpNldbBS1CRKjFG4Y616nJTRwiA5gOwzuwneoXNAQL1
         RBsNP5CBnfpS854Mv7+de3wPKzZOBE6x8B5r3Iar362GfJuYaVjeITxBvFuqydJ0dG
         EL5FYKSAxr3QA==
Date:   Wed, 14 Sep 2022 17:55:05 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pci: qcom,pcie-ep: correct qcom,perst-regs
Message-ID: <20220914122505.GH16459@workstation>
References: <20220911135547.23106-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220911135547.23106-1-krzysztof.kozlowski@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Sep 11, 2022 at 03:55:47PM +0200, Krzysztof Kozlowski wrote:
> qcom,perst-regs is an phandle array of one item with a phandle and its
> arguments.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani

> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> index 3d23599e5e91..077e002b07d3 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> @@ -60,8 +60,10 @@ properties:
>                   enable registers
>      $ref: "/schemas/types.yaml#/definitions/phandle-array"
>      items:
> -      minItems: 3
> -      maxItems: 3
> +      - items:
> +          - description: Syscon to TCSR system registers
> +          - description: Perst enable offset
> +          - description: Perst separateion enable offset
>  
>    interrupts:
>      items:
> -- 
> 2.34.1
> 
