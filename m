Return-Path: <SRS0=G860=RV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52194C43381
	for <linux-pci@archiver.kernel.org>; Mon, 18 Mar 2019 10:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 187D52070D
	for <linux-pci@archiver.kernel.org>; Mon, 18 Mar 2019 10:09:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="eB+E27zQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfCRKJ1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 18 Mar 2019 06:09:27 -0400
Received: from smtprelay.synopsys.com ([198.182.60.111]:42974 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727130AbfCRKJ1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Mar 2019 06:09:27 -0400
Received: from mailhost.synopsys.com (dc8-mailhost2.synopsys.com [10.13.135.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 9028710C1556;
        Mon, 18 Mar 2019 03:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1552903766; bh=qCm9KvfTairpRxzfIGQbUimxdnzi/aiQzGOCYJfipJk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=eB+E27zQGNgjiP19ZIc99nYSdRFgzEQOBSZGXIf2kWy/hl1s4Gaa6Qlhean6p4l3c
         aGwP6nvKn/OPJ/VbZNMFyunItwxwKc8MZOZAAJQJwFSBVdmI3C85rlseZOwKGJE2Pm
         sDTANH7pxAOJu1OdyG1I8qXkD2OhHvrRx1MIcEp8VfbwgbtRo28hh271a6/qtOz0/s
         KPvTbYu9uv+rJCcLG+8hflUShfe7g84JwFvIzroUDlGmV3NCPgfyO8bemdhQPt2mll
         88eGOZT/QQDCup7Q9d18kWS/Z4s58EBvvJkIV7oTYec3o217nqS6w1KjMkWTLSxxq9
         KpCckE+1zEmmg==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 753DCA0062;
        Mon, 18 Mar 2019 10:09:26 +0000 (UTC)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 us01wehtc1.internal.synopsys.com (10.12.239.235) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 18 Mar 2019 03:09:26 -0700
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 18 Mar 2019 11:09:24 +0100
Received: from [10.107.25.131] (10.107.25.131) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 18 Mar 2019 11:09:23 +0100
Subject: Re: [PATCH v3 5/5] PCI: dwc: Save root bus for driver remove
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20190318174415.74fd25a5@xhacker.debian>
 <20190318175051.5430be17@xhacker.debian>
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <52f4dc09-f1d0-47a1-2c75-91981308b08b@synopsys.com>
Date:   Mon, 18 Mar 2019 10:09:22 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190318175051.5430be17@xhacker.debian>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.25.131]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 18/03/2019 09:58, Jisheng Zhang wrote:
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
>  drivers/pci/controller/dwc/pcie-designware-host.c | 12 ++++++------
>  drivers/pci/controller/dwc/pcie-designware.h      |  1 +
>  2 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 68a9dac23b1b..7e9dad7ba056 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -341,7 +341,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  	struct device_node *np = dev->of_node;
>  	struct platform_device *pdev = to_platform_device(dev);
>  	struct resource_entry *win, *tmp;
> -	struct pci_bus *bus, *child;
> +	struct pci_bus *child;
>  	struct pci_host_bridge *bridge;
>  	struct resource *cfg_res;
>  	int ret;
> @@ -496,18 +496,18 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  	if (ret)
>  		goto err_free_msi;
>  
> -	bus = bridge->bus;
> +	pp->root_bus = bridge->bus;
>  
>  	if (pp->ops->scan_bus)
>  		pp->ops->scan_bus(pp);
>  
> -	pci_bus_size_bridges(bus);
> -	pci_bus_assign_resources(bus);
> +	pci_bus_size_bridges(pp->root_bus);
> +	pci_bus_assign_resources(pp->root_bus);
>  
> -	list_for_each_entry(child, &bus->children, node)
> +	list_for_each_entry(child, &pp->root_bus->children, node)
>  		pcie_bus_configure_settings(child);
>  
> -	pci_bus_add_devices(bus);
> +	pci_bus_add_devices(pp->root_bus);
>  	return 0;
>  
>  err_free_msi:
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 6fb0a1879932..adff0c713665 100644
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

Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>

