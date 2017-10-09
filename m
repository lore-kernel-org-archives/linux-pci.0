Return-Path: <SRS0=tsZr=BI=gmail.com=ibmirkin@kernel.org>
Return-Path: <SRS0=tsZr=BI=gmail.com=ibmirkin@kernel.org>
MIME-Version: 1.0
Sender: ibmirkin@gmail.com
In-Reply-To: <246df1d8-cb6c-518d-7ca1-7a389ca8ef21@gmail.com>
References: <CAKb7UvjFYoZZCQ8p6gMx_7crUjEA0d29gCB8g7rJz4k=NPcDAA@mail.gmail.com>
 <246df1d8-cb6c-518d-7ca1-7a389ca8ef21@gmail.com>
From: Ilia Mirkin <imirkin@alum.mit.edu>
Date: Mon, 9 Oct 2017 11:57:52 -0400
Message-ID: <CAKb7Uviesg2=b4AKFjoz1yEGSqE1EAjdq=VMo9Z-cJ1x1tGKVg@mail.gmail.com>
Subject: Re: Dynamically adding a PCI subfunction
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
	Ben Skeggs <bskeggs@redhat.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 9, 2017 at 11:45 AM, Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
> Am 09.10.2017 um 16:41 schrieb Ilia Mirkin:
>>
>> Hello,
>>
>> As a bit of background, all NVIDIA GPUs since GT215 have an audio
>> subfunction for HDMI(/DP) audio to be sent to the sink. This generally
>> works.
>>
>> However some, especially laptop, devices come up with that function
>> disabled. We have a quirk to enable it when coming back from runpm,
>> but that doesn't help the init case. Basically we have to write a bit
>> to the PCI config space:
>>
>>
>> https://github.com/torvalds/linux/blob/v4.12/drivers/gpu/drm/nouveau/nou=
veau_drm.c#L783
>>
>> (MMIO 0x88000 is an alias for the PCI config space)
>>
>> This works for runtime pm resume, since the device was originally
>> there and we just have to make sure the underlying device agrees with
>> it, but when it's missing on boot, we have to convince linux that it
>> exists, bind a driver, etc.
>>
>> What's the best way of going about doing that?
>
>
> Sounds similar to my work about resizing BARs.
>
> I would just try to enable the device and then trigger a rescan of the BU=
S
> where it is attached (similar to echo 1 >
> /sys/bus/pci/devices/$pci_id_of_your_bus/rescan).
>
> There is certainly a function in the PCI subsystem you just need to call =
for
> that.

I'm not exactly familiar with the pci subsystem. I know that hotplug
is a thing, at least in theory. I figured it'd be something related to
that, since this is in essence a random device appearing on the bus
after the initial scan. Is a bus rescan safe on a fully initialized
system?

Either way, some specific functions to call or look at would be great.

Cheers,

  -ilia
