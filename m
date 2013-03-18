Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:7658 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754236Ab3CRRCB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 18 Mar 2013 13:02:01 -0400
Date: Mon, 18 Mar 2013 10:01:59 -0700
From: Sarah Sharp <sarah.a.sharp@linux.intel.com>
To: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
Cc: USB list <linux-usb@vger.kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Lan Tianyu <tianyu.lan@intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: 3.8.2: xhci port is dead until pcieport PME# goes to disabled
Message-ID: <20130318170159.GF17414@xanatos>
References: <5142094D.2070305@fold.natur.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5142094D.2070305@fold.natur.cuni.cz>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Martin,

I'm really having trouble following you here.  Please don't try to tell
me what you think the root cause of the issue is.  Just tell me exactly
(in a paragraph or less) what your symptoms are.

Sending lots of log files and lsusb output at me isn't helpful if I
don't know what your issue is.

Sarah Sharp

On Thu, Mar 14, 2013 at 06:30:53PM +0100, Martin Mokrejs wrote:
> [resend, no dmesg attached]
> 
> Hi,
>   happened to me again that I plugged in some devcie into my USB3 socket
> in my laptop (usually use an external HUB). Don't believe this is a new
> issue as a whole, I am facing this time to time since 3.3 time when I bought
> the laptop. 
>   But now, I realized the first device works but subsequently plugged in
> devices do not show up until until I run 'lsusb -vv'. Simple 'lsusb -v'
> or 'lsusb -t' is not enough. The port starts to work after dmesg logs:
> 
> 
> [ 1445.597641] pcieport 0000:00:1c.4: PME# disabled
> [ 1445.617667] xhci_hcd 0000:0b:00.0: PME# disabled
> 
> I believe lsusb -vv while querying for the detailed device info triggers
> a fix.
> 
> Funny, but maybe this will help us to understand why my express card slot
> somehow relates to the USB3 proivided by the TexasInstruments chip. This
> is a SandyBridge-based Dell Vostro 3550 laptop. I should add that on the usb
> mailing list about a year ago some TexasInstruments developer published that
> they had a hardware bug in a "USB redriver", and as my laptop was made in
> fall 2011 I am likely having having the buggy HW. If I remember right, the
> report was about the problem that once you pluging a USB2 device into the XHCI
> slot, subsequently plugged in USB3 devices won't negotiate at SuperSpeed until
> you power off computer. So, I think I face a different issue but had to mention
> this.
> 
> I use pcie_aspm=off on my kernel command line. I tried to catch some usb traffic
> on the dead port but the file from usbmon is really empty until I do the
> 'lsusb -vv'. I tried to turn off the usb powersaving at runtime but I do not
> have the file to do:
> 
> # echo -n -1 > /sys/bus/usb/devices/3-0\:1.0/power/autosuspend
> 
> :(
> 
> # ls -la /sys/bus/usb/devices/3-0\:1.0/power/
> total 0
> drwxr-xr-x 2 root root    0 Mar 14 13:11 .
> drwxr-xr-x 6 root root    0 Mar 14 13:58 ..
> -rw-r--r-- 1 root root 4096 Mar 14 13:11 async
> -r--r--r-- 1 root root 4096 Mar 14 13:11 runtime_active_kids
> -r--r--r-- 1 root root 4096 Mar 14 13:11 runtime_enabled
> -r--r--r-- 1 root root 4096 Mar 14 13:11 runtime_status
> -r--r--r-- 1 root root 4096 Mar 14 13:11 runtime_usage
> #
> 
> I feel related could be patches under thread: "usb: add usb port auto power off mechanism"
> 
> 
> Below is a dmesg since a cold boot. I plugged in a mouse into the USB3 socket.
> 
> [   91.463285] xhci_hcd 0000:0b:00.0: hcd_pci_runtime_suspend: 0
> [   91.463377] xhci_hcd 0000:0b:00.0: PME# enabled
> [  447.389700] xhci_hcd 0000:0b:00.0: PME# disabled
> [  447.389711] xhci_hcd 0000:0b:00.0: enabling bus mastering
> [  447.389787] xhci_hcd 0000:0b:00.0: hcd_pci_runtime_resume: 0
> [  447.389819] usb usb3: usb wakeup-resume
> 
> Was detected. Unplugged the mouse. 
> 
> [  459.600056] usb 3-2: USB disconnect, device number 2
> [  459.600058] usb 3-2: unregistering device
> [  459.600059] usb 3-2: unregistering interface 3-2:1.0
> [  459.600622] xhci_hcd 0000:0b:00.0: shutdown urb ffff88040a641870 ep1in-intr
> [  459.702564] usb 3-2: usb_disable_device nuking all URBs
> [  459.707948] usb 3-2: Successful Endpoint Configure command
> [  459.860892] hub 3-0:1.0: debounce: port 2: total 100ms stable 100ms status 0x100
> [  459.860910] hub 3-0:1.0: hub_suspend
> [  459.860917] usb usb3: bus auto-suspend, wakeup 1
> [  459.860981] xhci_hcd 0000:0b:00.0: hcd_pci_runtime_suspend: 0
> [  459.861070] xhci_hcd 0000:0b:00.0: PME# enabled
> 
> Then I put the mouse back, I think it was not detected after until I did the lsusb
> trick. I am not sure, sorry, but is not that important. I was repeating test once
> again and just forgot now this detail. So below just that the mouse got detected,
> either thanks to lsusb -vv or not.
> 
> [  536.745422] xhci_hcd 0000:0b:00.0: PME# disabled
> [  536.745435] xhci_hcd 0000:0b:00.0: enabling bus mastering
> [  536.745487] xhci_hcd 0000:0b:00.0: hcd_pci_runtime_resume: 0
> [  536.745493] usb usb3: usb auto-resume
> [  536.745509] hub 3-0:1.0: hub_resume
> [  536.745579] hub 3-0:1.0: port 2: status 0301 change 0001
> 
> Then a mouse disconnect:
> 
> [  652.232958] usb 3-2: USB disconnect, device number 3
> [  652.232960] usb 3-2: unregistering device
> [  652.232961] usb 3-2: unregistering interface 3-2:1.0
> [  652.233148] xhci_hcd 0000:0b:00.0: shutdown urb ffff88040b1ee288 ep1in-intr
> [  652.333325] usb 3-2: usb_disable_device nuking all URBs
> [  652.337096] usb 3-2: Successful Endpoint Configure command
> [  652.492164] hub 3-0:1.0: debounce: port 2: total 100ms stable 100ms status 0x100
> [  652.492183] hub 3-0:1.0: hub_suspend
> [  652.492190] usb usb3: bus auto-suspend, wakeup 1
> [  652.492254] xhci_hcd 0000:0b:00.0: hcd_pci_runtime_suspend: 0
> [  652.492341] xhci_hcd 0000:0b:00.0: PME# enabled
> [  652.522157] pcieport 0000:00:1c.4: PME# enabled
> 
> [  688.128198] kmemleak: 1 new suspected memory leaks (see /sys/kernel/debug/kmemleak)
> 
> Note above two things pcieport started to mess in. I you look what xhci_hcd printed
> in previous attempts the was NO pcieport involved around, at all. Now, provided
> that I reported the kmemleak multiple times this year:
> 
> unreferenced object 0xffff88040b4a0690 (size 256):
>   comm "swapper/0", pid 1, jiffies 4294937581 (age 17428.760s)
>   hex dump (first 32 bytes):
>     00 00 00 00 ad 4e ad de ff ff ff ff 00 00 00 00  .....N..........
>     ff ff ff ff ff ff ff ff d8 9f 57 82 ff ff ff ff  ..........W.....
>   backtrace:
>     [<ffffffff815fcec7>] kmemleak_alloc+0x21/0x3e
>     [<ffffffff81117ac4>] slab_post_alloc_hook+0x28/0x2a
>     [<ffffffff8111a18f>] __kmalloc+0xf3/0x105
>     [<ffffffff8132b20c>] kzalloc.constprop.14+0xe/0x10
>     [<ffffffff8132b66d>] device_private_init+0x14/0x63
>     [<ffffffff8132d790>] dev_set_drvdata+0x19/0x2f
>     [<ffffffff813f19d1>] i801_probe+0x5e/0x41a
>     [<ffffffff812924d8>] local_pci_probe+0x39/0x61
>     [<ffffffff812936fb>] pci_device_probe+0xc6/0xf3
>     [<ffffffff8132dd59>] driver_probe_device+0xa9/0x1c1
>     [<ffffffff8132decb>] __driver_attach+0x5a/0x7e
>     [<ffffffff8132c5f3>] bus_for_each_dev+0x5c/0x88
>     [<ffffffff8132d8f6>] driver_attach+0x19/0x1b
>     [<ffffffff8132d4c6>] bus_add_driver+0xa8/0x1fa
>     [<ffffffff8132e33d>] driver_register+0x8c/0x106
>     [<ffffffff812932f6>] __pci_register_driver+0x5c/0x60
> 
> I believe this is related to the issue, somehow.
> 
> Now I started usbmon, so lets follow another attempt to repeat the bug. For clarity,
> I will plug into the socket a kayboard, and it won't work until I do 'lsusb -vv'.
> I pressed then space on the keyboard and that worked immediately (keyboard was dead
> until lsusb -vv and also dmesg did not log anything).
> 
> So, lsusb -vv:
> 
> [  802.986036] pcieport 0000:00:1c.4: PME# disabled
> [  803.016008] xhci_hcd 0000:0b:00.0: PME# disabled
> [  803.016021] xhci_hcd 0000:0b:00.0: enabling bus mastering
> [  803.016078] xhci_hcd 0000:0b:00.0: hcd_pci_runtime_resume: 0
> [  803.016085] usb usb3: usb auto-resume
> [  803.016103] hub 3-0:1.0: hub_resume
> [  803.016172] hub 3-0:1.0: port 2: status 0301 change 0001
> 
> unplug of the keyboard:
> 
> [  821.621331] usb usb4: usb auto-resume
> [  821.621347] hub 4-0:1.0: hub_resume
> [  821.621405] hub 4-0:1.0: state 7 ports 2 chg 0000 evt 0000
> [  821.622047] hub 4-0:1.0: hub_suspend
> [  821.622053] usb usb4: bus auto-suspend, wakeup 1
> [  967.433533] hub 3-0:1.0: state 7 ports 2 chg 0000 evt 0004
> [  967.433768] hub 3-0:1.0: port 2, status 0100, change 0001, 12 Mb/s
> [  967.433771] usb 3-2: USB disconnect, device number 4
> [  967.433772] usb 3-2: unregistering device
> [  967.433775] usb 3-2: unregistering interface 3-2:1.0
> [  967.433946] xhci_hcd 0000:0b:00.0: shutdown urb ffff88040a641948 ep1in-intr
> [  967.579130] usb 3-2: usb_disable_device nuking all URBs
> [  967.584494] usb 3-2: Successful Endpoint Configure command
> [  967.798027] hub 3-0:1.0: debounce: port 2: total 100ms stable 100ms status 0x100
> [  967.798046] hub 3-0:1.0: hub_suspend
> [  967.798075] usb usb3: bus auto-suspend, wakeup 1
> [  967.798155] xhci_hcd 0000:0b:00.0: hcd_pci_runtime_suspend: 0
> [  967.798242] xhci_hcd 0000:0b:00.0: PME# enabled
> [  967.828015] pcieport 0000:00:1c.4: PME# enabled
> 
> 
> You see? pcieport is messing with
> 00:1c.4 PCI bridge: Intel Corporation 6 Series/C200 Series Chipset Family PCI Express Root Port 5 (rev b5) (prog-if 00 [Normal decode])
> 
> I unplugged and replugged the keyboard multiple times and it did not work, so
> I connected the mouse used in the very beginning right after cold boot, still
> not working. But these were likely logged due to that.
> 
> [ 1063.263014] pcieport 0000:00:1c.4: PME# disabled
> [ 1063.272918] pcieport 0000:00:1c.4: PME# enabled
> [ 1063.312915] pcieport 0000:00:1c.4: PME# disabled
> [ 1063.322906] pcieport 0000:00:1c.4: PME# enabled
> [ 1070.132666] pcieport 0000:00:1c.4: PME# disabled
> [ 1070.142559] pcieport 0000:00:1c.4: PME# enabled
> [ 1070.182601] pcieport 0000:00:1c.4: PME# disabled
> [ 1070.192644] pcieport 0000:00:1c.4: PME# enabled
> 
>  After doing 'lsusb -vv' I rescued the USB3 socket and it detected the mouse.
> 
> [ 1108.504953] pcieport 0000:00:1c.4: PME# disabled
> [ 1108.525010] xhci_hcd 0000:0b:00.0: PME# disabled
> [ 1108.525023] xhci_hcd 0000:0b:00.0: enabling bus mastering
> [ 1108.525069] xhci_hcd 0000:0b:00.0: hcd_pci_runtime_resume: 0
> [ 1108.525075] usb usb3: usb auto-resume
> [ 1108.525094] hub 3-0:1.0: hub_resume
> [ 1108.525196] hub 3-0:1.0: port 2: status 0301 change 0001
> 
> I unplugged the mouse:
> 
> [ 1230.618019] usb 3-2: unregistering device
> [ 1230.618020] usb 3-2: unregistering interface 3-2:1.0
> [ 1230.618188] xhci_hcd 0000:0b:00.0: shutdown urb ffff88040b1ee288 ep1in-intr
> [ 1230.711764] usb 3-2: usb_disable_device nuking all URBs
> [ 1230.715101] usb 3-2: Successful Endpoint Configure command
> [ 1230.870763] hub 3-0:1.0: debounce: port 2: total 100ms stable 100ms status 0x100
> [ 1230.870782] hub 3-0:1.0: hub_suspend
> [ 1230.870797] usb usb3: bus auto-suspend, wakeup 1
> [ 1230.870862] xhci_hcd 0000:0b:00.0: hcd_pci_runtime_suspend: 0
> [ 1230.870950] xhci_hcd 0000:0b:00.0: PME# enabled
> [ 1230.900730] pcieport 0000:00:1c.4: PME# enabled
> 
> 
> In summary, note that *immediately before the line* "xhci_hcd 0000:0b:00.0: PME# disabled"
> must appear "pcieport 0000:00:1c.4: PME# disabled". Don't know who is the blocker.
> But in reverse order the PME# are being enabled after a device is unplugged from the USB3
> socket.
> 
> During the tests I had an eSATA in the express card slot since cold boot but don't think
> it is relevant here. The express slot is 01.c7 device and the card would be 11.0.
> 
> 
> 
> 
> I will send to Alan and Sarah two files directly (thank you for their inspection): ;)
> 
> The first part of testing is in usbmon_0u.bin (repeatedly connecting a mouse).
> 
> The latter in usbmon_0u_mouse_unplug_keyboard_insert.bin. Both files should demonstrate
> the same issue although in the latter file it might be easier to see because the keyboard
> was plugged in after a mouse and was not detected until 'lsusb -vv'.
> 
> 
> 
> 
> 
> Below is when a keyboard is connected to the dead USB3 socket:
> 
> # diff -u -w lspci_vvvxxx_mouse_unplugged.txt lspci_vvvxxx_mouse_unplugged_keyboard_inserted.txt
> --- lspci_vvvxxx_mouse_unplugged.txt    2013-03-14 12:22:34.000000000 +0100
> +++ lspci_vvvxxx_mouse_unplugged_keyboard_inserted.txt  2013-03-14 12:25:06.000000000 +0100
> @@ -747,7 +747,7 @@
>         Region 2: Memory at f7d10000 (64-bit, non-prefetchable) [size=8K]
>         Capabilities: [40] Power Management version 3
>                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=100mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
> -               Status: D3 NoSoftRst+ PME-Enable+ DSel=0 DScale=0 PME-
> +               Status: D3 NoSoftRst+ PME-Enable+ DSel=0 DScale=0 PME+
>         Capabilities: [48] MSI: Enable- Count=1/8 Maskable- 64bit+
>                 Address: 0000000000000000  Data: 0000
>         Capabilities: [70] Express (v2) Endpoint, MSI 00
> @@ -785,7 +785,7 @@
>  10: 04 00 d0 f7 00 00 00 00 04 00 d1 f7 00 00 00 00
>  20: 00 00 00 00 00 00 00 00 00 00 00 00 28 10 b3 04
>  30: 00 00 00 00 40 00 00 00 00 00 00 00 0b 01 00 00
> -40: 01 48 83 fe 0b 01 00 00 05 70 86 00 00 00 00 00
> +40: 01 48 83 fe 0b 81 00 00 05 70 86 00 00 00 00 00
>  50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  60: 30 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  70: 10 c0 02 00 c3 8f 90 05 00 20 19 00 12 3c 07 00
> 
> 
> Now, when the port is rescued by lsusb -vv, the following can be seen:
> 
> # diff -u -w lspci_vv_mouse_unplugged_keyboard_inserted.txt lspci_vv_mouse_unplugged_keyboard_inserted_kb_alive.txt
> --- lspci_vv_mouse_unplugged_keyboard_inserted.txt      2013-03-14 12:25:13.000000000 +0100
> +++ lspci_vv_mouse_unplugged_keyboard_inserted_kb_alive.txt     2013-03-14 12:26:42.000000000 +0100
> @@ -276,7 +276,7 @@
>         Capabilities: [90] Subsystem: Dell Device 04b3
>         Capabilities: [a0] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
> -               Status: D3 NoSoftRst- PME-Enable+ DSel=0 DScale=0 PME-
> +               Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>         Kernel driver in use: pcieport
>  
>  00:1c.7 PCI bridge: Intel Corporation 6 Series/C200 Series Chipset Family PCI Express Root Port 8 (rev b5) (prog-if 00 [Normal decode])
> @@ -476,14 +476,15 @@
>  
>  0b:00.0 USB controller: Texas Instruments TUSB73x0 SuperSpeed USB 3.0 xHCI Host Controller (rev 02) (prog-if 30 [XHCI])
>         Subsystem: Dell Device 04b3
> -       Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
> +       Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> +       Latency: 0, Cache Line Size: 64 bytes
>         Interrupt: pin A routed to IRQ 16
>         Region 0: Memory at f7d00000 (64-bit, non-prefetchable) [size=64K]
>         Region 2: Memory at f7d10000 (64-bit, non-prefetchable) [size=8K]
>         Capabilities: [40] Power Management version 3
>                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=100mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
> -               Status: D3 NoSoftRst+ PME-Enable+ DSel=0 DScale=0 PME+
> +               Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>         Capabilities: [48] MSI: Enable- Count=1/8 Maskable- 64bit+
>                 Address: 0000000000000000  Data: 0000
>         Capabilities: [70] Express (v2) Endpoint, MSI 00
> #
> 
> 
> 
> The difference in lsusb output is probably useless as it just shows that once the socket
> was working the keyboard was picked up by a driver. Looks like yet another PCI issue.
> At least no diffs in iomem. ;)
> 
> 
> Thanks,
> Martin
> 
