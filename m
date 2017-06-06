Return-Path: <SRS0=ejJQ=5L=gmail.com=alexdeucher@kernel.org>
Return-Path: <SRS0=ejJQ=5L=gmail.com=alexdeucher@kernel.org>
MIME-Version: 1.0
In-Reply-To: <779a883a-265a-ae04-b0cd-8cb3599f0dc0@vodafone.de>
References: <1494348547-1465-1-git-send-email-deathsimple@vodafone.de>
 <1494348547-1465-6-git-send-email-deathsimple@vodafone.de>
 <20170601201430.GC12257@bhelgaas-glaptop.roam.corp.google.com>
 <72e061a5-9684-06e2-3021-80de8ca97bd7@vodafone.de> <20170602202631.GA1452@bhelgaas-glaptop.roam.corp.google.com>
 <779a883a-265a-ae04-b0cd-8cb3599f0dc0@vodafone.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 6 Jun 2017 09:53:34 -0400
Message-ID: <CADnq5_POq7LpSDLBQxPaggnH2b9FzmndwKTe2xsiJtHcPdujyQ@mail.gmail.com>
Subject: Re: [PATCH v6 5/5] drm/amdgpu: resize VRAM BAR for CPU access v2
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <deathsimple@vodafone.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, David Airlie <airlied@linux.ie>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Maling list - DRI developers <dri-devel@lists.freedesktop.org>, platform-driver-x86@vger.kernel.org,
	amd-gfx list <amd-gfx@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 6, 2017 at 7:51 AM, Christian K=C3=B6nig <deathsimple@vodafone.=
