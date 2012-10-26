Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ns.uli-eckhardt.de ([85.214.28.137]:58788 "EHLO
	mail.uli-eckhardt.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965412Ab2JZQlp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 26 Oct 2012 12:41:45 -0400
Message-ID: <508ABD43.8080708@uli-eckhardt.de>
Date: Fri, 26 Oct 2012 18:41:39 +0200
From: Ulrich Eckhardt <usb@uli-eckhardt.de>
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@sisk.pl>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Sarah Sharp <sarah.a.sharp@linux.intel.com>,
	linux-pci@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Unreliable USB3 with NEC uPD720200 and Delock Cardreader
References: <50841CCC.9030809@uli-eckhardt.de> <CAErSpo5cN5w=E8GYyKE=bX0=67Qk0g0wAW4vVFe0QfPGxo=+MA@mail.gmail.com> <508973CE.8080603@uli-eckhardt.de> <42232189.sLGmN8Uve8@vostro.rjw.lan>
In-Reply-To: <42232189.sLGmN8Uve8@vostro.rjw.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am 25.10.2012 22:11, schrieb Rafael J. Wysocki:
> On Thursday, October 25, 2012 07:15:58 PM Ulrich Eckhardt wrote:
>> I have done first a cat to the control file which returns already on:
>>
>> uli:/ # cat /sys/devices/pci0000\:00/0000\:00\:04.0/power/control
>> on
>>
>> Writing again on to the file does not change anything.
>
> Yes, and this means that runtime PM is disabled on the controller.
>
> ASPM remains as a possible culprit, then.
>
> Can you please boot with pcie_aspm=off in the kernel command line and see
> if this makes a difference?

It make no difference:
    ...
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: 
root=/dev/disk/by-id/ata-Corsair_Force_3_SSD_123079600000149504CF-part1 
resume=/dev/disk/by-id/ata-WDC_WD20EARX-00PASB0_WD-WCAZA7766668-part2 
splash=silent quiet vga=0x31a pcie_aspm=off
[    0.000000] bootsplash: silent mode.
[    0.000000] PCIe ASPM is disabled
    ...
[  124.949190] sdf: detected capacity change from 2032664576 to 0
[  132.387722] sd 10:0:0:2: [sdf] 3970048 512-byte logical blocks: (2.03 
GB/1.89 GiB)
[  132.388881] sd 10:0:0:2: [sdf] No Caching mode page present
[  132.388891] sd 10:0:0:2: [sdf] Assuming drive cache: write through
[  132.390876] sd 10:0:0:2: [sdf] No Caching mode page present
[  132.390885] sd 10:0:0:2: [sdf] Assuming drive cache: write through
[  132.393259]  sdf: sdf1
[  137.286335] sdf: detected capacity change from 2032664576 to 0
[  144.304194] sd 10:0:0:2: [sdf] 3970048 512-byte logical blocks: (2.03 
GB/1.89 GiB)
[  144.305345] sd 10:0:0:2: [sdf] No Caching mode page present
[  144.305356] sd 10:0:0:2: [sdf] Assuming drive cache: write through
[  144.307389] sd 10:0:0:2: [sdf] No Caching mode page present
[  144.307399] sd 10:0:0:2: [sdf] Assuming drive cache: write through
[  144.309682]  sdf: sdf1
[  217.179499] hub 9-0:1.0: cannot reset port 2 (err = -19)
[  217.440798] hub 9-0:1.0: hub_port_status failed (err = -19)
[  217.440865] sd 10:0:0:2: Device offlined - not ready after error recovery
[  217.440873] sd 10:0:0:2: [sdf] Unhandled error code
[  217.440875] sd 10:0:0:2: [sdf]
[  217.440876] Result: hostbyte=DID_ABORT driverbyte=DRIVER_OK
[  217.440878] sd 10:0:0:2: [sdf] CDB:
[  217.440879] Read(10): 28 00 00 00 0f 00 00 00 f0 00
[  217.440884] end_request: I/O error, dev sdf, sector 3840
[  217.440909] sd 10:0:0:2: rejecting I/O to offline device
[  217.440911] sd 10:0:0:2: killing request
[  217.440945] sd 10:0:0:2: rejecting I/O to offline device
[  217.440958] sd 10:0:0:2: [sdf] killing request
[  217.440968] sd 10:0:0:2: rejecting I/O to offline device
[  217.440977] sd 10:0:0:2: rejecting I/O to offline device
[  217.440979] sd 10:0:0:2: rejecting I/O to offline device
[  217.441003] sd 10:0:0:2: [sdf] Unhandled error code
[  217.441008] sd 10:0:0:2: [sdf]
[  217.441012] Result: hostbyte=DID_NO_CONNECT driverbyte=DRIVER_OK
[  217.441017] sd 10:0:0:2: [sdf] CDB:
[  217.441020] Read(10): 28 00 00 00 0f f0 00 00 10 00
[  217.441036] end_request: I/O error, dev sdf, sector 4080
[  217.442200] sd 10:0:0:2: rejecting I/O to offline device
[  217.442252] sd 10:0:0:2: rejecting I/O to offline device

-- 
Ulrich Eckhardt                  http://www.uli-eckhardt.de

Ein Blitzableiter auf dem Kirchturm ist das denkbar stärkste
Misstrauensvotum gegen den lieben Gott. (Karl Krauss)
