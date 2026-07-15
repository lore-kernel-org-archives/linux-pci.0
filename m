Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BE01A8F7B
	for <linux-pci@vger.kernel.org>; Wed, 15 Jul 2026 05:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784094137; cv=none; b=UsCCgWUvlBtuppg24JjrZyJjEOHJX3uaNQ8QZGTFgX5liiSMHHXEO0VH9wEqLIZi+lC3Lqf2/0YcEdulYRofqy2iDeJYNwiwYnxTg8VQbe110zezaMxu3/vFq+bWTB62O+/OPBI1U4OcCp5vakUmjFFNRSPesHNZ9APDiOZlgTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784094137; c=relaxed/simple;
	bh=85UZwvIciebdEmkRr+SYKRdArqBYvs2guw8hT4ysxoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GtgWcaeud2DrmmID7UUqUhwYFGrnj9V3hBOC3zm7FCenOF0RTuzaMX9Msd/tU+NFZbt0YRMByXn5RBYuVt1XIjvXBSF7sN1nXhX5+PKzjpwdC8GyEZOqAifHvAy2bFWFGqpwGXct9YFanpTcJ3331emm342VWdIt7ac6e/y38aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=ltpRfCJC; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="ltpRfCJC"
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id BBD983F59A
	for <linux-pci@vger.kernel.org>; Wed, 15 Jul 2026 05:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1784094132;
	bh=uoBIPK0phEJaHsN6vT8ceqwYpwfQfLNrm6g9qxxe21o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=ltpRfCJC6ciG7/wBA5N1sYX5msb7wAGfXPYDqbmMYdd82syxYBuXWuUjrKBorS2C8
	 taWGGVSFJlWB2W+RqAL22Ve6g5ktInLg1NRDNq1PadZPeHJ36vNoLyak343xthi0b3
	 0lznSh9dJFbSTpRAk0/yijPxuviOp6/kVcOMMV2V6Mnx649Z5H0o+6dXPDbqpV0skR
	 2qDh5UCmAxEf2NcY2L+UvMmdbLLcR2QRiZ/z/eG/h+JuKZHLl8Z4IHNxVm03ky0OCu
	 TgUni2FpcrP2DiC4J4jM4F5p/yvIb+rxvGHtSejnwoHvDrI5xORyBWcE6m4EJ2rp+w
	 WM7u0Ze0gFeWMzeESEH2Y1xeEGkOlmmgA3y4ToHnlChboRewVbb/rHkEzBrxpbMgCa
	 +b/2v5foqmlhSXeuMTS2+oVJrGuJM89RT8D9z4oWtRUOgMgcU6Hkx77+B5+y137x3n
	 8vtCA0r+IxUMhnNBIgP8LCj0BFAYIvLk4a05AhXD8J6A1ST1Al11YGwt3aoCxH+kz5
	 aH6STRbbjgOOuPS0jh9WgIE3mLs9/aQyTQ1kHxbIsTGN6Zek5xWy8m59CJS9XtS512
	 HXW0XckpH5nfRhubUeqEgiHN3YQIgEVaEjaxvmbzI7pvdd4zPOOtQpsKtKT3jgM6lM
	 iA+yPsSrFHB/YbsbvqL3VoLQ=
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c8924f4d0a4so7472650a12.2
        for <linux-pci@vger.kernel.org>; Tue, 14 Jul 2026 22:42:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784094131; x=1784698931;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uoBIPK0phEJaHsN6vT8ceqwYpwfQfLNrm6g9qxxe21o=;
        b=dbztSAvrKuaofKa80yCUeCfpuRkfJgKHPG7ezgSy/GNWxiVHN3SVXoz1AABrjlPbr8
         Q0huZWDdbLs2h6b/UZ/EXNTxQF7xASV71p+8SmY2uHr1V1SDdlBuU8IegYNr4FrSAtd5
         10vRJW68Q2cEp/3mTJKPkMiHRlBmgxjPfLaj0qxDfYQTmwM8cUloH709n0k9IyqADNVm
         Bk6Wr5kv7LFAZuuhuVCgYxzxnbP7SV0v4ZKLQWt4ulew2qhTC/eteEH/tYtLmwgAbAVg
         GoMWMRPo0Rg76h6MsVvbUU/ega9f8ivPSqyESfLXtUyMIXF/6v7J71fx/b5C5kzTBSpS
         MjiA==