de> wrote:
> Am 02.06.2017 um 22:26 schrieb Bjorn Helgaas:
>>
>> On Fri, Jun 02, 2017 at 11:32:21AM +0200, Christian K=C3=B6nig wrote:
>>>
>>> Hi Bjorn,
>>>
>>> sorry for not responding earlier and thanks for picking this thread
>>> up again.
>>>
>>> Am 01.06.2017 um 22:14 schrieb Bjorn Helgaas:
>>>>
>>>> [+cc ADMGPU, DRM folks]
>>>>
>>>> On Tue, May 09, 2017 at 06:49:07PM +0200, Christian K=C3=B6nig wrote:
>>>>>
>>>>> [SNIP]
>>>>> +/**
>>>>> + * amdgpu_resize_bar0 - try to resize BAR0
>>>>> + *
>>>>> + * @adev: amdgpu_device pointer
>>>>> + *
>>>>> + * Try to resize BAR0 to make all VRAM CPU accessible.
>>>>> + */
>>>>> +void amdgpu_resize_bar0(struct amdgpu_device *adev)
>>>>> +{
>>>>> +       u64 space_needed =3D roundup_pow_of_two(adev->mc.real_vram_si=
ze);
>>>>> +       u32 rbar_size =3D order_base_2(((space_needed >> 20) | 1)) -1=
;
>>>>> +       u16 cmd;
>>>>> +       int r;
>>>>> +
>>>>> +       /* Free the doorbell mapping, it most likely needs to move as
>>>>> well */
>>>>> +       amdgpu_doorbell_fini(adev);
>>>>> +       pci_release_resource(adev->pdev, 2);
>>>>> +
>>>>> +       /* Disable memory decoding while we change the BAR addresses
>>>>> and size */
>>>>> +       pci_read_config_word(adev->pdev, PCI_COMMAND, &cmd);
>>>>> +       pci_write_config_word(adev->pdev, PCI_COMMAND,
>>>>> +                             cmd & ~PCI_COMMAND_MEMORY);
>>>>> +
>>>>> +       r =3D pci_resize_resource(adev->pdev, 0, rbar_size);
>>>>> +       if (r =3D=3D -ENOSPC)
>>>>> +               DRM_INFO("Not enough PCI address space for a large
>>>>> BAR.");
>>>>> +       else if (r && r !=3D -ENOTSUPP)
>>>>> +               DRM_ERROR("Problem resizing BAR0 (%d).", r);
>>>>> +
>>>>> +       pci_write_config_word(adev->pdev, PCI_COMMAND, cmd);
>>>>> +
>>>>> +       /* When the doorbell BAR isn't available we have no chance of
>>>>> +        * using the device.
>>>>> +        */
>>>>> +       BUG_ON(amdgpu_doorbell_init(adev));
>>>>
>>>> This amdgpu_doorbell_fini()/amdgpu_doorbell_init() thing doesn't look
>>>> right.  amdgpu_device_init() only calls amdgpu_doorbell_init() for
>>>> "adev->asic_type >=3D CHIP_BONAIRE", but we call it unconditionally
>>>> here.
>>>>
>>>> This is the call graph:
>>>>
>>>>    amdgpu_device_init
>>>>      adev->rmmio_base =3D pci_resource_start(adev->pdev, 5)   # 2 for =
<
>>>> BONAIRE
>>>>      adev->rmmio =3D ioremap(adev->rmmio_base, ...)
>>>>      DRM_INFO("register mmio base: 0x%08X\n",
>>>> (uint32_t)adev->rmmio_base)
>>>>      if (adev->asic_type >=3D CHIP_BONAIRE) {
>>>>        amdgpu_doorbell_init
>>>>         adev->doorbell.base =3D pci_resource_start(adev->pdev, 2)
>>>>         adev->doorbell.ptr =3D ioremap(adev->doorbell.base, ...)
>>>>      }
>>>>      amdgpu_init
>>>>        gmc_v7_0_sw_init              # gmc_v7_0_ip_funcs.sw_init
>>>>         gmc_v7_0_mc_init
>>>>    +         amdgpu_resize_bar0
>>>>    +           amdgpu_doorbell_fini
>>>>    +           pci_release_resource(adev->pdev, 2)
>>>>    +           pci_resize_resource(adev->pdev, 0, size)
>>>>    +           amdgpu_doorbell_init
>>>>           adev->mc.aper_base =3D pci_resource_start(adev->pdev, 0)
>>>>
>>>> If "asic_type < CHIP_BONAIRE", we ioremapped BAR 2 in
>>>> amdgpu_device_init(), then we released the resource here and never
>>>> updated the ioremap.
>>>
>>> The first hardware with a resizeable BAR I could find is a Tonga,
>>> and that is even a generation later than Bonaire.
>>>
>>> So we are never going to call this code on earlier hardware generations=
.
>>
>> The problem with that is that it's impossible for a code reader to
>> verify that.  So adding a check is ugly but I think makes it more
>> readable.
>
>
> Good point. I will just move the check into the function itself, that sho=
uld
> handle all such cases.
>
>>>>  From the PCI core perspective, it would be much cleaner to do the BAR
>>>> resize before the driver calls pci_enable_device().  If that could be
>>>> done, there would be no need for this sort of shutdown/reinit stuff
>>>> and we wouldn't have to worry about issues like these.  The amdgpu
>>>> init path is pretty complicated, so I don't know whether this is
>>>> possible.
>>>
>>> I completely agree on this and it is actually the approach I tried firs=
t.
>>>
>>> There are just two problems with this approach:
>>> 1. When the amdgpu driver is loaded there can already be the VGA
>>> console, Vesa or EFI driver active for the device and displaying the
>>> splash screen.
>>>
>>> When we resize and most likely relocate the BAR while those drivers
>>> are active it will certainly cause problems.
>>>
>>> What amdgpu does before trying to resize the BAR is kicking out
>>> other driver and making sure it has exclusive access to the
>>> hardware.
>>
>> I don't understand the problem here yet.  If you need to enable the
>> device, then disable it, resize, and re-enable it, that's fine.
>
>
> The issue is we never enable the device ourself in amdgpu, except for som=
e
> rare cases during resume.
>
> In most of the cases we have to handle this is the primary display device
> which is enabled by either the BIOS, VGA console, VesaFB or EFIFB. Amdgpu
> just kicks out whatever driver was responsible for the device previously =
and
> takes over.
>
> I could of course do the disable/resize/reenable dance, but I would rathe=
r
> want to avoid that.
>
> The hardware is most likely already displaying a boot splash and we want =
to
> transit to the desktop without any flickering (at least that's the long t=
erm
> goal). Completely disabling the device to do this doesn't sounds like a g=
ood
> idea if we want that.
>
>> The important thing I'm looking for is that the resize happens before
>> a pci_enable_device(), because pci_enable_device() is the sync point
>> where the PCI core enables resources and makes them available to the
>> driver.  Drivers know that they can't look at the resources before
>> that point.  There's a little bit of text about this in [1].
>
>
> Yeah, I understand that. But wouldn't it be sufficient to just disable
> memory decoding during the resize?
>
> I can easily guarantee that the CPU isn't accessing the BAR during the ti=
me
> (we need to do this for changing the memory clocks as well), but I have a
> bad gut feeling completely turning of the device while we are still
> displaying stuff.
>
>>> 2. Without taking a look at the registers you don't know how much
>>> memory there actually is on the board.
>>>
>>> We could always resize it to the maximum supported, but that would
>>> mean we could easily waste 128GB of address space while the hardware
>>> only has 8GB of VRAM.
>>>
>>> That would not necessarily hurt us when we have enough address
>>> space, but at least kind of sucks.
>>
>> Enable, read regs, disable, kick out other drivers, resize, enable.
>> Does that solve this problem?
>
>
> Yeah, that sounds like it should do it. I will try and take a look if tha=
t
> works or not.
>
>
>>>> I would also like to simplify the driver usage model and get the
>>>> PCI_COMMAND_MEMORY twiddling into the PCI core instead of the driver.
>>>> Ideally, the driver would do something like this:
>>>>
>>>>    pci_resize_resource(adev->pdev, 0, rbar_size);
>>>>    pci_enable_device(adev->pdev);
>>>>
>>>> And the PCI core would be something along these lines:
>>>>
>>>>    int pci_resize_resource(dev, bar, size)
>>>>    {
>>>>      if (pci_is_enabled(dev))
>>>>        return -EBUSY;
>>>>
>>>>      pci_disable_decoding(dev);          # turn off MEM, IO decoding
>>>>      pci_release_resources(dev);         # (all of them)
>>>>      err =3D pci_resize_bar(dev, bar, size);     # change BAR size (on=
ly)
>>>>      if (err)
>>>>        return err;
>>>>
>>>>      pci_assign_resources(dev);          # reassign all "dev" resource=
s
>>>>      return 0;
>>>>    }
>>>
>>> I already tried the approach with releasing all resources, but it
>>> didn't worked so well.
>>>
>>> When resizing fails because we don't have enough address space then
>>> we at least want to get back to a working config.
>>>
>>> Releasing everything makes that rather tricky, since I would then
>>> need to keep a backup of the old config and try to restore it.
>>
>> If resizing fails because of lack of address space, I would expect the
>> PCI core to at least restore to the previous state.  If it doesn't, I
>> think that would be a defect.
>
>
> I completely agree, but this is unfortunately what happens.
>
> The allocation and alignment functions in the PCI core sometimes doesn't
> seem to be able to restore the old config.
>
> I mean just try pci=3Drealloc. The core sometimes doesn't seem to be able=
 to
> come up with a valid config with that.
>
>> Having the driver specify the BARs it thinks might cause issues feels
>> like a crutch.
>
> Why? The driver just releases what is necessary to move the BAR.
>
>>
>>> Additional to that I'm not sure if releasing the register BAR and
>>> relocating it works with amdgpu.
>>
>> If the BAR can't be relocated, that sounds like a hardware defect.  If
>> that's really the case, you could mark it IORESOURCE_PCI_FIXED so we
>> don't move it.  Or if it's an amdgpu defect, e.g., if amdgpu doesn't
>> re-read the resource addresses after pci_enable_device(), you should
>> fix amdgpu.
>
>
> No, the issue is not the hardware but rather the fact that the I/O BAR mi=
ght
> be used by more than one driver in the system.
>
> We also have an alsa audio driver using this to program it's DMA for HDMI=
/DP
> audio and there is also the kicked out driver which might should take ove=
r
> again if amdgpu ever unloads.

I think you'll only see this on chips with ACP (Carrizo and Stoney)
and I think the soc alsa driver gets loaded via a hotplug call from
amdgpu when it detects ACP so as long as we do the resize before
probing ACP we should be fine.  On RV, ACP moves to it's own pci
device and the HDA audio on other devices is exposed via it's own pci
device.

Alex


>
> I need to double check how those two work.
>
> Regards,
> Christian.
>
>
>>
>> [1]
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/PCI/pci.txt#n255
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
