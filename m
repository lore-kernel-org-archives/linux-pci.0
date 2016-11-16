Return-Path: <okaya@codeaurora.org>
Return-Path: <okaya@codeaurora.org>
Subject: Re: [PATCH v3] PCI: create revision file in sysfs
To: Bjorn Helgaas <helgaas@kernel.org>, Daniel Vetter <daniel@ffwll.ch>
References: <20161101154232.6451-1-emil.l.velikov@gmail.com>
 <20161111143723.5818-1-emil.l.velikov@gmail.com>
 <20161114184003.gdkd4kkiet2qqe7s@phenom.ffwll.local>
 <20161116205811.GE26600@bhelgaas-glaptop.roam.corp.google.com>
Cc: Emil Velikov <emil.l.velikov@gmail.com>, dri-devel@lists.freedesktop.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 Greg KH <gregkh@linuxfoundation.org>, Lukas Wunner <lukas@wunner.de>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <dcd8d9fe-ea1d-45b8-2528-adb75a9ba3ed@codeaurora.org>
Date: Wed, 16 Nov 2016 16:30:16 -0500
MIME-Version: 1.0
In-Reply-To: <20161116205811.GE26600@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

On 11/16/2016 3:58 PM, Bjorn Helgaas wrote:
> [+cc Sinan, Lukas]
> 
> Hi Daniel,
> 
> On Mon, Nov 14, 2016 at 07:40:03PM +0100, Daniel Vetter wrote:
>> On Fri, Nov 11, 2016 at 02:37:23PM +0000, Emil Velikov wrote:
>>> From: Emil Velikov <emil.velikov@collabora.com>
>>>
>>> Currently the revision isn't available via sysfs/libudev thus if one
>>> wants to know the value they need to read through the config file.
>>>
>>> This in itself wakes/powers up the device, causing unwanted delay
>>> since it can be quite costly.
>>>
>>> There are at least two userspace components which could make use the new
>>> file libpciaccess and libdrm. The former [used in various places] wakes
>>> up _every_ PCI device, which can be observed via glxinfo [when using
>>> Mesa 10.0+ drivers]. While the latter [in association with Mesa 13.0]
>>> can lead to 2-3 second delays while starting firefox, thunderbird or
>>> chromium.
>>>
>>> Expose the revision as a separate file, just like we do for the device,
>>> vendor, their subsystem version and class.
>>>
>>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>>> Cc: linux-pci@vger.kernel.org
>>> Cc: Greg KH <gregkh@linuxfoundation.org>
>>> Link: https://bugs.freedesktop.org/show_bug.cgi?id=98502
>>> Tested-by: Mauro Santos <registo.mailling@gmail.com>
>>> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>>> Signed-off-by: Emil Velikov <emil.velikov@collabora.com>
>>
>> Given that waking a gpu can take somewhere between ages and forever, and
>> that we read the pci revisions everytime we launch a new gl app I think
>> this is the correct approach. Of course we could just patch libdrm and
>> everyone to not look at the pci revision, but that just leads to every
>> pci-based driver having a driver-private ioctl/getparam thing to expose
>> it. Which also doesn't make much sense.
> 
> This re-asserts what has already been said, but doesn't address any of
> my questions in the v2 discussion, so I'm still looking to continue
> that thread.
> 
> I am curious about this long wakeup issue, though.  Are we talking
> about a D3cold -> D0 transition?  I assume so, since config space is
> generally accessible in all power states except D3cold.  From the
> device's point of view this is basically like a power-on.  I think the
> gist of PCIe r3.0, sec 6.6.1 is that we need to wait 100ms, e.g.,
> PCI_PM_D3COLD_WAIT, before doing config accesses.
> 
> We do support Configuration Request Retry Status Software Visibility
> (pci_enable_crs()), so a device *can* take longer than 100ms after
> power-up to respond to a config read, but I think that only applies to
> reads of the Vendor ID.  I cc'd Sinan because we do have some issues
> with our CRS support, and maybe he can shed some light on this.

This applies to all config requests including vendor ID. It is just the
vendor ID returns a special code (device id = 0x0001 vendor id =0xffff) so
that CRS aware software can understand the difference between CRS and an
actual failure. It is recommended to always read the vendor ID following
a reset/power on to understand if the device is sending a CRS.

As Bjorn mentioned, we do enable CRS visibility in the kernel but only for
the root port in pci_enable_crs function. When CRS visibility is disabled,
root port needs to retry the request until a good response is received.

CRS polling happens behind the scenes in pci_bus_read_dev_vendor_id function.

In order for reads to take longer than 100ms, the CRS must be disabled at
a lower level in the bus. 

I wonder if you have a bridge between your device and the root port.

Bridge Configuration Retry Enable needs to be programmed if we want kernel
to know about retry responses behind a bridge. 

"Bridge Configuration Retry Enable – When Set, this bit enables PCI Express
to PCI/PCI-X bridges to return Configuration Request Retry Status (CRS) in
response to Configuration Requests that target devices below the bridge. Refer
to the PCI Express to PCI/PCI-X Bridge Specification, Revision 1.0 for
further details. Default value of this bit is 0b."

Kernel is currently not setting this.

> 
> I'm not surprised if a GPU takes longer than 100ms to do device-
> specific, driver-managed, non-PCI things like detect and wake up
> monitors.  But I *am* surprised if generic PCI bus-level things like
> config reads take longer than that.  I also cc'd Lukas because he
> knows a lot more about PCI PM than I do.
> 
> Bjorn
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
