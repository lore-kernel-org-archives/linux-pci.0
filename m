Return-Path: <SRS0=NFOj=OU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 826DEC07E85
	for <linux-pci@archiver.kernel.org>; Tue, 11 Dec 2018 14:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4691020851
	for <linux-pci@archiver.kernel.org>; Tue, 11 Dec 2018 14:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544537891;
	bh=mjcczxHWBLk6glsEhzWjENo8W7uzGln1zCBrMNLVbC8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bGRc7xvv8Vpl3XqAKUWNfNFbBZNLR5I843PR1s0YWpoh3mMNksEDmqAHtxd0ZLp3G
	 mixcNA01xmj5V8qhhOfi5JDC6RXGj98S2gomrdmI0wjT25wAg5kBKgArTacLXpkzHT
	 nk861+SokfqvTV0xSBpcDL/QuDPkroqo+6FUmzyE=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4691020851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbeLKOSK (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 11 Dec 2018 09:18:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:40058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726444AbeLKOSK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 11 Dec 2018 09:18:10 -0500
Received: from localhost (173-25-171-118.client.mchsi.com [173.25.171.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23F3C20849;
        Tue, 11 Dec 2018 14:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544537889;
        bh=mjcczxHWBLk6glsEhzWjENo8W7uzGln1zCBrMNLVbC8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GIebsVLlqSfTxhsvT8uw4oEcp/Rl1ouHa/FoxwZC7+yfgsKKifqKq5GzVYogkuU5T
         jeQdOb7qOawENsjzijzakr7sNH2qJhl6HKhthch4iHoP+Wko3bs2B3R6+T5Dc/gH+h
         Gavuwy9F5YfV7eAPetKdFSMQUr7UbtRgAqvuy6+A=
Date:   Tue, 11 Dec 2018 08:18:08 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, xuyandong <xuyandong2@huawei.com>,
        stable@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
        Jesse Barnes <jbarnes@virtuousgeek.org>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] pci: avoid bridge feature re-probing on hotplug
Message-ID: <20181211141808.GE99796@google.com>
References: <20181211021617.24072-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211021617.24072-1-mst@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Michael,

Please run "git log --oneline drivers/pci/setup-bus.c" and follow
the usual style.

On Mon, Dec 10, 2018 at 09:18:40PM -0500, Michael S. Tsirkin wrote:
> commit 1f82de10d6 ("PCI/x86: don't assume prefetchable ranges are
> 64bit") added probing of bridge support for 64 bit memory
> each time bridge is re-enumerated.

Use conventional SHA1 reference (12-char SHA1).

> Unfortunately this probing is destructive if any device behind
> the bridge is in use at this time.

Agreed, this sounds like a problem.

> There's no real need to re-probe the bridge features as the
> regiters in question never change - detect that using
> the memory flag being set and skip the probing.

s/regiters/registers/

> Avoiding repeated calls to pci_bridge_check_ranges might be even nicer
> would be a bigger patch and probably not appropriate on stable.

Maybe so.  The ideal thing might be to have a trivial patch like this
that can be marked for stable, immediately followed by the nicer
patch.  Trivial band-aids tend to accumulate and make things harder in
the future.

I'd have to take a much harder look at the problem to understand
1f82de10d6b1.  The comment about "double check" seems misleading -- as
you say, the hardware doesn't change and checking once should be
enough.  And if we're calling pci_bridge_check_ranges() more than
necessary, that sounds like a problem, too.

> Reported-by: xuyandong <xuyandong2@huawei.com>
> Cc: stable@vger.kernel.org
> Cc: Yinghai Lu <yinghai@kernel.org>
> Cc: Jesse Barnes <jbarnes@virtuousgeek.org>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> 
> This issue has been reported on upstream Linux and Centos.

Are there URLs to these reports that we could include in the changelog?

>  drivers/pci/setup-bus.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index ed960436df5e..7ab42f76579e 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -741,6 +741,13 @@ static void pci_bridge_check_ranges(struct pci_bus *bus)
>  	struct resource *b_res;
>  
>  	b_res = &bridge->resource[PCI_BRIDGE_RESOURCES];
> +
> +	/* Don't re-check after this was called once already:
> +	 * important since bridge might be in use.
> +	 */
> +	if (b_res[1].flags & IORESOURCE_MEM)
> +		return;

Use conventional multi-line comment style.

This test isn't 100%: devices below the bridge could be using only IO,
or theoretically could be even using just config space.

If it's safe to bail out if the bridge is in use, why isn't it safe to
bail out *always*?

>  	b_res[1].flags |= IORESOURCE_MEM;
>  
>  	pci_read_config_word(bridge, PCI_IO_BASE, &io);
> -- 
> MST
