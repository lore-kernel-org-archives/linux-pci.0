Return-Path: <SRS0=7EXQ=3A=free.fr=slash.tmp@kernel.org>
Return-Path: <SRS0=7EXQ=3A=free.fr=slash.tmp@kernel.org>
Subject: Re: AER notifications
From: Mason <slash.tmp@free.fr>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>, David Laight <david.laight@aculab.com>,
 linux-pci <linux-pci@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 Phuong Nguyen <phuong_nguyen@sigmadesigns.com>,
 Jean Delvare <jdelvare@suse.de>
References: <f22570b0-aaf5-0c30-0ee7-4e69762552b3@free.fr>
Message-ID: <92032302-8139-601b-690b-0299360bc462@free.fr>
Date: Thu, 23 Mar 2017 16:15:57 +0100
MIME-Version: 1.0
In-Reply-To: <f22570b0-aaf5-0c30-0ee7-4e69762552b3@free.fr>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-pci.vger.kernel.org>

On 23/03/2017 15:14, Mason wrote:

> My PCIe host bridge is supposed to support AER, so I enabled
> kernel support, out of curiosity. For these tests, I plugged
> a USB3 card into the PCIe slot.
> 
> I see two classes of reports.
> 
> 1) When the system is idling, with no USB device plugged into
> the PCIe card, I occasionally see these:
> 
> [ 5003.638675] pcieport 0000:00:00.0: AER: Multiple Corrected error received: id=0000
> [ 5003.646365] pcieport 0000:00:00.0: PCIe Bus Error: severity=Corrected, type=Physical Layer, id=0000(Receiver ID)
> [ 5003.656991] pcieport 0000:00:00.0:   device [1105:0028] error status/mask=00000001/00002000
> [ 5003.665566] pcieport 0000:00:00.0:    [ 0] Receiver Error         (First)
> 
> [ 6104.766906] pcieport 0000:00:00.0: AER: Multiple Corrected error received: id=0000
> [ 6104.774579] pcieport 0000:00:00.0: PCIe Bus Error: severity=Corrected, type=Physical Layer, id=0000(Receiver ID)
> [ 6104.785140] pcieport 0000:00:00.0:   device [1105:0028] error status/mask=00000001/00002000
> [ 6104.793701] pcieport 0000:00:00.0:    [ 0] Receiver Error         (First)
> 
> [ 8388.051130] pcieport 0000:00:00.0: AER: Multiple Corrected error received: id=0000
> [ 8388.058818] pcieport 0000:00:00.0: PCIe Bus Error: severity=Corrected, type=Physical Layer, id=0000(Receiver ID)
> [ 8388.069429] pcieport 0000:00:00.0:   device [1105:0028] error status/mask=00000001/00002000
> [ 8388.078041] pcieport 0000:00:00.0:    [ 0] Receiver Error         (First)
> 
> [11022.907894] pcieport 0000:00:00.0: AER: Multiple Corrected error received: id=0000
> [11022.915570] pcieport 0000:00:00.0: PCIe Bus Error: severity=Corrected, type=Physical Layer, id=0000(Receiver ID)
> [11022.926102] pcieport 0000:00:00.0:   device [1105:0028] error status/mask=00000001/00002000
> [11022.934666] pcieport 0000:00:00.0:    [ 0] Receiver Error         (First)
> 
> 1105:0024 is the rev1 host bridge.
> 1105:0028 is the rev2 host bridge.
> 
> I'll let a rev1 host bridge idle for a long time, but I don't
> remember seeing these reports on rev1.
> 
> 
> 2) When I unplug my USB3 Flash drive, I always get some kind of
> error from the USB framework, and sometimes they are coupled with
> AER messages.
> 
> [   40.158166] pcieport 0000:00:00.0: AER: Uncorrected (Non-Fatal) error received: id=0000
> [   40.166291] pcieport 0000:00:00.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, id=0000(Requester ID)
> [   40.178519] pcieport 0000:00:00.0:   device [1105:0024] error status/mask=00004000/00000000
> [   40.187033] pcieport 0000:00:00.0:    [14] Completion Timeout     (First)
> [   40.193957] pcieport 0000:00:00.0: broadcast error_detected message
> [   40.200345] pcieport 0000:00:00.0: AER: Device recovery failed
> [   40.485352] xhci_hcd 0000:01:00.0: Cannot set link state.
> [   40.490887] usb usb2-port2: cannot disable (err = -32)
> [   40.496070] usb 2-2: USB disconnect, device number 2
> [   40.508478] pcieport 0000:00:00.0: AER: Uncorrected (Non-Fatal) error received: id=0000
> [   40.517291] pcieport 0000:00:00.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, id=0000(Requester ID)
> [   40.529266] pcieport 0000:00:00.0:   device [1105:0024] error status/mask=00004000/00000000
> [   40.538284] pcieport 0000:00:00.0:    [14] Completion Timeout     (First)
> [   40.545233] pcieport 0000:00:00.0: broadcast error_detected message
> [   40.551883] pcieport 0000:00:00.0: AER: Device recovery failed
> [   40.557859] pcieport 0000:00:00.0: AER: Uncorrected (Non-Fatal) error received: id=0000
> [   40.566367] pcieport 0000:00:00.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, id=0000(Requester ID)
> [   40.578667] pcieport 0000:00:00.0:   device [1105:0024] error status/mask=00004000/00000000
> [   40.587098] pcieport 0000:00:00.0:    [14] Completion Timeout     (First)
> [   40.593950] pcieport 0000:00:00.0: broadcast error_detected message
> [   40.600268] pcieport 0000:00:00.0: AER: Device recovery failed
> [   40.606148] pcieport 0000:00:00.0: AER: Uncorrected (Non-Fatal) error received: id=0000
> [   40.614223] pcieport 0000:00:00.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, id=0000(Requester ID)
> [   40.626046] pcieport 0000:00:00.0:   device [1105:0024] error status/mask=00004000/00000000
> [   40.634455] pcieport 0000:00:00.0:    [14] Completion Timeout     (First)
> [   40.641295] pcieport 0000:00:00.0: broadcast error_detected message
> [   40.647605] pcieport 0000:00:00.0: AER: Device recovery failed


