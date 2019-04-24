Return-Path: <SRS0=9smm=S2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0611BC10F11
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 22:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD1FA208E4
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 22:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556145403;
	bh=sgHZdvRFoV1JAO3JhbtTQgcbbBaHHOdARzFokTOeNvQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FVM1rymRO7KqN5SX6eL+pgj0b0LyWGCVfksXoWs68HUIOw8Xkdeynq3nkKbLitzhp
	 C1aaz3ay9FWBuMq3qKYqYwgBu+hStE2T71ALmbgSM2mi4HBZwiy6m6Smjb3RTDZ7F/
	 UTIipN73krpPjHiAB05EKzM/9ER2Bvw4RxOyAek8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbfDXWgn (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 24 Apr 2019 18:36:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:56808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726291AbfDXWgm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Apr 2019 18:36:42 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1BA7208E4;
        Wed, 24 Apr 2019 22:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556145401;
        bh=sgHZdvRFoV1JAO3JhbtTQgcbbBaHHOdARzFokTOeNvQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P68SNt/w9wbcBT+yYsf7tJLpEzRFnvbmrsPZoHXpMRDNqkc22a8hAXlZdmdAvo4sL
         tk8T7jpmhvnWcNHbLr5w5qiIrs1/dziIa3rk75ntvAsDJFKoBaJyfhot0ip4+XWRfs
         VgHYDTptYFyzZE26iHPPYF61D9pSXImxyDq1Btuo=
Date:   Wed, 24 Apr 2019 17:36:38 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lyude Paul <lyude@redhat.com>
Cc:     David Ober <dober@lenovo.com>, linux-pci@vger.kernel.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Karol Herbst <kherbst@redhat.com>,
        Ben Skeggs <skeggsb@gmail.com>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] pci/quirks: Add quirk to reset nvgpu at boot for the
 Lenovo ThinkPad P50
Message-ID: <20190424223638.GC11428@google.com>
References: <20190212220230.1568-1-lyude@redhat.com>
 <20190215004329.GR96272@google.com>
 <2fca9a9feafcd17b27bc71994a71ebc241a93e9a.camel@redhat.com>
 <52b17f8cb24e179e9661d75548d193843ae87b4c.camel@redhat.com>
 <20190321224819.GK251185@google.com>
 <20190322113015.GM251185@google.com>
 <20190404141724.GJ141706@google.com>
 <3987ad435bfdb2d92e5e42648174634814b1646d.camel@redhat.com>
 <20190424185937.GB11428@google.com>
 <4e45b65b2151293d91dfc5811f64f3453f591f9d.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e45b65b2151293d91dfc5811f64f3453f591f9d.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 24, 2019 at 03:16:37PM -0400, Lyude Paul wrote:
