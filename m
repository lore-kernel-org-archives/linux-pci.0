Return-Path: <SRS0=IOiO=DI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57AA7C4727F
	for <linux-pci@archiver.kernel.org>; Thu,  1 Oct 2020 14:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DD74207FB
	for <linux-pci@archiver.kernel.org>; Thu,  1 Oct 2020 14:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601562982;
	bh=ODrEjGalkWELyKb+hOK2yhcNf2s1TBRoTqKiUfyJfAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=R5ybn/Y2/XDb+07LNGQ1/jcCyxfrtEtDvTBnbGGsc89Q9GPQZZdpJFImcj9L1jA4Y
	 GQhAv+czTgzeU6qtqnEXslyJOHSHT4tn3vpUd3C36L9eqp6RwVQoH7uPvG4rWWRb5B
	 8d10ICDJ3MvAp/0Ak+cqDd2GJJs9Sa/dS2kA3Lpw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732213AbgJAOgV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 1 Oct 2020 10:36:21 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:43234 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbgJAOgV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Oct 2020 10:36:21 -0400
Received: by mail-ot1-f52.google.com with SMTP id n61so5583407ota.10;
        Thu, 01 Oct 2020 07:36:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+OGojTsCgqqLX3sjLykJ84TRTlSsl+ju2zMZnbDe0Q8=;
        b=QRnOM+IxsTTs9H1tY7HDu/OsSYRXxwJLncArHUCxwyJ7hiyJx7ksQHKrPJweIyvHpr
         CpN/n27sT8aaKHDNSXjr5Ywi/3Mxn8hDhX1lp+qjpA9AbLaUWSxaURltin63GJVWNOpj
         p3DC+z83K1Rbw8TGe2KNuRgdpegCg98BaG7+x3ADG7z5pRfCdYwPSmyVWzGAqBn76kgD
         jwcHr3eqVvTwJxf4pbjvNEpd8IU3nthhtBCN5CVhtb3iSYhZI5n2jM8z4mMr/uvmf2NV
         6Jj2iHvKGbuZeFBOb5t6gZ/AVrGWhken1D5JrzR2IiH2XxxkL79cTmq/zZ6AGVADyy6H
         CD+w==
X-Gm-Message-State: AOAM532NSg8sFR8nwZSqCPeMv7r8WhGdAiFoYLaazEYGjeQ5xfpdbODG
        a2ZTVqKWO35GruQwt9C2pg==
X-Google-Smtp-Source: ABdhPJxSR7DmJ5mucTzds9TF9ad3q725ZrZ5jfvvZFpr4UUHPT/2L5I//UDn0pXDn5Jj82hpwdxQ0Q==
X-Received: by 2002:a9d:7084:: with SMTP id l4mr5295944otj.161.1601562980318;
        Thu, 01 Oct 2020 07:36:20 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y7sm1063888oih.51.2020.10.01.07.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 07:36:19 -0700 (PDT)
Received: (nullmailer pid 700173 invoked by uid 1000);
        Thu, 01 Oct 2020 14:36:19 -0000
Date:   Thu, 1 Oct 2020 09:36:19 -0500
From:   Rob Herring <robh@kernel.org>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org,
        Scott Branden <sbranden@broadcom.com>,
        linux-pci@vger.kernel.org, Ray Jui <rjui@broadcom.com>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH -next] PCI: iproc: use module_bcma_driver to simplify the
 code
Message-ID: <20201001143619.GA700120@bogus>
References: <20200918030829.3946025-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918030829.3946025-1-liushixin2@huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 18 Sep 2020 11:08:29 +0800, Liu Shixin wrote:
> module_bcma_driver() makes the code simpler by eliminating
> boilerplate code.
> 
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> ---
>  drivers/pci/controller/pcie-iproc-bcma.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
