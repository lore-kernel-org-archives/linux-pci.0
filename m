Return-Path: <SRS0=i78b=7Z=free.fr=slash.tmp@kernel.org>
Return-Path: <SRS0=i78b=7Z=free.fr=slash.tmp@kernel.org>
Subject: Re: Possible regression between 4.9 and 4.13
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
From: Mason <slash.tmp@free.fr>
Message-ID: <c31b86b7-2974-858c-baa9-2c2e65688606@free.fr>
Date: Wed, 23 Aug 2017 13:54:40 +0200
MIME-Version: 1.0
In-Reply-To: <599D62EA.7050100@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On 23/08/2017 13:11, Mathias Nyman wrote:

> On 23.08.2017 12:31, Mason wrote:
> 
>> [   46.525247] usb 2-2: new SuperSpeed USB device number 2 using xhci_hcd
>> [   46.565496] usb-storage 2-2:1.0: USB Mass Storage device detected
>> [   46.571934] scsi host0: usb-storage 2-2:1.0
>> [   47.601227] scsi 0:0:0:0: Direct-Access     Kingston DataTraveler 3.0      PQ: 0 ANSI: 6
>> [   47.611340] sd 0:0:0:0: [sda] 15109516 512-byte logical blocks: (7.74 GB/7.20 GiB)
>> [   47.621624] sd 0:0:0:0: [sda] Write Protect is off
>> [   47.627131] sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
>> [   47.639637]  sda: sda1
>> [   47.648091] sd 0:0:0:0: [sda] Attached SCSI removable disk
>> [   58.100306] xhci_hcd 0000:01:00.0: xHCI host controller not responding, assume dead
>> [   58.108021] CPU: 0 PID: 939 Comm: kworker/0:2 Tainted: G         C      4.13.0-rc6 #11
>> [   58.115976] Hardware name: Sigma Tango DT
>> [   58.120016] Workqueue: usb_hub_wq hub_event
>> [   58.124241] [<c010f288>] (unwind_backtrace) from [<c010af58>] (show_stack+0x10/0x14)
>> [   58.132033] [<c010af58>] (show_stack) from [<c049d714>] (dump_stack+0x84/0x98)
>> [   58.139302] [<c049d714>] (dump_stack) from [<c03b090c>] (xhci_hc_died.part.9+0x50/0x23c)
>> [   58.147438] [<c03b090c>] (xhci_hc_died.part.9) from [<c03b5d80>] (xhci_hub_control+0xf3c/0x175c)
>> [   58.156273] [<c03b5d80>] (xhci_hub_control) from [<c03934a4>] (usb_hcd_submit_urb+0x264/0x814)
>> [   58.164932] [<c03934a4>] (usb_hcd_submit_urb) from [<c0394fa4>] (usb_start_wait_urb+0x4c/0xbc)
>> [   58.173591] [<c0394fa4>] (usb_start_wait_urb) from [<c03950b4>] (usb_control_msg+0xa0/0xcc)
>> [   58.181985] [<c03950b4>] (usb_control_msg) from [<c038bf54>] (usb_clear_port_feature+0x44/0x4c)
>> [   58.190730] [<c038bf54>] (usb_clear_port_feature) from [<c038c320>] (hub_port_reset+0x228/0x51c)
>> [   58.199561] [<c038c320>] (hub_port_reset) from [<c038fd68>] (hub_event+0x87c/0x108c)
>> [   58.207349] [<c038fd68>] (hub_event) from [<c012ecc4>] (process_one_work+0x1d8/0x3f0)
>> [   58.215220] [<c012ecc4>] (process_one_work) from [<c012f8d8>] (worker_thread+0x38/0x554)
>> [   58.223354] [<c012f8d8>] (worker_thread) from [<c01347d0>] (kthread+0x108/0x138)
>> [   58.230789] [<c01347d0>] (kthread) from [<c01076d8>] (ret_from_fork+0x14/0x3c)
>> [   58.238056] xhci_hcd 0000:01:00.0: HC died; cleaning up
>> [   58.243391] usb 2-2: USB disconnect, device number 2
> 
> xhci driver reads 0xffffffff from a mmio mapped xhci portsc register and bails out in:
> xhci-hub.c:
>          temp = readl(port_array[wIndex]);
>                  if (temp == ~(u32)0) {
>                          xhci_hc_died(xhci);
> 			retval = -ENODEV;
> 	                break;
> 		}
> 
> In this case we read the register when hub thread asks to clear port feature.
> 
> why portsc returns 0xffffffff is a another question, could the hub thread be running while xhci controller is (in D3)?
> Was xhci runtime suspended?

