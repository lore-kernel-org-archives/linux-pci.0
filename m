Return-Path: <SRS0=Hy4z=SU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA9AC10F0E
	for <linux-pci@archiver.kernel.org>; Thu, 18 Apr 2019 22:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A05A21479
	for <linux-pci@archiver.kernel.org>; Thu, 18 Apr 2019 22:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555628195;
	bh=jwShYleCV5i5RKIjcQ9iqMlWCmfob/OykEZiJ7IT3Zk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0668frUtOSAHw/oIJINNMty+76oxnv0u/tGzD75T3P2yEDKGkznJ5LhJuAnmbQinV
	 D0APifq0kQK+sx3YiQ20cwuQuOXH2PMXIaAOVsq6pHxZuk32fN5U1snfV/fOJlMEZX
	 tuYk3AyZERFEx5vE2PBWKqMb22TTKjyp5SFrP1W8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725874AbfDRW4e (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 18 Apr 2019 18:56:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:47922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbfDRW4e (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Apr 2019 18:56:34 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED4D320869;
        Thu, 18 Apr 2019 22:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555628192;
        bh=jwShYleCV5i5RKIjcQ9iqMlWCmfob/OykEZiJ7IT3Zk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0Rne/mAw/zl9wXT5DM4Y61AuEBOQFJWqkSFWZ85DCXvUoACO/cUt0gtV31unRjIJ8
         LVcqZMuGIrguqjE3zXaYfwsllMwsdUQoYqcD4I8A3aFVo/TqyzKoBnyZyvw8KulW3/
         0Mw9l6qhslKX/8DYA76odIt2uL42saIsIah0Fdec=
Date:   Thu, 18 Apr 2019 17:56:27 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Nicolas Chauvet <kwizart@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: disable nv_msi_ht_cap_quirk_leaf quirk on arm/arm64
Message-ID: <20190418225627.GC126710@google.com>
References: <20180730094213.11973-1-kwizart@gmail.com>
 <20190415092537.14305-1-kwizart@gmail.com>
 <20190415134813.GA111421@google.com>
 <20190416113504.GG10907@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416113504.GG10907@ulmo>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 16, 2019 at 01:35:04PM +0200, Thierry Reding wrote:
> On Mon, Apr 15, 2019 at 08:48:13AM -0500, Bjorn Helgaas wrote:
> > On Mon, Apr 15, 2019 at 11:25:37AM +0200, Nicolas Chauvet wrote:
> > > This patch disable the use of nv_msi_ht_cap_quirk_leaf quirk on arm and
> > > arm64 NVIDIA devices such as Tegra
> > > 
> > > This fixes the following output:
> > > "pci 0000:00:01.0: nv_msi_ht_cap_quirk didn't locate host bridge"
> > > as experienced on a Trimslice device with PCI host bridge enabled
> > > 
> > > v3: exclude the quirk for arm and arm64 instead of only for x86
> > > 
> > > v2: use __maybe_unused to avoid a warning on nv_msi_ht_cap_quirk_leaf
> > > 
> > > Signed-off-by: Nicolas Chauvet <kwizart@gmail.com>
> > > Reviewed-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> > > Acked-by: Thierry Reding <treding@nvidia.com>
> > > ---
> > >  drivers/pci/quirks.c | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > > index a59ad09ce911..1ac65f09d7ee 100644
> > > --- a/drivers/pci/quirks.c
> > > +++ b/drivers/pci/quirks.c
> > > @@ -2811,12 +2811,15 @@ static void nv_msi_ht_cap_quirk_all(struct pci_dev *dev)
> > >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AL, PCI_ANY_ID, nv_msi_ht_cap_quirk_all);
> > >  DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_AL, PCI_ANY_ID, nv_msi_ht_cap_quirk_all);
> > >  
> > > -static void nv_msi_ht_cap_quirk_leaf(struct pci_dev *dev)
> > > +static void __maybe_unused nv_msi_ht_cap_quirk_leaf(struct pci_dev *dev)
> > >  {
> > >  	return __nv_msi_ht_cap_quirk(dev, 0);
> > >  }
> > > +/* HyperTransport is not relevant on theses arches */
> > > +#if !IS_ENABLED(CONFIG_ARM) && !IS_ENABLED(CONFIG_ARM64)
> > 
> > I don't see any of the previous versions or discussion on the list, so
> > I can't tell what led to this #ifdef, but I'd prefer to avoid #ifdefs
> > like this because they're checking for arch at the wrong level.
> > 
> > If you're seeing that warning message, apparently your system contains
> > an Nvidia device that has an HT_CAPTYPE_MSI_MAPPING capability, so
> > HyperTransport is at least in the picture, even on arm/arm64.
> > 
> > The quirk assumes a host bridge at 00:00.0, which is really a
> > device-specific assumption, or maybe something specific to
> > HyperTransport.  It's certainly not required by the PCI specs, which
> > don't require a host bridge to be visible as a PCI device at all.
> > 
> > I'd be tempted to just change that pci_warn() to a pci_info() or maybe
> > even remove it altogether.  It would be nice to have the complete
> > "lspci -vv" and dmesg log archived for future reference, since this
> > quirk has such a broad reach (matching PCI_ANY_ID) and it has a long
> > and ugly history already.
> 
> I've been thinking about this a bit and it seems to me like the
> intention of the quirk is to make sure that all devices have their HT
> MSI mapping capabilities disabled if the system doesn't support HT.
> As you said, the fact that a host bridge may not be present isn't an
> error, however, it also means that we have to assume that HT is not
> supported in such cases and make sure the HT MSI mapping capability gets
> disabled for all devices.
> 
> The following patch tries to address this and gets rid of the warning on
> Tegra systems.

