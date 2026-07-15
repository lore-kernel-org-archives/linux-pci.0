Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3639F42BC29
	for <linux-pci@vger.kernel.org>; Wed, 15 Jul 2026 01:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784077295; cv=none; b=Hs3QVfztVsLJvo7i8HqTxdX5r/XWamNaHBx/MCvJEHT09hbKjgZUod1EeJhUQSlhr/cqDsiL1FqPZETVvYf2Q6fCkjZ12qhSm2OW6AOu5B+ao60njCvjD/XUP6ZMNff4it+AUKQ5dCJUOh7rD59nJZrLRWayIo4boe911NE5C6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784077295; c=relaxed/simple;
	bh=HenaEGi1SHtlXUeQTN6AyK1GCRELFqD+sW7ibvfmcr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tmeb//wBa2SJXP37vEtBnxckl9kQfyRqUMKqgtly6Z4X4noqRykd8U6h1MAk0wiI6o0o10Ez74CtXidlGicmFvkY2vNORL8NLgojdb/fUVp0I9gRYgDEfUfyFIhpNpG0/xYpiuk0S7il1r87rsCsWCE3rlDKdt5+VMmdxZlM530=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=V8pq14s5; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="V8pq14s5"
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D965E3F60D
	for <linux-pci@vger.kernel.org>; Wed, 15 Jul 2026 01:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1784077280;
	bh=OSGKEDs2mB0fHKBrdmOidCpfxxFqVayLgti6ycpQ2Io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=V8pq14s5YeROb1ux+H/e9R7mrwurvMSUg977nOCa5S5nGsdh48shsc/AROPCS0KxO
	 P5XJi9jMaMN/wLqWJf6ToGDVeN5sd3RhMLTFssQeAeGtqdBLS7tl5ZjXmnaAiNUhkc
	 emzAEchh7B+J7gGY7Xih1rob/s7lI9MYSQFf9bHkhJIamWbj4z6WekiPk7bxl/aJRV
	 YB16RgNFclq+1F/rNTUc/e0D6nQV2lqQtcDsLZG1ruhpAwke6jD2HNpzK4V86DJJk4
	 3zeWyGHbHKY8/l8QM8oAgU4PbZ13+v26rHH/a+AjjOIS+v/CB2y4fP0vraSmPuPcQ3
	 MonDxz43PAE5zsBzaKtUc7HAh0BM/cR+CupE02r6o7eymERh2QIhnL+XH2tyS1gswg
	 q8rhXIOLCxy7BI59ry0XGvQuYXWiSxFZ3cbRxqkBwKUuBVvD/2YgCESoVMncJWBADY
	 qlfWrVu2N41ZkO4FhmqlK3HhRDLGpmMnedSM0KPIpWtunf+ooHKnNlpXiqWx1+Cyxy
	 hwOdrdz0/GGN+WQoK1KaEbLhqq0IxQ7OmCjNuL9Q8IvOi3k01Oo65SS+vxHuD+nsNn
	 OgV7oquRqbVX7gVPNAcE3OjEycmo7TbXXeqs+9UJQ62KdQDGy7ci2DMAG56agojRrm
	 sHgiC+oGBfCWrgGEaoePhLOE=
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38d7fcd1f66so7246719a91.2
        for <linux-pci@vger.kernel.org>; Tue, 14 Jul 2026 18:01:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784077278; x=1784682078;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OSGKEDs2mB0fHKBrdmOidCpfxxFqVayLgti6ycpQ2Io=;
        b=IaxYC/FrCVvAUiABwYhmTmi6FO/uWHX4FdfMUiDe9/Sl1nO69IRyLFykQmOBdDofj1
         GDRtjhnGqn/nUEX5QftC9DiR9sfRdh3bQZJ2jDCR94JkXCwk9jSf5+jnkDoH4xoAHp4y
         BljjP62KOgYY15FzVF225w4mOiw/wBysJtgKCM+Lnlip90OTE54JacysduXIk7uJnyqk
         SV+D8vxn4wCvXgj3X5s+iznHYTA17k2TN3zmXln8ZHN6Cz97rzcs9EDAgOCUFeeNjU2C
         HuyOwjmjS2Y1JhHbYIEPL0pSpcnP96OkArXzn2e/4F6xbHthGcrnQpnR28Z6YnGZK3cE
         i5MQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq0b0QbJiXEdd8ldfIo3d2pQ2dGSBCtbLMprHgsP8ykrnzehjF01ioDRVBjF7BtPy0bW8wAocQBu4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFiQmZpbQAVVkxJROTurWXOjST7qQN0Gsyz1/gp3z5f/M0PJYc
	2xqJxythq/H7YqOCl9Lc6YqdqzgHJza54Q2I8DrqOVTn1pDdRlTh2ZeSph9lOSdZgFkHLjvKaml
	zkqAbAC/r1qKp21BIU3kgbuNJ8TKUioTBmWjyH+GNgbh2NNNKTUzKnwjTkbvRT2W6vxerHhKZuY
	2G+w==
