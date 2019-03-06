Return-Path: <SRS0=ZPBx=RJ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE855C43381
	for <linux-pci@archiver.kernel.org>; Wed,  6 Mar 2019 15:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 890A8206DD
	for <linux-pci@archiver.kernel.org>; Wed,  6 Mar 2019 15:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks-com.20150623.gappssmtp.com header.i=@gateworks-com.20150623.gappssmtp.com header.b="B5qxC/oC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfCFP73 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 6 Mar 2019 10:59:29 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43272 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbfCFP73 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Mar 2019 10:59:29 -0500
Received: by mail-wr1-f65.google.com with SMTP id d17so13991303wre.10
        for <linux-pci@vger.kernel.org>; Wed, 06 Mar 2019 07:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yOkPVc7xy01w751E+qeOpBXjXdaf5yfzE3d2RqfNJZY=;
        b=B5qxC/oCaBr2DFgmgVPYZic7KecyTBMesi9X8wjHQjim1shrfo730nSCFZ06fRgwvt
         tJNRwlvgNTjTSpn2kzC8xCGMpmPZKxLKth/JKS6BsMvp7NxmrMSWiD5KLyMkJ5/eAnV5
         w52rzTtldow8ULiNGuH1Y77NwB7ErLYVgAPw1D2fAsDgnmhQpH4vvWqgSxPGoPoZ8XEW
         Q606Btm9iwSUe/Sh0n90QNer0e7YNC606GbX0Z21wdcAD2MR8Kl3Y/Y6+/IykILVXT2w
         4jNwoWPZoLBQjbOHunp4ADdu8DTif1djfSY3uwp3cJgtTGvNrmq5isQ9SpheWCMpRDYa
         qshw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yOkPVc7xy01w751E+qeOpBXjXdaf5yfzE3d2RqfNJZY=;
        b=LN2Jxd/o0gzukU45qFdAmM9WN1NGHCABiC6kw/ZJEFoukgxuqqxFdpaozbILUVOn3/
         BLhxarFqHo/4fz5Ahl8loiY3l+cs67M0LJqUHxGrP1tFCqkgfqHsp4abC9EfXYoT8npv
         PFptya4PNUTaTfE/Hyzi+4XXsW1nWNCmyJ0s3f9dsUmV+HsLgDBCq8EBC0HoOtaW/S+T
         j9OBNsBsEhoQUrBwOhKJNAlithbNi93akDWJMTZ/OXWFuQgB3ukIT0ER52cjWX4XlAmx
         QWTs+uiTnbc7WmrB58gx0LvtWFR7iHMtbopXH+ND6dIpigJ8RzzBuynsNuopNaQ58xmq
         1gfg==
X-Gm-Message-State: APjAAAWCBvffZGciE3SYa47Zub21Uz+/CcWs1eN4K7bQIkW062b3tPdH
        xVFJD2prdnnT+M7MVFhyyt7yP6xmbs+3XaZ4Y59hpg==
X-Google-Smtp-Source: APXvYqz6mRnQsr5uxv2OviA4p+uLB7x99cSDfnNFVbc4pj2mfZ/Cl4Qcxdhq5GvlpjwHbLhduCCofBOABhG27zEH3D0=
X-Received: by 2002:adf:eb85:: with SMTP id t5mr3542672wrn.168.1551887966724;
 Wed, 06 Mar 2019 07:59:26 -0800 (PST)
MIME-Version: 1.0
References: <20190227165219.31911-1-l.stach@pengutronix.de>
 <20190304192548.GB26569@google.com> <1551728385.9298.18.camel@pengutronix.de> <86ef7m1ji2.wl-marc.zyngier@arm.com>
In-Reply-To: <86ef7m1ji2.wl-marc.zyngier@arm.com>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Wed, 6 Mar 2019 07:59:15 -0800
Message-ID: <CAJ+vNU0EJbLETqQX51ZWNLX_t7fC3X524XsPr+dngkpntXjpXQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: dwc: skip MSI init if MSIs have been explicitly disabled
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>,
        patchwork-lst@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 4, 2019 at 12:18 PM Marc Zyngier <marc.zyngier@arm.com> wrote:
