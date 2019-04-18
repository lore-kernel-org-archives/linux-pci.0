Return-Path: <SRS0=Hy4z=SU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46585C10F0E
	for <linux-pci@archiver.kernel.org>; Thu, 18 Apr 2019 16:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 169372186A
	for <linux-pci@archiver.kernel.org>; Thu, 18 Apr 2019 16:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555605231;
	bh=PAZCy3lQJR5oEs7azLlYC4Bp6r7sXEjhGmfi4X8D5/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tbnMwVGSaowmnbAPlyGYKE+OUNL/Loa1jQ8UBEC8sUTsgG0IQ2h0mJAPJSQwOaJpF
	 2/s2nL12uScxgHPnBaBCUpmd48MJRuxJY3H5rxOr3Uy2Tr+FglbR71Zxkw3CrGZ0h7
	 0Xk98280ebX73nKlVVQGrneWWNOPswVfPtRBjuTQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388346AbfDRQdu (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 18 Apr 2019 12:33:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:41872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388299AbfDRQdu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Apr 2019 12:33:50 -0400
Received: from localhost (odyssey.drury.edu [64.22.249.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99FBB218A1;
        Thu, 18 Apr 2019 16:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555605228;
        bh=PAZCy3lQJR5oEs7azLlYC4Bp6r7sXEjhGmfi4X8D5/4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E/jNVWLrhxH8VT21A+VS8mSaG5b6bYAYGua7VgKSTcXhJpQibpVPOZlbpeVVmoGCz
         CM4/9InLiyBGgjB8rtFZZOrMhhpaOhLF86cIq/PaQGIFWsSFAsPSTtbue8Xm6JsvRX
         cvlxyuu5yKxCu6uFJWrYzhHnAYCTOFfWwbjVpcTI=
Date:   Thu, 18 Apr 2019 11:33:47 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Christian =?iso-8859-1?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>
Cc:     logang@deltatee.com, rdunlap@infradead.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/P2PDMA: start with a whitelist for root complexes
Message-ID: <20190418163347.GA213349@google.com>
References: <20190418115859.2394-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190418115859.2394-1-christian.koenig@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 18, 2019 at 01:58:59PM +0200, Christian König wrote:
> A lot of root complexes can still do P2P even when PCI devices
> don't share a common upstream bridge.
> 
> Start adding a whitelist and allow P2P if both participants are
> attached to known good root complex.

Is there a plan for addressing this in a generic way that doesn't
require an OS modification for every new "known good root complex",
e.g., some PCIe or ACPI spec update that allows the OS to discover
this?

> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>  drivers/pci/p2pdma.c | 38 +++++++++++++++++++++++++++++++++++---
>  1 file changed, 35 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index c52298d76e64..212baaa7f93b 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -274,6 +274,31 @@ static void seq_buf_print_bus_devfn(struct seq_buf *buf, struct pci_dev *pdev)
>  	seq_buf_printf(buf, "%s;", pci_name(pdev));
>  }
>  
> +/*
> + * If we can't find a common upstream bridge take a look at the root complex and
> + * compare it to a whitelist of known good hardware.
> + */
> +static bool root_complex_whitelist(struct pci_dev *dev)
> +{
> +	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
> +	struct pci_dev *root = pci_get_slot(host->bus, PCI_DEVFN(0, 0));
> +	unsigned short vendor, device;
> +
> +	if (!root)
> +		return false;
> +
> +	vendor = root->vendor;
> +	device = root->device;
> +	pci_dev_put(root);
> +
> +	/* AMD ZEN host bridges can do peer to peer */
> +	if (vendor == PCI_VENDOR_ID_AMD && device == 0x1450)
> +		return true;
> +
> +	/* TODO: Extend that to a proper whitelist */
> +	return false;
> +}
> +
>  /*
>   * Find the distance through the nearest common upstream bridge between
>   * two PCI devices.
> @@ -317,13 +342,13 @@ static void seq_buf_print_bus_devfn(struct seq_buf *buf, struct pci_dev *pdev)
>   * In this case, a list of all infringing bridge addresses will be
>   * populated in acs_list (assuming it's non-null) for printk purposes.
>   */
> -static int upstream_bridge_distance(struct pci_dev *a,
> -				    struct pci_dev *b,
> +static int upstream_bridge_distance(struct pci_dev *provider,
> +				    struct pci_dev *client,
>  				    struct seq_buf *acs_list)
>  {
> +	struct pci_dev *a = provider, *b = client, *bb;
>  	int dist_a = 0;
>  	int dist_b = 0;
> -	struct pci_dev *bb = NULL;
>  	int acs_cnt = 0;
>  
>  	/*
> @@ -354,6 +379,13 @@ static int upstream_bridge_distance(struct pci_dev *a,
>  		dist_a++;
>  	}
>  
> +	/* Allow the connection if both devices are on a whitelisted root
> +	 * complex, but add an arbitary large value to the distance.
> +	 */
> +	if (root_complex_whitelist(provider) &&
> +	    root_complex_whitelist(client))
> +		return 0x1000 + dist_a + dist_b;
> +
>  	return -1;
>  
>  check_b_path_acs:
> -- 
> 2.17.1
> 
