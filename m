Return-Path: <SRS0=SLfc=7Z=linux.intel.com=felipe.balbi@kernel.org>
Return-Path: <SRS0=SLfc=7Z=linux.intel.com=felipe.balbi@kernel.org>
From: Felipe Balbi <felipe.balbi@linux.intel.com>
To: Mason <slash.tmp@free.fr>, linux-pci <linux-pci@vger.kernel.org>, linux-usb <linux-usb@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mathias Nyman <mathias.nyman@intel.com>
Subject: Re: Possible regression between 4.9 and 4.13
In-Reply-To: <4dee5523-2d76-e731-6e81-f3027e88827f@free.fr>
References: <4dee5523-2d76-e731-6e81-f3027e88827f@free.fr>
Date: Wed, 23 Aug 2017 09:07:58 +0300
Message-ID: <87a82qbyv5.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-pci.vger.kernel.org>


Hi,

Mason <slash.tmp@free.fr> writes:
> Hello,
>
> The driver for my system's PCIe host bridge landed recently
> (in 4.13) but it was developed on 4.9
>
> I tested the PCIe host bridge by plugging a 4-port USB3 adapter
> into the PCIe slot (system at rest) and plugging an USB3 Flash
> drive into the USB3 adapter (at run-time).
>
> On 4.9, the setup works (almost perfectly, see below).
> On 4.13, once I unplug the Flash drive, the controller port
> remains unresponsive.
>
>
> On 4.9, I said *almost* perfectly, because the pcieport driver
> does report a few non-fatal errors when I unplug:
>
> [  193.838504] usb 2-2: new SuperSpeed USB device number 2 using xhci_hcd
> [  193.878081] usb-storage 2-2:1.0: USB Mass Storage device detected
> [  193.884547] scsi host0: usb-storage 2-2:1.0
> [  194.907936] scsi 0:0:0:0: Direct-Access     Kingston DataTraveler 3.0      PQ: 0 ANSI: 6
> [  194.920296] sd 0:0:0:0: [sda] 15109516 512-byte logical blocks: (7.74 GB/7.20 GiB)
> [  194.928666] sd 0:0:0:0: [sda] Write Protect is off
> [  194.933755] sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
> [  194.946074]  sda: sda1
> [  194.953608] sd 0:0:0:0: [sda] Attached SCSI removable disk
>
> [  208.930260] pcieport 0000:00:00.0: AER: Uncorrected (Non-Fatal) error received: id=0000
> [  208.938342] pcieport 0000:00:00.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, id=0000(Requester ID)
> [  208.950163] pcieport 0000:00:00.0:   device [1105:0024] error status/mask=00004000/00000000
> [  208.958577] pcieport 0000:00:00.0:    [14] Completion Timeout     (First)
> [  208.965432] pcieport 0000:00:00.0: AER: Device recovery failed
> [  209.663733] xhci_hcd 0000:01:00.0: Cannot set link state.
> [  209.669194] usb usb2-port2: cannot disable (err = -32)
> [  209.674376] usb 2-2: USB disconnect, device number 2
> [  209.680481] pcieport 0000:00:00.0: AER: Uncorrected (Non-Fatal) error received: id=0000
> [  209.688689] pcieport 0000:00:00.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, id=0000(Requester ID)
> [  209.700555] pcieport 0000:00:00.0:   device [1105:0024] error status/mask=00004000/00000000
> [  209.708978] pcieport 0000:00:00.0:    [14] Completion Timeout     (First)
> [  209.715845] pcieport 0000:00:00.0: AER: Device recovery failed
> [  209.721722] pcieport 0000:00:00.0: AER: Uncorrected (Non-Fatal) error received: id=0000
> [  209.729785] pcieport 0000:00:00.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, id=0000(Requester ID)
> [  209.741602] pcieport 0000:00:00.0:   device [1105:0024] error status/mask=00004000/00000000
> [  209.750027] pcieport 0000:00:00.0:    [14] Completion Timeout     (First)
> [  209.756866] pcieport 0000:00:00.0: AER: Device recovery failed
>
> After that, I can still plug the drive into the same port.
>
> But on 4.13, I get
>
> [   27.330378] usb 2-2: new SuperSpeed USB device number 2 using xhci_hcd
> [   27.369383] usb-storage 2-2:1.0: USB Mass Storage device detected
> [   27.375840] scsi host0: usb-storage 2-2:1.0
> [   28.403035] scsi 0:0:0:0: Direct-Access     Kingston DataTraveler 3.0      PQ: 0 ANSI: 6
> [   28.413326] sd 0:0:0:0: [sda] 15109516 512-byte logical blocks: (7.74 GB/7.20 GiB)
> [   28.423653] sd 0:0:0:0: [sda] Write Protect is off
> [   28.429139] sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
> [   28.441529]  sda: sda1
> [   28.449431] sd 0:0:0:0: [sda] Attached SCSI removable disk
>
> [   90.592134] xhci_hcd 0000:01:00.0: xHCI host controller not responding, assume dead
> [   90.599857] xhci_hcd 0000:01:00.0: HC died; cleaning up
> [   90.605336] usb 2-2: USB disconnect, device number 2
> [   90.630414] udevd[955]: inotify_add_watch(6, /dev/sda, 10) failed: No such file or directory
>
> Trying to replug into the same port = nothing happens
> (Linux did say "assume dead")
>
> Any idea what could have changed between 4.9 and 4.13 ?
>

Quite a bit:

$ git rev-list --no-merges  --count v4.13-rc6 ^v4.9 -- drivers/usb/host/xhci drivers/usb/core/
58

Any chance you can bisect to figure out the offending commit?

-- 
balbi
