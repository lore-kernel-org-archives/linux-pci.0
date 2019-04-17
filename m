Return-Path: <SRS0=SWM8=ST=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9107CC282DA
	for <linux-pci@archiver.kernel.org>; Wed, 17 Apr 2019 18:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C84D206BA
	for <linux-pci@archiver.kernel.org>; Wed, 17 Apr 2019 18:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LsMOCd6N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729512AbfDQSdT (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 17 Apr 2019 14:33:19 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41309 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728373AbfDQSdT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Apr 2019 14:33:19 -0400
Received: by mail-lj1-f193.google.com with SMTP id k8so23402886lja.8
        for <linux-pci@vger.kernel.org>; Wed, 17 Apr 2019 11:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o3pyyLNaVKG6Pw5EDNPn0DZOB4FdoounuxmUdJ+U49k=;
        b=LsMOCd6Nvtvq4IviDMSIafRizFm2QAD2DM2tp9l+xt7Dhq4JfgmGaJ2DMVNThhj7sv
         0AnEduqKeYWOCwDoRlR7kyTd0pBCwqag1DyrQiFWuNN4+S+XREaLKVrZo5y4YULzhgfh
         Gz7oax5BQntag7uIDf42a3wL9lrIKhKe/klLcaFdQNHKYFDsRG3ZZu9YciqgkfuX54W5
         o2JELCywWjd6x7aM/4j3oXwBqbZuo495jR6327mp5/ckU2wuROsbRDaqyiiBs/GiWILk
         Rg0ku48bqmji4mECB6tU2K6aQNe72WL8wEE6S8+Z5nfO5U5XsUzhNlyHKqH4n5BEAX8L
         d4sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o3pyyLNaVKG6Pw5EDNPn0DZOB4FdoounuxmUdJ+U49k=;
        b=S/GOJy09zZi4U5kmSR8ydqoo+l+kZtBNrNwFwtICmoAnwbKPaG6Wo/0YGHEDJbwVae
         az05ByMBiRs6vcladIOEGlpy/sIUVc4x8tIGWCelocCtI7Gr9RIIVcCR+6nitIMqCE/l
         B5ZeeAhz8CAiMcNyQ0d9dm1YyGnQ6XcQdamamafEtXC4CG0P5HU5CBitUNFo3ukaN9NT
         iUUlWRu0HvuAP3YBSqOeEetzbGEESmqRspq1qw4oJ+q2KNQ0hvpNAPi4pjYypss8EycQ
         N8WnaQvaWRibAN34VGT3Bz8z36lyPuRhIleF3EtBoGLMMqit7jxMlUBjOB+wBDGeXMap
         uNrw==
X-Gm-Message-State: APjAAAXm30cxO2R0E1w/zH2a6x+6g+Knoe+reCiJfnhgkRknjYJu6bY4
        PsgP7gJunQoff59pPeDvCRDtTNcVRbI6mgg7WIR8Gg==
X-Google-Smtp-Source: APXvYqyHswoIMiOsEYx3mOwcsph1ybFYiTdqaz1EtFknUGCajIHtk5ztKIqEJSpEjlmT9krVHwx1iBVVw+V5BKza1l4=
X-Received: by 2002:a2e:9719:: with SMTP id r25mr8472240lji.29.1555525997243;
 Wed, 17 Apr 2019 11:33:17 -0700 (PDT)
MIME-Version: 1.0
References: <3399add0-39da-3711-2614-80f611c2d5db@broadcom.com> <20190417134900.GA235813@google.com>
In-Reply-To: <20190417134900.GA235813@google.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Wed, 17 Apr 2019 11:32:39 -0700
Message-ID: <CACK8Z6G2z_7ETGRxmrFGE=_rpVTSf3HsMawaLf7GDVNgZOWQfQ@mail.gmail.com>
Subject: Re: Linux pci card forcing a remove and restore
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Scott Branden <scott.branden@broadcom.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        Sinan Kaya <Okaya@kernel.org>,
        Luca Coelho <luciano.coelho@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 17, 2019 at 6:49 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Sinan, Luca, Rajat (incidental mention of iwlwifi)]
>
> Hi Scott,
>
> On Tue, Apr 16, 2019 at 04:34:36PM -0700, Scott Branden wrote:
> > I have a possibly simple or may be more involved question:
> >
> > I have a PCI device that the hardware boots up and enumerates in GEN2 mode.
> >
> > Once the linux device driver is loaded we can download new firmware to the
> > card that may reinitialize the PCIe PHY in GEN3 mode and resizing the BARs.
> >
> > We can have the device re-enumerated via user space:
> >
> > echo 1 > /sys/bus/pci/devices/0000\:01\:00.0/remove
> >
> > echo 1 > /sys/bus/pci/rescan
> >
> > But, is it possible to do this inside the kernel device driver after it has
> > downloaded the new firmware instead?
> >
> > Before I start trying to play with pci_stop_and_remove_bus_device followed
> > by pci_rescan_bus I would like to know if what I'm trying to do is a correct
> > approach?
>
> Sinan mentioned the hfi1 driver, which does reinitialize the link to
> transition from gen2 to gen3.  This is a little bit messy and I think
> it has a little too much knowledge of link internals that
> theoretically should be managed by the PCI core, but the PCI core
> doesn't offer any good alternatives.
>
> But your situation sounds a little more complicated because you also
> want to resize the BARs, which means you need to remove & re-enumerate
> the device or at least somehow update the whole dev->resource[] and
> resource tree situation.  Removing the device of course means
> detaching the driver, and doing that from within the driver itself
> is a little problematic.
>
> The iwlwifi driver does seem to do that (it calls
> pci_stop_and_remove_bus_device() from iwl_trans_pcie_removal_wk(),
> added by 49564a806fc5 ("iwlwifi: pcie: remove non-responsive device"))
> but I'm a little hesitant about copying this design.  It's a singleton
> (all other uses are in hotplug drivers), the non-responsive device
> situation is not unique to iwlwifi, and scheduling work to remove the
> current driver seems a little too clever.

Our first choice of solution was to enable hotplug, but Intel had
concerns about enabling it at that time. Also the othe rthing we were
not sure was whether the PCI link actually comes down when the device
stops responding. Thus we did what we did...

>
> In any event, your situation is much different from iwlwifi.  Your
> device *is* responding; you merely want to download new firmware,
> re-enumerate the device, and re-attach your driver.
>
> I wonder if we could invent some scheme where you'd have a separate
> driver (possibly implemented in the same source file as your main
> driver but with a different struct pci_driver), where that driver's
> .probe() method would check to see whether a firmware update was
> needed, and if so it would download the new firmware and return an
> indication to the PCI core that the device should be removed, reset,
> and re-enumerated.

+1 to this. I think such a mechanism in the PCI core would find
multiple users. In fact if available, we can possibly also change
iwlwifi to use that.

Thanks,

Rajat

>
> Bjorn
