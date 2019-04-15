Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC8EC10F0E
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 18:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 095C4218D3
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 18:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbfDOSHX (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Apr 2019 14:07:23 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34938 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727909AbfDOSHX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Apr 2019 14:07:23 -0400
Received: by mail-qk1-f193.google.com with SMTP id a71so10458103qkg.2
        for <linux-pci@vger.kernel.org>; Mon, 15 Apr 2019 11:07:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=2+BlLzxkGTAuoyeo+4VN6BASdiWZbDXa6Iy34pUyHTw=;
        b=keFnIbkF2wfzSEZYcfwKyy6tuPHN0ZFqIWbXDTsHJAaP0xstOg08Xwz8jddDYCU0Kc
         UmJgKXPTHp6EkggjiNcI6pOBEpMBahDkRe1MnhpW7GmcqyiKbhregcywCJ7Ah3yOFSzc
         YSsNXb7KdOmBLHH6mDEqebbkB3/CgZPtBIKlQKY0nU1latJu1BvwH3CEwHOW79bBl7O1
         /lCMpG/MgwF3V42A+t/xivvtGco4Ll85xN7UfWsIKA6V9JqSGvFqS34Xb86RzRYRg2GP
         gOMSdGDleN+fxTR3nyzQhombXP4rbm2aOGKb0OwbXKqUYUEW5KkEMeEN+O6B5w2ED/58
         4/hQ==
X-Gm-Message-State: APjAAAWxSB+fItk2jY3qSch5diiyJPBHGf+CKk9qctb1kYQEgz8nDmTw
        xdEMhvcF89f507XLTYFlwmpxZg==
X-Google-Smtp-Source: APXvYqzlh7vAj3vd/l11mRjB+VQebK4IPh2obUfBIrZGG5LPfOy4mR2/8leAu6S4j8599zueIpW4yw==
X-Received: by 2002:ae9:f312:: with SMTP id p18mr17882445qkg.60.1555351641721;
        Mon, 15 Apr 2019 11:07:21 -0700 (PDT)
Received: from dhcp-10-20-1-11.bss.redhat.com ([144.121.20.162])
        by smtp.gmail.com with ESMTPSA id g15sm33428120qta.31.2019.04.15.11.07.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 11:07:21 -0700 (PDT)
Message-ID: <3987ad435bfdb2d92e5e42648174634814b1646d.camel@redhat.com>
Subject: Re: [PATCH] pci/quirks: Add quirk to reset nvgpu at boot for the
 Lenovo ThinkPad P50
From:   Lyude Paul <lyude@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     David Ober <dober@lenovo.com>, linux-pci@vger.kernel.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Karol Herbst <kherbst@redhat.com>,
        Ben Skeggs <skeggsb@gmail.com>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Hans de Goede <hdegoede@redhat.com>
Date:   Mon, 15 Apr 2019 14:07:18 -0400
In-Reply-To: <20190404141724.GJ141706@google.com>
References: <20190212220230.1568-1-lyude@redhat.com>
         <20190215004329.GR96272@google.com>
         <2fca9a9feafcd17b27bc71994a71ebc241a93e9a.camel@redhat.com>
         <52b17f8cb24e179e9661d75548d193843ae87b4c.camel@redhat.com>
         <20190321224819.GK251185@google.com> <20190322113015.GM251185@google.com>
         <20190404141724.GJ141706@google.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 2019-04-04 at 09:17 -0500, Bjorn Helgaas wrote:
> [+cc Hans, author of 0b2fe6594fa2 ("drm/nouveau: Queue hpd_work on (runtime)
> resume")]
> 
> On Fri, Mar 22, 2019 at 06:30:15AM -0500, Bjorn Helgaas wrote:
> > On Thu, Mar 21, 2019 at 05:48:19PM -0500, Bjorn Helgaas wrote:
> > > On Wed, Mar 13, 2019 at 06:25:02PM -0400, Lyude Paul wrote:
> > > > On Fri, 2019-02-15 at 16:17 -0500, Lyude Paul wrote:
> > > > > On Thu, 2019-02-14 at 18:43 -0600, Bjorn Helgaas wrote:
> > > > > > On Tue, Feb 12, 2019 at 05:02:30PM -0500, Lyude Paul wrote:
> > > > > > > On a very specific subset of ThinkPad P50 SKUs, particularly
> > > > > > > ones that come with a Quadro M1000M chip instead of the M2000M
> > > > > > > variant, the BIOS seems to have a very nasty habit of not
> > > > > > > always resetting the secondary Nvidia GPU between full reboots
> > > > > > > if the laptop is configured in Hybrid Graphics mode. The
> > > > > > > reason for this happening is unknown, but the following steps
> > > > > > > and possibly a good bit of patience will reproduce the issue:
> > > > > > > 
> > > > > > > 1. Boot up the laptop normally in Hybrid graphics mode
> > > > > > > 2. Make sure nouveau is loaded and that the GPU is awake
> > > > > > > 2. Allow the nvidia GPU to runtime suspend itself after being
> > > > > > > idle
> > > > > > > 3. Reboot the machine, the more sudden the better (e.g sysrq-b
> > > > > > > may help)
> > > > > > > 4. If nouveau loads up properly, reboot the machine again and go
> > > > > > > back to
> > > > > > > step 2 until you reproduce the issue
> > > > > > > 
> > > > > > > This results in some very strange behavior: the GPU will quite
> > > > > > > literally be left in exactly the same state it was in when the
> > > > > > > previously booted kernel started the reboot. This has all
> > > > > > > sorts of bad sideaffects: for starters, this completely breaks
> > > > > > > nouveau starting with a mysterious EVO channel failure that
> > > > > > > happens well before we've actually used the EVO channel for
> > > > > > > anything:
> > > 
> > > Thanks for the hybrid tutorial (snipped from this response).  IIUC,
> > > what you said was that in hybrid mode, the Intel GPU drives the
> > > built-in display and the Nvidia GPU drives any external displays and
> > > may be used for DRI PRIME rendering (whatever that is).  But since you
> > > say the Nvidia device gets runtime suspended, I assume there's no
> > > external display here and you're not using DRI PRIME.
> > > 
> > > I wonder if it's related to the fact that the Nvidia GPU has been
> > > runtime suspended before you do the reboot.  Can you try turning of
> > > runtime power management for the GPU by setting the runpm module
> > > parameter to 0?  I *think* this would be booting with
> > > "nouveau.runpm=0".
> > 
> > Sorry, I wasn't really thinking here.  You already *said* this is
> > related to runtime suspend.  It only happens when the Nvidia GPU has
> > been suspended.
> > 
> > I don't know that much about suspend, but ISTR seeing comments about
> > resuming devices before we shutdown.  If we do that, maybe there's
> > some kind of race between that resume and the reboot?
> 
> I think we do in fact resume PCI devices before shutdown.  Here's the
> path I'm looking at:
> 
>   device_shutdown
>     pm_runtime_get_noresume
>     pm_runtime_barrier
>     dev->bus->shutdown
>       pci_device_shutdown
>         pm_runtime_resume
>           __pm_runtime_resume(dev, 0)
>             rpm_resume(dev, 0)
>               __update_runtime_status(dev, RPM_RESUMING)
>               callback = RPM_GET_CALLBACK(dev, runtime_resume)
>               rpm_callback(callback, dev)
>                 __rpm_callback
>                   pci_pm_runtime_resume
>                     drv->pm->runtime_resume
>                       nouveau_pmops_runtime_resume
>                         nouveau_do_resume
>                         schedule_work(hpd_work)   # <---
>                         ...
>                         nouveau_display_hpd_work
>                           pm_runtime_get_sync
>                           drm_helper_hpd_irq_event
>                           pm_runtime_mark_last_busy
>                           pm_runtime_put_sync
> 
> I'm curious about that "schedule_work(hpd_work)" near the end because
> no other drivers seem to use schedule_work() in the runtime_resume
> path, and I don't know how that synchronizes with the shutdown
> process.  I don't see anything that waits for
> nouveau_display_hpd_work() to complete, so it seems like something
> that could be a race.
> 
> I wonder this problem would be easier to reproduce if you added a
> sleep in nouveau_display_hpd_work() as in the first hunk below, and I
> wonder if the problem would then go away if you stopped scheduling
> hpd_work as in the second hunk?  Obviously the second hunk isn't a
> solution, it's just an attempt to figure out if I'm looking in the
> right area.
> 

Hi, sorry it took me so long to get back to this - I've been busy with some
other responsibilities at work that came up last moment.

So I did try making it so that we cancel hpd_work from pci_driver->shutdown
and wait for it to complete, however that didn't really mseem to make any
difference. I did however try adding a workaround in the past that would shut
down the GPU whenever the kernel was shutting down (basically calling
nouveau_drm_remove() on shutdown) and that did actually fix the issue though,
but I didn't go with it as a final solution because of the problems it would
cause if we tried shutting down the card when it's in a bad state we could end
up hanging the whole system.

Do we want to have this discussion on the bz btw, or is this email thread
fine?

> Bjorn
> 
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_display.c
> b/drivers/gpu/drm/nouveau/nouveau_display.c
> index 55c0fa451163..e50806012d41 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_display.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_display.c
> @@ -350,6 +350,7 @@ nouveau_display_hpd_work(struct work_struct *work)
>  
>  	pm_runtime_get_sync(drm->dev->dev);
>  
> +	msleep(2000);
>  	drm_helper_hpd_irq_event(drm->dev);
>  
>  	pm_runtime_mark_last_busy(drm->dev->dev);
> 
> 
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c
> b/drivers/gpu/drm/nouveau/nouveau_drm.c
> index 5020265bfbd9..48da72caa017 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
> @@ -946,9 +946,6 @@ nouveau_pmops_runtime_resume(struct device *dev)
>  	nvif_mask(&device->object, 0x088488, (1 << 25), (1 << 25));
>  	drm_dev->switch_power_state = DRM_SWITCH_POWER_ON;
>  
> -	/* Monitors may have been connected / disconnected during suspend */
> -	schedule_work(&nouveau_drm(drm_dev)->hpd_work);
> -
>  	return ret;
>  }
>  
-- 
Cheers,
	Lyude Paul

