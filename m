Return-Path: <roland.singer@desertbit.com>
Return-Path: <roland.singer@desertbit.com>
Subject: Re: Kernel Freeze with American Megatrends BIOS
To: Emil Velikov <emil.l.velikov@gmail.com>
References: <004c7dbe-2014-c691-29d1-7a45f3b73dfa@desertbit.com>
 <20160829160210.GA24451@localhost>
 <1cca943f-eab4-4054-4a13-31370d7ae057@desertbit.com>
 <20160829190737.GA4053@localhost>
 <a0079ace-3062-4792-5c33-3a5e350daac3@desertbit.com>
 <20160829235403.GA14177@localhost>
 <1d1bfdc2-f23d-9816-e4e3-ae676105dc39@desertbit.com>
 <20160830130634.GA16426@localhost>
 <CACvgo51b4XLz2PwH1dkcK4_FknfZkSUKsFepYz-AGfPr7ux2kA@mail.gmail.com>
 <735da66c-aaf3-8c27-2d59-f62e8c85d3aa@desertbit.com>
 <CACvgo51gNzECupX6R7jwQndH-1rX6MN1kPquuikzJrPk3CeZVA@mail.gmail.com>
 <43ce7a5b-8331-fec2-f598-afcb13ba3785@desertbit.com>
 <CACvgo52qA9YyaskNObO_f_gg51MqBZHN7mubshJhDUcgO8SZaQ@mail.gmail.com>
 <CACvgo51OodZGqnrBCusXGycdibR8PY4wBfUZOjEhQ=1TyPenrg@mail.gmail.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
 "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
 ML dri-devel <dri-devel@lists.freedesktop.org>, linux-acpi@vger.kernel.org,
 Ilia Mirkin <imirkin@alum.mit.edu>, peter@lekensteyn.nl
From: Roland Singer <roland.singer@desertbit.com>
Message-ID: <58415a73-5405-531e-ccd0-a413b7a8eb63@desertbit.com>
Date: Wed, 31 Aug 2016 12:51:59 +0200
MIME-Version: 1.0
In-Reply-To: <CACvgo51OodZGqnrBCusXGycdibR8PY4wBfUZOjEhQ=1TyPenrg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

Am 30.08.2016 um 20:09 schrieb Emil Velikov:
> I second Ilia here. Using bbswitch in conjunction with any driver (be
> that nouveau or the proprietary one) is a bad idea.
>

I removed bbswitch from my system and will use vgaswitcheroo to check
the GPU power state from now.

> (If Ilia's suggestions does not help) Confirm if the freeze is due
> to/as the GPU is powered on or off.
>

Yeah, the freeze is caused by the switched off GPU.
Waited for the nouveau driver to switch it off, before starting
the graphical user interface...

> Out of curiosity: how did you force X to ignore the device ?
>

I tried to tell X11 to ignore the device with the following
configuration:

  Section "Device"
      Identifier  "Nvidia"
      VendorName  "NVIDIA Corporation"
      Option      "Ignore" "true"
  EndSection

> You can check if it's the boot_vga assumption with
> cat /sys/class/drm/card*/device/{boot_vga,vendor}
> If the output changes them my assumption holds true.

Output did not change:

  1
  0x8086

0x8086 is the vendor ID of intel. So that's ok...
