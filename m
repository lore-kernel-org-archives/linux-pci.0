Return-Path: <SRS0=cvZd=QJ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B68C282D8
	for <linux-pci@archiver.kernel.org>; Sat,  2 Feb 2019 00:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98A84218A6
	for <linux-pci@archiver.kernel.org>; Sat,  2 Feb 2019 00:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549068123;
	bh=IEGmkpfOHwCAHpgd7oEatYsV85QKz4VuQ+LXrU2UsvA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kyuzag8wRnUztDDZTtqM1QM52sHoWB7B0Wa0aldn2wAvjQz1FpAR+7v2aFTztmLp5
	 NQI6OPok2fwtTrsr81Fe7jr2QHldY2m+Pr8QtoElnD0tN8UhrZyH/eGwPp2k3fxQIF
	 KW05b3xnJDBcTBAtwFRSbc237hSl10rDOzRGSSjs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbfBBAmC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 1 Feb 2019 19:42:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:60506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726190AbfBBAmC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 Feb 2019 19:42:02 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B8E02148D;
        Sat,  2 Feb 2019 00:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549068121;
        bh=IEGmkpfOHwCAHpgd7oEatYsV85QKz4VuQ+LXrU2UsvA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P5syl6UVrESXt4aQM3EOxg7vyPVeOmrKsk3WssYIq9O8cbZqkGlyDYBT1ML/54uTZ
         lAuFe7flTUhrj7my34VDDoHM/pwkvUYc3nFtRsBkNQAQf+agIv2TfrOKm5zoIUgOJ9
         g8Tu/Q3/vDYrhhbP15XBf++bW4vVOvwp6htc8b1I=
Date:   Fri, 1 Feb 2019 18:41:59 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Timur Tabi <timur@codeaurora.org>,
        Jon Masters <jcm@redhat.com>,
        Yijing Wang <wangyijing@huawei.com>,
        Christopher Covington <cov@codeaurora.org>,
        Taku Izumi <izumi.taku@jp.fujitsu.com>,
        Oza Pawandeep <poza@codeaurora.org>,
        Ravikiran Gummaluri <rgummal@xilinx.com>
Subject: Re: [PATCH] PCI: Enable SERR# forwarding for Type-1 PCI devices
Message-ID: <20190202004159.GX229773@google.com>
References: <1542206821-24503-1-git-send-email-bharat.kumar.gogada@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542206821-24503-1-git-send-email-bharat.kumar.gogada@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc others who have commented or been copied on this ancient issue]

On Wed, Nov 14, 2018 at 08:17:01PM +0530, Bharat Kumar Gogada wrote:
> As per Figure 6-3 in PCIe r4.0, sec 6.2.6, ERR_ messages
> will be forwarded from the secondary interface to the primary interface,
> if the SERR# Enable bit in the Bridge Control register is set.
> Currently PCI_BRIDGE_CTL_SERR is being enabled only in
> ACPI flow.
> This patch enables PCI_BRIDGE_CTL_SERR for Type-1 PCI device.

I apologize for being so slow to respond to this.

I applied it to pci/aer for v5.1 with the following changelog:

    PCI: Enable SERR# forwarding for all bridges
    
    As per Figure 6-3 in PCIe r4.0, sec 6.2.6, ERR_ messages will be forwarded
    from the secondary interface to the primary interface, if the SERR# Enable
    bit in the Bridge Control register is set.
    
    It seems clear that an ACPI hotplug parameter method (_HPP or _HPX) that
    tells us to "enable SERR in the command register" (ACPI v6.2, sec 6.2.8,
    6.2.9.1) refers to PCI_COMMAND_SERR, which enables reporting of errors by
    the function itself.
    
    For bridges, we also interpreted that to mean we should enable
    PCI_BRIDGE_CTL_SERR, which enables *forwarding* of errors by the bridge.
    But we didn't enable PCI_BRIDGE_CTL_SERR anywhere else, which means we
    never enabled it for non-ACPI systems or ACPI systems that didn't supply
    hotplug parameters.
    
    That means errors reported below bridges were often never forwarded up to a
    Root Port where they could be signaled via AER.
    
    Enable PCI_BRIDGE_CTL_SERR for all bridges so we can get better error
    reporting for downstream devices.
    
    Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
    [bhelgaas: changelog]
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> ---
>  drivers/pci/probe.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index b1c05b5..ed71e8e 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1841,8 +1841,6 @@ static void program_hpp_type0(struct pci_dev *dev, struct hpp_type0 *hpp)
>  		pci_write_config_byte(dev, PCI_SEC_LATENCY_TIMER,
>  				      hpp->latency_timer);
>  		pci_read_config_word(dev, PCI_BRIDGE_CONTROL, &pci_bctl);
> -		if (hpp->enable_serr)
> -			pci_bctl |= PCI_BRIDGE_CTL_SERR;
>  		if (hpp->enable_perr)
>  			pci_bctl |= PCI_BRIDGE_CTL_PARITY;
>  		pci_write_config_word(dev, PCI_BRIDGE_CONTROL, pci_bctl);
> @@ -2114,6 +2112,23 @@ static void pci_configure_eetlp_prefix(struct pci_dev *dev)
>  #endif
>  }
>  
> +static void pci_configure_serr(struct pci_dev *dev)
> +{
> +	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
> +		u16 control;
> +
> +		/*
> +		 * A Type-1 PCI bridge will not forward ERR_ messages coming
> +		 * from an endpoint if SERR# forwarding is not enabled.
> +		 */
> +		pci_read_config_word(dev, PCI_BRIDGE_CONTROL, &control);
> +		if (!(control & PCI_BRIDGE_CTL_SERR)) {
> +			control |= PCI_BRIDGE_CTL_SERR;
> +			pci_write_config_word(dev, PCI_BRIDGE_CONTROL, control);
> +		}
> +	}
> +}
> +
>  static void pci_configure_device(struct pci_dev *dev)
>  {
>  	struct hotplug_params hpp;
> @@ -2124,6 +2139,7 @@ static void pci_configure_device(struct pci_dev *dev)
>  	pci_configure_relaxed_ordering(dev);
>  	pci_configure_ltr(dev);
>  	pci_configure_eetlp_prefix(dev);
> +	pci_configure_serr(dev);
>  
>  	memset(&hpp, 0, sizeof(hpp));
>  	ret = pci_get_hp_params(dev, &hpp);
> -- 
> 2.7.4
> 
