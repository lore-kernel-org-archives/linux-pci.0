Return-Path: <SRS0=7EXQ=3A=free.fr=slash.tmp@kernel.org>
Return-Path: <SRS0=7EXQ=3A=free.fr=slash.tmp@kernel.org>
From: Mason <slash.tmp@free.fr>
Subject: AER notifications
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>, David Laight <david.laight@aculab.com>,
 linux-pci <linux-pci@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 Phuong Nguyen <phuong_nguyen@sigmadesigns.com>,
 Jean Delvare <jdelvare@suse.de>
Message-ID: <f22570b0-aaf5-0c30-0ee7-4e69762552b3@free.fr>
Date: Thu, 23 Mar 2017 15:14:50 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-pci.vger.kernel.org>

Hello,

My PCIe host bridge is supposed to support AER, so I enabled
kernel support, out of curiosity. For these tests, I plugged
a USB3 card into the PCIe slot.

I see two classes of reports.

1) When the system is idling, with no USB device plugged into
the PCIe card, I occasionally see these:

[ 5003.638675] pcieport 0000:00:00.0: AER: Multiple Corrected error received: id=0000
[ 5003.646365] pcieport 0000:00:00.0: PCIe Bus Error: severity=Corrected, type=Physical Layer, id=0000(Receiver ID)
[ 5003.656991] pcieport 0000:00:00.0:   device [1105:0028] error status/mask=00000001/00002000
[ 5003.665566] pcieport 0000:00:00.0:    [ 0] Receiver Error         (First)

[ 6104.766906] pcieport 0000:00:00.0: AER: Multiple Corrected error received: id=0000
[ 6104.774579] pcieport 0000:00:00.0: PCIe Bus Error: severity=Corrected, type=Physical Layer, id=0000(Receiver ID)
[ 6104.785140] pcieport 0000:00:00.0:   device [1105:0028] error status/mask=00000001/00002000
[ 6104.793701] pcieport 0000:00:00.0:    [ 0] Receiver Error         (First)

[ 8388.051130] pcieport 0000:00:00.0: AER: Multiple Corrected error received: id=0000
[ 8388.058818] pcieport 0000:00:00.0: PCIe Bus Error: severity=Corrected, type=Physical Layer, id=0000(Receiver ID)
[ 8388.069429] pcieport 0000:00:00.0:   device [1105:0028] error status/mask=00000001/00002000
[ 8388.078041] pcieport 0000:00:00.0:    [ 0] Receiver Error         (First)

[11022.907894] pcieport 0000:00:00.0: AER: Multiple Corrected error received: id=0000
[11022.915570] pcieport 0000:00:00.0: PCIe Bus Error: severity=Corrected, type=Physical Layer, id=0000(Receiver ID)
[11022.926102] pcieport 0000:00:00.0:   device [1105:0028] error status/mask=00000001/00002000
[11022.934666] pcieport 0000:00:00.0:    [ 0] Receiver Error         (First)

1105:0024 is the rev1 host bridge.
1105:0028 is the rev2 host bridge.

I'll let a rev1 host bridge idle for a long time, but I don't
remember seeing these reports on rev1.


2) When I unplug my USB3 Flash drive, I always get some kind of
error from the USB framework, and sometimes they are coupled with
AER messages.

[   40.158166] pcieport 0000:00:00.0: AER: Uncorrected (Non-Fatal) error received: id=0000
[   40.166291] pcieport 0000:00:00.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, id=0000(Requester ID)
[   40.178519] pcieport 0000:00:00.0:   device [1105:0024] error status/mask=00004000/00000000
[   40.187033] pcieport 0000:00:00.0:    [14] Completion Timeout     (First)
[   40.193957] pcieport 0000:00:00.0: broadcast error_detected message
[   40.200345] pcieport 0000:00:00.0: AER: Device recovery failed
[   40.485352] xhci_hcd 0000:01:00.0: Cannot set link state.
[   40.490887] usb usb2-port2: cannot disable (err = -32)
[   40.496070] usb 2-2: USB disconnect, device number 2
[   40.508478] pcieport 0000:00:00.0: AER: Uncorrected (Non-Fatal) error received: id=0000
[   40.517291] pcieport 0000:00:00.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, id=0000(Requester ID)
[   40.529266] pcieport 0000:00:00.0:   device [1105:0024] error status/mask=00004000/00000000
[   40.538284] pcieport 0000:00:00.0:    [14] Completion Timeout     (First)
[   40.545233] pcieport 0000:00:00.0: broadcast error_detected message
[   40.551883] pcieport 0000:00:00.0: AER: Device recovery failed
[   40.557859] pcieport 0000:00:00.0: AER: Uncorrected (Non-Fatal) error received: id=0000
[   40.566367] pcieport 0000:00:00.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, id=0000(Requester ID)
[   40.578667] pcieport 0000:00:00.0:   device [1105:0024] error status/mask=00004000/00000000
[   40.587098] pcieport 0000:00:00.0:    [14] Completion Timeout     (First)
[   40.593950] pcieport 0000:00:00.0: broadcast error_detected message
[   40.600268] pcieport 0000:00:00.0: AER: Device recovery failed
[   40.606148] pcieport 0000:00:00.0: AER: Uncorrected (Non-Fatal) error received: id=0000
[   40.614223] pcieport 0000:00:00.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, id=0000(Requester ID)
[   40.626046] pcieport 0000:00:00.0:   device [1105:0024] error status/mask=00004000/00000000
[   40.634455] pcieport 0000:00:00.0:    [14] Completion Timeout     (First)
[   40.641295] pcieport 0000:00:00.0: broadcast error_detected message
[   40.647605] pcieport 0000:00:00.0: AER: Device recovery failed


Should I worry over these reports?
(The first set looks harmless, the second one looks bad.)

# /usr/sbin/lspci -v

00:00.0 PCI bridge: Sigma Designs, Inc. Device 0024 (rev 01) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0, IRQ 26
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 00000000-00000fff [size=4K]
        Memory behind bridge: 04000000-040fffff [size=1M]
        Prefetchable memory behind bridge: 00000000-000fffff [size=1M]
        Capabilities: [50] MSI: Enable+ Count=1/4 Maskable- 64bit+
        Capabilities: [78] Power Management version 3
        Capabilities: [80] Express Root Port (Slot-), MSI 03
        Capabilities: [100] Virtual Channel
        Capabilities: [800] Advanced Error Reporting
        Kernel driver in use: pcieport

01:00.0 USB controller: Renesas Technology Corp. uPD720201 USB 3.0 Host Controller (rev 03) (prog-if 30 [XHCI])
        Flags: bus master, fast devsel, latency 0, IRQ 28
        Memory at 54000000 (64-bit, non-prefetchable) [size=8K]
        Capabilities: [50] Power Management version 3
        Capabilities: [70] MSI: Enable+ Count=1/8 Maskable- 64bit+
        Capabilities: [90] MSI-X: Enable- Count=8 Masked-
        Capabilities: [a0] Express Endpoint, MSI 00
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [150] Latency Tolerance Reporting
        Kernel driver in use: xhci_hcd


Regards.
