Return-Path: <SRS0=ghk2=DN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A8CC3279D
	for <linux-pci@archiver.kernel.org>; Tue,  6 Oct 2020 21:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8072B208B8
	for <linux-pci@archiver.kernel.org>; Tue,  6 Oct 2020 21:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602020368;
	bh=TYqby1W8bssTiZQapqIoaxRkpXBvnRAqBygY0jhZ/jc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cMtJSgXNJYsz9i5ELJz6kCdCJOgPHmNl54wJBh0b1rWNKAoCJnRGW91UpIvm37ump
	 OAhksHcGoFcpugwkUtowoO0WxB8PcMsp4S+f+TPwAlMVH105IVkw8vIL06ZgP85LO8
	 E0nMyG6IFKUYJ4pLsfj5udumwe78xnpq7/YgV9XI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgJFVjY (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 6 Oct 2020 17:39:24 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44961 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgJFVjY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Oct 2020 17:39:24 -0400
Received: by mail-oi1-f196.google.com with SMTP id x62so146667oix.11;
        Tue, 06 Oct 2020 14:39:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZrSS0+QA6SNr5YkM/sCDvi3ZoWN6MrRR/tWnHfJPYsc=;
        b=eLlPimz70JC19WWiYRWpbjVD1Scp3hDHIMqIbHOWAw4SBYAniaVrXWpEwoFUBbgVhq
         utX8j5i+Uq3t+JmVVkvITbDsw4YX1pLGFBxdY4PQ3qjCK+IantHypu6i/sZiT5oJko9q
         X+5zwfxSB0UtpPFn4gSHyaX4IeYKzXTs/xSbt8X5+xEy/rJdbBqTVTGN+Lp70IB7zaw9
         Ok/TDxiT+TdAlX2QtziujfX9FQyZ5/OvTCMWBwBHy2l8w8NcerZGmNgUGuuGCydFeMkm
         37ptXooq8fruBB20KzF7HWL4o4KmR/d8a0VuMVH0FgrLRm3t5apnWKDckwHLu42AXxWa
         R29Q==
X-Gm-Message-State: AOAM531wxoNsumADE4ipQCEYQpQNpoSHP2OAOAvubiXPLMOh1cRmu0Ab
        2GWA2kjf7DOtm+Z3qj09uA==
X-Google-Smtp-Source: ABdhPJwsnzKRCQYibfSwzKqDk2bS+ldxmbO7twZNaDWJpTLRoyFHNMfakBisAntt56WcG70/DzLvdg==
X-Received: by 2002:aca:b9c4:: with SMTP id j187mr185204oif.48.1602020363483;
        Tue, 06 Oct 2020 14:39:23 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i205sm65333oih.23.2020.10.06.14.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 14:39:22 -0700 (PDT)
Received: (nullmailer pid 2893359 invoked by uid 1000);
        Tue, 06 Oct 2020 21:39:21 -0000
Date:   Tue, 6 Oct 2020 16:39:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     agross@kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, svarbanov@mm-sol.com,
        bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        kishon@ti.com, bhelgaas@google.com, mgautam@codeaurora.org,
        vkoul@kernel.org
Subject: Re: [PATCH v4 1/5] dt-bindings: phy: qcom,qmp: Add SM8250 PCIe PHY
 bindings
Message-ID: <20201006213921.GA2893306@bogus>
References: <20201005093152.13489-1-manivannan.sadhasivam@linaro.org>
 <20201005093152.13489-2-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005093152.13489-2-manivannan.sadhasivam@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 05 Oct 2020 15:01:48 +0530, Manivannan Sadhasivam wrote:
> Add the below three PCIe PHYs found in SM8250 to the QMP binding:
> 
> QMP GEN3x1 PHY - 1 lane
> QMP GEN3x2 PHY - 2 lanes
> QMP Modem PHY - 2 lanes
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
