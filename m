Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Thu, 27 Oct 2016 11:35:59 +0200
From: Peter Wu <peter@lekensteyn.nl>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Rick Kerkhof <rick.2889@gmail.com>, linux-acpi@vger.kernel.org,
        nouveau@lists.freedesktop.org, linux-pci@vger.kernel.org
Subject: Re: Acer Aspire V7-582PG (Haswell, GTX 750M) fails to power off GPU
 via Power Resources
Message-ID: <20161027093559.GC27017@al>
References: <bug-98398-8800@http.bugs.freedesktop.org/>
 <bug-98398-8800-66oU1nuK0R@http.bugs.freedesktop.org/>
 <20161026225641.GA27017@al>
 <20161027081748.GX1476@lahna.fi.intel.com>
 <20161027090604.GB27017@al>
 <CANni8hdMs4pL0m6FrgeyJjE2R2C=6PaHbVbMVoUU+NszJuf9OA@mail.gmail.com>
 <20161027093011.GZ1476@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161027093011.GZ1476@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 27, 2016 at 12:30:11PM +0300, Mika Westerberg wrote:
> On Thu, Oct 27, 2016 at 09:15:19AM +0000, Rick Kerkhof wrote:
> >    I can confirm what Peter said, path contains \_SB_.PCI0.RP05 and
> >    power_state contains D3hot.
> 
> And there are no power_resources_Dx directories under
> /sys/bus/pci/devices/0000:00:1c.4/firmware_node?

