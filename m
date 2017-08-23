Return-Path: <SRS0=i78b=7Z=free.fr=slash.tmp@kernel.org>
Return-Path: <SRS0=i78b=7Z=free.fr=slash.tmp@kernel.org>
Subject: Re: Possible regression between 4.9 and 4.13
From: Mason <slash.tmp@free.fr>
To: Mathias Nyman <mathias.nyman@intel.com>,
 Felipe Balbi <felipe.balbi@linux.intel.com>,
 linux-pci <linux-pci@vger.kernel.org>, linux-usb
 <linux-usb@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Alan Stern
 <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <4dee5523-2d76-e731-6e81-f3027e88827f@free.fr>
 <87a82qbyv5.fsf@linux.intel.com> <599D3410.9050504@intel.com>
 <251c41c0-a4fd-8aae-88e0-5d5928ce45cf@free.fr>
 <599D62EA.7050100@linux.intel.com>
 <c31b86b7-2974-858c-baa9-2c2e65688606@free.fr>
Message-ID: <8ac92197-907a-282b-2165-f50d1b09bd55@free.fr>
Date: Wed, 23 Aug 2017 14:41:01 +0200
MIME-Version: 1.0
In-Reply-To: <c31b86b7-2974-858c-baa9-2c2e65688606@free.fr>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On 23/08/2017 13:54, Mason wrote:

> On 23/08/2017 13:11, Mathias Nyman wrote:
> 
>> In this case we read the register when hub thread asks to clear port feature.
>>
>> why portsc returns 0xffffffff is a another question, could the hub thread be running while xhci controller is (in D3)?
>> Was xhci runtime suspended?
> 
> How do I tell?
> Should I disable SUSPEND support and all kinds of power management?

I compiled a minimal kernel, with lots of irrelevant drivers and
frameworks left out, including power management. I still get the
"xHCI host controller not responding, assume dead" issue.

PLUG
[   59.803499] usb 2-2: new SuperSpeed USB device number 2 using xhci_hcd
[   59.836902] usb 2-2: New USB device found, idVendor=0951, idProduct=1666
[   59.843653] usb 2-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[   59.850900] usb 2-2: Product: DataTraveler 3.0
[   59.855417] usb 2-2: Manufacturer: Kingston
[   59.859661] usb 2-2: SerialNumber: 002618887865F0C0F8646BFA
[   59.868249] usb-storage 2-2:1.0: USB Mass Storage device detected
[   59.874691] scsi host0: usb-storage 2-2:1.0
[   60.882801] scsi 0:0:0:0: Direct-Access     Kingston DataTraveler 3.0      PQ: 0 ANSI: 6
[   60.891640] sd 0:0:0:0: [sda] 15109516 512-byte logical blocks: (7.74 GB/7.20 GiB)
[   60.899662] sd 0:0:0:0: [sda] Write Protect is off
[   60.904763] sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[   60.916154]  sda: sda1
[   60.919798] sd 0:0:0:0: [sda] Attached SCSI removable disk

UNPLUG
[   70.545087] pcieport 0000:00:00.0: AER: Uncorrected (Non-Fatal) error received: id=0000
[   70.553169] pcieport 0000:00:00.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, id=0000(Requester ID)
[   70.565084] pcieport 0000:00:00.0:   device [1105:0024] error status/mask=00004000/00000000
[   70.573528] pcieport 0000:00:00.0:    [14] Completion Timeout     (First)
[   70.580402] pcieport 0000:00:00.0: AER: Device recovery failed

[   71.275253] xhci_hcd 0000:01:00.0: xHCI host controller not responding, assume dead
[   71.282956] xhci_hcd 0000:01:00.0: HC died; cleaning up
[   71.288304] usb 2-2: USB disconnect, device number 2

[   71.293445] pcieport 0000:00:00.0: AER: Uncorrected (Non-Fatal) error received: id=0000
[   71.301851] pcieport 0000:00:00.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, id=0000(Requester ID)
[   71.313785] pcieport 0000:00:00.0:   device [1105:0024] error status/mask=00004000/00000000
[   71.322240] pcieport 0000:00:00.0:    [14] Completion Timeout     (First)
[   71.329115] pcieport 0000:00:00.0: AER: Device recovery failed

[   71.335042] pcieport 0000:00:00.0: AER: Uncorrected (Non-Fatal) error received: id=0000
[   71.343137] pcieport 0000:00:00.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, id=0000(Requester ID)
[   71.354984] pcieport 0000:00:00.0:   device [1105:0024] error status/mask=00004000/00000000
[   71.363443] pcieport 0000:00:00.0:    [14] Completion Timeout     (First)
[   71.370289] pcieport 0000:00:00.0: AER: Device recovery failed


defconfig for reference

# CONFIG_SWAP is not set
CONFIG_SYSVIPC=y
CONFIG_NO_HZ_IDLE=y
CONFIG_HIGH_RES_TIMERS=y
# CONFIG_COMPAT_BRK is not set
CONFIG_SLAB=y
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODVERSIONS=y
CONFIG_ARCH_TANGO=y
# CONFIG_ARM_ERRATA_643719 is not set
CONFIG_PCI=y
CONFIG_PCIEPORTBUS=y
CONFIG_PCI_MSI=y
CONFIG_PCIE_TANGO_SMP8759=y
CONFIG_SMP=y
CONFIG_PREEMPT=y
CONFIG_HZ_300=y
CONFIG_AEABI=y
CONFIG_HIGHMEM=y
# CONFIG_ATAGS is not set
CONFIG_ARM_APPENDED_DTB=y
CONFIG_ARM_ATAG_DTB_COMPAT=y
CONFIG_VFP=y
CONFIG_NEON=y
# CONFIG_SUSPEND is not set
CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
# CONFIG_INPUT_KEYBOARD is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_SERIO is not set
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_RT288X=y
CONFIG_SERIAL_OF_PLATFORM=y
# CONFIG_HW_RANDOM is not set
# CONFIG_HWMON is not set
# CONFIG_HID is not set
# CONFIG_USB_HID is not set
CONFIG_USB=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
CONFIG_USB_XHCI_HCD=y
CONFIG_USB_STORAGE=y
CONFIG_VFAT_FS=m
CONFIG_TMPFS=y
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_UTF8=m
CONFIG_PRINTK_TIME=y