Apparently, the above error trace occurs *every time* I unplug the
USB3 Flash drive. I'm sure it didn't use to happen systematically...

[   59.058798] usb 2-2: new SuperSpeed USB device number 2 using xhci_hcd
[   59.092272] usb 2-2: New USB device found, idVendor=0951, idProduct=1666
[   59.099029] usb 2-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[   59.106377] usb 2-2: Product: DataTraveler 3.0
[   59.110929] usb 2-2: Manufacturer: Kingston
[   59.115209] usb 2-2: SerialNumber: 002618887865F0C0F8646BFA
[   59.124163] usb-storage 2-2:1.0: USB Mass Storage device detected
[   59.130727] scsi host0: usb-storage 2-2:1.0
[   60.158296] scsi 0:0:0:0: Direct-Access     Kingston DataTraveler 3.0      PQ: 0 ANSI: 6
[   60.168252] sd 0:0:0:0: [sda] 15109516 512-byte logical blocks: (7.74 GB/7.20 GiB)
[   60.178876] sd 0:0:0:0: [sda] Write Protect is off
[   60.184356] sd 0:0:0:0: [sda] Mode Sense: 4f 00 00 00
[   60.189738] sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[   60.202228]  sda: sda1
[   60.206629] sd 0:0:0:0: [sda] Attached SCSI removable disk

[   65.963480] pcieport 0000:00:00.0: AER: Uncorrected (Non-Fatal) error received: id=0000
[   65.971582] pcieport 0000:00:00.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, id=0000(Requester ID)
[   65.983816] pcieport 0000:00:00.0:   device [1105:0024] error status/mask=00004000/00000000
[   65.992331] pcieport 0000:00:00.0:    [14] Completion Timeout     (First)
[   65.999274] pcieport 0000:00:00.0: broadcast error_detected message
[   66.005664] pcieport 0000:00:00.0: AER: Device recovery failed
[   66.280717] xhci_hcd 0000:01:00.0: Cannot set link state.
[   66.286295] usb usb2-port2: cannot disable (err = -32)
[   66.291486] usb 2-2: USB disconnect, device number 2
[   66.297725] pcieport 0000:00:00.0: AER: Uncorrected (Non-Fatal) error received: id=0000
[   66.306012] pcieport 0000:00:00.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, id=0000(Requester ID)
[   66.318142] pcieport 0000:00:00.0:   device [1105:0024] error status/mask=00004000/00000000
[   66.326704] pcieport 0000:00:00.0:    [14] Completion Timeout     (First)
[   66.333641] pcieport 0000:00:00.0: broadcast error_detected message
[   66.340043] pcieport 0000:00:00.0: AER: Device recovery failed
[   66.345996] pcieport 0000:00:00.0: AER: Uncorrected (Non-Fatal) error received: id=0000
[   66.354141] pcieport 0000:00:00.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, id=0000(Requester ID)
[   66.366026] pcieport 0000:00:00.0:   device [1105:0024] error status/mask=00004000/00000000
[   66.374444] pcieport 0000:00:00.0:    [14] Completion Timeout     (First)
[   66.381321] pcieport 0000:00:00.0: broadcast error_detected message
[   66.387635] pcieport 0000:00:00.0: AER: Device recovery failed

