Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fold.natur.cuni.cz ([195.113.57.32]:41172 "HELO
	fold.natur.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753012Ab3CKPsn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 11 Mar 2013 11:48:43 -0400
Message-ID: <513DFCD4.2070309@fold.natur.cuni.cz>
Date: Mon, 11 Mar 2013 16:48:36 +0100
From: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
MIME-Version: 1.0
To: Alan Stern <stern@rowland.harvard.edu>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Sarah Sharp <sarah.a.sharp@linux.intel.com>
Subject: Re: 3.8.2: stale pci device info for a previously inserted express
 card
References: <Pine.LNX.4.44L0.1303111111220.2246-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1303111111220.2246-100000@iolanthe.rowland.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Alan,

Alan Stern wrote:
> On Mon, 11 Mar 2013, Martin Mokrejs wrote:
> 
>> Hi,
>>   I use for my daily work acpiphp to manage express cards in Dell Vostro 3550.
>> I have never seen something like this before and believe this is some new regression
>> in 3.8 series. I had in the a USB3 card and ejected it. Then I inserted a
>> SATA Sil3132 card but it is not detected and dmesg still ends with last lines
>> added when the USB card was being removed. The funny thing is that lspci reports
>> a mixture of USB-card properties with NEC chips along with Silicon Image eSATA card.
> 
> ...
> 
> When did you run this lspci command?  After inserting the SATA card?

Yes, because I did not see anything new the eSATA being picked up in dmesg.

> 
> Did you check to see if there were any hung processes?

I did not reboot yet. What commands?

> 
>>   I think as a guide you can take the kmemleak report showing that USB did not
>> release its resources completely? Did I screw something with having USB HID generic
>> driver?
> 
> Is this repeatable?  It would be more meaningful to see a kmemleak

No idea, saw it for the first time. Nobody ever told me whether kmemleak is
able to report the leak immediately or whether that is some background process
which is always lagging, by definition. If the latter is true, it could be
I have meanwhile done something else (popped in or out another card). Until
I know what to expect I am just lost with what I see logged.

> report for immediately after the USB-3 card is removed.  The leak may
> be related to these two lines in the log (they occurred only once):
> 
> [ 8768.825242] xhci_hcd 0000:11:00.0: Abort command ring failed
> [ 8768.825244] xhci_hcd 0000:11:00.0: HC died; cleaning up
> 
> Perhaps cleaning up after a dead controller doesn't deallocate all that
> it should.  Quite possibly this is connected with the fact that on this
> attempt, you removed the USB-3 card while the WD disk drive was plugged
> into it.

I am not that skilled but I believe somebody could help me to provide you
with the current time value in the epoch way to translate two lines
  comm "kworker/0:1", pid 675, jiffies 4295795189 (age 58365.960s)
  comm "kworker/0:1", pid 675, jiffies 4295809367 (age 58224.180s)
into human date. Same for the timestamps in dmesg output.

Well, from the

[ 8770.143509] usb usb6: bus auto-suspend, wakeup 1
[ 8770.243135] hub 5-0:1.0: state 7 ports 2 chg 0002 evt 0000
[ 8770.243168] hub 5-0:1.0: port 1, status 0101, change 0000, 12 Mb/s
[ 8770.362933] usb 5-1: new high-speed USB device number 2 using xhci_hcd
[ 8770.385501] usb 5-1: skipped 1 descriptor after interface
[ 8770.386048] usb 5-1: default language 0x0409
[ 8770.387954] usb 5-1: udev 2, busnum 5, minor = 513
[ 8770.387956] usb 5-1: New USB device found, idVendor=13fd, idProduct=0550
[ 8770.387958] usb 5-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[ 8770.387959] usb 5-1: Product: WD3200BEVE-00A0H
[ 8770.387960] usb 5-1: Manufacturer: Initio  
[ 8770.387961] usb 5-1: SerialNumber: 00101005500011B80
[ 8770.388445] usb 5-1: usb_probe_device
[ 8770.388447] usb 5-1: configuration #1 chosen from 1 choice
[ 8770.388906] usb 5-1: Successful Endpoint Configure command
[ 8770.389186] usb 5-1: adding 5-1:1.0 (config #1, interface 0)
[ 8770.389442] usb-storage 5-1:1.0: usb_probe_interface
[ 8770.389445] usb-storage 5-1:1.0: usb_probe_interface - got id
[ 8770.389627] scsi7 : usb-storage 5-1:1.0
[ 8770.390563] usb 5-1: adding 5-1:1.1 (config #1, interface 1)
[ 8770.390783] usbhid 5-1:1.1: usb_probe_interface
[ 8770.390784] usbhid 5-1:1.1: usb_probe_interface - got id
[ 8770.393386] usbhid 5-1:1.1: looking for a minor, starting at 0
[ 8770.394586] hid-generic 0003:13FD:0550.0004: hiddev0,hidraw2: USB HID v1.10 Device [Initio   WD3200BEVE-00A0H] on usb-0000:11:00.0-1/input1
[ 8771.382843] scsi 7:0:0:0: Direct-Access     Initio   WD3200BEVE-00A0H 3.12 PQ: 0 ANSI: 0
[ 8771.384510] sd 7:0:0:0: Attached scsi generic sg2 type 0
[ 8771.385463] sd 7:0:0:0: [sdb] 625142448 512-byte logical blocks: (320 GB/298 GiB)
[ 8771.386350] sd 7:0:0:0: [sdb] Write Protect is off
[ 8771.386353] sd 7:0:0:0: [sdb] Mode Sense: 86 0b 00 02
[ 8771.387198] sd 7:0:0:0: [sdb] No Caching mode page present
[ 8771.387200] sd 7:0:0:0: [sdb] Assuming drive cache: write through
[ 8771.392420] sd 7:0:0:0: [sdb] No Caching mode page present
[ 8771.392423] sd 7:0:0:0: [sdb] Assuming drive cache: write through
[ 8771.405239]  sdb: sdb1
[ 8771.411001] sd 7:0:0:0: [sdb] No Caching mode page present
[ 8771.411002] sd 7:0:0:0: [sdb] Assuming drive cache: write through
[ 8771.411006] sd 7:0:0:0: [sdb] Attached SCSI disk
[ 9893.877224] kmemleak: 1 new suspected memory leaks (see /sys/kernel/debug/kmemleak)
[11735.840095] kmemleak: 1 new suspected memory leaks (see /sys/kernel/debug/kmemleak)
[16849.168366] hub 5-0:1.0: state 7 ports 2 chg 0000 evt 0002
[16849.168467] hub 5-0:1.0: port 1, status 0100, change 0001, 12 Mb/s
[16849.168470] usb 5-1: USB disconnect, device number 2
[16849.168472] usb 5-1: unregistering device
[16849.168473] usb 5-1: unregistering interface 5-1:1.0
[16849.172371] usb 5-1: unregistering interface 5-1:1.1
[16849.172594] usbhid 5-1:1.1: removing 0 minor
[16849.173256] usb 5-1: usb_disable_device nuking all URBs
[16849.173843] usb 5-1: Successful Endpoint Configure command
[16849.336164] hub 5-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x100

I bet both kmemleaks happened before I ejected the USB card (at about [16849.168366]).
But why the two kmemleak lines are so much lagging after any previous log lines
I don't know but I am repeating here myself. The system is 99% idle. What process
shoudl I be looking for? Or you mean some SysRq magic?

Martin
