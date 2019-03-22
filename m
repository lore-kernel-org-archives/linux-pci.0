Return-Path: <SRS0=nTPQ=RZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE0C9C10F03
	for <linux-pci@archiver.kernel.org>; Fri, 22 Mar 2019 23:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B13D621900
	for <linux-pci@archiver.kernel.org>; Fri, 22 Mar 2019 23:50:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbfCVXu1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 22 Mar 2019 19:50:27 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35202 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726916AbfCVXuZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Mar 2019 19:50:25 -0400
Received: by mail-qt1-f195.google.com with SMTP id h39so4517930qte.2
        for <linux-pci@vger.kernel.org>; Fri, 22 Mar 2019 16:50:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=th36FAJVJTVRoMKc5rwU+hTs+FnbW4f1G9n/BJ1jnaA=;
        b=cS+7WDWstygebOL9P+EHZGqg3eO/j/jl1rJkaJQG0+2tfwu2Hup3YlwRUH9cuqXTpK
         2Vt6uyzNZS9iOQ84MAU0AVI1if3Yez0ToyOPM0/9dzsAv+tbmid1Mdes3K6/3NAzecOV
         h8wJNfSKnfA6cUmn8xHFDDKPlFFdw4kSYlJrqLOIBx+P3AFMAdFZNyV4WEZTKmVHwwnS
         kFM21wAhh7mxK+hzKpmhWcwhfyPGKj9qdOnkNALlog3LZtQWZ/cxHKtFHjALCJ5J4lcw
         Nwmv+iVKr5r0S+eFaVYOzIGA7dXilF7NhJrhroYwk4h6SzAzs6282A5n9mJ8JAOzTwtp
         GPQg==
X-Gm-Message-State: APjAAAUPV9xYpbCpNOwwJ4lSaWdSuKiBInKXOTmsIQ0vsNWRJXcHKAAc
        WJf9urXTqJoXn7FNps9YGvaVbg==
X-Google-Smtp-Source: APXvYqwuaLFCZhS5kXq/KyS1ciOsqKe+8f7xqgoFsibjJZFdaYeZQgxzxFF1Ll6nBrXu4E7sE9wvjQ==
X-Received: by 2002:ac8:a81:: with SMTP id d1mr10812920qti.213.1553298624132;
        Fri, 22 Mar 2019 16:50:24 -0700 (PDT)
Received: from dhcp-10-20-1-11.bss.redhat.com ([144.121.20.162])
        by smtp.gmail.com with ESMTPSA id l6sm1543328qke.65.2019.03.22.16.50.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Mar 2019 16:50:23 -0700 (PDT)
Message-ID: <b73419b7b48ef5ef26ae874dcfa19b21a7b0fde1.camel@redhat.com>
Subject: Re: [PATCH] pci/quirks: Add quirk to reset nvgpu at boot for the
 Lenovo ThinkPad P50
From:   Lyude Paul <lyude@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     David Ober <dober@lenovo.com>, linux-pci@vger.kernel.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Karol Herbst <kherbst@redhat.com>,
        Ben Skeggs <skeggsb@gmail.com>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Date:   Fri, 22 Mar 2019 19:50:22 -0400
In-Reply-To: <20190321224819.GK251185@google.com>
References: <20190212220230.1568-1-lyude@redhat.com>
         <20190215004329.GR96272@google.com>
         <2fca9a9feafcd17b27bc71994a71ebc241a93e9a.camel@redhat.com>
         <52b17f8cb24e179e9661d75548d193843ae87b4c.camel@redhat.com>
         <20190321224819.GK251185@google.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Note: I did read your response lower down in the thread, but I wanted to make
sure I addressed one of the comments here (see below)

