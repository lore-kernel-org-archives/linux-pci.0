Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50729 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755310AbbFCNz3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 3 Jun 2015 09:55:29 -0400
Message-ID: <1433339727.3510.23.camel@redhat.com>
Subject: Re: lenovo T530+Nvida GTX 660 TI eGPU via PE4H
From: Alex Williamson <alex.williamson@redhat.com>
To: Joachim Schiele <js@lastlog.de>
Cc: linux-pci@vger.kernel.org
Date: Wed, 03 Jun 2015 07:55:27 -0600
In-Reply-To: <mkn0aa$ph8$1@ger.gmane.org>
References: <mebuq3$mqo$1@ger.gmane.org>
		 <CAErSpo4AS0LRas_nYsp3ZL=4wx=Avtq_mX_W_ZcEMUf2hkDm6Q@mail.gmail.com>
		 <mecob7$pof$1@ger.gmane.org> <mjqftk$jp4$1@ger.gmane.org>
	 <1432787230.5794.9.camel@redhat.com> <mkn0aa$ph8$1@ger.gmane.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2015-06-03 at 15:43 +0200, Joachim Schiele wrote:
> On 28.05.2015 06:27, Alex Williamson wrote:
> > On Sat, 2015-05-23 at 20:12 +0200, Joachim Schiele wrote:
> >> just wanted to report that i got the external graphics card to work with
> >> native windows 7 and setup 1.x + pci compaction!
> >>
> >> see:
> >>   http://blog.lastlog.de/posts/setup-1.x/
> >>
> >> i hope to get it also working in linux host using kvm+win7 as guest soon.
> > 
> > I just setup something similar, using the EXP GDC "Beast" rather than
> > the PE4H.  My Lenovo T530 only leaves 390MB for MMIO space and doesn't
> > provide any 64bit space via ACPI.  I also need to fiddle with the
> > switches to delay the card so the laptop doesn't hang during BIOS boot.
> 
> are you using the 'nvidia gtx 660 ti' or 'nvidia gtx 660' or something else?
> 
> what i'm curious about is why i get the 'nvidia gtx 660' working but not
> the 'nvidia gtx 660 ti'. both have 2gb of ram.
> 
> maybe there is some white/blacklisting of pcie IDs in the kernel
> somewhere and the 'nvidia gtx 660 ti' didn't make it there yet?
> 
> all i get to see is stuff like:
> 
> (quote from an earlier attempt to get the 'nvidia gtx 660 ti' to work):
> [  966.575224] vgaarb: device added:
> PCI:0000:04:00.0,decodes=io+mem,owns=none,locks=none
> [  966.575227] vgaarb: device changed decodes:
> PCI:0000:00:02.0,olddecodes=io+mem,decodes=none:owns=none
> [  966.575327] pci 0000:04:00.1: [10de:0e0a] type 00 class 0x040300
> [  966.575356] pci 0000:04:00.1: reg 0x10: [mem 0x00000000-0x00003fff]
> [  966.998345] pci 0000:04:00.0: BAR 1: no space for [mem size
> 0x08000000 64bit pref]
> [  966.998350] pci 0000:04:00.0: BAR 1: failed to assign [mem size
> 0x08000000 64bit pref]
> [  966.998353] pci 0000:04:00.0: BAR 3: no space for [mem size
> 0x02000000 64bit pref]
> [  966.998355] pci 0000:04:00.0: BAR 3: failed to assign [mem size
> 0x02000000 64bit pref]
> [  966.998357] pci 0000:04:00.0: BAR 0: no space for [mem size 0x01000000]
> [  966.998358] pci 0000:04:00.0: BAR 0: failed to assign [mem size
> 0x01000000]
> [  966.998360] pci 0000:04:00.0: BAR 6: assigned [mem
> 0xf1400000-0xf147ffff pref]
> [  966.998363] pci 0000:04:00.1: BAR 0: assigned [mem 0xf1480000-0xf1483fff]
> [  966.998369] pci 0000:04:00.1: BAR 0: error updating (0xf1480000 !=
> 0xffffffff)
> [  966.998373] pci 0000:04:00.0: BAR 5: assigned [io  0x3000-0x307f]
> [  966.998379] pci 0000:04:00.0: BAR 5: error updating (0x003001 !=
> 0xffffffff)
> 
> 
> > I pass pci=nocrs,realloc on the kernel commandline in order to get the
> > GPU programmed.  I've only actually tested it with KVM/VFIO GPU
> > assignment and it seems to work well, or at least as well as can be
> > expected over a x1 5GT/s link.  Thanks,
> 
> i've been playing with pci=nocrs,realloc a lot lately but that didn't
> make it work.

