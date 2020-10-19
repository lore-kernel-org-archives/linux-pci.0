Return-Path: <SRS0=4e9O=D2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EEA5C43457
	for <linux-pci@archiver.kernel.org>; Mon, 19 Oct 2020 20:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4375422404
	for <linux-pci@archiver.kernel.org>; Mon, 19 Oct 2020 20:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603138077;
	bh=tG8QcI4RnmNRIF0n79miMarBhCTYEjwCdm0dAUNCMEM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IZk0YKnEbHQSRI3JAs+IdYVH44/HtJFrV7xDRpy297L2RmePfUgQEqP9ds2xwkmkN
	 E5viw+feUZAvpbLdHxlgG1x+0R8OmCdwcou/TzhmLAtqam2BrDodLDbyIKGhOxoVJy
	 x5fFhaDzU9wQ1F8VSojgNpfISK8X3IJ4GtbQS7qw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729132AbgJSUHz (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 19 Oct 2020 16:07:55 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35496 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728748AbgJSUHz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Oct 2020 16:07:55 -0400
Received: by mail-oi1-f193.google.com with SMTP id w141so1373836oia.2;
        Mon, 19 Oct 2020 13:07:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=22K4eTas0BJ7J9uGzGzaZteEURxGE4VcHw+8CKvhgqw=;
        b=EolNcHy6xB3q5Iv0oQzOgxRdoWZVo+V1E2UgAmQ6UCUkCrtjrpA7yvyqcpGzItS8+W
         0Raw3R7UdcAASklROPuTg6mpXor+O7dUgd2xy+YivW7mIcAFeq9iFTB92ICU2ElcucjM
         Iu22JwHTrJWxm7IbKA2JdTWn7ttRysptmJalDZM8OEsCofZfjjeZQtSokLE5ipufln65
         EBdvrEnAMwY7mIlZhcKn7q6gCBlwTH80CtUkRFEXPnDGJ63Pmn5/vNa31patCSFRecOG
         4MqH/UhA9yWGPtQDdIOGXiesWeOur/MyGPAhQpOuuqFiDxWTSCdwume/D1Q3gVwJopcl
         D+rQ==
X-Gm-Message-State: AOAM530LgBYgDcSq+Mf8XtFCm6JT7U0cuF9jledK/TJVWp10BU97zBTz
        X8t2NZLTieAXJBupgFQnYQ==
X-Google-Smtp-Source: ABdhPJyqxqRlhym9OJfINJldAu5slGwuzgZv7U9BAMNz8EWFeNoX0yh9zCGJZGpHlqH5aIDUhJLHxw==
X-Received: by 2002:aca:c410:: with SMTP id u16mr786432oif.65.1603138074506;
        Mon, 19 Oct 2020 13:07:54 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s21sm176722otr.77.2020.10.19.13.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 13:07:53 -0700 (PDT)
Received: (nullmailer pid 3521721 invoked by uid 1000);
        Mon, 19 Oct 2020 20:07:52 -0000
Date:   Mon, 19 Oct 2020 15:07:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-samsung-soc@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 1/6] Documetation: dt-bindings: drop
 samsung,exynos5440-pcie binding
Message-ID: <20201019200752.GA3513040@bogus>
References: <20201019094715.15343-1-m.szyprowski@samsung.com>
 <CGME20201019094738eucas1p29b377b561089cfc3eba1755d475125b9@eucas1p2.samsung.com>
 <20201019094715.15343-2-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201019094715.15343-2-m.szyprowski@samsung.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 19, 2020 at 11:47:10AM +0200, Marek Szyprowski wrote:
> Exynos5440 SoC support has been dropped since commit 8c83315da1cf ("ARM:
> dts: exynos: Remove Exynos5440"). Drop the obsolete bindings for
> exynos5440-pcie.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  .../bindings/pci/samsung,exynos5440-pcie.txt  | 58 -------------------
>  1 file changed, 58 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pci/samsung,exynos5440-pcie.txt

Reviewed-by: Rob Herring <robh@kernel.org>
