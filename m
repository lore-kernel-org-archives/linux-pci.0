Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F4734A3C5
	for <linux-pci@vger.kernel.org>; Fri, 24 Apr 2026 22:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777068571; cv=none; b=NwJOhlTPgam/0xXYK2/J1nX8n13A2RWJmnXmsnZQ6O81HemCWmeokQFG2RwQNQvWPc4ZwdxvtyL9qWD76Cv7nrwsvPQ0ee007aAa76EtqfASwC1BGMXEg42LgBesniWOOT6t3ayzDrKNfEHinKfjwnPFV4CrcM4ZN+F+f4L3h3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777068571; c=relaxed/simple;
	bh=g7Rt/3R/nfqSZ9jHy0CQVm1xkgoZtOMS1J6px4mTkgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TZWKnO4SaIZAT1t02O4EztInJpmbPAj/KrkoEcUEb2WbeovNP6Vm15vGIJxOWGKMToYhhKcUMZUSZgwnsRe10ElN6w3h1RHWktRGl3dlzvgvN0jJgnlVCyOk89+A/z4hdzHYHZymj3xijvV71/rv9zhZCmXS7a7uUWoMlW4h4I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nSrm2cMp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nSrm2cMp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E655DC19425;
	Fri, 24 Apr 2026 22:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777068571;
	bh=g7Rt/3R/nfqSZ9jHy0CQVm1xkgoZtOMS1J6px4mTkgY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nSrm2cMpa+714ClWkq7oieu3Hb0wfgQVadpf7+qv0iicVkidYM28sU1rNgwQYTONe
	 Rb2xyqBFYJI/Jnk1XKCbT143JliioabfU0Ei5xBm0aBF/lvjFjNfidrrZvl9vXGYzn
	 oO6l8x5fePT3fQWbWIRJyxDdO0kiGX1GqnkrGVjiWcYRvmF8xN7RjH2kkfmw4V9OKZ
	 q6MOR18RGjeF1+xK3EAteUD2XdRHVygHcoO/rWI6B3U4BcmeFihfyVH6IWhd4qNTNO
	 SmP8/UAKKCq5Zf59fFDlJ33tomBhv8UoOAq7s/EyOmc8U1mluHfslvlJyYXmpeRT3+
	 zrdUXr0Ah6Tvw==
Date: Fri, 24 Apr 2026 16:09:29 -0600
From: Keith Busch <kbusch@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, linux-pci@vger.kernel.org,
	bhelgaas@google.com
Subject: Re: [PATCH] pci: don't fallback to bus reset after failed slot reset
Message-ID: <aevqGci1hLqZQdOF@kbusch-mbp>
References: <20260421150644.3543733-1-kbusch@meta.com>
 <20260424161136.GA11831@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424161136.GA11831@bhelgaas>

On Fri, Apr 24, 2026 at 11:11:36AM -0500, Bjorn Helgaas wrote:
> On Tue, Apr 21, 2026 at 08:06:44AM -0700, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > If a bus has hotplug slots that implement the slot's reset_slot
> > callback, it is not safe to do the non-slot specific bus reset, so don't
> > fallback to it. If a slot reset does fail, the subsequent bus reset will
> > attempt a 2nd link reset on top of previous and fail to handle the
> > hotplug events.
> > 
> > Fixes: 8238cb69c01fe ("PCI: Make reset_subordinate hotplug safe")
> > Signed-off-by: Keith Busch <kbusch@kernel.org>
> 
> Applied to pci/reset for v7.2, thanks!  Will be rebased after
> v7.1-rc1.

I kind of think this is 7.1 material. If a pciehp slot reset fails
because of some hardware issue, that means the device is being removed
after disabling the hotplug "ignore". Falling back to a bus reset walks
the bus' device list without a lock, so it risks grabbing an invalid
pointer racing with the removal.

I didn't intend to get into those details because it may distract to the
pre-existing locking issues that you can hit from a variety of
directions. But for the record, the failure from this particular path
before this patch looks like this:

 pcieport 0000:55:01.0: pciehp: Slot(30): Link Down/Up ignored
 pcieport 0000:55:01.0: pciehp: Slot(30): Link Down
 pcieport 0000:55:01.0: pciehp: Slot(30): Card not present
 Oops: general protection fault, probably for non-canonical address 0xdead000000000180: 0000 [#1] SMP
...
 RIP: 0010:pci_dev_save_and_disable+0x9/0x70
 Code: 89 fe 48 89 c7 e8 57 9d 99 00 48 89 df e8 5f 5e ff ff 4c 89 f7 45 31 e4 e9 6c ff ff ff cc cc cc cc 0f 1f 44 00 00 53 48 89 fb <48> 8b 87 80 00 00 00 48 85 c0 75 27 48 89 df 31 f6 31 d2 e8 6f c1
 RSP: 0018:ffa0000052f27db8 EFLAGS: 00010297
 RAX: 0000000000000086 RBX: dead000000000100 RCX: 0000000000000000
 RDX: 0000000000000400 RSI: 0000000000000004 RDI: dead000000000100
 RBP: ff11000112c8f428 R08: 0000000000000002 R09: ffa0000052f27cfc
 R10: ffffffff82b37718 R11: 0000000000000001 R12: ff11000112c8f440
 R13: ff1100011024b508 R14: dead000000000100 R15: ff1100011024b500
 FS:  00007f63b0ced740(0000) GS:ff11007eea90e000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007f58fc1774e0 CR3: 00000003087c8002 CR4: 0000000000771ef0
 PKRU: 55555554
 Call Trace:
  <TASK>
  pci_bus_save_and_disable_locked+0x20/0x40
  pci_reset_bridge+0x1e6/0x230
  reset_subordinate_store+0x39/0x60
  kernfs_fop_write_iter.llvm.2764860334700261357+0xd4/0x1d0
  ? do_timerfd_settime+0x490/0x490
  __x64_sys_write+0x309/0x540
  do_syscall_64+0x6b/0x250
  entry_SYSCALL_64_after_hwframe+0x4b/0x53
