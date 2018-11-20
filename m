Return-Path: <SRS0=4GJS=N7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F48AC28CF8
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 15:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E5A820851
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 15:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GjfooLZt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E5A820851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbeKUBmn (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Nov 2018 20:42:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:59702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbeKUBmn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Nov 2018 20:42:43 -0500
Received: from localhost (173-25-171-118.client.mchsi.com [173.25.171.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72037206BA;
        Tue, 20 Nov 2018 15:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542726785;
        bh=guKcLinyXsRXGX8eBh2sdUxkgj/JMgzol82PTdVEFbg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GjfooLZtAPCh3yQPt87WmStx0h33N9P+mh6dByIL6ecBWyoBn48Tb+wmCa2aTplKw
         a3SSfDEcvd/GAY2h7zWkRz1A/vRyVPM36YZKPCED+oHkMnJHBawTguykMPTevQdp5c
         A2BstTISGuPbL33Of+1nmt82x+TrSK5YgEs0m1OU=
Date:   Tue, 20 Nov 2018 09:13:03 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     mpatocka@redhat.com, Linux PCI <linux-pci@vger.kernel.org>,
        talgi@mellanox.com, tariqt@mellanox.com,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] pci: fix incorrect value returned from pcie_get_speed_cap
Message-ID: <20181120151303.GB191199@google.com>
References: <alpine.LRH.2.02.1810301232310.23106@file01.intranet.prod.int.rdu2.redhat.com>
 <20181120004704.GA191199@google.com>
 <CADnq5_OjN8jaxr9SsSgLxeUvOcZoxY401pg732QoXxJjtUiCuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADnq5_OjN8jaxr9SsSgLxeUvOcZoxY401pg732QoXxJjtUiCuw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 20, 2018 at 09:17:52AM -0500, Alex Deucher wrote:
> On Mon, Nov 19, 2018 at 7:47 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Tue, Oct 30, 2018 at 12:36:08PM -0400, Mikulas Patocka wrote:
> > > The macros PCI_EXP_LNKCAP_SLS_*GB are values, not bit masks. We must mask
> > > the register and compare it against them.
> > >
> > > This patch fixes errors "amdgpu: [powerplay] failed to send message 261
> > > ret is 0" errors when PCIe-v3 card is plugged into PCIe-v1 slot, because
> > > the slot is being incorrectly reported as PCIe-v3 capable.
> > >
> > > Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> > > Fixes: 6cf57be0f78e ("PCI: Add pcie_get_speed_cap() to find max supported link speed")
> > > Cc: stable@vger.kernel.org    # v4.17+
> > >
> > > ---
> > >  drivers/pci/pci.c |    8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > >
> > > Index: linux-4.19/drivers/pci/pci.c
> > > ===================================================================
> > > --- linux-4.19.orig/drivers/pci/pci.c 2018-10-30 16:58:58.000000000 +0100
> > > +++ linux-4.19/drivers/pci/pci.c      2018-10-30 16:58:58.000000000 +0100
> > > @@ -5492,13 +5492,13 @@ enum pci_bus_speed pcie_get_speed_cap(st
> > >
> > >       pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
> > >       if (lnkcap) {
> > > -             if (lnkcap & PCI_EXP_LNKCAP_SLS_16_0GB)
> > > +             if ((lnkcap & PCI_EXP_LNKCAP_SLS) == PCI_EXP_LNKCAP_SLS_16_0GB)
> > >                       return PCIE_SPEED_16_0GT;
> > > -             else if (lnkcap & PCI_EXP_LNKCAP_SLS_8_0GB)
> > > +             else if ((lnkcap & PCI_EXP_LNKCAP_SLS) == PCI_EXP_LNKCAP_SLS_8_0GB)
> > >                       return PCIE_SPEED_8_0GT;
> > > -             else if (lnkcap & PCI_EXP_LNKCAP_SLS_5_0GB)
> > > +             else if ((lnkcap & PCI_EXP_LNKCAP_SLS) ==PCI_EXP_LNKCAP_SLS_5_0GB)
> > >                       return PCIE_SPEED_5_0GT;
> > > -             else if (lnkcap & PCI_EXP_LNKCAP_SLS_2_5GB)
> > > +             else if ((lnkcap & PCI_EXP_LNKCAP_SLS) == PCI_EXP_LNKCAP_SLS_2_5GB)
> > >                       return PCIE_SPEED_2_5GT;
> > >       }
> > >
> >
> > I'd like to apply this as below, where I removed the 8_0GB and 16_0GB
> > cases as recommended by the spec.  I can't test it myself, and the
> > bugzillas don't contain enough information for me to confirm that the
> > patch below is enough (the "lspci -vv" output of the root port and GPU
> > is what I would need).
> >
> > I'm confused about the fact that 6cf57be0f78e appeared in v4.17, but
> > v4.18 works fine according to both bugzillas.
> 
> This issue affects AMD GPUs because we switched from using an open
> coded check for pcie link speeds in the driver to using the common
> pcie variants in
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v4.19&id=5d9a6330403271fbb1244f14380a7cc44662796f

OK, thanks.  I added that SHA1 and a note to explain the connection.

> The patch below would regress performance, at least on AMD GPUs, since
> we'd end up reporting a max speed of gen 2 (5 GT/s) which would cause
> the driver to limit the speed to gen2 even if gen3 or 4 are available.

I guess this means these parts are broken with respect to the spec,
since they support gen3 speeds but don't implement LnkCap2?

Gen2, i.e., PCIe r2.1, only defined 2.5 GT/s and 5 GT/s.  Devices
capable of the higher speeds added by PCIe r3.0 are supposed to
implement LnkCap2, but if we're even getting to this code, it means
LnkCap2 was zero.

If we confirm that this is a device defect, the question is what the
best way to work around it is.  Probably the original patch is easier
than some sort of quirk, but we'd need to expand the comment a little
bit to explain why we're not following the spec recommendation.

It looks like lspci probably also needs some updating here -- it
currently doesn't do anything at all with LnkCap2.

> > I also don't have a good feel for whether this is urgent enough to be
> > a v4.20 fix or whether it can wait for v4.21.  Evidence either way
> > would help.
> 
> I'd like it to land for 4.19 and 4.20 at least.  Alternatively, we
> could revert all of the drm patches to and bring back all the open
> coded implementations, but it's a fairly large number of patches to
> revert.

OK, sounds like it makes sense to do this for v4.20 and backport it at
least to v4.19 stable.  I do want to get the places below fixed also.
They may not be as urgent, but we might as well try and make
everything consistent while we're looking at it.

> > We also need similar fixes in pci_set_bus_speed(), pcie_speeds()
> > (hfi1), cobalt_pcie_status_show(), hba_ioctl_callback(),
> > qla24xx_pci_info_str(), and maybe a couple other places.
> >
> > Bjorn
> >
> >
> > commit 871f73abf4b8e6aee8a206775f944ede7c7d7250
> > Author: Mikulas Patocka <mpatocka@redhat.com>
> > Date:   Tue Oct 30 12:36:08 2018 -0400
> >
> >     PCI: Fix incorrect value returned from pcie_get_speed_cap()
> >
> >     The macros PCI_EXP_LNKCAP_SLS_*GB are values, not bit masks.  We must mask
> >     the register and compare it against them.
> >
> >     This patch fixes errors "amdgpu: [powerplay] failed to send message 261 ret
> >     is 0" errors when PCIe-v3 card is plugged into PCIe-v1 slot, because the
> >     slot is being incorrectly reported as PCIe-v3 capable.
> >
> >     Fixes: 6cf57be0f78e ("PCI: Add pcie_get_speed_cap() to find max supported link speed")
> >     Link: https://bugs.freedesktop.org/show_bug.cgi?id=108704
> >     Link: https://bugs.freedesktop.org/show_bug.cgi?id=108778
> >     Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> >     [bhelgaas: update comment, remove use of PCI_EXP_LNKCAP_SLS_8_0GB and
> >     PCI_EXP_LNKCAP_SLS_16_0GB since those should be covered by PCI_EXP_LNKCAP2]
> >     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> >     Acked-by: Alex Deucher <alexander.deucher@amd.com>
> >     Cc: stable@vger.kernel.org      # v4.17+
> >
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index d068f11d08a7..8563d1d9b102 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -5556,9 +5556,13 @@ enum pci_bus_speed pcie_get_speed_cap(struct pci_dev *dev)
> >         u32 lnkcap2, lnkcap;
> >
> >         /*
> > -        * PCIe r4.0 sec 7.5.3.18 recommends using the Supported Link
> > -        * Speeds Vector in Link Capabilities 2 when supported, falling
> > -        * back to Max Link Speed in Link Capabilities otherwise.
> > +        * Link Capabilities 2 was added in PCIe r3.0, sec 7.8.18.  The
> > +        * implementation note there recommends using the Supported Link
> > +        * Speeds Vector in Link Capabilities 2 when supported.
> > +        *
> > +        * Without Link Capabilities 2, i.e., prior to PCIe r3.0, software
> > +        * should use the Supported Link Speeds field in Link Capabilities,
> > +        * where only 2.5 GT/s and 5.0 GT/s speeds were defined.
> >          */
> >         pcie_capability_read_dword(dev, PCI_EXP_LNKCAP2, &lnkcap2);
> >         if (lnkcap2) { /* PCIe r3.0-compliant */
> > @@ -5575,13 +5579,9 @@ enum pci_bus_speed pcie_get_speed_cap(struct pci_dev *dev)
> >
> >         pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
> >         if (lnkcap) {
> > -               if (lnkcap & PCI_EXP_LNKCAP_SLS_16_0GB)
> > -                       return PCIE_SPEED_16_0GT;
> > -               else if (lnkcap & PCI_EXP_LNKCAP_SLS_8_0GB)
> > -                       return PCIE_SPEED_8_0GT;
> > -               else if (lnkcap & PCI_EXP_LNKCAP_SLS_5_0GB)
> > +               if ((lnkcap & PCI_EXP_LNKCAP_SLS) == PCI_EXP_LNKCAP_SLS_5_0GB)
> >                         return PCIE_SPEED_5_0GT;
> > -               else if (lnkcap & PCI_EXP_LNKCAP_SLS_2_5GB)
> > +               else if ((lnkcap & PCI_EXP_LNKCAP_SLS) == PCI_EXP_LNKCAP_SLS_2_5GB)
> >                         return PCIE_SPEED_2_5GT;
> >         }
> >
