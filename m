Return-Path: <SRS0=QzeJ=5O=vodafone.de=deathsimple@kernel.org>
Return-Path: <SRS0=QzeJ=5O=vodafone.de=deathsimple@kernel.org>
Subject: Re: [PATCH v6 5/5] drm/amdgpu: resize VRAM BAR for CPU access v2
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@linux.ie>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <1494348547-1465-1-git-send-email-deathsimple@vodafone.de>
 <1494348547-1465-6-git-send-email-deathsimple@vodafone.de>
 <20170601201430.GC12257@bhelgaas-glaptop.roam.corp.google.com>
 <72e061a5-9684-06e2-3021-80de8ca97bd7@vodafone.de>
 <20170602202631.GA1452@bhelgaas-glaptop.roam.corp.google.com>
 <779a883a-265a-ae04-b0cd-8cb3599f0dc0@vodafone.de>
 <20170606231019.GC12672@bhelgaas-glaptop.roam.corp.google.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple@vodafone.de>
Message-ID: <55fb9500-5062-78ea-93c3-0f3e850dd31f@vodafone.de>
Date: Fri, 9 Jun 2017 10:59:38 +0200
MIME-Version: 1.0
In-Reply-To: <20170606231019.GC12672@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Am 07.06.2017 um 01:10 schrieb Bjorn Helgaas:
> [SNIP]
> What if the driver did something like this:
>
>    pci_disable_decoding(dev, IORESOURCE_MEM);
>    pci_release_resource(dev, 2);
>    pci_resize_bar(dev, bar, size);
>    pci_assign_resources(dev);
>    pci_enable_decoding(dev, IORESOURCE_MEM);
>
> That would require adding pci_enable/disable_decoding() to the driver
> API, along with the requirement that the driver discard and remap
> some resources after pci_enable_decoding().  I think
> pci_enable_decoding() would look much like the existing
> pci_enable_resources() except taking a resource type instead of a
> bitmask.

This is pretty close to what we already do. I'm going to send out an 
updated version of the patch in a minute.

One difference that I still have in this patch is
> +       pci_read_config_word(adev->pdev, PCI_COMMAND, &cmd);
> +       pci_write_config_word(adev->pdev, PCI_COMMAND,
> +                             cmd & ~PCI_COMMAND_MEMORY);
in the driver instead of "pci_disable_decoding(dev, IORESOURCE_MEM);"

I thought that introducing a new interface for this two lines would be 
overkill, but if you find it cleaner to add the new interface I can 
change that.

> I would *prefer* if we released and reassigned all resources, because
> then the core has complete flexibility to move things around, and it's
> easy to document that pci_assign_resources() means you have to
> reread/remap everything.
I've tried this and it doesn't work at all, surprisingly the I/O ports 
turned out to be not the first problem I've ran into.

Releasing all resources means that we also try to release the 
0xa000-0xbffff (VGA) and 0xc0000-0xdffff (VBIOS) ranges.

They can be reassigned, but somehow that seems to cause problems later on.

> If the driver only releases specified BARs, the pci_assign_resources()
> interface becomes "you need to reread/remap the BAR you resized, plus
> any other BARs you released".  It's a little more complicated to
> describe and more dependent on previous driver actions.
How about the driver releases all resources it wants to move, including 
the resized and reallocates them after the resize is done?

>
> But releasing only the specified BAR will make your life easier and
> help with the fact that multiple drivers might be using the same BAR
> (I have to raise my eyebrows at that), so I think I'm OK with it.  And
> it would also side-step the "can't restore previous state" problem.
I agree that it is a bit more documentation work to describe how the 
interface works, but it is clearly less problematic during runtime.

Please take a look at the new version of the patches and let me know 
what you think.

Regards,
Christian.

>
> It's an "interesting" asymmetry that pci_enable_device() turns on BAR
> decoding but doesn't touch bus mastering, while pci_disable_device()
> turns off bus mastering but doesn't touch BAR decoding.
>
> Bjorn
