Return-Path: <SRS0=UCfD=CY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F937C433E2
	for <linux-pci@archiver.kernel.org>; Tue, 15 Sep 2020 01:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09700214F1
	for <linux-pci@archiver.kernel.org>; Tue, 15 Sep 2020 01:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600132593;
	bh=CV4ENCiVd5aHKjkNl3qVnHSBEKCNGvaVzNOaCrkrfzc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Yj31r076NOl29ELjunAqhenaQIKLMeq5Xgv5tO8/L219kpUNoabk/gIHNmwFse8Ld
	 1GStxMD10QAOdJPHrVYIf7Mix/eulQDZgL1vkcdHsGT+3fzIIf8ZoIS0nswHj+va83
	 YDS6OfKWc25F6orP1yErOaPbylRqRGe5FeVL6mqs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbgIOBQc (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 14 Sep 2020 21:16:32 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:38214 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgIOBQa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Sep 2020 21:16:30 -0400
Received: by mail-io1-f66.google.com with SMTP id h4so2270009ioe.5;
        Mon, 14 Sep 2020 18:16:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Kbg1eHGtOQnYQ+M/Y2pvYX5z74YhXGuuRyeYjR/TpSM=;
        b=Qhq+Yonnpg5hgFuxsybXIg/yuZXj6IYvVOauycvhcMvQPWdXIfen6NNjlOdDvGGFyr
         H9XYlzQx7d7DRSBs0t6oSXvYJG/JhGPiwnm4lCMtKlwtcwjQV0xy3AYdNsQiKkcM90tL
         9kDeuYdAGwe4SZchVX14mg5HoffiG2ePJbxZhiBStLl90HRJJmYUHiG5n7138THg9ig3
         GGMD4mWSPsxbir0RaU5ZFKfVX4MYmLUZ97oPAe6tah8wmrKGjlaxJI68GtppRqzBAKgn
         8h1V/iFcQ/y1a2nEQQzwT/6CiwVsWQAM9QtxJFRpzyswL+CNCm5cc75s/e7bMOC7V2En
         FEKw==
X-Gm-Message-State: AOAM5310vIAI60MBh+wFtn65y748LufiopPrhb15e6ITxI7AnBmQk72H
        r2Otfx+YE8/7NMrxbnZ/ep6IOcnw50Ug
X-Google-Smtp-Source: ABdhPJzqNhRuky/yaaH0einwgyUJv5TnN63uuqMrcij/bT0VGW6Pej9sVoCe1aQ3eG7ZLHN59UMLuw==
X-Received: by 2002:a6b:c953:: with SMTP id z80mr13381128iof.178.1600132589539;
        Mon, 14 Sep 2020 18:16:29 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id d23sm6861698ioh.22.2020.09.14.18.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 18:16:28 -0700 (PDT)
Received: (nullmailer pid 645148 invoked by uid 1000);
        Tue, 15 Sep 2020 01:16:25 -0000
Date:   Mon, 14 Sep 2020 19:16:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bhelgaas@google.com,
        shawnguo@kernel.org, leoyang.li@nxp.com, lorenzo.pieralisi@arm.com,
        gustavo.pimentel@synopsys.com, minghuan.Lian@nxp.com,
        mingkai.hu@nxp.com, roy.zang@nxp.com
Subject: Re: [PATCH 1/7] PCI: dwc: Fix a bug of the case dw_pci->ops is NULL
Message-ID: <20200915011625.GA640859@bogus>
References: <20200907053801.22149-1-Zhiqiang.Hou@nxp.com>
 <20200907053801.22149-2-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907053801.22149-2-Zhiqiang.Hou@nxp.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 07, 2020 at 01:37:55PM +0800, Zhiqiang Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> The dw_pci->ops may be a NULL, and fix it by adding one more check.
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>

Note that this may conflict with my 40 patch clean-up series.

Rob
