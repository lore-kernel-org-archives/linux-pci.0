Return-Path: <SRS0=b5K0=D3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56690C388F2
	for <linux-pci@archiver.kernel.org>; Tue, 20 Oct 2020 16:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 031A22224A
	for <linux-pci@archiver.kernel.org>; Tue, 20 Oct 2020 16:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603209783;
	bh=oLsjpAWsvX9lEqIdEw4cReNHKVcbecgMUj8JTFgOKcc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=yFjIhP3Gk/iarMBwwXG1IxF5eUoSWINquEvy6YWof8gRoP/9+b1b3Tyytert1ra63
	 Hwan7uKgJSfYTF19thgocGlRBYWypAaG8n42En3J+wCSca4UXjbaz+Zg44RHJJ8/hD
	 QCxUMriBuMo7hixaXGY3PRtC4YQ9tSSjiCfEzCgw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbgJTQDC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Oct 2020 12:03:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:60756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728110AbgJTQDC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Oct 2020 12:03:02 -0400
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CEC621534;
        Tue, 20 Oct 2020 16:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603209781;
        bh=oLsjpAWsvX9lEqIdEw4cReNHKVcbecgMUj8JTFgOKcc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=j01t9UdNehO5PH/noqaa6zZr6RXF+N+ORGyNUoAvGvyWjh1Cj01uxM2JjPUL1UvL0
         ZU1aJRlTQBGhRHINcfJ5bBKWFnemlCSI9/hb2eA7OnTmVvlyc8kUBOH5njWx+aYxBp
         h7x02L5NszTMPy39zJTutyrrsjBW1McDCFrIXZQQ=
Date:   Tue, 20 Oct 2020 11:02:59 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     trix@redhat.com
Cc:     linus.walleij@linaro.org, lorenzo.pieralisi@arm.com,
        robh@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci: remove unneeded break
Message-ID: <20201020160259.GA370179@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201019190249.7825-1-trix@redhat.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 19, 2020 at 12:02:49PM -0700, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> A break is not needed if it is preceded by a return
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

Applied with Linus' reviewed-by to pci/misc for v5.10, thanks!

> ---
>  drivers/pci/controller/pci-v3-semi.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pci-v3-semi.c b/drivers/pci/controller/pci-v3-semi.c
> index 1f54334f09f7..154a5398633c 100644
> --- a/drivers/pci/controller/pci-v3-semi.c
> +++ b/drivers/pci/controller/pci-v3-semi.c
> @@ -658,7 +658,6 @@ static int v3_get_dma_range_config(struct v3_pci *v3,
>  	default:
>  		dev_err(v3->dev, "illegal dma memory chunk size\n");
>  		return -EINVAL;
> -		break;
>  	}
>  	val |= V3_PCI_MAP_M_REG_EN | V3_PCI_MAP_M_ENABLE;
>  	*pci_map = val;
> -- 
> 2.18.1
> 
