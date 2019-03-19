Return-Path: <SRS0=xwy5=RW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A2BC43381
	for <linux-pci@archiver.kernel.org>; Tue, 19 Mar 2019 20:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 485902175B
	for <linux-pci@archiver.kernel.org>; Tue, 19 Mar 2019 20:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbfCSU4H (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 19 Mar 2019 16:56:07 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39030 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfCSU4H (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Mar 2019 16:56:07 -0400
Received: by mail-qt1-f193.google.com with SMTP id t28so49416qte.6
        for <linux-pci@vger.kernel.org>; Tue, 19 Mar 2019 13:56:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=21SMHLnaFYbuf8HRUUH9wZvrGITMExP5/OJO56UdI6Y=;
        b=tqn1WYjXjapjnHDrGkWzREGW6hHgFamzU7X57Tvx3gg6/2rbpCqmv40RhHvnla2ogl
         vuAi8s5x7qQfgP6Cpucumv7on9k8/67vXxCPiVZQgRlrI6rmCPPdd5RGf+I6XIgMY46N
         tSWEd2LE/svD4zzVNjPQVdqKHi7hB8D3Oy3W4YMltyWSEw9G565kgThfL373fwPY9Q+l
         U+Q6nBJTo35KfuzvhbWs3iiV1v/FAZg/MrW3oP/FurHsq0PtFC1QD5k7QsKcc1airyA9
         k4Nstbl9fA1cukkAocAg5ef0YSxvQ4qv1RabAP2iM1fsRB209PRotrnCIyytItFypqYg
         mVQw==
X-Gm-Message-State: APjAAAWIfo80W2n4ClkWD/rcpofklzFcpFslBZId8LIexONN1gufemCD
        ztWphIk+N9LCNR+1FclImZVg/A==
X-Google-Smtp-Source: APXvYqyEdZjqfapcBHouPJijTlhdPXTQysAMsGCnyl6Ue8Ze6a/IkRQCjGsKxnK/Cm2jASll4d6bGQ==
X-Received: by 2002:ac8:2d62:: with SMTP id o31mr3948611qta.370.1553028965527;
        Tue, 19 Mar 2019 13:56:05 -0700 (PDT)
Received: from dhcp-10-20-1-11.bss.redhat.com ([144.121.20.162])
        by smtp.gmail.com with ESMTPSA id o19sm38710qkl.65.2019.03.19.13.56.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 13:56:04 -0700 (PDT)
Message-ID: <1e73b768ac65033658740abe553291fd3b0496c6.camel@redhat.com>
Subject: Re: [PATCH] pci/quirks: Add quirk to reset nvgpu at boot for the
 Lenovo ThinkPad P50
From:   Lyude Paul <lyude@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>, David Ober <dober@lenovo.com>
Cc:     linux-pci@vger.kernel.org, nouveau@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, Karol Herbst <kherbst@redhat.com>,
        Ben Skeggs <skeggsb@gmail.com>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 19 Mar 2019 16:56:03 -0400
In-Reply-To: <52b17f8cb24e179e9661d75548d193843ae87b4c.camel@redhat.com>
References: <20190212220230.1568-1-lyude@redhat.com>
         <20190215004329.GR96272@google.com>
         <2fca9a9feafcd17b27bc71994a71ebc241a93e9a.camel@redhat.com>
         <52b17f8cb24e179e9661d75548d193843ae87b4c.camel@redhat.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Bump, sorry to bug you but is there any update on this or any information you
still need from me which would help get this upstream?

On Wed, 2019-03-13 at 18:25 -0400, Lyude Paul wrote:
> [note to David Ober: you -should- be able to reply to this, hopefully, but I
> haven't actually tested that so results may vary]
> 
> Hi again! Sorry I didn't fully answer all of the questions you originally
> asked in this email, I had to get in contact with Lenovo to make sure that
> it
> was OK for me to disclose more details on this bug (and I had PTO scheduled
> immediately after I asked). I've added David Ober from Lenovo to this thread
> as well. So now that I've got Lenovo's approval I can answer those
> questions,
> and give some better answers for the others! (see below)
> 
> 
> On Fri, 2019-02-15 at 16:17 -0500, Lyude Paul wrote:
> > On Thu, 2019-02-14 at 18:43 -0600, Bjorn Helgaas wrote:
> > > Hi Lyude,
> > > 
> > > On Tue, Feb 12, 2019 at 05:02:30PM -0500, Lyude Paul wrote:
> > > > On a very specific subset of ThinkPad P50 SKUs, particularly ones that
> > > > come with a Quadro M1000M chip instead of the M2000M variant, the BIOS
> > > > seems to have a very nasty habit of not always resetting the secondary
> > > > Nvidia GPU between full reboots if the laptop is configured in Hybrid
> > > > Graphics mode. The reason for this happening is unknown, but the
> > > > following steps and possibly a good bit of patience will reproduce the
> > > > issue:
> > > > 
> > > > 1. Boot up the laptop normally in Hybrid graphics mode
> > > > 2. Make sure nouveau is loaded and that the GPU is awake
> > > > 2. Allow the nvidia GPU to runtime suspend itself after being idle
> > > > 3. Reboot the machine, the more sudden the better (e.g sysrq-b may
> > > > help)
> > > > 4. If nouveau loads up properly, reboot the machine again and go back
> > > > to
> > > > step 2 until you reproduce the issue
> > > > 
> > > > This results in some very strange behavior: the GPU will
> > > > quite literally be left in exactly the same state it was in when the
> > > > previously booted kernel started the reboot. This has all sorts of bad
> > > > sideaffects: for starters, this completely breaks nouveau starting
> > > > with
> > > > a
> > > > mysterious EVO channel failure that happens well before we've actually
> > > > used the EVO channel for anything:
> > > 
> > > There are a lot of moving parts here that are probably obvious to you
> > > but not to me.  I need help untangling this a bit so I'm comfortable
> > > that we got to the root cause and that we're doing something logical
> > > as opposed to something that just happens to make things work.  I
> > > really don't know enough to even ask the right questions...
> > 
> > I completely understand! I'm pretty sure I'd be just as skeptical if I was
> > in
> > your position reviewing a patch like this :P
> > 
> > > Is there a bug report for this?  Bugzilla.kernel.org would be ideal,
> > > including "lspci -vvxxx" and dmidecode for the system.
> > > 
> > Not yet, but there has been discussion about this between nouveau
> > developers
> > on our IRC channel.
> I lied: yes there actually is a bug report for this, but it's currently on
> the
> Red Hat bugzilla. I can get more information from it if you need (with
> lenovo's approval of course).
> 
> > > Is this running a current BIOS?  The date in your log below looks
> > > pretty recent, so I assume it is current.
> > 
> > Yes, this is the most up to date BIOS available for this system.
> 
> And additionally: I've been working with Lenovo on this issue for a couple
> of
> months now, and we've gone through dozens of different trial BIOSes with no
> success thus far. However, Lenovo is currently working on trying to add this
> workaround into their BIOS but I've been told that this change is going to
> take a decent amount of time since they need to test it across multiple
> operating systems. I'd be happy to come back and add a conditional later to
> turn this workaround off for later BIOS versions once Lenovo has released a
> proper fix.
> 
> With all of that being said, [how] do you think we should proceed?
> 
> > > I assume "hybrid graphics" means you have two GPUs.  Do you select
> > > hybrid graphics mode in the BIOS?
> > 
> > Yes, the P50 has two available modes in the BIOS: Dedicated (e.g. only
> > the nvidia GPU is used for everything), and Hybrid (i915 drives the
> > built-in display panel, nouveau drives everything else). This bug only
> > seems to occur in Hybrid mode.
> > 
> > > I assume when you say the Nvidia GPU doesn't get reset on a full
> > > reboot, you're talking about a "warm reboot", and that if you actually
> > > remove the power and do a cold reboot, there's no problem?
> > 
> > If you meant "unplugging the power adapter" when you said cutting the
> > power we don't need to go that far, but shutting down the machine and
> > restarting it by hand does avoid the problem yes.
> > 
> > > I assume Nvidia GPU being active means you are using the performance
> > > GPU.  Does that mean the integrated GPU is completely unused and Linux
> > > does nothing at all with it?  Is Linux doing any switching between
> > > them?  If so, how?  I am not 100% confident in the code I've seen that
> > > does the switching.
> > 
> > "Switching" isn't really the right word to describe it these days as the
> > process for how this is handled has changed quite a bit in the last few
> > years. As I mentioned above, the main intel GPU is used for driving the
> > built-in display. As for the nvidia GPU, it's used to drive any kind of
> > external displays connected to the P50 and can also be used to do
> > rendering through DRI PRIME. The connector hookups are mostly hardcoded
> > as there isn't really much of a mux, unlike the old days where we could
> > actually do things like switch which GPU was driving the internal
> > display on the fly with  vga-switcheroo using the _DSM methods provided
> > by ACPI.
> > 
> > Nowadays muxless laptops like the ThinkPad P50 don't make much use of
> > _DSM for power management and instead just runtime suspend the dedicated
> > nvidia GPU when it's not in use. We rely on the PCI subsystem to invoke
> > the _PR3 ACPI methods for suspending and resuming the GPU and don't
> > handle much of it ourselves anymore:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/nouveau/nouveau_drm.c?h=v5.0-rc6#n860
> > 
> > (You can ignore the call to nouveau_switcheroo_optimus_dsm() there; it
> >  doesn't do anything on systems like the P50 where we detect _PR3)
> > 
> > Additionally-if you see any problems with how we're handling things
> > there we're all ears! We've been trying to fix as many issues with
> > runtime PM as we can find.
> > 
> > Something else to consider here too: I've only ever managed to reproduce
> > this issue on this specific P50 SKU. Since I work on Desktop engineering
> > at Red Hat we have access to a very large number of laptops with hybrid
> > GPU setups. Interestingly I haven't ever reproduced anything like this
> > on any of them, even P50 SKUs with the M2000M GPU instead of the M1000M
> > (which are almost identical, they're both GM107 chips) I can follow the
> > same steps that I followed to reproduce this bug and it never appears.
> > 
> > Another thing to note: this bug also doesn't appear to happen 100% of
> > the time. Some warm reboots the GPU will be reset by the BIOS perfectly
> > fine.
> > 
> > > > nouveau 0000:01:00.0: disp: chid 0 mthd 0000 data 00000400 00001000
> > > > 00000002
> > > > 
> > > > Later on, this causes us to timeout trying to bring up the GR ctx:
> > > > 
> > > > ------------[ cut here ]------------
> > > > nouveau 0000:01:00.0: timeout
> > > > WARNING: CPU: 0 PID: 12 at
> > > > drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgf100.c:1547
> > > > gf100_grctx_generate+0x7b2/0x850 [nouveau]
> > > > Modules linked in: nouveau mxm_wmi i915 crc32c_intel ttm i2c_algo_bit
> > > > serio_raw drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops
> > > > xhci_pci drm xhci_hcd i2c_core wmi video
> > > > CPU: 0 PID: 12 Comm: kworker/0:1 Not tainted 5.0.0-rc5Lyude-Test+ #29
> > > > Hardware name: LENOVO 20EQS64N0B/20EQS64N0B, BIOS N1EET82W (1.55 )
> > > > 12/18/2018
> > > > Workqueue: events_long drm_dp_mst_link_probe_work [drm_kms_helper]
> > > > RIP: 0010:gf100_grctx_generate+0x7b2/0x850 [nouveau]
> > > > Code: 85 d2 75 04 48 8b 57 10 48 89 95 28 ff ff ff e8 b4 37 0e e1 48
> > > > 8b
> > > > 95 28 ff ff ff 48 c7 c7 b1 97 57 a0 48 89 c6 e8 5a 38 c0 e0 <0f> 0b e9
> > > > b9 fd ff ff 48 8b 85 60 ff ff ff 48 8b 40 10 48 8b 78 10
> > > > RSP: 0018:ffffc900000b77f0 EFLAGS: 00010286
> > > > RAX: 0000000000000000 RBX: ffff888871af8000 RCX: 0000000000000000
> > > > RDX: ffff88887f41dfe0 RSI: ffff88887f415698 RDI: ffff88887f415698
> > > > RBP: ffffc900000b78c8 R08: 0000000000000000 R09: 0000000000000000
> > > > R10: 0000000000000000 R11: 0000000000000000 R12: ffff888872118000
> > > > R13: 0000000000000000 R14: ffffffffa0551420 R15: ffffc900000b7818
> > > > FS:  0000000000000000(0000) GS:ffff88887f400000(0000)
> > > > knlGS:0000000000000000
> > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > CR2: 00005644d0556ca8 CR3: 0000000002214006 CR4: 00000000003606f0
> > > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > > Call Trace:
> > > >  gf100_gr_init_ctxctl+0x27b/0x2d0 [nouveau]
> > > >  gf100_gr_init+0x5bd/0x5e0 [nouveau]
> > > >  gf100_gr_init_+0x61/0x70 [nouveau]
> > > >  nvkm_gr_init+0x1d/0x20 [nouveau]
> > > >  nvkm_engine_init+0xcb/0x210 [nouveau]
> > > >  nvkm_subdev_init+0xd6/0x230 [nouveau]
> > > >  nvkm_engine_ref.part.0+0x52/0x70 [nouveau]
> > > >  nvkm_engine_ref+0x13/0x20 [nouveau]
> > > >  nvkm_ioctl_new+0x12c/0x260 [nouveau]
> > > >  ? nvkm_fifo_chan_child_del+0xa0/0xa0 [nouveau]
> > > >  ? gf100_gr_dtor+0xe0/0xe0 [nouveau]
> > > >  nvkm_ioctl+0xe2/0x180 [nouveau]
> > > >  nvkm_client_ioctl+0x12/0x20 [nouveau]
> > > >  nvif_object_ioctl+0x47/0x50 [nouveau]
> > > >  nvif_object_init+0xc8/0x120 [nouveau]
> > > >  nvc0_fbcon_accel_init+0x5c/0x960 [nouveau]
> > > >  nouveau_fbcon_create+0x5a5/0x5d0 [nouveau]
> > > >  ? drm_setup_crtcs+0x27b/0xcb0 [drm_kms_helper]
> > > >  ? __lock_is_held+0x5e/0xa0
> > > >  __drm_fb_helper_initial_config_and_unlock+0x27c/0x520
> > > > [drm_kms_helper]
> > > >  drm_fb_helper_hotplug_event.part.29+0xae/0xc0 [drm_kms_helper]
> > > >  drm_fb_helper_hotplug_event+0x1c/0x30 [drm_kms_helper]
> > > >  nouveau_fbcon_output_poll_changed+0xb8/0x110 [nouveau]
> > > >  drm_kms_helper_hotplug_event+0x2a/0x40 [drm_kms_helper]
> > > >  drm_dp_send_link_address+0x176/0x1c0 [drm_kms_helper]
> > > >  drm_dp_check_and_send_link_address+0xa0/0xb0 [drm_kms_helper]
> > > >  drm_dp_mst_link_probe_work+0xa4/0xc0 [drm_kms_helper]
> > > >  process_one_work+0x22f/0x5c0
> > > >  worker_thread+0x44/0x3a0
> > > >  kthread+0x12b/0x150
> > > >  ? wq_pool_ids_show+0x140/0x140
> > > >  ? kthread_create_on_node+0x60/0x60
> > > >  ret_from_fork+0x3a/0x50
> > > > irq event stamp: 22490
> > > > hardirqs last  enabled at (22489): [<ffffffff8113281d>]
> > > > console_unlock+0x44d/0x5f0
> > > > hardirqs last disabled at (22490): [<ffffffff81001c03>]
> > > > trace_hardirqs_off_thunk+0x1a/0x1c
> > > > softirqs last  enabled at (22486): [<ffffffff81c00330>]
> > > > __do_softirq+0x330/0x44d
> > > > softirqs last disabled at (22479): [<ffffffff810c3105>]
> > > > irq_exit+0xe5/0xf0
> > > > WARNING: CPU: 0 PID: 12 at
> > > > drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgf100.c:1547
> > > > gf100_grctx_generate+0x7b2/0x850 [nouveau]
> > > > ---[ end trace bf0976ed88b122a8 ]---
> > > > nouveau 0000:01:00.0: gr: wait for idle timeout (en: 1, ctxsw: 0,
> > > > busy:
> > > > 1)
> > > > nouveau 0000:01:00.0: gr: wait for idle timeout (en: 1, ctxsw: 0,
> > > > busy:
> > > > 1)
> > > > nouveau 0000:01:00.0: fifo: fault 01 [WRITE] at 0000000000008000
> > > > engine
> > > > 00 [GR] client 15 [HUB/SCC_NB] reason c4 [] on channel -1 [0000000000
> > > > unknown]
> > > > 
> > > > From which the GPU never manages to recover. Booting without nouveau
> > > > loading causes issues as well, since the GPU starts sending spurious
> > > > interrupts that cause other device's IRQs to get disabled by the
> > > > kernel:
> > > > 
> > > > irq 16: nobody cared (try booting with the "irqpoll" option)
> > > > …
> > > > handlers:
> > > > [<000000007faa9e99>] i801_isr [i2c_i801]
> > > > Disabling IRQ #16
> > > > …
> > > > serio: RMI4 PS/2 pass-through port at rmi4-00.fn03
> > > > i801_smbus 0000:00:1f.4: Timeout waiting for interrupt!
> > > > i801_smbus 0000:00:1f.4: Transaction timeout
> > > > rmi4_f03 rmi4-00.fn03: rmi_f03_pt_write: Failed to write to F03 TX
> > > > register (-110).
> > > > i801_smbus 0000:00:1f.4: Timeout waiting for interrupt!
> > > > i801_smbus 0000:00:1f.4: Transaction timeout
> > > > rmi4_physical rmi4-00: rmi_driver_set_irq_bits: Failed to change
> > > > enabled
> > > > interrupts!
> > > > 
> > > > Which in turn causes the touchpad and sometimes even other things to
> > > > get
> > > > disabled.
> > > > 
> > > > Since the GPU staying on causes problems even without nouveau's
> > > > intervention, we can't fix this problem from nouveau itself. We have
> > > > to
> > > > fix it as early as possible in the boot sequence in order to make sure
> > > > that the GPU is in a clean state before it has a chance to spam us
> > > > with
> > > > interrupts and break things.
> > > 
> > > Was nouveau loaded *before* the reboot?  Or can you reproduce the
> > > spurious interrupts even if you do a cold reboot without nouveau, then
> > > a warm reboot again without nouveau?
> > 
> > Nouveau was loaded before the reboot, yes, and as far as I'm aware this
> > bug won't show up following the steps you described here. We wouldn't
> > really notice the interrupts if this bug happened without nouveau loaded
> > (since the BIOS doesn't arm them). However, I can confirm it's being
> > reset each on each warm reboot when nouveau's completely disabled by
> > sticking values into some MMIO registers we know the VBIOS doesn't touch
> > followed by rebooting in order to see if they retain their value (this
> > is how I discovered that the GPU wasn't being power cycled in the first
> > place, if the values I stick into said registers gets cleared after
> > reboot then the GPU was reset, otherwise it wasn't).
> > 
> > 
> > > > So to do this, we add a new pci quirk using
> > > > DECLARE_PCI_FIXUP_CLASS_FINAL that will be invoked before the PCI
> > > > probe
> > > > at boot finishes. From there, we check to make sure that this is
> > > > indeed
> > > > the specific P50 variant of this GPU. We also make sure that the GPU
> > > > PCI
> > > > device is advertising NoReset- in order to prevent us from trying to
> > > > reset the GPU when the machine is in Dedicated graphics mode (where
> > > > the
> > > > GPU being initialized by the BIOS is normal and expected). Finally, we
> > > > try mapping the MMIO space for the GPU which should only work if the
> > > > GPU
> > > > is actually active in D0 mode. We can then read the magic 0x2240c
> > > > register on the GPU, which will have bit 1 set if the GPU's firmware
> > > > has
> > > > already been posted during a previous boot. Once we've confirmed all
> > > > of
> > > > this, we reset the PCI device and re-disable it - bringing the GPU
> > > > back
> > > > into a healthy state.
> > > > 
> > > > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > > > Cc: nouveau@lists.freedesktop.org
> > > > Cc: dri-devel@lists.freedesktop.org
> > > > Cc: Karol Herbst <kherbst@redhat.com>
> > > > Cc: Ben Skeggs <skeggsb@gmail.com>
> > > > Cc: stable@vger.kernel.org
> > > > ---
> > > >  drivers/pci/quirks.c | 65
> > > > ++++++++++++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 65 insertions(+)
> > > > 
> > > > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > > > index b0a413f3f7ca..948492fda8bf 100644
> > > > --- a/drivers/pci/quirks.c
> > > > +++ b/drivers/pci/quirks.c
> > > > @@ -5117,3 +5117,68 @@ SWITCHTEC_QUIRK(0x8573);  /* PFXI 48XG3 */
> > > >  SWITCHTEC_QUIRK(0x8574);  /* PFXI 64XG3 */
> > > >  SWITCHTEC_QUIRK(0x8575);  /* PFXI 80XG3 */
> > > >  SWITCHTEC_QUIRK(0x8576);  /* PFXI 96XG3 */
> > > > +
> > > > +/*
> > > > + * On certain Lenovo Thinkpad P50 SKUs, specifically those with a
> > > > Nvidia
> > > > + * Quadro M1000M, the BIOS will occasionally make the mistake of not
> > > > resetting
> > > > + * the nvidia GPU between reboots if the system is configured to use
> > > > hybrid
> > > > + * graphics mode. This results in the GPU being left in whatever
> > > > state
> > > > it
> > > > was
> > > > + * in during the previous boot which causes spurious interrupts from
> > > > the
> > > > GPU,
> > > > + * which in turn cause us to disable the wrong IRQs and end up
> > > > breaking
> > > > the
> > > > + * touchpad. Unsurprisingly, this also completely breaks nouveau.
> > > > + *
> > > > + * Luckily, it seems a simple reset of the PCI device for the nvidia
> > > > GPU
> > > > + * manages to bring the GPU back into a clean state and fix all of
> > > > these
> > > > + * issues. Additionally since the GPU will report NoReset+ when the
> > > > machine is
> > > > + * configured in Dedicated display mode, we don't need to worry about
> > > > + * accidentally resetting the GPU when it's supposed to already be
> > > > + * initialized.
> > > > + */
> > > > +static void
> > > > +quirk_lenovo_thinkpad_p50_nvgpu_survives_reboot(struct pci_dev *pdev)
> > > > +{
> > > > +	void __iomem *map;
> > > > +	int ret;
> > > > +
> > > > +	if (pdev->subsystem_vendor != PCI_VENDOR_ID_LENOVO ||
> > > > +	    pdev->subsystem_device != 0x222e ||
> > > > +	    !pdev->reset_fn)
> > > > +		return;
> > > > +
> > > > +	/*
> > > > +	 * If we can't enable the device's mmio space, it's probably
> > > > not even
> > > > +	 * initialized. This is fine, and means we can just skip the
> > > > quirk
> > > > +	 * entirely.
> > > > +	 */
> > > > +	if (pci_enable_device_mem(pdev)) {
> > > > +		pci_dbg(pdev, "Can't enable device mem, no reset
> > > > needed\n");
> > > > +		return;
> > > > +	}
> > > > +
> > > > +	/* Taken from drivers/gpu/drm/nouveau/engine/device/base.c */
> > > > +	map = ioremap(pci_resource_start(pdev, 0), 0x102000);
> > > > +	if (!map) {
> > > > +		pci_err(pdev, "Can't map MMIO space, this is probably
> > > > very
> > > > bad\n");
> > > > +		goto out_disable;
> > > > +	}
> > > > +
> > > > +	/*
> > > > +	 * Be extra careful, and make sure that the GPU firmware is
> > > > posted
> > > > +	 * before trying a reset
> > > > +	 */
> > > > +	if (ioread32(map + 0x2240c) & 0x2) {
> > > > +		pci_info(pdev,
> > > > +			 FW_BUG "GPU left initialized by EFI,
> > > > resetting\n");
> > > > +		ret = pci_reset_function(pdev);
> > > > +		if (ret < 0)
> > > > +			pci_err(pdev, "Failed to reset GPU: %d\n",
> > > > ret);
> > > > +	}
> > > > +
> > > > +	iounmap(map);
> > > > +out_disable:
> > > > +	pci_disable_device(pdev);
> > > > +}
> > > > +
> > > > +DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, 0x13b1,
> > > > +			      PCI_CLASS_DISPLAY_VGA, 8,
> > > > +			      quirk_lenovo_thinkpad_p50_nvgpu_survives
> > > > _reboot)
> > > > ;
> > > > -- 
> > > > 2.20.1
> > > > 
-- 
Cheers,
	Lyude Paul