Correct, this is what Rick sent me yesterday for
ls -lR /sys/bus/pci/devices/0000:00:1c.4/firmware_node/

    .:
    totaal 0
    -r--r--r--  1 root root 4096 26 okt 22:10 adr
    drwxr-xr-x  3 root root    0 26 okt 22:12 device:32
    drwxr-xr-x 12 root root    0 26 okt 22:12 LNXVIDEO:00
    -r--r--r--  1 root root 4096 26 okt 22:10 path
    lrwxrwxrwx  1 root root    0 26 okt 22:10 physical_node -> ../../../../pci0000:00/0000:00:1c.4
    drwxr-xr-x  2 root root    0 26 okt 22:12 power
    -r--r--r--  1 root root 4096 26 okt 22:10 power_state
    lrwxrwxrwx  1 root root    0 26 okt 22:10 subsystem -> ../../../../../bus/acpi
    -rw-r--r--  1 root root 4096 26 okt 22:10 uevent

    ./device:32:
    totaal 0
    -r--r--r-- 1 root root 4096 26 okt 22:12 adr
    -r--r--r-- 1 root root 4096 26 okt 22:12 path
    drwxr-xr-x 2 root root    0 26 okt 22:31 power
    lrwxrwxrwx 1 root root    0 26 okt 22:10 subsystem -> ../../../../../../bus/acpi
    -rw-r--r-- 1 root root 4096 26 okt 22:12 uevent

    ./device:32/power:
    totaal 0
    -rw-r--r-- 1 root root 4096 26 okt 22:12 async
    -rw-r--r-- 1 root root 4096 26 okt 22:12 autosuspend_delay_ms
    -rw-r--r-- 1 root root 4096 26 okt 22:12 control
    -r--r--r-- 1 root root 4096 26 okt 22:12 runtime_active_kids
    -r--r--r-- 1 root root 4096 26 okt 22:12 runtime_active_time
    -r--r--r-- 1 root root 4096 26 okt 22:12 runtime_enabled
    -r--r--r-- 1 root root 4096 26 okt 22:12 runtime_status
    -r--r--r-- 1 root root 4096 26 okt 22:12 runtime_suspended_time
    -r--r--r-- 1 root root 4096 26 okt 22:12 runtime_usage

    ./LNXVIDEO:00:
    totaal 0
    -r--r--r-- 1 root root 4096 26 okt 22:31 adr
    drwxr-xr-x 3 root root    0 26 okt 22:31 device:33
    drwxr-xr-x 3 root root    0 26 okt 22:31 device:34
    drwxr-xr-x 3 root root    0 26 okt 22:31 device:35
    drwxr-xr-x 3 root root    0 26 okt 22:31 device:36
    drwxr-xr-x 3 root root    0 26 okt 22:31 device:37
    drwxr-xr-x 3 root root    0 26 okt 22:31 device:38
    drwxr-xr-x 3 root root    0 26 okt 22:31 device:39
    drwxr-xr-x 3 root root    0 26 okt 22:31 device:3a
    lrwxrwxrwx 1 root root    0 26 okt 22:10 driver -> ../../../../../../bus/acpi/drivers/video
    -r--r--r-- 1 root root 4096 26 okt 22:31 hid
    drwxr-xr-x 3 root root    0 26 okt 22:31 input
    -r--r--r-- 1 root root 4096 26 okt 22:31 modalias
    -r--r--r-- 1 root root 4096 26 okt 22:31 path
    lrwxrwxrwx 1 root root    0 26 okt 22:31 physical_node -> ../../../../../pci0000:00/0000:00:1c.4/0000:01:00.0
    drwxr-xr-x 2 root root    0 26 okt 22:31 power
    -r--r--r-- 1 root root 4096 26 okt 22:31 power_state
    -r--r--r-- 1 root root 4096 26 okt 22:31 status
    lrwxrwxrwx 1 root root    0 26 okt 22:10 subsystem -> ../../../../../../bus/acpi
    -rw-r--r-- 1 root root 4096 26 okt 22:31 uevent

    ./LNXVIDEO:00/device:33:
    totaal 0
    -r--r--r-- 1 root root 4096 26 okt 22:31 adr
    -r--r--r-- 1 root root 4096 26 okt 22:31 path
    drwxr-xr-x 2 root root    0 26 okt 22:31 power
    lrwxrwxrwx 1 root root    0 26 okt 22:10 subsystem -> ../../../../../../../bus/acpi
    -rw-r--r-- 1 root root 4096 26 okt 22:31 uevent

    ./LNXVIDEO:00/device:33/power:
    totaal 0
    -rw-r--r-- 1 root root 4096 26 okt 22:31 async
    -rw-r--r-- 1 root root 4096 26 okt 22:31 autosuspend_delay_ms
    -rw-r--r-- 1 root root 4096 26 okt 22:31 control
    -r--r--r-- 1 root root 4096 26 okt 22:31 runtime_active_kids
    -r--r--r-- 1 root root 4096 26 okt 22:31 runtime_active_time
    -r--r--r-- 1 root root 4096 26 okt 22:31 runtime_enabled
    -r--r--r-- 1 root root 4096 26 okt 22:31 runtime_status
    -r--r--r-- 1 root root 4096 26 okt 22:31 runtime_suspended_time
    -r--r--r-- 1 root root 4096 26 okt 22:31 runtime_usage

    ./LNXVIDEO:00/device:34:
    totaal 0
    -r--r--r-- 1 root root 4096 26 okt 22:31 adr
    -r--r--r-- 1 root root 4096 26 okt 22:31 path
    drwxr-xr-x 2 root root    0 26 okt 22:31 power
    lrwxrwxrwx 1 root root    0 26 okt 22:10 subsystem -> ../../../../../../../bus/acpi
    -rw-r--r-- 1 root root 4096 26 okt 22:31 uevent

    ./LNXVIDEO:00/device:34/power:
    totaal 0
    -rw-r--r-- 1 root root 4096 26 okt 22:31 async
    -rw-r--r-- 1 root root 4096 26 okt 22:31 autosuspend_delay_ms
    -rw-r--r-- 1 root root 4096 26 okt 22:31 control
    -r--r--r-- 1 root root 4096 26 okt 22:31 runtime_active_kids
    -r--r--r-- 1 root root 4096 26 okt 22:31 runtime_active_time
    -r--r--r-- 1 root root 4096 26 okt 22:31 runtime_enabled
    -r--r--r-- 1 root root 4096 26 okt 22:31 runtime_status
    -r--r--r-- 1 root root 4096 26 okt 22:31 runtime_suspended_time
    -r--r--r-- 1 root root 4096 26 okt 22:31 runtime_usage

    ./LNXVIDEO:00/device:35:
    totaal 0
    -r--r--r-- 1 root root 4096 26 okt 22:31 adr
    -r--r--r-- 1 root root 4096 26 okt 22:31 path
    drwxr-xr-x 2 root root    0 26 okt 22:31 power
    lrwxrwxrwx 1 root root    0 26 okt 22:10 subsystem -> ../../../../../../../bus/acpi
    -rw-r--r-- 1 root root 4096 26 okt 22:31 uevent

    ./LNXVIDEO:00/device:35/power:
    totaal 0
    -rw-r--r-- 1 root root 4096 26 okt 22:31 async
    -rw-r--r-- 1 root root 4096 26 okt 22:31 autosuspend_delay_ms
    -rw-r--r-- 1 root root 4096 26 okt 22:31 control
    -r--r--r-- 1 root root 4096 26 okt 22:31 runtime_active_kids
    -r--r--r-- 1 root root 4096 26 okt 22:31 runtime_active_time
    -r--r--r-- 1 root root 4096 26 okt 22:31 runtime_enabled
    -r--r--r-- 1 root root 4096 26 okt 22:31 runtime_status
    -r--r--r-- 1 root root 4096 26 okt 22:31 runtime_suspended_time
    -r--r--r-- 1 root root 4096 26 okt 22:31 runtime_usage

    ./LNXVIDEO:00/device:36:
    totaal 0
    -r--r--r-- 1 root root 4096 26 okt 22:31 adr
    -r--r--r-- 1 root root 4096 26 okt 22:31 path
    drwxr-xr-x 2 root root    0 26 okt 22:31 power
    lrwxrwxrwx 1 root root    0 26 okt 22:10 subsystem -> ../../../../../../../bus/acpi
    -rw-r--r-- 1 root root 4096 26 okt 22:31 uevent

    ./LNXVIDEO:00/device:36/power:
    totaal 0
    -rw-r--r-- 1 root root 4096 26 okt 22:31 async
    -rw-r--r-- 1 root root 4096 26 okt 22:31 autosuspend_delay_ms
    -rw-r--r-- 1 root root 4096 26 okt 22:31 control
    -r--r--r-- 1 root root 4096 26 okt 22:31 runtime_active_kids
    -r--r--r-- 1 root root 4096 26 okt 22:31 runtime_active_time
    -r--r--r-- 1 root root 4096 26 okt 22:31 runtime_enabled
    -r--r--r-- 1 root root 4096 26 okt 22:31 runtime_status
    -r--r--r-- 1 root root 4096 26 okt 22:31 runtime_suspended_time
    -r--r--r-- 1 root root 4096 26 okt 22:31 runtime_usage

    ./LNXVIDEO:00/device:37:
    totaal 0
    -r--r--r-- 1 root root 4096 26 okt 22:31 adr
    -r--r--r-- 1 root root 4096 26 okt 22:31 path
    drwxr-xr-x 2 root root    0 26 okt 22:31 power
    lrwxrwxrwx 1 root root    0 26 okt 22:10 subsystem -> ../../../../../../../bus/acpi
    -rw-r--r-- 1 root root 4096 26 okt 22:31 uevent

    ./LNXVIDEO:00/device:37/power:
    totaal 0
    -rw-r--r-- 1 root root 4096 26 okt 22:31 async
    -rw-r--r-- 1 root root 4096 26 okt 22:31 autosuspend_delay_ms
    -rw-r--r-- 1 root root 4096 26 okt 22:31 control
    -r--r--r-- 1 root root 4096 26 okt 22:31 runtime_active_kids
    -r--r--r-- 1 root root 4096 26 okt 22:31 runtime_active_time
    -r--r--r-- 1 root root 4096 26 okt 22:31 runtime_enabled
    -r--r--r-- 1 root root 4096 26 okt 22:31 runtime_status
    -r--r--r-- 1 root root 4096 26 okt 22:31 runtime_suspended_time
    -r--r--r-- 1 root root 4096 26 okt 22:31 runtime_usage

    ./LNXVIDEO:00/device:38:
    totaal 0
    -r--r--r-- 1 root root 4096 26 okt 22:31 adr
    -r--r--r-- 1 root root 4096 26 okt 22:31 path
    drwxr-xr-x 2 root root    0 26 okt 22:31 power
    lrwxrwxrwx 1 root root    0 26 okt 22:10 subsystem -> ../../../../../../../bus/acpi
    -rw-r--r-- 1 root root 4096 26 okt 22:31 uevent

    ./LNXVIDEO:00/device:38/power:
    totaal 0
    -rw-r--r-- 1 root root 4096 26 okt 22:31 async
    -rw-r--r-- 1 root root 4096 26 okt 22:31 autosuspend_delay_ms
    -rw-r--r-- 1 root root 4096 26 okt 22:31 control
    -r--r--r-- 1 root root 4096 26 okt 22:31 runtime_active_kids
    -r--r--r-- 1 root root 4096 26 okt 22:31 runtime_active_time
    -r--r--r-- 1 root root 4096 26 okt 22:31 runtime_enabled
    -r--r--r-- 1 root root 4096 26 okt 22:31 runtime_status
    -r--r--r-- 1 root root 4096 26 okt 22:31 runtime_suspended_time
    -r--r--r-- 1 root root 4096 26 okt 22:31 runtime_usage

    ./LNXVIDEO:00/device:39:
    totaal 0
    -r--r--r-- 1 root root 4096 26 okt 22:31 adr
    -r--r--r-- 1 root root 4096 26 okt 22:31 path
    drwxr-xr-x 2 root root    0 26 okt 22:31 power
    lrwxrwxrwx 1 root root    0 26 okt 22:10 subsystem -> ../../../../../../../bus/acpi
    -rw-r--r-- 1 root root 4096 26 okt 22:31 uevent

    ./LNXVIDEO:00/device:39/power:
    totaal 0
    -rw-r--r-- 1 root root 4096 26 okt 22:31 async
    -rw-r--r-- 1 root root 4096 26 okt 22:31 autosuspend_delay_ms
    -rw-r--r-- 1 root root 4096 26 okt 22:31 control
    -r--r--r-- 1 root root 4096 26 okt 22:31 runtime_active_kids
    -r--r--r-- 1 root root 4096 26 okt 22:31 runtime_active_time
    -r--r--r-- 1 root root 4096 26 okt 22:31 runtime_enabled
    -r--r--r-- 1 root root 4096 26 okt 22:31 runtime_status
    -r--r--r-- 1 root root 4096 26 okt 22:31 runtime_suspended_time
    -r--r--r-- 1 root root 4096 26 okt 22:31 runtime_usage

    ./LNXVIDEO:00/device:3a:
    totaal 0
    -r--r--r-- 1 root root 4096 26 okt 22:31 adr
    -r--r--r-- 1 root root 4096 26 okt 22:31 path
    drwxr-xr-x 2 root root    0 26 okt 22:31 power
    lrwxrwxrwx 1 root root    0 26 okt 22:10 subsystem -> ../../../../../../../bus/acpi
    -rw-r--r-- 1 root root 4096 26 okt 22:31 uevent

    ./LNXVIDEO:00/device:3a/power:
    totaal 0
    -rw-r--r-- 1 root root 4096 26 okt 22:31 async
    -rw-r--r-- 1 root root 4096 26 okt 22:31 autosuspend_delay_ms
    -rw-r--r-- 1 root root 4096 26 okt 22:31 control
    -r--r--r-- 1 root root 4096 26 okt 22:31 runtime_active_kids
    -r--r--r-- 1 root root 4096 26 okt 22:31 runtime_active_time
    -r--r--r-- 1 root root 4096 26 okt 22:31 runtime_enabled
    -r--r--r-- 1 root root 4096 26 okt 22:31 runtime_status
    -r--r--r-- 1 root root 4096 26 okt 22:31 runtime_suspended_time
    -r--r--r-- 1 root root 4096 26 okt 22:31 runtime_usage

    ./LNXVIDEO:00/input:
    totaal 0
    drwxr-xr-x 6 root root 0 26 okt 22:31 input4

    ./LNXVIDEO:00/input/input4:
    totaal 0
    drwxr-xr-x 2 root root    0 26 okt 22:31 capabilities
    lrwxrwxrwx 1 root root    0 26 okt 22:31 device -> ../../../LNXVIDEO:00
    drwxr-xr-x 3 root root    0 26 okt 22:31 event4
    drwxr-xr-x 2 root root    0 26 okt 22:31 id
    -r--r--r-- 1 root root 4096 26 okt 22:31 modalias
    -r--r--r-- 1 root root 4096 26 okt 22:31 name
    -r--r--r-- 1 root root 4096 26 okt 22:31 phys
    drwxr-xr-x 2 root root    0 26 okt 22:31 power
    -r--r--r-- 1 root root 4096 26 okt 22:31 properties
    lrwxrwxrwx 1 root root    0 26 okt 22:10 subsystem -> ../../../../../../../../class/input
    -rw-r--r-- 1 root root 4096 26 okt 22:31 uevent
    -r--r--r-- 1 root root 4096 26 okt 22:31 uniq

    ./LNXVIDEO:00/input/input4/capabilities:
    totaal 0
    -r--r--r-- 1 root root 4096 26 okt 22:31 abs
    -r--r--r-- 1 root root 4096 26 okt 22:31 ev
    -r--r--r-- 1 root root 4096 26 okt 22:31 ff
    -r--r--r-- 1 root root 4096 26 okt 22:31 key
    -r--r--r-- 1 root root 4096 26 okt 22:31 led
    -r--r--r-- 1 root root 4096 26 okt 22:31 msc
    -r--r--r-- 1 root root 4096 26 okt 22:31 rel
    -r--r--r-- 1 root root 4096 26 okt 22:31 snd
    -r--r--r-- 1 root root 4096 26 okt 22:31 sw

    ./LNXVIDEO:00/input/input4/event4:
    totaal 0
    -r--r--r-- 1 root root 4096 26 okt 22:31 dev
    lrwxrwxrwx 1 root root    0 26 okt 22:31 device -> ../../input4
    drwxr-xr-x 2 root root    0 26 okt 22:31 power
    lrwxrwxrwx 1 root root    0 26 okt 22:10 subsystem -> ../../../../../../../../../class/input
    -rw-r--r-- 1 root root 4096 26 okt 22:31 uevent

    ./LNXVIDEO:00/input/input4/event4/power:
    totaal 0
    -rw-r--r-- 1 root root 4096 26 okt 22:31 async
    -rw-r--r-- 1 root root 4096 26 okt 22:31 autosuspend_delay_ms
    -rw-r--r-- 1 root root 4096 26 okt 22:31 control
    -r--r--r-- 1 root root 4096 26 okt 22:31 runtime_active_kids
    -r--r--r-- 1 root root 4096 26 okt 22:31 runtime_active_time
    -r--r--r-- 1 root root 4096 26 okt 22:31 runtime_enabled
    -r--r--r-- 1 root root 4096 26 okt 22:31 runtime_status
    -r--r--r-- 1 root root 4096 26 okt 22:31 runtime_suspended_time
    -r--r--r-- 1 root root 4096 26 okt 22:31 runtime_usage

    ./LNXVIDEO:00/input/input4/id:
    totaal 0
    -r--r--r-- 1 root root 4096 26 okt 22:31 bustype
    -r--r--r-- 1 root root 4096 26 okt 22:31 product
    -r--r--r-- 1 root root 4096 26 okt 22:31 vendor
    -r--r--r-- 1 root root 4096 26 okt 22:31 version

    ./LNXVIDEO:00/input/input4/power:
    totaal 0
    -rw-r--r-- 1 root root 4096 26 okt 22:31 async
    -rw-r--r-- 1 root root 4096 26 okt 22:31 autosuspend_delay_ms
    -rw-r--r-- 1 root root 4096 26 okt 22:31 control
    -r--r--r-- 1 root root 4096 26 okt 22:31 runtime_active_kids
    -r--r--r-- 1 root root 4096 26 okt 22:31 runtime_active_time
    -r--r--r-- 1 root root 4096 26 okt 22:31 runtime_enabled
    -r--r--r-- 1 root root 4096 26 okt 22:31 runtime_status
    -r--r--r-- 1 root root 4096 26 okt 22:31 runtime_suspended_time
    -r--r--r-- 1 root root 4096 26 okt 22:31 runtime_usage

    ./LNXVIDEO:00/power:
    totaal 0
    -rw-r--r-- 1 root root 4096 26 okt 22:31 async
    -rw-r--r-- 1 root root 4096 26 okt 22:31 autosuspend_delay_ms
    -rw-r--r-- 1 root root 4096 26 okt 22:31 control
    -r--r--r-- 1 root root 4096 26 okt 22:31 runtime_active_kids
    -r--r--r-- 1 root root 4096 26 okt 22:31 runtime_active_time
    -r--r--r-- 1 root root 4096 26 okt 22:31 runtime_enabled
    -r--r--r-- 1 root root 4096 26 okt 22:31 runtime_status
    -r--r--r-- 1 root root 4096 26 okt 22:31 runtime_suspended_time
    -r--r--r-- 1 root root 4096 26 okt 22:31 runtime_usage

    ./power:
    totaal 0
    -rw-r--r-- 1 root root 4096 26 okt 22:11 async
    -rw-r--r-- 1 root root 4096 26 okt 22:11 autosuspend_delay_ms
    -rw-r--r-- 1 root root 4096 26 okt 22:11 control
    -r--r--r-- 1 root root 4096 26 okt 22:11 runtime_active_kids
    -r--r--r-- 1 root root 4096 26 okt 22:11 runtime_active_time
    -r--r--r-- 1 root root 4096 26 okt 22:11 runtime_enabled
    -r--r--r-- 1 root root 4096 26 okt 22:11 runtime_status
    -r--r--r-- 1 root root 4096 26 okt 22:11 runtime_suspended_time
    -r--r--r-- 1 root root 4096 26 okt 22:11 runtime_usage
-- 
Kind regards,
Peter Wu
https://lekensteyn.nl
