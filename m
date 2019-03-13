Return-Path: <SRS0=vhAr=RQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD87C43381
	for <linux-pci@archiver.kernel.org>; Wed, 13 Mar 2019 10:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDF3B20449
	for <linux-pci@archiver.kernel.org>; Wed, 13 Mar 2019 10:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="f+kPSHf3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725889AbfCMKY7 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 13 Mar 2019 06:24:59 -0400
Received: from smtprelay.synopsys.com ([198.182.60.111]:35664 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfCMKY6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Mar 2019 06:24:58 -0400
Received: from mailhost.synopsys.com (dc8-mailhost1.synopsys.com [10.13.135.209])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 9027D10C260A;
        Wed, 13 Mar 2019 03:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1552472698; bh=mWkOJrm3USsacYgpgtGi/hc2CEa983PNQAMWVQbNTrc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=f+kPSHf372nBogRZlnB6AmBwWyODzJALAe2sDnH8mknRHt1OFPOOJK1SRhN1DA9m0
         Kr/Jq4WIAiqYw09D9A9/AJajIhF6GzF6TyuQIzsMFU46rRgVRJPJgXLilR7wFqGgZ/
         xBMz8u5k5vmC3jSAzv5mPofZ3ebd7xc/5NUuBmZh6HGOFZZuJCM5Uv1gimfKz6c0G2
         InDEBjVIsl1YaNt13KLjLEwqB6iMjzT9LRAKWuIMJTBAahprlRAsVjZtcpsp0QRP5M
         K8cSNTPGN6/7FLfbIYNSuZ6tD8IJFa1Vp1aHCr1SxZDGraAmUNPXmSuM3pH8CWf/Zw
         uEQpbAmCA9Gtw==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 7A3EDA005D;
        Wed, 13 Mar 2019 10:24:58 +0000 (UTC)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 13 Mar 2019 03:24:58 -0700
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 13 Mar 2019 11:24:56 +0100
Received: from [10.107.19.55] (10.107.19.55) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 13 Mar 2019 11:24:56 +0100
Subject: Re: [PATCH v2 3/5] PCI: dwc: Free MSI in the error code path of
 dw_pcie_host_init()
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20190301125510.4e2ee985@xhacker.debian>
 <20190301125818.1b0d7e08@xhacker.debian>
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <c85ba113-5f0b-8aa9-60bd-729373212387@synopsys.com>
Date:   Wed, 13 Mar 2019 10:24:54 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190301125818.1b0d7e08@xhacker.debian>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.19.55]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,


On 01/03/2019 05:05, Jisheng Zhang wrote:
> If we ever did some msi related initializations, we need to call
> dw_pcie_free_msi() in the error code path.
> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index abe3ff5f0867..66569d0f3ab9 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -482,7 +482,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  	if (pp->ops->host_init) {
>  		ret = pp->ops->host_init(pp);
>  		if (ret)
> -			goto error;
> +			goto err_free_msi;
>  	}
>  
>  	pp->root_bus_nr = pp->busn->start;
> @@ -496,7 +496,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  
>  	ret = pci_scan_root_bus_bridge(bridge);
>  	if (ret)
> -		goto error;
> +		goto err_free_msi;
>  
>  	bus = bridge->bus;
>  
> @@ -512,6 +512,9 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  	pci_bus_add_devices(bus);
>  	return 0;
>  
> +err_free_msi:
> +	if (IS_ENABLED(CONFIG_PCI_MSI) && !pp->ops->msi_host_init)

Look to Lucas Stach patch 3afc8299f39a ("PCI: dwc: skip MSI init if MSIs have
been explicitly disabled")

You need to change this to:

if (IS_ENABLED(CONFIG_PCI_MSI) && pci_msi_enabled() && !pp->ops->msi_host_init)


> +		dw_pcie_free_msi(pp);
>  error:
>  	pci_free_host_bridge(bridge);
>  	return ret;
> 

Sounds good, thanks.

Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