X-Gm-Gg: AfdE7clQrIwxa+nQJQHtsxan3na+pDalA2zJCNDc7fT2W8DXn3oFje5VjlBlFyHEGvT
	ZOe+0+lO4McbFs6jYo6ZxF1hASQqeQJ03q4zjHHWL5n9cSJ2/oTAZjpDkrnV2EQbO3jkO7UyQxn
	nnB7qmsjAs53WlelWfnf84xvnDStrQktuYS0oSwjDEHmHQawTLyzAZH24+ZhcaSVmD7MfXNYzyu
	YXk+JuiT1v4abhtbAfvlH5Iln9/DRChxWQoSwJPFCRnYAKrnwL50EH7WDB2OMPDnokdxVbUsGAK
	fLB6Vs1mhpjudEtILTsYNz3r5QkGo9J4CT6fHScLd4xUZAsK77w8RqTeWEXGUdiLkiAkARhYtyO
	RnkHJgd1ipnb3H5ysALvkFmsb09e82t1M2lMvxtOG562JBuERLSdCs3VSFqJ4j+b7m3M=
X-Received: by 2002:a17:90b:5830:b0:387:e0bb:57f7 with SMTP id 98e67ed59e1d1-38e1af72937mr4537817a91.40.1784077277909;
        Tue, 14 Jul 2026 18:01:17 -0700 (PDT)
X-Received: by 2002:a17:90b:5830:b0:387:e0bb:57f7 with SMTP id 98e67ed59e1d1-38e1af72937mr4537765a91.40.1784077277188;
        Tue, 14 Jul 2026 18:01:17 -0700 (PDT)
Received: from acelan-Precision-5480 (211-75-139-220.hinet-ip.hinet.net. [211.75.139.220])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313b4cbafa1sm83468385eec.6.2026.07.14.18.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 18:01:16 -0700 (PDT)
Date: Wed, 15 Jul 2026 09:01:10 +0800
From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: Andreas Noever <andreas.noever@gmail.com>, 
	Mika Westerberg <westeri@kernel.org>, Yehezkel Bernat <YehezkelShB@gmail.com>, 
	Yo-Jung Leo Lin <Leo.Lin@amd.com>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"S, Sanath" <sanath.s@amd.com>, "Natikar, Basavaraj" <basavaraj.natikar@amd.com>, 
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>
Subject: Re: [RFC][PATCH] thunderbolt: Quiesce AMD NHI during suspend
Message-ID: <albapl82ioSBPbp6@acelan-Precision-5480>
Mail-Followup-To: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>, 
	Mario Limonciello <superm1@kernel.org>, Andreas Noever <andreas.noever@gmail.com>, 
	Mika Westerberg <westeri@kernel.org>, Yehezkel Bernat <YehezkelShB@gmail.com>, 
	Yo-Jung Leo Lin <Leo.Lin@amd.com>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"S, Sanath" <sanath.s@amd.com>, "Natikar, Basavaraj" <basavaraj.natikar@amd.com>, 
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>
References: <20260706023422.3647320-1-acelan.kao@canonical.com>
 <2ff2d9b9-12fb-4908-8738-2498b2927571@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ff2d9b9-12fb-4908-8738-2498b2927571@kernel.org>

