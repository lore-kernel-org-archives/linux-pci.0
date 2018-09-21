Return-Path: <SRS0=H68a=MD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99AA6ECE567
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 16:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F38221550
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 16:07:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F38221550
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390550AbeIUV5Z (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Sep 2018 17:57:25 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38688 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389545AbeIUV5Y (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Sep 2018 17:57:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2320418A;
        Fri, 21 Sep 2018 09:07:51 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.Emea.Arm.com [10.4.13.117])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E4363F557;
        Fri, 21 Sep 2018 09:07:47 -0700 (PDT)
Date:   Fri, 21 Sep 2018 17:07:45 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     honghui.zhang@mediatek.com
Cc:     marc.zyngier@arm.com, bhelgaas@google.com, matthias.bgg@gmail.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        yingjoe.chen@mediatek.com, eddie.huang@mediatek.com,
        ryder.lee@mediatek.com, ulf.hansson@linaro.org,
        hongkun.cao@mediatek.com, youlin.pei@mediatek.com,
        yong.wu@mediatek.com, yt.shen@mediatek.com, sean.wang@mediatek.com,
        xinping.qian@mediatek.com
Subject: Re: [PATCH v4 1/4] PCI: mediatek: fixup mtk_pcie_find_port logical
Message-ID: <20180921160745.GB21644@e107981-ln.cambridge.arm.com>
References: <1536573023-6720-1-git-send-email-honghui.zhang@mediatek.com>
 <1536573023-6720-2-git-send-email-honghui.zhang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536573023-6720-2-git-send-email-honghui.zhang@mediatek.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 10, 2018 at 05:50:20PM +0800, honghui.zhang@mediatek.com wrote:
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
> This patch fix the mtk_pcie_find_port's logical by using the slot's
> devfn for match.
> 
> Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
> Acked-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  drivers/pci/controller/pcie-mediatek.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> index 861dda6..20b9088 100644
> --- a/drivers/pci/controller/pcie-mediatek.c
> +++ b/drivers/pci/controller/pcie-mediatek.c
> @@ -337,11 +337,26 @@ static struct mtk_pcie_port *mtk_pcie_find_port(struct pci_bus *bus,
>  {
>  	struct mtk_pcie *pcie = bus->sysdata;
>  	struct mtk_pcie_port *port;
> +	struct pci_dev *dev;
> +	struct pci_bus *pbus;
>  
> -	list_for_each_entry(port, &pcie->ports, list)
> -		if (port->slot == PCI_SLOT(devfn))
> +	list_for_each_entry(port, &pcie->ports, list) {
> +		if (!bus->number && port->slot == PCI_SLOT(devfn))
>  			return port;
>  
> +		if (bus->number) {
> +			pbus = bus;
> +
> +			while (pbus->number) {
> +				dev = pbus->self;
> +				pbus = dev->bus;
> +			}
> +
> +			if (port->slot == PCI_SLOT(dev->devfn))
> +				return port;
> +		}
> +	}

	/*
	 * Walk the bus hierarchy to get the devfn value
	 * of the port in the root bus.
	 */
	while (bus && bus->number) {
		devfn = bus->self->devfn;
		bus = bus->parent;
	}

	list_for_each_entry(port, &pcie->ports, list) {
		if (port->slot == PCI_SLOT(devfn))
			return port;

	return NULL;

Would it work ? Maybe it is a little easier to parse.

I think this can even be made easier by using struct device_node* as
comparison (and store it in port->slot instead of the port number), I
think that the pci_dev representing the port should have the right
of_node associated with it by core code, so it is just a matter of
finding the first pci_dev parent with an of_node set and compare it
against port->slot (that should be converted to a struct device_node*).

This ought to be tested and written but I think that's doable.

Lorenzo
