Return-Path: <SRS0=ChyX=OI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF03C43441
	for <linux-pci@archiver.kernel.org>; Thu, 29 Nov 2018 15:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABF2021019
	for <linux-pci@archiver.kernel.org>; Thu, 29 Nov 2018 15:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+HmHWbo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABF2021019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbeK3CJO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 29 Nov 2018 21:09:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:59530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728528AbeK3CJN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Nov 2018 21:09:13 -0500
Received: from localhost (173-25-171-118.client.mchsi.com [173.25.171.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1F4A2082F;
        Thu, 29 Nov 2018 15:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543503814;
        bh=z0yA2fmW6AAfQHtJol27Z5D7iiJmpSCaptAauJncejg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E+HmHWbollj651mM4mzzjdQ6LK7rfke2RUFXSrwMsprJaLf9+ge5hshSVeGD7bTaa
         CsvoItf7zbMBzzVJiQDKujmn1XivMm1DOeH5zBL7ccAuZ57OQBW+yB3fM/UdKKrLwe
         2zGjv9qW9nObN5VDmHc4vnc7426gd/7NyYxz8+yA=
Date:   Thu, 29 Nov 2018 09:03:32 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     sundeep subbaraya <sundeep.lkml@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        sean.stalley@intel.com, sgoutham@marvell.com,
        Subbaraya Sundeep <sbhatta@marvell.com>
Subject: Re: [PATCH v2] PCI: assign bus numbers present in EA capability for
 bridges
Message-ID: <20181129150332.GA107073@google.com>
References: <1542633272-16161-1-git-send-email-sundeep.lkml@gmail.com>
 <20181128215545.GC178809@google.com>
 <CALHRZurM1XgwtaLQw2Nqtcb+uX+SY8thgnKDQUzftO9i9a+_RA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALHRZurM1XgwtaLQw2Nqtcb+uX+SY8thgnKDQUzftO9i9a+_RA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 29, 2018 at 07:00:14PM +0530, sundeep subbaraya wrote:
> On Thu, Nov 29, 2018 at 3:25 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Mon, Nov 19, 2018 at 06:44:32PM +0530, sundeep.lkml@gmail.com wrote:
> > > From: Subbaraya Sundeep <sbhatta@marvell.com>
> > >
> > > As per the spec, bridges with EA capability work
> > > with fixed secondary and subordinate bus numbers.
> > > Hence assign bus numbers to bridges from EA if the
> > > capability exists.
> >
> > A reference to the spec section would be good, i.e., PCIe r4.0, sec xxx.
> >
> Ok. I referred ECN 2014 section 6.9.1.2.
> 
> > > Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> > > ---
> > > Changes for v2:
> > >       No changes just added Sean Stalley who did EA support for BARs.
> > >
> > >  drivers/pci/probe.c           | 58 ++++++++++++++++++++++++++++++++++++++++---
> > >  include/uapi/linux/pci_regs.h |  6 +++++
> > >  2 files changed, 60 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > > index b1c05b5..f41d2e6 100644
> > > --- a/drivers/pci/probe.c
> > > +++ b/drivers/pci/probe.c
> > > @@ -1030,6 +1030,40 @@ static void pci_enable_crs(struct pci_dev *pdev)
> > >
> > >  static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
> > >                                             unsigned int available_buses);
> > > +/*
> > > + * pci_ea_fixed_busnrs() - Read fixed Secondary and Subordinate bus
> > > + * numbers from EA capability.
> > > + * @dev: Bridge with EA
> > > + * @secondary: updated with secondary bus number in EA
> > > + * @subordinate: updated with subordinate bus number in EA
> > > + *
> > > + * If it is a bridge with EA capability then fixed bus numbers are
> > > + * read from EA capability list and secondary, subordinate reference
> > > + * variables will be updated. Otherwise secondary and subordinate reference
> > > + * variables will be zeroed.
> > > + */
> > > +static void pci_ea_fixed_busnrs(struct pci_dev *dev, u8 *secondary,
> > > +                             u8 *subordinate)
> > > +{
> > > +     int ea;
> > > +     int offset;
> > > +     u32 dw;
> > > +
> > > +     *secondary = *subordinate = 0;
> > > +
> > > +     if (dev->hdr_type != PCI_HEADER_TYPE_BRIDGE)
> > > +             return;
> > > +
> > > +     /* find PCI EA capability in list */
> > > +     ea = pci_find_capability(dev, PCI_CAP_ID_EA);
> > > +     if (!ea)
> > > +             return;
> > > +
> > > +     offset = ea + PCI_EA_FIRST_ENT;
> > > +     pci_read_config_dword(dev, offset, &dw);
> >
> > "Num Entries" in the first DW of the capability is allowed to be zero,
> > in which case this word (the second DW) is invalid.  [See comments
> > below; this code would be valid based on the 2014 ECN, but not per the
> > 2017 PCIe r4.0 spec]
> >
> Yes but Entries follow after first DW of EA capability for devices and
> after second
> DW for bridges.
> 2014 ECN says for bridges DW2 of EA must be present:
> "For Type 1 functions only, there is a second DW in the capability,
> preceding the first entry.
> This second DW must be included in the Enhanced Allocation Capability
> whenever this
> capability is implemented in a Type 1 Function"
> So for normal device EA DW1, Entries(if any)
> for bridges EA DW1,EA DW2, Entries(if any)
> 
> > It would be much better if this function could be somehow incorporated
> > into pci_ea_init(), which already knows how to parse much of the EA
> > capability.
> >
> I initially thought of this but didn't do it to avoid new members in pci_dev.
> 
> > > +     *secondary =  dw & PCI_EA_SEC_BUS_MASK;
> > > +     *subordinate = (dw & PCI_EA_SUB_BUS_MASK) >> PCI_EA_SUB_BUS_SHIFT;
> > > +}
> > >
> > >  /*
> > >   * pci_scan_bridge_extend() - Scan buses behind a bridge
> > > @@ -1064,6 +1098,8 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
> > >       u16 bctl;
> > >       u8 primary, secondary, subordinate;
> > >       int broken = 0;
> > > +     u8 fixed_sec, fixed_sub;
> > > +     int next_busnr;
> > >
> > >       /*
> > >        * Make sure the bridge is powered on to be able to access config
> > > @@ -1163,17 +1199,25 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
> > >               /* Clear errors */
> > >               pci_write_config_word(dev, PCI_STATUS, 0xffff);
> > >
> > > +             /* read bus numbers from EA */
> > > +             pci_ea_fixed_busnrs(dev, &fixed_sec, &fixed_sub);
> > > +
> > > +             next_busnr = max + 1;
> > > +             /* Use secondary bus number in EA */
> > > +             if (fixed_sec)
> > > +                     next_busnr = fixed_sec;
> > > +
> > >               /*
> > >                * Prevent assigning a bus number that already exists.
> > >                * This can happen when a bridge is hot-plugged, so in this
> > >                * case we only re-scan this bus.
> > >                */
> > > -             child = pci_find_bus(pci_domain_nr(bus), max+1);
> > > +             child = pci_find_bus(pci_domain_nr(bus), next_busnr);
> > >               if (!child) {
> > > -                     child = pci_add_new_bus(bus, dev, max+1);
> > > +                     child = pci_add_new_bus(bus, dev, next_busnr);
> > >                       if (!child)
> > >                               goto out;
> > > -                     pci_bus_insert_busn_res(child, max+1,
> > > +                     pci_bus_insert_busn_res(child, next_busnr,
> > >                                               bus->busn_res.end);
> > >               }
> > >               max++;
> > > @@ -1234,7 +1278,13 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
> > >                       max += i;
> > >               }
> > >
> > > -             /* Set subordinate bus number to its real value */
> > > +             /*
> > > +              * Set subordinate bus number to its real value.
> > > +              * If fixed subordinate bus number exists from EA
> > > +              * capability then use it.
> > > +              */
> > > +             if (fixed_sub)
> > > +                     max = fixed_sub;
> > >               pci_bus_update_busn_res_end(child, max);
> > >               pci_write_config_byte(dev, PCI_SUBORDINATE_BUS, max);
> > >       }
> > > diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> > > index e1e9888..c3d0904 100644
> > > --- a/include/uapi/linux/pci_regs.h
> > > +++ b/include/uapi/linux/pci_regs.h
> > > @@ -372,6 +372,12 @@
> > >  #define PCI_EA_FIRST_ENT_BRIDGE      8       /* First EA Entry for Bridges */
> >
> > You didn't add PCI_EA_FIRST_ENT_BRIDGE (Sean did with f80b0ba95964
> > ("PCI: Add Enhanced Allocation register entries")), but it is unused
> > and I can't match it with anything in the spec (PCIe r4.0, sec 7.8.5).
> >
> > It might be related to the code in pci_ea_init() that skips DWORD 2
> > for type 1 functions.  But I still don't see that in the spec.
> >
> > If it's obsolete, we should remove it (with a separate patch).
> >
> PCI_EA_FIRST_ENT_BRIDGE is not needed we can remove.
> I will send a patch to remove it.
> I will add new members for fixed secondary and subordinate bus numbers in
> pci_dev and make changes as below please let me know it is okay for you:
> @@ -2909,6 +2909,7 @@ void pci_ea_init(struct pci_dev *dev)
>         u8 num_ent;
>         int offset;
>         int i;
> +      u32 dw;
> 
>         /* find PCI EA capability in list */
>         ea = pci_find_capability(dev, PCI_CAP_ID_EA); @@ -2922,9
> +2923,14 @@ void pci_ea_init(struct pci_dev *dev)
>         offset = ea + PCI_EA_FIRST_ENT;
> -       /* Skip DWORD 2 for type 1 functions */
> -       if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE)
> +       /* Note fixed bus numbers for type 1 functions */
> +       if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
> +               pci_read_config_dword(dev, offset, &dw);
> +               dev->fixed_sec_busnr = dw & PCI_EA_FIXED_SEC_BUS;
> +               dev->fixed_sub_busnr = (dw & PCI_EA_FIXED_SUB_BUS) >>
> +                                       PCI_EA_FIXED_SUB_SHIFT;
>                 offset += 4;
> +       }
> 
> > Hmm, I do see this in the ECN dated 23 Oct 2014, sec 6.9.1.2.  But
> > presumably that would be incorporated in PCIe r4.0, which is dated 27
> > Sep 2017.
> >
> > I have no idea what to do with this.  I can't merge this without some
> > clarification here,
> >
> Yeah I see there is no mention of EA for bridges in r4.0.
> Since we check whether the device is bridge or not before reading DW2 of EA
> I guess we are okay.

I don't think so.  We need at least some plan to clarify this in the
spec.  I think Sean is plugged into the PCI-SIG, so maybe he can help
with that?

Bjorn