On Wed, Jul 08, 2026 at 10:34:54AM -0500, Mario Limonciello wrote:
> ++ linux-pci
> ++ Sanath && Basavaraj
>
> On 7/5/26 21:34, Chia-Lin Kao (AceLan) wrote:
> > On some AMD USB4 systems, resuming from system suspend with a
> > Thunderbolt dock in the picture hard-hangs the machine very early in the
> > resume path, before the Thunderbolt driver gets a chance to rescan and
> > re-establish the topology. It is a PCIe bus wedge: the system never
> > reaches the point where the thunderbolt module could recover the dock,
> > and the kernel journal does not persist past "PM: suspend entry
> > (s2idle)".
> >
> > Reproduce:
> >
> >    1. Affected platform: an AMD USB4 host with the thunderbolt driver
> >       bound to its NHI PCI functions. Observed on a Dell Pro 14 Plus
> >       (PB14255, AMD Phoenix) which exposes two USB4 NHI functions
> >       (0000:c6:00.5 and 0000:c6:00.6).
> >
> >    2. Put the system into s2idle (Low Power S0 Idle / Modern Standby)
> >       with no dock attached.
> >
> >    3. While the system is suspended, plug in a Dell SD25TB4 Thunderbolt 4
> >       dock (Goshen Ridge). The plug event wakes the system, and the dock's
> >       downstream PCIe bridges are enumerated behind the AMD USB4 PCIe
> >       tunnel during the resume.
> >
> >    4. The machine hard-hangs during the noirq resume phase, before the
> >       thunderbolt driver re-establishes the topology. The Dell power
> >       indicator flashes the "3A5W" code (3 amber + 5 white lights).
> >
> >    Removing the trigger makes resume reliable: unbinding the two NHI PCI
> >    functions, or unloading the thunderbolt module, before suspend both
> >    avoid the hang completely. The difference in those cases is the PCI
> >    state the core restores for the driver-bound NHI on resume.
> >
> > EC team findings (from the platform EC log):
> >
> > The EC/PD/dock side is healthy across the failing cycle, which points
> > the finger at the host resume path rather than the dock:
> >
> >    - Modern Standby entry and resume are seen on the EC side; the dock
> >      plug interrupt during MS is handled and the full power sequence
> >      recovers (SLP_S3# okay, PLTRST# received, U8-U20 sequence completed).
> >
> >    - The EC-to-dock DDM command exchange fully succeeds: all CMsd/CMgd
> >      transactions return success (device type, TBT cable type, dock
> >      module config for USB/TBT/Audio/LAN).
> >
> >    - PD/Type-C renegotiation is normal (power contracts up to 95W/100W);
> >      no persistent protocol error appears in the log.
> >
> >    - The only suspicious symptom is host-side: the EC repeatedly logs
> >      PmSt_Timeout_Count while waiting for the BIOS/host to consume the
> >      wake (PWRB pressed) event. That indicates the host resume path is
> >      late or stuck, not an EC-to-dock transport failure. The Dell "3A5W"
> >      diagnostic LED code (3 amber + 5 white) maps in the EC code to an
> >      SLP_S3#/PLTRST#/RUNPWROK failure indication.
> >
> > Root cause:
> >
> > With the driver bound, the PCI core restores the saved NHI config space
> > during the noirq resume phase, including PCI_COMMAND with memory space
> > and bus mastering enabled. This is the same phase in which the core
> > restores the config space of the tunneled PCI bridges and whatever sits
> > behind them (the dock). If the AMD host router is made active (memory +
> > bus mastering) while the downstream USB4 PCIe tunnel to the dock is still
> > being restored and is not yet ready, the host interface starts bus
> > activity toward a not-yet-ready endpoint and the PCIe hierarchy wedges.
> >
> > This matches the workarounds: unbinding the NHI or unloading the module
> > means the core does not restore an active NHI over the tunnel during
> > noirq, and the hang disappears. Several Thunderbolt-side attempts did not
> > help (returning early from nhi_resume_noirq(), disabling host-router wake
> > flags, adding an unconditional delay before tunnel activation), which is
> > why the actionable boundary is the PCI PM state of the driver-bound AMD
> > NHI rather than a later Thunderbolt protocol step. We do not have
> > visibility into what the host router does internally in that window; that
> > uncertainty is the main reason for sending this as an RFC (see open
> > questions below).
> >
> > What this patch does:
> >
> > Add a QUIRK_QUIESCE_ON_SUSPEND quirk, currently set for all AMD USB4 host
> > routers (matched by vendor AMD + USB4 PCI class), and:
> >
> >    - clear PCI_COMMAND_MEMORY and PCI_COMMAND_MASTER before the PCI core
> >      saves the NHI config space in runtime and system suspend, so the NHI
> >      is restored inactive on resume;
> >
> >    - keep the NHI quiescent across nhi_resume_noirq() (return early without
> >      touching the controller), so it stays inactive while the core
> >      restores the tunneled bridges and the dock;
> >
> >    - once the whole system has resumed, re-enable memory space and bus
> >      mastering and bring the domain back up from the PM complete callback
> >      via tb_domain_resume_noirq(), and from nhi_runtime_resume() for the
> >      runtime PM path.
> >
> > The result is that Thunderbolt/USB4 stays functional after resume instead
> > of the machine hanging or the tunnels staying down until the module is
> > reloaded.
> >
> > Test results:
> >
> > Tested on the Dell Pro 14 Plus (PB14255, AMD Phoenix, two USB4 host
> > routers) with the Dell SD25TB4 dock. Without the patch, the sequence
> > above hard-hangs during resume. With the patch, repeated suspend/resume
> > cycles with the dock connected complete cleanly with no hang. After
> > resume the NHI PCI_COMMAND reads back with MEMORY|MASTER set again, and
> > the dock's downstream USB devices re-enumerate, confirming the USB tunnel
> > is restored and the domain is functional.
> >
> > Caveats observed while the NHI is quiescent across noirq: config space
> > reads to the host router time out and TMU configuration restore fails
> > during that window; the controller and domain are fully brought back in
> > nhi_complete(). The DP tunnel restore path was not exercised in this
> > test, as no external display was driven through the dock during the
> > tested cycle.
> >
> > Open questions for RFC discussion:
> >
> >    1. Root cause: what does the AMD host router actually do when it is
> >       restored with memory + bus mastering enabled during noirq while the
> >       downstream tunnel is not ready? Is this an expected ordering
> >       constraint, a firmware behavior, or a hardware erratum?
> >
> >    2. Scope: the quirk currently matches all AMD USB4 host routers by
> >       class. Which parts are actually affected? Should this be narrowed
> >       (e.g. by DMI or specific device IDs) instead of applied to all AMD
> >       USB4?
> >
> >    3. Mechanism: is clearing both PCI_COMMAND_MEMORY and PCI_COMMAND_MASTER
> >       the right lever, or would clearing bus mastering alone suffice and be
> >       less invasive? Is poking PCI_COMMAND directly acceptable in the NHI
> >       driver, or should this move into a PCI backend op / PCI quirk?
> >
> > Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
>
> I have no idea why I didn't receive this patch in my mailbox - I'm obviously
> CC'ed.  But I checked my spam and it's not there either.
>
> But anyway, I am wondering if the real issue here is that we're accessing
> the hardware before it's ready.  If you can readily reproduce the issue, can
> you try this series to see if it helps?
>
> https://lore.kernel.org/linux-pci/20260708152650.536604-1-mario.limonciello@amd.com/
No, this patch doesn't work.
I applied this patch on top of the latest mainline kernel
58717b2a1365 ("Merge tag 'sound-7.2-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound")
and the power indicator shows 3 amber and 5 white lights after
plugging in the tbt dock during suspend.

>
> > ---
> >   drivers/thunderbolt/nhi.c | 78 +++++++++++++++++++++++++++++++++++++--
> >   drivers/thunderbolt/nhi.h |  5 ++-
> >   drivers/thunderbolt/pci.c |  8 ++++
> >   3 files changed, 85 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
> > index 698fb124d529..787185c745ae 100644
> > --- a/drivers/thunderbolt/nhi.c
> > +++ b/drivers/thunderbolt/nhi.c
> > @@ -16,6 +16,7 @@
> >   #include <linux/interrupt.h>
> >   #include <linux/iommu.h>
> >   #include <linux/module.h>
> > +#include <linux/pci.h>
> >   #include <linux/delay.h>
> >   #include <linux/property.h>
> >   #include <linux/string_choices.h>
> > @@ -40,6 +41,31 @@ static bool host_reset = true;
> >   module_param(host_reset, bool, 0444);
> >   MODULE_PARM_DESC(host_reset, "reset USB4 host router (default: true)");
> > +static bool nhi_quirk_quiesce_on_suspend(const struct tb_nhi *nhi)
> > +{
> > +	return nhi->quirks & QUIRK_QUIESCE_ON_SUSPEND;
> > +}
> > +
> > +static void nhi_disable_pci_mem_master(struct tb_nhi *nhi)
> > +{
> > +	struct pci_dev *pdev = to_pci_dev(nhi->dev);
> > +	u16 cmd;
> > +
> > +	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
> > +	cmd &= ~(PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER);
> > +	pci_write_config_word(pdev, PCI_COMMAND, cmd);
> > +}
> > +
> > +static void nhi_enable_pci_mem_master(struct tb_nhi *nhi)
> > +{
> > +	struct pci_dev *pdev = to_pci_dev(nhi->dev);
> > +	u16 cmd;
> > +
> > +	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
> > +	cmd |= PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER;
> > +	pci_write_config_word(pdev, PCI_COMMAND, cmd);
> > +}
> > +
> >   static int ring_interrupt_index(const struct tb_ring *ring)
> >   {
> >   	int bit = ring->hop;
> > @@ -988,6 +1014,9 @@ static int __nhi_suspend_noirq(struct device *dev, bool wakeup)
> >   			return ret;
> >   	}
> > +	if (nhi_quirk_quiesce_on_suspend(nhi))
> > +		nhi_disable_pci_mem_master(nhi);
> > +
> >   	return 0;
> >   }
> > @@ -1038,6 +1067,18 @@ static int nhi_resume_noirq(struct device *dev)
> >   	struct tb_nhi *nhi = tb->nhi;
> >   	int ret;
> > +	/*
> > +	 * If the NHI was quiesced on suspend keep it quiescent (bus
> > +	 * mastering and memory access disabled) across the noirq phase.
> > +	 * The PCI core restores the config space of the tunneled PCI
> > +	 * bridges and anything behind them (e.g. a dock) here; letting the
> > +	 * AMD host router become active now can wedge the PCIe bus before
> > +	 * the dock side is ready. The controller and domain are brought
> > +	 * back up in nhi_complete() once the whole system has resumed.
> > +	 */
> > +	if (nhi_quirk_quiesce_on_suspend(nhi))
> > +		return 0;
> > +
> >   	/*
> >   	 * Check that the device is still there. It may be that the user
> >   	 * unplugged last device which causes the host controller to go
> > @@ -1064,16 +1105,33 @@ static int nhi_suspend(struct device *dev)
> >   static void nhi_complete(struct device *dev)
> >   {
> >   	struct tb *tb = dev_get_drvdata(dev);
> > +	struct tb_nhi *nhi = tb->nhi;
> >   	/*
> >   	 * If we were runtime suspended when system suspend started,
> >   	 * schedule runtime resume now. It should bring the domain back
> > -	 * to functional state.
> > +	 * to functional state (and undo the quiesce, if any, via
> > +	 * nhi_runtime_resume()).
> >   	 */
> > -	if (pm_runtime_suspended(dev))
> > +	if (pm_runtime_suspended(dev)) {
> >   		pm_runtime_resume(dev);
> > -	else
> > -		tb_domain_complete(tb);
> > +		return;
> > +	}
> > +
> > +	/*
> > +	 * A quiesced NHI (see __nhi_suspend_noirq()) was intentionally
> > +	 * left with bus mastering and memory access disabled and its
> > +	 * domain was not resumed in nhi_resume_noirq(). Now that the whole
> > +	 * system has resumed and the PCI core has finished restoring the
> > +	 * tunneled bridges, re-enable the controller and bring the domain
> > +	 * back up so Thunderbolt/USB4 keeps working after resume.
> > +	 */
> > +	if (nhi_quirk_quiesce_on_suspend(nhi)) {
> > +		nhi_enable_pci_mem_master(nhi);
> > +		tb_domain_resume_noirq(tb);
> > +	}
> > +
> > +	tb_domain_complete(tb);
> >   }
> >   static int nhi_runtime_suspend(struct device *dev)
> > @@ -1091,6 +1149,10 @@ static int nhi_runtime_suspend(struct device *dev)
> >   		if (ret)
> >   			return ret;
> >   	}
> > +
> > +	if (nhi_quirk_quiesce_on_suspend(nhi))
> > +		nhi_disable_pci_mem_master(nhi);
> > +
> >   	return 0;
> >   }
> > @@ -1100,6 +1162,14 @@ static int nhi_runtime_resume(struct device *dev)
> >   	struct tb_nhi *nhi = tb->nhi;
> >   	int ret;
> > +	/*
> > +	 * The NHI is quiesced (bus mastering and memory access disabled)
> > +	 * across runtime suspend as well; re-enable it before resuming the
> > +	 * domain.
> > +	 */
> > +	if (nhi_quirk_quiesce_on_suspend(nhi))
> > +		nhi_enable_pci_mem_master(nhi);
> > +
> >   	if (nhi->ops->runtime_resume) {
> >   		ret = nhi->ops->runtime_resume(nhi);
> >   		if (ret)
> > diff --git a/drivers/thunderbolt/nhi.h b/drivers/thunderbolt/nhi.h
> > index d488eadadfce..c8b973150434 100644
> > --- a/drivers/thunderbolt/nhi.h
> > +++ b/drivers/thunderbolt/nhi.h
> > @@ -119,8 +119,9 @@ struct tb_nhi_ops {
> >   #define PCI_CLASS_SERIAL_USB_USB4			0x0c0340
> >   /* Host interface quirks */
> > -#define QUIRK_AUTO_CLEAR_INT	BIT(0)
> > -#define QUIRK_E2E		BIT(1)
> > +#define QUIRK_AUTO_CLEAR_INT		BIT(0)
> > +#define QUIRK_E2E			BIT(1)
> > +#define QUIRK_QUIESCE_ON_SUSPEND	BIT(2)
> >   /*
> >    * Minimal number of vectors when we use MSI-X. Two for control channel
> > diff --git a/drivers/thunderbolt/pci.c b/drivers/thunderbolt/pci.c
> > index dbb6badda867..4cf8107f1ce8 100644
> > --- a/drivers/thunderbolt/pci.c
> > +++ b/drivers/thunderbolt/pci.c
> > @@ -43,6 +43,14 @@ static void nhi_pci_check_quirks(struct tb_nhi_pci *nhi_pci)
> >   	struct tb_nhi *nhi = &nhi_pci->nhi;
> >   	struct pci_dev *pdev = to_pci_dev(nhi->dev);
> > +	/*
> > +	 * AMD USB4 host routers may otherwise become active too early during
> > +	 * resume after the PCI core restores the saved COMMAND register.
> > +	 */
> > +	if (pdev->vendor == PCI_VENDOR_ID_AMD &&
> > +	    pdev->class == PCI_CLASS_SERIAL_USB_USB4)
> > +		nhi->quirks |= QUIRK_QUIESCE_ON_SUSPEND;
> > +
> >   	if (pdev->vendor == PCI_VENDOR_ID_INTEL) {
> >   		/*
> >   		 * Intel hardware supports auto clear of the interrupt
>