On Thu, 2019-03-21 at 17:48 -0500, Bjorn Helgaas wrote:
> [+cc Rafael]
> 
> On Wed, Mar 13, 2019 at 06:25:02PM -0400, Lyude Paul wrote:
> > On Fri, 2019-02-15 at 16:17 -0500, Lyude Paul wrote:
> > > On Thu, 2019-02-14 at 18:43 -0600, Bjorn Helgaas wrote:
> > > > On Tue, Feb 12, 2019 at 05:02:30PM -0500, Lyude Paul wrote:
> > > > > On a very specific subset of ThinkPad P50 SKUs, particularly
> > > > > ones that come with a Quadro M1000M chip instead of the M2000M
> > > > > variant, the BIOS seems to have a very nasty habit of not
> > > > > always resetting the secondary Nvidia GPU between full reboots
> > > > > if the laptop is configured in Hybrid Graphics mode. The
> > > > > reason for this happening is unknown, but the following steps
> > > > > and possibly a good bit of patience will reproduce the issue:
> > > > > 
> > > > > 1. Boot up the laptop normally in Hybrid graphics mode
> > > > > 2. Make sure nouveau is loaded and that the GPU is awake
> > > > > 2. Allow the nvidia GPU to runtime suspend itself after being idle
> > > > > 3. Reboot the machine, the more sudden the better (e.g sysrq-b may
> > > > > help)
> > > > > 4. If nouveau loads up properly, reboot the machine again and go
> > > > > back to
> > > > > step 2 until you reproduce the issue
> > > > > 
> > > > > This results in some very strange behavior: the GPU will quite
> > > > > literally be left in exactly the same state it was in when the
> > > > > previously booted kernel started the reboot. This has all
> > > > > sorts of bad sideaffects: for starters, this completely breaks
> > > > > nouveau starting with a mysterious EVO channel failure that
> > > > > happens well before we've actually used the EVO channel for
> > > > > anything:
> 
> Thanks for the hybrid tutorial (snipped from this response).  IIUC,
> what you said was that in hybrid mode, the Intel GPU drives the
> built-in display and the Nvidia GPU drives any external displays and
> may be used for DRI PRIME rendering (whatever that is).  But since you
> say the Nvidia device gets runtime suspended, I assume there's no
> external display here and you're not using DRI PRIME.
> 
> I wonder if it's related to the fact that the Nvidia GPU has been
> runtime suspended before you do the reboot.  Can you try turning of
> runtime power management for the GPU by setting the runpm module
> parameter to 0?  I *think* this would be booting with
> "nouveau.runpm=0".
> 
> > > > Is there a bug report for this?  Bugzilla.kernel.org would be ideal,
> > > > including "lspci -vvxxx" and dmidecode for the system.
> > > > 
> > > Not yet, but there has been discussion about this between nouveau
> > > developers on our IRC channel.
> > 
> > I lied: yes there actually is a bug report for this, but it's
> > currently on the Red Hat bugzilla. I can get more information from
> > it if you need (with lenovo's approval of course).
> 
> Can you please make a bugzilla.kernel.org entry with as much
> information (dmesg, "lspci -vvxxx", dmidecode, etc) as you can get
> approval for?  You can include the Red Hat bugzilla URL in the commit
> log, too, but that's not quite as good because we have no control over
> whether it's public.
> 
> > And additionally: I've been working with Lenovo on this issue for a
> > couple of months now, and we've gone through dozens of different
> > trial BIOSes with no success thus far. However, Lenovo is currently
> > working on trying to add this workaround into their BIOS but I've
> > been told that this change is going to take a decent amount of time
> > since they need to test it across multiple operating systems. I'd be
> > happy to come back and add a conditional later to turn this
> > workaround off for later BIOS versions once Lenovo has released a
> > proper fix.
> 
> Sounds like Lenovo is going to a lot of trouble for this.  The ideal
> thing from my point of view would be if they could figure out why this
> works on Windows but not on Linux.  I doubt Windows has a quirk like
> this, so if we could figure out why it works on Windows, we could
> likely do something similar in Linux.

I did actually try this route after first finding this bug, but unfortunately
from what I understand there isn't really much more Lenovo can do other then
give us a patched BIOS or look at their own BIOS to see if it's the cause. 

Anyway, went ahead and filed a bug with as much information as I could get my
hands on here (different email then the one I'm talking to you from): 
https://bugzilla.kernel.org/show_bug.cgi?id=203003

> 
> > > > > So to do this, we add a new pci quirk using
> > > > > DECLARE_PCI_FIXUP_CLASS_FINAL that will be invoked before the PCI
> > > > > probe
> > > > > at boot finishes. From there, we check to make sure that this is
> > > > > indeed
> > > > > the specific P50 variant of this GPU. We also make sure that the GPU
> > > > > PCI
> > > > > device is advertising NoReset- in order to prevent us from trying to
> > > > > reset the GPU when the machine is in Dedicated graphics mode (where
> > > > > the
> > > > > GPU being initialized by the BIOS is normal and expected). Finally,
> > > > > we
> > > > > try mapping the MMIO space for the GPU which should only work if the
> > > > > GPU
> > > > > is actually active in D0 mode. We can then read the magic 0x2240c
> > > > > register on the GPU, which will have bit 1 set if the GPU's firmware
> > > > > has
> > > > > already been posted during a previous boot. Once we've confirmed all
> > > > > of
> > > > > this, we reset the PCI device and re-disable it - bringing the GPU
> > > > > back
> > > > > into a healthy state.
> > > > > 
> > > > > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > > > > Cc: nouveau@lists.freedesktop.org
> > > > > Cc: dri-devel@lists.freedesktop.org
> > > > > Cc: Karol Herbst <kherbst@redhat.com>
> > > > > Cc: Ben Skeggs <skeggsb@gmail.com>
> > > > > Cc: stable@vger.kernel.org
> > > > > ---
> > > > >  drivers/pci/quirks.c | 65
> > > > > ++++++++++++++++++++++++++++++++++++++++++++
> > > > >  1 file changed, 65 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > > > > index b0a413f3f7ca..948492fda8bf 100644
> > > > > --- a/drivers/pci/quirks.c
> > > > > +++ b/drivers/pci/quirks.c
> > > > > @@ -5117,3 +5117,68 @@ SWITCHTEC_QUIRK(0x8573);  /* PFXI 48XG3 */
> > > > >  SWITCHTEC_QUIRK(0x8574);  /* PFXI 64XG3 */
> > > > >  SWITCHTEC_QUIRK(0x8575);  /* PFXI 80XG3 */
> > > > >  SWITCHTEC_QUIRK(0x8576);  /* PFXI 96XG3 */
> > > > > +
> > > > > +/*
> > > > > + * On certain Lenovo Thinkpad P50 SKUs, specifically those with a
> > > > > Nvidia
> > > > > + * Quadro M1000M, the BIOS will occasionally make the mistake of
> > > > > not
> > > > > resetting
> > > > > + * the nvidia GPU between reboots if the system is configured to
> > > > > use
> > > > > hybrid
> > > > > + * graphics mode. This results in the GPU being left in whatever
> > > > > state
> > > > > it
> > > > > was
> > > > > + * in during the previous boot which causes spurious interrupts
> > > > > from
> > > > > the
> > > > > GPU,
> > > > > + * which in turn cause us to disable the wrong IRQs and end up
> > > > > breaking
> > > > > the
> > > > > + * touchpad. Unsurprisingly, this also completely breaks nouveau.
> > > > > + *
> > > > > + * Luckily, it seems a simple reset of the PCI device for the
> > > > > nvidia
> > > > > GPU
> > > > > + * manages to bring the GPU back into a clean state and fix all of
> > > > > these
> > > > > + * issues. Additionally since the GPU will report NoReset+ when the
> > > > > machine is
> > > > > + * configured in Dedicated display mode, we don't need to worry
> > > > > about
> > > > > + * accidentally resetting the GPU when it's supposed to already be
> > > > > + * initialized.
> > > > > + */
> > > > > +static void
> > > > > +quirk_lenovo_thinkpad_p50_nvgpu_survives_reboot(struct pci_dev
> > > > > *pdev)
> > > > > +{
> > > > > +	void __iomem *map;
> > > > > +	int ret;
> > > > > +
> > > > > +	if (pdev->subsystem_vendor != PCI_VENDOR_ID_LENOVO ||
> > > > > +	    pdev->subsystem_device != 0x222e ||
> > > > > +	    !pdev->reset_fn)
> > > > > +		return;
> > > > > +
> > > > > +	/*
> > > > > +	 * If we can't enable the device's mmio space, it's probably
> > > > > not even
> > > > > +	 * initialized. This is fine, and means we can just skip the
> > > > > quirk
> > > > > +	 * entirely.
> > > > > +	 */
> > > > > +	if (pci_enable_device_mem(pdev)) {
> > > > > +		pci_dbg(pdev, "Can't enable device mem, no reset
> > > > > needed\n");
> > > > > +		return;
> > > > > +	}
> > > > > +
> > > > > +	/* Taken from drivers/gpu/drm/nouveau/engine/device/base.c */
> > > > > +	map = ioremap(pci_resource_start(pdev, 0), 0x102000);
> > > > > +	if (!map) {
> > > > > +		pci_err(pdev, "Can't map MMIO space, this is probably
> > > > > very
> > > > > bad\n");
> > > > > +		goto out_disable;
> > > > > +	}
> > > > > +
> > > > > +	/*
> > > > > +	 * Be extra careful, and make sure that the GPU firmware is
> > > > > posted
> > > > > +	 * before trying a reset
> > > > > +	 */
> > > > > +	if (ioread32(map + 0x2240c) & 0x2) {
> > > > > +		pci_info(pdev,
> > > > > +			 FW_BUG "GPU left initialized by EFI,
> > > > > resetting\n");
> > > > > +		ret = pci_reset_function(pdev);
> > > > > +		if (ret < 0)
> > > > > +			pci_err(pdev, "Failed to reset GPU: %d\n",
> > > > > ret);
> > > > > +	}
> > > > > +
> > > > > +	iounmap(map);
> > > > > +out_disable:
> > > > > +	pci_disable_device(pdev);
> > > > > +}
> > > > > +
> > > > > +DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, 0x13b1,
> > > > > +			      PCI_CLASS_DISPLAY_VGA, 8,
> > > > > +			      quirk_lenovo_thinkpad_p50_nvgpu_survives
> > > > > _reboot)
> > > > > ;
> > > > > -- 
> > > > > 2.20.1
> > > > > 
> > -- 
> > Cheers,
> > 	Lyude Paul
> > 
-- 
Cheers,
	Lyude Paul

