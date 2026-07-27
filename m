Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F3C386C25;
	Mon, 27 Jul 2026 14:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785162828; cv=none; b=XSIhj5HVBJMHgNVM3ZYTg04Abw9flMtb2ROrGPrdt0Ia5kyHEe42SAE3/D6Y0JArae3gBcK8VnEsy1N3Bko/j/CymVOmiUzDk9nfFXN2GGFBF30yqIs3wAtONRsRRs1rQ30MihI21OsxFawoSkHC0+aAAK4z6tuR6r8xcR5tfDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785162828; c=relaxed/simple;
	bh=qEvON0Yy0K3rxbAOCZTGyskWXur6c8s0d/f9xU6gvIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mcBc4TySH0xW+HPpkD3K9gZl7ELhqhSe7zweAXgHpLWL1s8e1ICjJZmox7VbjknHbiCtGqhikdcwOUslLAW6eh6Yd/koWuvdWkoWbynHLKnuwZFjA52lGeayhrBo29OiLdS89eIffiNvlpjV6dT72CLkGXJ+R7jWReSuccuzxdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mBEZsjsG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mBEZsjsG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4D831F00A3A;
	Mon, 27 Jul 2026 14:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785162826;
	bh=8pQ8xFTiyU5kl4DynYG947K4dKQ5Lkx8jwfBYG7u+kk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mBEZsjsGa6vN7isNN79T4HjfUk8E7SaQtbNNViJtBSpFYVmvdNE9DLLUrQVoMhfhI
	 kDDeudNnW/Vbm8zHmsniEduoUiQCburYgl9T8LBP+h/eguL9RpB7+4xC/JJWZF7lie
	 3IrmOjI014cMpPPYmt5eOh7vasuvIXTvmb34TYGs=
Date: Mon, 27 Jul 2026 16:33:34 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thomas Gleixner <tglx@kernel.org>
Cc: syzbot <syzbot+690d666eb12fca6e1e61@syzkaller.appspotmail.com>,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	Danilo Krummrich <dakr@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	driver-core@lists.linux.dev, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, Ian Abbott <abbotti@mev.co.uk>
Subject: Re: [syzbot] [kernel?] WARNING: proc registration bug in
 unregister_irq_proc (2)
Message-ID: <2026072703-sandbox-oven-5235@gregkh>
References: <6a653bcf.073198cf.94f0f.001c.GAE@google.com>
 <87ik60ikal.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ik60ikal.ffs@fw13>

On Mon, Jul 27, 2026 at 04:22:58PM +0200, Thomas Gleixner wrote:
> On Sat, Jul 25 2026 at 15:42, syzbot wrote:
> 
> > HEAD commit:    3dab139d4795 Merge tag 'rust-fixes-7.2-2' of git://git.ker..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=156bd88e580000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=145fa60d73086782
> > dashboard link: https://syzkaller.appspot.com/bug?extid=690d666eb12fca6e1e61
> > compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
> > 
> > Unfortunately, I don't have any reproducer for this issue yet.
> > 
> > Downloadable assets:
> > disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-3dab139d.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/2b5a401a9dc7/vmlinux-3dab139d.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/7ed2d255bd44/bzImage-3dab139d.xz
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+690d666eb12fca6e1e61@syzkaller.appspotmail.com
> 
> > ------------[ cut here ]------------
> > remove_proc_entry: removing non-empty directory 'irq/20', leaking at least 'comedi_parport'
> > WARNING: fs/proc/generic.c:747 at remove_proc_entry+0x4e7/0x610 fs/proc/generic.c:747, CPU#1: syz.3.389/7224
> 
> So this frees an interupt descriptor, which still has an active
> interrupt request on it.
> 
> > Modules linked in:
> > CPU: 1 UID: 0 PID: 7224 Comm: syz.3.389 Tainted: G             L      syzkaller #0 PREEMPT(full) 
> >  unregister_irq_proc+0x206/0x2a0 kernel/irq/proc.c:406
> >  free_desc+0x89/0x330 kernel/irq/irqdesc.c:482
> >  irq_free_descs kernel/irq/irqdesc.c:874 [inline]
> >  irq_free_descs+0x84/0xc0 kernel/irq/irqdesc.c:865
> >  irq_domain_free_irqs+0x46a/0x5c0 kernel/irq/irqdomain.c:1917
> >  mp_unmap_irq+0xf8/0x130 arch/x86/kernel/apic/io_apic.c:1061
> >  acpi_unregister_gsi_ioapic+0x40/0x60 arch/x86/kernel/acpi/boot.c:722
> >  acpi_unregister_gsi+0x25/0x40 arch/x86/kernel/acpi/boot.c:751
> >  acpi_pci_irq_disable+0x275/0x360 drivers/acpi/pci_irq.c:517
> >  pcibios_disable_device arch/x86/pci/common.c:706 [inline]
> >  pcibios_disable_device+0x89/0xb0 arch/x86/pci/common.c:703
> >  do_pci_disable_device+0x9f/0x100 drivers/pci/pci.c:2170
> >  pci_disable_device+0x130/0x270 drivers/pci/pci.c:2206
> >  pci_device_remove+0xb2/0x1d0 drivers/pci/pci-driver.c:512
> >  device_remove+0xcb/0x180 drivers/base/dd.c:616
> >  __device_release_driver drivers/base/dd.c:1349 [inline]
> >  device_release_driver_internal+0x44e/0x620 drivers/base/dd.c:1372
> >  unbind_store+0xf8/0x110 drivers/base/bus.c:244
> >  drv_attr_store+0x74/0xb0 drivers/base/bus.c:125
> >  sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:145
> >  kernfs_fop_write_iter+0x3e0/0x5f0 fs/kernfs/file.c:345
> >  new_sync_write fs/read_write.c:595 [inline]
> >  vfs_write+0x6ac/0x1050 fs/read_write.c:687
> >  ksys_write+0x12a/0x250 fs/read_write.c:739
> >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >  do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> unbind() releases the driver, which removes the device, but the device
> removal does not end up freeing the requested interrupt and
> pci_device_remove() ends up correctly freeing the legacy PCI interrupt
> descriptor through the above call chain.
> 
> The real question is how that comedi parport driver ends up on a PCI
> device without actually registering a PCI driver with a proper remove
> callback. It seems it just attaches blindly to something which user
> space hands in through the ioctl().
> 
> Though deciphering this comedi code is beyond my skillset.
> 
> I rather go and harden the interrupt core against such bogosities.

Sure, but really, anyone doing a manual "unbind" gets to keep the pieces
if the kernel can't handle it. The comedi driver really aren't all that
ready for stuff like this as they are in systems that are fixed to the
shop floor, driving big stone cutters.

So no real rush/need that I can see here.

thanks,

greg k-h
