Return-Path: <SRS0=TBtX=6P=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64658C4724C
	for <linux-pci@archiver.kernel.org>; Fri,  1 May 2020 17:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4472924953
	for <linux-pci@archiver.kernel.org>; Fri,  1 May 2020 17:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588354211;
	bh=VAvajmE7+I8hb9c+/89VRkTtTxfrHcVSwWdqiUGJonU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=OUlIPtImS0nsK/Gmxa0542a63hQw2EzZQ1dY8H+znus2ZIoHfX1amN8D1L88lXAg8
	 1S4bAMn4GtAGXiCyIChGWFYwS5ZLMngengFKBplILuhMkYO8FXm2TC7jcFpXaPPdNy
	 YxN3b7pvQ40p2s30jKbyqkiF0j2H5pEBXlg/OU1Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729372AbgEARaK (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 1 May 2020 13:30:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:57574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728933AbgEARaK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 May 2020 13:30:10 -0400
Received: from localhost (mobile-166-175-184-168.mycingular.net [166.175.184.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71DE4208D6;
        Fri,  1 May 2020 17:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588354209;
        bh=VAvajmE7+I8hb9c+/89VRkTtTxfrHcVSwWdqiUGJonU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=qC1WjjWYbOxnynz2nVNvSlfFOJYxsyYwB5Z9WkPQ+54FRes/owmjqGxdTAYdFkLmm
         xo8EywIMalxpSslREjZByCYxfxer6meYf4QiTQgKUHu78Es/HZ2xrS3YCwX0VZrpLb
         9Pr03YowoTAb/byrLnfgr8DyyKulhpbEtAp4CARo=
Date:   Fri, 1 May 2020 12:30:07 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-pci@vger.kernel.org, christian.koenig@amd.com,
        bhelgaas@google.com, jon@solid-run.com, wasim.khan@nxp.com
Subject: Re: [PATCH] PCI: allow pci_resize_resource() to be used on devices
 on the root bus
Message-ID: <20200501173007.GA117976@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421162256.26887-1-ardb@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 21, 2020 at 06:22:56PM +0200, Ard Biesheuvel wrote:
> When resizing a BAR, pci_reassign_bridge_resources() is invoked to
> bring the bridge windows of parent bridges in line with the new BAR
> assignment.
> 
> This assumes that the device whose BAR is being resized lives on a
> subordinate bus, but this is not necessarily the case. A device may
> live on the root bus, in which case dev->bus->self is NULL, and
> passing a NULL pci_dev pointer to pci_reassign_bridge_resources()
> will cause it to crash.
> 
> So let's make the call to pci_reassign_bridge_resources() conditional
> on whether dev->bus->self is non-NULL in the first place.
> 
> Fixes: 8bb705e3e79d84e7 ("PCI: Add pci_resize_resource() for resizing BARs")
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Applied with Christian's reviewed-by to pci/resource for v5.8, thanks!

> ---
>  drivers/pci/setup-res.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
> index d8ca40a97693..d21fa04fa44d 100644
> --- a/drivers/pci/setup-res.c
> +++ b/drivers/pci/setup-res.c
> @@ -439,10 +439,11 @@ int pci_resize_resource(struct pci_dev *dev, int resno, int size)
>  	res->end = res->start + pci_rebar_size_to_bytes(size) - 1;
>  
>  	/* Check if the new config works by trying to assign everything. */
> -	ret = pci_reassign_bridge_resources(dev->bus->self, res->flags);
> -	if (ret)
> -		goto error_resize;
> -
> +	if (dev->bus->self) {
> +		ret = pci_reassign_bridge_resources(dev->bus->self, res->flags);
> +		if (ret)
> +			goto error_resize;
> +	}
>  	return 0;
>  
>  error_resize:
> -- 
> 2.17.1
> 
