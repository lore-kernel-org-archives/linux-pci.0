Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B724C433FE
	for <linux-pci@archiver.kernel.org>; Fri, 22 Apr 2022 15:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449531AbiDVPuX (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 22 Apr 2022 11:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449523AbiDVPuW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Apr 2022 11:50:22 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281115DA1B
        for <linux-pci@vger.kernel.org>; Fri, 22 Apr 2022 08:47:28 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-2ec42eae76bso89507807b3.10
        for <linux-pci@vger.kernel.org>; Fri, 22 Apr 2022 08:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ukTM52ERK2PAH2x9W0trRBxUxYmVFkTS8BhnUeQKe+Y=;
        b=DsZ522CU4y+1NYWFKCKhotBkXppypbRBNkP1GKg8JybU7i/wjy1+8Rdd5zp8dPx3y7
         mDESPEHuJvz9bo0luNm+iExatZnaOjJW/I+UuDUHiWnHTG0O8tPf1ya9A5DXw/7jJI9b
         2Jnt8OXgA9jjqN34PcwbtZCbLvngZ+tbiUOgreIdhPanaIse+8m8Jp3zXm50tNqyWy7Y
         wCp/zcfBpBM4iVEOfZDTV2kTv2hhMSgMFMkVjrXSXTnnjaBMXhlKGaeE1D4OKaE2+ETH
         3kcGzprmxo0XDyZLES7uqpAX4g1BLu+ERpDP50w9vQ0LqH9Z7Lhb51DayDpnYl/7/II4
         6wBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ukTM52ERK2PAH2x9W0trRBxUxYmVFkTS8BhnUeQKe+Y=;
        b=fP9xCXnqHnUuyqmHDHnBykNKyz117j25bxaOpaiOErYZLRgWQhVQm9U4F6LsGfQyFu
         lbwsEtZ3UPDfjeuNHMJbVCNYmBc/H9QupUAVpuKDzzz7lRZIk3gL/KspZSbpJwo7jyyA
         dvCXHYrYJnrvlOVZsbd0Ed3qcHPla2iJTOTPEqFMWrrXISC6JUaYfDjf72FWRmcGwKWW
         q66nSCLyL7tUZFTtxbDJneaUuJ2ZuYiV4P4Ch6t+Ml/W7g1DYADmK9FbirR5iTiRstrf
         XXr53DXQyygSdYgREMANlwYthZxhuFThPBQrCYI2EQbElwRQgK/3MarqYd4Vo9kG9Opi
         yqtw==
X-Gm-Message-State: AOAM532u+KcSDxXlnpymVJ34uUZffPpoNUskQ9zqpwIrKvbXJzsnzDiT
        gfUykDX8Ou3OY5d3PXzQU2BKfU6oD502UpgU1h1jJw==
X-Google-Smtp-Source: ABdhPJxCgG9GjIP7oVFKGcnuyzU2sX36ebgw64u4B2HkK1gTlI+6j+IbRHE/2n3VJxjy099NvUbVqO0gEjw0S+0aC6o=
X-Received: by 2002:a81:4c11:0:b0:2d1:1925:cd70 with SMTP id
 z17-20020a814c11000000b002d11925cd70mr5290906ywa.101.1650642447704; Fri, 22
 Apr 2022 08:47:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220422114841.1854138-1-dmitry.baryshkov@linaro.org>
 <20220422114841.1854138-4-dmitry.baryshkov@linaro.org> <fe9c5691-caa1-79b4-666b-daac8913b546@linaro.org>
In-Reply-To: <fe9c5691-caa1-79b4-666b-daac8913b546@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 22 Apr 2022 18:47:16 +0300
Message-ID: <CAA8EJpr=XE-8fo+99+KjTEffS1jmBibQnbN1T4ZcgkhWCDucpg@mail.gmail.com>
Subject: Re: [PATCH 3/6] dt-bindings: pci/qcom-pcie: specify reg-names explicitly
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 22 Apr 2022 at 15:55, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 22/04/2022 13:48, Dmitry Baryshkov wrote:
> > Instead of specifying the enum of possible reg-names, specify them
> > explicitly. This allows us to specify which chipsets need the "atu"
> > regions, which do not. Also it clearly describes which platforms
> > enumerate PCIe cores using the dbi region and which use parf region for
> > that.
> >
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >  .../devicetree/bindings/pci/qcom,pcie.yaml    | 96 ++++++++++++++++---
> >  1 file changed, 81 insertions(+), 15 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > index 7210057d1511..e78e63ea4b25 100644
> > --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > @@ -35,21 +35,6 @@ properties:
> >            - qcom,pcie-ipq6018
> >        - const: snps,dw-pcie
> >
> > -  reg:
> > -    minItems: 4
> > -    maxItems: 5
>
> This should stay.
>
> > -
> > -  reg-names:
> > -    minItems: 4
> > -    maxItems: 5
> > -    items:
> > -      enum:
> > -        - parf # Qualcomm specific registers
> > -        - dbi # DesignWare PCIe registers
> > -        - elbi # External local bus interface registers
> > -        - config # PCIe configuration space
> > -        - atu # ATU address space (optional)
>
> Move one of your lists for specific compatibles here and name last
> element optional (minItems: 4).
>
> You will need to fix the order of regs in DTS to match the one defined here.

I see your idea. I wanted to be explicit, which platforms need atu and
which do not. You'd prefer not to.
Let's probably drop this for now. The bindings proposed in patch 1
work for now. I will work on updating reg-names later.

>
> > -
> >    interrupts:
> >      maxItems: 1
> >
> > @@ -108,6 +93,87 @@ required:
> >
> >  allOf:
> >    - $ref: /schemas/pci/pci-bus.yaml#
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - qcom,pcie-apq8064
> > +              - qcom,pcie-ipq4019
> > +              - qcom,pcie-ipq8064
> > +              - qcom,pcie-ipq8064v2
> > +              - qcom,pcie-ipq8074
> > +              - qcom,pcie-qcs404
> > +    then:
> > +      properties:
> > +        reg:
> > +          minItems: 4
> > +          maxItems: 4
>
> Only maxItems: 4
>
> > +        reg-names:
> > +          items:
> > +            - const: dbi # DesignWare PCIe registers
> > +            - const: elbi # External local bus interface registers
> > +            - const: parf # Qualcomm specific registers
> > +            - const: config # PCIe configuration space
>
> No need for this, instead only maxItems:4
>
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - qcom,pcie-ipq6018
> > +    then:
> > +      properties:
> > +        reg:
> > +          minItems: 5
> > +          maxItems: 5
>
> Only minItems:5 should be needed.
>
> > +        reg-names:
> > +          items:
> > +            - const: dbi # DesignWare PCIe registers
> > +            - const: elbi # External local bus interface registers
> > +            - const: atu # ATU address space (optional)
> > +            - const: parf # Qualcomm specific registers
> > +            - const: config # PCIe configuration space
>
> This can be removed.
>
> All other cases should be merged with the ones here.
>
> Best regards,
> Krzysztof



-- 
With best wishes
Dmitry