>
> Hi both,
>
> On Mon, 04 Mar 2019 19:39:45 +0000,
> Lucas Stach <l.stach@pengutronix.de> wrote:
> >
> > Hi Bjorn,
> >
> > Am Montag, den 04.03.2019, 13:25 -0600 schrieb Bjorn Helgaas:
> > > [+cc Marc, in case you have any suggestions]
> > >
> > > Hi Lucas,
> > >
> > > Nit: this has already been merged, but next time please make the
> > > subject line match the convention wrt capitalization.  This is not a
> > > PCI-specific idea; all it takes is "git log --oneline <file>", and
> > > that should be common practice anywhere in the kernel.
> >
> > Sorry about that. I didn't really notice the capitalization, but
> > focused on the prefix.
> >
> > > On Wed, Feb 27, 2019 at 05:52:19PM +0100, Lucas Stach wrote:
> > > > Since 7c5925afbc58 (PCI: dwc: Move MSI IRQs allocation to IRQ domains
> > > > hierarchical API) the MSI init claims one of the controller IRQs as a
> > > > chained IRQ line for the MSI controller. On some designs, like the i.MX6,
> > > > this line is shared with a PCIe legacy IRQ. When the line is claimed for
> > > > the MSI domain, any device trying to use this legacy IRQs will fail to
> > > > request this IRQ line.
> > > >
> > > > As MSI and legacy IRQs are already mutually exclusive on the DWC core,
> > > > as the core won't forward any legacy IRQs once any MSI has been enabled,
> > > > users wishing to use legacy IRQs already need to explictly disable MSI
> > > > support (usually via the pci=nomsi kernel commandline option). To avoid
> > > > any issues with MSI conflicting with legacy IRQs, just skip all of the
> > > > DWC MSI initalization, including the IRQ line claim, when MSI is disabled.
> > >
> > > Does this mean that if we have a device that uses legacy IRQs, the
> > > user has to figure out to boot with "pci=nomsi"?
> >
> > As long as there is only a single device connected and there are no
> > port services things will work. If port services are active, those will
> > start to use MSIs, breaking legacy IRQs in the process.
> >
> > I've asked Synopsys if there is a workaround for this, but it seems
> > that the core is working "as designed" with no workaround for this icky
> > behavior.
>
> Is this the general DWC controller behaviour? Or something that is
> specific to a given implementation? I can't believe someone actually
> thought this is an acceptable behaviour...
>
> Gustavo, can you please check with your HW colleagues and let
> everybody know what's the official Synopsys position on this?
>
> >
> > > I don't like kernel command line parameters.  If we need that
> > > parameter to make devices with legacy IRQs work, what happens without
> > > the parameter?  How obvious is it that the fix is to use "pci=nomsi"?
> >
> > Totally non-obvious currently. Maybe this warrants a warning in the
> > kernel log.
> >
> > > Is it impossible for Linux to figure this out and make it work
> > > automatically?
> > >
> > > If we can't do it automatically, fine, maybe we have to live with the
> > > parameter.  But if there's any way we can avoid it, we should.
> >
> > I don't think there is a practical way to make this work
> > automatically.
> >
> > At PCIe enumeration time we can only know if all devices in the
> > hierarchy are able to use MSIs, but this doesn't mean the device driver
> > will use MSIs. This is something we only get to know at driver probe
> > time, at which point it may already be too late, as another device
> > might already use some MSIs, so we can't revert to legacy IRQs only
> > mode.
>
> It is almost as the default is backward. It feels like it should
> default to legacy interrupts, and only enable MSIs if the user
> actually asks for it. We should always be able to provide legacy
> interrupts, as this is the usual fallback for most drivers.
>

Marc,

I would agree with 'should default to legacy interrupts' as that works
everywhere AFAIK and likely allows for improved performance.

Tim
