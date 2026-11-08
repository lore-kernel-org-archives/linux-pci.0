Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794171691;
	b=aeqn+BNBH4O7PVkggZ3jSHeSJxlQKbSE8XyHN804cJd7o8BDcD4z9FFjxIGuAQmadQFs
	 8DP4PkhqXxPvu6a34xuaVJ9kA+/gSXvC9DVqZOm9BcO4QKM+y2p7qesi4t07sL8e07zpd
	 B6nUf7bwjp4TlUUfkopcbgOwjJQgGkUfC3HXm0mR6NYs4S7HuWFMF0VhOcRhufQW1EUys
	 a6wCbWXlrWHTv4DLglY70fJgLyXo3E6F6OSx+x3RtaIxVpGuVtvrD9rUz6/HK4qCbpzLI
	 ZoTlDolTO9hbVGjKw1VcDN67jrJ2P0apopLKVJv1Doia9WTRNfisgJX15mg3Wo4dmTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794171691;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=CCDT5czqSKuVF8dnEL2I3ztvJrFNsCyUNOb0I8ij6bw=;
	b=Rcs4Nq2Rk3jfjooJfEgsHDRu0cBtzFC+/TsgXsnUEfdCISUYngibx5Z5mmivlztSbU2a
	 hWlMXyP6QS0sasH7waGx6A18IbVypd/D0GBDUZsfqdsruYp0kmBF1vCXJNbIWKew5pM4h
	 h/X1ZtCAKf1W2BtDcIi+w6ZLFn7zYd8CXHm0z+BgED9vUr5eVumWHwCdIL73bZuHzGybK
	 1zj1sBY7J8gU3fKYCyAwtAApGV0gR42hIDsuGq/RbEA5Ucn/5DABeqphEMN+4cpkFtjTT
	 JJDhFeWsURLG2cU8ZoGp0MNoF2zK0Xebqbf8rU0wYdYAMIY1xO9461i3MK0sK5fyGCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PEPoB+M6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69291606A320;
	Sun,  8 Nov 2026 21:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PEPoB+M6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B22AF1F0089F;
	Sun,  8 Nov 2026 21:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794171690;
	bh=CCDT5czqSKuVF8dnEL2I3ztvJrFNsCyUNOb0I8ij6bw=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=PEPoB+M6W27TGTVULDx6PMHDtm1KDmwnHPbWXSeSQRPlMO1NQoviHOUKeWMQ0jX94
	 KLRbF9xWaCzCjblUkt6J3mVgf8bHEUswOIuHBtO1o2Iix2wbcwC6xGJ9FAcUE5YG26
	 dxfgAvzWso7PxxbOYWsCsiwXvUoqzhKtM5Qx2eeyqv80NLeoku2cHArU57/5hmFNYq
	 eSIjqdp0IfssJDYtAttZCQ4sDFAOfXppW7E7xQ3VsleSDWXsXTRd4tOBG7yYxX+rRS
	 80uxSPtqGFHlWUlzpR7/fWGe1qPJbQg4uLSr1WyHB8jvCkzla9kQFaH/2ooOo262M0
	 6VH+8frUXc18g==
Date: Sun, 8 Nov 2026 15:01:29 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Louis H. Poulin II" <poulin.louis@student.oaklandcc.edu>
Cc: linux-pci@vger.kernel.org, zhaojinming@uniontech.com, lukas@wunner.de,
	linux-kernel@vger.kernel.org,
	manivannan.sadhasivam@oss.qualcomm.com, dsimic@manjaro.org,
	shawn.lin@rock-chips.com, kees@kernel.org,
	krishna.chundru@oss.qualcomm.com,
	Daniel Stodden <daniel.stodden@gmail.com>,
	Ding Hui <dinghui@sangfor.com.cn>
Subject: Re: [PATCH] PCI/ASPM: Add missing NULL check for link in sysfs
 show/store callbacks
Message-ID: <20261108210129.GA51008@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGQButvJXLyiK2eRvuRmx=rGxN1M334=7vsp1Whq3w0mpeV1yg@mail.gmail.com>

[+cc Daniel, Ding]

