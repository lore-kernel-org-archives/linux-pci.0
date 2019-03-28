Return-Path: <SRS0=vCch=R7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6EF9C43381
	for <linux-pci@archiver.kernel.org>; Thu, 28 Mar 2019 17:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 928C1206B6
	for <linux-pci@archiver.kernel.org>; Thu, 28 Mar 2019 17:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfC1RIr (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 28 Mar 2019 13:08:47 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48670 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbfC1RIq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Mar 2019 13:08:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 31BFE80D;
        Thu, 28 Mar 2019 10:08:46 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C766A3F557;
        Thu, 28 Mar 2019 10:08:44 -0700 (PDT)
Subject: Re: [PATCH v3 3/5] PCI: dwc: Free MSI in the error code path of
 dw_pcie_host_init()
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20190318174415.74fd25a5@xhacker.debian>
 <20190318174841.522fb6fd@xhacker.debian>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <689f8a0f-ba79-da80-d0e3-24ef6814a9aa@arm.com>
Date:   Thu, 28 Mar 2019 17:08:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190318174841.522fb6fd@xhacker.debian>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 18/03/2019 09:56, Jisheng Zhang wrote:
> If we ever did some msi related initializations, we need to call
> dw_pcie_free_msi() in the error code path.
> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> ---
>   drivers/pci/controller/dwc/pcie-designware-host.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index a71b874ae3c0..585080699675 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -483,7 +483,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
>   	if (pp->ops->host_init) {
>   		ret = pp->ops->host_init(pp);
>   		if (ret)
> -			goto error;
> +			goto err_free_msi;
>   	}
>   
>   	pp->root_bus_nr = pp->busn->start;
> @@ -497,7 +497,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
>   
>   	ret = pci_scan_root_bus_bridge(bridge);
>   	if (ret)
> -		goto error;
> +		goto err_free_msi;
>   
>   	bus = bridge->bus;
>   
> @@ -513,6 +513,10 @@ int dw_pcie_host_init(struct pcie_port *pp)
>   	pci_bus_add_devices(bus);
>   	return 0;
>   
> +err_free_msi:
> +	if (IS_ENABLED(CONFIG_PCI_MSI) && pci_msi_enabled() &&

pci_msi_enabled() already has a stub for !CONFIG_PCI_MSI, so you 
shouldn't need an explicit IS_ENABLED() here.

Robin.

> +			!pp->ops->msi_host_init)
> +		dw_pcie_free_msi(pp);
>   error:
>   	pci_free_host_bridge(bridge);
>   	return ret;
> 
