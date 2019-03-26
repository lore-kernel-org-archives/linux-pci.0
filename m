Return-Path: <SRS0=/keI=R5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BE6C43381
	for <linux-pci@archiver.kernel.org>; Tue, 26 Mar 2019 19:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85E8820823
	for <linux-pci@archiver.kernel.org>; Tue, 26 Mar 2019 19:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553627590;
	bh=qo+GKUPJZX+bvvD/bhL0EMpl8YD8x5KfuoRsDygMmQQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wrS/6bgx8ycCeTR4Jk5tv1/53aqr8Xp/yQ7oiUytLCB09QUudBj0PcWYDEYEViU1Z
	 biMx1ASmsO9S6tJ3UZMBNNyApID4woIng6OtT1OyU7YxlGiATjym33LMfkl3bomltB
	 0DzL3HsRh7YTlz+h2hN+/SGXDH6g7qxixgPNxkeA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbfCZTNJ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 26 Mar 2019 15:13:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:44042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbfCZTNJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Mar 2019 15:13:09 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4B0520700;
        Tue, 26 Mar 2019 19:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553627589;
        bh=qo+GKUPJZX+bvvD/bhL0EMpl8YD8x5KfuoRsDygMmQQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=omY5iDsV7tn5seOWolhnzXmV71Fui1Zs+3PTNpCkew6KYmy02I8tbjx5Denwu3fkM
         qRxVZD58y+XAKGnq0RZ/BeRgg7F1WFesNCFhHw97HSrsNnJqUaMUNuldGOKSQrFUTe
         2OA8b5YURkSsOHFSlmr9lhcm4u/piYTOed6xshTI=
Date:   Tue, 26 Mar 2019 14:13:07 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Cc:     linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux@yadro.com
Subject: Re: [PATCH RFC v4 03/21] PCI: Enable bridge's I/O and MEM access for
 hotplugged devices
Message-ID: <20190326191307.GM24180@google.com>
References: <20190311133122.11417-1-s.miroshnichenko@yadro.com>
 <20190311133122.11417-4-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311133122.11417-4-s.miroshnichenko@yadro.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 11, 2019 at 04:31:04PM +0300, Sergey Miroshnichenko wrote:
> After updating the bridge window resources, the PCI_COMMAND_IO and
> PCI_COMMAND_MEMORY bits of the bridge must be addressed as well.
> 
> Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
> ---
>  drivers/pci/pci.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 895201d4c9e6..69898fe5255e 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1622,6 +1622,14 @@ static void pci_enable_bridge(struct pci_dev *dev)
>  		pci_enable_bridge(bridge);
>  
>  	if (pci_is_enabled(dev)) {
> +		int i, bars = 0;
> +
> +		for (i = PCI_BRIDGE_RESOURCES; i < DEVICE_COUNT_RESOURCE; i++) {
> +			if (dev->resource[i].flags & (IORESOURCE_MEM | IORESOURCE_IO))
> +				bars |= (1 << i);
> +		}
> +		do_pci_enable_device(dev, bars);

In what situation is this needed, exactly?  This code already exists
in pci_enable_device_flags().  Why isn't that enough?

I guess maybe there's some case where we enable the bridge, then
assign bridge windows, then enable a downstream device?

Does this fix a bug with current hotplug?

>  		if (!dev->is_busmaster)
>  			pci_set_master(dev);
>  		mutex_unlock(&dev->enable_mutex);
> -- 
> 2.20.1
> 
