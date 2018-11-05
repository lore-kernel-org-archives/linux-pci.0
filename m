Return-Path: <SRS0=Hm5h=NQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D06E8C0044C
	for <linux-pci@archiver.kernel.org>; Mon,  5 Nov 2018 19:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A19F020685
	for <linux-pci@archiver.kernel.org>; Mon,  5 Nov 2018 19:39:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A19F020685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725774AbeKFFAC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 6 Nov 2018 00:00:02 -0500
Received: from mail.skyhub.de ([5.9.137.197]:38780 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725139AbeKFFAC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Nov 2018 00:00:02 -0500
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3Yg419cShtUj; Mon,  5 Nov 2018 20:38:48 +0100 (CET)
Received: from zn.tnic (p200300EC2BCD5300329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bcd:5300:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3E1A41EC038E;
        Mon,  5 Nov 2018 20:38:48 +0100 (CET)
Date:   Mon, 5 Nov 2018 20:38:40 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Woods, Brian" <Brian.Woods@amd.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Clemens Ladisch <clemens@ladisch.de>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Bjorn Helgaas <bhelgaas@google.com>, Pu Wen <puwen@hygon.cn>,
        Jia Zhang <qianyue.zj@alibaba-inc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 2/4] x86/amd_nb: add support for newer PCI topologies
Message-ID: <20181105193840.GA26868@zn.tnic>
References: <20181102181055.130531-1-brian.woods@amd.com>
 <20181102181055.130531-3-brian.woods@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181102181055.130531-3-brian.woods@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 02, 2018 at 06:11:07PM +0000, Woods, Brian wrote:
> Add support for new processors which have multiple PCI root complexes
> per data fabric/SMN interface.

Please write out abbreviations. I believe it is only you and I who know
what SMN means. :)

> The interfaces per root complex are redundant and should be skipped.

And I believe it is only you who understands that sentence. :)

Please elaborate why interfaces need to be skipped, *which* interfaces
need to be skipped and which is the correct interface to access DF/SMN
through?

> This makes sure the DF/SMN interfaces get accessed via the correct
> root complex.
>
> Ex:
> DF/SMN 0 -> 60
> 	    40
> 	    20
> 	    00
> DF/SMN 1 -> e0
> 	    c0
> 	    a0
> 	    80
> 
> Signed-off-by: Brian Woods <brian.woods@amd.com>
> ---
>  arch/x86/kernel/amd_nb.c | 41 +++++++++++++++++++++++++++++++++++------
>  1 file changed, 35 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
> index 19d489ee2b1e..c0bf26aeb7c3 100644
> --- a/arch/x86/kernel/amd_nb.c
> +++ b/arch/x86/kernel/amd_nb.c
> @@ -213,7 +213,10 @@ int amd_cache_northbridges(void)
>  	const struct pci_device_id *root_ids = amd_root_ids;
>  	struct pci_dev *root, *misc, *link;
>  	struct amd_northbridge *nb;
> -	u16 i = 0;
> +	u16 roots_per_misc = 0;
> +	u16 misc_count = 0;
> +	u16 root_count = 0;
> +	u16 i, j;
>  
>  	if (amd_northbridges.num)
>  		return 0;
> @@ -226,26 +229,52 @@ int amd_cache_northbridges(void)
>  
>  	misc = NULL;
>  	while ((misc = next_northbridge(misc, misc_ids)) != NULL)
> -		i++;
> +		misc_count++;
>  
> -	if (!i)
> +	root = NULL;
> +	while ((root = next_northbridge(root, root_ids)) != NULL)
> +		root_count++;
> +
> +	if (!misc_count)
>  		return -ENODEV;

So you're doing the root_count above but returning in the !misc_count
case. So that root_count iteration was unnecessary work. IOW, you should
keep the misc_count check after its loop.

>  
> -	nb = kcalloc(i, sizeof(struct amd_northbridge), GFP_KERNEL);
> +	if (root_count) {
> +		roots_per_misc = root_count / misc_count;
> +
> +		/*
> +		 * There should be _exactly_ N roots for each DF/SMN
> +		 * interface.
> +		 */
> +		if (!roots_per_misc || (root_count % roots_per_misc)) {
> +			pr_info("Unsupported AMD DF/PCI configuration found\n");
> +			return -ENODEV;
> +		}
> +	}
> +
> +	nb = kcalloc(misc_count, sizeof(struct amd_northbridge), GFP_KERNEL);
>  	if (!nb)
>  		return -ENOMEM;
>  
>  	amd_northbridges.nb = nb;
> -	amd_northbridges.num = i;
> +	amd_northbridges.num = misc_count;
>  
>  	link = misc = root = NULL;
> -	for (i = 0; i != amd_northbridges.num; i++) {
> +	for (i = 0; i < amd_northbridges.num; i++) {
>  		node_to_amd_nb(i)->root = root =
>  			next_northbridge(root, root_ids);
>  		node_to_amd_nb(i)->misc = misc =
>  			next_northbridge(misc, misc_ids);
>  		node_to_amd_nb(i)->link = link =
>  			next_northbridge(link, link_ids);
> +
> +		/*
> +		 * If there are more root devices than data fabric/SMN,
> +		 * interfaces, then the root devices per DF/SMN
> +		 * interface are redundant and N-1 should be skipped so
> +		 * they aren't mapped incorrectly.
> +		 */

This text is trying to explain it a bit better but you still still need
to specify which are the redundant ones. All N-1 or is there a special
root device through which the DF/SMN gets accessed or?

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
