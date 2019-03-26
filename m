Return-Path: <SRS0=/keI=R5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 155BDC43381
	for <linux-pci@archiver.kernel.org>; Tue, 26 Mar 2019 20:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D00AE20896
	for <linux-pci@archiver.kernel.org>; Tue, 26 Mar 2019 20:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553633853;
	bh=UVIbZv9vi6fjHqFOZTEpik2iSB2Wele+O0/BmP1/Bho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EvsOSXEJZof/RJ579auWz6Nxip5r7/vuzuLWiRL+w7jUbetJJBzSu7uZR7aUssnRB
	 h3A7lsKC22fBPeUd7l3Xs1l+7SAjxg+HPbu/wpVcKUIczwa9hJMjmKxddHogYEBm+D
	 KcEZ90TceQxBRIHOkxb+nXdpZLYci4i/J7Owc2OQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732286AbfCZU5d (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 26 Mar 2019 16:57:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:35862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732071AbfCZU5d (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Mar 2019 16:57:33 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39E0B20700;
        Tue, 26 Mar 2019 20:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553633852;
        bh=UVIbZv9vi6fjHqFOZTEpik2iSB2Wele+O0/BmP1/Bho=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wwaQdg5Tkm5eiDnJkbjAwXb+71qowbm+fk/XL3j09t+TWcjK9RaHnygSADkRMkRVK
         L+/bMWAUqXZpuglm8hIxEd1X7kT5akut+DYFjNlfUyOPp24FG2tXBYFLmc3O5m0me/
         N/OuxknkijU066aYKF026FCeJCSk2z2IDQ3E+U/4=
Date:   Tue, 26 Mar 2019 15:57:31 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Cc:     linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux@yadro.com
Subject: Re: [PATCH RFC v4 14/21] PCI: Don't reserve memory for hotplug when
 enabled movable BARs
Message-ID: <20190326205731.GU24180@google.com>
References: <20190311133122.11417-1-s.miroshnichenko@yadro.com>
 <20190311133122.11417-15-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311133122.11417-15-s.miroshnichenko@yadro.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 11, 2019 at 04:31:15PM +0300, Sergey Miroshnichenko wrote:
> pbus_size_mem() returns a precise amount of memory required to fit
> all the requested BARs and windows of children bridges.

Please make the commit log complete in itself, without requiring the
subject.

> Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
> ---
>  drivers/pci/setup-bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 9d93f2b32bf1..f9d605cd1725 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1229,7 +1229,7 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
>  
>  	case PCI_HEADER_TYPE_BRIDGE:
>  		pci_bridge_check_ranges(bus);
> -		if (bus->self->is_hotplug_bridge) {
> +		if (bus->self->is_hotplug_bridge && !pci_movable_bars_enabled()) {
>  			additional_io_size  = pci_hotplug_io_size;
>  			additional_mem_size = pci_hotplug_mem_size;
>  		}
> -- 
> 2.20.1
> 
