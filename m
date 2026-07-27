Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D25F3783CC;
	Mon, 27 Jul 2026 14:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785162184; cv=none; b=f33GViRTGX2f1Pi19VnxjsdW1aKwZ8j8lPn0vAtMeE5DVkaMYICCPpaxC+vvTUZt1qzvLXlzWyffplfPR92LrRVbhFCfj4u/+4ptWb6LdG6lTMH6baFnr8k/p9Ewf3PsHtTGYMubQl8OiYZOUWjwuySV/3K1DFP0hycJEBkQne8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785162184; c=relaxed/simple;
	bh=xgNTSFvDc6PJZbCsJuoOE7jjDZVtyM9GANdc4NAX2tk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MXbtwEyFhR+QIbO//6QYEbe4y7MlkOk6t+FDzQwKMDT4TzNauCFyxuMqY4iRR7ouih0CXRH/ctDUJpKR9OI5aelWJ2LEO6kF0zkdi/anhV2xUCSsXJ5yEBRDLMk03ZXRB0pqT9lW+PIWYy53no0XpRc5L3k8xUkmS3IW/UxnvoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HrLrJ3kE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HrLrJ3kE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6BF21F000E9;
	Mon, 27 Jul 2026 14:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785162182;
	bh=2zYwmPMrvROiN1z06ajoqtgEHZKOmjIvuVvPw9f14xA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=HrLrJ3kEtu2IHmBjPlebu6elRgARxU4OPVP0TGHjwWWCfPz5CTjD9oYfma96SnkIn
	 wT5vqmOrtDtOdXGpP9WgxJnFOYZlJ5FexMBiUBhwnanKY/kC2S4glY8qO5ozsNINY2
	 iv7YcRwoFh/FGXwujSmuIGQsjLFyMLmL9lXAhdZAb3AHjC9R2Jtnm1ag4EjoHVGPKl
	 OE5KrNSq9d7ZLHIPbIN3h3lCVbaqVrm+8bJuD3vP7FSiYkKmXwefTW38hQxOFWp8CQ
	 FJmDKWwp5+mkEjae36IcB/XbuaK8K+R9FE1hx7WwCCFitvyIjo8rz4CN2jW55j4Szx
	 56r1HW62NgB1w==
From: Thomas Gleixner <tglx@kernel.org>
To: syzbot <syzbot+690d666eb12fca6e1e61@syzkaller.appspotmail.com>,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich
 <dakr@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 driver-core@lists.linux.dev, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, Ian Abbott <abbotti@mev.co.uk>
Subject: Re: [syzbot] [kernel?] WARNING: proc registration bug in
 unregister_irq_proc (2)
In-Reply-To: <6a653bcf.073198cf.94f0f.001c.GAE@google.com>
References: <6a653bcf.073198cf.94f0f.001c.GAE@google.com>
Date: Mon, 27 Jul 2026 16:22:58 +0200
Message-ID: <87ik60ikal.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Jul 25 2026 at 15:42, syzbot wrote:

> HEAD commit:    3dab139d4795 Merge tag 'rust-fixes-7.2-2' of git://git.ker..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=156bd88e580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=145fa60d73086782
> dashboard link: https://syzkaller.appspot.com/bug?extid=690d666eb12fca6e1e61
> compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-3dab139d.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/2b5a401a9dc7/vmlinux-3dab139d.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/7ed2d255bd44/bzImage-3dab139d.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+690d666eb12fca6e1e61@syzkaller.appspotmail.com

> ------------[ cut here ]------------
> remove_proc_entry: removing non-empty directory 'irq/20', leaking at least 'comedi_parport'
> WARNING: fs/proc/generic.c:747 at remove_proc_entry+0x4e7/0x610 fs/proc/generic.c:747, CPU#1: syz.3.389/7224

So this frees an interupt descriptor, which still has an active
interrupt request on it.

> Modules linked in:
> CPU: 1 UID: 0 PID: 7224 Comm: syz.3.389 Tainted: G             L      syzkaller #0 PREEMPT(full) 
>  unregister_irq_proc+0x206/0x2a0 kernel/irq/proc.c:406
>  free_desc+0x89/0x330 kernel/irq/irqdesc.c:482
>  irq_free_descs kernel/irq/irqdesc.c:874 [inline]
>  irq_free_descs+0x84/0xc0 kernel/irq/irqdesc.c:865
>  irq_domain_free_irqs+0x46a/0x5c0 kernel/irq/irqdomain.c:1917
>  mp_unmap_irq+0xf8/0x130 arch/x86/kernel/apic/io_apic.c:1061
>  acpi_unregister_gsi_ioapic+0x40/0x60 arch/x86/kernel/acpi/boot.c:722
>  acpi_unregister_gsi+0x25/0x40 arch/x86/kernel/acpi/boot.c:751
>  acpi_pci_irq_disable+0x275/0x360 drivers/acpi/pci_irq.c:517
>  pcibios_disable_device arch/x86/pci/common.c:706 [inline]
>  pcibios_disable_device+0x89/0xb0 arch/x86/pci/common.c:703
>  do_pci_disable_device+0x9f/0x100 drivers/pci/pci.c:2170
>  pci_disable_device+0x130/0x270 drivers/pci/pci.c:2206
>  pci_device_remove+0xb2/0x1d0 drivers/pci/pci-driver.c:512
>  device_remove+0xcb/0x180 drivers/base/dd.c:616
>  __device_release_driver drivers/base/dd.c:1349 [inline]
>  device_release_driver_internal+0x44e/0x620 drivers/base/dd.c:1372
>  unbind_store+0xf8/0x110 drivers/base/bus.c:244
>  drv_attr_store+0x74/0xb0 drivers/base/bus.c:125
>  sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:145
>  kernfs_fop_write_iter+0x3e0/0x5f0 fs/kernfs/file.c:345
>  new_sync_write fs/read_write.c:595 [inline]
>  vfs_write+0x6ac/0x1050 fs/read_write.c:687
>  ksys_write+0x12a/0x250 fs/read_write.c:739
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f

unbind() releases the driver, which removes the device, but the device
removal does not end up freeing the requested interrupt and
pci_device_remove() ends up correctly freeing the legacy PCI interrupt
descriptor through the above call chain.

The real question is how that comedi parport driver ends up on a PCI
device without actually registering a PCI driver with a proper remove
callback. It seems it just attaches blindly to something which user
space hands in through the ioctl().

Though deciphering this comedi code is beyond my skillset.

I rather go and harden the interrupt core against such bogosities.

Thanks,

        tglx



