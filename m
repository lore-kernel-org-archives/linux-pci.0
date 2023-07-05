Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292F2EB64DD
	for <linux-pci@archiver.kernel.org>; Wed,  5 Jul 2023 08:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbjGEI0I (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 5 Jul 2023 04:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbjGEI0H (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Jul 2023 04:26:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8FA1A2;
        Wed,  5 Jul 2023 01:26:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A0136148F;
        Wed,  5 Jul 2023 08:26:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03F4EC433C8;
        Wed,  5 Jul 2023 08:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688545562;
        bh=tnfwjRMNeY+xXNQJk4GOEiAkLnVkej3s88TiU3bpGJI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qQMNW6qQrijO8TlFMenDOUD58UaStiBga7SYuwgTgDDIEDYLYYQTJYP5JWtvWl+ts
         /PaxWoBrzbqx5Vpm3UgSazGtUJbMxQnqDdNWVLYrh0F1m6TaUmgIHXk2tU6Wgxp7LP
         AloORPn3Afq6N6JfS8ueNcmppnAS87z/p5Oc5OZTpYz1HGilnulqit7ZyEbwA9JkPL
         aHTaQmOP/i8nQiG6xuItzfgMR7NI84k/830UC6flj8jvgBothNtgDG+qecOOOnPsrp
         y5guk+cSyWsCmNKQlk4CwVsXZbEawh8xRDK+QapYXZ7XoME+6yWHT5ppmzZbYZdaw5
         GSMwOy09YehcA==
Date:   Wed, 5 Jul 2023 13:55:45 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Mrinmay Sarkar <quic_msarkar@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        konrad.dybcio@linaro.org, quic_shazhuss@quicinc.com,
        quic_nitegupt@quicinc.com, quic_ramkri@quicinc.com,
        quic_nayiluri@quicinc.com,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH v1 1/6] dt-bindings: PCI: qcom: Add sa8775p compatible
Message-ID: <20230705082545.GA11854@thinkpad>
References: <1688545032-17748-1-git-send-email-quic_msarkar@quicinc.com>
 <1688545032-17748-2-git-send-email-quic_msarkar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1688545032-17748-2-git-send-email-quic_msarkar@quicinc.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 05, 2023 at 01:47:06PM +0530, Mrinmay Sarkar wrote:
> Add sa8775p platform to the binding.
> 
> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
> ---
>  .../devicetree/bindings/pci/qcom,pcie.yaml    | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> index 81971be4e554..2c79585a2d1e 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -40,6 +40,7 @@ properties:
>            - qcom,pcie-sm8450-pcie0
>            - qcom,pcie-sm8450-pcie1
>            - qcom,pcie-sm8550
> +          - qcom,pcie-sa8775p

Sort the compatible alphabetically here and below.

- Mani

>        - items:
>            - const: qcom,pcie-msm8998
>            - const: qcom,pcie-msm8996
> @@ -220,6 +221,7 @@ allOf:
>                - qcom,pcie-sm8450-pcie0
>                - qcom,pcie-sm8450-pcie1
>                - qcom,pcie-sm8550
> +              - qcom,pcie-sa8775p
>      then:
>        properties:
>          reg:
> @@ -743,6 +745,30 @@ allOf:
>            items:
>              - const: pci # PCIe core reset
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +                - qcom,pcie-sa8775p
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 5
> +          maxItems: 5
> +        clock-names:
> +          items:
> +            - const: aux # Auxiliary clock
> +            - const: cfg # Configuration clock
> +            - const: bus_master # Master AXI clock
> +            - const: bus_slave # Slave AXI clock
> +            - const: slave_q2a # Slave Q2A clock
> +        resets:
> +          maxItems: 1
> +        reset-names:
> +          items:
> +            - const: pci # PCIe core reset
> +
>    - if:
>        properties:
>          compatible:
> @@ -750,6 +776,7 @@ allOf:
>              enum:
>                - qcom,pcie-sa8540p
>                - qcom,pcie-sc8280xp
> +              - qcom,pcie-sa8775p
>      then:
>        required:
>          - interconnects
> @@ -854,6 +881,7 @@ allOf:
>                - qcom,pcie-ipq8074-gen3
>                - qcom,pcie-qcs404
>                - qcom,pcie-sa8540p
> +              - qcom,pcie-sa8775p
>      then:
>        properties:
>          interrupts:
> -- 
> 2.39.2
> 

-- 
மணிவண்ணன் சதாசிவம்