X-Forwarded-Encrypted: i=1; AHgh+RpHq/oiTzjO22IgIte2vQOylfDIPQWIzo8H36GnM5ULArnvXlQN/qsiK8FWQxtoQlkCxCTV17EDkyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnfDjlPVkRrzqdN3b2eub1IYVcA4Z1WxNFtXXPzvUW+HrcQQxS
	Y+ZxcKiYcbqoWBFt4En6GWV44xqU0jdPO+Kus5nqIOFh4hXaadgs3/eEbelpnE+vxw0Qp8VTlWR
	ijfRVC9bPksC4lkq5dxkH8j2XC3KpANd9U7G23xvcVZfhKNdJAoM6T24qRooVKLAmjfD/Uz38UU
	3YEg==
X-Gm-Gg: AfdE7cmFXs7+hNwUyx2+0lfHTu31lVWlIj+yb+tDVHyGeMpK5mk01G68cO40fD5qC66
	wWq8JnAT7B/nOIY6hh1xgkf3Pjv/c5NCv8omyCkdHrx2CedT/vlSGVGw9/3GN5JxKvpEkn8qW4o
	HKAudkWgzCF1LnHK0hJshEJIamTRk/c2MmpOzU/1G/DVQPvCyto+Qd1/ugQ56jZtcLDaZumRNJh
	mGXFWXxumsTkfq1VOuDZ4hlaWAmr2xnAR0E3mVwf9Hno5m7ziUHoYRYr5zEfoG8StLm2YlYiWsZ
	q0iAS0toGgLSfKNoXMWka1TN4pxBcF81BQjqup/CRpCeh0jjAcLJg70OupcYa0L8qYtDDqn8ZZv
	bdBNmhL9FEsfLAWHQCKt/RqLeHRCpdbXtOCadoGYswUsK6RcwIpIMYUgP1uKNgyBvRqA=
X-Received: by 2002:a05:6a20:a10b:b0:3c1:d78:6458 with SMTP id adf61e73a8af0-3c36c345708mr1531950637.44.1784094130695;
        Tue, 14 Jul 2026 22:42:10 -0700 (PDT)
X-Received: by 2002:a05:6a20:a10b:b0:3c1:d78:6458 with SMTP id adf61e73a8af0-3c36c345708mr1531926637.44.1784094130222;
        Tue, 14 Jul 2026 22:42:10 -0700 (PDT)
Received: from acelan-Precision-5480 (211-75-139-220.hinet-ip.hinet.net. [211.75.139.220])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174ac14f2sm93260262eec.27.2026.07.14.22.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 22:42:09 -0700 (PDT)
Date: Wed, 15 Jul 2026 13:42:03 +0800
From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: Andreas Noever <andreas.noever@gmail.com>, 
	Mika Westerberg <westeri@kernel.org>, Yehezkel Bernat <YehezkelShB@gmail.com>, 
	Yo-Jung Leo Lin <Leo.Lin@amd.com>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"S, Sanath" <sanath.s@amd.com>, "Natikar, Basavaraj" <basavaraj.natikar@amd.com>, 
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>
Subject: Re: [RFC][PATCH] thunderbolt: Quiesce AMD NHI during suspend
Message-ID: <alccavxbVnZGtVU5@acelan-Precision-5480>
Mail-Followup-To: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>, 
	Mario Limonciello <superm1@kernel.org>, Andreas Noever <andreas.noever@gmail.com>, 
	Mika Westerberg <westeri@kernel.org>, Yehezkel Bernat <YehezkelShB@gmail.com>, 
	Yo-Jung Leo Lin <Leo.Lin@amd.com>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"S, Sanath" <sanath.s@amd.com>, "Natikar, Basavaraj" <basavaraj.natikar@amd.com>, 
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>
References: <20260706023422.3647320-1-acelan.kao@canonical.com>
 <2ff2d9b9-12fb-4908-8738-2498b2927571@kernel.org>
 <albapl82ioSBPbp6@acelan-Precision-5480>
 <e78152a9-c6d3-47d9-8657-f5efc2fe69f7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e78152a9-c6d3-47d9-8657-f5efc2fe69f7@kernel.org>