[   72.715540] usb 2-2: new SuperSpeed USB device number 3 using xhci_hcd
[   72.748836] usb 2-2: New USB device found, idVendor=0951, idProduct=1666
[   72.755594] usb 2-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[   72.762778] usb 2-2: Product: DataTraveler 3.0
[   72.767329] usb 2-2: Manufacturer: Kingston
[   72.771547] usb 2-2: SerialNumber: 002618887865F0C0F8646BFA
[   72.780539] usb-storage 2-2:1.0: USB Mass Storage device detected
[   72.786987] scsi host0: usb-storage 2-2:1.0
[   73.811611] scsi 0:0:0:0: Direct-Access     Kingston DataTraveler 3.0      PQ: 0 ANSI: 6
[   73.821656] sd 0:0:0:0: [sda] 15109516 512-byte logical blocks: (7.74 GB/7.20 GiB)
[   73.832641] sd 0:0:0:0: [sda] Write Protect is off
[   73.837909] sd 0:0:0:0: [sda] Mode Sense: 4f 00 00 00
[   73.843538] sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[   73.856237]  sda: sda1
[   73.864146] sd 0:0:0:0: [sda] Attached SCSI removable disk

[   78.138502] pcieport 0000:00:00.0: AER: Uncorrected (Non-Fatal) error received: id=0000
[   78.146629] pcieport 0000:00:00.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, id=0000(Requester ID)
[   78.158469] pcieport 0000:00:00.0:   device [1105:0024] error status/mask=00004000/00000000
[   78.166904] pcieport 0000:00:00.0:    [14] Completion Timeout     (First)
[   78.173768] pcieport 0000:00:00.0: broadcast error_detected message
[   78.180081] pcieport 0000:00:00.0: AER: Device recovery failed
[   78.464045] xhci_hcd 0000:01:00.0: Cannot set link state.
[   78.469507] usb usb2-port2: cannot disable (err = -32)
[   78.474689] usb 2-2: USB disconnect, device number 3
[   78.480947] pcieport 0000:00:00.0: AER: Uncorrected (Non-Fatal) error received: id=0000
[   78.489209] pcieport 0000:00:00.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, id=0000(Requester ID)
[   78.501131] pcieport 0000:00:00.0:   device [1105:0024] error status/mask=00004000/00000000
[   78.509573] pcieport 0000:00:00.0:    [14] Completion Timeout     (First)
[   78.516495] pcieport 0000:00:00.0: broadcast error_detected message
[   78.522833] pcieport 0000:00:00.0: AER: Device recovery failed
[   78.528715] pcieport 0000:00:00.0: AER: Uncorrected (Non-Fatal) error received: id=0000
[   78.536799] pcieport 0000:00:00.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, id=0000(Requester ID)
[   78.548644] pcieport 0000:00:00.0:   device [1105:0024] error status/mask=00004000/00000000
[   78.557053] pcieport 0000:00:00.0:    [14] Completion Timeout     (First)
[   78.563905] pcieport 0000:00:00.0: broadcast error_detected message
[   78.570214] pcieport 0000:00:00.0: AER: Device recovery failed


And I also see a third kind of report:

[   17.826017] pcieport 0000:00:00.0: AER: Corrected error received: id=0000
[   17.833917] pcieport 0000:00:00.0: PCIe Bus Error: severity=Corrected, type=Data Link Layer, id=0000(Transmitter ID)
[   17.844583] pcieport 0000:00:00.0:   device [1105:0024] error status/mask=00001000/00002000
[   17.853217] pcieport 0000:00:00.0:    [12] Replay Timer Timeout  

[ 7100.130522] pcieport 0000:00:00.0: AER: Corrected error received: id=0000
[ 7100.137405] pcieport 0000:00:00.0: PCIe Bus Error: severity=Corrected, type=Data Link Layer, id=0000(Transmitter ID)
[ 7100.148351] pcieport 0000:00:00.0:   device [1105:0024] error status/mask=00001000/00002000
[ 7100.156888] pcieport 0000:00:00.0:    [12] Replay Timer Timeout  


I'll try enabling AER on the legacy kernel (3.4) to see if I get
the same behavior.

Regards.
