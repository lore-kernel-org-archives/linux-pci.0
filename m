Return-Path: <SRS0=01Vy=CT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9899AC43461
	for <linux-pci@archiver.kernel.org>; Thu, 10 Sep 2020 07:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EBB921556
	for <linux-pci@archiver.kernel.org>; Thu, 10 Sep 2020 07:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="DpeInDNA";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eVUq/LdL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgIJHx6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 10 Sep 2020 03:53:58 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:37933 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730180AbgIJHxp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Sep 2020 03:53:45 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 2D75F580430;
        Thu, 10 Sep 2020 03:53:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 10 Sep 2020 03:53:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=4IwUSWnhrsr8imxfyk4VF7uLol/
        6Va9L4vcVGrq/KUg=; b=DpeInDNAleYGgRXYx5yZL9OHtS5DeNQcN2Gg0do++SH
        YSMmizLhTlgbIzCCwaj45lba97oInLSBoC6AM+6WQWjQ1TmCDYqt07Mc3PpHmGVA
        VgqCogEuSPN7Rt8IpT1Kly4QyyGlvulQZ0R8/MIhZWxwclIhIWi7Rl6zGA4OJYxg
        BCh3npgBVQM6Rg5KNjmQHx9tJcSUXP9EvBi2AulzSfn6rvIsvd1/SbhJyoD4a7Zf
        Prt9485zxgfMob9e4ivtEOn6BGnKvsDWUQCTSqMjUSoKIf8htP96RlQsa5m/zwVN
        3lGi46OxtSJpzKQoiZ9ZnOfuHrCCxT5BYTBVXsUb4bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=4IwUSW
        nhrsr8imxfyk4VF7uLol/6Va9L4vcVGrq/KUg=; b=eVUq/LdLkUmCzqUDe5XjHQ
        6gQaMja5JKFL9P9rWSs6PvHNXbHt4Mhyk4bUxnldBp/HUyCRVPR/p2fse6aLXfuL
        p2FwfdgB45G4oWXpGcza34nuXlS66nvkahnM8uzTtSYJDiDbp2V8bB4TOG2/4jhX
        h99ut2OUengbFRdqwvQSGakPaub230xTJCKFZaVYsWuFB58LHQ5Hx354UZh0dYVw
        PCo3EB4GKBH9Xop2bbTsvLGZ3eHmkSY7iCXIHw62TmeG/DEAMtqRfUyHQF/b77/p
        jM4PInh8wwP50Dj5r/NjPhp6NRMzEBwaPR+KMImvvyZi0uW66CTCdq1rQRKeZtwA
        ==
X-ME-Sender: <xms:httZX2bEkdb-6xbpM0Gy3unGo1mEokpb2i4nwc1asaSi0EsUNYRRNw>
    <xme:httZX5ZfghwWmJCGxGZkMtskcUnPoh3-9owhrrTtvkUVoZYyCe_oApefsaJUFkTjq
    wrXeHGxcGhhhA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudehiedguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepveeuhe
    ejgfffgfeivddukedvkedtleelleeghfeljeeiueeggeevueduudekvdetnecukfhppeek
    fedrkeeirdejgedrieegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:httZXw_PC2-hN3lbCWXZPNhoI7ya91a6T95ugFHV-s2JEndE3J8W-A>
    <xmx:httZX4oPxgyUOuJjTMKBYzSiseIs1alu69_7qFSnbpL6IndtEfbiLg>
    <xmx:httZXxpexp38l6Jtr_EOif9jZQf7-0VYCOQddV7wetbhUkTk3goDNA>
    <xmx:iNtZX8AUUp7WbntFrnfozKyPES4R0GmgBnTEqST-zruj-BkHlu38bw>
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id 291DA3280065;
        Thu, 10 Sep 2020 03:53:42 -0400 (EDT)
Date:   Thu, 10 Sep 2020 09:53:51 +0200
From:   Greg KH <greg@kroah.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org,
        Russell King <linux@armlinux.org.uk>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH 3/3] dma-mapping: introduce DMA range map, supplanting
 dma_pfn_offset
Message-ID: <20200910075351.GA1092435@kroah.com>
References: <20200910054038.324517-1-hch@lst.de>
 <20200910054038.324517-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910054038.324517-4-hch@lst.de>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 10, 2020 at 07:40:38AM +0200, Christoph Hellwig wrote:
> From: Jim Quinlan <james.quinlan@broadcom.com>
> 
> The new field 'dma_range_map' in struct device is used to facilitate the
> use of single or multiple offsets between mapping regions of cpu addrs and
> dma addrs.  It subsumes the role of "dev->dma_pfn_offset" which was only
> capable of holding a single uniform offset and had no region bounds
> checking.
> 
> The function of_dma_get_range() has been modified so that it takes a single
> argument -- the device node -- and returns a map, NULL, or an error code.
> The map is an array that holds the information regarding the DMA regions.
> Each range entry contains the address offset, the cpu_start address, the
> dma_start address, and the size of the region.
> 
> of_dma_configure() is the typical manner to set range offsets but there are
> a number of ad hoc assignments to "dev->dma_pfn_offset" in the kernel
> driver code.  These cases now invoke the function
> dma_attach_offset_range(dev, cpu_addr, dma_addr, size).

So if an error happens, we don't do anything?

ice_init(dev->dev);
> diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
> index 6197938dcc2d8f..935ee98e049f65 100644
> --- a/drivers/usb/core/message.c
> +++ b/drivers/usb/core/message.c
> @@ -1956,10 +1956,11 @@ int usb_set_configuration(struct usb_device *dev, int configuration)
>  		intf->dev.groups = usb_interface_groups;
>  		/*
>  		 * Please refer to usb_alloc_dev() to see why we set
> -		 * dma_mask and dma_pfn_offset.
> +		 * dma_mask and dma_range_map.
>  		 */
>  		intf->dev.dma_mask = dev->dev.dma_mask;
> -		intf->dev.dma_pfn_offset = dev->dev.dma_pfn_offset;
> +		if (dma_direct_copy_range_map(&intf->dev, &dev->dev))
> +			dev_err(&dev->dev, "failed to copy DMA map\n");

We tell the user, but then just keep on running?  Is there anything that
we can do here?

If not, why not have dma_direct_copy_range_map() print out the error?

thanks,

greg k-h
