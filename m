Return-Path: <SRS0=obOR=L7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E87ECE560
	for <linux-pci@archiver.kernel.org>; Mon, 17 Sep 2018 14:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E00842088F
	for <linux-pci@archiver.kernel.org>; Mon, 17 Sep 2018 14:47:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E00842088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbeIQUPR (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 17 Sep 2018 16:15:17 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60276 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728902AbeIQUPR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Sep 2018 16:15:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81CBBED1;
        Mon, 17 Sep 2018 07:47:38 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.emea.arm.com [10.4.13.117])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 963D93F5BD;
        Mon, 17 Sep 2018 07:47:37 -0700 (PDT)
Date:   Mon, 17 Sep 2018 15:47:34 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>
Cc:     linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] PCI: rockchip: Remove redundant "valid device" check
Message-ID: <20180917144734.GF7239@e107981-ln.cambridge.arm.com>
References: <20171215202935.157396.74423.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171215202935.157396.74423.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
Message-ID: <20180917144734.ywfLGS-y_FJrdILJqTOYU8oUtyqklBu-wMu1U-2xXGE@z>

On Fri, Dec 15, 2017 at 02:29:35PM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> In rockchip_pcie_valid_device(), we do the exact same test twice:
> 
>   if (bus->number == rockchip->root_bus_nr && dev > 0)
>     return 0;
>   if (bus->number == rockchip->root_bus_nr && dev > 0)
>     return 0;
> 
> We only need to do it once, so remove one of them.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/host/pcie-rockchip.c |    4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
> index 9051c6c8fea4..dd9c7ea69e0b 100644
> --- a/drivers/pci/host/pcie-rockchip.c
> +++ b/drivers/pci/host/pcie-rockchip.c
> @@ -293,10 +293,6 @@ static void rockchip_pcie_update_txcredit_mui(struct rockchip_pcie *rockchip)
>  static int rockchip_pcie_valid_device(struct rockchip_pcie *rockchip,
>  				      struct pci_bus *bus, int dev)
>  {
> -	/* access only one slot on each root port */
> -	if (bus->number == rockchip->root_bus_nr && dev > 0)
> -		return 0;
> -
>  	/*
>  	 * do not read more than one device on the bus directly attached
>  	 * to RC's downstream side.
> 

Hi Bjorn,

this patch slipped through the cracks but I do not think it is right.

The point here is filtering both the host bridge access side (ie check
for dev > 0) AND the RC downstream side, it is two different busses.

Perhaps the check can be written in a more concise way (squash them in
one single conditional) but I think the current logic is correct,
AFAICS.

I would drop it from the PCI patch queue.

Thanks,
Lorenzo