On Sun, Nov 08, 2026 at 12:36:30PM -0800, Louis H. Poulin II wrote:
> Hi Bjorn,
> 
> > Your next message suggests that the device and upstream bridge are
> > valid, so possibly bridge->link_state was NULL. I would instrument
> > pcie_aspm_get_link() to verify that and add a dump_stack() in
> > free_link_state().
> 
> Yes. The instrumentation shows bridge->link_state becoming NULL after
> function-0 removal. Later lookups for surviving functions 0000:75:00.4
> and 0000:75:00.6 still find upstream bridge 0000:00:08.1, but its
> link_state is NULL.
> 
> This was on the ASUS TUF GAMING X870-PLUS WIFI, BIOS 1805, running
> 7.2.15-ogc1.1.fc45.aspm453.x86_64 (#453). It was built from Linux
> 7.2.15 plus the OpenGamingCollective downstream patch set and local
> diagnostics. This is not a reproduction on unmodified upstream.
> 
> The diagnostic patch logs initialization, publication, visibility,
> lookup and teardown, with dump_stack() in free_link_state(). It also
> adds NULL checks returning -ENODEV to the ASPM and clock power-management
> sysfs show/store callbacks so collection can continue. These checks
> are diagnostic containment, not a proposed fix.
> 
> The trigger is a local systemd oneshot,
> helix-gaming-disable-igpu.service. Its stated purpose is to keep the
> iGPU display function out of Gamescope DRM enumeration. Its command is:
> 
>   /bin/sh -c 'if [ -e /sys/bus/pci/devices/0000:75:00.0/remove ]; then
> echo 1 > /sys/bus/pci/devices/0000:75:00.0/remove; fi'

Thanks for the debugging.  Before that remove, can you collect the
output of "sudo lspci -vv" so we have a picture of the whole topology?

It seems legit to remove one function of the multi-function device at
75:00.x (from a software perspective; obviously we can't physically
remove it separately from the other functions), but seems like we
prematurely discard the ASPM link info when doing so.  I haven't dug
into them, but maybe these commits have some bearing on this:

  456d8aa37d0f ("PCI/ASPM: Disable ASPM on MFD function removal to avoid use-after-free")
  cbf937dcadfd ("PCI/ASPM: Fix link state exit during switch upstream function removal")

> It targets function .0, not the bridge or siblings. In the same boot,
> systemd retains ExecMainPID=2486, matching the shell PID in the stack.
> Its recorded execution interval is 10.303980-10.348137 s monotonic;
> the journal records exit-free at 10.308186 s, within that interval.
> The dmesg timestamps in the separate excerpt below are left unchanged.
> 
> Stack excerpt from the dump_stack() in free_link_state():
> 
>   CPU: 1 UID: 0 PID: 2486 Comm: sh Not tainted
> 7.2.15-ogc1.1.fc45.aspm453.x86_64 #453 PREEMPT(lazy)
>   dump_stack_lvl+0x5d/0x80
>   pcie_aspm_exit_link_state.cold+0x5/0x14
>   pci_remove_bus_device+0x10b/0x170
>   pci_stop_and_remove_bus_device_locked+0x22/0x30
>   remove_store+0x83/0xa0
>   kernfs_fop_write_iter+0x178/0x200
>   vfs_write+0x281/0x560
>   ksys_write+0x7b/0x110
> 
> The matching vmlinux resolves the cold frame to free_link_state(),
> inlined into pcie_aspm_exit_link_state().
> 
> Selected dmesg fields (abridged; attr= names the downstream device in
> publish-link, free-link and clear-link records):
> 
>   [0.367481] seq=98 event=publish-link dev=0000:00:08.1
> link_state=present attr=0000:75:00.0
>   [0.367583] seq=159 event=visible dev=0000:75:00.4
> bridge=0000:00:08.1 link_state=present attr=l0s_aspm arg=420
>   [0.367609] seq=177 event=visible dev=0000:75:00.6
> bridge=0000:00:08.1 link_state=present attr=l0s_aspm arg=420
>   [10.307508] seq=191 event=exit-free dev=0000:75:00.0
> bridge=0000:00:08.1 link_state=present
>   [10.308089] seq=192 event=free-link dev=0000:00:08.1
> link_state=present attr=0000:75:00.0
>   [10.308728] seq=193 event=clear-link dev=0000:00:08.1
> link_state=NULL attr=0000:75:00.0
>   [10.896953] seq=194 event=get-bridge-link-null dev=0000:75:00.6
> bridge=0000:00:08.1 link_state=NULL
>   [10.896958] seq=195 event=show dev=0000:75:00.6 bridge=0000:00:08.1
> link_state=NULL attr=l0s_aspm
>   [10.896960] seq=196 event=show-result dev=0000:75:00.6
> bridge=0000:00:08.1 link_state=NULL attr=l0s_aspm arg=-19
>   [297.729199] seq=242 event=get-bridge-link-null dev=0000:75:00.4
> bridge=0000:00:08.1 link_state=NULL
>   [297.729204] seq=244 event=show-result dev=0000:75:00.4
> bridge=0000:00:08.1 link_state=NULL attr=l0s_aspm arg=-19
> 
> arg=420 is mode 0644. l1_aspm was also exposed on .4 and .6 (seq 161
> and 179); subsequent l1_aspm reads also reached the NULL lookup. The
> -19 results above are produced by the added diagnostic guards. In
> this source, the unguarded show path dereferences link without a check.
> 
> The trace shows publication for downstream .0, visibility with link
> state present, then teardown and pointer clearing when .0 is removed.
> Both siblings remain with reachable attributes. The first recorded
> post-teardown NULL lookup on .6 is about 0.59 s after clear-link in
> dmesg; .4 also reaches the NULL lookup at 297.729199 s.
> 
> This establishes teardown followed by NULL lookups. It does not
> demonstrate a concurrent use-after-free or rule out other lifetime
> issues. I have preserved the full logs, diagnostic patch, source
> inputs, configuration and matching-vmlinux symbolization.
> 
> Thanks,
> Louis
> 
> 
> On Thu, 05 Nov 2026 17:46:28 -0600, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > [+cc other members of conversation at
> > https://lore.kernel.org/all/20260727072915.3954329-1-zhaojinming@uniontech.com]
> >
> > On Wed, Nov 04, 2026 at 03:22:51PM -0800, Poulin, Louis wrote:
> > > Hi,
> > >
> > > We observed a cold-boot crash in l0s_aspm_show() that appears to
> > > contradict the assumption in this thread that the visibility check
> > > always keeps readers out when the ASPM link is unavailable.
> > >
> > > This was on an ASUS TUF GAMING X870-PLUS WIFI, BIOS 1805, running
> > > Bazzite's 7.2.15-ogc1.1.fc45.x86_64 kernel with InputPlumber 0.83.1.
> > > The fault occurred about 10 seconds into a cold boot. An earlier boot
> > > on the same system had the same fault address and symbol offset on
> > > 7.2.9-ogc3.1.fc44.x86_64 with InputPlumber 0.83.0. Both observations
> > > were on downstream kernels. The captured 7.2.15 kernel was tainted
> > > O/E (out-of-tree and unsigned module).
> > >
> > > Relevant excerpt from 7.2.15:
> > >
> > >   BUG: kernel NULL pointer dereference, address: 0000000000000030
> > >   Comm: inputplumber
> > >   RIP: 0010:l0s_aspm_show+0x47/0x80
> > >   RAX: 0000000000000000
> > >   CR2: 0000000000000030
> > >   Call Trace:
> > >     dev_attr_show+0x1f/0x50
> > >     sysfs_kf_seq_show+0xa8/0x110
> > >     seq_read_iter+0x132/0x4c0
> > >     vfs_read+0x34d/0x490
> > >
> > > The faulting instruction accesses offset 0x30 from the NULL register.
> > > In the corresponding source, aspm_attr_show_common() dereferences the
> > > result of pcie_aspm_get_link(). The read reached the callback even
> > > though that lookup had no link to return. The kernel killed the
> > > InputPlumber main thread and the service stopped answering
> > > ObjectManager.GetManagedObjects. This blocked the boot-time controller
> > > setup.
> > >
> > > We are building a diagnostic kernel that returns -ENODEV in that
> > > specific read callback when the link is absent and logs the PCI device
> > > and upstream bridge. The device and the reason its link state was
> > > missing are still unknown. We have not reproduced the fault on an
> > > unmodified upstream kernel.
> > >
> > > Would this trace justify a guard in the read callback, or is there a
> > > preferred way to instrument link-state teardown and sysfs visibility
> > > on this hardware? We can follow up with the device and bridge once
> > > captured.
> >
> > I don't think we should add a guard in addition to
> > aspm_ctrl_attrs_are_visible().
> >
> > pcie_aspm_get_link() must have returned non-NULL in
> > aspm_ctrl_attrs_are_visible() for the sysfs file to be visible.
> >
> > If it later returned NULL in aspm_attr_show_common(), we must have a
> > bug, like a lifetime issue or some kind of corruption.  Adding a guard
> > would just hide the bug.
> >
> > Your next message suggests that the device and upstream bridge are
> > valid, so possibly bridge->link_state was NULL.  I would instrument
> > pcie_aspm_get_link() to verify that and add a dump_stack() in
> > free_link_state().
> >
> > > Kernel source for the captured build
> > > https://github.com/OpenGamingCollective/linux/blob/f6857d4bfd614b90302903490796ef376be0a67d/drivers/pci/pcie/aspm.c
> > >
> > > Thanks,
> > > Louis