How do I tell?
Should I disable SUSPEND support and all kinds of power management?

> There were some pcieport errors in another log you showed, maybe PCI devices are not properly recovered
> and the registers return 0xffffffff?

FWIW, I just compiled v4.12-rc1 and I do get the broken behavior.

v4.11.12 = OK
v4.12-rc1 = KO

PLUG
[   17.226953] usb 2-2: new SuperSpeed USB device number 2 using xhci_hcd
[   17.267195] usb-storage 2-2:1.0: USB Mass Storage device detected
[   17.273612] scsi host0: usb-storage 2-2:1.0
[   18.296369] scsi 0:0:0:0: Direct-Access     Kingston DataTraveler 3.0      PQ: 0 ANSI: 6
[   18.307772] sd 0:0:0:0: [sda] 15109516 512-byte logical blocks: (7.74 GB/7.20 GiB)
[   18.316991] sd 0:0:0:0: [sda] Write Protect is off
[   18.322588] sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[   18.334828]  sda: sda1
[   18.339507] sd 0:0:0:0: [sda] Attached SCSI removable disk
[   18.366202] random: fast init done

UNPLUG
[   21.314111] pcieport 0000:00:00.0: AER: Uncorrected (Non-Fatal) error received: id=0000
[   21.322219] pcieport 0000:00:00.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, id=0000(Requester ID)
[   21.334039] pcieport 0000:00:00.0:   device [1105:0024] error status/mask=00004000/00000000
[   21.342453] pcieport 0000:00:00.0:    [14] Completion Timeout     (First)
[   21.349306] pcieport 0000:00:00.0: AER: Device recovery failed
[   22.055471] xhci_hcd 0000:01:00.0: xHCI host controller not responding, assume dead
[   22.063187] xhci_hcd 0000:01:00.0: HC died; cleaning up
[   22.068523] usb 2-2: USB disconnect, device number 2
[   22.073774] pcieport 0000:00:00.0: AER: Uncorrected (Non-Fatal) error received: id=0000
[   22.085369] pcieport 0000:00:00.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, id=0000(Requester ID)
[   22.098823] pcieport 0000:00:00.0:   device [1105:0024] error status/mask=00004000/00000000
[   22.107245] pcieport 0000:00:00.0:    [14] Completion Timeout     (First)
[   22.114130] pcieport 0000:00:00.0: AER: Device recovery failed
[   22.120026] pcieport 0000:00:00.0: AER: Uncorrected (Non-Fatal) error received: id=0000
[   22.128096] pcieport 0000:00:00.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, id=0000(Requester ID)
[   22.139916] pcieport 0000:00:00.0:   device [1105:0024] error status/mask=00004000/00000000
[   22.148320] pcieport 0000:00:00.0:    [14] Completion Timeout     (First)
[   22.155162] pcieport 0000:00:00.0: AER: Device recovery failed


The defconfig I used for testing:

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
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPUFREQ_DT=y
CONFIG_VFP=y
CONFIG_NEON=y
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
# CONFIG_INET_XFRM_MODE_TUNNEL is not set
# CONFIG_INET_XFRM_MODE_BEET is not set
# CONFIG_IPV6 is not set
CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_NETDEVICES=y
CONFIG_NET_VENDOR_AURORA=y
CONFIG_AURORA_NB8800=y
CONFIG_AT803X_PHY=y
# CONFIG_WLAN is not set
# CONFIG_INPUT_KEYBOARD is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_SERIO is not set
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_RT288X=y
CONFIG_SERIAL_OF_PLATFORM=y
# CONFIG_HW_RANDOM is not set
CONFIG_I2C=y
CONFIG_I2C_XLR=y
CONFIG_GPIOLIB=y
CONFIG_THERMAL=y
CONFIG_CPU_THERMAL=y
CONFIG_TANGO_THERMAL=y
CONFIG_WATCHDOG=y
CONFIG_TANGOX_WATCHDOG=y
CONFIG_FB=y
# CONFIG_HID is not set
# CONFIG_USB_HID is not set
CONFIG_USB=y
CONFIG_USB_XHCI_HCD=y
CONFIG_USB_STORAGE=y
CONFIG_EXT4_FS=y
CONFIG_FUSE_FS=m
CONFIG_VFAT_FS=m
CONFIG_TMPFS=y
CONFIG_NFS_FS=y
# CONFIG_NFS_V2 is not set
CONFIG_ROOT_NFS=y
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_UTF8=m
CONFIG_PRINTK_TIME=y
# CONFIG_CRYPTO_ECHAINIV is not set
