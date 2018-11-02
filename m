Return-Path: <SRS0=VxNY=NN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D705C32789
	for <linux-pci@archiver.kernel.org>; Fri,  2 Nov 2018 19:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDCB220833
	for <linux-pci@archiver.kernel.org>; Fri,  2 Nov 2018 19:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zwmlpB+Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDCB220833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbeKCFH6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 3 Nov 2018 01:07:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:46112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726106AbeKCFH6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 3 Nov 2018 01:07:58 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B900C2081B;
        Fri,  2 Nov 2018 19:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541188767;
        bh=liSUcXWJy0aGb9Dr/w+lxSwtMCU7z5euI7DsIO4eMFE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zwmlpB+QE650NorjxNp88N+Rj5S/VO1Ufs1j/gr2b6PAh8PVo+HpZdBc3OmoRYDTn
         CCkpYyacrWOKmrtQ9OUOJt9k8jZRsAu94kbIfD20orQjVt8Dj6EmxMZ5Xs1Zt85JuX
         oOs1nOesXo5cekr43z2debVfAARzXPUdu+DCFh3Y=
Date:   Fri, 2 Nov 2018 14:59:25 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Woods, Brian" <Brian.Woods@amd.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Clemens Ladisch <clemens@ladisch.de>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, Pu Wen <puwen@hygon.cn>,
        Jia Zhang <qianyue.zj@alibaba-inc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 2/4] x86/amd_nb: add support for newer PCI topologies
Message-ID: <20181102195925.GB160487@google.com>
References: <20181102181055.130531-1-brian.woods@amd.com>
 <20181102181055.130531-3-brian.woods@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181102181055.130531-3-brian.woods@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 02, 2018 at 06:11:07PM +0000, Woods, Brian wrote:
> Add support for new processors which have multiple PCI root complexes
> per data fabric/SMN interface.  The interfaces per root complex are
> redundant and should be skipped.  This makes sure the DF/SMN interfaces
> get accessed via the correct root complex.

SMN?

> Ex:
> DF/SMN 0 -> 60
> 	    40
> 	    20
> 	    00
> DF/SMN 1 -> e0
> 	    c0
> 	    a0
> 	    80

This isn't my code, and I'm not really objecting to these changes, but
from where I sit, the fact that you need this sort of vendor-specific
topology discovery is a little bit ugly and seems like something of a
maintenance issue.  You could argue that this is sort of an "AMD CPU
driver", which is entitled to be device-specific, and that does make
some sense.

But device-specific code is typically packaged as a driver that uses
driver registration interfaces like acpi_bus_register_driver(),
pci_register_driver(), etc.  That gives you a consistent structure
and, more importantly, a framework for dealing with hotplug.  It
doesn't look like amd_nb.c would deal well with hot-add of CPUs.

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
> +		for (j = 1; j < roots_per_misc; j++)
> +			root = next_northbridge(root, root_ids);
>  	}
>  
>  	if (amd_gart_present())
> -- 
> 2.11.0
> 
