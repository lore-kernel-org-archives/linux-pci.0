Return-Path: <SRS0=/qR3=MN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A439BC43143
	for <linux-pci@archiver.kernel.org>; Mon,  1 Oct 2018 14:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75998208AE
	for <linux-pci@archiver.kernel.org>; Mon,  1 Oct 2018 14:36:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75998208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729452AbeJAVOG (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 1 Oct 2018 17:14:06 -0400
Received: from foss.arm.com ([217.140.101.70]:50636 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729378AbeJAVOF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Oct 2018 17:14:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BBE6C18A;
        Mon,  1 Oct 2018 07:35:58 -0700 (PDT)
Received: from red-moon (red-moon.emea.arm.com [10.4.13.120])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0138E3F5B3;
        Mon,  1 Oct 2018 07:35:55 -0700 (PDT)
Date:   Mon, 1 Oct 2018 15:36:41 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     honghui.zhang@mediatek.com
Cc:     bhelgaas@google.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryder.lee@mediatek.com,
        ulf.hansson@linaro.org, marc.zyngier@arm.com,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        yingjoe.chen@mediatek.com, eddie.huang@mediatek.com,
        youlin.pei@mediatek.com, yt.shen@mediatek.com,
        sean.wang@mediatek.com
Subject: Re: [PATCH v5 1/9] PCI: mediatek: Using slot's devfn for compare to
 fix mtk_pcie_find_port logic
Message-ID: <20181001143641.GB13049@red-moon>
References: <1538129080-8206-1-git-send-email-honghui.zhang@mediatek.com>
 <1538129080-8206-2-git-send-email-honghui.zhang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538129080-8206-2-git-send-email-honghui.zhang@mediatek.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 28, 2018 at 06:04:32PM +0800, honghui.zhang@mediatek.com wrote:
> From: Honghui Zhang <honghui.zhang@mediatek.com>
> 
> The Mediatek's host controller has two slots, each with it's own control
> registers. The host driver need to identify which slot was connected
> in order to access the device's configuration space. There's problem
> for current host driver to find out which slot was connected to for
> a given EP device.
> 
> Assuming each slot have connect with one EP device as below:
> 
>                 host bridge
>   bus 0 --> __________|_______
>            |                  |
>            |                  |
>          slot 0             slot 1
>   bus 1 -->|        bus 2 --> |
>            |                  |
>          EP 0               EP 1
> 
> During PCI enumeration, system software will scan all the PCI device
> starting from devfn 0. So it will get the proper port for slot0 and
> slot1 device when using PCI_SLOT(devfn) for match. But it will get
> the wrong slot for EP1: The devfn will be start from 0 when scanning
> EP1 behind slot1, it will get port0 since the PCI_SLOT(EP1) is match
> for port0's slot value. So the host driver should not using EP's devfn
> but the slot's devfn(the slot which EP was connected to) for match.
> 
> This patch fix the mtk_pcie_find_port's logic by using the slot's
> devfn for match if finding device connected to the subordinate bus.
> 
> Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
> ---
>  drivers/pci/controller/pcie-mediatek.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> index 9999dae..264e03f 100644
> --- a/drivers/pci/controller/pcie-mediatek.c
> +++ b/drivers/pci/controller/pcie-mediatek.c
> @@ -337,10 +337,25 @@ static struct mtk_pcie_port *mtk_pcie_find_port(struct pci_bus *bus,
>  {
>  	struct mtk_pcie *pcie = bus->sysdata;
>  	struct mtk_pcie_port *port;
> +	struct pci_dev *dev = NULL;
> +
> +	/*
> +	 * Walk the bus hierarchy to get the devfn value
> +	 * of the port in the root bus.
> +	 */
> +	while (bus && bus->number) {
> +		dev = bus->self;
> +		bus = dev->bus;

If you add:

devfn = dev->devfn;

here

> +	}
> +
> +	list_for_each_entry(port, &pcie->ports, list) {
> +		/* Using slot's devfn to compare for subordinary bus. */
> +		if (dev)
> +			devfn = dev->devfn;

You can remove this ugly hunk altogether (and dev initialization
to NULL).

Lorenzo

> -	list_for_each_entry(port, &pcie->ports, list)
>  		if (port->slot == PCI_SLOT(devfn))
>  			return port;
> +	}
>  
>  	return NULL;
>  }
> -- 
> 2.6.4
> 
