Return-Path: <SRS0=Y6U6=MP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D40C00449
	for <linux-pci@archiver.kernel.org>; Wed,  3 Oct 2018 20:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7B9221477
	for <linux-pci@archiver.kernel.org>; Wed,  3 Oct 2018 20:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oV2UGR3e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7B9221477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbeJDDCl (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 3 Oct 2018 23:02:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:60964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726950AbeJDDCl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Oct 2018 23:02:41 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EC0321470;
        Wed,  3 Oct 2018 20:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538597567;
        bh=ZPs0Oa4tqcEP9M41WwrONHaui5nL3bwAw5u1np159FA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oV2UGR3ejbLPCTEssToBX3t8/sktoYvn5g9X78QQuAHdN0iSWPnb6H0NStoedSb3v
         Du/B4rLzRlFUI3TqbIhsQqU01GE9Fkb+fY9dPngJhY94ZUwex4YtezE0ABCBzyF7eh
         M1P5OB100U+wpdlHWCN89bXdI/OqL73IqfWYx2dw=
Date:   Wed, 3 Oct 2018 15:12:44 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Bin Meng <bmeng.cn@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Thomas Jarosch <thomas.jarosch@intra2net.com>,
        stable <stable@vger.kernel.org>, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pci: Add a few new IDs for Intel GPU "spurious
 interrupt" quirk
Message-ID: <20181003201244.GG120535@bhelgaas-glaptop.roam.corp.google.com>
References: <1537974841-29928-1-git-send-email-bmeng.cn@gmail.com>
 <20180926165721.GA28024@bhelgaas-glaptop.roam.corp.google.com>
 <CAEUhbmXc--Ph71DGu2b+ijTzB6xvHXzuESBJKp9zARE2gjqV6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEUhbmXc--Ph71DGu2b+ijTzB6xvHXzuESBJKp9zARE2gjqV6w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 27, 2018 at 10:10:07AM +0800, Bin Meng wrote:
> On Thu, Sep 27, 2018 at 12:57 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Wed, Sep 26, 2018 at 08:14:01AM -0700, Bin Meng wrote:
> > > Add more PCI IDs to the Intel GPU "spurious interrupt" quirk table,
> > > which are known to break.
> >
> > Do you have a reference for this?  Any public bug reports, bugzilla,
> > Intel spec reference or errata?  "Which are known to break" is pretty
> > vague.
> 
> Sorry I used wrong words and should have been clearer. These devices
> are validated to be broken. The test I used is very simple, just
> unplug the VGA cable and plug it again, and "spurious interrupt" will
> be seen on the interrupt line of the IGD device. I was not aware of
> any public bugs filed to Intel, nor seen any errata from Intel.

The original commit, f67fd55fa96f ("PCI: Add quirk for still enabled
interrupts on Intel Sandy Bridge GPUs"), says some systems "crash"
(not sure if that means an oops or an actual crash that requires a
reboot) and on other systems, Linux disables the shared interrupt
line.  I assume disabling the interrupt line keeps devices using that
line from working, but does not directly cause a crash.

What specific symptom do you see here?  I think it might be useful to
collect details, e.g., dmesg logs, /proc/interrupts contents, output
of "sudo lspci -vv", etc., for the systems you're quirking here.  I'm
hoping we can eventually figure out a solution that doesn't require a
quirk for every new GPU, and maybe that info will help find it.

> > > See commit f67fd55fa96f ("PCI: Add quirk for still enabled interrupts
> > > on Intel Sandy Bridge GPUs"), and commit 7c82126a94e6 ("PCI: Add new
> > > ID for Intel GPU "spurious interrupt" quirk") for some history.
> > >
> > > Based on current findings, it is highly possible that all Intel
> > > 1st/2nd/3rd generation Core processors' IGD has such quirk.
> >
> > Can you include a reference to these "current findings"?  I assume you
> > have bug reports that include the device IDs you're adding?  If not,
> > how did you build this list of new IDs?
> 
> By "current findings" I mean given the IDs we have here, plus previous
> one added by Thomas, it's highly possible this VGA BIOS bug exists in
> every 1st/2nd/3rd generation Core processors.
> 
> > The function comment added by f67fd55fa96f ("PCI: Add quirk for still
> > enabled interrupts on Intel Sandy Bridge GPUs") suggests that this is
> > actually a BIOS issue, not a hardware erratum, i.e., I don't see
> > anything there that suggests a hardware defect.
> >
> > But there must be a hole somewhere -- the kernel can't be expected to
> > disable interrupts in device-specific ways when there's no driver
> > loaded.  Maybe it's simply a BIOS defect or maybe there's some
> > interrupt or _PRT-related setup we're missing.
> 
> It's a pure VGA BIOS bug, not the BIOS bug or _PRT etc. The VGA BIOS
> forgot to turn off the interrupt on these devices.

If this is a VGA BIOS defect, it's not very likely that it will
magically be fixed for all new Intel GPUs, so in effect it sounds like
we need to update this list of quirks in Linux every time a new Intel
GPU comes out.  That prospect is a little daunting.

Do you happen to know if Windows has the same problem?  I.e., if you
boot an old version of Windows with a new GPU, and unplug the VGA
cable, does Windows crash?  If Windows can figure out how to handle
that situation gracefully, Linux should be able to do it, too.

> > > Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> > > Cc: <stable@vger.kernel.org> # v3.4+
> > > ---
> > >
> > >  drivers/pci/quirks.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > > index 6bc27b7..c0673a7 100644
> > > --- a/drivers/pci/quirks.c
> > > +++ b/drivers/pci/quirks.c
> > > @@ -3190,7 +3190,11 @@ static void disable_igfx_irq(struct pci_dev *dev)
> > >
> > >       pci_iounmap(dev, regs);
> > >  }
> > > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0042, disable_igfx_irq);
> > > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0046, disable_igfx_irq);
> > > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x004a, disable_igfx_irq);
> > >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0102, disable_igfx_irq);
> > > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0106, disable_igfx_irq);
> > >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x010a, disable_igfx_irq);
> > >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0152, disable_igfx_irq);
> > >
> > > --
> 
> Regards,
> Bin
