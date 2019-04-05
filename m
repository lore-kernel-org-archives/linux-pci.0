Return-Path: <SRS0=e3W/=SH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35CEC282CE
	for <linux-pci@archiver.kernel.org>; Fri,  5 Apr 2019 21:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8E1221726
	for <linux-pci@archiver.kernel.org>; Fri,  5 Apr 2019 21:28:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbfDEV2O (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 5 Apr 2019 17:28:14 -0400
Received: from foss.arm.com ([217.140.101.70]:55822 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725973AbfDEV2O (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Apr 2019 17:28:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 44CFD16A3;
        Fri,  5 Apr 2019 14:28:13 -0700 (PDT)
Received: from [192.168.1.123] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D2D103F68F;
        Fri,  5 Apr 2019 14:28:10 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] PCI: OF: Support external-facing property
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Grant.Likely@arm.com,
        Jeremy.Linton@arm.com
References: <20190402131548.41949-1-jean-philippe.brucker@arm.com>
 <20190402131548.41949-3-jean-philippe.brucker@arm.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <17400193-bf44-1573-a35a-852ab9127721@arm.com>
Date:   Fri, 5 Apr 2019 22:28:05 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190402131548.41949-3-jean-philippe.brucker@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2019-04-02 2:15 pm, Jean-Philippe Brucker wrote:
> Set the "untrusted" attribute to any PCIe port that has an
> "external-facing" device tree property. Any device downstream of this
> port will inherit the attribute and have only the strictest IOMMU
> protection.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> ---
>   drivers/pci/of.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 3d32da15c215..3e7ac7748d90 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -35,6 +35,9 @@ void pci_set_bus_of_node(struct pci_bus *bus)
>   		bus->dev.of_node = pcibios_get_phb_of_node(bus);
>   	else
>   		bus->dev.of_node = of_node_get(bus->self->dev.of_node);
> +
> +	if (of_get_property(bus->dev.of_node, "external-facing", NULL))

You could use of_property_read_bool() for this, but either way,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> +		bus->self->untrusted = true;
>   }
>   
>   void pci_release_bus_of_node(struct pci_bus *bus)
> 
