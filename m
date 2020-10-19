Return-Path: <SRS0=4e9O=D2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B97C433E7
	for <linux-pci@archiver.kernel.org>; Mon, 19 Oct 2020 10:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 369DA22268
	for <linux-pci@archiver.kernel.org>; Mon, 19 Oct 2020 10:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603102580;
	bh=xCP5VryhV64XbcvfTqg3fxcp/qXdmFoOOlVrr4EgqEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Z9CyjLLfN49DlENMgo0yVlc6Sn4ICNk3rcODiWqz4aLh1Txto+y0JBSFYHD4SjtWh
	 GWSCgId85LweqUpRY19d6sJh2QfzIQas1PU7fekk7USYY2aqVw6gRKHofEVRQOnw9g
	 7Xty/EzWNTZPT3NV6oU918TqGhAXOpCEACFFMM5E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgJSKQT (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 19 Oct 2020 06:16:19 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52047 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgJSKQT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Oct 2020 06:16:19 -0400
Received: by mail-wm1-f65.google.com with SMTP id d81so9737284wmc.1;
        Mon, 19 Oct 2020 03:16:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+Sou4lxGRAq1dK5QgqtSBQCCefIqYxpTxJ9hIjv7QOE=;
        b=Qb7cYwUKg+AtgIOl9L96GaeyQ3DvQbo77YBzyNxm/LrrURZFmYqfZ+egRQCIFKRgQZ
         MppZ1nv7JGz39mU3/iiCPr1BJPGTnxBcNVTL9tJ5OOnEUBG/IJNJKeSzwvU7Qe4BX5zk
         0HmJjWo+fIzcrScgUymQ1TRKNrrnqqVzNG7XEfP1W0u2UvQocdfpDFlqL78zGFFahH44
         dFod1huFk3pJGGFkfsfF0UrdBD8wLkNeeQBjjdhhy2diRFVAKdfl6GZ2HMFvelFnvuSd
         +skZ1kA5mMCVLRhZ90f8dv4lbdHyP9oeqRLPMsRu13IBWtfCjCdoIgvCWMZlL+QbHRMr
         5TfA==
X-Gm-Message-State: AOAM5331ujb1umo2YlFf9bj2hBj1qj5UCmUFyIJeqXXjscd5P5AWikM1
        NtS5oLYtjlnh+4qa0CZlnqE=
X-Google-Smtp-Source: ABdhPJyOyNXRxavkp9tyFnmBFkKlWbeCdQ1DhdkxfqIRjIvJ54n9vaf2A6nReVgTpP3zNo7beoXhWw==
X-Received: by 2002:a1c:1b8f:: with SMTP id b137mr14211025wmb.61.1603102575285;
        Mon, 19 Oct 2020 03:16:15 -0700 (PDT)
Received: from kozik-lap ([194.230.155.171])
        by smtp.googlemail.com with ESMTPSA id w4sm15199041wmi.10.2020.10.19.03.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 03:16:13 -0700 (PDT)
Date:   Mon, 19 Oct 2020 12:16:11 +0200
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
Subject: Re: [PATCH 4/6] phy: samsung: phy-exynos-pcie: rework driver to
 support Exynos5433 PCIe PHY
Message-ID: <20201019101611.GD51073@kozik-lap>
References: <20201019094715.15343-1-m.szyprowski@samsung.com>
 <CGME20201019094740eucas1p10ea264deb2cd185858d0dfdd9f6ed6fe@eucas1p1.samsung.com>
 <20201019094715.15343-5-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201019094715.15343-5-m.szyprowski@samsung.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 19, 2020 at 11:47:13AM +0200, Marek Szyprowski wrote:
> From: Jaehoon Chung <jh80.chung@samsung.com>
> 
> Exynos5440 SoC support has been dropped since commit 8c83315da1cf ("ARM:
> dts: exynos: Remove Exynos5440"). Rework this driver to support PCIe PHY
> variant found in the Exynos5433 SoCs.
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> [mszyprow: reworked the driver to support only Exynos5433 variant, rebased
> 	   onto current kernel code, rewrote commit message]
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/phy/samsung/phy-exynos-pcie.c | 304 ++++++++++----------------
>  1 file changed, 112 insertions(+), 192 deletions(-)
> 

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