On Tue, Jul 14, 2026 at 08:05:04PM -0500, Mario Limonciello wrote:
> On 7/14/26 20:01, Chia-Lin Kao (AceLan) wrote:
> > On Wed, Jul 08, 2026 at 10:34:54AM -0500, Mario Limonciello wrote:
> > > ++ linux-pci
> > > ++ Sanath && Basavaraj
> > >
> > > On 7/5/26 21:34, Chia-Lin Kao (AceLan) wrote:
> > > > On some AMD USB4 systems, resuming from system suspend with a
> > > > Thunderbolt dock in the picture hard-hangs the machine very early in the
> > > > resume path, before the Thunderbolt driver gets a chance to rescan and
> > > > re-establish the topology. It is a PCIe bus wedge: the system never
> > > > reaches the point where the thunderbolt module could recover the dock,
> > > > and the kernel journal does not persist past "PM: suspend entry
> > > > (s2idle)".
> > > >
> > > > Reproduce:
> > > >
> > > >     1. Affected platform: an AMD USB4 host with the thunderbolt driver
> > > >        bound to its NHI PCI functions. Observed on a Dell Pro 14 Plus
> > > >        (PB14255, AMD Phoenix) which exposes two USB4 NHI functions
> > > >        (0000:c6:00.5 and 0000:c6:00.6).
> > > >
> > > >     2. Put the system into s2idle (Low Power S0 Idle / Modern Standby)
> > > >        with no dock attached.
> > > >
> > > >     3. While the system is suspended, plug in a Dell SD25TB4 Thunderbolt 4
> > > >        dock (Goshen Ridge). The plug event wakes the system, and the dock's
> > > >        downstream PCIe bridges are enumerated behind the AMD USB4 PCIe
> > > >        tunnel during the resume.
> > > >
> > > >     4. The machine hard-hangs during the noirq resume phase, before the
> > > >        thunderbolt driver re-establishes the topology. The Dell power
> > > >        indicator flashes the "3A5W" code (3 amber + 5 white lights).
> > > >
> > > >     Removing the trigger makes resume reliable: unbinding the two NHI PCI
> > > >     functions, or unloading the thunderbolt module, before suspend both
> > > >     avoid the hang completely. The difference in those cases is the PCI
> > > >     state the core restores for the driver-bound NHI on resume.
> > > >
> > > > EC team findings (from the platform EC log):
> > > >
> > > > The EC/PD/dock side is healthy across the failing cycle, which points
> > > > the finger at the host resume path rather than the dock:
> > > >
> > > >     - Modern Standby entry and resume are seen on the EC side; the dock
> > > >       plug interrupt during MS is handled and the full power sequence
> > > >       recovers (SLP_S3# okay, PLTRST# received, U8-U20 sequence completed).
> > > >
> > > >     - The EC-to-dock DDM command exchange fully succeeds: all CMsd/CMgd
> > > >       transactions return success (device type, TBT cable type, dock
> > > >       module config for USB/TBT/Audio/LAN).
> > > >
> > > >     - PD/Type-C renegotiation is normal (power contracts up to 95W/100W);
> > > >       no persistent protocol error appears in the log.
> > > >
> > > >     - The only suspicious symptom is host-side: the EC repeatedly logs
> > > >       PmSt_Timeout_Count while waiting for the BIOS/host to consume the
> > > >       wake (PWRB pressed) event. That indicates the host resume path is
> > > >       late or stuck, not an EC-to-dock transport failure. The Dell "3A5W"
> > > >       diagnostic LED code (3 amber + 5 white) maps in the EC code to an
> > > >       SLP_S3#/PLTRST#/RUNPWROK failure indication.
> > > >
> > > > Root cause:
> > > >
> > > > With the driver bound, the PCI core restores the saved NHI config space
> > > > during the noirq resume phase, including PCI_COMMAND with memory space
> > > > and bus mastering enabled. This is the same phase in which the core
> > > > restores the config space of the tunneled PCI bridges and whatever sits
> > > > behind them (the dock). If the AMD host router is made active (memory +
> > > > bus mastering) while the downstream USB4 PCIe tunnel to the dock is still
> > > > being restored and is not yet ready, the host interface starts bus
> > > > activity toward a not-yet-ready endpoint and the PCIe hierarchy wedges.
> > > >
> > > > This matches the workarounds: unbinding the NHI or unloading the module
> > > > means the core does not restore an active NHI over the tunnel during
> > > > noirq, and the hang disappears. Several Thunderbolt-side attempts did not
> > > > help (returning early from nhi_resume_noirq(), disabling host-router wake
> > > > flags, adding an unconditional delay before tunnel activation), which is
> > > > why the actionable boundary is the PCI PM state of the driver-bound AMD
> > > > NHI rather than a later Thunderbolt protocol step. We do not have
> > > > visibility into what the host router does internally in that window; that
> > > > uncertainty is the main reason for sending this as an RFC (see open
> > > > questions below).
> > > >
> > > > What this patch does:
> > > >
> > > > Add a QUIRK_QUIESCE_ON_SUSPEND quirk, currently set for all AMD USB4 host
> > > > routers (matched by vendor AMD + USB4 PCI class), and:
> > > >
> > > >     - clear PCI_COMMAND_MEMORY and PCI_COMMAND_MASTER before the PCI core
> > > >       saves the NHI config space in runtime and system suspend, so the NHI
> > > >       is restored inactive on resume;
> > > >
> > > >     - keep the NHI quiescent across nhi_resume_noirq() (return early without
> > > >       touching the controller), so it stays inactive while the core
> > > >       restores the tunneled bridges and the dock;
> > > >
> > > >     - once the whole system has resumed, re-enable memory space and bus
> > > >       mastering and bring the domain back up from the PM complete callback
> > > >       via tb_domain_resume_noirq(), and from nhi_runtime_resume() for the
> > > >       runtime PM path.
> > > >
> > > > The result is that Thunderbolt/USB4 stays functional after resume instead
> > > > of the machine hanging or the tunnels staying down until the module is
> > > > reloaded.
> > > >
> > > > Test results:
> > > >
> > > > Tested on the Dell Pro 14 Plus (PB14255, AMD Phoenix, two USB4 host
> > > > routers) with the Dell SD25TB4 dock. Without the patch, the sequence
> > > > above hard-hangs during resume. With the patch, repeated suspend/resume
> > > > cycles with the dock connected complete cleanly with no hang. After
> > > > resume the NHI PCI_COMMAND reads back with MEMORY|MASTER set again, and
> > > > the dock's downstream USB devices re-enumerate, confirming the USB tunnel
> > > > is restored and the domain is functional.
> > > >
> > > > Caveats observed while the NHI is quiescent across noirq: config space
> > > > reads to the host router time out and TMU configuration restore fails
> > > > during that window; the controller and domain are fully brought back in
> > > > nhi_complete(). The DP tunnel restore path was not exercised in this
> > > > test, as no external display was driven through the dock during the
> > > > tested cycle.
> > > >
> > > > Open questions for RFC discussion:
> > > >
> > > >     1. Root cause: what does the AMD host router actually do when it is
> > > >        restored with memory + bus mastering enabled during noirq while the
> > > >        downstream tunnel is not ready? Is this an expected ordering
> > > >        constraint, a firmware behavior, or a hardware erratum?
> > > >
> > > >     2. Scope: the quirk currently matches all AMD USB4 host routers by
> > > >        class. Which parts are actually affected? Should this be narrowed
> > > >        (e.g. by DMI or specific device IDs) instead of applied to all AMD
> > > >        USB4?
> > > >
> > > >     3. Mechanism: is clearing both PCI_COMMAND_MEMORY and PCI_COMMAND_MASTER
> > > >        the right lever, or would clearing bus mastering alone suffice and be
> > > >        less invasive? Is poking PCI_COMMAND directly acceptable in the NHI
> > > >        driver, or should this move into a PCI backend op / PCI quirk?
> > > >
> > > > Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
> > >
> > > I have no idea why I didn't receive this patch in my mailbox - I'm obviously
> > > CC'ed.  But I checked my spam and it's not there either.
> > >
> > > But anyway, I am wondering if the real issue here is that we're accessing
> > > the hardware before it's ready.  If you can readily reproduce the issue, can
> > > you try this series to see if it helps?
> > >
> > > https://lore.kernel.org/linux-pci/20260708152650.536604-1-mario.limonciello@amd.com/
> > No, this patch doesn't work.
> > I applied this patch on top of the latest mainline kernel
> > 58717b2a1365 ("Merge tag 'sound-7.2-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound")
> > and the power indicator shows 3 amber and 5 white lights after
> > plugging in the tbt dock during suspend.
> >
>
> Thanks for checking.  That code ended up not helping the original issue it
> was for, a different solution for that issue is being provided.
>
> But I'm wondering, is this issue you're working on something to do with
> pm_async?  Could you turn that off and see if it improves anything?
1. echo 0 | sudo /sys/power/pm_async
2. sudo systemctl suspend
3. plug in the tbt dock
4. power indicator shows 3A5W lights and hard hang

>
> Any chance you can get UART output from the system using a debug board over
> suspend/resume in case there is a panic happening that doesn't flush to
> NVME?
No, there is no UART port on the machine for debugging.

>
> > >
> > > > ---
> > > >    drivers/thunderbolt/nhi.c | 78 +++++++++++++++++++++++++++++++++++++--
> > > >    drivers/thunderbolt/nhi.h |  5 ++-
> > > >    drivers/thunderbolt/pci.c |  8 ++++
> > > >    3 files changed, 85 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
> > > > index 698fb124d529..787185c745ae 100644
> > > > --- a/drivers/thunderbolt/nhi.c
> > > > +++ b/drivers/thunderbolt/nhi.c
> > > > @@ -16,6 +16,7 @@
> > > >    #include <linux/interrupt.h>
> > > >    #include <linux/iommu.h>
> > > >    #include <linux/module.h>
> > > > +#include <linux/pci.h>
> > > >    #include <linux/delay.h>
> > > >    #include <linux/property.h>
> > > >    #include <linux/string_choices.h>
> > > > @@ -40,6 +41,31 @@ static bool host_reset = true;
> > > >    module_param(host_reset, bool, 0444);
> > > >    MODULE_PARM_DESC(host_reset, "reset USB4 host router (default: true)");
> > > > +static bool nhi_quirk_quiesce_on_suspend(const struct tb_nhi *nhi)
> > > > +{
> > > > +	return nhi->quirks & QUIRK_QUIESCE_ON_SUSPEND;
> > > > +}
> > > > +
> > > > +static void nhi_disable_pci_mem_master(struct tb_nhi *nhi)
> > > > +{
> > > > +	struct pci_dev *pdev = to_pci_dev(nhi->dev);
> > > > +	u16 cmd;
> > > > +
> > > > +	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
> > > > +	cmd &= ~(PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER);
> > > > +	pci_write_config_word(pdev, PCI_COMMAND, cmd);
> > > > +}
> > > > +
> > > > +static void nhi_enable_pci_mem_master(struct tb_nhi *nhi)
> > > > +{
> > > > +	struct pci_dev *pdev = to_pci_dev(nhi->dev);
> > > > +	u16 cmd;
> > > > +
> > > > +	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
> > > > +	cmd |= PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER;
> > > > +	pci_write_config_word(pdev, PCI_COMMAND, cmd);
> > > > +}
> > > > +
> > > >    static int ring_interrupt_index(const struct tb_ring *ring)
> > > >    {
> > > >    	int bit = ring->hop;
> > > > @@ -988,6 +1014,9 @@ static int __nhi_suspend_noirq(struct device *dev, bool wakeup)
> > > >    			return ret;
> > > >    	}
> > > > +	if (nhi_quirk_quiesce_on_suspend(nhi))
> > > > +		nhi_disable_pci_mem_master(nhi);
> > > > +
> > > >    	return 0;
> > > >    }
> > > > @@ -1038,6 +1067,18 @@ static int nhi_resume_noirq(struct device *dev)
> > > >    	struct tb_nhi *nhi = tb->nhi;
> > > >    	int ret;
> > > > +	/*
> > > > +	 * If the NHI was quiesced on suspend keep it quiescent (bus
> > > > +	 * mastering and memory access disabled) across the noirq phase.
> > > > +	 * The PCI core restores the config space of the tunneled PCI
> > > > +	 * bridges and anything behind them (e.g. a dock) here; letting the
> > > > +	 * AMD host router become active now can wedge the PCIe bus before
> > > > +	 * the dock side is ready. The controller and domain are brought
> > > > +	 * back up in nhi_complete() once the whole system has resumed.
> > > > +	 */
> > > > +	if (nhi_quirk_quiesce_on_suspend(nhi))
> > > > +		return 0;
> > > > +
> > > >    	/*
> > > >    	 * Check that the device is still there. It may be that the user
> > > >    	 * unplugged last device which causes the host controller to go
> > > > @@ -1064,16 +1105,33 @@ static int nhi_suspend(struct device *dev)
> > > >    static void nhi_complete(struct device *dev)
> > > >    {
> > > >    	struct tb *tb = dev_get_drvdata(dev);
> > > > +	struct tb_nhi *nhi = tb->nhi;
> > > >    	/*
> > > >    	 * If we were runtime suspended when system suspend started,
> > > >    	 * schedule runtime resume now. It should bring the domain back
> > > > -	 * to functional state.
> > > > +	 * to functional state (and undo the quiesce, if any, via
> > > > +	 * nhi_runtime_resume()).
> > > >    	 */
> > > > -	if (pm_runtime_suspended(dev))
> > > > +	if (pm_runtime_suspended(dev)) {
> > > >    		pm_runtime_resume(dev);
> > > > -	else
> > > > -		tb_domain_complete(tb);
> > > > +		return;
> > > > +	}
> > > > +
> > > > +	/*
> > > > +	 * A quiesced NHI (see __nhi_suspend_noirq()) was intentionally
> > > > +	 * left with bus mastering and memory access disabled and its
> > > > +	 * domain was not resumed in nhi_resume_noirq(). Now that the whole
> > > > +	 * system has resumed and the PCI core has finished restoring the
> > > > +	 * tunneled bridges, re-enable the controller and bring the domain
> > > > +	 * back up so Thunderbolt/USB4 keeps working after resume.
> > > > +	 */
> > > > +	if (nhi_quirk_quiesce_on_suspend(nhi)) {
> > > > +		nhi_enable_pci_mem_master(nhi);
> > > > +		tb_domain_resume_noirq(tb);
> > > > +	}
> > > > +
> > > > +	tb_domain_complete(tb);
> > > >    }
> > > >    static int nhi_runtime_suspend(struct device *dev)
> > > > @@ -1091,6 +1149,10 @@ static int nhi_runtime_suspend(struct device *dev)
> > > >    		if (ret)
> > > >    			return ret;
> > > >    	}
> > > > +
> > > > +	if (nhi_quirk_quiesce_on_suspend(nhi))
> > > > +		nhi_disable_pci_mem_master(nhi);
> > > > +
> > > >    	return 0;
> > > >    }
> > > > @@ -1100,6 +1162,14 @@ static int nhi_runtime_resume(struct device *dev)
> > > >    	struct tb_nhi *nhi = tb->nhi;
> > > >    	int ret;
> > > > +	/*
> > > > +	 * The NHI is quiesced (bus mastering and memory access disabled)
> > > > +	 * across runtime suspend as well; re-enable it before resuming the
> > > > +	 * domain.
> > > > +	 */
> > > > +	if (nhi_quirk_quiesce_on_suspend(nhi))
> > > > +		nhi_enable_pci_mem_master(nhi);
> > > > +
> > > >    	if (nhi->ops->runtime_resume) {
> > > >    		ret = nhi->ops->runtime_resume(nhi);
> > > >    		if (ret)
> > > > diff --git a/drivers/thunderbolt/nhi.h b/drivers/thunderbolt/nhi.h
> > > > index d488eadadfce..c8b973150434 100644
> > > > --- a/drivers/thunderbolt/nhi.h
> > > > +++ b/drivers/thunderbolt/nhi.h
> > > > @@ -119,8 +119,9 @@ struct tb_nhi_ops {
> > > >    #define PCI_CLASS_SERIAL_USB_USB4			0x0c0340
> > > >    /* Host interface quirks */
> > > > -#define QUIRK_AUTO_CLEAR_INT	BIT(0)
> > > > -#define QUIRK_E2E		BIT(1)
> > > > +#define QUIRK_AUTO_CLEAR_INT		BIT(0)
> > > > +#define QUIRK_E2E			BIT(1)
> > > > +#define QUIRK_QUIESCE_ON_SUSPEND	BIT(2)
> > > >    /*
> > > >     * Minimal number of vectors when we use MSI-X. Two for control channel
> > > > diff --git a/drivers/thunderbolt/pci.c b/drivers/thunderbolt/pci.c
> > > > index dbb6badda867..4cf8107f1ce8 100644
> > > > --- a/drivers/thunderbolt/pci.c
> > > > +++ b/drivers/thunderbolt/pci.c
> > > > @@ -43,6 +43,14 @@ static void nhi_pci_check_quirks(struct tb_nhi_pci *nhi_pci)
> > > >    	struct tb_nhi *nhi = &nhi_pci->nhi;
> > > >    	struct pci_dev *pdev = to_pci_dev(nhi->dev);
> > > > +	/*
> > > > +	 * AMD USB4 host routers may otherwise become active too early during
> > > > +	 * resume after the PCI core restores the saved COMMAND register.
> > > > +	 */
> > > > +	if (pdev->vendor == PCI_VENDOR_ID_AMD &&
> > > > +	    pdev->class == PCI_CLASS_SERIAL_USB_USB4)
> > > > +		nhi->quirks |= QUIRK_QUIESCE_ON_SUSPEND;
> > > > +
> > > >    	if (pdev->vendor == PCI_VENDOR_ID_INTEL) {
> > > >    		/*
> > > >    		 * Intel hardware supports auto clear of the interrupt
> > >
>
