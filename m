Received: from smtp70.iad3a.emailsrvr.com (smtp70.iad3a.emailsrvr.com [173.203.187.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85CE3ED3CC
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 15:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.203.187.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785165097; cv=none; b=NdfAmvQ2MiaOMEG+N9hTcUc7AQNmoZ1cdNJyYz/AXoaj905KZkhfFG/4nnW9JB74nrWtroJj6CZnZ192YY0w48AvlYCe5k3BDd5wcP1UjSdnv1Am/MEvYkzcqgdFK78QjpzqdZ7HUBiQ0N8tJwPUlHOzZHZI3dKKPdT5b80zlFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785165097; c=relaxed/simple;
	bh=ZEabfeduTzOfzBFUTRDyw1lfD4I0nS+Cm4lYfQEyCVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nHyB5N5p52GcV8p8f/kMZpy0ynKA2kUvsTNi/lFuc4n4UpIFVLop0cYlIF6J+8AJ0Kv2TgySK26A9FwzRJok/0Xu8OXn07EvFn5viyr1/pR1qRNmd1HuA0+sVegrHB4PR6CEsbFWF+MlLxgTO9aQgT4WEA0c+AMOfFPLtmokM08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=HdLG2Nf4; arc=none smtp.client-ip=173.203.187.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="HdLG2Nf4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1785164633;
	bh=ZEabfeduTzOfzBFUTRDyw1lfD4I0nS+Cm4lYfQEyCVk=;
	h=Date:Subject:To:From:From;
	b=HdLG2Nf4VOgIN4BN8rW54RjppxBt7jPxPDptP1WPg8CVGe3AyOCbnduJAdmQ5DC7K
	 OC6NIDRsvhDHpUNTUnRPHDLOMyztRwaKJDQ2J5pscAxV9NZjKSPXShU9hmRa9QYWVc
	 dx43Guz4HTYHsgeXJwOXIBQoYtSdXewEDxDz+xIo=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp1.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 7D72559B1;
	Mon, 27 Jul 2026 11:03:52 -0400 (EDT)
Message-ID: <c82a9772-bcc2-4a74-9247-d90df4caa0ae@mev.co.uk>
Date: Mon, 27 Jul 2026 16:03:53 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [kernel?] WARNING: proc registration bug in
 unregister_irq_proc (2)
To: Thomas Gleixner <tglx@kernel.org>,
 syzbot <syzbot+690d666eb12fca6e1e61@syzkaller.appspotmail.com>,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 driver-core@lists.linux.dev, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org
References: <6a653bcf.073198cf.94f0f.001c.GAE@google.com>
 <87ik60ikal.ffs@fw13>
Content-Language: en-US
From: Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
In-Reply-To: <87ik60ikal.ffs@fw13>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Classification-ID: 70be1a8d-9012-45ee-bcf1-9093cf3a296e-1-1

On 2026-07-27 15:22, Thomas Gleixner wrote:
> On Sat, Jul 25 2026 at 15:42, syzbot wrote:
> 
>> HEAD commit:    3dab139d4795 Merge tag 'rust-fixes-7.2-2' of git://git.ker..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=156bd88e580000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=145fa60d73086782
>> dashboard link: https://syzkaller.appspot.com/bug?extid=690d666eb12fca6e1e61
>> compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
>>
>> Unfortunately, I don't have any reproducer for this issue yet.
>>
>> Downloadable assets:
>> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-3dab139d.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/2b5a401a9dc7/vmlinux-3dab139d.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/7ed2d255bd44/bzImage-3dab139d.xz
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+690d666eb12fca6e1e61@syzkaller.appspotmail.com
> 
>> ------------[ cut here ]------------
>> remove_proc_entry: removing non-empty directory 'irq/20', leaking at least 'comedi_parport'
>> WARNING: fs/proc/generic.c:747 at remove_proc_entry+0x4e7/0x610 fs/proc/generic.c:747, CPU#1: syz.3.389/7224
> 
> So this frees an interupt descriptor, which still has an active
> interrupt request on it.
> 
>> Modules linked in:
>> CPU: 1 UID: 0 PID: 7224 Comm: syz.3.389 Tainted: G             L      syzkaller #0 PREEMPT(full)
>>   unregister_irq_proc+0x206/0x2a0 kernel/irq/proc.c:406
>>   free_desc+0x89/0x330 kernel/irq/irqdesc.c:482
>>   irq_free_descs kernel/irq/irqdesc.c:874 [inline]
>>   irq_free_descs+0x84/0xc0 kernel/irq/irqdesc.c:865
>>   irq_domain_free_irqs+0x46a/0x5c0 kernel/irq/irqdomain.c:1917
>>   mp_unmap_irq+0xf8/0x130 arch/x86/kernel/apic/io_apic.c:1061
>>   acpi_unregister_gsi_ioapic+0x40/0x60 arch/x86/kernel/acpi/boot.c:722
>>   acpi_unregister_gsi+0x25/0x40 arch/x86/kernel/acpi/boot.c:751
>>   acpi_pci_irq_disable+0x275/0x360 drivers/acpi/pci_irq.c:517
>>   pcibios_disable_device arch/x86/pci/common.c:706 [inline]
>>   pcibios_disable_device+0x89/0xb0 arch/x86/pci/common.c:703
>>   do_pci_disable_device+0x9f/0x100 drivers/pci/pci.c:2170
>>   pci_disable_device+0x130/0x270 drivers/pci/pci.c:2206
>>   pci_device_remove+0xb2/0x1d0 drivers/pci/pci-driver.c:512
>>   device_remove+0xcb/0x180 drivers/base/dd.c:616
>>   __device_release_driver drivers/base/dd.c:1349 [inline]
>>   device_release_driver_internal+0x44e/0x620 drivers/base/dd.c:1372
>>   unbind_store+0xf8/0x110 drivers/base/bus.c:244
>>   drv_attr_store+0x74/0xb0 drivers/base/bus.c:125
>>   sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:145
>>   kernfs_fop_write_iter+0x3e0/0x5f0 fs/kernfs/file.c:345
>>   new_sync_write fs/read_write.c:595 [inline]
>>   vfs_write+0x6ac/0x1050 fs/read_write.c:687
>>   ksys_write+0x12a/0x250 fs/read_write.c:739
>>   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>>   do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
>>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
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

Yes, the device's I/O base address and IRQ number are configured by an 
ioctl() for this driver.  (The process doing that needs CAP_SYS_ADMIN 
capability.  There is also precedent for this sort of thing in the 
TIOCSSERIAL ioctl() command for configuring TTY serial ports since the 
early days of the Linux kernel.)

Back in the old days of PCs with ISA buses, you could configure the BIOS 
to reserve specified IRQs so that they would not be assigned to PCI 
devices, so you could use them for ISA devices.

> 
> Though deciphering this comedi code is beyond my skillset.
> 
> I rather go and harden the interrupt core against such bogosities.
> 
> Thanks,
> 
>          tglx
> 
> 
> 

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-

