Return-Path: <SRS0=Ivhv=RX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B0F0C43381
	for <linux-pci@archiver.kernel.org>; Wed, 20 Mar 2019 22:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 085E7218D4
	for <linux-pci@archiver.kernel.org>; Wed, 20 Mar 2019 22:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553119986;
	bh=G+jCJeiztv5MQ05x6fsnzWCVxnBmXCrPv6xFGNTK3QU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1dImSMgZTNp/dT4TZv5qtg6FYFYknRc5Iuz8reG//0qv543CZK4gtZsfOZ+6ysM2j
	 GHH7YyHcxeQevW153DqqsDTEQZi4Tv5cUHMh0kk1jUt38h75nozDsT6oHNkoHLkuMZ
	 IZhKur7fQmPENPvCfChffTNFXDOmo7Zlq3eUtaTs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbfCTWNA (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 20 Mar 2019 18:13:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:38790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727382AbfCTWNA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 Mar 2019 18:13:00 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FD822175B;
        Wed, 20 Mar 2019 22:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553119979;
        bh=G+jCJeiztv5MQ05x6fsnzWCVxnBmXCrPv6xFGNTK3QU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uJoHSa2v+N2C+2ffE2ZjtdtUHENfqpuZEzkEH/u8U5gq13+AC2fUtHbl70bdiGcTZ
         V6HxB2gV0HLADokaX8AnnvcQWK26UF8/1a9gF9A79LPmG/IIrgqjiRmrToRiYXzs5I
         8yTwiLNrTvvmLECwwdNzUgRwWrlI21XD8SBWiuz0=
Date:   Wed, 20 Mar 2019 17:12:57 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: Re: [PATCH] hotplug/drc-info: ininitialize fndit to zero
Message-ID: <20190320221257.GI251185@google.com>
References: <20190316214016.6612-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190316214016.6612-1-colin.king@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Michael B (original author)]

On Sat, Mar 16, 2019 at 09:40:16PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently variable fndit is not initialized and contains a
> garbage value, later it is set to 1 if a drc entry is found.
> Ensure fndit is not containing garbage by initializing it to
> zero. Also remove an extraneous space at the end of an
> sprintf call.
> 
> Detected by static analysis with cppcheck.
> 
> Fixes: 2fcf3ae508c2 ("hotplug/drc-info: Add code to search ibm,drc-info property")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Michael E, I assume you'll take this since you took the original?
Let me know if you want me to.

> ---
>  drivers/pci/hotplug/rpaphp_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/rpaphp_core.c b/drivers/pci/hotplug/rpaphp_core.c
> index bcd5d357ca23..28213f44f64a 100644
> --- a/drivers/pci/hotplug/rpaphp_core.c
> +++ b/drivers/pci/hotplug/rpaphp_core.c
> @@ -230,7 +230,7 @@ static int rpaphp_check_drc_props_v2(struct device_node *dn, char *drc_name,
>  	struct of_drc_info drc;
>  	const __be32 *value;
>  	char cell_drc_name[MAX_DRC_NAME_LEN];
> -	int j, fndit;
> +	int j, fndit = 0;
>  
>  	info = of_find_property(dn->parent, "ibm,drc-info", NULL);
>  	if (info == NULL)
> @@ -254,7 +254,7 @@ static int rpaphp_check_drc_props_v2(struct device_node *dn, char *drc_name,
>  	/* Found it */
>  
>  	if (fndit)
> -		sprintf(cell_drc_name, "%s%d", drc.drc_name_prefix, 
> +		sprintf(cell_drc_name, "%s%d", drc.drc_name_prefix,
>  			my_index);
>  
>  	if (((drc_name == NULL) ||
> -- 
> 2.20.1
> 
