Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:43561 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750988Ab2FKTdJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 11 Jun 2012 15:33:09 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glp-linux-pci@m.gmane.org>)
	id 1SeAMM-0000WY-74
	for linux-pci@vger.kernel.org; Mon, 11 Jun 2012 21:33:06 +0200
Received: from dsl001-168-162.bos1.dsl.speakeasy.net ([72.1.168.162])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Mon, 11 Jun 2012 21:33:06 +0200
Received: from tkcarr03873 by dsl001-168-162.bos1.dsl.speakeasy.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Mon, 11 Jun 2012 21:33:06 +0200
To: linux-pci@vger.kernel.org
From: Tom Carr <tkcarr03873@gmail.com>
Subject: Re: PCIe rescan not working
Date: Mon, 11 Jun 2012 19:32:56 +0000 (UTC)
Message-ID: <loom.20120611T205954-871@post.gmane.org>
References: <loom.20120607T194858-986@post.gmane.org> <CAE9FiQWau+ko4JiEEjM=2xSH_7FPBr_ZYOm8YGpin2p97=12PQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


> please try:

> echo 1 > /sys/bus/pci/devices/0000:00:01.2/remove

> before

> echo 1 > /sys/bus/pci/rescan

>than should work.

Yinghai, sorry about the direct email on Friday, I tried to reply back to the
newsgroup but the send kept failing. Your suggestion worked but only if there
were no drivers attached to the endpoints. If I load the driver for the endpoint
at bus 6.0 and 9.0, then load the empty FPGA at bus 8.0, which is off of 4.8,
and write 1 to /sys/bus/pci/remove the system crashes. Is there a 
requirement that all down stream devices be removed? I could not find any such
requirement in any documentation. Here is the most of the stack trace.

kernel BUG at /mnt/disk2/home/tcarr/work-ubuntu-12.4-patch/drivers/pci/msi.c
:316!
invalid opcode: 0000 [#1] SMP
Modules linked in: bdsfpga(P) bnep rfcomm bluetooth snd_hda_codec_realtek 
ftdi_sio ppdev snd_hda_intel snd_hda_codec snd_hwdep snd_pcm psmouse serio_raw 
parport_pc snd_seq_midi snd_rawmidi snd_seq_midi_event snd_seq i915 joydev 
snd_timer snd_seq_device mac_hid usbserial drm_kms_helper snd drm mei(C) 
i2c_algo_bit video soundcore snd_page_alloc lp parport usbhid hid e1000e 
floppy

Pid: 74, comm: kworker/u:5 Tainted: P         C O 3.2.0-25-generic-pae #40 To 
be filled by O.E.M. To be filled by O.E.M./To be filled by O.E.M.
EIP: 0060:[<c12e28bc>] EFLAGS: 00010286 CPU: 2
EIP is at free_msi_irqs+0xec/0xf0
EAX: ea9968c0 EBX: ea996dc0 ECX: fffffffa EDX: 00000000
ESI: 00000000 EDI: 00000001 EBP: f6c4bec4 ESP: f6c4beb0
DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
Process kworker/u:5 (pid: 74, ti=f6c4a000 task=f6c58000 task.ti=f6c4a000)
Stack:
 f7777800 f7777dc4 00000000 f7777800 ef71f080 f6c4becc c12e39cd f6c4bedc
 c12cce21 f7764e14 f7776800 f6c4beec c12cce91 f7764e00 f7776800 f6c4befc
 c12ccddf f7764414 f7774000 f6c4bf0c c12cce91 f7764400 f7774000 f6c4bf1c
Call Trace:
 [<c12e39cd>] msi_remove_pci_irq_vectors+0x2d/0x40
 [<c12cce21>] pci_remove_bus_device+0x61/0xa0
 [<c12cce91>] pci_remove_behind_bridge+0x31/0x50
 [<c12ccddf>] pci_remove_bus_device+0x1f/0xa0
 [<c12cce91>] pci_remove_behind_bridge+0x31/0x50
 [<c12ccddf>] pci_remove_bus_device+0x1f/0xa0
 [<c12cce91>] pci_remove_behind_bridge+0x31/0x50
 [<c12ccddf>] pci_remove_bus_device+0x1f/0xa0
 [<c12d30bd>] remove_callback+0x1d/0x30
 [<c11a5ec1>] sysfs_schedule_callback_work+0x11/0x60
 [<c1074d41>] process_one_work+0x101/0x3a0
 [<c11a5eb0>] ? sysfs_schedule_callback+0x1e0/0x1e0
 [<c1075804>] worker_thread+0x124/0x2d0
 [<c10756e0>] ? manage_workers.isra.27+0x110/0x110
 [<c107962d>] kthread+0x6d/0x80
 [<c10795c0>] ? flush_kthread_worker+0x80/0x80
 [<c15b087e>] kernel_thread_helper+0x6/0x10

If you want to see the whole stack trace, can you tell me what the format of
the return email should be so I can send an attachement.




