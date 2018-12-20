Return-Path: <SRS0=yvM8=O5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90487C43387
	for <linux-pci@archiver.kernel.org>; Thu, 20 Dec 2018 19:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62A0F218D3
	for <linux-pci@archiver.kernel.org>; Thu, 20 Dec 2018 19:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545335402;
	bh=CfjC8duhK8Hp21eeKdeGvDK/DSapzWMqpqZLC8LNDxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bYQKAuFAa+s3ToBNAaYbhqn1LlrPDJaA/J9fNPLM1hj16Yyh5MwX3pS1bopgrjcEP
	 YDcYXRwTAsLFsKkysYcX6MBErSOclpWiRZFPaRmHCVX3Vcap4LgLugsiauykKReFZ2
	 4SyEp2Nr8Ce39S5EmsVn84yXHe4nAp7ccuH69SlM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728613AbeLTTt4 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 20 Dec 2018 14:49:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:49440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728528AbeLTTt4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Dec 2018 14:49:56 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89AD0218D3;
        Thu, 20 Dec 2018 19:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545335394;
        bh=CfjC8duhK8Hp21eeKdeGvDK/DSapzWMqpqZLC8LNDxQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SpN8s6sXczIwhk51ja3KV830FBvSZ72vh+WdT1oatM0XTAi2bOCV5Kz08mwQXyN7m
         uLRo+yrFgEayJLJRS0I3f5S1BR4JZW2meW3LqxFgfR32JMHVXuE4/eVNaoOP5+YRWF
         He1mZMMtfi13hz2qRnO1wygc5/peuovcy7V0BhhY=
Date:   Thu, 20 Dec 2018 13:49:50 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, xuyandong <xuyandong2@huawei.com>,
        stable@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
        Jesse Barnes <jbarnes@virtuousgeek.org>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: avoid bridge feature re-probing on hotplug
Message-ID: <20181220194950.GD183878@google.com>
References: <20181218004455.20186-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218004455.20186-1-mst@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Michael,

On Mon, Dec 17, 2018 at 07:45:41PM -0500, Michael S. Tsirkin wrote:
> commit 1f82de10d6b1 ("PCI/x86: don't assume prefetchable ranges are 64bit")
> added probing of bridge support for 64 bit memory each time bridge is
> re-enumerated.
> 
> Unfortunately this probing is destructive if any device behind
> the bridge is in use at this time.
> 
> This was observed in the field, see
> https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg01711.html
> and specifically
> https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg02082.html
> 
> There's no real need to re-probe the bridge features as the
> registers in question never change - detect that using
> the memory flag being set (it's always set on the 1st pass since
> all PCI2PCI bridges support memory forwarding) and skip the probing.
> Thus, only the first call will perform the disruptive probing and sets
> the resource flags as required - which we can be reasonably sure happens
> before any devices have been configured.
> Avoiding repeated calls to pci_bridge_check_ranges might be even nicer.
> Unfortunately I couldn't come up with a clean way to do it without a
> major probing code refactoring.

I'm OK with major probe code refactoring as long as it's done
carefully.  Doing a special-case fix like this solves the immediate
problem but adds to the long-term maintenance problem.

As far as I can tell, everything in pci_bridge_check_ranges() should
be done once at enumeration-time, e.g., in the pci_read_bridge_bases()
path, and pci_bridge_check_ranges() itself should be removed.

If that turns out to be impossible for some reason, we need a comment
explaining why.

> Reported-by: xuyandong <xuyandong2@huawei.com>
> Tested-by: xuyandong <xuyandong2@huawei.com>
> Cc: stable@vger.kernel.org
> Cc: Yinghai Lu <yinghai@kernel.org>
> Cc: Jesse Barnes <jbarnes@virtuousgeek.org>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> 
> Please review and consider for stable.
> 
> changes from v1:
> 	comment and commit log updates to address comments by Bjorn.
> 
>  drivers/pci/setup-bus.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index ed960436df5e..d5c25d465d97 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -741,6 +741,16 @@ static void pci_bridge_check_ranges(struct pci_bus *bus)
>  	struct resource *b_res;
>  
>  	b_res = &bridge->resource[PCI_BRIDGE_RESOURCES];
> +
> +	/*
> +	 * Don't re-check after this was called once already:
> +	 * important since bridge might be in use.
> +	 * Note: this is only reliable because as per spec all PCI to PCI
> +	 * bridges support memory unconditionally so IORESOURCE_MEM is set.
> +	 */
> +	if (b_res[1].flags & IORESOURCE_MEM)
> +		return;
> +
>  	b_res[1].flags |= IORESOURCE_MEM;
>  
>  	pci_read_config_word(bridge, PCI_IO_BASE, &io);
> -- 
> MST
