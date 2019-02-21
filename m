Return-Path: <SRS0=2g0o=Q4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E461C43381
	for <linux-pci@archiver.kernel.org>; Thu, 21 Feb 2019 23:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0334C20838
	for <linux-pci@archiver.kernel.org>; Thu, 21 Feb 2019 23:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550792231;
	bh=pEihKUO/K2gMKtPW1/2JoH/l70OghPbp4AK1Fp6t8RU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YT/X7dG1xg5ZLEtq2iNAFYwfk8/E+qOTYlUpkbUn2j3JeVwEd1HdeqwXy0OVqx9e+
	 wjFb7vVa3hZFWfqH1MU5BsPjAP5INPaH6y269Y9/XvW+vSkp9p397dhtwB1YaIhrGK
	 kiDvM3OnsV1xUjXxSZWlwjgugs+Bh3Cp5p6uxV60=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbfBUXhK (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 21 Feb 2019 18:37:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:54938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725961AbfBUXhJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 Feb 2019 18:37:09 -0500
Received: from localhost (unknown [104.133.8.90])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2948220818;
        Thu, 21 Feb 2019 23:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550792229;
        bh=pEihKUO/K2gMKtPW1/2JoH/l70OghPbp4AK1Fp6t8RU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B5Gw36R/H7jTBcj3qWLQ13v7YjX2u1Te135TTdsQy9/6aGOb7bvEneQoFnvetFIYZ
         kNDjRuK2UGqjFsVCSKSScAwNVz50tE0+VJ4B29xGuHwReOsyFk4EOQFBMFC/gYCymk
         woX5Hodjf+iMcJvLU5G9Z7BKu++OtDgjtO/RmLR8=
Date:   Thu, 21 Feb 2019 17:37:08 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/10] PCI: call add_bus method also for root bus
Message-ID: <20190221233708.GC219879@google.com>
References: <20190219155728.19163-1-tbogendoerfer@suse.de>
 <20190219155728.19163-8-tbogendoerfer@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190219155728.19163-8-tbogendoerfer@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Thomas,

On Tue, Feb 19, 2019 at 04:57:21PM +0100, Thomas Bogendoerfer wrote:
> pci-xtalk controller code uses the add_bus method to set node of
> the bus device, which then is used for pcibus_to_node() implementation.
> 
> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
> ---
>  drivers/pci/probe.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 257b9f6f2ebb..456448d5f46d 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -837,6 +837,12 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
>  
>  	pcibios_add_bus(bus);
>  
> +	if (bus->ops->add_bus) {
> +		err = bus->ops->add_bus(bus);
> +		if (WARN_ON(err < 0))
> +			dev_err(&bus->dev, "failed to add bus: %d\n", err);
> +	}

Is there something special about pci-xtalk that prevents it from
setting the node the way other platforms do, without using the
add_bus() method?

I haven't researched the details of how other platforms do it, but if
it would be possible for pci-xtalk to do it the same way, that would
be ideal.

>  	/* Create legacy_io and legacy_mem files for this bus */
>  	pci_create_legacy_files(bus);
>  
> -- 
> 2.13.7
> 
