Return-Path: <emil.l.velikov@gmail.com>
Return-Path: <emil.l.velikov@gmail.com>
MIME-Version: 1.0
In-Reply-To: <43ce7a5b-8331-fec2-f598-afcb13ba3785@desertbit.com>
References: <004c7dbe-2014-c691-29d1-7a45f3b73dfa@desertbit.com>
 <20160829160210.GA24451@localhost> <1cca943f-eab4-4054-4a13-31370d7ae057@desertbit.com>
 <20160829190737.GA4053@localhost> <a0079ace-3062-4792-5c33-3a5e350daac3@desertbit.com>
 <20160829235403.GA14177@localhost> <1d1bfdc2-f23d-9816-e4e3-ae676105dc39@desertbit.com>
 <20160830130634.GA16426@localhost> <CACvgo51b4XLz2PwH1dkcK4_FknfZkSUKsFepYz-AGfPr7ux2kA@mail.gmail.com>
 <735da66c-aaf3-8c27-2d59-f62e8c85d3aa@desertbit.com> <CACvgo51gNzECupX6R7jwQndH-1rX6MN1kPquuikzJrPk3CeZVA@mail.gmail.com>
 <43ce7a5b-8331-fec2-f598-afcb13ba3785@desertbit.com>
From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Tue, 30 Aug 2016 19:09:11 +0100
Message-ID: <CACvgo52qA9YyaskNObO_f_gg51MqBZHN7mubshJhDUcgO8SZaQ@mail.gmail.com>
Subject: Re: Kernel Freeze with American Megatrends BIOS
To: Roland Singer <roland.singer@desertbit.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	"Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
	ML dri-devel <dri-devel@lists.freedesktop.org>, linux-acpi@vger.kernel.org,
	Ilia Mirkin <imirkin@alum.mit.edu>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On 30 August 2016 at 18:37, Roland Singer <roland.singer@desertbit.com> wrote:
> I am running 4.7.2, but I also just tried the 4.8.0-rc4 mainline kernel.
> The result is the same. There is no difference if bbswitch of acpi_call
> is used. However I noticed following:
>
> 1. The nouveau driver is broken in both kernel version and is responsible
>    for the freezes while gathering power state information with bbswitch.
>    Sometimes while shutting the system down, everything except the LCD
>    screen is switched off. This only happens with nouveau.
>    I noticed following error log messages:
>
I second Ilia here. Using bbswitch in conjunction with any driver (be
that nouveau or the proprietary one) is a bad idea.

>    kernel: nouveau 0000:01:00.0: fb: 6144 MiB GDDR5
>    kernel: nouveau 0000:01:00.0: priv: HUB0: 10ecc0 ffffffff (1e40822c)
>    kernel: nouveau 0000:01:00.0: DRM: VRAM: 6144 MiB
>    kernel: nouveau 0000:01:00.0: DRM: GART: 1048576 MiB
>    kernel: nouveau 0000:01:00.0: DRM: Pointer to TMDS table invalid
>    kernel: nouveau 0000:01:00.0: DRM: DCB version 4.1
>    kernel: nouveau 0000:01:00.0: DRM: Pointer to flat panel table invalid
>
> 2. -> Boot with nouveau module loaded
>    -> switch off the discrete GPU with bbswitch or acpi_call
>    -> start X11
>    -> obtaining power state with bbswitch freezes the system
>    -> or working with the system for some minutes freezes the system
>
(If Ilia's suggestions does not help) Confirm if the freeze is due
to/as the GPU is powered on or off.

> 3. -> Boot with nouveau module blacklisted
>    -> switch off the discrete GPU
>    -> start X11
>    -> system immediately freezes
>
It's perfectly possible that the discrete GPU is set as boot one and X
goes angry since there's no driver/way to bring it up.

> 4. -> Boot with nouveau module blacklisted
>    -> switch off the discrete GPU
>    -> start Wayland
>    -> system runs - Note: I tried this for couple of days with 4.6 and 4.7 mainline
>                           and the system freezed randomly after some time.
>                           However I have to test if this is still present with 4.7.2
>                           and 4.8 mainline. Right now it seams to be fine.
>    -> running Xwayland (does not depend on the GPU power state) kills performance!
>       the system freezes for several seconds...
>       So working with Wayland is also no solution.
>
> My conclusion:
>
> 1. Nouveau has couple of problems with GTX 9** M Nvidia GPUs.
>    I would love to help here.
>
> 2. X11 is just broken and is not capable to start the graphical session
>    if the nvidia GPU is not handled by any video driver (kernel module).
>    Even forcing X11 to ignore the discrete GPU doesn't help.
>
Out of curiosity: how did you force X to ignore the device ?

>    Setting the command line arguments to:
>
>      acpi_osi=! acpi_osi="Windows 2009"
>
>    fixes the issues with X11 but other things break...
>    What the hell is going on?! :/
>
You can check if it's the boot_vga assumption with

Check wh

You're a victum of the Windows specific fun (quirks?) in

> Am 30.08.2016 um 17:48 schrieb Emil Velikov:
>> On 30 August 2016 at 16:25, Roland Singer <roland.singer@desertbit.com> wrote:
>>> I tried these scenarios:
>>>
>>> 1. Booted the system without the bbswitch module. The nouveau module
>>>    was loaded and is responsible for the power management of the GPU.
>>>    The graphical session freezes after some minutes...
>>>
>>> 2. Booted the system without bbswitch and with nouveau blacklisted.
>>>    Manually loaded bbswitch to switch off the discrete GPU.
>>>    Same freeze after a while or by explicitly obtaining the GPU state.
>>>
>>> Is there a possibility to switch off the discrete card without bbswitch?
>>> If this is possible, then I could test this without nouveau and bbswitch
>>> at all. If the system hangs, then it is not the video driver nor bbswitch.
>>>
>> As Ilia mentioned acpi_call should do it. You can also check with the
>> nouveau/bbwswitch code to see which ones they use in your case and
>> bash it manually. It might be that the 'wrong one' gets used thus
>> things going horribly wrong.
>>
>> Regards,
>> Emil
>>
>
