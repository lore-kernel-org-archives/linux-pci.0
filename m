Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A326C433F5
	for <linux-pci@archiver.kernel.org>; Thu, 26 May 2022 18:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244835AbiEZSFo (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 26 May 2022 14:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiEZSFn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 May 2022 14:05:43 -0400
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2297DA889D;
        Thu, 26 May 2022 11:05:42 -0700 (PDT)
Received: by mail-ot1-f42.google.com with SMTP id 30-20020a9d0121000000b0060ae97b9967so1449838otu.7;
        Thu, 26 May 2022 11:05:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LMdeXMnCAzG+eheQSLhFYFBckn/dHBYwUTyFKgdd99c=;
        b=0J7S97BgXHRZS4d7ygjuMP6zDAWExH4JraqZsl7Y00hWeypGU5BRI7qLih8PY4QpxW
         AddKaV1qEA3FA36gZ8joHGUXa9FpcT3I6lZYKtE6yMvDPTIVYR0RIxgDe/JfJPs8Emtt
         UD77nlZSNrp43bYMOjf94+7M+y6jhKA1qfSh0A7QZdToWyP5Gv5IU/RrYt0TCSMh40k7
         OY/yrunuKSzLSqRiuu3PQweCoEzkLOPK9/TfvoBMs104BFPztEpDvf5QG4Q+yOulh8AO
         qQIXFBaUxFGb3cIekDbZ9T+enbybEwog37PfWhZCXcwUm9D8s1siCxC/NHiez5b0WZY8
         RVfA==
X-Gm-Message-State: AOAM5334s6nj8R/Ieq/cAfQy7dpcwiMjMEra3Hczs+VPDSc9ihS2cD5v
        H7TeGniHnNc+1XFl5aOA6UlhaNsi6Q==
X-Google-Smtp-Source: ABdhPJyCfAFriLOav9N3K6ohpGqA+A6oimSl97cPPE+U2a1faihPhk8dealeb2uxsrrU6FcK71KKnQ==
X-Received: by 2002:a9d:6c96:0:b0:60b:2e5b:e82a with SMTP id c22-20020a9d6c96000000b0060b2e5be82amr4240690otr.177.1653588341380;
        Thu, 26 May 2022 11:05:41 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id kw36-20020a056870ac2400b000f2911d1987sm907346oab.39.2022.05.26.11.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 11:05:40 -0700 (PDT)
Received: (nullmailer pid 73374 invoked by uid 1000);
        Thu, 26 May 2022 18:05:39 -0000
Date:   Thu, 26 May 2022 13:05:39 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v12 3/8] PCI: dwc: Convert msi_irq to the array
Message-ID: <20220526180539.GB54904-robh@kernel.org>
References: <20220523181836.2019180-1-dmitry.baryshkov@linaro.org>
 <20220523181836.2019180-4-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523181836.2019180-4-dmitry.baryshkov@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 23, 2022 at 09:18:31PM +0300, Dmitry Baryshkov wrote:
> Qualcomm version of DWC PCIe controller supports more than 32 MSI
> interrupts, but they are routed to separate interrupts in groups of 32
> vectors. To support such configuration, change the msi_irq field into an
> array. Let the DWC core handle all interrupts that were set in this
> array.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/pci/controller/dwc/pci-dra7xx.c       |  2 +-
>  drivers/pci/controller/dwc/pci-exynos.c       |  2 +-
>  .../pci/controller/dwc/pcie-designware-host.c | 30 +++++++++++--------
>  drivers/pci/controller/dwc/pcie-designware.h  |  2 +-
>  drivers/pci/controller/dwc/pcie-keembay.c     |  2 +-
>  drivers/pci/controller/dwc/pcie-spear13xx.c   |  2 +-
>  drivers/pci/controller/dwc/pcie-tegra194.c    |  2 +-
>  7 files changed, 24 insertions(+), 18 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
