Return-Path: <SRS0=9smm=S2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40232C282E1
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 23:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18C1B2183E
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 23:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbfDXXDU (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 24 Apr 2019 19:03:20 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33496 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbfDXXDU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Apr 2019 19:03:20 -0400
Received: by mail-qt1-f196.google.com with SMTP id g7so14931001qtc.0
        for <linux-pci@vger.kernel.org>; Wed, 24 Apr 2019 16:03:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=OJQGnyPq3Cj1Oc3L3YD/dEk2D6MaMIS+ZWdsHQ8VMWo=;
        b=oM9rX2WyKiLRontusZIFKKvl8bELP4Xx+Mv/yAM30kv75KC3AGOwy8pozSiW0cXrKo
         zXU5oWuKwoYdE8yRGf7My64IWcd+0feLS64fJIcFaIyFWu/YVzKICJGg5oL5g2HPkG43
         gVw+Plov9EFXPCeLSoNQuE91hBgBgrIzrVu+/ZW7pl8CVSW9zr8zWUZmU5oXTp61a1nO
         tzhBFKorKYVaxEXWhCDEpuVhjt1Xl0ieYvd5J4IgPCKZp4piTD8v/lk2FG38/Z9e/nGu
         f97usgMtyIQtszFvFuSY53ys7oFC1QN/+7jcKZ66ZFmovxFEQQuQ3e8m07sHR93CvEu0
         WSWw==
X-Gm-Message-State: APjAAAW0agJ3vePhJnSSyWLdfaaDxqSGxqG8uwMn9+8J8BIXSByjCU0B
        Sji44t9te9zImNlHVPe0RGo9bA==
X-Google-Smtp-Source: APXvYqxoRHP8PINzug2zepzifIFiSsXEhHp6V/i2TCzSOPpQeaiKJD9JsI28XUcNXCFDRj9dN1BRlg==
X-Received: by 2002:a0c:b012:: with SMTP id k18mr27383700qvc.243.1556146998801;
        Wed, 24 Apr 2019 16:03:18 -0700 (PDT)
Received: from dhcp-10-20-1-11.bss.redhat.com ([144.121.20.162])
        by smtp.gmail.com with ESMTPSA id q50sm13334490qtq.34.2019.04.24.16.03.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 16:03:17 -0700 (PDT)
Message-ID: <0fde652ad43ad3eaaa0f6dae34377cdf479697ec.camel@redhat.com>
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
Date:   Wed, 24 Apr 2019 19:03:16 -0400
In-Reply-To: <20190424223638.GC11428@google.com>
References: <20190212220230.1568-1-lyude@redhat.com>
         <20190215004329.GR96272@google.com>
         <2fca9a9feafcd17b27bc71994a71ebc241a93e9a.camel@redhat.com>
         <52b17f8cb24e179e9661d75548d193843ae87b4c.camel@redhat.com>
         <20190321224819.GK251185@google.com> <20190322113015.GM251185@google.com>
         <20190404141724.GJ141706@google.com>
         <3987ad435bfdb2d92e5e42648174634814b1646d.camel@redhat.com>
         <20190424185937.GB11428@google.com>
         <4e45b65b2151293d91dfc5811f64f3453f591f9d.camel@redhat.com>
         <20190424223638.GC11428@google.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 2019-04-24 at 17:36 -0500, Bjorn Helgaas wrote:
> On Wed, Apr 24, 2019 at 03:16:37PM -0400, Lyude Paul wrote:
> > On Wed, 2019-04-24 at 13:59 -0500, Bjorn Helgaas wrote:
> > > Not being a scheduled work expert, I was unsure if this experiment was
> > > equivalent to what I proposed.
> > > 
> > > I'm always suspicious of singleton solutions like this (using
> > > schedule_work() in runtime_resume()) because usually they seem to be
> > > solving a generic problem that should happen on many kinds of
> > > hardware.  The 0b2fe6594fa2 ("drm/nouveau: Queue hpd_work on (runtime)
> > > resume") commit log says:
> > > 
> > >   We need to call drm_helper_hpd_irq_event() on resume to properly
> > >   detect monitor connection / disconnection on some laptops, use
> > >   hpd_work for this to avoid deadlocks.
> > > 
> > > The situation of a monitor being connected or disconnected during
> > > suspend can happen to *any* GPU, but the commit only changes nouveau,
> > > which of course raises the question of how we deal with that in other
> > > drivers.  If the Nvidia GPU has some unique behavior related to
> > > monitor connection, that would explain special-case code there, but
> > > the commit doesn't mention anything like that.
> > > 
> > > It should be simple to revert 0b2fe6594fa2 and see whether it changes
> > > the behavior at all (well, simple except for the fact that this
> > > problem isn't 100% reproducible in the first place).
> > 
> > It's not 100% reproducible, but it's at least 90% so it's not
> > difficult for me to test at all.
> > 
> > Also, reverting this commit makes no difference either. 
> 
> OK, great, that makes it crystal clear.  I didn't know you had
> specifically tested that revert.  Thanks for doing that.
> 
> > Note that while that commit only changed nouveau, scheduled_work()
> > is exactly how a number of other drivers (i915 for instance) handle
> > reprobing like this as well.
> 
> OK.  The GPU code would be a lot more approachable if similar things
> were done in similar ways.  I spent an hour or so looking for this
> similar code in i915, but gave up.

We try
> 
> > The reason being that we can't do full connector reprobing in our
> > runtime resume thread because we could deadlock if someone else is
> > holding a modesetting lock we need and waiting on us to resume at
> > the same time (there's a number of other bug fixes in nouveau for
> > other issues caused by the same deadlock scenario). 
> 
> You mention nouveau specifically here, but I assume this is a generic
> deadlock scenario that applies to any GPU, and they all avoid the
> deadlock in the same way.  Right?

Yes-there is only one exception in the tree that I know of (amdgpu/radeon),
but fixing that is on my todo if someone else hasn't already gotten to it yet.

> 
> > I'm confused here though, it sounds like you're running under the
> > assumption that PCI devices like this aren't reset into a clean
> > state during a system reboot, is that correct?
> 
> No, I wasn't trying to say anything about that.  My point here is
> that:
> 
>   - you're reporting a problem that only happens with nouveau and
>     only happens during shutdown/reboot
>   - the behavior is similar to a race (not 100% reproducible, seems
>     to happen more if shutdown is faster)
>   - shutdown involves resuming the device (see pci_device_shutdown())
>   - nouveau_pmops_runtime_resume() schedules asynchronous work, which
>     (to my untrained eye) looks unusual
>   - asynchronous work is inherently subject to races
> 
> So I think that's all somewhat suspicious.  But if the same problem
> happens without the asynchronous work, obviously the issue is
> elsewhere.
> 
> But you *are* right that if the device were actually reset, none of
> this should matter.  It certainly seems that the BIOS neglects to
> reset it in some cases.
> 
> I can sort of imagine a BIOS engineer thinking that if the device
> looks like it's in use, we shouldn't reset it, and it's still
> conceivable that some sort of Linux shutdown race could leave it
> looking like it's in use.  But you've been working with Lenovo on
> this, and it seems like that would be pretty obvious to somebody with
> the BIOS source (though I just demonstrated above that even with the
> source it's easy to miss things).

Yeah, that's what I thought as well! This experience has taught me that
there's a surprising amount of things about BIOSes that BIOS engineers don't
seem to know about…

> 
> I'm out of ideas, so I think your quirk is the best way forward.  I
> trimmed out some of the commit log backtraces and such, added the
> bugzilla, and tweaked the patch to use pci_iomap() instead of
> ioremap().  Would the patch below work for you?

Works for me, tested on the problematic P50 as well.

> 
> 
> commit 18dc5b3c7ddc
> Author: Lyude Paul <lyude@redhat.com>
> Date:   Tue Feb 12 17:02:30 2019 -0500
> 
>     PCI: Reset Lenovo ThinkPad P50 nvgpu at boot if necessary
>     
>     On ThinkPad P50 SKUs with an Nvidia Quadro M1000M instead of the M2000M
>     variant, the BIOS does not always reset the secondary Nvidia GPU during
>     reboot if the laptop is configured in Hybrid Graphics mode.  The reason
> is
>     unknown, but the following steps and possibly a good bit of patience
> will
>     reproduce the issue:
>     
>       1. Boot up the laptop normally in Hybrid Graphics mode
>       2. Make sure nouveau is loaded and that the GPU is awake
>       2. Allow the Nvidia GPU to runtime suspend itself after being idle
>       3. Reboot the machine, the more sudden the better (e.g sysrq-b may
> help)
>       4. If nouveau loads up properly, reboot the machine again and go back
> to
>          step 2 until you reproduce the issue
>     
>     This results in some very strange behavior: the GPU will be left in
> exactly
>     the same state it was in when the previously booted kernel started the
>     reboot.  This has all sorts of bad side effects: for starters, this
>     completely breaks nouveau starting with a mysterious EVO channel failure
>     that happens well before we've actually used the EVO channel for
> anything:
>     
>       nouveau 0000:01:00.0: disp: chid 0 mthd 0000 data 00000400 00001000
> 00000002
>     
>     This causes a timeout trying to bring up the GR ctx:
>     
>       nouveau 0000:01:00.0: timeout
>       WARNING: CPU: 0 PID: 12 at
> drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgf100.c:1547
> gf100_grctx_generate+0x7b2/0x850 [nouveau]
>       Hardware name: LENOVO 20EQS64N0B/20EQS64N0B, BIOS N1EET82W (1.55 )
> 12/18/2018
>       Workqueue: events_long drm_dp_mst_link_probe_work [drm_kms_helper]
>       ...
>       nouveau 0000:01:00.0: gr: wait for idle timeout (en: 1, ctxsw: 0,
> busy: 1)
>       nouveau 0000:01:00.0: gr: wait for idle timeout (en: 1, ctxsw: 0,
> busy: 1)
>       nouveau 0000:01:00.0: fifo: fault 01 [WRITE] at 0000000000008000
> engine 00 [GR] client 15 [HUB/SCC_NB] reason c4 [] on channel -1 [0000000000
> unknown]
>     
>     The GPU never manages to recover.  Booting without loading nouveau
> causes
>     issues as well, since the GPU starts sending spurious interrupts that
> cause
>     other device's IRQs to get disabled by the kernel:
>     
>       irq 16: nobody cared (try booting with the "irqpoll" option)
>       ...
>       handlers:
>       [<000000007faa9e99>] i801_isr [i2c_i801]
>       Disabling IRQ #16
>       ...
>       serio: RMI4 PS/2 pass-through port at rmi4-00.fn03
>       i801_smbus 0000:00:1f.4: Timeout waiting for interrupt!
>       i801_smbus 0000:00:1f.4: Transaction timeout
>       rmi4_f03 rmi4-00.fn03: rmi_f03_pt_write: Failed to write to F03 TX
> register (-110).
>       i801_smbus 0000:00:1f.4: Timeout waiting for interrupt!
>       i801_smbus 0000:00:1f.4: Transaction timeout
>       rmi4_physical rmi4-00: rmi_driver_set_irq_bits: Failed to change
> enabled interrupts!
>     
>     This causes the touchpad and sometimes other things to get disabled.
>     
>     Since this happens without nouveau, we can't fix this problem from
> nouveau
>     itself.
>     
>     Add a PCI quirk for the specific P50 variant of this GPU.  Make sure the
>     GPU is advertising NoReset- so we don't reset the GPU when the machine
> is
>     in Dedicated graphics mode (where the GPU being initialized by the BIOS
> is
>     normal and expected).  Map the GPU MMIO space and read the magic 0x2240c
>     register, which will have bit 1 set if the device was POSTed during a
>     previous boot.  Once we've confirmed all of this, reset the GPU and
>     re-disable it - bringing it back to a healthy state.
>     
>     Link: https://bugzilla.kernel.org/show_bug.cgi?id=203003
>     Link: 
> https://lore.kernel.org/lkml/20190212220230.1568-1-lyude@redhat.com
>     Signed-off-by: Lyude Paul <lyude@redhat.com>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>     Cc: nouveau@lists.freedesktop.org
>     Cc: dri-devel@lists.freedesktop.org
>     Cc: Karol Herbst <kherbst@redhat.com>
>     Cc: Ben Skeggs <skeggsb@gmail.com>
>     Cc: stable@vger.kernel.org
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index a59ad09ce911..819a595b0b1d 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5120,3 +5120,61 @@ SWITCHTEC_QUIRK(0x8573);  /* PFXI 48XG3 */
>  SWITCHTEC_QUIRK(0x8574);  /* PFXI 64XG3 */
>  SWITCHTEC_QUIRK(0x8575);  /* PFXI 80XG3 */
>  SWITCHTEC_QUIRK(0x8576);  /* PFXI 96XG3 */
> +
> +/*
> + * On Lenovo Thinkpad P50 SKUs with a Nvidia Quadro M1000M, the BIOS does
> + * not always reset the secondary Nvidia GPU between reboots if the system
> + * is configured to use Hybrid Graphics mode.  This results in the GPU
> + * being left in whatever state it was in during the *previous* boot, which
> + * causes spurious interrupts from the GPU, which in turn causes us to
> + * disable the wrong IRQ and end up breaking the touchpad.  Unsurprisingly,
> + * this also completely breaks nouveau.
> + *
> + * Luckily, it seems a simple reset of the Nvidia GPU brings it back to a
> + * clean state and fixes all these issues.
> + *
> + * When the machine is configured in Dedicated display mode, the issue
> + * doesn't occur.  Fortunately the GPU advertises NoReset+ when in this
> + * mode, so we can detect that and avoid resetting it.
> + */
> +static void quirk_reset_lenovo_thinkpad_p50_nvgpu(struct pci_dev *pdev)
> +{
> +	void __iomem *map;
> +	int ret;
> +
> +	if (pdev->subsystem_vendor != PCI_VENDOR_ID_LENOVO ||
> +	    pdev->subsystem_device != 0x222e ||
> +	    !pdev->reset_fn)
> +		return;
> +
> +	if (pci_enable_device_mem(pdev))
> +		return;
> +
> +	/*
> +	 * Based on nvkm_device_ctor() in
> +	 * drivers/gpu/drm/nouveau/nvkm/engine/device/base.c
> +	 */
> +	map = pci_iomap(pdev, 0, 0x23000);
> +	if (!map) {
> +		pci_err(pdev, "Can't map MMIO space\n");
> +		goto out_disable;
> +	}
> +
> +	/*
> +	 * Make sure the GPU looks like it's been POSTed before resetting
> +	 * it.
> +	 */
> +	if (ioread32(map + 0x2240c) & 0x2) {
> +		pci_info(pdev, FW_BUG "GPU left initialized by EFI,
> resetting\n");
> +		ret = pci_reset_function(pdev);
> +		if (ret < 0)
> +			pci_err(pdev, "Failed to reset GPU: %d\n", ret);
> +	}
> +
> +	iounmap(map);
> +out_disable:
> +	pci_disable_device(pdev);
> +}
> +DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, 0x13b1,
> +			      PCI_CLASS_DISPLAY_VGA, 8,
> +			      quirk_reset_lenovo_thinkpad_p50_nvgpu);
-- 
Cheers,
	Lyude Paul

