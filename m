Return-Path: <SRS0=wdCK=BI=gmail.com=ckoenig.leichtzumerken@kernel.org>
Return-Path: <SRS0=wdCK=BI=gmail.com=ckoenig.leichtzumerken@kernel.org>
Reply-To: christian.koenig@amd.com
Subject: Re: Dynamically adding a PCI subfunction
To: Ilia Mirkin <imirkin@alum.mit.edu>, Linux PCI <linux-pci@vger.kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Ben Skeggs <bskeggs@redhat.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
References: <CAKb7UvjFYoZZCQ8p6gMx_7crUjEA0d29gCB8g7rJz4k=NPcDAA@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <246df1d8-cb6c-518d-7ca1-7a389ca8ef21@gmail.com>
Date: Mon, 9 Oct 2017 17:45:32 +0200
MIME-Version: 1.0
In-Reply-To: <CAKb7UvjFYoZZCQ8p6gMx_7crUjEA0d29gCB8g7rJz4k=NPcDAA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Am 09.10.2017 um 16:41 schrieb Ilia Mirkin:
> Hello,
>
> As a bit of background, all NVIDIA GPUs since GT215 have an audio
> subfunction for HDMI(/DP) audio to be sent to the sink. This generally
> works.
>
> However some, especially laptop, devices come up with that function
> disabled. We have a quirk to enable it when coming back from runpm,
> but that doesn't help the init case. Basically we have to write a bit
> to the PCI config space:
>
> https://github.com/torvalds/linux/blob/v4.12/drivers/gpu/drm/nouveau/nouveau_drm.c#L783
>
> (MMIO 0x88000 is an alias for the PCI config space)
>
> This works for runtime pm resume, since the device was originally
> there and we just have to make sure the underlying device agrees with
> it, but when it's missing on boot, we have to convince linux that it
> exists, bind a driver, etc.
>
> What's the best way of going about doing that?

Sounds similar to my work about resizing BARs.

I would just try to enable the device and then trigger a rescan of the 
BUS where it is attached (similar to echo 1 > 
/sys/bus/pci/devices/$pci_id_of_your_bus/rescan).

There is certainly a function in the PCI subsystem you just need to call 
for that.

Regards,
Christian.

>
> Thanks,
>
>    -ilia
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
