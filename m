Return-Path: <emil.l.velikov@gmail.com>
Return-Path: <emil.l.velikov@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20161111144917.GA5138@bhelgaas-glaptop.roam.corp.google.com>
References: <20161101154232.6451-1-emil.l.velikov@gmail.com>
 <20161109165607.26322-1-emil.l.velikov@gmail.com> <20161110071327.GA30661@kroah.com>
 <CACvgo50m+nNhfUOmB_vw1ScMXDteG+fXU6D5G6D+suiH85Digw@mail.gmail.com>
 <20161110235931.GB12055@bhelgaas-glaptop.roam.corp.google.com>
 <CACvgo53i4zTROE7=6_=G4ryVVBoUZLDZ=arQjpmzk2A62kEqbA@mail.gmail.com> <20161111144917.GA5138@bhelgaas-glaptop.roam.corp.google.com>
From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Fri, 11 Nov 2016 18:56:51 +0000
Message-ID: <CACvgo50V+wcibUHkpdsFJa_q+K2=k1T2UzsJ2gmdc3NGo+7qUQ@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: create revision file in sysfs
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	ML dri-devel <dri-devel@lists.freedesktop.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On 11 November 2016 at 14:49, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Fri, Nov 11, 2016 at 12:31:47AM +0000, Emil Velikov wrote:
>> On 10 November 2016 at 23:59, Bjorn Helgaas <helgaas@kernel.org> wrote:
>> > Hi Emil,
>> >
>> > On Thu, Nov 10, 2016 at 01:14:35PM +0000, Emil Velikov wrote:
>> >> On 10 November 2016 at 07:13, Greg KH <gregkh@linuxfoundation.org> wrote:
>> >> > On Wed, Nov 09, 2016 at 04:56:07PM +0000, Emil Velikov wrote:
>> >> >> From: Emil Velikov <emil.velikov@collabora.com>
>> >> >>
>> >> >> Currently the revision isn't available via sysfs/libudev thus if one
>> >> >> wants to know the value they need to read through the config file.
>> >> >>
>> >> >> This in itself wakes/powers up the device, causing unwanted delays.
>> >> >>
>> >> >> There are at least two userspace components which could make use the new
>> >> >> file - libpciaccess and libdrm. At the moment the former will wake up
>> >> >> _every_ PCI device for simple invocation of glxinfo [when using Mesa
>> >> >> 10.0+ drivers]. While the latter [in association with Mesa 13.0] can
>> >> >> lead to 2-3 second delays while starting firefox, thunderbird or
>> >> >> chromium.
>> >
>> > I agree, these unwanted delays are completely unacceptable.  My
>> > question is whether we should fix them by exporting more information
>> > from the kernel, or by changing the way the userspace components work.
>> >
>> > It should not take anywhere near 2 seconds to wake up a PCI device.
>> > That makes me think there's a more serious problem than just a lack of
>> > caching for the revision field, e.g., maybe we're looking at far more
>> > PCI devices than we need to, or we're doing it many times to the same
>> > device, or ...
>> >
>> > If I understand correctly, the delay was bisected to
>> > https://cgit.freedesktop.org/mesa/mesa/commit/?id=be239326aa4f, which
>> > removed a bunch of code that looked up the vendor and device IDs, and
>> > replaced it with drmGetDevice().  And apparently drmGetDevice(), in
>> > this path:
>> >
>> >   drmGetDevice
>> >     drmProcessPciDevice
>> >       drmParsePciDeviceInfo
>> >
>> > is a little more thorough in that it looks up the *revision* in
>> > addition to the vendor and device IDs.  So we pay the cost for the
>> > revision even though in this instance we don't care about the revision
>> > at all.
>> >
>> Above all, apologies for all the "lovely" code that you had to go
>> through for these.
>> And yes, you've got it spot on.
>>
>> > drmParsePciDeviceInfo() currently reads the whole config header from
>> > sysfs (https://cgit.freedesktop.org/drm/libdrm/tree/xf86drm.c#n2949),
>> > but I think you're extending that to try the vendor, device,
>> > subsystem_vendor, subsystem_device, and (if present) revision sysfs
>> > files first (http://www.spinics.net/lists/dri-devel/msg122319.html).
>> >
>> Yes, making the revision file optional and "faking it" was my first
>> thought, esp. since we don't have any users of it (yet).
>> Although people are not too keen on it, so we'll likely opt for
>> revision-less API.
>>
>> > Bottom line, I guess I'm not super opposed to this, but I do feel like
>> > we're making a kernel change to cover up a userspace problem, and I
>> > think it would be better to push on that userspace problem a little
>> > more.
>> >
>> Yes, definitely we can beat some sense into userspace. Yet that
>> shouldn't be a deterrent for exposing the revision.
>
> Maybe.  If we speed things up by extending this kernel ABI, there's
> much less incentive to optimize the userspace stuff.  I feel a little
> bit like an enabler for undesirable userspace behavior :)
>
Yes, fixing userspace to not do silly things is the goal. But at the
same time even if userspace is perfect, there is no reason to power on
the device just to get the revision field, is it ?
Especially since everything else is readily available.

>> As hinted before the other prominent user libpciaccess wakes up probes
>> _every_ pci device.
>
> Is it really necessary to probe *every* PCI device?  That doesn't
> sound like a scalable design.
>
> As you can tell, the argument that "we should add this kernel ABI to
> make suboptimal userspace algorithms go faster" doesn't feel very
> compelling to me.
>
"Don't shoot the messenger" comes to mind. I'm just the stupid^Wnice
person who's trying to untangle unfortunate design decisions - don't
force me to rewrite more than a dozen pieces of software, please ?
Even then, I wonder how long it'll take for those to hit end users.

Yes I see your concern - userspace does do stupid stuff. Yet it
[sometimes] must know the information and the current way of
retrieving it (waking up the device) is quite sub-optimal.

Thanks
Emil
P.S. Some drivers have custom ioctls to retrieve the device info
(incl. revision). Surely we won't want to continue promoting/assisting
that ?
