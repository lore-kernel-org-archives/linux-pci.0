Return-Path: <SRS0=/keI=R5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 593A4C43381
	for <linux-pci@archiver.kernel.org>; Tue, 26 Mar 2019 20:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25F5720896
	for <linux-pci@archiver.kernel.org>; Tue, 26 Mar 2019 20:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553633917;
	bh=6ujCIOWsOpQAnCiYLQ10EoPrx6oW6RzFQfKyKQYBr2g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fT4wdwtXqJYa9HYTz7C8i2Qf4lWs76yhI3LgYM4mCop2rNcp76k7VUHvg6kIdxYwO
	 4xzfh49NYLi9g5aHLZki0eyKVN16o5+KjhDe6tcqmpAjzfEJljQqPKPyMllMTMkilt
	 8hLJ+4ZNLYYgiFnoVAdjGgiDQGuDAdhwCPcdU/WY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731828AbfCZU6g (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 26 Mar 2019 16:58:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:36214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727997AbfCZU6g (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Mar 2019 16:58:36 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 522B320700;
        Tue, 26 Mar 2019 20:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553633915;
        bh=6ujCIOWsOpQAnCiYLQ10EoPrx6oW6RzFQfKyKQYBr2g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ozo50Idbg48rciW+FqVAefhFQC39nGjXSRfq+wa0KzlDtByMsKO2WUDEekyBnzRac
         IPLlC9jQArhnkUYikTUEVz4uuc6/xnoMTdLwfUSSMq02RLo1mjfl2aHq9RkP42B+KY
         b41arw8i9BtoM2SMSnH4PWm30bJmHD6Uv8+rW/K8=
Date:   Tue, 26 Mar 2019 15:58:32 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Cc:     linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux@yadro.com
Subject: Re: [PATCH RFC v4 15/21] PCI: Allow the failed resources to be
 reassigned later
Message-ID: <20190326205832.GV24180@google.com>
References: <20190311133122.11417-1-s.miroshnichenko@yadro.com>
 <20190311133122.11417-16-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311133122.11417-16-s.miroshnichenko@yadro.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 11, 2019 at 04:31:16PM +0300, Sergey Miroshnichenko wrote:
> Don't lose the size of the requested EP's BAR if it can't be fit
> in a current trial, so this can be retried.

s/EP/device/, since this applies equally to conventional PCI.

> But a failed bridge window must be dropped and recalculated in the
> next trial.
> 
> Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
> ---
>  drivers/pci/setup-bus.c |  3 ++-
>  drivers/pci/setup-res.c | 12 ++++++++++++
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index f9d605cd1725..c1559a4a8564 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -309,7 +309,8 @@ static void assign_requested_resources_sorted(struct list_head *head,
>  						    0 /* don't care */,
>  						    0 /* don't care */);
>  			}
> -			reset_resource(res);
> +			if (!pci_movable_bars_enabled())
> +				reset_resource(res);
>  		}
>  	}
>  }
> diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
> index d8ca40a97693..732d18f60f1b 100644
> --- a/drivers/pci/setup-res.c
> +++ b/drivers/pci/setup-res.c
> @@ -298,6 +298,18 @@ static int _pci_assign_resource(struct pci_dev *dev, int resno,
>  
>  	bus = dev->bus;
>  	while ((ret = __pci_assign_resource(bus, dev, resno, size, min_align))) {
> +		if (pci_movable_bars_enabled()) {
> +			if (resno >= PCI_BRIDGE_RESOURCES &&
> +			    resno <= PCI_BRIDGE_RESOURCE_END) {
> +				struct resource *res = dev->resource + resno;
> +
> +				res->start = 0;
> +				res->end = 0;
> +				res->flags = 0;
> +			}
> +			break;
> +		}
> +
>  		if (!bus->parent || !bus->self->transparent)
>  			break;
>  		bus = bus->parent;
> -- 
> 2.20.1
> 
