Return-Path: <SRS0=Hy4z=SU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1142C10F0E
	for <linux-pci@archiver.kernel.org>; Thu, 18 Apr 2019 23:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E23E217FA
	for <linux-pci@archiver.kernel.org>; Thu, 18 Apr 2019 23:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555629428;
	bh=Z6C9UqrhJQ85tkkdKAI3DqslSUOVOJNtpbq7V9arSwU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kSc2Cxafyv7SAKRDi/RmJPdmiC178MsEcm2ZzONVX3h125tZ5gOtKFlzy20Bs4VSR
	 gsr6B4Lh9p3B1XV7WyDgltQoVUv8RtH54/ZM0qndH/rmU9Cmbb5f6ztQHkbDlJVPlB
	 d3uSGzIPReSnnQ2fyhhKC0syiR3OcDnGKNLWFf0g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbfDRXRH (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 18 Apr 2019 19:17:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:56212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbfDRXRH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Apr 2019 19:17:07 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F9C321479;
        Thu, 18 Apr 2019 23:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555629426;
        bh=Z6C9UqrhJQ85tkkdKAI3DqslSUOVOJNtpbq7V9arSwU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kf+H+8l0pk7iF9I6szYOpjDcdOpnwnOJ/CB8Tg8UtxB08mnDO+mnKBRuxhV09J+u/
         0J6JtG0y2ZQEe/FeX2oCB1hJukoUBIF7GhiMT6TPU/CpK6LV6zlTMQhpsWvI/M+jJc
         4VyU75oQfpKedaS+qPXFrOHCqb7a/iVFeQGIE/kw=
Date:   Thu, 18 Apr 2019 18:17:04 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Nicolas Chauvet <kwizart@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: disable nv_msi_ht_cap_quirk_leaf quirk on arm/arm64
Message-ID: <20190418231704.GD126710@google.com>
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

Also interesting that Nicolas' original patch took this quirk
completely out of the picture for ARM/ARM64, while your patch actively
disables HT MSI mapping if there's no HT host bridge.

If HT MSI Mapping Capability is enabled, the device is supposed to map
MSIs into HyperTransport interrupt messages (HyperTransport I/O Link
spec r3.10e, sec 7.12).  I don't know what that even means if the
device is on a PCIe link instead of an HT chain.

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


