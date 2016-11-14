Return-Path: <michel@daenzer.net>
Return-Path: <michel@daenzer.net>
Subject: Re: [PATCH v2] PCI: create revision file in sysfs
To: Bjorn Helgaas <helgaas@kernel.org>,
 Emil Velikov <emil.l.velikov@gmail.com>
References: <20161101154232.6451-1-emil.l.velikov@gmail.com>
 <20161109165607.26322-1-emil.l.velikov@gmail.com>
 <20161110071327.GA30661@kroah.com>
 <CACvgo50m+nNhfUOmB_vw1ScMXDteG+fXU6D5G6D+suiH85Digw@mail.gmail.com>
 <20161110235931.GB12055@bhelgaas-glaptop.roam.corp.google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Greg KH
 <gregkh@linuxfoundation.org>, ML dri-devel
 <dri-devel@lists.freedesktop.org>, Linux PCI <linux-pci@vger.kernel.org>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Message-ID: <16411399-cb4a-127b-d71d-74bc7dfd4f3d@daenzer.net>
Date: Mon, 14 Nov 2016 12:35:19 +0900
MIME-Version: 1.0
In-Reply-To: <20161110235931.GB12055@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 11/11/16 08:59 AM, Bjorn Helgaas wrote:
> On Thu, Nov 10, 2016 at 01:14:35PM +0000, Emil Velikov wrote:
>> On 10 November 2016 at 07:13, Greg KH <gregkh@linuxfoundation.org> wrote:
>>> On Wed, Nov 09, 2016 at 04:56:07PM +0000, Emil Velikov wrote:
>>>> From: Emil Velikov <emil.velikov@collabora.com>
>>>>
>>>> Currently the revision isn't available via sysfs/libudev thus if one
>>>> wants to know the value they need to read through the config file.
>>>>
>>>> This in itself wakes/powers up the device, causing unwanted delays.
>>>>
>>>> There are at least two userspace components which could make use the new
>>>> file - libpciaccess and libdrm. At the moment the former will wake up
>>>> _every_ PCI device for simple invocation of glxinfo [when using Mesa
>>>> 10.0+ drivers]. While the latter [in association with Mesa 13.0] can
>>>> lead to 2-3 second delays while starting firefox, thunderbird or
>>>> chromium.
> 
> I agree, these unwanted delays are completely unacceptable.  My
> question is whether we should fix them by exporting more information
> from the kernel, or by changing the way the userspace components work.
> 
> It should not take anywhere near 2 seconds to wake up a PCI device.

The DRM drivers for AMD/ATI GPUs can take on the order of that to
initialize, so a single wakeup might be sufficient for the described
symptoms.


-- 
Earthling Michel Dänzer               |               http://www.amd.com
Libre software enthusiast             |             Mesa and X developer
