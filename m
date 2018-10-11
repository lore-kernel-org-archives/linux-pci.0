Return-Path: <SRS0=UcfF=MX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35F7C32788
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 07:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 232EE20841
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 07:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QveMhMYT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 232EE20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbeJKOhL (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Oct 2018 10:37:11 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40220 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbeJKOhL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Oct 2018 10:37:11 -0400
Received: by mail-ed1-f65.google.com with SMTP id r1-v6so7235519edd.7;
        Thu, 11 Oct 2018 00:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RfjMOpk4IR7k/ytZ0GpMq9Dx5ypAOWjJjYYZmR/lSeo=;
        b=QveMhMYTs1gnmL//X/RMWf+mt2jz7ARGpf+XQ+id0DS4RRDJM8qMtyfMvOGetJ1BCi
         mE8hkgbvDMi/EAQvUMVluZoWsAi9xlIuKc0WP2RTc8v739Jms//u/05iisNjO6GPMvne
         W4EfH+fBBOOipeHtK0JsCB3ecExsuVzJStCbd1DPn6oT2DB//5VK9IyE/rcwkfkyqQPH
         FEFBFMgO1mbE1EZd33cYl5DvHoD0EDE0O4vHYPTNNPiZBCJWyYUY7GV2nhyIWxxpx8aa
         peXoFKXj3KNiCrZ+ixKTZ2QPXG9DoeK0dcdJi+qRSg0sW3o067qoBBt2EtLCBN5n4sI+
         lASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RfjMOpk4IR7k/ytZ0GpMq9Dx5ypAOWjJjYYZmR/lSeo=;
        b=MDGL11HYLQjNhXJZS0GXyHus1eLsJ8y+Ano43E6bKdB/sPLSOyKKHrM0u2EjKgsB7b
         ImFBgB/InG9iIz9ELfwWkfMcXz98gvIRrIIRGwAvyrLqusahYtafd4NjnQYGImjfTcIE
         Ylr/ArXjYXEc0Kcqp7dDlE6aDYz24XntO9quTNrbrI4k80/v5gVKuOUY/Fg0em1GMu0V
         6GAXyEZmV2sodxaIYA69meov7y06adTSexxXV83DuKjOWctwCLUQ9UXc0yifcEiV+8+u
         KMHlZdbKFk4hqjXp2clHfWNJKlr7dKEnRSBcRpnAnlm6FOOrYPTilCcJObcQSwWg5F9R
         3+xQ==
X-Gm-Message-State: ABuFfoiu2YM+bGAamGEuYtQJxhh7/yNmbcO/WHb7wp+aiBWvNXiqIzLX
        OuzCXo3peMQ1dwKAiCdim2YBA37y9nvX4+G81XY=
X-Google-Smtp-Source: ACcGV62k3Inq3v/Yc2J86bV4fcn4lJX0jQ0mgMg7iSHH+mO7gL0DnD9Ml4RAwZhgawRgB82pIm2kgIdCFqbgf3AzX/0=
X-Received: by 2002:a17:906:2d4a:: with SMTP id e10-v6mr828904eji.105.1539241873050;
 Thu, 11 Oct 2018 00:11:13 -0700 (PDT)
MIME-Version: 1.0
References: <1537974841-29928-1-git-send-email-bmeng.cn@gmail.com>
 <20180926165721.GA28024@bhelgaas-glaptop.roam.corp.google.com>
 <CAEUhbmXc--Ph71DGu2b+ijTzB6xvHXzuESBJKp9zARE2gjqV6w@mail.gmail.com>
 <20181003201244.GG120535@bhelgaas-glaptop.roam.corp.google.com>
 <CAEUhbmUBic3RJbMH6bukw3NVis4qxMKr_pqJhn14vFtpGvES=w@mail.gmail.com> <20181009170158.GA5906@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20181009170158.GA5906@bhelgaas-glaptop.roam.corp.google.com>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Thu, 11 Oct 2018 15:11:01 +0800
Message-ID: <CAEUhbmXvN9RAYr139YcPdTdzWtCMN0D1881+9+9UGF1zeNjMWA@mail.gmail.com>
Subject: Re: [PATCH] pci: Add a few new IDs for Intel GPU "spurious interrupt" quirk
To:     helgaas@kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Thomas Jarosch <thomas.jarosch@intra2net.com>,
        stable <stable@vger.kernel.org>, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On Wed, Oct 10, 2018 at 1:02 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Mon, Oct 08, 2018 at 05:44:08PM +0800, Bin Meng wrote:
> > On Thu, Oct 4, 2018 at 4:12 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Thu, Sep 27, 2018 at 10:10:07AM +0800, Bin Meng wrote:
> > > > On Thu, Sep 27, 2018 at 12:57 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > On Wed, Sep 26, 2018 at 08:14:01AM -0700, Bin Meng wrote:
> > > > > > Add more PCI IDs to the Intel GPU "spurious interrupt" quirk table,
> > > > > > which are known to break.
> > > > >
> > > > > Do you have a reference for this?  Any public bug reports, bugzilla,
> > > > > Intel spec reference or errata?  "Which are known to break" is pretty
> > > > > vague.
> > > >
> > > > Sorry I used wrong words and should have been clearer. These devices
> > > > are validated to be broken. The test I used is very simple, just
> > > > unplug the VGA cable and plug it again, and "spurious interrupt" will
> > > > be seen on the interrupt line of the IGD device. I was not aware of
> > > > any public bugs filed to Intel, nor seen any errata from Intel.
> > >
> > > The original commit, f67fd55fa96f ("PCI: Add quirk for still enabled
> > > interrupts on Intel Sandy Bridge GPUs"), says some systems "crash"
> > > (not sure if that means an oops or an actual crash that requires a
> > > reboot) and on other systems, Linux disables the shared interrupt
> > > line.  I assume disabling the interrupt line keeps devices using that
> > > line from working, but does not directly cause a crash.
> > >
> >
> > Correct, disable the shared interrupt line keeps all devices using
> > that line from working, which is current kernel's behavior w/o this
> > quirk handling: it disables the (shared) interrupt line after 100.000+
> > generated interrupts. But the side effect is that other devices become
> > unusable after that (eg: USB devices which share the same interrupt
> > line with the Intel GPU). That's why the original commit, f67fd55fa96f
> > ("PCI: Add quirk for still enabled interrupts on Intel Sandy Bridge
> > GPUs") disables the GPU's interrupt directly, which should really be
> > done by the VGA BIOS itself (a buggy VBIOS!).
> >
> > > What specific symptom do you see here?  I think it might be useful to
> > > collect details, e.g., dmesg logs, /proc/interrupts contents, output
> > > of "sudo lspci -vv", etc., for the systems you're quirking here.  I'm
> > > hoping we can eventually figure out a solution that doesn't require a
> > > quirk for every new GPU, and maybe that info will help find it.
> >
> > The symptom was described briefly in the original commit f67fd55fa96f
> > too, that disables the (shared) interrupt line after 100.000+
> > generated interrupts (can be observed via /proc/interrupts).
> >
> > > > > > See commit f67fd55fa96f ("PCI: Add quirk for still enabled interrupts
> > > > > > on Intel Sandy Bridge GPUs"), and commit 7c82126a94e6 ("PCI: Add new
> > > > > > ID for Intel GPU "spurious interrupt" quirk") for some history.
> > > > > >
> > > > > > Based on current findings, it is highly possible that all Intel
> > > > > > 1st/2nd/3rd generation Core processors' IGD has such quirk.
> > > > >
> > > > > Can you include a reference to these "current findings"?  I assume you
> > > > > have bug reports that include the device IDs you're adding?  If not,
> > > > > how did you build this list of new IDs?
> > > >
> > > > By "current findings" I mean given the IDs we have here, plus previous
> > > > one added by Thomas, it's highly possible this VGA BIOS bug exists in
> > > > every 1st/2nd/3rd generation Core processors.
> > > >
> > > > > The function comment added by f67fd55fa96f ("PCI: Add quirk for still
> > > > > enabled interrupts on Intel Sandy Bridge GPUs") suggests that this is
> > > > > actually a BIOS issue, not a hardware erratum, i.e., I don't see
> > > > > anything there that suggests a hardware defect.
> > > > >
> > > > > But there must be a hole somewhere -- the kernel can't be expected to
> > > > > disable interrupts in device-specific ways when there's no driver
> > > > > loaded.  Maybe it's simply a BIOS defect or maybe there's some
> > > > > interrupt or _PRT-related setup we're missing.
> > > >
> > > > It's a pure VGA BIOS bug, not the BIOS bug or _PRT etc. The VGA BIOS
> > > > forgot to turn off the interrupt on these devices.
> > >
> > > If this is a VGA BIOS defect, it's not very likely that it will
> > > magically be fixed for all new Intel GPUs, so in effect it sounds like
> > > we need to update this list of quirks in Linux every time a new Intel
> > > GPU comes out.  That prospect is a little daunting.
> >
> > I don't have a relatively newer Intel board at hand for testing right
> > now. I can try to locate one. But as I said, it's highly possible at
> > least all 1st/2nd/3rd generation Core processors are affected.
>
> > Maybe
> > we can add all these known GPU devices of  1st/2nd/3rd generation Core
> > processors all together for now? For newer GPUs, let's wait until
> > someone reports the issue again?
>
> This is exactly my point: we don't want to have to wait for somebody
> to report an issue for every new GPU.  That (a) is a maintenance
> headache and, more importantly, (b) prevents an old kernel from
> running on new hardware.  (b) is important to distros because nobody
> wants to qualify and release a new kernel just to add a new device ID.
>
> Bottom line is that I think I'm going to have to apply this patch, but
> I want to get off this train in the future, so now is the time to find
> a better solution.
>
> > > Do you happen to know if Windows has the same problem?  I.e., if you
> > > boot an old version of Windows with a new GPU, and unplug the VGA
> > > cable, does Windows crash?  If Windows can figure out how to handle
> > > that situation gracefully, Linux should be able to do it, too.
> >
> > I suspect Windows cannot handle it too. Without the GPU awareness, the
> > interrupt line is simply on and no driver claims the devices and will
> > cause issues. I can test this.
>
> If you could test this, that would be great.  I would be quite
> surprised if Windows crashed when you unplug the VGA cable.
>

For the record, I installed Windows 7 to one of the affected board.
The Intel GPU driver is not installed, so Windows is using the
standard VGA driver. Unplug/plug the VGA cable does not crash Windows,
nor did I notice anything abnormal. Since I have no idea how Windows
is handling any spurious interrupt, I cannot tell whether Windows does
anything special in the background to make it be "normal".

> What I'm wondering is if there's some different way we could manage
> the IOAPICs or maybe disable interrupts at the PCI device level as
> David suggests.  If something like that could be done we wouldn't need
> quirks for every new device.
>
> It's possible we could learn something by running Windows on qemu and
> tracing its PCI config accesses to see whether it sets the
> PCI_COMMAND_INTX_DISABLE bit or something.

Good idea.

Regards,
Bin
