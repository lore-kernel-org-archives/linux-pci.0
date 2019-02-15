Return-Path: <SRS0=N/Da=QW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE30C43381
	for <linux-pci@archiver.kernel.org>; Fri, 15 Feb 2019 00:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DD6721B1C
	for <linux-pci@archiver.kernel.org>; Fri, 15 Feb 2019 00:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550191413;
	bh=3Z9mPbOLzcqgAZaIlB20YWhJlYL2gxbtJQZyddByEPw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iazXErpadGchfZOljLKWqnvUkGwArIPo0fh+5QMTQ/TtYEzr2xAQJ/dU8N96pWESs
	 yOHG4VtpRBIEbG/bB5rv8DllvCX7rTJ2yM5+hcf2XHuK5gqZsoG7q0HQ1cgNGkNEqB
	 ZV44p7Zoy36fybIFgUpCZhBu2tm8EFusDWXVMau0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388108AbfBOAnc (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 14 Feb 2019 19:43:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:42024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387553AbfBOAnc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 14 Feb 2019 19:43:32 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7570821B1C;
        Fri, 15 Feb 2019 00:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550191410;
        bh=3Z9mPbOLzcqgAZaIlB20YWhJlYL2gxbtJQZyddByEPw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s/hvYz72s1JQrnNMfN20sIboyRiQYnbGTsTpv+TxXX1UU2glv5wGxhUDLC57jXYtR
         S8noX7YpheDNl2opjRaW1jFWG9/beKklqpv9Bw+xcfdciO1QQPRnu7roDL1xOdXPyc
         ZAPm1D8N+Id673Cb7sPpjQJOp5riyxms2Tagl09o=
Date:   Thu, 14 Feb 2019 18:43:29 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lyude Paul <lyude@redhat.com>
Cc:     linux-pci@vger.kernel.org, nouveau@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, Karol Herbst <kherbst@redhat.com>,
        Ben Skeggs <skeggsb@gmail.com>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci/quirks: Add quirk to reset nvgpu at boot for the
 Lenovo ThinkPad P50
Message-ID: <20190215004329.GR96272@google.com>
References: <20190212220230.1568-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190212220230.1568-1-lyude@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lyude,

On Tue, Feb 12, 2019 at 05:02:30PM -0500, Lyude Paul wrote:
> On a very specific subset of ThinkPad P50 SKUs, particularly ones that
> come with a Quadro M1000M chip instead of the M2000M variant, the BIOS
> seems to have a very nasty habit of not always resetting the secondary
> Nvidia GPU between full reboots if the laptop is configured in Hybrid
> Graphics mode. The reason for this happening is unknown, but the
> following steps and possibly a good bit of patience will reproduce the
> issue:
> 
> 1. Boot up the laptop normally in Hybrid graphics mode
> 2. Make sure nouveau is loaded and that the GPU is awake
> 2. Allow the nvidia GPU to runtime suspend itself after being idle
> 3. Reboot the machine, the more sudden the better (e.g sysrq-b may help)
> 4. If nouveau loads up properly, reboot the machine again and go back to
> step 2 until you reproduce the issue
> 
> This results in some very strange behavior: the GPU will
> quite literally be left in exactly the same state it was in when the
> previously booted kernel started the reboot. This has all sorts of bad
> sideaffects: for starters, this completely breaks nouveau starting with a
> mysterious EVO channel failure that happens well before we've actually
> used the EVO channel for anything:

There are a lot of moving parts here that are probably obvious to you
but not to me.  I need help untangling this a bit so I'm comfortable
that we got to the root cause and that we're doing something logical
as opposed to something that just happens to make things work.  I
really don't know enough to even ask the right questions...

Is there a bug report for this?  Bugzilla.kernel.org would be ideal,
including "lspci -vvxxx" and dmidecode for the system.

Is this running a current BIOS?  The date in your log below looks
pretty recent, so I assume it is current.

I assume "hybrid graphics" means you have two GPUs.  Do you select
hybrid graphics mode in the BIOS?

I assume when you say the Nvidia GPU doesn't get reset on a full
reboot, you're talking about a "warm reboot", and that if you actually
remove the power and do a cold reboot, there's no problem?

I assume Nvidia GPU being active means you are using the performance
GPU.  Does that mean the integrated GPU is completely unused and Linux
does nothing at all with it?  Is Linux doing any switching between
them?  If so, how?  I am not 100% confident in the code I've seen that
does the switching.

> nouveau 0000:01:00.0: disp: chid 0 mthd 0000 data 00000400 00001000
> 00000002
> 
> Later on, this causes us to timeout trying to bring up the GR ctx:
> 
> ------------[ cut here ]------------
> nouveau 0000:01:00.0: timeout
> WARNING: CPU: 0 PID: 12 at
> drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgf100.c:1547
> gf100_grctx_generate+0x7b2/0x850 [nouveau]
> Modules linked in: nouveau mxm_wmi i915 crc32c_intel ttm i2c_algo_bit
> serio_raw drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops
> xhci_pci drm xhci_hcd i2c_core wmi video
> CPU: 0 PID: 12 Comm: kworker/0:1 Not tainted 5.0.0-rc5Lyude-Test+ #29
> Hardware name: LENOVO 20EQS64N0B/20EQS64N0B, BIOS N1EET82W (1.55 )
> 12/18/2018
> Workqueue: events_long drm_dp_mst_link_probe_work [drm_kms_helper]
> RIP: 0010:gf100_grctx_generate+0x7b2/0x850 [nouveau]
> Code: 85 d2 75 04 48 8b 57 10 48 89 95 28 ff ff ff e8 b4 37 0e e1 48 8b
> 95 28 ff ff ff 48 c7 c7 b1 97 57 a0 48 89 c6 e8 5a 38 c0 e0 <0f> 0b e9
> b9 fd ff ff 48 8b 85 60 ff ff ff 48 8b 40 10 48 8b 78 10
> RSP: 0018:ffffc900000b77f0 EFLAGS: 00010286
> RAX: 0000000000000000 RBX: ffff888871af8000 RCX: 0000000000000000
> RDX: ffff88887f41dfe0 RSI: ffff88887f415698 RDI: ffff88887f415698
> RBP: ffffc900000b78c8 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: ffff888872118000
> R13: 0000000000000000 R14: ffffffffa0551420 R15: ffffc900000b7818
> FS:  0000000000000000(0000) GS:ffff88887f400000(0000)
> knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00005644d0556ca8 CR3: 0000000002214006 CR4: 00000000003606f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  gf100_gr_init_ctxctl+0x27b/0x2d0 [nouveau]
>  gf100_gr_init+0x5bd/0x5e0 [nouveau]
>  gf100_gr_init_+0x61/0x70 [nouveau]
>  nvkm_gr_init+0x1d/0x20 [nouveau]
>  nvkm_engine_init+0xcb/0x210 [nouveau]
>  nvkm_subdev_init+0xd6/0x230 [nouveau]
>  nvkm_engine_ref.part.0+0x52/0x70 [nouveau]
>  nvkm_engine_ref+0x13/0x20 [nouveau]
>  nvkm_ioctl_new+0x12c/0x260 [nouveau]
>  ? nvkm_fifo_chan_child_del+0xa0/0xa0 [nouveau]
>  ? gf100_gr_dtor+0xe0/0xe0 [nouveau]
>  nvkm_ioctl+0xe2/0x180 [nouveau]
>  nvkm_client_ioctl+0x12/0x20 [nouveau]
>  nvif_object_ioctl+0x47/0x50 [nouveau]
>  nvif_object_init+0xc8/0x120 [nouveau]
>  nvc0_fbcon_accel_init+0x5c/0x960 [nouveau]
>  nouveau_fbcon_create+0x5a5/0x5d0 [nouveau]
>  ? drm_setup_crtcs+0x27b/0xcb0 [drm_kms_helper]
>  ? __lock_is_held+0x5e/0xa0
>  __drm_fb_helper_initial_config_and_unlock+0x27c/0x520 [drm_kms_helper]
>  drm_fb_helper_hotplug_event.part.29+0xae/0xc0 [drm_kms_helper]
>  drm_fb_helper_hotplug_event+0x1c/0x30 [drm_kms_helper]
>  nouveau_fbcon_output_poll_changed+0xb8/0x110 [nouveau]
>  drm_kms_helper_hotplug_event+0x2a/0x40 [drm_kms_helper]
>  drm_dp_send_link_address+0x176/0x1c0 [drm_kms_helper]
>  drm_dp_check_and_send_link_address+0xa0/0xb0 [drm_kms_helper]
>  drm_dp_mst_link_probe_work+0xa4/0xc0 [drm_kms_helper]
>  process_one_work+0x22f/0x5c0
>  worker_thread+0x44/0x3a0
>  kthread+0x12b/0x150
>  ? wq_pool_ids_show+0x140/0x140
>  ? kthread_create_on_node+0x60/0x60
>  ret_from_fork+0x3a/0x50
> irq event stamp: 22490
> hardirqs last  enabled at (22489): [<ffffffff8113281d>]
> console_unlock+0x44d/0x5f0
> hardirqs last disabled at (22490): [<ffffffff81001c03>]
> trace_hardirqs_off_thunk+0x1a/0x1c
> softirqs last  enabled at (22486): [<ffffffff81c00330>]
> __do_softirq+0x330/0x44d
> softirqs last disabled at (22479): [<ffffffff810c3105>]
> irq_exit+0xe5/0xf0
> WARNING: CPU: 0 PID: 12 at
> drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgf100.c:1547
> gf100_grctx_generate+0x7b2/0x850 [nouveau]
> ---[ end trace bf0976ed88b122a8 ]---
> nouveau 0000:01:00.0: gr: wait for idle timeout (en: 1, ctxsw: 0, busy: 1)
> nouveau 0000:01:00.0: gr: wait for idle timeout (en: 1, ctxsw: 0, busy: 1)
> nouveau 0000:01:00.0: fifo: fault 01 [WRITE] at 0000000000008000 engine
> 00 [GR] client 15 [HUB/SCC_NB] reason c4 [] on channel -1 [0000000000
> unknown]
> 
> From which the GPU never manages to recover. Booting without nouveau
> loading causes issues as well, since the GPU starts sending spurious
> interrupts that cause other device's IRQs to get disabled by the kernel:
> 
> irq 16: nobody cared (try booting with the "irqpoll" option)
> …
> handlers:
> [<000000007faa9e99>] i801_isr [i2c_i801]
> Disabling IRQ #16
> …
> serio: RMI4 PS/2 pass-through port at rmi4-00.fn03
> i801_smbus 0000:00:1f.4: Timeout waiting for interrupt!
> i801_smbus 0000:00:1f.4: Transaction timeout
> rmi4_f03 rmi4-00.fn03: rmi_f03_pt_write: Failed to write to F03 TX
> register (-110).
> i801_smbus 0000:00:1f.4: Timeout waiting for interrupt!
> i801_smbus 0000:00:1f.4: Transaction timeout
> rmi4_physical rmi4-00: rmi_driver_set_irq_bits: Failed to change enabled
> interrupts!
> 
> Which in turn causes the touchpad and sometimes even other things to get
> disabled.
> 
> Since the GPU staying on causes problems even without nouveau's
> intervention, we can't fix this problem from nouveau itself. We have to
> fix it as early as possible in the boot sequence in order to make sure
> that the GPU is in a clean state before it has a chance to spam us with
> interrupts and break things.

Was nouveau loaded *before* the reboot?  Or can you reproduce the
spurious interrupts even if you do a cold reboot without nouveau, then
a warm reboot again without nouveau?

> So to do this, we add a new pci quirk using
> DECLARE_PCI_FIXUP_CLASS_FINAL that will be invoked before the PCI probe
> at boot finishes. From there, we check to make sure that this is indeed
> the specific P50 variant of this GPU. We also make sure that the GPU PCI
> device is advertising NoReset- in order to prevent us from trying to
> reset the GPU when the machine is in Dedicated graphics mode (where the
> GPU being initialized by the BIOS is normal and expected). Finally, we
> try mapping the MMIO space for the GPU which should only work if the GPU
> is actually active in D0 mode. We can then read the magic 0x2240c
> register on the GPU, which will have bit 1 set if the GPU's firmware has
> already been posted during a previous boot. Once we've confirmed all of
> this, we reset the PCI device and re-disable it - bringing the GPU back
> into a healthy state.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: nouveau@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: Karol Herbst <kherbst@redhat.com>
> Cc: Ben Skeggs <skeggsb@gmail.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/pci/quirks.c | 65 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index b0a413f3f7ca..948492fda8bf 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5117,3 +5117,68 @@ SWITCHTEC_QUIRK(0x8573);  /* PFXI 48XG3 */
>  SWITCHTEC_QUIRK(0x8574);  /* PFXI 64XG3 */
>  SWITCHTEC_QUIRK(0x8575);  /* PFXI 80XG3 */
>  SWITCHTEC_QUIRK(0x8576);  /* PFXI 96XG3 */
> +
> +/*
> + * On certain Lenovo Thinkpad P50 SKUs, specifically those with a Nvidia
> + * Quadro M1000M, the BIOS will occasionally make the mistake of not resetting
> + * the nvidia GPU between reboots if the system is configured to use hybrid
> + * graphics mode. This results in the GPU being left in whatever state it was
> + * in during the previous boot which causes spurious interrupts from the GPU,
> + * which in turn cause us to disable the wrong IRQs and end up breaking the
> + * touchpad. Unsurprisingly, this also completely breaks nouveau.
> + *
> + * Luckily, it seems a simple reset of the PCI device for the nvidia GPU
> + * manages to bring the GPU back into a clean state and fix all of these
> + * issues. Additionally since the GPU will report NoReset+ when the machine is
> + * configured in Dedicated display mode, we don't need to worry about
> + * accidentally resetting the GPU when it's supposed to already be
> + * initialized.
> + */
> +static void
> +quirk_lenovo_thinkpad_p50_nvgpu_survives_reboot(struct pci_dev *pdev)
> +{
> +	void __iomem *map;
> +	int ret;
> +
> +	if (pdev->subsystem_vendor != PCI_VENDOR_ID_LENOVO ||
> +	    pdev->subsystem_device != 0x222e ||
> +	    !pdev->reset_fn)
> +		return;
> +
> +	/*
> +	 * If we can't enable the device's mmio space, it's probably not even
> +	 * initialized. This is fine, and means we can just skip the quirk
> +	 * entirely.
> +	 */
> +	if (pci_enable_device_mem(pdev)) {
> +		pci_dbg(pdev, "Can't enable device mem, no reset needed\n");
> +		return;
> +	}
> +
> +	/* Taken from drivers/gpu/drm/nouveau/engine/device/base.c */
> +	map = ioremap(pci_resource_start(pdev, 0), 0x102000);
> +	if (!map) {
> +		pci_err(pdev, "Can't map MMIO space, this is probably very bad\n");
> +		goto out_disable;
> +	}
> +
> +	/*
> +	 * Be extra careful, and make sure that the GPU firmware is posted
> +	 * before trying a reset
> +	 */
> +	if (ioread32(map + 0x2240c) & 0x2) {
> +		pci_info(pdev,
> +			 FW_BUG "GPU left initialized by EFI, resetting\n");
> +		ret = pci_reset_function(pdev);
> +		if (ret < 0)
> +			pci_err(pdev, "Failed to reset GPU: %d\n", ret);
> +	}
> +
> +	iounmap(map);
> +out_disable:
> +	pci_disable_device(pdev);
> +}
> +
> +DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, 0x13b1,
> +			      PCI_CLASS_DISPLAY_VGA, 8,
> +			      quirk_lenovo_thinkpad_p50_nvgpu_survives_reboot);
> -- 
> 2.20.1
> 
