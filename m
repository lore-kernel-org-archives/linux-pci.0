Return-Path: <SRS0=vhAr=RQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 103EAC10F03
	for <linux-pci@archiver.kernel.org>; Wed, 13 Mar 2019 10:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFE96214AE
	for <linux-pci@archiver.kernel.org>; Wed, 13 Mar 2019 10:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="EWmTK3JK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbfCMKdX (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 13 Mar 2019 06:33:23 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:35946 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfCMKdW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Mar 2019 06:33:22 -0400
Received: from mailhost.synopsys.com (dc8-mailhost1.synopsys.com [10.13.135.209])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 78D0910C25F8;
        Wed, 13 Mar 2019 03:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1552473202; bh=hZJ5siwkYRrtUpNGM0+G4sTCKZ5j4X5UCoWae5UxQSc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=EWmTK3JKGjwRNGp6X0Ds6sNMmZbR5RQDPGWm/eSKS4UJwjuL28hWnCQGg+d0hEEeF
         5d0LBarwh/MJH0/NB18fhWjMtnV9xjvNSLLnUh6Q8zki2T/6RvBG8w7O8SYIX4ECc4
         smZZogV20n3Oor+FR0nl5gvVfbRzyS5vWLGtaXzihEgseheY/j3MxctXjvvWoDtlFA
         ZZTcXhhc4Kd9UyD5zIolXuLiew3dQ4ab54jRhKuLy+GevLQTzRCqlXYC39XNqFoAgc
         58xZWdaJjrqMYiyyPBvbPB4XZFGBikyD7PrpD9oIBEevtVWjmFuMpdz3M0z/ivat03
         lTvb2AvRu7MHA==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 51451A0087;
        Wed, 13 Mar 2019 10:33:22 +0000 (UTC)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 13 Mar 2019 03:33:17 -0700
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 13 Mar 2019 11:33:15 +0100
Received: from [10.107.19.55] (10.107.19.55) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 13 Mar 2019 11:33:15 +0100
Subject: Re: [PATCH v2 5/5] PCI: dwc: Save root bus for driver remove
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
 <20190301125943.47adae82@xhacker.debian>
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <962065dc-6e9d-d481-ca56-a2045ca7fef0@synopsys.com>
Date:   Wed, 13 Mar 2019 10:33:13 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190301125943.47adae82@xhacker.debian>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.19.55]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 01/03/2019 05:06, Jisheng Zhang wrote:
> Currently dwc host doesn't support the remove, but nothing prevent us
> from supporting it. Save the root bus for clean up work in driver
> remove code path.
> 
> After this patch, the dwc host users could implement its remove as:
> 
> static int foo_pcie_remove(struct platform_device *pdev)
> {
> 	...
> 	pci_stop_root_bus(pp->root_bus);
> 	pci_remove_root_bus(pp->root_bus);
> 	dw_pcie_free_msi(pp);
> 	...
> }
> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 1 +
>  drivers/pci/controller/dwc/pcie-designware.h      | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 4831c12fee93..ca45a4471ca0 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -496,6 +496,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  		goto err_free_msi;
>  
>  	bus = bridge->bus;
> +	pp->root_bus = bus;

Why you don't use from the begging the pp->root_bus variable instead of bus
variable? That way we can remove the bus variable.

Regards,
Gustavo

>  
>  	if (pp->ops->scan_bus)
>  		pp->ops->scan_bus(pp);
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 3be7ca9f1fc3..cd92ded606c6 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -182,6 +182,7 @@ struct pcie_port {
>  	struct page		*msi_page;
>  	u32			num_vectors;
>  	u32			irq_mask[MAX_MSI_CTRLS];
> +	struct pci_bus		*root_bus;
>  	raw_spinlock_t		lock;
>  	DECLARE_BITMAP(msi_irq_in_use, MAX_MSI_IRQS);
>  };
> 