You need to boot with the card attached, perhaps even stalling at the
grub boot loader to make sure you've passed the delay configured by the
onboard switches that hide the card past bios boot.  Your dmesg
timestamps above seem to imply you're trying to hot-plug the card later,
but there's not sufficient space for it.

I tested with a lowly GT 635, but I guarantee there are no
white/blacklist in the kernel for basic resource assignment of devices.
Thanks,

Alex

> >> On 18.03.2015 21:48, Joachim Schiele wrote:
> >>> hi,
> >>>
> >>> i've run with pci=realloc two tests, the results are here (also the
> >>> dmesg) outputs:
> >>>
> >>> https://lastlog.de/wiki/index.php/T530%2BNvida_GTX_660_TI_eGPU_via_PE4H#debugging_using_pci.3Drealloc
> >>>
> >>> thanks in advance,
> >>> joachim schiele
> >>>
> >>>
> >>> On 18.03.2015 18:06, Bjorn Helgaas wrote:
> >>>> [+cc Alex]
> >>>>
> >>>> Hi Joachim,
> >>>>
> >>>> Thanks a lot for the bug report.
> >>>>
> >>>> On Wed, Mar 18, 2015 at 8:32 AM, Joachim Schiele <js@lastlog.de> wrote:
> >>>>> hi,
> >>>>>
> >>>>> === question ===
> >>>>> with the setup described below, i can't pass the graphics adapter into a
> >>>>> KVM guest as described below.
> >>>>>
> >>>>> is the BAR stuff in the listing an error i wuld have to fix in order to
> >>>>> get my eGPU running? if so, what could i do about it
> >>>>
> >>>> Yes.  If we can't assign resources to the BARs, we can't enable the
> >>>> device.  If you boot with "pci=realloc", Linux will try harder to
> >>>> assign space (including moving other devices to make space if
> >>>> necessary).
> >>>>
> >>>>> i've seen that the
> >>>>> laptop will hang on boot if the eGPU is powered on system startup.
> >>>>
> >>>> It's possible the BIOS is hanging because it tried to assign space for
> >>>> the eGPU but failed.
> >>>>
> >>>>> i can
> >>>>> see the adapter after hotplugging it using lspci and i never see an
> >>>>> image on the external display.
> >>>>
> >>>> The device will appear in lspci even if we can't assign space for it.
> >>>> In that case the device would not work, even though it appears in
> >>>> lspci.
> >>>>
> >>>> So please try "pci=realloc".  Also, please collect a complete dmesg
> >>>> log and "lspci -vv" output (with eGPU attached).  That will contain
> >>>> the information needed to see whether it's possible even in principle
> >>>> to make this work.
> >>>>
> >>>>> my config is this:
> >>>>> sudo qemu-system-x86_64 -enable-kvm \
> >>>>> -m 8192 \
> >>>>> -M q35 \
> >>>>> -cpu host,kvm=off \
> >>>>> -smp 4,sockets=1,cores=4,threads=1 \
> >>>>> -vga none \
> >>>>> -vnc none \
> >>>>> -device
> >>>>> ioh3420,bus=pcie.0,addr=1c.0,multifunction=on,port=1,chassis=1,id=root.1 \
> >>>>> -device
> >>>>> vfio-pci,host=04:00.0,bus=root.1,addr=00.0,multifunction=on,x-vga=on \
> >>>>> -device vfio-pci,host=04:00.1,bus=root.1,addr=00.1 \
> >>>>> -drive
> >>>>> file=/home/joachim/en_windows_7_professional_x64_dvd_X15-65805.iso,id=isocd
> >>>>> -device ide-cd,bus=ide.1,drive=isocd \
> >>>>> -drive file=/var/lib/libvirt/images/win7.qcow2,format=qcow2,id=hdd
> >>>>> -device ide-hd,bus=ide.0,drive=hdd \
> >>>>> -bios /usr/share/seabios/bios.bin \
> >>>>> -soundhw ac97
> >>>>>
> >>>>> === when hotplugging the eGPU ===
> >>>>> i want to use a Nvidia GTX 660 TI as an eGPU using PE4H and when i
> >>>>> hotplug the ePCI adapter i get this log on a 3.18 ubuntu kernel:
> >>>>>
> >>>>> [  960.145002] vgaarb: device changed decodes:
> >>>>> PCI:0000:00:02.0,olddecodes=none,decodes=io+mem:owns=none
> >>>>> [  966.574858] pci 0000:04:00.0: [10de:1183] type 00 class 0x030000
> >>>>> [  966.574892] pci 0000:04:00.0: reg 0x10: [mem 0x00000000-0x00ffffff]
> >>>>> [  966.574921] pci 0000:04:00.0: reg 0x14: [mem 0x00000000-0x07ffffff
> >>>>> 64bit pref]
> >>>>> [  966.574950] pci 0000:04:00.0: reg 0x1c: [mem 0x00000000-0x01ffffff
> >>>>> 64bit pref]
> >>>>> [  966.574963] pci 0000:04:00.0: reg 0x24: [io  0x0000-0x007f]
> >>>>> [  966.574974] pci 0000:04:00.0: reg 0x30: [mem 0x00000000-0x0007ffff pref]
> >>>>> [  966.575224] vgaarb: device added:
> >>>>> PCI:0000:04:00.0,decodes=io+mem,owns=none,locks=none
> >>>>> [  966.575227] vgaarb: device changed decodes:
> >>>>> PCI:0000:00:02.0,olddecodes=io+mem,decodes=none:owns=none
> >>>>> [  966.575327] pci 0000:04:00.1: [10de:0e0a] type 00 class 0x040300
> >>>>> [  966.575356] pci 0000:04:00.1: reg 0x10: [mem 0x00000000-0x00003fff]
> >>>>> [  966.998345] pci 0000:04:00.0: BAR 1: no space for [mem size
> >>>>> 0x08000000 64bit pref]
> >>>>> [  966.998350] pci 0000:04:00.0: BAR 1: failed to assign [mem size
> >>>>> 0x08000000 64bit pref]
> >>>>> [  966.998353] pci 0000:04:00.0: BAR 3: no space for [mem size
> >>>>> 0x02000000 64bit pref]
> >>>>> [  966.998355] pci 0000:04:00.0: BAR 3: failed to assign [mem size
> >>>>> 0x02000000 64bit pref]
> >>>>> [  966.998357] pci 0000:04:00.0: BAR 0: no space for [mem size 0x01000000]
> >>>>> [  966.998358] pci 0000:04:00.0: BAR 0: failed to assign [mem size
> >>>>> 0x01000000]
> >>>>> [  966.998360] pci 0000:04:00.0: BAR 6: assigned [mem
> >>>>> 0xf1400000-0xf147ffff pref]
> >>>>> [  966.998363] pci 0000:04:00.1: BAR 0: assigned [mem 0xf1480000-0xf1483fff]
> >>>>> [  966.998369] pci 0000:04:00.1: BAR 0: error updating (0xf1480000 !=
> >>>>> 0xffffffff)
> >>>>> [  966.998373] pci 0000:04:00.0: BAR 5: assigned [io  0x3000-0x307f]
> >>>>> [  966.998379] pci 0000:04:00.0: BAR 5: error updating (0x003001 !=
> >>>>> 0xffffffff)
> >>>>> [  966.998392] pcieport 0000:00:1c.2: Max Payload Size set to  128/ 128
> >>>>> (was  128), Max Read Rq  128
> >>>>> [  966.998403] pci 0000:04:00.0: Max Payload Size set to 16384/ 256 (was
> >>>>> 16384), Max Read Rq 16384
> >>>>> [  966.998414] pci 0000:04:00.1: Max Payload Size set to 16384/ 256 (was
> >>>>> 16384), Max Read Rq 16384
> >>>>> [  966.998472] pci-stub 0000:04:00.0: claimed by stub
> >>>>> [  966.998495] pci-stub 0000:04:00.1: claimed by stub
> >>>>> [  967.099040] pcieport 0000:00:1c.2: Max Payload Size set to  128/ 128
> >>>>> (was  128), Max Read Rq  128
> >>>>> [  967.099059] pci-stub 0000:04:00.0: Max Payload Size set to  128/ 256
> >>>>> (was  128), Max Read Rq  512
> >>>>> [  967.099075] pci-stub 0000:04:00.1: Max Payload Size set to  128/ 256
> >>>>> (was  128), Max Read Rq  512
> >>>>> [ 7735.938854] vgaarb: device changed decodes:
> >>>>> PCI:0000:00:02.0,olddecodes=none,decodes=io+mem:owns=none
> >>>>>
> >>>>>
> >>>>>
> >>>>>
> >>>>> more at:
> >>>>>
> >>>>> https://lastlog.de/wiki/index.php/T530%2BNvida_GTX_660_TI_eGPU_via_PE4H
> >>>>>
> >>>>> i derived the scripts i'm using from this guide:
> >>>>> http://www.pugetsystems.com/labs/articles/Multiheaded-NVIDIA-Gaming-using-Ubuntu-14-04-KVM-585/
> >>>>>
> >>>>> --
> >>>>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> >>>>> the body of a message to majordomo@vger.kernel.org
> >>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>>
> >>>
> >>
> >>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> > 
> > 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



