Return-Path: <SRS0=PPlZ=SV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23BB8C282DA
	for <linux-pci@archiver.kernel.org>; Fri, 19 Apr 2019 19:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E001620854
	for <linux-pci@archiver.kernel.org>; Fri, 19 Apr 2019 19:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555701557;
	bh=N4uSEXgkJLE08820e9yGWuIVOHsRT3XZtzmn5IYRXSA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DNegmb2rps4ogbA2FB6ESLLODfawkGUtsRJ4F1anCizCp6ue+Ao5ScqmlQLjPucuD
	 0p3Kn7qs995OdD5u184DfQSDuhv3aN5JqMHTuChZQksXcJxaziTkV7gtYcTMdaoNQX
	 a2Up8/21DnGkOrDz2eklegT3DlqyVv5a8h2J6VWQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbfDSTTQ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:19:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:45772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbfDSTTQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Apr 2019 15:19:16 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AD0520693;
        Fri, 19 Apr 2019 19:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555701554;
        bh=N4uSEXgkJLE08820e9yGWuIVOHsRT3XZtzmn5IYRXSA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eHQtWlhRr1TSoErmOR6uoqNYh8WV+aW/LwovWGqhBSDUUkgV2tJqHHzwtmmeonevJ
         joPHbutik3QYnWhbKsfCaXD1BhG3Cczp9ECGsGGjjeiFfhkhwyQvfcQs2IFwarJY6d
         +Qmvl7G1RQtdrBpJ46WybJNibzQ970XCR0/pT0Ew=
Date:   Fri, 19 Apr 2019 14:19:12 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Christian =?iso-8859-1?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>
Cc:     logang@deltatee.com, rdunlap@infradead.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/P2PDMA: start with a whitelist for root complexes
Message-ID: <20190419191912.GG173520@google.com>
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
> 
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

The fact that 00.0 is a host bridge and that its vendor/device ID
tells us whether peer-to-peer is supported between two *other* devices
(provider and client) is all totally vendor-specific.  There's nothing
in the PCI specs that says the host bridge even has to exist as a PCI
device.

Is there any chance you could identify it by the Root Port
vendor/device instead of groping around for the 00:0 device?  That
would have been simpler, so I suppose that doesn't work for some
reason.

I'm surprised that you don't need both the provider and the client to
figure this out.  Wouldn't it would be possible to have two Root Ports
under host bridge A that could do peer-to-peer to each other, but not
to a Root Port under host bridge B?  E.g., I'd think you would need
something like this:

  if (pci_find_host_bridge(a->bus) == pci_find_host_bridge(b->bus) &&
      a->vendor == PCI_VENDOR_ID_AMD &&
      b->vendor == PCI_VENDOR_ID_AMD &&
      a->device == X &&
      b->device == X)
        return true;

  return false;

But I guess that still implicitly relies on the notion that everything
under one PNP0A03 device is potentially connected via P2P, and I don't
think there's anything the PCI or ACPI specs that would support that.

Maybe we should add a pci_dev.p2p_group and make it so "a.p2p_group ==
b.p2p_group" means that P2P is possible between them.  You'd have to
have a quirk for the root ports to initialize p2p_group using whatever
vendor-specific information you need, then everything under them could
inherit from the parent.

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
