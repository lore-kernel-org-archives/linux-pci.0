Return-Path: <SRS0=tsZr=BI=gmail.com=ibmirkin@kernel.org>
Return-Path: <SRS0=tsZr=BI=gmail.com=ibmirkin@kernel.org>
MIME-Version: 1.0
Sender: ibmirkin@gmail.com
From: Ilia Mirkin <imirkin@alum.mit.edu>
Date: Mon, 9 Oct 2017 10:41:38 -0400
Message-ID: <CAKb7UvjFYoZZCQ8p6gMx_7crUjEA0d29gCB8g7rJz4k=NPcDAA@mail.gmail.com>
Subject: Dynamically adding a PCI subfunction
To: Linux PCI <linux-pci@vger.kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Ben Skeggs <bskeggs@redhat.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

Hello,

As a bit of background, all NVIDIA GPUs since GT215 have an audio
subfunction for HDMI(/DP) audio to be sent to the sink. This generally
works.

However some, especially laptop, devices come up with that function
disabled. We have a quirk to enable it when coming back from runpm,
but that doesn't help the init case. Basically we have to write a bit
to the PCI config space:

https://github.com/torvalds/linux/blob/v4.12/drivers/gpu/drm/nouveau/nouveau_drm.c#L783

(MMIO 0x88000 is an alias for the PCI config space)

This works for runtime pm resume, since the device was originally
there and we just have to make sure the underlying device agrees with
it, but when it's missing on boot, we have to convince linux that it
exists, bind a driver, etc.

What's the best way of going about doing that?

Thanks,

  -ilia