> On Wed, 2019-04-24 at 13:59 -0500, Bjorn Helgaas wrote:
> > Not being a scheduled work expert, I was unsure if this experiment was
> > equivalent to what I proposed.
> > 
> > I'm always suspicious of singleton solutions like this (using
> > schedule_work() in runtime_resume()) because usually they seem to be
> > solving a generic problem that should happen on many kinds of
> > hardware.  The 0b2fe6594fa2 ("drm/nouveau: Queue hpd_work on (runtime)
> > resume") commit log says:
> > 
> >   We need to call drm_helper_hpd_irq_event() on resume to properly
> >   detect monitor connection / disconnection on some laptops, use
> >   hpd_work for this to avoid deadlocks.
> > 
> > The situation of a monitor being connected or disconnected during
> > suspend can happen to *any* GPU, but the commit only changes nouveau,
> > which of course raises the question of how we deal with that in other
> > drivers.  If the Nvidia GPU has some unique behavior related to
> > monitor connection, that would explain special-case code there, but
> > the commit doesn't mention anything like that.
> > 
> > It should be simple to revert 0b2fe6594fa2 and see whether it changes
> > the behavior at all (well, simple except for the fact that this
> > problem isn't 100% reproducible in the first place).
> 
> It's not 100% reproducible, but it's at least 90% so it's not
> difficult for me to test at all.
> 
> Also, reverting this commit makes no difference either. 

OK, great, that makes it crystal clear.  I didn't know you had
specifically tested that revert.  Thanks for doing that.

> Note that while that commit only changed nouveau, scheduled_work()
> is exactly how a number of other drivers (i915 for instance) handle
> reprobing like this as well.

OK.  The GPU code would be a lot more approachable if similar things
were done in similar ways.  I spent an hour or so looking for this
similar code in i915, but gave up.

> The reason being that we can't do full connector reprobing in our
> runtime resume thread because we could deadlock if someone else is
> holding a modesetting lock we need and waiting on us to resume at
> the same time (there's a number of other bug fixes in nouveau for
> other issues caused by the same deadlock scenario). 

You mention nouveau specifically here, but I assume this is a generic
deadlock scenario that applies to any GPU, and they all avoid the
deadlock in the same way.  Right?

> I'm confused here though, it sounds like you're running under the
> assumption that PCI devices like this aren't reset into a clean
> state during a system reboot, is that correct?

No, I wasn't trying to say anything about that.  My point here is
that:

  - you're reporting a problem that only happens with nouveau and
    only happens during shutdown/reboot
  - the behavior is similar to a race (not 100% reproducible, seems
    to happen more if shutdown is faster)
  - shutdown involves resuming the device (see pci_device_shutdown())
  - nouveau_pmops_runtime_resume() schedules asynchronous work, which
    (to my untrained eye) looks unusual
  - asynchronous work is inherently subject to races

So I think that's all somewhat suspicious.  But if the same problem
happens without the asynchronous work, obviously the issue is
elsewhere.

But you *are* right that if the device were actually reset, none of
this should matter.  It certainly seems that the BIOS neglects to
reset it in some cases.

I can sort of imagine a BIOS engineer thinking that if the device
looks like it's in use, we shouldn't reset it, and it's still
conceivable that some sort of Linux shutdown race could leave it
looking like it's in use.  But you've been working with Lenovo on
this, and it seems like that would be pretty obvious to somebody with
the BIOS source (though I just demonstrated above that even with the
source it's easy to miss things).

I'm out of ideas, so I think your quirk is the best way forward.  I
trimmed out some of the commit log backtraces and such, added the
bugzilla, and tweaked the patch to use pci_iomap() instead of
ioremap().  Would the patch below work for you?


commit 18dc5b3c7ddc
Author: Lyude Paul <lyude@redhat.com>
Date:   Tue Feb 12 17:02:30 2019 -0500

    PCI: Reset Lenovo ThinkPad P50 nvgpu at boot if necessary
    
    On ThinkPad P50 SKUs with an Nvidia Quadro M1000M instead of the M2000M
    variant, the BIOS does not always reset the secondary Nvidia GPU during
    reboot if the laptop is configured in Hybrid Graphics mode.  The reason is
    unknown, but the following steps and possibly a good bit of patience will
    reproduce the issue:
    
      1. Boot up the laptop normally in Hybrid Graphics mode
      2. Make sure nouveau is loaded and that the GPU is awake
      2. Allow the Nvidia GPU to runtime suspend itself after being idle
      3. Reboot the machine, the more sudden the better (e.g sysrq-b may help)
      4. If nouveau loads up properly, reboot the machine again and go back to
         step 2 until you reproduce the issue
    
    This results in some very strange behavior: the GPU will be left in exactly
    the same state it was in when the previously booted kernel started the
    reboot.  This has all sorts of bad side effects: for starters, this
    completely breaks nouveau starting with a mysterious EVO channel failure
    that happens well before we've actually used the EVO channel for anything:
    
      nouveau 0000:01:00.0: disp: chid 0 mthd 0000 data 00000400 00001000 00000002
    
    This causes a timeout trying to bring up the GR ctx:
    
      nouveau 0000:01:00.0: timeout
      WARNING: CPU: 0 PID: 12 at drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgf100.c:1547 gf100_grctx_generate+0x7b2/0x850 [nouveau]
      Hardware name: LENOVO 20EQS64N0B/20EQS64N0B, BIOS N1EET82W (1.55 ) 12/18/2018
      Workqueue: events_long drm_dp_mst_link_probe_work [drm_kms_helper]
      ...
      nouveau 0000:01:00.0: gr: wait for idle timeout (en: 1, ctxsw: 0, busy: 1)
      nouveau 0000:01:00.0: gr: wait for idle timeout (en: 1, ctxsw: 0, busy: 1)
      nouveau 0000:01:00.0: fifo: fault 01 [WRITE] at 0000000000008000 engine 00 [GR] client 15 [HUB/SCC_NB] reason c4 [] on channel -1 [0000000000 unknown]
    
    The GPU never manages to recover.  Booting without loading nouveau causes
    issues as well, since the GPU starts sending spurious interrupts that cause
    other device's IRQs to get disabled by the kernel:
    
      irq 16: nobody cared (try booting with the "irqpoll" option)
      ...
      handlers:
      [<000000007faa9e99>] i801_isr [i2c_i801]
      Disabling IRQ #16
      ...
      serio: RMI4 PS/2 pass-through port at rmi4-00.fn03
      i801_smbus 0000:00:1f.4: Timeout waiting for interrupt!
      i801_smbus 0000:00:1f.4: Transaction timeout
      rmi4_f03 rmi4-00.fn03: rmi_f03_pt_write: Failed to write to F03 TX register (-110).
      i801_smbus 0000:00:1f.4: Timeout waiting for interrupt!
      i801_smbus 0000:00:1f.4: Transaction timeout
      rmi4_physical rmi4-00: rmi_driver_set_irq_bits: Failed to change enabled interrupts!
    
    This causes the touchpad and sometimes other things to get disabled.
    
    Since this happens without nouveau, we can't fix this problem from nouveau
    itself.
    
    Add a PCI quirk for the specific P50 variant of this GPU.  Make sure the
    GPU is advertising NoReset- so we don't reset the GPU when the machine is
    in Dedicated graphics mode (where the GPU being initialized by the BIOS is
    normal and expected).  Map the GPU MMIO space and read the magic 0x2240c
    register, which will have bit 1 set if the device was POSTed during a
    previous boot.  Once we've confirmed all of this, reset the GPU and
    re-disable it - bringing it back to a healthy state.
    
    Link: https://bugzilla.kernel.org/show_bug.cgi?id=203003
    Link: https://lore.kernel.org/lkml/20190212220230.1568-1-lyude@redhat.com
    Signed-off-by: Lyude Paul <lyude@redhat.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Cc: nouveau@lists.freedesktop.org
    Cc: dri-devel@lists.freedesktop.org
    Cc: Karol Herbst <kherbst@redhat.com>
    Cc: Ben Skeggs <skeggsb@gmail.com>
    Cc: stable@vger.kernel.org

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index a59ad09ce911..819a595b0b1d 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5120,3 +5120,61 @@ SWITCHTEC_QUIRK(0x8573);  /* PFXI 48XG3 */
 SWITCHTEC_QUIRK(0x8574);  /* PFXI 64XG3 */
 SWITCHTEC_QUIRK(0x8575);  /* PFXI 80XG3 */
 SWITCHTEC_QUIRK(0x8576);  /* PFXI 96XG3 */
+
+/*
+ * On Lenovo Thinkpad P50 SKUs with a Nvidia Quadro M1000M, the BIOS does
+ * not always reset the secondary Nvidia GPU between reboots if the system
+ * is configured to use Hybrid Graphics mode.  This results in the GPU
+ * being left in whatever state it was in during the *previous* boot, which
+ * causes spurious interrupts from the GPU, which in turn causes us to
+ * disable the wrong IRQ and end up breaking the touchpad.  Unsurprisingly,
+ * this also completely breaks nouveau.
+ *
+ * Luckily, it seems a simple reset of the Nvidia GPU brings it back to a
+ * clean state and fixes all these issues.
+ *
+ * When the machine is configured in Dedicated display mode, the issue
+ * doesn't occur.  Fortunately the GPU advertises NoReset+ when in this
+ * mode, so we can detect that and avoid resetting it.
+ */
+static void quirk_reset_lenovo_thinkpad_p50_nvgpu(struct pci_dev *pdev)
+{
+	void __iomem *map;
+	int ret;
+
+	if (pdev->subsystem_vendor != PCI_VENDOR_ID_LENOVO ||
+	    pdev->subsystem_device != 0x222e ||
+	    !pdev->reset_fn)
+		return;
+
+	if (pci_enable_device_mem(pdev))
+		return;
+
+	/*
+	 * Based on nvkm_device_ctor() in
+	 * drivers/gpu/drm/nouveau/nvkm/engine/device/base.c
+	 */
+	map = pci_iomap(pdev, 0, 0x23000);
+	if (!map) {
+		pci_err(pdev, "Can't map MMIO space\n");
+		goto out_disable;
+	}
+
+	/*
+	 * Make sure the GPU looks like it's been POSTed before resetting
+	 * it.
+	 */
+	if (ioread32(map + 0x2240c) & 0x2) {
+		pci_info(pdev, FW_BUG "GPU left initialized by EFI, resetting\n");
+		ret = pci_reset_function(pdev);
+		if (ret < 0)
+			pci_err(pdev, "Failed to reset GPU: %d\n", ret);
+	}
+
+	iounmap(map);
+out_disable:
+	pci_disable_device(pdev);
+}
+DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, 0x13b1,
+			      PCI_CLASS_DISPLAY_VGA, 8,
+			      quirk_reset_lenovo_thinkpad_p50_nvgpu);
