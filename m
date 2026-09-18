Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6A019B5A3;
	Fri, 18 Sep 2026 22:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789770189; cv=none; b=ccILrvbLF9jDgkwh16PnWRBsDIaQ92OV3A7haY+bNRfp65neSKJXtv8I9n5XpuGKMd/SrcO1afO+p8VZAAEeEWRVxGv14TSWtPkxbabYpFg0daBkvza+jU0MW6cNMWeZ6VNsNWBUAsVxtLXfvM9731Fq9jhYvxHNB6j6LWtrBN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789770189; c=relaxed/simple;
	bh=nucvwISXMCDKMHV4jkfXUTO7Xx/vX5jFdJJQOxsGeFM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=JYUFIoEM49fQGKHlVrbvOUEXJpc6hV75g+yaNMuxA3Jq4KSwEgBu0u8wJ/FRjGdI+q6rY6dlx82UM1bymyz/yZdSNe/M7IpSDmWQdVX1jZyHeMCKTJvBOL7Rzy/+Ejhmrg6M+/r6gZaEQ/MinjN3OENrhJ2BhYwa1fdnHDYt82s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OPbZz5ah; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OPbZz5ah"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53B611F000FF;
	Fri, 18 Sep 2026 22:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789770187;
	bh=aadCeXW0ciM6vLWCVdfuHHJvH4AslTQpNsGe5hz/Ry8=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=OPbZz5ahJ9sLLgQIf3lt69hzVr8HxIVnxzlqzjY2Hh0MMVxgKiBqp3vEk6IxtayRw
	 Zxld/ydvwMA06F6xDGgfftaTE2mJZ3IbVG843iflMfUHO4k7bfA5hoEG3OaKxwsMGT
	 7Dt6plr9ZCHB/xI8GxvHppVsMlVcL5z4iTHMKd09h+KftaHvR15nd+K8sOQg2rxboH
	 jAli1JZhQwsnL4iKNeWn6SRtnsubRZ9E0Y9SjFC65iaqc7nKrLwgWRFcaraz2EYkKP
	 +e6X2ZatVAFEI2fn+BeukdDAzce0WX2ewUQMLICcu+xsy534pvf38+Mw6EWijg+6je
	 5oCjPFj42A/UQ==
Date: Fri, 18 Sep 2026 17:23:05 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Josh Perry <josh@6bit.com>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>, bhelgaas@google.com,
	Mario Limonciello <mario.limonciello@amd.com>, hkallweit1@gmail.com,
	nic_swsd@realtek.com, rafael@kernel.org, linux-pci@vger.kernel.org,
	netdev@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [REGRESSION 6.16] r8169 =?utf-8?Q?RTL8?=
 =?utf-8?Q?168h=2F8111h_fails_to_probe_=E2=80=94_=22Unable_to_change_power?=
 =?utf-8?Q?_state_from_D3cold_to_D0=22_=E2=80=94?= bisected to 4d4c10f763d7
Message-ID: <20260918222305.GA1200870@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1ad46724-18a6-4cc1-9c40-f34fbf0f0b7c@amd.com>

On Sun, Jun 21, 2026 at 12:24:42PM -0700, Mario Limonciello wrote:
> On 6/17/26 01:32, Thorsten Leemhuis wrote:
> > On 6/12/26 03:07, Josh Perry wrote:
> > > #regzbot introduced: 4d4c10f763d7
> > > 
> > > Since v6.16 one of two onboard RTL8168h/8111h NICs on this board fails
> > > to probe on boot; the device drops to D3cold and the driver can't bring
> > > it back:
> > 
> > FWIW, that commit is 4d4c10f763d780 ("PCI: Explicitly put devices into
> > D0 when initializing") [v6.16-rc1] from Mario, who is already CCed, but
> > looks like might be on holiday or something due to inactivity on the
> > lists in the recent days. So it might take a few days before this moves on.
> > 
> > Josh, this is not my area of expertise, but there are two things I guess
> > might be helpful:
> > 
> > * retry with 7.1
> > * upload "dmesg" and "sudo lspci -vvv" output from working and broken
> > kernels somewhere (like bugzilla.kernel.org).
> 
> Yes; please retry with mainline.  We already had multiple regressions from
> that commit fixed, so if you bisected down to this commit then it's
> plausible that there is already a fix.

Thanks a lot for your bisection and detailed report, Josh.  Can you
verify whether this is still a problem?

The only commit that claims to fix 4d4c10f763d7 ("PCI: Explicitly put
devices into D0 when initializing") is 907a7a2e5bf4 ("PCI/PM: Set up
runtime PM even for devices without PCI PM"), and you already verified
that it did not fix the problem (both appeared in v6.16).

c855c9921da7 ("PCI/ASPM: Don't reconfigure ASPM entering low-power
state"), which appeared in v7.2-rc1, mentions a similar symptom
("Unable to change power state from D3hot to D0, device inaccessible") 
so it's possible that it would fix the issue.

> > >    r8169 0000:02:00.0 eth0: RTL8168h/8111h, 00:2b:67:48:40:01, XID 541,
> > > IRQ 137
> > >    r8169 0000:04:00.0: Unable to change power state from D3cold to D0,
> > > device inaccessible
> > >    r8169 0000:04:00.0: Mem-Wr-Inval unavailable
> > >    r8169 0000:04:00.0: error -EIO: PCI read failed
> > >    r8169 0000:04:00.0: probe with driver r8169 failed with error -5
> > > 
> > > The board has two identical RTL8168h NICs (both XID 541): 0000:02:00.0
> > > and 0000:04:00.0. Only 04:00.0 fails — its sibling 02:00.0, on a
> > > different root port, probes and works normally on the very same kernel
> > > and boot. The failing NIC then does not appear (no enp4s0), taking the
> > > machine's WAN offline. This strongly suggests the problem is port/
> > > topology-specific rather than device- or driver-specific: the upstream
> > > port behind 04:00.0 is placed in D3cold and the endpoint cannot be
> > > resumed to D0.
> > > 
> > > Hardware: RTL8168h/8111h, XID 541, PCI 04:00.0 (onboard 1GbE).
> > > Platform: Lenovo ThinkCentre M90n-1 (11AHS0B200), BIOS M2AKT49A
> > > (2026-03-25, latest available). Firmware is current, so this is not a
> > > platform-firmware issue.
> > > 
> > > Bisection: v6.15 good, v6.16 bad (verified by booting both). I then
> > > reverted 4d4c10f763d7 ("PCI: Explicitly put devices into D0 when
> > > initializing") together with its follow-up 907a7a2e5bf4 ("PCI/PM: Set up
> > > runtime PM even for devices without PCI PM") on top of 6.16.7: the NIC
> > > probes and links at 1Gbps/Full normally, with no workaround:
> > > 
> > >    r8169 0000:04:00.0 eth1: RTL8168h/8111h, 00:2b:67:48:40:02, XID 541,
> > > IRQ 138
> > >    r8169 0000:04:00.0 enp4s0: Link is Up - 1Gbps/Full - flow control rx/tx
> > > 
> > > Workaround: booting an unmodified v6.16+ kernel with pcie_port_pm=off
> > > also restores the NIC, which is consistent with the upstream port being
> > > placed in D3cold and the device failing to resume to D0 after the
> > > explicit-D0 init change.
> > > 
> > > The follow-up 907a7a2e5bf4 does not fix this resume case: v6.18.33 is
> > > still affected (retested today on current firmware).
> > > 
> > > Happy to test patches or provide full dmesg / lspci.
> > > 
> > 
> 
