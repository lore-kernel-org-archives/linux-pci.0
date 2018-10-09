Return-Path: <SRS0=286E=MV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B341C64EB8
	for <linux-pci@archiver.kernel.org>; Tue,  9 Oct 2018 17:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58C56214DC
	for <linux-pci@archiver.kernel.org>; Tue,  9 Oct 2018 17:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQVofOBk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58C56214DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbeJJATy (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 9 Oct 2018 20:19:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:38088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726764AbeJJATy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 9 Oct 2018 20:19:54 -0400
Received: from localhost (57.sub-174-234-155.myvzw.com [174.234.155.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1ABA214DA;
        Tue,  9 Oct 2018 17:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539104520;
        bh=2/u36yA2RO9M0kPxMJO7WK7RFc8N7LIJOmI3JRzZVBk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BQVofOBkXZpqFdlVxdXyQs+0h+VI56WJF2LG+EdU4tpo0rv6Kvw4htSQPYYY4W8Tb
         NQhFB8Ix6r27XUsmImCiXcCJvP16AhqsO34SS4nmb17lRot+mywRE9I7E6eBo8LPBq
         bx2/XGptgGf+AipNlSgDIsXGImnHtwJalh9TFZaI=
Date:   Tue, 9 Oct 2018 12:01:58 -0500
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
Message-ID: <20181009170158.GA5906@bhelgaas-glaptop.roam.corp.google.com>
References: <1537974841-29928-1-git-send-email-bmeng.cn@gmail.com>
 <20180926165721.GA28024@bhelgaas-glaptop.roam.corp.google.com>
 <CAEUhbmXc--Ph71DGu2b+ijTzB6xvHXzuESBJKp9zARE2gjqV6w@mail.gmail.com>
 <20181003201244.GG120535@bhelgaas-glaptop.roam.corp.google.com>
 <CAEUhbmUBic3RJbMH6bukw3NVis4qxMKr_pqJhn14vFtpGvES=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEUhbmUBic3RJbMH6bukw3NVis4qxMKr_pqJhn14vFtpGvES=w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 08, 2018 at 05:44:08PM +0800, Bin Meng wrote:
> On Thu, Oct 4, 2018 at 4:12 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Thu, Sep 27, 2018 at 10:10:07AM +0800, Bin Meng wrote:
> > > On Thu, Sep 27, 2018 at 12:57 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > On Wed, Sep 26, 2018 at 08:14:01AM -0700, Bin Meng wrote:
> > > > > Add more PCI IDs to the Intel GPU "spurious interrupt" quirk table,
> > > > > which are known to break.
> > > >
> > > > Do you have a reference for this?  Any public bug reports, bugzilla,
> > > > Intel spec reference or errata?  "Which are known to break" is pretty
> > > > vague.
> > >
> > > Sorry I used wrong words and should have been clearer. These devices
> > > are validated to be broken. The test I used is very simple, just
> > > unplug the VGA cable and plug it again, and "spurious interrupt" will
> > > be seen on the interrupt line of the IGD device. I was not aware of
> > > any public bugs filed to Intel, nor seen any errata from Intel.
> >
> > The original commit, f67fd55fa96f ("PCI: Add quirk for still enabled
> > interrupts on Intel Sandy Bridge GPUs"), says some systems "crash"
> > (not sure if that means an oops or an actual crash that requires a
> > reboot) and on other systems, Linux disables the shared interrupt
> > line.  I assume disabling the interrupt line keeps devices using that
> > line from working, but does not directly cause a crash.
> >
> 
> Correct, disable the shared interrupt line keeps all devices using
> that line from working, which is current kernel's behavior w/o this
> quirk handling: it disables the (shared) interrupt line after 100.000+
> generated interrupts. But the side effect is that other devices become
> unusable after that (eg: USB devices which share the same interrupt
> line with the Intel GPU). That's why the original commit, f67fd55fa96f
> ("PCI: Add quirk for still enabled interrupts on Intel Sandy Bridge
> GPUs") disables the GPU's interrupt directly, which should really be
> done by the VGA BIOS itself (a buggy VBIOS!).
> 
> > What specific symptom do you see here?  I think it might be useful to
> > collect details, e.g., dmesg logs, /proc/interrupts contents, output
> > of "sudo lspci -vv", etc., for the systems you're quirking here.  I'm
> > hoping we can eventually figure out a solution that doesn't require a
> > quirk for every new GPU, and maybe that info will help find it.
> 
> The symptom was described briefly in the original commit f67fd55fa96f
> too, that disables the (shared) interrupt line after 100.000+
> generated interrupts (can be observed via /proc/interrupts).
> 
> > > > > See commit f67fd55fa96f ("PCI: Add quirk for still enabled interrupts
> > > > > on Intel Sandy Bridge GPUs"), and commit 7c82126a94e6 ("PCI: Add new
> > > > > ID for Intel GPU "spurious interrupt" quirk") for some history.
> > > > >
> > > > > Based on current findings, it is highly possible that all Intel
> > > > > 1st/2nd/3rd generation Core processors' IGD has such quirk.
> > > >
> > > > Can you include a reference to these "current findings"?  I assume you
> > > > have bug reports that include the device IDs you're adding?  If not,
> > > > how did you build this list of new IDs?
> > >
> > > By "current findings" I mean given the IDs we have here, plus previous
> > > one added by Thomas, it's highly possible this VGA BIOS bug exists in
> > > every 1st/2nd/3rd generation Core processors.
> > >
> > > > The function comment added by f67fd55fa96f ("PCI: Add quirk for still
> > > > enabled interrupts on Intel Sandy Bridge GPUs") suggests that this is
> > > > actually a BIOS issue, not a hardware erratum, i.e., I don't see
> > > > anything there that suggests a hardware defect.
> > > >
> > > > But there must be a hole somewhere -- the kernel can't be expected to
> > > > disable interrupts in device-specific ways when there's no driver
> > > > loaded.  Maybe it's simply a BIOS defect or maybe there's some
> > > > interrupt or _PRT-related setup we're missing.
> > >
> > > It's a pure VGA BIOS bug, not the BIOS bug or _PRT etc. The VGA BIOS
> > > forgot to turn off the interrupt on these devices.
> >
> > If this is a VGA BIOS defect, it's not very likely that it will
> > magically be fixed for all new Intel GPUs, so in effect it sounds like
> > we need to update this list of quirks in Linux every time a new Intel
> > GPU comes out.  That prospect is a little daunting.
> 
> I don't have a relatively newer Intel board at hand for testing right
> now. I can try to locate one. But as I said, it's highly possible at
> least all 1st/2nd/3rd generation Core processors are affected.

> Maybe
> we can add all these known GPU devices of  1st/2nd/3rd generation Core
> processors all together for now? For newer GPUs, let's wait until
> someone reports the issue again?

This is exactly my point: we don't want to have to wait for somebody
to report an issue for every new GPU.  That (a) is a maintenance
headache and, more importantly, (b) prevents an old kernel from
running on new hardware.  (b) is important to distros because nobody
wants to qualify and release a new kernel just to add a new device ID.

Bottom line is that I think I'm going to have to apply this patch, but
I want to get off this train in the future, so now is the time to find
a better solution.

> > Do you happen to know if Windows has the same problem?  I.e., if you
> > boot an old version of Windows with a new GPU, and unplug the VGA
> > cable, does Windows crash?  If Windows can figure out how to handle
> > that situation gracefully, Linux should be able to do it, too.
> 
> I suspect Windows cannot handle it too. Without the GPU awareness, the
> interrupt line is simply on and no driver claims the devices and will
> cause issues. I can test this.

If you could test this, that would be great.  I would be quite
surprised if Windows crashed when you unplug the VGA cable.

What I'm wondering is if there's some different way we could manage
the IOAPICs or maybe disable interrupts at the PCI device level as
David suggests.  If something like that could be done we wouldn't need
quirks for every new device.

It's possible we could learn something by running Windows on qemu and
tracing its PCI config accesses to see whether it sets the
PCI_COMMAND_INTX_DISABLE bit or something.

> > > > > Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> > > > > Cc: <stable@vger.kernel.org> # v3.4+
> > > > > ---
> > > > >
> > > > >  drivers/pci/quirks.c | 4 ++++
> > > > >  1 file changed, 4 insertions(+)
> > > > >
> > > > > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > > > > index 6bc27b7..c0673a7 100644
> > > > > --- a/drivers/pci/quirks.c
> > > > > +++ b/drivers/pci/quirks.c
> > > > > @@ -3190,7 +3190,11 @@ static void disable_igfx_irq(struct pci_dev *dev)
> > > > >
> > > > >       pci_iounmap(dev, regs);
> > > > >  }
> > > > > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0042, disable_igfx_irq);
> > > > > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0046, disable_igfx_irq);
> > > > > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x004a, disable_igfx_irq);
> > > > >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0102, disable_igfx_irq);
> > > > > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0106, disable_igfx_irq);
> > > > >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x010a, disable_igfx_irq);
> > > > >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0152, disable_igfx_irq);
> > > > >
> > > > > --
> 
> Regards,
> Bin
