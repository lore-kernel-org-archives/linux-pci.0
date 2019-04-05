Return-Path: <SRS0=e3W/=SH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C42BC282CE
	for <linux-pci@archiver.kernel.org>; Fri,  5 Apr 2019 22:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A49121855
	for <linux-pci@archiver.kernel.org>; Fri,  5 Apr 2019 22:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554504667;
	bh=Uv8T5XkijlF/iPY/OSSxFTQYFyUxGEd5wyOr5X3v9jA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ikxcldnpaC2YdujC0+9sOiWmMG2Lk3qeREGc9qobdjpDA4BgWamMmxPdmNSMxFPjO
	 7R3xMad6lNZZaGhshoy3kNLbU5c9VoZeqDLkMJMdNNsKkz3iHD2pCvwfX1YhDjgffS
	 kxiIq+4D1EUJI3eDuPkQUxv4UKohmD/bwVsRjMqc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbfDEWvG (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 5 Apr 2019 18:51:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:47242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726206AbfDEWvG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Apr 2019 18:51:06 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 736AC2171F;
        Fri,  5 Apr 2019 22:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554504665;
        bh=Uv8T5XkijlF/iPY/OSSxFTQYFyUxGEd5wyOr5X3v9jA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z5BXW0eX4Q4pTV22oMZ3rjhl46Qr1F6TnkyDiGGcpJ2mMpP1uRAIDJMzVn41kJvUF
         hCzP4U8A9y10bSK1PUednKRxDUNNTMAZJ+wEAlOjekmu8Jn0eSQnKEUC8lYRVI1/2t
         fZOuwoiDzbh6qgKGsE3meFNNQZike0bJcuGZBvVs=
Date:   Fri, 5 Apr 2019 17:51:02 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc:     lorenzo.pieralisi@arm.com, linux-pci@vger.kernel.org,
        Vidya Sagar <vidyas@nvidia.com>
Subject: Re: [PATCH] PCI: Fix pci_host_bridge initialization
Message-ID: <20190405225102.GE159318@google.com>
References: <20190318160718.10925-1-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318160718.10925-1-jean-philippe.brucker@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Vidya -- Jean-Philippe magically fixed the "tangent 2" problem :)]

On Mon, Mar 18, 2019 at 04:07:18PM +0000, Jean-Philippe Brucker wrote:
> Two functions allocate a host bridge, devm_pci_alloc_host_bridge() and
> pci_alloc_host_bridge(). At the moment, only the unmanaged one
> initializes the PCIe feature bits, which prevents from using features
> such as hotplug or AER on some systems, when booting with device tree.
> Make the initialization code common.
> 
> Fixes: 02bfeb484230 ("PCI/portdrv: Simplify PCIe feature permission checking")
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>

Applied with stable tag to pci/enumeration for v5.2, thanks!

> ---
>  drivers/pci/probe.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 2ec0df04e0dc..012250a78da7 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -586,16 +586,9 @@ static void pci_release_host_bridge_dev(struct device *dev)
>  	kfree(to_pci_host_bridge(dev));
>  }
>  
> -struct pci_host_bridge *pci_alloc_host_bridge(size_t priv)
> +static void pci_init_host_bridge(struct pci_host_bridge *bridge)
>  {
> -	struct pci_host_bridge *bridge;
> -
> -	bridge = kzalloc(sizeof(*bridge) + priv, GFP_KERNEL);
> -	if (!bridge)
> -		return NULL;
> -
>  	INIT_LIST_HEAD(&bridge->windows);
> -	bridge->dev.release = pci_release_host_bridge_dev;
>  
>  	/*
>  	 * We assume we can manage these PCIe features.  Some systems may
> @@ -608,6 +601,18 @@ struct pci_host_bridge *pci_alloc_host_bridge(size_t priv)
>  	bridge->native_shpc_hotplug = 1;
>  	bridge->native_pme = 1;
>  	bridge->native_ltr = 1;
> +}
> +
> +struct pci_host_bridge *pci_alloc_host_bridge(size_t priv)
> +{
> +	struct pci_host_bridge *bridge;
> +
> +	bridge = kzalloc(sizeof(*bridge) + priv, GFP_KERNEL);
> +	if (!bridge)
> +		return NULL;
> +
> +	pci_init_host_bridge(bridge);
> +	bridge->dev.release = pci_release_host_bridge_dev;
>  
>  	return bridge;
>  }
> @@ -622,7 +627,7 @@ struct pci_host_bridge *devm_pci_alloc_host_bridge(struct device *dev,
>  	if (!bridge)
>  		return NULL;
>  
> -	INIT_LIST_HEAD(&bridge->windows);
> +	pci_init_host_bridge(bridge);
>  	bridge->dev.release = devm_pci_release_host_bridge_dev;
>  
>  	return bridge;
> -- 
> 2.21.0
> 