One thing I still don't understand here is whether this quirk is
actually for a defect in Nvidia and ALi endpoints, or if it's related
to an issue in certain host bridges, or if it's just a generic
HT-related thing that's correctly implemented in hardware but Linux
doesn't know how to deal with.

Having this quirk run forever and ever on every Nvidia and ALI
endpoint just seems like massive overkill.

We assume a host bridge must be xxxx:00:00.0, which I don't think is
true in HT.  __nv_msi_ht_cap_quirk() doesn't look at the topology at
all, so it apparently assumes any device in domain xxxx with an HT MSI
capability must be part of the xxxx:00:00.0 HT hierarchy.  I don't
think that's true either.

It seems like what we really want to do is look for HT_CAPTYPE_SLAVE
in generic code for every device we enumerate and set an "ht_tree" bit
in its pci_dev if we find it.  Then inherit that for all children, and
use that to enable/disable HT MSI mapping.

I bet there's no actual hardware defect here that we're working
around.  I suspect this could all be done in generic code as above.
Maybe we think we only need this for Nvidia/ALi because of differences
in how BIOS leaves things set up.  And that probably depends mostly on
the host bridge, not the endpoints that the quirks apply to.

Sigh.  I suppose it's probably not worth trying to unravel all this at
this stage of the game.  The commits below have lots of interesting
information if anybody *were* to dig into this:

  de7453065d5d ("PCI: don't enable too much HT MSI mapping")
  1dec6b054dd1 ("PCI: don't enable too many HT MSI mappings")
  439a7733e8fc ("PCI: enable nv_msi_ht_cap_quirk for ALi bridges")
  9dc625e72309 ("PCI: quirks: set 'En' bit of MSI Mapping for devices onHT-based nvidia platform")
  6bae1d96c6d7 ("PCI: quirk: enable MSI Mapping on HT1000")
  1d84b5424efb ("PCI: Add MSI quirk for ServerWorks HT1000 PCIX bridge.")
  e3008dedff4b ("PCI: disable MSI by default on systems with Serverworks HT1000 chips")
  6397c75cbc4d ("MSI: Blacklist PCI-E chipsets depending on Hypertransport MSI capability")

Bjorn

> --- >8 ---
> From 69fb3b269cc852964385436694d79765d5c1cab3 Mon Sep 17 00:00:00 2001
> From: Thierry Reding <treding@nvidia.com>
> Date: Tue, 16 Apr 2019 13:27:53 +0200
> Subject: [PATCH] PCI: Be less noisy if no HT host bridge exists
> 
> Embedded systems will typically not expose a host bridge's configuration
> space, so such setups must be assumed not to support HyperTransport, and
> consequently the HT MSI mapping capability should be disabled for all
> devices.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/pci/quirks.c | 34 +++++++++++++++++++---------------
>  1 file changed, 19 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index f9cd4d432e05..705891c88073 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -2792,24 +2792,28 @@ static void __nv_msi_ht_cap_quirk(struct pci_dev *dev, int all)
>  	 */
>  	host_bridge = pci_get_domain_bus_and_slot(pci_domain_nr(dev->bus), 0,
>  						  PCI_DEVFN(0, 0));
> -	if (host_bridge == NULL) {
> -		pci_warn(dev, "nv_msi_ht_cap_quirk didn't locate host bridge\n");
> -		return;
> -	}
> -
> -	pos = pci_find_ht_capability(host_bridge, HT_CAPTYPE_SLAVE);
> -	if (pos != 0) {
> -		/* Host bridge is to HT */
> -		if (found == 1) {
> -			/* it is not enabled, try to enable it */
> -			if (all)
> -				ht_enable_msi_mapping(dev);
> -			else
> -				nv_ht_enable_msi_mapping(dev);
> +	if (host_bridge) {
> +		pos = pci_find_ht_capability(host_bridge, HT_CAPTYPE_SLAVE);
> +		if (pos != 0) {
> +			/* Host bridge is to HT */
> +			if (found == 1) {
> +				/* it is not enabled, try to enable it */
> +				if (all)
> +					ht_enable_msi_mapping(dev);
> +				else
> +					nv_ht_enable_msi_mapping(dev);
> +			}
> +			goto out;
>  		}
> -		goto out;
>  	}
>  
> +	/*
> +	 * Some systems, such as embedded devices, may not expose the host
> +	 * bridge's configuration space. Assume such systems to not support
> +	 * HyperTransport and disable the HT MSI mapping capability for all
> +	 * devices.
> +	 */
> +
>  	/* HT MSI is not enabled */
>  	if (found == 1)
>  		goto out;
> -- 
> 2.21.0
> 


